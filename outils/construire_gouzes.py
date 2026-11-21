"""Tableau « Offices Gouzes répartition, traduction.xlsx » → site/donnees/gouzes.json

    python3 outils/construire_gouzes.py [chemin du .xlsx]

Lit les feuilles de la Liturgie chorale du peuple de Dieu (A. Gouzes) et produit, pour chaque
office, la liste des psaumes du psautier avec leur antienne, leur cote et leur ton :

  G/…  répartition gouzantine (temps ordinaire, Avent, Carême, temps pascal)
  R/…  répartition romaine avec les antiennes de Gouzes (feuilles « LAUD ROM », « VEP ROM », « VIG ROM »)

Clés : « G/to/1/lundi/laudes », « G/avent/dim2/lectures », « G/avent/j3/vepres » (19 déc.),
« G/careme/sem1/mardi/vepres », « G/paques/dim/vepres1 », « G/paques/ascension/laudes »…
Les feuilles « SEMAINE SAINTE », « Sanctoral » et « Milieu du jour » ne sont pas reprises
(antiennes incomplètes, ou office non proposé par le site).
Nécessite openpyxl (pour la construction seulement ; le site n'en dépend pas).
"""
from __future__ import annotations
import json
import re
import sys
import unicodedata
from pathlib import Path

import openpyxl

ICI = Path(__file__).resolve().parent
sys.path.insert(0, str(ICI))
DONNEES = ICI.parent / "site" / "donnees"

ROM = {"I": 1, "II": 2, "III": 3, "IV": 4, "V": 5, "VI": 6, "VII": 7, "VIII": 8, "IX": 9, "X": 10, "XI": 11,
       "XII": 12, "XIII": 13, "XIV": 14, "XV": 15, "XVI": 16, "XVII": 17, "XVIII": 18, "XIX": 19, "XX": 20,
       "XXI": 21, "XXII": 22}
JOURS = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"]

P = json.loads((DONNEES / "psautier.json").read_text(encoding="utf-8"))["pieces"]
avert: list[str] = []


def norm(s) -> str:
    if s is None:
        return ""
    s = unicodedata.normalize("NFC", str(s)).replace("\xa0", " ").replace("–", "-").replace("—", "-")
    return re.sub(r"\s+", " ", s).strip()


def sans_accents(s: str) -> str:
    return "".join(c for c in unicodedata.normalize("NFD", s) if not unicodedata.combining(c)).lower()


def jour_de(s) -> str | None:
    s = sans_accents(norm(s))
    for j in JOURS:
        if s.startswith(j):
            return j
    return None


# ── Cantiques : livre + chapitre de chaque cantique du psautier
def _livre_chap(ref: str):
    m = re.match(r"^((?:[1-3]\s?)?[A-Z][a-z]*)\s*(\d+)", ref or "")
    return (m.group(1).replace(" ", ""), int(m.group(2))) if m else None


CANT = {pid: _livre_chap(p["ref"]) for pid, p in P.items() if p["genre"] != "psaume" and p.get("ref")}


def cantique_par_ref(ref: str):
    """« Ap 4-5 », « Ph 2 », « Ap 11-12 » → id de cantique NT/AT du psautier."""
    lc = _livre_chap(ref)
    if not lc:
        return None
    for pid, x in CANT.items():
        if x == lc:
            return pid
    for pid, x in CANT.items():  # chapitre de départ différent : même livre, chapitre voisin
        if x and x[0] == lc[0] and abs(x[1] - lc[1]) <= 1:
            return pid
    return None


def premier_verset(pid: str):
    for s in P[pid]["strophes"]:
        for l in s["lignes"]:
            if l.get("v"):
                m = re.match(r"\d+", l["v"])
                if m:
                    return int(m.group(0))
    return None


def piece_psaume(num: str, lettre: str | None, verset: int | None):
    """Psaume 9 / 18 / 113 : les pièces 9A/9B… existent ; sinon le numéro seul."""
    if lettre and (num + lettre.upper()) in P:
        return num + lettre.upper(), None
    if num in P:
        return num, lettre
    a, b = num + "A", num + "B"
    if a in P and b in P:
        if verset is not None:
            pb = premier_verset(b) or 10 ** 6
            return (b if verset >= pb else a), lettre
        return a, lettre
    return None, lettre


