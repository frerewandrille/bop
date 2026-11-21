"""Ordo des carnets du sanctoral → partitions/ordo.json

    python3 outils/construire_ordo.py "<dossier des carnets>" [--rapport]

Les carnets « Sanctoral » de la Province donnent, fête par fête, ce qu'on chante à chaque office :
  - l'hymne (notée sur la page de l'office, ou renvoi « Hymne p. 22 ») ;
  - le lucernaire, l'invitatoire (renvois) ;
  - une antienne au-dessus de chaque étiquette « Psaume 62 & AT 49 » ;
  - le cantique du Nouveau Testament, le répons, le Te Deum (renvois « p. N »).
Ce programme lit ces indications (texte du PDF + pièces découpées par decouper_partitions.py)
et écrit, pour chaque fête et chaque office, la liste ordonnée des partitions à afficher.

Clés : « MM-JJ » (date de la fête), ou « trinite », « saint-sacrement », « sacre-coeur », « christ-roi ».
Offices : laudes, vepres (jour de la fête), vepres1 (veille), lectures (vigiles).

Les corrections à la main se font dans partitions/corrections.json (voir docs/CORRIGER-UNE-PARTITION.md),
jamais dans ordo.json, qui est réécrit à chaque exécution.
"""
from __future__ import annotations
import html
import json
import re
import subprocess
import sys
import unicodedata
from pathlib import Path

ICI = Path(__file__).resolve().parent
RACINE = ICI.parent
DPI = 110
CARNETS = {
    "sanctoral1": "Sanctoral-sept-jan.pdf",
    "sanctoral2": "Sanctoral-Fév-Août.pdf",
}
MOIS = {"janvier": 1, "fevrier": 2, "mars": 3, "avril": 4, "mai": 5, "juin": 6, "juillet": 7, "aout": 8,
        "septembre": 9, "octobre": 10, "novembre": 11, "decembre": 12}
MOBILES = [(r"sainte trinite", "trinite"), (r"saint-sacrement", "saint-sacrement"), (r"sacre-c(œ|oe)ur", "sacre-coeur"),
           (r"christ roi", "christ-roi")]
ROM = {"VI": 6, "VII": 7, "VIII": 8, "XI": 11, "XII": 12, "XIII": 13, "XIV": 14}


def sa(s: str) -> str:
    s = unicodedata.normalize("NFD", s)
    return "".join(c for c in s if not unicodedata.combining(c)).lower().replace("’", "'").replace("œ", "oe")


def lignes_pdf(pdf: Path):
    """{page: [(y, texte)]} — lignes de texte du PDF, y en pixels à DPI."""
    t = subprocess.run(["pdftotext", "-bbox", str(pdf), "-"], capture_output=True, text=True).stdout
    pages, p, k = {}, 0, DPI / 72
    for l in t.split("\n"):
        if "<page " in l:
            p += 1; pages[p] = []
        m = re.search(r'xMin="([\d.]+)" yMin="([\d.]+)" xMax="([\d.]+)" yMax="([\d.]+)">(.*)</word>', l)
        if m and p:
            pages[p].append((float(m.group(2)) * k, float(m.group(1)) * k, float(m.group(4)) * k, html.unescape(m.group(5))))
    out = {}
    for p, mots in pages.items():
        mots.sort()
        ls = []
        for y, x, y1, mot in mots:
            if ls and abs(ls[-1][0] - y) < 9:
                ls[-1][2].append((x, mot)); ls[-1][1] = max(ls[-1][1], y1)
            else:
                ls.append([y, y1, [(x, mot)]])
        res = []
        for y, y1, ms in ls:
            t = " ".join(m for _, m in sorted(ms))
            t = re.sub(r"\b(I|II)\s*(res|es)\b\s*", lambda m: m.group(1) + m.group(2) + " ", t)
            t = re.sub(r"\b1\s*er\b", "1er", t)
            t = re.sub(r"^(Vêpres.*?)\s+(I|II)\s+(res|es)$", r"\2\3 \1", t)
            if t.strip() in ("res", "es", "er", "re", "e"): continue       # exposant isolé
            res.append((y, y1, t))
        out[p] = res
    return out


