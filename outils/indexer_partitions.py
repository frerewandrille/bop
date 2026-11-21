"""Index des carnets de chœur de la Province (« carnets Perdrix ») → partitions/index.json

    python3 outils/indexer_partitions.py "<dossier des carnets>"

Chaque page des carnets porte un titre en texte (« Laudes - Lundi I & III », « Répons des vêpres -
Semaine II », « Vigiles - Dimanche III année A | K 311 »…). On en tire des étiquettes :
office, rôle (hymne, antiennes, répons, cantique…), jours, semaines, dimanche, année, cotes.
Une page sans titre continue la pièce de la page précédente.
Les images des pages sont faites par outils/rendre_partitions.sh (partitions/<carnet>/p-NNN.jpg).
"""
from __future__ import annotations
import json
import re
import subprocess
import sys
import unicodedata
from pathlib import Path

ICI = Path(__file__).resolve().parent
SORTIE = ICI.parent / "partitions" / "index.json"
CARNETS = {
    "to": ("Temps ordinaire-MàJ juillet 2018.pdf", "Temps ordinaire"),
    "avent": ("Livret-Avent-2019.pdf", "Avent"),
    "noel": ("livret du temps de Noël.pdf", "Noël et Épiphanie"),
    "careme": ("Livret de Careme 3.0 ODENDALL DBJL.pdf", "Carême"),
    "paques": ("Livret Temps Pascal-final.pdf", "Temps pascal"),
    "sanctoral1": ("Sanctoral-sept-jan.pdf", "Sanctoral (septembre-janvier)"),
}
JOURS = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"]
ROM = {"i": 1, "ii": 2, "iii": 3, "iv": 4, "v": 5, "vi": 6, "vii": 7, "viii": 8}
ORD = {"1er": 1, "premier": 1, "1re": 1, "2e": 2, "deuxieme": 2, "3e": 3, "troisieme": 3, "4e": 4, "quatrieme": 4,
       "5e": 5, "cinquieme": 5, "6e": 6, "7e": 7}


def sa(s: str) -> str:
    s = unicodedata.normalize("NFD", s)
    return "".join(c for c in s if not unicodedata.combining(c)).lower().replace("’", "'")


def textes_pages(pdf: Path) -> list[str]:
    t = subprocess.run(["pdftotext", "-layout", str(pdf), "-"], capture_output=True).stdout.decode("utf-8", "replace")
    pages = t.split("\f")
    out = []
    for p in pages:
        ls = [re.sub(r"\s+", " ", l).strip() for l in p.split("\n")]
        ls = [l for l in ls if l and not re.fullmatch(r"\d{1,3}", l) and "�" not in l[:3] and "Tapez pour" not in l]
        out.append(ls)
    return out


TITRE = re.compile(r"(laudes|vepres|vigiles|complies|hymne|lucernaire|invitatoire|repons|antiennes|louanges|intercessions|"
                   r"preces|cantique|choral|alleluia|canon|te deum|salve|ave |regina|sub tuum|nous te saluons|semaine|dimanche|"
                   r"lundi|mardi|mercredi|jeudi|vendredi|samedi|decembre|janvier|fete|solennite|memoire|saint|sainte|noel|epiphanie|"
                   r"bapteme|paques|ascension|pentecote|rameaux|cendres|acclamation|office|psaume|\(nt )", re.I)


