"""« Les Heures grégoriennes » (Communauté Saint-Martin, 3 tomes) : rattache chaque pièce notée
(découpée par outils/decouper_partitions.py dans partitions/hgN/) à son jour, son office et son rôle.

    python3 outils/indexer_heures_gregoriennes.py
      → partitions/hg/index.json : [{cle, office, role, rang, fichiers: [...]}]

cle :  "P/<semaine>/<jour>"        psautier des 4 semaines (jour : dimanche…samedi)
       "T/<temps>/<semaine>/<jour>" temporal (avent, careme, paques ; semaine 0 = après les Cendres)
       "TO/<semaine>"              dimanches du temps ordinaire (antiennes évangéliques)
       "D/<MM-JJ>"                 date (sanctoral, féries du 17 au 24 décembre, octave de Noël)
       "F/<nom>"                   fêtes nommées (nativite, epiphanie, bapteme, trinite, …)
       "C/<commun>"                communs
office : lectures | laudes | milieu | vepres | vepres1 | vepres2 | complies | invitatoire
role :   hymne | antienne (rang 1, 2, 3) | repons | evangelique | autre

Usage privé : ces livres portent « Tous droits réservés » ; les images restent hors du site publié.
"""
from __future__ import annotations
import json
import re
import subprocess
import sys
from pathlib import Path

ICI = Path(__file__).resolve().parent
RACINE = ICI.parent
sys.path.insert(0, str(ICI))
from decouper_partitions import mots_pdf  # noqa: E402

SRC = RACINE / "sources_gouzes" / "heures-gregoriennes"
JOURS_L = {"DOMINICA": "dimanche", "FERIA II": "lundi", "FERIA III": "mardi", "FERIA IV": "mercredi", "FERIA V": "jeudi",
           "FERIA VI": "vendredi", "SABBATO": "samedi"}
ROM = {"I": 1, "II": 2, "III": 3, "IV": 4, "V": 5, "VI": 6, "VII": 7, "VIII": 8, "IX": 9, "X": 10, "XI": 11, "XII": 12,
       "XIII": 13, "XIV": 14, "XV": 15, "XVI": 16, "XVII": 17, "XVIII": 18, "XIX": 19, "XX": 20, "XXI": 21, "XXII": 22,
       "XXIII": 23, "XXIV": 24, "XXV": 25, "XXVI": 26, "XXVII": 27, "XXVIII": 28, "XXIX": 29, "XXX": 30, "XXXI": 31,
       "XXXII": 32, "XXXIII": 33, "XXXIV": 34}
MOIS_L = {"IANUARII": 1, "FEBRUARII": 2, "MARTII": 3, "APRILIS": 4, "MAII": 5, "IUNII": 6, "IULII": 7, "AUGUSTI": 8,
          "SEPTEMBRIS": 9, "OCTOBRIS": 10, "NOVEMBRIS": 11, "DECEMBRIS": 12}
OFFICES = [(r"AD I VESPERAS", "vepres1"), (r"AD II VESPERAS", "vepres2"), (r"AD VESPERAS", "vepres"),
           (r"AD LAUDES MATUTINAS", "laudes"), (r"AD OFFICIUM LECTIONIS", "lectures"), (r"AD HORAM MEDIAM", "milieu"),
           (r"AD (TERTIAM|SEXTAM|NONAM)", "milieu"), (r"AD COMPLETORIUM", "complies"), (r"INVITATORIUM", "invitatoire")]
FETES = [("NATIVITATE DOMINI", "nativite"), ("SANCTÆ FAMILIÆ", "sainte-famille"), ("SANCTÆ DEI GENETRICIS", "marie-mere-de-dieu"),
         ("EPIPHANIA", "epiphanie"), ("BAPTISMATE", "bapteme"), ("UNIVERSORUM REGIS", "christ-roi"), ("TRINITATIS", "trinite"),
         ("CORPORIS ET SANGUINIS", "saint-sacrement"), ("CORDIS IESU", "sacre-coeur"), ("ASCENSIONE", "ascension"),
         ("PENTECOSTES", "pentecote"), ("RESURRECTIONIS", "paques"), ("IN PALMIS", "rameaux"), ("FERIA IV CINERUM", "cendres"),
         ("IN CENA DOMINI", "jeudi-saint"), ("IN PASSIONE DOMINI", "vendredi-saint"), ("SABBATO SANCTO", "samedi-saint")]