def analyser_ref(brut) -> list[dict]:
    """Une cellule « Psaume » → liste d'éléments {id, partie?, versets?}."""
    s = norm(brut)
    if not s or s in ("B",) or s.startswith("Be"):
        return []
    s = re.sub(r"\s*\((?:B|Z)\s*\d+\)\s*$", "", s)  # « AT 1 (B 901) »
    out = []
    # cantiques
    m = re.fullmatch(r"(AT|NT)\s*([0-9]+|[IVX]+)", s, re.I)
    if m:
        n = m.group(2).upper()
        pid = f"{m.group(1).upper()}{ROM[n] if n in ROM else int(n)}"
        return [{"id": pid}] if pid in P else _manque(s)
    if re.match(r"^(?:[1-3]\s?)?[A-Z][a-z]+\s*\d", s):
        pid = cantique_par_ref(s)
        return [{"id": pid}] if pid else _manque(s)
    # Ps 118 : « 118, XIX », « 118-XIV »
    m = re.fullmatch(r"118\s*[,-]\s*([IVX]+)", s)
    if m:
        return [{"id": f"118-{ROM[m.group(1)]}"}]
    # plage de psaumes « 112 - 116 »
    m = re.fullmatch(r"(\d+)\s*-\s*(\d+)", s)
    if m and int(m.group(2)) > int(m.group(1)) and int(m.group(2)) - int(m.group(1)) < 8:
        for n in range(int(m.group(1)), int(m.group(2)) + 1):
            for pid in ([str(n)] if str(n) in P else [f"{n}A", f"{n}B"]):
                if pid in P:
                    out.append({"id": pid})
        return out
    # versets : « 26, 7-14 », « 144, 13b-21 », « 18, 1-7 »
    m = re.fullmatch(r"(\d+)\s*,\s*(\d+)[a-c]?\s*-\s*(\d+)[a-c]?", s)
    if m:
        pid, _ = piece_psaume(m.group(1), None, int(m.group(2)))
        return [{"id": pid, "versets": f"{m.group(2)}-{m.group(3)}"}] if pid else _manque(s)
    # nombres collés par Excel : 120124 → 120 et 124
    if re.fullmatch(r"\d{6}", s):
        return analyser_ref(s[:3]) + analyser_ref(s[3:])
    # plusieurs éléments dans la cellule : « 6 AT18 12 »
    morceaux = re.findall(r"AT\s*\d+|NT\s*[IVX]+|\d+\s*[a-cA-C]?\b", s)
    if len(morceaux) > 1 and not re.fullmatch(r"\d+\s*[a-cA-C]", s):
        for mo in morceaux:
            out += analyser_ref(mo)
        return out
    m = re.fullmatch(r"(\d+)\s*([a-cA-C])?", s)
    if m:
        pid, lettre = piece_psaume(m.group(1), m.group(2), None)
        if not pid:
            return _manque(s)
        e = {"id": pid}
        if lettre:
            e["lettre"] = lettre.lower()
        return [e]
    return _manque(s)


def _manque(s):
    avert.append(f"référence non reconnue : « {s} »")
    return []


def element(cote, ant, ps, ton) -> dict | None:
    pieces = analyser_ref(ps)
    if not pieces:
        return None
    e = {"pieces": pieces}
    if norm(ant):
        e["ant"] = norm(ant)
    if norm(cote) and norm(cote) != "Cf.":
        e["cote"] = norm(cote)
    if norm(ton):
        e["ton"] = norm(ton)
    return e


def finir(elements: list[dict]) -> list[dict]:
    """Découpe en parties : lettres a/b/c, ou même psaume répété (deux antiennes pour un psaume)."""
    elems = [e for e in elements if e]
    # psaume répété sans lettre → parties 1..n
    compte: dict[str, int] = {}
    for e in elems:
        for p in e["pieces"]:
            if "versets" not in p and "lettre" not in p:
                compte[p["id"]] = compte.get(p["id"], 0) + 1
    vus: dict[str, int] = {}
    for e in elems:
        for p in e["pieces"]:
            if compte.get(p["id"], 0) > 1 and "versets" not in p and "lettre" not in p:
                vus[p["id"]] = vus.get(p["id"], 0) + 1
                p["partie"] = [vus[p["id"]], compte[p["id"]]]
    # lettres → parties (n = plus grande lettre de l'office, au moins 2)
    lettres: dict[str, int] = {}
    for e in elems:
        for p in e["pieces"]:
            if "lettre" in p:
                lettres[p["id"]] = max(lettres.get(p["id"], 0), "abc".index(p["lettre"]) + 1)
    for e in elems:
        for p in e["pieces"]:
            if "lettre" in p:
                p["partie"] = ["abc".index(p.pop("lettre")) + 1, max(2, lettres[p["id"]])]
    # « 144 » puis « 144 b » : le premier est la partie a
    for e in elems:
        for p in e["pieces"]:
            if "partie" not in p and "versets" not in p and p["id"] in lettres:
                p["partie"] = [1, max(2, lettres[p["id"]])]
    return elems


