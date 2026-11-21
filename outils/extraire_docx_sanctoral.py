"""Images des carnets du sanctoral (.docx exportés de Pages) → partitions/op/

    python3 outils/extraire_docx_sanctoral.py "<dossier des carnets>" [--liste]
    python3 outils/extraire_docx_sanctoral.py "<dossier des carnets>" --sept-jan [--liste]

Avec --sept-jan : toutes les fêtes du carnet « septembre-janvier » (le PDF de 2024 est périmé) et ses annexes
→ partitions/sj/<clé>-<n>.jpg (clés MM-JJ, christ-roi, _annexes) ; ce que chaque image est : outils/ordo_sept_jan.py.

Les .docx « Sanctoral-sept-jan.docx » et « Sanctoral-Fév-Août.docx » (exportés de Pages le 20/11/2026)
contiennent chaque partition comme image séparée, dans l'ordre du carnet, avec ses étiquettes
(« Psaume 62 & AT 49 », « Répons p. 62 »…). Le PDF « sept-jan » de 2024 est, lui, en retard sur le carnet
(pages décalées : le 28 janvier, la page des vêpres montrait la fin de l'hymne).

Ce programme découpe, pour les fêtes listées dans FETES (propre de l'Ordre et pages auxquelles il renvoie),
la suite des images et des textes, recadre chaque image comme dans le carnet (srcRect), la réduit à
900 px de large et l'écrit dans partitions/op/<clé>-<n>.jpg. Avec --liste : la suite, pour relecture.
Ce que chaque image est (hymne, antienne de tel psaume, répons…) est fixé à la main dans
outils/offices_op.py (vérifié à l'œil, image par image).
"""
from __future__ import annotations
import re
import subprocess
import sys
import tempfile
import zipfile
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
SORTIE = RACINE / "partitions" / "op"
LARGEUR = 900
CARNETS = {"sanctoral1": "Sanctoral-sept-jan.docx", "sanctoral2": "Sanctoral-Fév-Août.docx"}
# clé → (carnet, titre de date qui ouvre la fête dans le carnet)
FETES = {
    "09-28": ("sanctoral1", "28 septembre"),
    "10-04": ("sanctoral1", "4 octobre"),
    "10-07": ("sanctoral1", "7 octobre"),
    "11-01": ("sanctoral1", "1er novembre"),     # Toussaint : le 7 novembre y renvoie (hymnes, psalmodie des laudes)
    "11-02": ("sanctoral1", "2 novembre"),       # défunts : le 8 novembre y renvoie
    "11-03": ("sanctoral1", "3 novembre"),
    "11-07": ("sanctoral1", "7 novembre"),
    "11-15": ("sanctoral1", "15 novembre"),
    "01-28": ("sanctoral1", "28 janvier"),
    "04-29": ("sanctoral2", "29 avril"),
    "05-24": ("sanctoral2", "24 mai"),
    "08-08": ("sanctoral2", "8 août"),
    "08-28": ("sanctoral2", "28 août"),
}
DATE = re.compile(r"^(1er|1°|\d{1,2}) (janvier|février|fevrier|mars|avril|mai|juin|juillet|août|aout|septembre|octobre|novembre|décembre)\s*$", re.I)


def suite(docx: Path):
    """[(type, valeur)] : ("T", texte) / ("IMG", (média, recadrage l,t,r,b en 1/1000 %)) / ("PAGE", n)."""
    with zipfile.ZipFile(docx) as z:
        x = z.read("word/document.xml").decode()
        rels = dict(re.findall(r'Id="(rId\d+)"[^>]*Target="([^"]+)"', z.read("word/_rels/document.xml.rels").decode()))
    out, page = [], 1
    for m in re.finditer(r"<w:p[ >].*?</w:p>", x, re.S):
        texte = ""
        for part in re.split(r'(<w:drawing.*?</w:drawing>|<w:br w:type="page"/>|<w:t[^>]*>[^<]*</w:t>)', m.group(0), flags=re.S):
            if part.startswith("<w:br"):
                page += 1; out.append(("PAGE", page))
            elif part.startswith("<w:drawing"):
                e = re.search(r'r:embed="(rId\d+)"', part)
                sr = re.search(r"<a:srcRect([^/]*)/>", part)
                c = tuple(int(v) for v in re.findall(r'[ltrb]="(-?\d+)"', sr.group(1))) if sr else ()
                if e: out.append(("IMG", (rels[e.group(1)], c if len(c) == 4 else (0, 0, 0, 0))))
            elif part.startswith("<w:t"):
                texte += re.sub(r"<[^>]+>", "", part).replace("&amp;", "&").replace("&apos;", "'").replace("&quot;", '"')
        if texte.strip(): out.append(("T", texte.strip()))
    return out


def suite_complete(docx: Path):
    """Comme suite(), mais lit aussi les images posées dans des cadres de texte (paragraphes imbriqués, que la lecture
    par paragraphe perdait : 7 images du carnet septembre-janvier, dont « Venez à moi » de saint Matthieu)."""
    with zipfile.ZipFile(docx) as z:
        x = z.read("word/document.xml").decode()
        rels = dict(re.findall(r'Id="(rId\d+)"[^>]*Target="([^"]+)"', z.read("word/_rels/document.xml.rels").decode()))
    out, page, texte = [], 1, ""
    for m in re.finditer(r'<pic:pic\b.*?</pic:pic>|<w:br w:type="page"/>|<w:t[ >][^<]*</w:t>|<w:t/>|</w:p>', x, re.S):
        part = m.group(0)
        if part.startswith("<pic:pic"):
            e = re.search(r'r:embed="(rId\d+)"', part)
            sr = re.search(r"<a:srcRect([^/]*)/>", part)
            c = tuple(int(v) for v in re.findall(r'[ltrb]="(-?\d+)"', sr.group(1))) if sr else ()
            if e: out.append(("IMG", (rels[e.group(1)], c if len(c) == 4 else (0, 0, 0, 0))))
        elif part.startswith("<w:br"):
            page += 1; out.append(("PAGE", page))
        elif part == "</w:p>":
            if texte.strip(): out.append(("T", texte.strip()))
            texte = ""
        else:
            texte += re.sub(r"<[^>]+>", "", part).replace("&amp;", "&").replace("&apos;", "'").replace("&quot;", '"')
    return out