COMMUNS = [("DEDICATIONIS", "dedicace"), ("BEATÆ MARIÆ", "vierge-marie"), ("APOSTOLORUM", "apotres"), ("PLURIUM MARTYRUM", "martyrs"),
           ("UNIUS MARTYRIS", "martyr"), ("PASTORUM", "pasteurs"), ("DOCTORUM", "docteurs"), ("VIRGINUM", "vierges"),
           ("SANCTORUM VIRORUM", "saints"), ("SANCTARUM MULIERUM", "saintes"), ("DEFUNCTORUM", "defunts")]
CHIF = str.maketrans({"≤": "1", "≥": "2", "<": "5", "‹": "4", "6": "6"})


def cle_jour(t: str) -> str | None:
    """Titre courant latin → clé du jour."""
    t = re.sub(r"\s+", " ", t.upper().translate(CHIF)).strip()
    t = re.sub(r"\s+\.", ".", t)                                  # « HEBD . II » (pdftotext) → « HEBD. II »
    t = re.sub(r"\s+AD .*$", "", t)
    m = re.match(r"^(I|II|III|IV) – (DOMINICA|FERIA (?:III|II|IV|VI|V)\b|SABBATO)$", t)
    if m:
        return f"P/{ROM[m.group(1)]}/{JOURS_L[m.group(2)]}"
    m = re.match(r"^DIE (\d+) ([A-Z]+)", t)
    if m and m.group(2) in MOIS_L:
        return f"D/{MOIS_L[m.group(2)]:02d}-{int(m.group(1)):02d}"
    for k, v in COMMUNS:
        if "COMMUNE" in t and k in t:
            return f"C/{v}"
    if "COMMUNE" in t or "OFFICIUM DEFUNCTORUM" in t:
        return "C/" + ("defunts" if "DEFUNCT" in t else "autre")
    m = re.match(r"^HEBDOMADA ([IVX]+) PER ANNUM", t) or re.match(r"^DOMINICA ([IVX]+) PER ANNUM", t)
    if m:
        return f"TO/{ROM[m.group(1)]}"
    for k, v in FETES:
        if k in t:
            return f"F/{v}"
    m = re.match(r"^(FERIA (?:III|II|IV|VI|V)\b|SABBATO) POST (DOMINICAM EPIPHANIÆ|CINERES)", t)
    if m:
        return (f"T/epiphanie/1/{JOURS_L[m.group(1)]}" if "EPIPH" in m.group(2) else f"T/careme/0/{JOURS_L[m.group(1)]}")
    if re.match(r"^PROPRIUM C\. S\. M\.", t):
        m = re.search(r"DIE (\d+) ([A-Z]+)", t)
        return f"CSM/{MOIS_L.get(m.group(2), 0):02d}-{int(m.group(1)):02d}" if m else None
    temps = "avent" if "ADVENTUS" in t else "careme" if ("QUADRAGESIM" in t or "CINERUM" in t) else \
        "semaine-sainte" if "HEBD. SANCTÆ" in t else "paques" if ("PASCH" in t) else None
    if temps:
        m = re.match(r"^DOMINICA ([IVX]+)", t)
        if m:
            return f"T/{temps}/{ROM[m.group(1)]}/dimanche"
        m = re.match(r"^(FERIA (?:III|II|IV|VI|V)\b|SABBATO)(?: HEBD\. ([IVX]+))?", t)
        if m:
            sem = ROM[m.group(2)] if m.group(2) else (0 if "CINERUM" in t else 1 if "OCTAV" in t else 6 if temps == "semaine-sainte" else None)
            return f"T/{temps}/{sem}/{JOURS_L[m.group(1)]}"
    return None


def lignes(mots):
    out = {}
    for x0, y0, x1, y1, w in mots:
        k = next((k for k in out if abs(k - y0) < 4), y0)
        out.setdefault(k, []).append((x0, w))
    return sorted((y, " ".join(w for _, w in sorted(v))) for y, v in out.items())


def role_de(p):
    t = f"{p['dessus']} | {p['dedans'][:60]}"
    T = t.upper()
    if re.search(r"BENEDICTUS|MAGNIFICAT|NUNC DIMITTIS|CANT\. EVANG", T):
        return "evangelique", None
    if "HYMNUS" in T:
        return "hymne", None
    if re.search(r"RESPONSORIUM|RESP\.|^R/", T):
        return "repons", None
    if "INVITATOR" in T:
        return "invitatoire", None
    m = re.search(r"ANT\.\s*(\d)", T.translate(CHIF))
    if m:
        return "antienne", int(m.group(1))
    if re.search(r"\bANT\.", T):
        return "antienne", None
    return "autre", None