OFF: dict[str, dict] = {}


def poser(cle: str, elements=None, **extra):
    o = OFF.setdefault(cle, {})
    if elements is not None:
        o["psalmodie"] = finir(elements)
    for k, v in extra.items():
        if v:
            o[k] = v


# ───────────────────────── Feuilles hebdomadaires ─────────────────────────
def feuille_semaine(ws, serie: str, office: str):
    groupes: dict[tuple, list] = {}
    jour = sem = None
    for r in ws.iter_rows(values_only=True):
        r = list(r) + [None] * 8
        j, s, cote, ant, ps, ton = r[:6]
        if norm(j).upper() in ("JOUR", "VÊPRES", "VEPRES") or (j is None and s is None and ps is None):
            continue
        jour = jour_de(j) or jour
        if isinstance(s, (int, float)):
            sem = int(s)
        if jour is None or sem is None or ps is None:
            continue
        groupes.setdefault((sem, jour), []).append(element(cote, ant, ps, ton if serie == "G" else None))
    for (sem, jour), el in groupes.items():
        poser(f"{serie}/to/{sem}/{jour}/{office}", el)


def feuille_vigiles_rom(ws):
    groupes: dict[tuple, list] = {}
    for r in ws.iter_rows(values_only=True):
        r = list(r) + [None] * 8
        _, j, s, _, cote, txt, ps = r[:7]
        if not jour_de(j) or not isinstance(s, (int, float)):
            continue
        t = norm(txt)
        m = re.search(r"\s+et\s+ps\.?\s*([\d ]+[a-c]?)\s*$", t, re.I)
        if m:
            ps = re.sub(r"(?<=\d)\s+(?=\d)", "", m.group(1)).strip()
            t = t[:m.start()]
        groupes.setdefault((int(s), jour_de(j)), []).append((cote, t, ps))
    for (s, j), lignes in groupes.items():
        if any(ps in (None, "") for _, _, ps in lignes):
            avert.append(f"Vigiles (romaine) {j} {s} : psaume manquant pour une antienne, office non repris")
            continue
        poser(f"R/to/{s}/{j}/lectures", [element(c, t, ps, None) for c, t, ps in lignes])


# ───────────────────────── Temps pascal ─────────────────────────
def feuille_paques(ws, decal: int):
    blocs: dict[str, list] = {}
    for r in ws.iter_rows(values_only=True):
        r = list(r)[decal:] + [None] * 9
        sem, jour, off, num, cote, ant, ps, mode = r[:8]
        o = sans_accents(norm(off))
        if o not in ("vepres i", "vepres ii", "vepres", "vigiles", "laudes"):
            continue
        office = {"vepres i": "vepres1", "vepres ii": "vepres2", "vepres": "vepres", "vigiles": "lectures", "laudes": "laudes"}[o]
        s, jr = sans_accents(norm(sem)), sans_accents(norm(jour))
        if jr == "ascension":
            base = "ascension"
        elif jr == "pentecote":
            base = "pentecote"
        elif jr.startswith("7e dimanche"):
            base = "dim7"
        elif s.startswith("apres l"):
            base = f"apres-ascension/{jour_de(jour)}"
        elif s == "commun":
            base = "dim"
        elif re.fullmatch(r"i{1,2}", s):
            base = f"sem{len(s)}/{jour_de(jour)}"
        else:
            m = re.match(r"^([ivx]+)e\s*([a-c-]+)$", s)  # invitatoires des dimanches : « IIe A-B-C », « Ve B »
            if m and str(num) == "0":
                n = ROM[m.group(1).upper()]
                for c in re.findall(r"[abc]", m.group(2)):
                    poser(f"G/paques/dim{n}{c.upper()}/laudes", None, invitatoire={"ant": norm(ant), "cote": norm(cote)})
            continue
        cle = f"{base}/{office}"
        n = str(num)
        if n == "0":
            poser(f"G/paques/{base}/laudes", None, invitatoire={"ant": norm(ant), "cote": norm(cote), "ton": norm(mode)})
            continue
        if n in ("M", "B"):
            cible = cle if n == "M" else f"{base}/laudes"
            if n == "M" and office == "laudes":
                cible = f"{base}/laudes"
            poser(f"G/paques/{cible}", None, evangelique={"ant": norm(ant), "cote": norm(cote), "ton": norm(mode)})
            continue
        if ant is None and ps is None:
            blocs.setdefault(cle, []).append(None)  # élément inconnu : l'office sera incomplet
            continue
        if ps is None:
            ps = CODES_CANTIQUES.get(norm(cote).replace(" ", ""))
            if ps is None:
                avert.append(f"Temps pascal {base} {office} : cantique {norm(cote)} sans référence, omis")
                continue
        blocs.setdefault(cle, []).append(element(cote, ant, ps, mode))
    for cle, el in blocs.items():
        if any(e is None for e in el):
            avert.append(f"Temps pascal {cle} : antiennes non renseignées dans le tableau, office non repris")
            continue
        poser(f"G/paques/{cle}", el)