SECTION = [
    (r"^(ires|1res|1eres|i) vepres\b", "office", "vepres1"),
    (r"^(iies|2es|2emes|ii) vepres\b", "office", "vepres"),
    (r"^vepres\b", "office", "vepres"),
    (r"^laudes\b", "office", "laudes"),
    (r"^vigiles\b", "office", "lectures"),
    (r"^hymne\b(?! p\.)", "piece", "hymne"),
    (r"^lucernaire\b(?! p\.)", "piece", "lucernaire"),
    (r"^repons\b(?! p\.)", "piece", "repons"),
    (r"^invitatoires?\b(?! p\.)(?! - psaume)", "piece", "invitatoire"),
    (r"^acclamation de l'evangile", "piece", "acclamation"),
    (r"^choral\b", "piece", "choral"),
    (r"^te deum$", "piece", "tedeum"),
    (r"^antienne a magnificat", "piece", "magnificat"),
    (r"^antiennes? (complementaires|supplementaires)", "piece", "antiennes-autres"),
    (r"^antienne mariale", "piece", "mariale"),
    (r"^nt ([ivx]+)$", "annexe", "cantique"),
    (r"^lucernaire (festif|marial|pascal)", "annexe", "lucernaire"),
    (r"^cantique des (creatures|trois enfants)", "annexe", "cantique-at"),
    (r"^invitatoires des solennites", "annexe", "invitatoire"),
    (r"^(louanges|intercessions) & notre pere", "annexe", "priere"),
    (r"^(antiennes mariales|nous te saluons|sous ta misericorde|ave regina)", "annexe", "mariale"),
]
REF = re.compile(r"(Hymnes?|Lucernaire(?: & [Hh]ymne)?|Invitatoire(?: - Psaume 94)?|R[ée]pons(?: \d)?|Te Deum|Magnificat|Antiennes et psaumes|Psalmodie|Antiennes|Ev\.)"
                 r"\s*(?:\[?psaume 94\s*)?(?:p\.\s*|(?<=pons )(?=\d{2,3}$))(\d+)(?:\s*(?:s\.|ou|&|et)\s*(?:p\.\s*)?(\d+)?)?", re.I)
ROLE_REF = {"hymne": "hymne", "hymnes": "hymne", "lucernaire": "lucernaire", "invitatoire": "invitatoire", "repons": "repons",
            "te deum": "tedeum", "magnificat": "magnificat", "antiennes et psaumes": "psalmodie", "psalmodie": "psalmodie",
            "antiennes": "psalmodie", "ev.": "acclamation"}


def ids_psaume(t: str) -> list[str]:
    sys.path.insert(0, str(ICI))
    from decouper_partitions import ids_etiquette
    return ids_etiquette(t)


def lire_carnet(code: str, pdf: Path):
    """Suite ordonnée des événements du carnet : lignes de texte et pièces (images), page par page."""
    lignes = lignes_pdf(pdf)
    pieces = json.loads((RACINE / "partitions" / code / "pieces.json").read_text())
    par_page = {}
    for x in pieces:
        if x.get("nature") in ("image", "titre"): continue        # gravures, lignes de titre
        par_page.setdefault(x["page"], []).append(x)
    n = max(lignes)
    imprime = {}     # numéro imprimé → page du PDF
    ev = []
    h = 1286
    INDIC = re.compile(r"^(Psaumes?\b|Ps\.? ?\d|&\s*NT|R[ée]pons p\.|Hymnes? p\.|Lucernaire p\.|Cantique NT|ou$|\[)")
    for p in range(1, n + 1):
        ls = lignes.get(p, [])
        for y, y1, t in ls:
            if re.fullmatch(r"\d{1,3}", t.strip()) and y > h * 0.9:
                imprime.setdefault(int(t), p)
        items = [("t", y, t.strip()) for y, y1, t in ls if t.strip() and not (re.fullmatch(r"\d{1,3}", t.strip()) and y > h * 0.9) and "Tapez" not in t]
        zones = [(x["y0"], x["y1"]) for x in par_page.get(p, [])]
        # le texte pris dans une image de partition (paroles saisies par-dessus) n'est pas une indication,
        # sauf l'étiquette du psaume placée à côté du ton
        titre = lambda t: len(t) < 70 and any(re.search(m, sa(t)) for m, _, _ in SECTION)
        items = [it for it in items if INDIC.match(it[2]) or titre(it[2]) or it[1] < 200 or not any(a + 14 < it[1] < b - 14 for a, b in zones)]
        # un titre pris dans le haut d'une image (l'image déborde au-dessus du titre) passe avant elle
        def avance(it):
            z = next((a for a, b in zones if a <= it[1] < b), None)
            return ("t", z - 1 - (400 - it[1]) / 1000, it[2]) if z is not None and it[1] < 400 and (titre(it[2]) or it[1] < 200) else it
        items = [avance(it) for it in items]
        items += [("p", x["y0"], x) for x in par_page.get(p, [])]
        items.sort(key=lambda it: it[1])
        for k, y, v in items:
            ev.append((p, k, v, y))
    return ev, imprime, n


