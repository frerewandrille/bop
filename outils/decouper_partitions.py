"""Découpe les carnets de chant en pièces (une partition = une image), pour les placer
sous leur texte dans l'office.

    python3 outils/decouper_partitions.py <code> "<carnet.pdf>" [<code> "<carnet.pdf>" …]

Pour chaque page : rendu en niveaux de gris (110 dpi), repérage des portées (lignes noires
longues), regroupement en pièces séparées par des blancs ou des intertitres, puis
recadrage de l'image de la page (partitions/<code>/p-NNN.jpg, déjà rendue) avec sips.
Les mots du PDF (pdftotext -bbox) donnent l'intertitre au-dessus d'une pièce
(« Samedis du temps ordinaire : »), l'étiquette au-dessous (« Psaume 41 & AT 15 ») et les cotes
(« K 312 ») qu'elle contient.

Sortie : partitions/<code>/s-NNN-K.jpg et partitions/<code>/pieces.json
  [{page, n, fichier, y0, y1, x0, x1, dessus, dessous, dedans, cotes, ids}]
"""
from __future__ import annotations
import html
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ICI = Path(__file__).resolve().parent
RACINE = ICI.parent
DPI = 110
SOMBRE = bytes(1 if i < 170 else 0 for i in range(256))


def mots_pdf(pdf: Path):
    """{page: [(x0, y0, x1, y1, mot)]} en pixels à DPI."""
    t = subprocess.run(["pdftotext", "-bbox", str(pdf), "-"], capture_output=True, text=True).stdout
    pages, p, k = {}, 0, DPI / 72
    for l in t.split("\n"):
        if "<page " in l:
            p += 1; pages[p] = []
        m = re.search(r'xMin="([\d.]+)" yMin="([\d.]+)" xMax="([\d.]+)" yMax="([\d.]+)">(.*)</word>', l)
        if m and p:
            x0, y0, x1, y1 = (float(m.group(i)) * k for i in range(1, 5))
            pages[p].append((x0, y0, x1, y1, html.unescape(m.group(5))))
    return pages


def lire_pgm(f: Path):
    d = f.read_bytes()
    m = re.match(rb"P5\s+(?:#.*\s+)*(\d+)\s+(\d+)\s+(\d+)\s", d)
    w, h = int(m.group(1)), int(m.group(2))
    return w, h, d[m.end():m.end() + w * h]


def texte_zone(mots, y0, y1, x0=0, x1=1e9):
    ls = [m for m in mots if y0 - 1 <= (m[1] + m[3]) / 2 <= y1 + 1 and m[0] >= x0 - 2 and m[2] <= x1 + 2]
    ls.sort(key=lambda m: (round(m[1] / 6), m[0]))
    return " ".join(m[4] for m in ls).strip()


VECTORIELS = {"complies", "hg1", "hg2", "hg3"}   # livrets imprimés (portées nettes) : détection stricte