def etiquettes(titre: str, carnet: str) -> dict:
    t = sa(titre)
    e: dict = {}
    # office
    if re.search(r"\b(ires|1res|1eres|premieres)\s+vepres", t): e["office"] = "vepres1"
    elif re.search(r"\b(iies|2es|2emes|deuxiemes)\s+vepres", t): e["office"] = "vepres2"
    elif "vepres" in t: e["office"] = "vepres"
    elif "laudes" in t or "benedictus" in t: e["office"] = "laudes"
    elif "vigiles" in t or "office des lectures" in t: e["office"] = "lectures"
    elif "complies" in t: e["office"] = "complies"
    if "magnificat" in t: e["office"] = e.get("office") if e.get("office", "").startswith("vepres") else "vepres"
    # rôle
    for motif, role in [(r"hymne|gloria (ambrosien|semaine)|hymnes de la passion", "hymne"), (r"lucernaire", "lucernaire"),
                        (r"invitatoire", "invitatoire"), (r"repons", "repons"), (r"benedictus", "benedictus"),
                        (r"magnificat|antiennes . o .|^\d{2} decembre", "magnificat"), (r"louanges|intercessions|preces", "priere"),
                        (r"\(nt [ivx]+\)|cantiques? du nouveau testament", "cantique"), (r"choral", "choral"),
                        (r"alleluia", "alleluia"), (r"canon de saint andre", "canon"), (r"te deum", "tedeum"),
                        (r"antiennes mariales|salve regina|ave maria|ave regina|regina caeli|sub tuum|nous te saluons|rejouis-toi, reine", "mariale"),
                        (r"cantique des (creatures|trois enfants)|cantique de nehemie", "cantique-at"), (r"acclamation de l'evangile", "acclamation"),
                        (r"psaume|\bps\.? ?\d|\bk ?\d{3}|\bl ?\d{3}", "antiennes")]:
        if re.search(motif, t):
            e["role"] = role
            break
    if e.get("role") is None and e.get("office") and re.search(r"(lundi|mardi|mercredi|jeudi|vendredi|samedi|dimanche|jour)", t):
        e["role"] = "antiennes"
    # jours
    jours = [j for j in JOURS if re.search(rf"\b{j}s?\b", t)]
    if jours: e["jours"] = jours
    m = re.search(r"\b(lundi|mardi|mercredi|jeudi|vendredi|samedi|dimanches?)\s+((?:[ivx]+)(?:\s*(?:&|et)\s*[ivx]+)*)\b", t)
    if m:
        e["semaines"] = [ROM[x] for x in re.findall(r"[ivx]+", m.group(2)) if x in ROM]
    m = re.search(r"semaine\s+((?:[ivx]+)(?:\s*(?:&|et)\s*[ivx]+)*)\b", t)
    if m and "semaines" not in e:
        e["semaines"] = [ROM[x] for x in re.findall(r"[ivx]+", m.group(1)) if x in ROM]
    if re.search(r"semaine des cendres", t):
        e.setdefault("semaines", []).insert(0, 0)
    if "semaine sainte" in t or "rameaux" in t or re.search(r"\b(lundi|mardi|mercredi) saint", t):
        e["semaines"] = [6]
    if "cendres" in t and "semaines" not in e:
        e["semaines"] = [0]
    m = re.search(r"\b(1er|2e|3e|4e|5e|6e|7e|premier|deuxieme|troisieme|quatrieme|cinquieme)\s+dimanche", t)
    if m: e["dimanche"] = ORD[m.group(1)]
    m = re.search(r"\bannee\s+([abc])\b", t)
    if m: e["annee"] = m.group(1).upper()
    m = re.search(r"\b(\d{1,2})\s+decembre", t)
    if m: e["date"] = f"12-{int(m.group(1)):02d}"
    m = re.search(r"\b(\d)e?r?\s*(?:et\s*(\d)e)?\s*jours?\b", t)
    if m and carnet == "avent": e["jours_prep"] = [int(x) for x in m.groups() if x]
    cotes = re.findall(r"\b([ABCGKLNPZ])\s?(\d{3})\b", titre)
    if cotes: e["cotes"] = [f"{a} {b}" for a, b in cotes]
    nt = re.search(r"\(nt ([ivx]+)\)", t)
    if nt: e["nt"] = nt.group(1).upper()
    return e


def autres_titres(ls):
    return [k for k, l in enumerate(ls) if k > 0 and re.match(r"^(Ires |IIes |1res |2es )?(Laudes|Vêpres|Vigiles)\s*-\s*\w", l)]