def analyser(code: str, pdf: Path):
    ev, imprime, n = lire_carnet(code, pdf)
    fetes = {}        # clé → {nom, page}
    sections = []     # {genre, quoi, titre, page, fete, items, pages}
    fete = None
    cur = None
    attente_nom = None
    for p, k, v, y in ev:
        if k == "t":
            t = sa(v)
            m = re.fullmatch(r"(\d{1,2})(?:er)? (janvier|fevrier|mars|avril|mai|juin|juillet|aout|septembre|octobre|novembre|decembre)", t)
            if t.startswith(("sommaire", "index alphabetique")) and p > n * 0.6:
                break
            if t.startswith("annexes") and p > n * 0.6:
                fete, cur = None, None
                continue
            if m:
                cle = f"{MOIS[m.group(2)]:02d}-{int(m.group(1)):02d}"
                if cur is not None and cur["genre"] == "annexe":
                    continue          # « Saint Joseph (19 mars) » dans les invitatoires
                fete = fetes.setdefault(cle, {"cle": cle, "nom": "", "page": p, "carnet": code})
                attente_nom = fete if not fete["nom"] else None
                cur = None
                continue
            mob = next((c for r, c in MOBILES if re.search(r, t)), None)
            if mob and re.search(r"^(la |le |34e )", t) and " - " not in t and not REF.search(v) and not (cur and cur["genre"] == "annexe"):
                f = fetes.setdefault(mob, {"cle": mob, "nom": v, "page": p, "carnet": code})
                if f is not fete:
                    fete, cur = f, None
                attente_nom = f if len(f["nom"]) < 18 else None
                if mob == "christ-roi": f["nom"], attente_nom = "Le Christ Roi de l'univers", None
                continue
            sec = None
            if len(v) < 70 and not re.match(r"^\d+\.", v):
                for motif, genre, quoi in SECTION:
                    if re.search(motif, t):
                        sec = (genre, quoi); break
            if sec and sec[0] == "piece" and cur is not None and cur["genre"] == "office" and cur["page"] == p and sec[1] in ("hymne", "invitatoire", "lucernaire"):
                cur["items"].append({"t": "marque", "role": sec[1], "page": p})
                continue
            if sec:
                attente_nom = None
                genre, quoi = sec
                cur = {"genre": genre, "quoi": quoi, "titre": v, "page": p, "fete": fete["cle"] if fete and genre != "annexe" else None,
                       "carnet": code, "items": [], "pages": [p]}
                if genre == "annexe":
                    fete = None
                    mm = re.search(r"^nt ([ivx]+)$", t)
                    if mm: cur["nt"] = ROM.get(mm.group(1).upper())
                sections.append(cur)
                continue
            if attente_nom is not None and not REF.search(v) and not re.match(r"^(Psaume|ou$|\[)", v) and len(v) < 60:
                attente_nom["nom"] = (attente_nom["nom"] + " " + v).strip()
                continue
            attente_nom = None
            if cur is None:
                continue
            if p not in cur["pages"]: cur["pages"].append(p)
            if re.fullmatch(r"ou( bien)?", t):
                d = cur["items"][-1] if cur["items"] else None
                if d and d["t"] == "img" and d["page"] == p and d["y0"] + 20 < y < d["y1"] - 20:
                    continue      # « ou » pris dans une image qui porte les deux antiennes au choix
                cur["items"].append({"t": "ou", "page": p}); continue
            if re.match(r"^\[ ?autres? antiennes?", t) or re.match(r"^antiennes ad libitum", t):
                cur["items"].append({"t": "ou", "page": p, "libre": True}); continue
            if cur["genre"] != "office":
                continue
            # étiquette de psaume d'abord, puis cantique NT, puis renvois (ordre de la ligne)
            est_ps = bool(re.match(r"^(Psaumes?|Ps\.?)\b|^&\s*NT|^AT\s*\d", v) or re.search(r"\bPsaumes? [\d(]", v)) and not re.match(r"^Invitatoire", v)
            if est_ps:
                dernier = cur["items"][-1] if cur["items"] else None
                ids_l = ids_psaume(v if v.startswith("Ps") else "Psaume " + v)
                if dernier and dernier["t"] == "img" and dernier.get("etiq") and dernier["page"] == p and (dernier["etiq"].strip() == v.strip() or set(ids_l) <= set(dernier["ids"])):
                    pass        # étiquette déjà portée par la pièce
                elif dernier and dernier["t"] == "img" and dernier["page"] == p and dernier["y0"] + 20 < y < dernier["y1"] - 20 and ids_l:
                    dernier["ids"] = ids_l + [i for i in dernier.get("ids", []) if i not in ids_l]      # l'image porte deux antiennes
                    dernier.setdefault("etiq", v)
                else:
                    cur["items"].append({"t": "ps", "txt": v, "ids": ids_psaume(v if v.startswith("Ps") else "Psaume " + v), "page": p,
                                         "ferie": "férie" in v})
            for mm in re.finditer(r"\bNT\s+([IVX]+)\b", v):
                if ROM.get(mm.group(1)): cur["items"].append({"t": "nt", "nt": ROM[mm.group(1)], "page": p})
            for mm in REF.finditer(v):
                nom = sa(re.sub(r"\s*\d$", "", re.sub(r"\s*(-|&).*", "", mm.group(1)))).strip()
                role = ROLE_REF.get(nom)
                if not role: continue
                nums = [int(x) for x in (mm.group(2), mm.group(3)) if x]
                cur["items"].append({"t": "ref", "role": role, "p": nums, "suite": bool(re.search(r"p\.\s*\d+\s*s\.", mm.group(0))), "page": p, "txt": mm.group(0)})
                if "& hymne" in sa(mm.group(1)):
                    cur["items"].append({"t": "ref", "role": "hymne", "p": nums[1:] or nums, "page": p, "txt": mm.group(0)})
        else:
            if cur is None:
                continue
            if p not in cur["pages"]: cur["pages"].append(p)
            it = {"t": "img", "f": f"{code}/{v['fichier']}", "page": p, "y0": v["y0"], "y1": v["y1"]}
            if cur["genre"] == "office" and ids_psaume(v["dessous"]) and not re.match(r"^Invitatoire", v["dessous"]):
                it["ids"], it["etiq"] = ids_psaume(v["dessous"]), v["dessous"]
                # plusieurs pièces au-dessus de la même étiquette : seule la dernière est l'antienne de ce psaume
                d = cur["items"][-1] if cur["items"] else None
                if d and d["t"] == "img" and d["page"] == p and d.get("etiq") == it["etiq"]:
                    d.pop("ids"); d.pop("etiq")
            cur["items"].append(it)
    return fetes, sections, imprime