def analyser_page(w, h, px, mots, haut_titre=0.075, bas_num=0.94, strict=False, gregorien=False):
    """Renvoie les pièces : [(y0, y1, x0, x1)] en pixels."""
    lignes = [px[y * w:(y + 1) * w].translate(SOMBRE) for y in range(h)]
    encre = [l.count(1) for l in lignes]
    long_portee = b"\x01" * int(w * 0.28)
    # ligne de portée : un long trait noir, ou une ligne très encrée (portées scannées, grises ou tremblées)
    clair = [px[y * w:(y + 1) * w].translate(bytes(1 if i < 215 else 0 for i in range(256))) for y in range(h)]
    portee = [long_portee in l or (not strict and c.count(1) > w * 0.36) for l, c in zip(lignes, clair)]
    y_min, y_max = int(h * haut_titre), int(h * bas_num)
    # bandes d'encre (lignes non blanches), fusion des trous < 3 px
    bandes, debut, blanc = [], None, 0
    for y in range(y_min, y_max):
        if encre[y] > 1:
            if debut is None: debut = y
            blanc = 0
        elif debut is not None:
            blanc += 1
            if blanc >= 3:
                bandes.append([debut, y - blanc]); debut, blanc = None, 0
    if debut is not None: bandes.append([debut, y_max - 1])
    bandes = [b for b in bandes if b[1] - b[0] >= 2]
    if gregorien:
        # intertitre (« Preces », « Oratio »…) collé sous la dernière ligne de paroles : on coupe la bande au-dessus
        TETE = re.compile(r"^(Preces|Oratio|Lectio|Capitulum|Benedicamus|Conclusio|HYMNUS|Hymnus|Psalmus|Canticum)$")
        for m in sorted(mm for mm in mots if TETE.match(mm[4])):
            yt = int(m[1]) - 7
            for k, b in enumerate(bandes):
                if b[0] + 8 < yt <= b[1]:
                    bandes[k:k + 1] = [[b[0], yt - 1], [yt, b[1]]]
                    break
    for b in bandes:
        b.append(any(portee[b[0]:b[1] + 1]))        # bande musicale ?
        b.append(texte_zone(mots, b[0], b[1]))       # mots du PDF dans la bande
        # texte collé au-dessus de la première portée (intertitre, « Hymnus », « Ant. »…)
        fs = next((y for y in range(b[0], b[1] + 1) if portee[y]), b[0]) if b[2] else b[0]
        dessus = texte_zone(mots, b[0], fs - 12) if b[2] else ""
        b.append(dessus)
    TITRE = re.compile(r"^(Introduction|R[ée]pons|Cantique|Hymne|Pri[èe]re|B[ée]n[ée]diction|Antienne|Psaume|Ps\b|Invitatoire|Benedictus|Magnificat|Salve|O lumen|O spem|Ou bien|Avant|Apr[èe]s|Aux|Au |En |Du |De l|Le |La |Les |Jusqu|Entre|Dimanche|Sp[ée]cialement|Temps|Pr[ée]sentation|Annonciation|Solennit)")
    ETIQ = re.compile(r"^(Hymnus|Resp\.?|Ant\.?|Cant\.?|V|[IV]+[a-g]?|[IV]+ ?[A-G]|H\.? ?[IV]+|D|\*)$")
    # pièces : suites de bandes musicales, avec les bandes de paroles intercalées
    pieces, cur = [], None
    for i, (y0, y1, mus, txt, au_dessus) in enumerate(bandes):
        if mus:
            t = " ".join(m for m in au_dessus.split() if not ETIQ.match(m)).strip()
            paroles = bool(re.search(r"\w-\w|^\d+\.", t))       # syllabes coupées ou strophe numérotée : des paroles
            intertitre = bool(t) and not paroles and (t.endswith(":") or bool(TITRE.match(t)) or (t.upper() == t and len(t) > 4)
                                                      or (gregorien and bool(re.search(r"(^Ad (Benedictus|Magnificat|Nunc)|ant\.( ?\d\.?)?$|^Resp|^R/|br\.$)", t))))
            if cur and (y0 - cur[1] > 70 or intertitre):   # grand blanc ou intertitre : nouvelle pièce
                pieces.append(cur); cur = None
            if cur is None:
                cur = [y0, y1, i, i]
                # intonation courte (« En paix, prions le Seigneur ») : portée trop courte pour être reconnue,
                # image sans mot du PDF collée juste au-dessus de la pièce → on la rattache
                pb = bandes[i - 1] if i else None
                if pb and not pb[2] and not pb[3] and y0 - pb[1] < 15 and pb[1] - pb[0] > 30 and (not pieces or pieces[-1][1] < pb[0]):
                    cur[0] = pb[0]
            else: cur[1], cur[3] = y1, i
            # étiquette « Psaume … » à côté du ton de la psalmodie : fin de la pièce
            if not strict and re.search(r"(^|\s)(Psaumes?|Ps\.?|Cantique|AT|NT)\s+[\dIVX]", txt or ""):
                cur.append(re.search(r"(Psaumes?|Ps\.?|Cantique|AT|NT)\s+[\dIVX].*", txt).group(0))
                pieces.append(cur); cur = None
        elif cur is not None:
            # paroles : une seule ligne collée sous une portée, ou de l'encre sans mot du PDF (image)
            colle = y0 - cur[1] < 40 and (y1 - y0) < 45
            sous_portee = bandes[i - 1][2]
            intertitre = txt and not re.search(r"\w-\w|^\d+\.", txt) and (txt.rstrip().endswith(":") or re.match(r"^(Psaume|Ps\b|Cantique|Ant\.|R[ée]pons|Benedictus|Magnificat|Hymne|Invitatoire)", txt))
            if gregorien and txt and re.match(r"^(Preces|Oratio|Lectio|Capitulum|Benedicamus|Conclusio|Ad (Laudes|Vesperas|Completorium)|HYMNUS|Hymnus|Psalmus|Canticum|Lecture|Pri[èe]re|Oraison)\b", txt):
                intertitre = True
            if colle and not intertitre and (sous_portee or not txt) and not re.match(r"^\d+$", txt or ""):
                cur[1], cur[3] = y1, i
            else:
                pieces.append(cur); cur = None
    if cur: pieces.append(cur)
    out = []
    for y0, y1, i0, i1, *etiq in pieces:
        cols = [0] * w
        for y in range(y0, y1 + 1):
            l = lignes[y]
            a = l.find(1); b = l.rfind(1)
            if a >= 0:
                cols[a] += 1; cols[b] += 1
        xs = [x for x in range(w) if cols[x] and (not gregorien or w * 0.07 < x < w * 0.93)]   # hors repères de coupe
        x0, x1 = (min(xs), max(xs)) if xs else (0, w - 1)
        dessus = bandes[i0][4] or next((bandes[k][3] for k in range(i0 - 1, -1, -1) if not bandes[k][2] and bandes[k][3]), "")
        ecart_dessus = next((bandes[i0][0] - bandes[k][1] for k in range(i0 - 1, -1, -1)), 999)
        dessous = etiq[0] if etiq else next((bandes[k][3] for k in range(i1 + 1, len(bandes)) if not bandes[k][2]), "")
        out.append({"y0": max(0, y0 - 6), "y1": min(h - 1, y1 + 6), "x0": max(0, x0 - 6), "x1": min(w - 1, x1 + 6),
                    "dessus": dessus, "ecart_dessus": ecart_dessus, "dessous": dessous,
                    "dedans": texte_zone(mots, y0, y1)})
    return out


