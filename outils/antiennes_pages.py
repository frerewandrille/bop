#!/usr/bin/env python3
"""Antiennes découpées selon la règle de l'utilisateur (17/11/2026).

Pages d'antiennes reconnues à leur titre « jour + semaine » (« Laudes - Mardi I », « Vigiles - Dimanches II & VI »).
De haut en bas : 1re antienne = sous le titre, au-dessus de la 1re étiquette des psaumes (« Psaume 23 & AT 6 ») ;
2e antienne = sous la 1re étiquette, au-dessus de la 2e ; etc. Les étiquettes elles-mêmes ne sont pas reprises.

Sortie : partitions/<carnet>/a-NNN-i.jpg et partitions/decoupes.json :
  "pages"    : {carnet: {page: [pièces]}} — remplace, pour ces pages, la liste de pieces.json (une pièce par antienne,
               avec les psaumes de son étiquette et les cotes lues dans sa zone ; les pièces sous la dernière étiquette restent) ;
  "fichiers" : {"<carnet>/s-NNN-k.jpg": ["<carnet>/a-NNN-i.jpg", …]} — pour les renvois directs (ordo, corrections).

    python3 outils/antiennes_pages.py ["<dossier des carnets>"]
"""
import html, json, re, subprocess, sys
from collections import defaultdict
from pathlib import Path

ICI = Path(__file__).resolve().parent
sys.path.insert(0, str(ICI))
from decouper_partitions import ids_etiquette
COTES = ("K", "L", "F", "G", "H", "M", "N", "P", "Q", "U", "V", "W", "X", "Y", "Z", "KL")
RACINE = ICI.parent / "partitions"
DOSSIER = Path(sys.argv[1]) if len(sys.argv) > 1 else Path(
    "/Users/frerewandrille/Library/CloudStorage/GoogleDrive-wandrille.givelet@praedicatio.onmicrosoft.com/"
    "Drive partagés/LITURGIE/LITURGIE/02-Liturgie-des-Heures/Carnets PERDRIX")
CARNETS = {"to": "Temps ordinaire-MàJ juillet 2018.pdf", "avent": "Livret-Avent-2019.pdf", "noel": "livret du temps de Noël.pdf",
           "careme": "Livret de Careme 3.0 ODENDALL DBJL.pdf", "paques": "Livret Temps Pascal-final.pdf",
           "sanctoral1": "Sanctoral-sept-jan.pdf", "sanctoral2": "Sanctoral-Fév-Août.pdf"}
DPI = 110
JOUR_SEMAINE = re.compile(r"\b(Lundi|Mardi|Mercredi|Jeudi|Vendredi|Samedi|Dimanches?)\s+(?:I|II|III|IV|V|VI|VII|VIII)\b(?!\w)")
ETIQUETTE = re.compile(r"^(Psaumes?|Ps\.?|Cantique|AT|NT)\b")


def lignes_pdf(pdf):
    """{page: [(y0, y1, x0, texte)]} en pixels à DPI, une entrée par ligne de texte."""
    t = subprocess.run(["pdftotext", "-bbox", str(pdf), "-"], capture_output=True, text=True).stdout
    k, p, mots = DPI / 72, 0, defaultdict(list)
    for l in t.split("\n"):
        if "<page " in l:
            p += 1
        m = re.search(r'xMin="([\d.]+)" yMin="([\d.]+)" xMax="([\d.]+)" yMax="([\d.]+)">(.*)</word>', l)
        if m and p:
            x0, y0, x1, y1 = (float(m.group(i)) * k for i in range(1, 5))
            mots[p].append((y0, y1, x0, m.group(5)))
    out = {}
    for p, ms in mots.items():
        ms.sort()
        lignes = []
        for y0, y1, x0, w in ms:
            if lignes and abs((y0 + y1) / 2 - (lignes[-1][0] + lignes[-1][1]) / 2) < 6:
                a = lignes[-1]; lignes[-1] = (min(a[0], y0), max(a[1], y1), min(a[2], x0), a[3] + [(x0, w)])
            else:
                lignes.append((y0, y1, x0, [(x0, w)]))
        out[p] = [(a, b, c, html.unescape(" ".join(w for _, w in sorted(ws)))) for a, b, c, ws in lignes]
    return out