PS = ("antiennes", "psaume", "renvoi-psalmodie")


def classer(s):
    """Pièces d'un office, dans l'ordre, avec leur rôle ; les renvois restent à résoudre (genre « ref »)."""
    sortie, tampon = [], []
    libre = False
    avant_ou = None        # pièce placée avant un « ou » : même rôle que la pièce qui suit
    apres_inv = False
    marque = None          # « Hymne », « Invitatoire » écrits sur la page de l'office : rôle des images qui suivent
    def psalmodie_commencee():
        return any(x["role"] in PS for x in sortie)
    def vider(role=None):
        nonlocal tampon
        if tampon: sortie.append({"role": role or marque or ("antiennes" if libre else "?"), "f": tampon, "libre": libre})
        tampon = []
    def antienne(fs, ids, txt):
        nonlocal avant_ou
        if avant_ou:
            sortie.append({"role": "antiennes", "f": [avant_ou], "ids": ids, "txt": txt, "libre": libre})
            sortie.append({"role": "antiennes", "f": fs, "ids": ids, "txt": txt, "alt": True, "libre": libre})
            avant_ou = None
        elif sortie and sortie[-1]["role"] == "ou":
            sortie.pop(); sortie.append({"role": "antiennes", "f": fs, "ids": ids, "txt": txt, "alt": True, "libre": libre})
        else:
            sortie.append({"role": "antiennes", "f": fs, "ids": ids, "txt": txt, "libre": libre})
    def prendre_antienne(f):
        """Images de l'antienne close par une étiquette : la dernière, et celles qui la précèdent une fois la psalmodie commencée."""
        nonlocal tampon, marque
        if (psalmodie_commencee() or avant_ou) and not marque:
            fs, tampon = tampon + [f], []
        else:
            vider(); fs = [f]
        marque = None
        return fs
    for it in s["items"]:
        if it["t"] == "img" and it.get("ids"):
            antienne(prendre_antienne(it["f"]), it["ids"], it["etiq"])
        elif it["t"] == "img":
            if apres_inv:       # l'antienne d'invitatoire : la première image après le renvoi
                sortie.append({"role": "invitatoire", "f": [it["f"]]}); apres_inv = False
            else:
                tampon.append(it["f"])
        elif it["t"] == "marque":
            vider(); marque = it["role"]
        elif it["t"] == "ou":
            if it.get("libre"):
                vider(); libre = True
            elif tampon:
                avant_ou = tampon.pop(); vider()
            elif sortie and sortie[-1]["role"] == "antiennes":
                sortie.append({"role": "ou"})       # antienne déjà étiquetée, suivie d'une autre au choix
        elif it["t"] == "ps":
            deja = next((x for x in reversed(sortie) if x["role"] == "antiennes"), None)
            if not tampon and deja and it["ids"] and set(it["ids"]) <= set(deja.get("ids", [])):
                continue                                # étiquette répétée
            if tampon and not re.match(r"^Psaumes de la f", it["txt"]):
                f = tampon.pop()
                antienne(prendre_antienne(f), it["ids"], it["txt"])
            else:
                vider()
                if avant_ou: sortie.append({"role": "?", "f": [avant_ou], "libre": libre}); avant_ou = None
                sortie.append({"role": "psaume", "ids": it["ids"], "txt": it["txt"], "ferie": it.get("ferie", False)})
        elif it["t"] in ("ref", "nt"):
            vider()
            sortie.append({"role": "ref", "ref": it})
            apres_inv = it["t"] == "ref" and it["role"] == "invitatoire"
    if avant_ou:
        sortie.append({"role": "?", "f": [avant_ou], "libre": libre})
        if tampon: sortie.append({"role": "?", "f": tampon, "alt": True, "libre": libre}); tampon = []
    vider()
    sortie = [x for x in sortie if x["role"] != "ou"]
    reels = [k for k, x in enumerate(sortie) if x["role"] in PS or (x["role"] == "ref" and x["ref"].get("role") == "psalmodie")]
    premier = reels[0] if reels else len(sortie)
    dernier = reels[-1] if reels else -1
    vep = s["quoi"].startswith("vepres")
    for k, x in enumerate(sortie):
        if x["role"] != "?": continue
        if k < premier: x["role"] = "hymne"
        elif k > dernier: x["role"] = "magnificat" if vep else "benedictus"
        else: x["role"] = "antiennes"; x["ids"] = []
    return sortie