NUM_ROM = {"I": 1, "II": 2, "III": 3, "IV": 4, "V": 5, "VI": 6, "VII": 7, "VIII": 8, "IX": 9, "X": 10, "XI": 11, "XII": 12,
           "XIII": 13, "XIV": 14, "XV": 15, "XVI": 16, "XVII": 17, "XVIII": 18, "XIX": 19, "XX": 20, "XXI": 21, "XXII": 22}


def ids_etiquette(t: str) -> list[str]:
    """« Psaume 41 & AT 15 » → ['41', 'AT15'] ; « Psaume 44, 11-18 & NT VI p. 329 » → ['44', 'NT6']."""
    if not re.match(r"^\s*(Psaumes?|Ps\.?|Cantique|AT|NT)\b", t or ""):
        return []
    t = re.sub(r"\(?p\.\s*\d+\)?", "", t)
    out = []
    for m in re.finditer(r"\b(AT|NT)\s*([IVXL]+|\d+)\b", t):
        n = m.group(2)
        out.append(m.group(1) + str(NUM_ROM.get(n, n)))
    t2 = re.sub(r"\b(AT|NT)\s*([IVXL]+|\d+)\b", "", t)
    t2 = re.sub(r"(\d)\s*,\s*\d+[a-z]?\s*-\s*\d+[a-z]?", r"\1", t2)          # « 44, 1-10 » : versets
    for m in re.finditer(r"(?:Psaumes?|Ps\.?|&|,|et)\s*(\d{1,3})\s*([AB])?(?:\s*-\s*([IVX]+))?", t2):
        n = m.group(1) + (m.group(2) or "")
        if m.group(3): n = f"{n}-{NUM_ROM.get(m.group(3), m.group(3))}"
        if n not in out: out.append(n)
    return out