def segments(sq, cles):
    """{clé: [éléments]} de la date de la fête à la date suivante (ou aux annexes)."""
    res, cur = {}, None
    for t, v in sq:
        if t == "T" and (DATE.match(v) or v.upper().startswith("ANNEXES") or v.startswith("Sommaire")):
            cur = None
            for k, (_, titre) in cles.items():
                if v.lower().startswith(titre.lower()) and k not in res: cur = k; res[k] = []
            continue
        if cur: res[cur].append((t, v))
    return res


MOIS = {"janvier": 1, "février": 2, "fevrier": 2, "mars": 3, "avril": 4, "mai": 5, "juin": 6, "juillet": 7, "août": 8, "aout": 8,
        "septembre": 9, "octobre": 10, "novembre": 11, "décembre": 12}
NOEL = {"12-26", "12-27", "12-28", "01-01"}   # renvois au livret de Noël


def segments_tout(sq):
    """Toutes les fêtes d'un carnet : {clé: [éléments]} ; « 34e Dimanche… » = christ-roi ; annexes = _annexes."""
    res, cur = {}, None
    for t, v in sq:
        if t == "T":
            m = re.match(r"^(1er|1°|\d{1,2}) (\w+)\s*$", v.strip())
            if m and m.group(2).lower() in MOIS:
                k = f"{MOIS[m.group(2).lower()]:02d}-{1 if not m.group(1).isdigit() else int(m.group(1)):02d}"
                cur = None if k in NOEL or k in res else k
                if cur: res[cur] = []
                continue
            if "Dimanche du Temps ordinaire" in v and "christ-roi" not in res: cur = "christ-roi"; res[cur] = []; continue
            if v.startswith("La Sainte Famille"): cur = None; continue
            if v.upper().startswith("ANNEXES") and "_annexes" not in res: cur = "_annexes"; res[cur] = []; continue
            if v.startswith("Sommaire"): cur = None; continue
        if cur: res[cur].append((t, v))
    return res


def recadrer(z: zipfile.ZipFile, media: str, crop, dest: Path):
    with tempfile.TemporaryDirectory() as d:
        src = Path(d) / Path(media).name
        try: donnees = z.read("word/" + media)
        except zipfile.BadZipFile:            # somme de contrôle fausse dans l'archive (image208 du carnet sept-jan) : lue quand même
            with z.open("word/" + media) as fz:
                fz._expected_crc = None
                donnees = fz.read()
            print(f"  (attention : {media} abîmée dans le .docx, lue sans contrôle)")
        src.write_bytes(donnees)
        w, h = (int(v) for v in re.findall(r"pixel(?:Width|Height): (\d+)", subprocess.run(["sips", "-g", "pixelWidth", "-g", "pixelHeight", str(src)], capture_output=True, text=True).stdout))
        l, t, r, b = (max(0, v) / 100000 for v in crop)
        cw, ch = round(w * (1 - l - r)), round(h * (1 - t - b))
        if (l, t, r, b) != (0, 0, 0, 0):
            # (sips recadre au centre si le décalage vaut 0 : au moins 1 pixel)
            subprocess.run(["sips", "-c", str(ch), str(cw), "--cropOffset", str(max(1, round(h * t))), str(max(1, round(w * l))), str(src)], capture_output=True)
        subprocess.run(["sips", "-s", "format", "jpeg", "-s", "formatOptions", "72", "-Z", str(LARGEUR) if cw >= ch else str(round(LARGEUR * ch / max(cw, 1))), str(src), "--out", str(dest)], capture_output=True)


def main():
    dossier = Path(sys.argv[1])
    liste = "--liste" in sys.argv
    if "--sept-jan" in sys.argv:
        sortie = RACINE / "partitions" / "sj"
        sortie.mkdir(parents=True, exist_ok=True)
        docx = dossier / CARNETS["sanctoral1"]
        with zipfile.ZipFile(docx) as z:
            for k, els in segments_tout(suite_complete(docx)).items():
                n = 0
                print(f"== {k}")
                for t, v in els:
                    if t == "IMG":
                        n += 1
                        if not liste: recadrer(z, v[0], v[1], sortie / f"{k}-{n:02d}.jpg")
                        print(f"  [{n:02d}] {v[0]} {v[1] if any(v[1]) else ''}")
                    elif t == "T": print(f"       « {v} »")
                    elif t == "PAGE": print("  ---")
        return
    SORTIE.mkdir(parents=True, exist_ok=True)
    for carnet, nom in CARNETS.items():
        cles = {k: v for k, v in FETES.items() if v[0] == carnet}
        docx = dossier / nom
        seg = segments(suite(docx), cles)
        with zipfile.ZipFile(docx) as z:
            for k, els in seg.items():
                n = 0
                print(f"== {k} ({nom})")
                for t, v in els:
                    if t == "IMG":
                        n += 1
                        dest = SORTIE / f"{k}-{n:02d}.jpg"
                        if not liste: recadrer(z, v[0], v[1], dest)
                        print(f"  [{n:02d}] {v[0]} {v[1] if any(v[1]) else ''}")
                    elif t == "T": print(f"       « {v} »")
                    elif t == "PAGE": print("  ---")


if __name__ == "__main__":
    main()