def construire(dossier: Path):
    ordo, notes = {}, []
    for code, fichier in CARNETS.items():
        pdf = dossier / fichier
        if not pdf.exists() or not (RACINE / "partitions" / code / "pieces.json").exists():
            notes.append(f"{code} : carnet ou découpage absent"); continue
        fetes, sections, imprime = analyser(code, pdf)
        for s in sections:
            if s["genre"] == "office":
                s["classe"] = classer(s)

        def page_de(num):
            if num in imprime: return imprime[num]
            k = min(imprime, key=lambda k: abs(k - num))
            return imprime[k] + (num - k)

        def images(s2):
            f = [it["f"] for it in s2["items"] if it["t"] == "img"]
            if not f and s2["genre"] in ("piece", "annexe") and not (s2["quoi"] == "acclamation"):
                f = [f"{code}/p-{q:03d}.jpg" for q in s2["pages"]]      # rien de découpé : les pages entières
            return f

        def cible(role, num, origine):
            """Pièces visées par « <role> p. num »."""
            pg = page_de(num)
            cands = []          # (pages, pièces, titre, fête)
            for s2 in sections:
                if s2["genre"] in ("piece", "annexe") and (s2["quoi"] == role or {s2["quoi"], role} == {"hymne", "lucernaire"} or (role == "hymne" and s2["quoi"] == "choral")):
                    cands.append((s2["pages"], images(s2), s2["titre"], s2["fete"], s2["quoi"] == role))
                elif s2["genre"] == "office" and role in ("hymne", "lucernaire") and s2 is not origine:
                    f = [y for x in s2["classe"] if x["role"] == "hymne" and "f" in x for y in x["f"]]
                    pp = sorted({int(x.split("/s-")[1][:3]) for x in f})
                    if f: cands.append((pp, f, f"{s2['titre']} ({fetes[s2['fete']]['nom'] if s2['fete'] else ''})".replace(" ()", ""), s2["fete"], True))
                elif s2["genre"] == "office" and role in ("magnificat",) and s2 is not origine:
                    f = [y for x in s2["classe"] if x["role"] == "magnificat" and "f" in x for y in x["f"]]
                    if f: cands.append((sorted({int(x.split("/s-")[1][:3]) for x in f}), f, s2["titre"], s2["fete"], True))
            cands = [c for c in cands if c[1]]
            def avant(c):      # écart vers l'avant (pages ajoutées après coup : les renvois imprimés sont en retard)
                d = [q - pg for q in c[0] if q >= pg]
                return min(d) if d else 99
            for exact_role in (True, False):
                cs = [c for c in cands if c[4] == exact_role]
                dedans = [c for c in cs if pg in c[0]]
                if dedans: return sorted(dedans, key=lambda c: c[0][0] != pg)[0]
                pres = sorted(cs, key=avant)
                if pres and avant(pres[0]) <= 8:
                    if avant(pres[0]) >= 2 or not exact_role:
                        notes.append(f"{code} p. {origine['page']} « {origine['titre']} » : « {role} p. {num} » pris pour « {pres[0][2]} » (p. {pres[0][0][0]} du PDF)")
                    return pres[0]
            arriere = sorted(cands, key=lambda c: min(abs(q - pg) for q in c[0]))
            if arriere and min(abs(q - pg) for q in arriere[0][0]) <= 4:
                notes.append(f"{code} p. {origine['page']} « {origine['titre']} » : « {role} p. {num} » pris, faute de mieux, pour « {arriere[0][2]} » (p. {arriere[0][0][0]} du PDF) — À VÉRIFIER")
                return arriere[0]
            if role != "acclamation":
                notes.append(f"{code} p. {origine['page']} « {origine['titre']} » : renvoi « {role} p. {num} » INTROUVABLE")
            return None

        for s in sections:
            if s["genre"] != "office" or not s["fete"]:
                continue
            f = fetes[s["fete"]]
            sortie = []
            for x in s["classe"]:
                if x["role"] != "ref":
                    sortie.append(x); continue
                x = x["ref"]
                if x["t"] == "nt":
                    c = next((s2 for s2 in sections if s2.get("nt") == x["nt"]), None)
                    if c: sortie.append({"role": "cantique", "f": images(c), "titre": f"Cantique NT {x['nt']}", "nt": x["nt"]})
                    else: notes.append(f"{code} p. {s['page']} : cantique NT {x['nt']} absent des annexes")
                    continue
                role = x["role"]
                if role == "psalmodie":
                    pg = page_de(x["p"][0])
                    fam = lambda q: "vepres" if q.startswith("vepres") else q
                    cs = [s2 for s2 in sections if s2["genre"] == "office" and s2 is not s and fam(s2["quoi"]) == fam(s["quoi"]) and any(0 <= q - pg <= 8 for q in s2["pages"])]
                    c = min(cs, key=lambda s2: min(q - pg for q in s2["pages"] if q >= pg)) if cs else None
                    if c:
                        sortie += [dict(y, renvoi=True) for y in c["classe"] if y["role"] in PS and y["role"] != "renvoi-psalmodie"]
                    else: notes.append(f"{code} p. {s['page']} « {s['titre']} » : psalmodie p. {x['p'][0]} INTROUVABLE")
                    continue
                pris = []
                for k, num in enumerate(x["p"]):
                    c = cible(role, num, s)
                    if c and c[1] in pris:
                        # « p. 130 ou 132 », renvois en retard d'une page : la pièce suivante de même rôle
                        suiv = [s2 for s2 in sections if s2["genre"] == "piece" and s2["quoi"] == role and s2["pages"][0] > c[0][0] and images(s2) not in pris]
                        c = (suiv[0]["pages"], images(suiv[0]), suiv[0]["titre"], suiv[0]["fete"], True) if suiv and suiv[0]["pages"][0] - c[0][-1] <= 3 else None
                    if not c: continue
                    pris.append(c[1])
                    sortie.append({"role": role, "f": c[1], "titre": c[2], "alt": k > 0})
                    if x.get("suite"):
                        # « p. 28 s. » : les pièces suivantes de même rôle de la même fête
                        suiv = [s2 for s2 in sections if s2["genre"] == "piece" and s2["quoi"] == role and s2["fete"] == c[3] and s2["pages"][0] > c[0][0]]
                        for s2 in suiv:
                            if images(s2) != c[1]: sortie.append({"role": role, "f": images(s2), "titre": s2["titre"], "alt": True})
            e = ordo.setdefault(f["cle"], {"nom": f["nom"], "carnet": code, "page": f["page"], "offices": {}})
            if s["quoi"] in e["offices"]:
                e["offices"][s["quoi"]]["pieces"] += sortie
            else:
                e["offices"][s["quoi"]] = {"titre": s["titre"], "page": s["page"], "pieces": sortie}
        for s in sections:
            if s["genre"] == "piece" and s["fete"] and s["fete"] in fetes:
                e = ordo.setdefault(s["fete"], {"nom": fetes[s["fete"]]["nom"], "carnet": code, "page": fetes[s["fete"]]["page"], "offices": {}})
                e.setdefault("propres", []).append({"role": s["quoi"], "f": images(s), "titre": s["titre"], "page": s["page"]})
        for cle, f in fetes.items():
            ordo.setdefault(cle, {"nom": f["nom"], "carnet": code, "page": f["page"], "offices": {}})
        ordo.setdefault("_annexes", {})[code] = [{"role": s["quoi"], "f": images(s), "titre": s["titre"], "page": s["page"], **({"nt": s["nt"]} if s.get("nt") else {})}
                                                 for s in sections if s["genre"] == "annexe"]
    return ordo, notes