def pages_avec_image(pdf: Path) -> set[int]:
    t = subprocess.run(["pdfimages", "-list", str(pdf)], capture_output=True, text=True).stdout
    return {int(l.split()[0]) for l in t.splitlines()[2:] if l.strip() and l.split()[0].isdigit()}


SECTIONS_ROLE = [(r"hymnes?", "hymne"), (r"repons", "repons"), (r"antiennes", "antiennes"), (r"cantiques", "cantique"),
                 (r"alleluia", "alleluia"), (r"chorals?", "choral"), (r"invitatoires?", "invitatoire"),
                 (r"antiennes mariales", "mariale")]


# Retouches à la main (constat de l'utilisateur) : (carnet, page) → page qui n'est pas ce que son titre annonce.
# to p. 99 : titre « Vêpres » (hymne « Dieu d'Abraham » en texte), mais la musique est la fin du Gloria des laudes du
# vendredi (p. 98) ; signalé le 20/11/2026 (« cet hymne n'a rien à faire dans les Vêpres »).
SUITES = {("to", 99): ("to", 98)}


def retoucher(index):
    for (c, p), (c0, p0) in SUITES.items():
        index["pages"] = [x for x in index["pages"] if not (x["carnet"] == c and x["page"] == p)]
        for x in index["pages"]:
            if x["carnet"] == c0 and x["page"] == p0 and p not in x["suite"]:
                x["suite"].append(p)