def indexer(n: int):
    pdf = SRC / f"Tome {'I' * n}.pdf"
    code = f"hg{n}"
    pieces = json.loads((RACINE / "partitions" / code / "pieces.json").read_text(encoding="utf-8"))
    parpage = {}
    for p in pieces:
        parpage.setdefault(p["page"], []).append(p)
    mots = mots_pdf(pdf)
    jour, office = None, None
    res = []
    for page in sorted(mots):
        ls = lignes(mots[page])
        # titre courant : première ligne de texte (en latin sur les pages paires)
        titre = next((t for y, t in ls if y > 20 and not t.startswith("Tome ")), "")
        titre = re.sub(r"^\d+\s+|\s+\d+$", "", titre)
        c = cle_jour(titre)
        if c:
            jour = c
        evts = [(y, "office", o) for y, t in ls for pat, o in OFFICES if re.fullmatch(r"\s*" + pat + r"\s*", t.upper())]
        # début d'un jour du psautier au milieu de la page (« FERIA TERTIA », « HEBDOMADA II »)
        JOUR_TITRE = {"DOMINICA": "dimanche", "FERIA SECUNDA": "lundi", "FERIA TERTIA": "mardi", "FERIA QUARTA": "mercredi",
                      "FERIA QUINTA": "jeudi", "FERIA SEXTA": "vendredi", "SABBATO": "samedi"}
        for y, t in ls:
            u = t.strip().upper()
            if u in JOUR_TITRE:
                evts.append((y, "jour", JOUR_TITRE[u]))
            m = re.fullmatch(r"HEBDOMADA (I|II|III|IV)", u)
            if m:
                evts.append((y, "semaine", ROM[m.group(1)]))
        evts.sort()
        if not evts:      # office donné par le titre courant
            o = next((o for pat, o in OFFICES if re.search(pat, titre.upper())), None)
            if o and o != office:
                office = o
        def appliquer(y_lim, tous=False):
            nonlocal office, jour
            for y, typ, v in evts:
                if not tous and y >= y_lim:
                    continue
                if typ == "office": office = v
                elif typ == "jour" and jour and jour.startswith("P/"): jour = f"P/{jour.split('/')[1]}/{v}"
                elif typ == "semaine" and jour and jour.startswith("P/"): jour = f"P/{v}/{jour.split('/')[2]}"
        for p in sorted(parpage.get(page, []), key=lambda x: x["y0"]):
            appliquer(p["y0"])
            role, rang = role_de(p)
            d = re.sub(r"\s+", " ", p["dessus"]).strip()
            f = f"{code}/{p['fichier']}"
            prec = res[-1] if res else None
            # suite d'une pièce commencée à la page précédente (rien au-dessus, sauf le titre courant)
            if role == "autre" and prec and prec["page"] in (page - 1, page - 2) and (not d or re.match(r"^\d+\s+[A-ZÀ-Ý]", d) or cle_jour(d)):
                prec["fichiers"].append(f)
                continue
            variante = None
            m = re.match(r"^(Anno ([ABC])|Tempore paschali|Tempore Adventus|Tempore Nativitatis|Tempore Quadragesimæ|Extra tempus paschale|Vel)", d)
            if m:
                variante = m.group(2) or {"Tempore paschali": "TP", "Extra tempus paschale": "hors-TP", "Vel": "ou"}.get(m.group(1), m.group(1))
                if role == "autre" and prec and prec["cle"] == jour and prec["office"] == office:
                    role, rang = prec["role"], prec["rang"]
            if re.match(r"^TON\b", d):
                role = "ton"
            res.append({"cle": jour, "office": office, "role": role, "rang": rang, "variante": variante,
                        "fichiers": [f], "page": page, "titre": d[:60]})
        appliquer(0, tous=True)
    # rang des antiennes non numérotées : ordre dans l'office
    from collections import defaultdict
    n_ant = defaultdict(int)
    for r in res:
        if r["role"] == "antienne":
            k = (r["cle"], r["office"])
            n_ant[k] += 1
            r["rang"] = r["rang"] or n_ant[k]
    return res


# ─── Traduction française (page impaire en regard) ───
VAR_FR = [(r"^(Au )?[Tt]emps pascal", "TP"), (r"^(En |Au temps du |Temps du )?Carême", "Tempore Quadragesimæ"), (r"^(Au )?([Tt]emps de l.|En )Avent", "Tempore Adventus"),
          (r"^(Au )?([Tt]emps de )Noël", "Tempore Nativitatis"), (r"^Année ([ABC])", None), (r"^Hors du temps pascal", "hors-TP"), (r"^Ou bien", "ou")]