def completer(ordo, notes):
    """Complète chaque office par les pièces propres de la fête qu'il ne cite pas."""
    for cle, e in ordo.items():
        if cle.startswith("_"): continue
        propres = e.get("propres", [])
        for nom, o in e["offices"].items():
            roles = {x["role"] for x in o["pieces"]}
            for role in ("invitatoire", "lucernaire", "hymne", "repons", "magnificat", "choral", "tedeum", "acclamation"):
                if role in roles: continue
                if role == "invitatoire" and nom not in ("lectures", "laudes"): continue
                if role in ("lucernaire", "magnificat") and not nom.startswith("vepres"): continue
                if role in ("choral", "tedeum", "acclamation") and nom != "lectures": continue
                for k, x in enumerate([x for x in propres if x["role"] == role and x["f"]]):
                    o["pieces"].append({"role": role, "f": x["f"], "titre": x["titre"], "alt": k > 0, "deduit": True})
    return ordo


def retoucher(ordo, notes):
    """Cas que la mise en page des carnets ne permet pas de lire automatiquement (vérifiés à l'œil sur les pages)."""
    # 2 octobre, Anges gardiens : laudes et vêpres sur la même page ; l'antienne des vêpres (Ps 33 I et II) est en deux images
    e = ordo.get("10-02")
    if e and "vepres" in e["offices"] and "laudes" in e["offices"]:
        hymnes = [dict(x) for x in e["offices"]["laudes"]["pieces"] if x["role"] == "hymne"]
        nt = [x for x in e["offices"]["vepres"]["pieces"] if x["role"] == "cantique" and x.get("nt") == 12]
        rep_ = [x for x in e["offices"]["vepres"]["pieces"] if x["role"] == "repons"]
        e["offices"]["vepres"]["pieces"] = hymnes + [{"role": "antiennes", "f": ["sanctoral1/s-082-1.jpg", "sanctoral1/s-082-2.jpg"], "ids": ["33"],
                                                      "txt": "Psaume 33, 2-11 & 33, 12-23"}] + nt + rep_
    # 8 novembre : « Voir au 2 novembre »
    if "11-02" in ordo and "11-08" in ordo and not ordo["11-08"]["offices"]:
        ordo["11-08"]["offices"] = ordo["11-02"]["offices"]
        ordo["11-08"]["nom"] = "Anniversaire de tous les frères et sœurs défunts de l'Ordre des Prêcheurs"
        ordo["11-08"]["comme"] = "11-02"
    # fêtes du temps de Noël : dans le livret de Noël, pas dans le sanctoral
    for k in ("12-26", "12-27", "12-28", "01-01"):
        if k in ordo and not ordo[k]["offices"]: del ordo[k]
    return ordo