def indexer(dossier: Path):
    index = {"carnets": {}, "pages": []}
    for code, (fichier, nom) in CARNETS.items():
        pdf = dossier / fichier
        if not pdf.exists():
            print("absent :", fichier); continue
        pages = textes_pages(pdf)
        images = pages_avec_image(pdf)
        n = int(re.search(r"Pages:\s+(\d+)", subprocess.run(["pdfinfo", str(pdf)], capture_output=True, text=True).stdout).group(1))
        index["carnets"][code] = {"nom": nom, "fichier": fichier, "pages": n}
        courant = None
        section = None     # rôle donné par la dernière page de garde (« Hymnes fériales des laudes & vêpres »)
        jour_herite = None
        for i, ls in enumerate(pages[:n], 1):
            tete = ls[0] if ls else ""
            court = all(len(x) < 40 for x in ls)
            # page de garde de section : pas d'image, quelques lignes courtes
            garde = (i not in images) or (len(ls) >= 3 and sa(ls[1]) in ("des", "du", "de", "pour les", "pour la", "&", "de la", "a"))
            if garde and 0 < len(ls) <= 5 and court and not re.search(r"\bp\.\s*\d", " ".join(ls)):
                t = sa(" ".join(ls))
                section = next((r for m, r in SECTIONS_ROLE[::-1] if re.search(m, t)), None)
                if "mariale" in t: section = "mariale"
                courant, jour_herite = None, None
                continue
            if not ls or (len(ls) <= 2 and court and tete.isupper() and len(tete) < 12):
                if courant is not None and i in images:
                    courant["suite"].append(i)
                continue
            if sa(tete).startswith(("sommaire", "index")) or re.search(r"\bp\.\s*\d+", " ".join(ls[:3])) and i not in images:
                courant = None
                continue
            if courant is not None and re.match(r"^(Psaume|Ps\.?)\s*\d", tete):
                courant["suite"].append(i)   # suite de la psalmodie (« Psaume 144, 10-14 »)
                continue
            if re.match(r"^[A-Z] ?\d{3}\b", tete) and courant is not None:
                courant["suite"].append(i)
                courant.setdefault("cotes", []).extend(f"{a} {b}" for a, b in re.findall(r"\b([ABCGKLNPZ])\s?(\d{3})\b", " ".join(ls[:3])))
                continue
            if len(tete) < 90 and TITRE.search(sa(tete)) and not re.match(r"^\d+\.", tete):
                titre = " | ".join(ls[:6])
                e = etiquettes(titre, code)
                if section and (e.get("role") in (None, "antiennes") or (section == "hymne" and e.get("role") not in ("hymne", "lucernaire", "invitatoire", "repons", "cantique", "benedictus", "magnificat"))):
                    if not (section == "antiennes" and e.get("role") == "antiennes"):
                        e["role"] = section
                if e.get("role") in (None, "antiennes") and not autres_titres(ls):
                    toutes = [f"{a} {b}" for a, b in re.findall(r"\b([KL])\s?(\d{3})\b", " ".join(ls))]
                    if toutes: e["cotes"] = list(dict.fromkeys(toutes))
                    mnt = re.search(r"\bNT\s+([IVX]+)\b", " ".join(ls))
                    if mnt: e["nt"] = mnt.group(1)
                if "preparatoire" in sa(titre):
                    e["prep"] = True
                # titre réduit au jour (« Mercredi I ») : même rôle et même office que la pièce précédente
                if courant is not None and not e.get("office") and courant.get("role") in ("benedictus", "magnificat", "repons", "cantique", "hymne") \
                        and re.fullmatch(r"(lundi|mardi|mercredi|jeudi|vendredi|samedi|dimanche)( [ivx]+)?", sa(tete).strip()):
                    e["role"] = courant["role"]
                    if courant.get("office"): e["office"] = courant["office"]
                if e.get("jours"):
                    jour_herite = e["jours"]
                elif jour_herite and section == "hymne" and re.match(r"^(Laudes|Vêpres)\b(?!\s*-)", tete) and "semaine" not in sa(tete):
                    e["jours"] = jour_herite   # hymnes sans musique : « Vêpres » sous « Lundi »
                # même titre que la pièce précédente, sans nouvelle précision : c'est sa suite
                if courant is not None and tete == courant["titre"] and not (set(e) - {"role", "office"}):
                    courant["suite"].append(i)
                    continue
                # deux pièces sur la même page (« Vêpres - Vendredi III » puis « Laudes - Samedi III »)
                autres = [k for k, l in enumerate(ls) if k > 0 and re.match(r"^(Ires |IIes |1res |2es )?(Laudes|Vêpres|Vigiles)\s*-\s*\w", l)]
                if autres:
                    e = etiquettes(" | ".join(ls[:autres[0]]), code)
                    if section and e.get("role") in (None, "antiennes") and section != "antiennes": e["role"] = section
                courant = {"carnet": code, "page": i, "titre": tete, "detail": " | ".join(ls[1:6])[:200], **e, "suite": []}
                index["pages"].append(courant)
                for k in autres:
                    e2 = etiquettes(" | ".join(ls[k:k + 3]), code)
                    if section and e2.get("role") in (None, "antiennes") and section != "antiennes": e2["role"] = section
                    courant = {"carnet": code, "page": i, "titre": ls[k], "detail": " | ".join(ls[k + 1:k + 3])[:200], **e2, "suite": []}
                    index["pages"].append(courant)
            elif courant is not None and i in images:
                courant["suite"].append(i)
            else:
                courant = None
    retoucher(index)
    # Table publique (sans musique) : cotes des antiennes par office, pour le mode « Province »
    prov = [{k: p[k] for k in ("carnet", "office", "jours", "semaines", "annee", "date", "cotes", "nt", "titre") if k in p}
            for p in index["pages"] if p.get("role") == "antiennes" and p.get("cotes") and p.get("office")]
    (ICI.parent / "site" / "donnees" / "province.json").write_text(json.dumps(prov, ensure_ascii=False, indent=0), encoding="utf-8")
    SORTIE.parent.mkdir(exist_ok=True)
    SORTIE.write_text(json.dumps(index, ensure_ascii=False, indent=0), encoding="utf-8")
    print(f"{len(index['pages'])} pièces indexées dans {len(index['carnets'])} carnets → {SORTIE}")


if __name__ == "__main__":
    indexer(Path(sys.argv[1]))