CODES_CANTIQUES: dict[str, str] = {}


def relever_codes(ws, decal):
    """Cote « B 942 » ↔ « AT 50 » : sert quand la cote du cantique est seule."""
    for r in ws.iter_rows(values_only=True):
        r = list(r)[decal:] + [None] * 9
        cote, ps = norm(r[4]).replace(" ", ""), norm(r[6])
        if cote.startswith("B") and ps.startswith("AT"):
            CODES_CANTIQUES[cote] = ps


def main(chemin: Path):
    wb = openpyxl.load_workbook(chemin, data_only=True)
    F = {sans_accents(ws.title): ws for ws in wb.worksheets}
    feuille_semaine(F["laudes to"], "G", "laudes")
    feuille_semaine(F["vepres to"], "G", "vepres")
    feuille_semaine(F["laud rom"], "R", "laudes")
    feuille_semaine(F["vep rom"], "R", "vepres")
    feuille_vigiles_rom(F["vig rom"])
    # Avent et Carême : lus dans les documents Word (plus complets), voir construire_gouzes_docs.py
    relever_codes(F["temps pascal ii"], 0)
    relever_codes(F["temps pascal iii"], 1)
    feuille_paques(F["temps pascal ii"], 0)
    feuille_paques(F["temps pascal iii"], 1)
    # Milieu du jour : une antienne et un psaume par jour (semaines I à IV, sauf le dimanche)
    for r in F["milieu du jour"].iter_rows(min_row=4, values_only=True):
        sem, jour, cote, ant, ps = (list(r) + [None] * 5)[:5]
        if sem and jour and ps and jour_de(jour):
            ps = re.sub(r"^118\s+([IVX]+)$", r"118, \1", norm(ps))
            ps = {"18Ba": "18 B a", "18Bb": "18 B b"}.get(ps, ps)
            if ps.startswith("18 B"):
                el = [{"pieces": [{"id": "18B", "partie": [1 if ps.endswith("a") else 2, 2]}], "ant": norm(ant), "cote": norm(cote)}]
                OFF[f"G/to/{ROM[norm(sem)]}/{jour_de(jour)}/milieu"] = {"psalmodie": el}
            else:
                poser(f"G/to/{ROM[norm(sem)]}/{jour_de(jour)}/milieu", [element(cote, ant, ps, None)])
    # Documents Word (Avent, Carême, répons, litanies, Ténèbres) : complètent et précisent le tableau
    import construire_gouzes_docs as docs
    textes = docs.ajouter(sys.modules[__name__], chemin.parent, F)
    import repons_to_lignes                     # répons du TO avec leurs retours à la ligne (texte de l'utilisateur)
    repons_to_lignes.appliquer(textes)
    sortie = {
        "source": chemin.name,
        "textes": textes,
        "titre": "Liturgie chorale du peuple de Dieu (A. Gouzes)",
        "offices": dict(sorted(OFF.items())),
        "remarques": sorted(set(avert)),
    }
    (DONNEES / "gouzes.json").write_text(json.dumps(sortie, ensure_ascii=False, indent=0), encoding="utf-8")
    print(f"Gouzes : {len(OFF)} offices ({sum(1 for k in OFF if k.startswith('G/'))} gouzantins, "
          f"{sum(1 for k in OFF if k.startswith('R/'))} romains avec antiennes de Gouzes)")
    for a in sorted(set(avert)):
        print("  ", a)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        src = Path(sys.argv[1])
    else:
        cands = list((ICI.parent / "sources_gouzes").glob("*Gouzes*.xlsx"))
        if not cands:
            sys.exit("Placez le tableau Gouzes (.xlsx) dans le dossier « sources_gouzes ».")
        src = cands[0]
    main(src)