ORDRE = ["invitatoire", "lucernaire", "hymne", "antiennes", "psaume", "renvoi-psalmodie", "cantique", "repons", "acclamation",
         "benedictus", "magnificat", "tedeum", "choral", "priere"]


def ecrire_rapport(ordo, notes, sortie: Path):
    L = ["# Offices du sanctoral relevés dans les carnets", "",
         "Une ligne par pièce : rôle, titre ou psaume, fichiers. « ou » = pièce au choix ; « (déduit) » = pièce propre de la fête,",
         "non citée par la page de l'office.", ""]
    for cle in sorted(k for k in ordo if not k.startswith("_")):
        e = ordo[cle]
        L.append(f"## {cle} — {e['nom']}  ({e['carnet']}, p. {e['page']})")
        for nom in ("vepres1", "lectures", "laudes", "vepres"):
            o = e.get("offices", {}).get(nom)
            if not o: continue
            L.append(f"- **{nom}** (p. {o['page']})")
            for x in o["pieces"]:
                det = x.get("titre") or x.get("txt") or ""
                fs = ", ".join(y.split("/")[1].replace(".jpg", "") for y in x.get("f", [])) or "—"
                L.append(f"    - {'ou ' if x.get('alt') else ''}{x['role']}{' (déduit)' if x.get('deduit') else ''}{' (renvoi)' if x.get('renvoi') else ''}{' (au choix)' if x.get('libre') else ''} : {det} → {fs}")
        L.append("")
    if notes:
        L += ["## Notes", ""] + [f"- {n}" for n in notes]
    sortie.write_text("\n".join(L), encoding="utf-8")


if __name__ == "__main__":
    dossier = Path(sys.argv[1])
    ordo, notes = construire(dossier)
    ordo = retoucher(completer(ordo, notes), notes)
    import ordo_noel
    ordo = ordo_noel.ajouter(ordo, notes)
    import ordo_sept_jan                       # carnet sept-jan et propre de l'Ordre : depuis les .docx (le PDF de 2024 est périmé)
    ordo = ordo_sept_jan.appliquer(ordo, notes)
    (RACINE / "partitions" / "ordo.json").write_text(json.dumps(ordo, ensure_ascii=False, indent=0), encoding="utf-8")
    ecrire_rapport(ordo, notes, RACINE / "partitions" / "ordo-rapport.md")
    nf = len([k for k in ordo if not k.startswith("_")])
    no = sum(len(e["offices"]) for k, e in ordo.items() if not k.startswith("_"))
    print(f"{nf} fêtes, {no} offices → partitions/ordo.json ; rapport : partitions/ordo-rapport.md ; {len(notes)} note(s)")