def decouper(code: str, pdf: Path, pages: list[int] | None = None):
    dossier = RACINE / "partitions" / code
    dossier.mkdir(parents=True, exist_ok=True)
    for f in dossier.glob("s-*.jpg"):
        if pages is None or int(f.name.split("-")[1]) in pages:
            f.unlink()
    mots = mots_pdf(pdf)
    n = int(re.search(r"Pages:\s+(\d+)", subprocess.run(["pdfinfo", str(pdf)], capture_output=True, text=True).stdout).group(1))
    anciennes = []
    if pages is not None and (dossier / "pieces.json").exists():
        anciennes = [x for x in json.loads((dossier / "pieces.json").read_text()) if x["page"] not in pages]
    res = []
    with tempfile.TemporaryDirectory() as tmp:
        for p in (pages or range(1, n + 1)):
            subprocess.run(["pdftoppm", "-r", str(DPI), "-gray", "-f", str(p), "-l", str(p), "-singlefile", str(pdf), f"{tmp}/q"], check=True)
            w, h, px = lire_pgm(Path(tmp) / "q.pgm")
            fin_prec = 0
            for k, pc in enumerate(analyser_page(w, h, px, mots.get(p, []), strict=code in VECTORIELS, gregorien=code.startswith("hg")), 1):
                if pc["y1"] - pc["y0"] < 40:
                    continue
                f = f"s-{p:03d}-{k}.jpg"
                src = dossier / f"p-{p:03d}.jpg"
                if not src.exists():          # page non rendue d'avance (gros volumes) : rendu temporaire
                    src = Path(tmp) / "page.jpg"
                    if not src.exists() or getattr(decouper, "_page", None) != p:
                        subprocess.run(["pdftoppm", "-r", str(DPI), "-gray", "-jpeg", "-jpegopt", "quality=80", "-f", str(p), "-l", str(p),
                                        "-singlefile", str(pdf), str(Path(tmp) / "page")], check=True)
                        decouper._page = p
                subprocess.run(["sips", "-c", str(pc["y1"] - pc["y0"]), str(pc["x1"] - pc["x0"]), "--cropOffset", str(pc["y0"]), str(pc["x0"]),
                                str(src), "--out", str(dossier / f)], capture_output=True, check=True)
                zone = texte_zone(mots.get(p, []), fin_prec, pc["y1"])
                fin_prec = pc["y1"]
                cotes = list(dict.fromkeys(re.findall(r"\b([A-Z]{1,2}) ?(\d{3}[a-z]?)\b", zone)))
                res.append({"page": p, "n": k, "fichier": f, **{c: pc[c] for c in ("y0", "y1", "x0", "x1", "dessus", "ecart_dessus", "dessous")},
                            "dedans": pc["dedans"][:300], "cotes": [f"{a} {b}" for a, b in cotes if a in ("K", "L", "F", "G", "H", "M", "N", "P", "Q", "U", "V", "W", "X", "Y", "Z", "KL")],
                            "ids": ids_etiquette(pc["dessous"]) or ids_etiquette(pc["dessus"])})
    res = sorted(anciennes + res, key=lambda x: (x["page"], x["n"]))
    (dossier / "pieces.json").write_text(json.dumps(res, ensure_ascii=False, indent=0), encoding="utf-8")
    print(f"{code} : {len(res)} pièces sur {len({x['page'] for x in res})} pages")


if __name__ == "__main__":
    a = sys.argv[1:]
    pages = None
    if a and a[0] == "--pages":
        pages = [int(x) for x in a[1].split(",")]; a = a[2:]
    for i in range(0, len(a), 2):
        decouper(a[i], Path(a[i + 1]), pages)