def taille(img):
    o = subprocess.run(["sips", "-g", "pixelWidth", "-g", "pixelHeight", str(img)], capture_output=True, text=True).stdout
    return int(o.split("pixelWidth:")[1].split()[0]), int(o.split("pixelHeight:")[1].split()[0])


def main():
    index = json.loads((RACINE / "index.json").read_text())
    titres = defaultdict(list)
    for e in index["pages"]:
        titres[(e["carnet"], e["page"])].append(e.get("titre") or "")
    decoupes, rapport, pages_out = {}, [], {}
    for code, nom in CARNETS.items():
        pdf = DOSSIER / nom
        if not pdf.exists():
            print(f"{code} : PDF introuvable ({pdf})"); continue
        for f in (RACINE / code).glob("a-*.jpg"):     # anciennes coupes de CE carnet seulement (Marseille a ses propres a-…)
            f.unlink()
        lignes = lignes_pdf(pdf)
        pieces = defaultdict(list)
        for x in json.loads((RACINE / code / "pieces.json").read_text()):
            pieces[x["page"]].append(x)
        n_pages = 0
        for page, ls in sorted(lignes.items()):
            haut = [l for l in ls if l[1] < 62]
            titre = " ".join(l[3] for l in haut) + " " + " ".join(titres.get((code, page), []))
            if not JOUR_SEMAINE.search(titre) or not pieces.get(page):
                continue
            etiq = []
            for l in ls:
                if l[1] < 62: continue
                if ETIQUETTE.match(l[3]) and l[2] < 300: etiq.append(list(l))
                elif etiq and l[3].startswith("&") and -12 <= l[0] - etiq[-1][1] < 30 and l[2] < 300:
                    etiq[-1][1] = l[1]; etiq[-1][3] += " " + l[3]          # étiquette sur deux lignes
            if not etiq:
                continue
            src = RACINE / code / f"p-{page:03d}.jpg"
            W, H = taille(src)
            bas_titre = max((l[1] for l in haut), default=40)
            zones, debut = [], bas_titre + 6
            for l in etiq:
                zones.append((debut, l[0] - 9, html.unescape(l[3]))); debut = l[1] + 6
            ps = pieces[page]
            g = max(0, min(x["x0"] for x in ps) - 22); d = min(W, max(x["x1"] for x in ps) + 22)
            nouvelles, n_pages = [], n_pages + 1
            for i, (a, b, lib) in enumerate(zones, 1):
                if b - a < 40: continue
                f = f"a-{page:03d}-{i}.jpg"
                subprocess.run(["sips", "-c", str(int(b - a)), str(int(d - g)), "--cropOffset", str(int(a)), str(int(g)), str(src),
                                "--out", str(RACINE / code / f)], capture_output=True, check=True)
                zone = " ".join(l[3] for l in ls if a <= (l[0] + l[1]) / 2 <= b)
                cotes = [f"{c} {n}" for c, n in dict.fromkeys(re.findall(r"\b([A-Z]{1,2}) ?(\d{3}[a-z]?)\b", zone)) if c in COTES]
                nouvelles.append({"page": page, "n": i, "fichier": f, "y0": int(a), "y1": int(b), "x0": int(g), "x1": int(d),
                                  "dessus": "", "dessous": lib, "dedans": zone[:300], "cotes": cotes, "ids": ids_etiquette(lib), "nature": "musique"})
                for x in ps:
                    if min(b, x["y1"]) - max(a, x["y0"]) > 0.25 * min(x["y1"] - x["y0"], b - a):
                        decoupes.setdefault(f"{code}/{x['fichier']}", []).append(f"{code}/{f}")
            # pièces sous la dernière étiquette (antienne évangélique…) : gardées telles quelles
            fin = etiq[-1][1]
            reste = [x for x in ps if x["y0"] >= fin - 5 and f"{code}/{x['fichier']}" not in decoupes]
            pages_out.setdefault(code, {})[str(page)] = nouvelles + [{**x, "n": 100 + x["n"]} for x in reste]
        print(f"{code} : {n_pages} page(s) d'antiennes découpée(s)")
    (RACINE / "decoupes.json").write_text(json.dumps({"pages": pages_out, "fichiers": dict(sorted(decoupes.items()))}, ensure_ascii=False, indent=0))
    print(f"{len(decoupes)} pièce(s) rattachée(s) → partitions/decoupes.json")
    for r in rapport: print("  ", r)


if __name__ == "__main__":
    main()