def items_fr(texte: str):
    """Pièces de la page française : [(role, rang, variante, [lignes])]."""
    out, cur, var = [], None, None
    for l in texte.split("\n"):
        t = re.sub(r"\s+", " ", l).strip().translate(CHIF)
        if not t or t.startswith("Tome ") or re.fullmatch(r"\d+|.*\s\d{2,4}$", t) and t.upper() == t:
            continue
        m = re.match(r"^Ant\.\s*(\d)\.?\s*(.*)$", t)
        mv = next(((pat, v) for pat, v in VAR_FR if re.match(pat, t)), None)
        if mv:
            var = mv[1] or re.match(r"^Année ([ABC])", t).group(1)
            ma = re.search(r"ant\.\s*(\d)", t)                  # « Au temps pascal, ant. 2. »
            if ma:
                cur = ["antienne", int(ma.group(1)), var, []]; out.append(cur); var = None; continue
            if re.search(r"Benedictus|Magnificat|cantique", t):
                cur = ["evangelique", None, var, []]; out.append(cur); var = None; continue
            reste = re.sub(r"^[^:]*:\s*", "", t) if ":" in t else ""
            if cur and reste: cur[3].append(reste)
            continue
        if m:
            cur = ["antienne", int(m.group(1)), var, [m.group(2)] if m.group(2) else []]; out.append(cur); var = None; continue
        if re.match(r"^Ant\. (du|au) (Benedictus|Magnificat|Nunc|cantique)", t) or re.match(r"^Antienne (du|au) (Benedictus|Magnificat|cantique)", t):
            cur = ["evangelique", None, var, []]; out.append(cur); var = None; continue
        if re.match(r"^Répons bref", t):
            cur = ["repons", None, var, []]; out.append(cur); var = None; continue
        if re.fullmatch(r"HYMNE", t):
            cur = ["hymne", None, var, []]; out.append(cur); var = None; continue
        if re.match(r"^(PSAUME|CANTIQUE|LECTURE|Lecture|INTERCESSION|Prière|Oraison|Oraison|Notre Père|AUX |À L|On se signe|Cantique )", t):
            cur = None; continue
        if t.upper() == t and len(t) > 6 and re.search(r"[A-Z]{4}", t):   # titre de psaume en capitales : fin du texte
            cur = None; continue
        if cur is not None and len(cur[3]) < 16:
            cur[3].append(t.replace("®", "R/").replace("£", "V/"))
    def joindre(ls):
        t = " ".join(x for x in ls if x).strip()
        return re.sub(r"(\w)- (\w)", r"\1\2", t)
    return [(r, n, v, joindre(ls)) for r, n, v, ls in out if any(ls)]


def traduire(res, pdf):
    pages = subprocess.run(["pdftotext", "-layout", str(pdf), "-"], capture_output=True, text=True).stdout.split("\f")
    cache = {}
    for r in res:
        if r["role"] not in ("antienne", "repons", "evangelique", "hymne"):
            continue
        p = r["page"]
        for q in (p + 1, p - 1):                 # page française en regard
            if q not in cache and 0 < q <= len(pages):
                cache[q] = items_fr(pages[q - 1])
            libres = [it for it in cache.get(q, []) if it[0] == r["role"] and (r["rang"] is None or it[1] == r["rang"]) and not it[4:]]
            if not libres:
                continue
            it = next((x for x in libres if x[2] == r.get("variante")), None)   # variante exacte, sinon pas de texte
            if it is None:
                continue
            r["texte"] = it[3][:600]
            cache[q][cache[q].index(it)] = it + (True,)
            break


def main():
    out = []
    for n in (1, 2, 3):
        if (RACINE / "partitions" / f"hg{n}" / "pieces.json").exists():
            r = indexer(n)
            traduire(r, SRC / f"Tome {'I' * n}.pdf")
            out += r
            from collections import Counter
            print(f"tome {n} : {len(r)} pièces ; rôles {Counter(x['role'] for x in r)} ; sans clé {sum(1 for x in r if not x['cle'])}")
    d = RACINE / "partitions" / "hg"
    d.mkdir(exist_ok=True)
    (d / "index.json").write_text(json.dumps(out, ensure_ascii=False, indent=0), encoding="utf-8")


if __name__ == "__main__":
    main()
