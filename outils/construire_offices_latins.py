"""Offices latin-français tirés des « Heures grégoriennes » (3 tomes, page latine / page française en regard).

    python3 outils/construire_offices_latins.py
      → partitions/hg/offices.json : {"<clé>|<office>": [élément, …]}

Élément : {t: hymne|antienne|psaume|lecture|repons|evangelique|preces|oraison|texte,
           n: rang (antiennes), v: variante, la: [lignes], fr: [lignes], tla, tfr: titres, ref,
           partitions: [fichiers]}
Une ligne = [retrait, html] ; dans le français, les voyelles marquées pour le chant sont en gras.

Le texte vient de Ghostscript (txtwrite), qui garde les codes des lettres marquées que pdftotext perd :
    for n in I II III; do gs -q -dNOPAUSE -dBATCH -sDEVICE=txtwrite \
        -sOutputFile="sources_gouzes/heures-gregoriennes/gs/gs-$n-%04d.txt" "…/Tome $n.pdf"; done
Usage privé (« Tous droits réservés ») : le résultat reste dans partitions/, publié seulement derrière
le mot de passe du site.
"""
from __future__ import annotations
import collections
import difflib
import glob
import html
import json
import re
import sys
from pathlib import Path

ICI = Path(__file__).resolve().parent
RACINE = ICI.parent
sys.path.insert(0, str(ICI))
from indexer_heures_gregoriennes import cle_jour, OFFICES, ROM, CHIF  # noqa: E402

GS = RACINE / "sources_gouzes" / "heures-gregoriennes" / "gs"
JOUR_TITRE = {"DOMINICA": "dimanche", "FERIA SECUNDA": "lundi", "FERIA TERTIA": "mardi", "FERIA QUARTA": "mercredi",
              "FERIA QUINTA": "jeudi", "FERIA SEXTA": "vendredi", "SABBATO": "samedi"}

# ─── Lettres marquées (police « Antiphonaire ») ───
SUR = {"½": "o", "¼": "u", "Ž": "a", "¾": "â", "¦": "ô", "ª": "ë", "º": "y", "²": "î", "³": "ê", "ž": "à",
       "∑": "A", "−": "û", "Ω": "œ"}
# e marqués : le dessin du glyphe ne dit pas sûrement s'il s'agit de e, é, è ou ê (« bénissèz », « tèrre »…) ;
# la première lettre est la lecture par défaut, les autres sont essayées et départagées par le vocabulaire (17/11/2026)
AMBIGUS = {"\x01": "eiéè", "\x03": "eiéè", "\x04": "eiéè", "\x06": "éièe",
           "\x02": "èeéêi", "\x07": "èeéêi", "\x05": "éeèêi", "\x08": "eèéêi",
           "\ue001": "ïeèéi", "\ue002": "eèéi", "\ue003": "eèéi"}   # tabulation et \x0b : remplacées avant le découpage en mots
LATIN = {"∆": "ǽ", "∂": "œ́", "◊": "ý", "´": ""}
ENLEVER = "→π\r"
MARQUES = set(SUR) | set(AMBIGUS)


def lire_pages(tome: str) -> dict[int, list[str]]:
    out = {}
    for f in sorted(glob.glob(str(GS / f"gs-{tome}-*.txt"))):
        n = int(re.search(r"-(\d+)\.txt$", f).group(1))
        # \x0c est une lettre marquée (« pr\x0cs », « ci\x0cl ») : remplacée avant le découpage en lignes
        out[n] = open(f, encoding="utf-8", errors="replace").read().replace("\x0c", "\ue003").split("\n")
    return out


def texte_json(f) -> str:
    """Toutes les chaînes d'un fichier JSON, décodées (les accents y sont parfois écrits « \\u00e9 »)."""
    out = []
    def visiter(x):
        if isinstance(x, str): out.append(x)
        elif isinstance(x, dict): [visiter(v) for v in x.values()]
        elif isinstance(x, list): [visiter(v) for v in x]
    visiter(json.load(open(f, encoding="utf-8")))
    return re.sub(r"<[^>]+>", " ", " ".join(out))


def vocabulaire(pages_toutes) -> collections.Counter:
    v = collections.Counter()
    # français de référence : Bible et psautier de la BJ déjà importés (pour départager les lettres marquées)
    for f in glob.glob(str(RACINE / "site" / "donnees" / "bible" / "*.json")) + [str(RACINE / "site" / "donnees" / "psautier.json")]:
        t = texte_json(f)
        for w in re.findall(r"[^\W\d_]+", t):
            v[w.lower()] += 1
    for pages in pages_toutes:
        for ls in pages.values():
            apres = 99
            for l in ls:
                apres += 1
                if re.match(r"^\s*(PSALMUS|CANTICUM|PSAUME|CANTIQUE)\b", l):
                    apres = 0
                if apres <= 7:                     # début de psaume : lettrines mal placées, mots coupés
                    continue
                for w in re.findall(r"[^\W\d_]+", l):
                    if not any(c in MARQUES for c in w):
                        v[w.lower()] += 1
    return v


def decoder(ligne: str, voc, francais: bool) -> str:
    """Texte → HTML ; lettres marquées en gras (français), lettres latines spéciales rétablies."""
    ligne = ligne.replace("\t", "\ue001").replace("\x0b", "\ue002")
    for c in ENLEVER:
        ligne = ligne.replace(c, "")
    ligne = ligne.replace("", "✠").replace("ﬁ", "fi").replace("ﬂ", "fl").replace("ƒ", "ffi")
    for k, v in LATIN.items():
        ligne = ligne.replace(k, v)
    ligne = ligne.replace("®", "R/ ").replace("£", "V/ ")
    ligne = re.sub(r"(R/|V/)\s+", r"\1 ", ligne)
    # mots contenant des marques : choix des lettres ambiguës par le vocabulaire
    def mot(m):
        w = m.group(0)
        if not any(c in MARQUES for c in w):
            return html.escape(w)
        pos = [i for i, c in enumerate(w) if c in AMBIGUS]
        meilleur, score = None, -1
        import itertools
        for choix in itertools.product(*[AMBIGUS[w[i]] for i in pos]) if pos else [()]:
            l = list(w)
            for i, c in zip(pos, choix):
                l[i] = c
            s = "".join(SUR.get(c, c) for c in l)
            # « j’élève », « Jésus-Christ » : chaque partie doit être un mot connu
            sc = min((voc.get(x.lower(), 0) for x in re.split(r"[’'-]", s) if x), default=0)
            if sc > score:
                meilleur, score = l, sc
        return "".join(f"<b>{html.escape(SUR.get(c, c))}</b>" if w[i] in MARQUES and francais else html.escape(SUR.get(c, c))
                       for i, c in enumerate(meilleur))
    return re.sub(r"[^\s,;:.!?«»()\[\]“”\"]+", mot, ligne)


# ─── En-têtes de sections ───
VAR_LA = r"(?:(Tempore paschali|Tempore Adventus|Tempore Nativitatis|Tempore Quadragesimæ|Tempore per annum|Extra tempus paschale|Anno [ABC]|Vel)[,:]?\s*)?"
VAR_FR = r"(?:((?:Au )?[Tt]emps pascal|(?:Au |En )?(?:[Tt]emps de l.|)Avent|(?:Au )?[Tt]emps de Noël|(?:En |Au temps du |Temps du )?Carême|(?:Au )?[Tt]emps ordinaire|Hors du temps pascal|Année [ABC]|Ou bien)[,:]?\s*)?"
TETES = {
    "la": [("hymne", re.compile(r"^" + VAR_LA + r"HYMNUS$")),
           ("antienne", re.compile(r"^" + VAR_LA + r"[Aa]nt\.\s*(\d)?\.?$")),
           ("psaume", re.compile(r"^(PSALMUS\s+\d.*|CANTICUM\b.*)$")),
           ("lecture", re.compile(r"^Lectio brevis(?:\s+(?:Cf\.\s*)?([1-3]?\s?[A-Z][a-zæ]*\.?\s?\d.*))?$")),
           ("repons", re.compile(r"^" + VAR_LA + r"Responsorium breve")),
           ("evangelique", re.compile(r"^" + VAR_LA + r"Ad (Benedictus|Magnificat|Nunc dimittis),? ant\.?:?$")),
           ("preces", re.compile(r"^Preces$")),
           ("oraison", re.compile(r"^Oratio$")),
           ("versus", re.compile(r"^Versus$")),
           ("heure", re.compile(r"^Ad (Tertiam|Sextam|Nonam):?$"))],
    "fr": [("hymne", re.compile(r"^" + VAR_FR + r"HYMNE$")),
           ("antienne", re.compile(r"^" + VAR_FR + r"[Aa]nt\.\s*(\d)?\.?$")),
           ("psaume", re.compile(r"^(PSAUME\s+\d.*|CANTIQUE\b.*)$")),
           ("lecture", re.compile(r"^Lecture brève(?:\s+(?:Cf\.\s*)?([1-3]?\s?[A-Z][a-zé]*\.?\s?\d.*))?$")),
           ("repons", re.compile(r"^" + VAR_FR + r"Répons bref")),
           ("evangelique", re.compile(r"^" + VAR_FR + r"(?:Ant\.|Antienne) (?:du|au) (Benedictus|Magnificat|Nunc dimittis|cantique)")),
           ("preces", re.compile(r"^(Prières d.intercession|Intercession|Prière litanique)")),
           ("oraison", re.compile(r"^Oraison$")),
           ("versus", re.compile(r"^Verset$")),
           ("heure", re.compile(r"^À (Tierce|Sexte|None):?$"))],
}
TETES = {lg: [(t, re.compile(rx.pattern.replace(" ", r"\s*"))) for t, rx in v] for lg, v in TETES.items()}
BORNES = {"la": re.compile(r"^(" + "|".join(p for p, _ in OFFICES) + r"|" + "|".join(JOUR_TITRE) + r"|HEBDOMADA (I|II|III|IV))$"),
          "fr": re.compile(r"^(AUX? .*|À L.*|OFFICE .*|INVITATOIRE|(LUNDI|MARDI|MERCREDI|JEUDI|VENDREDI|SAMEDI|DIMANCHE)|(PREMIÈRE|DEUXIÈME|TROISIÈME|QUATRIÈME) SEMAINE)$")}
BORNES_SE = {re.sub(r"\\s|\s", "", p) for p, _ in OFFICES if "(" not in p} | {k.replace(" ", "") for k in JOUR_TITRE} | \
            {f"HEBDOMADA{x}" for x in ("I", "II", "III", "IV")} | {"ADTERTIAM", "ADSEXTAM", "ADNONAM"}
FIN = {"la": re.compile(r"^(Pater noster|Benedicamus|Conclusio|Dóminus nos benedícat|Deinde dicitur)"),
       "fr": re.compile(r"^(Notre Père|Bénissons le Seigneur|Conclusion|Que le Seigneur nous bénisse)")}

FR_MOTS = re.compile(r"\b(le|la|les|des|du|Seigneur|vous|nous|toi|sur|dans|pour|une)\b")
LA_MOTS = re.compile(r"\b(in|ad|Dóminus|Dómine|Deus|eius|tuam|tuo|sunt|nobis|quia|cum|super|tibi)\b")


def langue(ls) -> str:
    t = " ".join(ls)
    return "fr" if len(FR_MOTS.findall(t)) > len(LA_MOTS.findall(t)) else "la"


def corps(ls):
    """Lignes de la page sans l'en-tête (ligne d'imprimeur + titre courant)."""
    out = [l.rstrip() for l in ls]
    while out and not out[0].strip():
        out.pop(0)
    if out and out[0].strip().startswith("Tome "):
        out.pop(0)
    titre = out.pop(0) if out else ""
    return titre.strip(), out


def sections(ls, lg):
    """[(type, rang, variante, entete, [lignes brutes], ligne_debut)] ; type None = suite de la page précédente,
    'borne' = changement d'office ou de jour."""
    out = [[None, None, None, "", [], 0]]
    for i, l in enumerate(ls):
        t = re.sub(r"\s+", " ", l).strip()
        if not t:
            continue
        if BORNES[lg].match(t.translate(CHIF)) or (lg == "la" and t == t.upper() and sans_espace(t) in BORNES_SE):
            out.append(["borne", None, None, t, [], i]); continue
        if FIN[lg].match(t):
            out.append(["texte", None, None, "", [l], i]); continue
        for typ, rx in TETES[lg]:
            m = rx.match(t)
            if m:
                g = [x for x in m.groups()]
                var = g[0] if typ in ("hymne", "antienne", "repons", "evangelique") else None
                if typ == "heure":
                    var = {"Tertiam": "tierce", "Sextam": "sexte", "Nonam": "none", "Tierce": "tierce", "Sexte": "sexte", "None": "none"}[g[0]]
                rang = int(g[1]) if typ == "antienne" and len(g) > 1 and g[1] else None
                out.append([typ, rang, var, t, [], i]); break
        else:
            out[-1][4].append(l)
    return out


VOC = {}


def nettoyer(lignes, voc, lg):
    """Lignes brutes → [[retrait, html]] : lettrines recollées, marques isolées rattachées."""
    ls = [l.replace("\r", "") for l in lignes]
    ls = [l for l in ls if l.strip() and not re.fullmatch(r"\s*[→π\s]*", l)]
    out = []
    for k, l in enumerate(ls):
        s = l.strip()
        if s in ("†", "*"):                       # signe placé sur la ligne au-dessus du vers
            if k + 1 < len(ls):
                ls[k + 1] = ls[k + 1].rstrip() + " " + s
            continue
        out.append([len(l) - len(l.lstrip()), s])
    MAJ = "A-ZÆŒÉÈÀÂÎÔÛÇÁÍÓÚÝ"
    MIN = "a-zà-ÿæœ\x01-\x08½¼Ž¾∆"
    f = lambda w: VOC.get(w.lower(), 0)
    for x in out:
        x[1] = re.sub(r"^([A-ZÆŒ]+) ([ÁÉÍÓÚÝÀÈÊ][A-ZÆŒ]*)", r"\1\2", x[1])          # « BENED ÍCTUS »
        m = re.match(rf"^([{MAJ}]{{3,}})([{MIN}]+)(.*)$", x[1])
        if m:                                                                       # « ANTÁTEDómino », « ERBAmea »
            W, r, suite = m.groups()
            if f(W[-1] + r) > 0 and f(W[-1] + r) >= f(r):
                x[1] = f"{W[:-1]} {W[-1]}{r}{suite}"
            else:
                x[1] = f"{W} {r}{suite}"
    # lettrine : la lettre initiale est passée en tête de la ligne suivante
    # (« Vintéllege », « Lcolláuda », « G Célèbre », « L«In », « LIls »)
    for k in range(min(5, len(out) - 1)):
        m = re.match(rf"^([{MAJ}]+)(?=[\s,;:.!?’'-]|$)(.*)$", out[k][1])
        n = re.match(rf"^([{MAJ}])(.*)$", out[k + 1][1])
        if not (m and n and (re.search(rf"[{MIN}]", out[k][1]) or (k > 0 and len(m.group(1)) >= 3))):
            continue
        W, X, reste = m.group(1), n.group(1), n.group(2)
        mot = re.match(rf"^[{MIN}{MAJ}]+", reste)
        ok = (not mot and X not in "ÔÀOAY") or \
             (mot and f(mot.group(0)) > 2 * f(X + mot.group(0)) + 1) or \
             (mot and f(X + mot.group(0)) == 0 and f(mot.group(0)) > 0) or \
             (mot and f(X + mot.group(0)) == 0 and f(X + W) > 0) or \
             (len(W) >= 2 and f(X + W) > 2 * f(W))
        if ok:
            out[k][1] = X + W + m.group(2)
            out[k + 1][1] = reste.lstrip()
            break
    out = [x for x in out if x[1].strip()]
    if not out:
        return []
    base = min(r for r, _ in (out[3:] or out))
    return [[min(3, round((r - base) / 3)), decoder(s, voc, lg == "fr")] for r, s in out if s]


def titres_pdftotext(n: int) -> list[str]:
    """Titre courant de chaque page selon pdftotext (Ghostscript colle parfois les mots du titre)."""
    pages = (GS.parent / f"t{n}.txt").read_text(encoding="utf-8").split("\f")
    out = []
    for pg in pages:
        ls = [l.strip() for l in pg.split("\n") if l.strip() and not l.strip().startswith("Tome ")]
        out.append(ls[0] if ls else "")
    return out


def sans_espace(t: str) -> str:
    return re.sub(r"\s+", "", t.upper().translate(CHIF))


def construire():
    tomes = {t: lire_pages(t) for t in ("I", "II", "III")}
    voc = vocabulaire(tomes.values())
    VOC.update(voc)
    index = json.loads((RACINE / "partitions" / "hg" / "index.json").read_text(encoding="utf-8"))
    offices = collections.OrderedDict()
    stats = collections.Counter()
    for t, pages in tomes.items():
        n_tome = {"I": 1, "II": 2, "III": 3}[t]
        TT = titres_pdftotext(n_tome)
        jour, office = None, None
        dernier = {}                                          # (clé, office) → dernier élément (suites)
        heure = {}                                            # milieu du jour : tierce, sexte, none
        nums = sorted(pages)
        for p in nums:
            titre, ls = corps(pages[p])
            if langue(ls) != "la" or p + 1 not in pages:
                continue
            titre_fr, ls_fr = corps(pages[p + 1])
            if langue(ls_fr) != "fr":
                continue
            ttl = re.sub(r"^\d+\s+|\s+\d+$", "", TT[p - 1] if p - 1 < len(TT) else titre)
            c = cle_jour(ttl)
            se = sans_espace(ttl)
            if "COMPLETORIUM" in se:
                m = re.search(r"POST(II|I)VESP", se) or re.search(r"FERIA(III|II|IV|VI|V)", se) or re.search(r"(SABBATO)", se)
                if m:
                    c = "K/" + ({"I": "samedi", "II": "dimanche"}[m.group(1)] if "POST" in m.group(0) else
                                {"II": "lundi", "III": "mardi", "IV": "mercredi", "V": "jeudi", "VI": "vendredi", "SABBATO": "samedi"}[m.group(1)])
                    office = "complies"
            if c:
                jour = c
            S_la, S_fr = sections(ls, "la"), sections(ls_fr, "fr")
            if not any(s[0] == "borne" for s in S_la):
                o = next((o for pat, o in OFFICES if re.search(pat, ttl.upper())), None)
                if o:
                    office = o
            # appariement des sections latines et françaises (même suite de types)
            cle_s = lambda s: (s[0], s[1])
            sm = difflib.SequenceMatcher(None, [cle_s(s) for s in S_la], [cle_s(s) for s in S_fr], autojunk=False)
            paires = []
            for op, a0, a1, b0, b1 in sm.get_opcodes():
                if op == "equal":
                    paires += list(zip(S_la[a0:a1], S_fr[b0:b1]))
                else:
                    paires += [(s, None) for s in S_la[a0:a1]] + [(None, s) for s in S_fr[b0:b1]]
            paires.sort(key=lambda x: (x[0] or x[1])[5] if x[0] else 10 ** 6)  # ordre latin ; français orphelin en fin
            for la, fr in paires:
                s = la or fr
                typ = s[0]
                if typ == "borne":
                    if la:
                        u = la[3].upper().translate(CHIF)
                        for pat, o in OFFICES:
                            if re.fullmatch(pat, u) or re.fullmatch(pat.replace(" ", ""), sans_espace(u)):
                                office = o
                        u = {k.replace(" ", ""): k for k in JOUR_TITRE}.get(sans_espace(u), u)
                        m = re.fullmatch(r"HEBDOMADA(I|II|III|IV)", sans_espace(u))
                        if m: u = f"HEBDOMADA {m.group(1)}"
                        if u in JOUR_TITRE and jour and jour.startswith("P/"):
                            jour = f"P/{jour.split('/')[1]}/{JOUR_TITRE[u]}"
                        if u in JOUR_TITRE and jour and jour.startswith("K/"):
                            jour = f"K/{JOUR_TITRE[u]}"
                        m = re.fullmatch(r"HEBDOMADA (I|II|III|IV)", u)
                        if m and jour and jour.startswith("P/"):
                            jour = f"P/{ROM[m.group(1)]}/{jour.split('/')[2]}"
                    continue
                if not jour or not office:
                    continue
                k = f"{n_tome}:{jour}|{office}"
                L = nettoyer(la[4], voc, "la") if la else []
                F = nettoyer(fr[4], voc, "fr") if fr else []
                if typ == "heure":
                    heure[k] = s[2]
                    continue
                if typ is None:                                   # suite de la page précédente
                    e = dernier.get(k)
                    if e is not None:
                        e["la"] += L; e["fr"] += F
                    continue
                e = {"t": typ, "n": s[1], "v": (la or fr)[2], "p": p, "tome": n_tome}
                if office == "milieu" and heure.get(k): e["h"] = heure[k]
                if la: e["tla"] = la[3]
                if fr: e["tfr"] = fr[3]
                if typ == "lecture":
                    m = re.search(r"\s{2,}(\S.*)$", (la or fr)[3]) or re.search(r"brevis\s+(.*)$|brève\s+(.*)$", (la or fr)[3])
                    e["ref"] = re.sub(r"^(Lectio brevis|Lecture brève)\s*", "", (la or fr)[3]).strip()
                e["la"], e["fr"] = L, F
                offices.setdefault(k, []).append(e)
                dernier[k] = e
                stats[typ] += 1
                stats["apparie" if la and fr else "seul"] += 1
    # psaume en plusieurs parties : après « Ant. 2. », la partie II commence par le seul chiffre « II »
    NUM = re.compile(r"^(I|II|III|IV|V)$")
    for k, els in offices.items():
        out, dernier_ps = [], None
        for e in els:
            if e["t"] == "psaume":
                dernier_ps = e
            if e["t"] == "antienne" and dernier_ps and (any(NUM.match(x[1]) for x in e["la"]) or any(NUM.match(x[1]) for x in e["fr"])):
                ia = next((i for i, x in enumerate(e["la"]) if NUM.match(x[1])), len(e["la"]))
                i_f = next((i for i, x in enumerate(e["fr"]) if NUM.match(x[1])), len(e["fr"]))
                num = (e["la"][ia:] or e["fr"][i_f:])[0][1]
                ps = {"t": "psaume", "n": None, "v": None, "p": e["p"], "tome": e["tome"],
                      "tla": f"{re.sub(r' (I|II|III|IV|V)$', '', dernier_ps.get('tla', ''))} {num}".strip(),
                      "tfr": f"{re.sub(r' (I|II|III|IV|V)$', '', dernier_ps.get('tfr', ''))} {num}".strip(),
                      "la": e["la"][ia + 1:], "fr": e["fr"][i_f + 1:]}
                e["la"], e["fr"] = e["la"][:ia], e["fr"][:i_f]
                out += [e, ps]
                continue
            out.append(e)
        offices[k] = out
    # partitions : pièces indexées, dans l'ordre, par (clé, office, rôle, rang, variante)
    libres = collections.defaultdict(list)
    for r in index:
        if r["cle"] and r["office"]:
            libres[(f"{r['fichiers'][0][2]}:{r['cle']}|{r['office']}", r["role"])].append(r)
    parpage = collections.defaultdict(list)
    for r in index:
        parpage[(int(r["fichiers"][0][2]), r["page"])].append(r)
    for k, els in offices.items():
        for e in els:
            role = e["t"]
            if role not in ("hymne", "antienne", "repons", "evangelique"):
                continue
            cands = libres.get((k, role), [])
            r = next((x for x in cands if (role != "antienne" or x["rang"] == e["n"]) and _var(x["variante"]) == _var(e["v"])), None)
            if r is None and role != "antienne":
                r = next((x for x in cands if not x.get("_pris")), None)
            if r is None:                               # même page, même rôle (clé différente dans l'index : complies…)
                r = next((x for x in parpage.get((e["tome"], e["p"]), []) if not x.get("_pris") and x["role"] == role
                          and (role != "antienne" or x["rang"] in (e["n"], None) or e["n"] is None)), None)
            if r is None and role == "hymne":          # hymne étiquetée « autre » (« Tempore per annum: » au-dessus)
                r = next((x for x in libres.get((k, "autre"), []) if not x.get("_pris") and x["page"] == e["p"]), None)
            if r is not None and not r.get("_pris"):
                r["_pris"] = True
                e["partitions"] = r["fichiers"]
                stats["avec_partition"] += 1
    return offices, stats


def _var(v):
    if not v:
        return None
    v = v.lower()
    for k, n in (("hors", "hors-TP"), ("extra", "hors-TP"), ("pascal", "TP"), ("pasch", "TP"), ("tp", "TP"), ("carême", "Q"), ("quadrag", "Q"), ("avent", "A"), ("advent", "A"),
                 ("noël", "N"), ("nativ", "N"), ("per annum", None), ("ordinaire", None), ("hors", "hors-TP"), ("extra", "hors-TP"),
                 ("vel", "ou"), ("ou bien", "ou")):
        if k in v:
            return n
    m = re.search(r"(anno|année) ([abc])", v)
    return m.group(2).upper() if m else v


def recoller_lettrines(offices):
    """Lettrine tombée au début de la ligne suivante : « ONâme ✠ exalte » / « Mexulte mon esprit »
    → « MON âme ✠ exalte » / « exulte mon esprit » ; « PERÍTE mihi » / « Aingréssus » → « APERÍTE mihi » / « ingréssus »."""
    voc = collections.Counter()
    for els in offices.values():
        for e in els:
            for lg in ("la", "fr"):
                for _, t in e.get(lg, []):
                    voc.update(w.lower() for w in re.findall(r"[^\W\d_]+", re.sub(r"<[^>]+>", "", t)))
    n = 0
    for els in offices.values():
        for e in els:
            for lg in ("la", "fr"):
                ls = e.get(lg, [])
                for i in range(len(ls) - 1):
                    a, b = ls[i][1], ls[i + 1][1]
                    if re.match(r"^[IVX]+$", a.strip()) and i + 2 < len(ls):
                        # section du Ps 118 : « IX » / « Ufais le bonheur » / « TSeigneur… » → « TU fais le bonheur » / « Seigneur… »
                        c = ls[i + 2][1]
                        mb = re.match(r"^([A-ZÀ-ÝŒÆ])(?=(?:<b>)?[a-zà-ÿœæ])", b)
                        mc = re.match(r"^([A-ZÀ-ÝŒÆ])(?=[A-ZÀ-ÝŒÆ](?:<b>)?[a-zà-ÿœæ’])", c)
                        if mb and mc and voc[(mc.group(1) + mb.group(1)).lower()] >= 2:
                            ls[i + 1][1], ls[i + 2][1] = mc.group(1) + mb.group(1) + " " + b[1:], c[1:]
                            n += 1
                        continue
                    if not re.match(r"^[A-ZÀ-ÝŒÆ]{2,}", a):
                        continue
                    titre = not re.search(r"[a-zà-ÿœæ]", re.sub(r"<[^>]+>|&\w+;", "", a))   # ligne de titre, tout en capitales
                    m = re.match(r"^([A-ZÀ-ÝŒÆ])(’?)((?:<b>)?[a-zà-ÿœæ])", b)
                    m2 = re.match(r"^([A-ZÀ-ÝŒÆ])(?=[A-ZÀ-ÝŒÆ](?:<b>)?[a-zà-ÿœæ’])", b)
                    if m:
                        mot = re.match(r"[^\W\d_]+", re.sub(r"<[^>]+>", "", b)).group(0)
                        reste = re.match(r"[^\W\d_]+", re.sub(r"<[^>]+>", "", b[1 + len(m.group(2)):])).group(0)
                        if m.group(2) and (titre or not re.match(r"[AEIOUYHÀÂÉÈÊÎÔÛŒÆ]", a)):
                            continue                  # élision seulement devant voyelle, jamais sur un titre
                        if m.group(2) or (voc[reste.lower()] > 2 * voc[mot.lower()] and voc[reste.lower()] >= 2):
                            a = m.group(1) + m.group(2) + a          # « C’ » + « EST l’heure »
                            a = re.sub(r"^([A-ZÀ-ÝŒÆ’]{2,})(?=(?:<b>)?[a-zà-ÿœæ])", r"\1 ", a)
                            ls[i][1], ls[i + 1][1] = a, b[1 + len(m.group(2)):]
                            n += 1
                    elif m2:
                        premier = re.match(r"[A-ZÀ-ÝŒÆ]+", a).group(0)
                        if voc[(m2.group(1) + premier).lower()] >= 2 or voc[(m2.group(1) + premier).lower().replace("î", "i")] >= 2:
                            ls[i][1], ls[i + 1][1] = re.sub(r"^([ÔÀ])(?=[A-ZÀ-ÝŒÆ]{2})", r"\1 ", m2.group(1) + a), b[1:]   # « AÎTRE » / « MTu » → « MAÎTRE » / « Tu »
                            n += 1
    return n


ELISIONS = {"c", "d", "l", "j", "m", "n", "s", "t", "qu", "jusqu", "lorsqu", "puisqu"}


def redecouper_debuts(offices):
    """Premiers mots en petites capitales collés : « CEST l’anniversaire » → « C’EST l’anniversaire »,
    « LAGNEAU » → « L’AGNEAU », « ADTE, Dómine » → « AD TE, Dómine », « ADD óminum » → « AD Dóminum »."""
    import math
    vocs = {"la": collections.Counter(), "fr": collections.Counter()}
    hg = {"la": collections.Counter(), "fr": collections.Counter()}   # mots des Heures grégoriennes seules
    for f in glob.glob(str(RACINE / "site" / "donnees" / "bible" / "*.json")) + [str(RACINE / "site" / "donnees" / "psautier.json")]:
        vocs["fr"].update(w.lower() for w in re.findall(r"[^\W\d_]+", texte_json(f)))
    for els in offices.values():
        for e in els:
            for lg in ("la", "fr"):
                for _, t in e.get(lg, []):
                    # mots écrits en minuscules seulement : les capitales collées (« CEST ») ne comptent pas comme mots
                    mots = [w.lower() for w in re.findall(r"[^\W\d_]+", re.sub(r"<[^>]+>", "", t)) if not (w.isupper() and len(w) > 1)]
                    vocs[lg].update(mots)
                    hg[lg].update(mots)
    COURTS = {"à", "ô", "au", "du", "de", "le", "la", "ce", "il", "je", "tu", "me", "te", "se", "ne", "et", "en",
              "un", "ad", "in", "ut", "ab", "ex", "de", "et", "te", "me", "tu", "si", "ou", "y", "on", "ni", "nos"}

    def decoupe(mot, lg):
        voc = vocs[lg]
        m = mot.lower()
        best = [(0.0, None)] + [(-1e9, None)] * len(m)
        for i in range(1, len(m) + 1):
            for j in range(max(0, i - 20), i):
                w = m[j:i]
                if best[j][0] < -1e8:
                    continue
                if lg == "fr" and w in ELISIONS and i < len(m) and m[i] in "aeiouyhàâäéèêëîïôöùûüœæ":
                    sc = best[j][0] - 1.5
                elif voc[w] >= (20 if lg == "fr" else 5) and (len(w) > 2 or w in COURTS):
                    sc = best[j][0] + math.log(voc[w]) - 12
                else:
                    continue
                if sc > best[i][0]:
                    best[i] = (sc, j)
        if best[len(m)][0] < -1e8:
            return None
        cuts, i = [], len(m)
        while i > 0:
            j = best[i][1]
            cuts.append((j, i)); i = j
        return [(mot[j:i], m[j:i] in ELISIONS and i < len(m)) for j, i in reversed(cuts)]

    n = 0
    for els in offices.values():
        for e in els:
            for lg in ("la", "fr"):
                ls = e.get(lg, [])
                # début de l'élément, et début de chaque partie de psaume (ligne « II », « III »…)
                for x in [y for k, y in enumerate(ls) if k < 4 or re.match(r"^[IVX]+$", ls[k - 1][1].strip())]:
                    t = x[1]
                    voc = vocs[lg]
                    if re.match(r"^(CANTICUM|PSALMUS|CANTIQUE|PSAUME)", t) or not re.search(r"[a-zà-ÿœæ]", re.sub(r"<[^>]+>|&\w+;", "", t)):
                        continue                      # titres (tout en capitales) : on n’y touche pas
                    mm = re.match(r"^([A-ZÀ-ÝŒÆ]{2,})( ?)([a-zà-ÿœæ]*)(?=[\s,;:.!?’'✠-]|$)", t)
                    if not mm:
                        continue
                    caps, esp, suite = mm.groups()
                    if esp and voc[suite.lower()] >= 2:
                        esp, suite = "", ""           # « AUNOUVEAU soldat » : on ne touche qu’aux capitales
                    if suite and not esp and len(caps) == 2 and not re.search(r"[AEIOUYÀ-Ý]", caps) and voc[(caps[1] + suite).lower()] >= 20:
                        x[1] = t[1:]                  # « TSeigneur » : lettre parasite devant le mot
                        n += 1
                        continue
                    if suite and not esp and re.search(r"[AEIOUYÀ-Ý]", caps) and voc[caps.lower()] >= 20:
                        x[1] = caps + " " + t[len(caps):]   # « JEbénirai », « JEn’ai » : il manque l’espace
                        n += 1
                        continue
                    plein = caps + suite
                    if voc[plein.lower()] >= 2 and (not esp or not suite):
                        continue                      # déjà un mot
                    if suite and esp and voc[caps.lower()] >= 2 and voc[suite.lower()] >= 2:
                        continue                      # « MON âme » : deux mots justes
                    morceaux = decoupe(plein, lg)
                    if not morceaux and not suite and voc[caps.lower()] == 0 and t[len(caps):len(caps) + 1] == " ":
                        # lettrine perdue : « OICI le jour » → « VOICI le jour » (une seule lettre possible, nettement)
                        essais = sorted(((voc[(c + caps).lower()], c) for c in "ABCDEFGHIJLMNOPQRSTUV"), reverse=True)
                        if essais[0][0] >= 20 and essais[0][0] >= 3 * essais[1][0]:
                            x[1] = essais[0][1] + t
                            n += 1
                        continue
                    if not morceaux or len(morceaux) < 2:
                        continue
                    if lg == "la" and not (len(morceaux) == 2 and morceaux[0][0].lower() in ("ad", "in", "ut", "et", "te", "tu", "qui", "usque")):
                        continue                      # latin : seulement « AD TE », « IN TE », « UT QUID », « USQUE QUO »…
                    nouveau = ""
                    for k, (w, elision) in enumerate(morceaux):
                        nouveau += w + ("’" if elision else (" " if k < len(morceaux) - 1 else ""))
                    if nouveau.replace(" ", "") == plein and nouveau == caps + esp + suite:
                        continue
                    # chaque mot obtenu doit être un vrai mot (« DS eigneur », « TUÉ LOI GNES » refusés)
                    if not all(w.lower() in COURTS or (voc[w.lower()] >= (20 if lg == "fr" else 5) and hg[lg][w.lower()] >= 2) for w, el in morceaux if not el):
                        continue
                    x[1] = nouveau + t[len(caps) + len(esp) + len(suite):]
                    n += 1
    return n


# Hymnes de Sexte (Ordinaire de l'office) : pages PDF (tome, page latine, page française), bornes du texte, partitions
SEXTE = {
    "per-annum": ("I", [1068], r"^Tempore per annum:", None, [1069], r"aux solennités:$", None,
                  {"TO": ["hg1/s-1068-2.jpg"], "avent": ["hg1/s-1070-1.jpg"], "noel": ["hg1/s-1070-2.jpg"], "solennite": ["hg1/s-1070-3.jpg"]}),
    "avent-17": ("I", [1072], r"^Tempore Adventus post diem 16", r"^Tempore Nativitatis", [1073], r"^l’Épiphanie:$", None,
                 {"avent": ["hg1/s-1072-1.jpg"], "noel": ["hg1/s-1072-2.jpg"]}),
    "careme": ("II", [1164], r"^Tempore Quadragesimæ:", r"^Tempore paschali:", [1165], r"^Temps du Carême:", r"^Temps pascal:",
               {"careme": ["hg2/s-1164-1.jpg"]}),
    "paques": ("II", [], None, None, [1165, 1167], r"^Temps pascal:", r"^À None",
               {"paques": ["hg2/s-1164-2.jpg", "hg2/s-1166-1.jpg"]}),
}


def hymnes_sexte(voc):
    tomes = {}
    def lignes(tome, pages, debut, fin, fr):
        if tome not in tomes:
            tomes[tome] = lire_pages(tome)
        out, dedans = [], debut is None
        for p in pages:
            for l in tomes[tome].get(p, [])[2:]:           # sans le titre courant
                t = l.strip()
                if not t or re.match(r"^\d+\s|^(ORDINAIRE|ORDINARIUM)", t):
                    continue
                if not dedans:
                    dedans = bool(re.search(debut, t)); continue
                if fin and re.search(fin, t):
                    return out
                if re.match(r"^(Ad |À )(Sextam|Nonam|Sexte|None)$|^HYMN", t):
                    continue
                out.append([0, decoder(t, voc, fr)])
        return out
    res = {}
    for nom, (tome, pla, dla, fla, pfr, dfr, ffr, parts) in SEXTE.items():
        res[nom] = {"la": lignes(tome, pla, dla, fla, False) if pla else [], "fr": lignes(tome, pfr, dfr, ffr, True), "partitions": parts}
    return res


ROMAIN = {"I": 1, "V": 5, "X": 10, "L": 50}


def romain(r):
    n = 0
    for i, c in enumerate(r):
        v = ROMAIN[c]
        n += -v if i + 1 < len(r) and ROMAIN[r[i + 1]] > v else v
    return n


def propres_dimanches_to(voc):
    """Dimanches du temps ordinaire (tome I, p. 778-870) : antienne du cantique évangélique (années A, B, C)
    et oraison, lues directement dans le livre (l'extraction générale mêlait chaque semaine à la précédente)."""
    pages = lire_pages("I")
    semaines = collections.OrderedDict()
    def sem(n):
        return semaines.setdefault(n, {"ant_la_page": None, "ant_fr": [], "or_la": [], "or_fr": []})
    # latin (pages paires)
    cur, etat = None, None
    for p in range(778, 872, 2):
        for l in pages.get(p, [])[2:]:
            t = l.strip()
            if not t or re.match(r"^\d+\s", t):
                continue
            m = re.match(r"^HEBDOMADA\s*([IVXL]+)\s*PER\s*ANNUM$", t)
            if m:
                cur, etat = romain(m.group(1)), None; continue
            if cur is None:
                continue
            if re.match(r"^Ad canticum evangelicum", t):
                sem(cur)["ant_la_page"] = sem(cur)["ant_la_page"] or p; etat = None; continue
            if t == "Oratio":
                etat = "or"; sem(cur)["or_la"] = []; continue
            if etat == "or":
                sem(cur)["or_la"].append([0, decoder(t, voc, False)])
                if re.search(r"(Per Dóminum|Qui tecum|Qui vivis)", t):
                    etat = None
    # français (pages impaires)
    cur, etat = None, None
    for p in range(779, 873, 2):
        for l in pages.get(p, [])[2:]:
            t = l.strip()
            if not t or re.search(r"SEMAINEDUTEMPS", t) or t == "e":
                continue
            m = re.match(r"^(\d+|≤|≥)\s*(?:e|re|er|ère)?\s*SEMAINE$", t)       # « ≤ère », « ≥e » : 1re, 2e
            if m:
                cur, etat = {"≤": 1, "≥": 2}.get(m.group(1)) or int(m.group(1)), None; continue
            if cur is None:
                continue
            if re.match(r"^Ant\. du cantique évangélique", t):
                etat = "ant"; sem(cur)["ant_fr"] = []; continue
            if t == "Oraison":
                etat = "or"; sem(cur)["or_fr"] = []; continue
            if etat == "ant":
                sem(cur)["ant_fr"].append([0, decoder(t, voc, True)])
            elif etat == "or":
                sem(cur)["or_fr"].append([0, decoder(t, voc, True)])
                if re.search(r"(Par Jésus|Lui qui|Toi qui règnes)", t):
                    etat = None
    # partitions des antiennes : dans l'ordre des pages, A, B, C pour chaque semaine qui a une antienne
    I = json.load(open(RACINE / "partitions" / "hg" / "index.json", encoding="utf-8"))
    imgs = sorted((x for x in I if x["fichiers"][0].startswith("hg1/") and 779 <= x["page"] <= 870 and re.match(r"Ann", x.get("titre", ""))),
                  key=lambda x: (x["page"], int(re.search(r"-(\d+)\.jpg$", x["fichiers"][0]).group(1))))
    # images des antiennes dans l'ordre du livre ; leurs étiquettes (Anno A, B, C, Annis A & B) sont justes :
    # on passe à la semaine suivante quand revient une année déjà vue
    ordre = [n for n in sorted(semaines) if semaines[n]["ant_fr"]]
    k = 0
    for x in imgs:
        ans = re.findall(r"[ABC]", re.sub(r"^Ann(o|is)\s*", "", x["titre"]))
        if not ans or k >= len(ordre):
            continue
        while k < len(ordre) and any(a in semaines[ordre[k]].get("parts", {}) for a in ans):
            k += 1
        if k >= len(ordre):
            break
        for a in ans:
            semaines[ordre[k]].setdefault("parts", {})[a] = x["fichiers"]
    return semaines


LAB_LA = re.compile(r"^Dom\.\s*([IVX]+)(?:\s*&\s*([IVX]+))?\s*(Quadragesimæ|Paschæ),\s*ant\.\s*(\d)\.?$")
LAB_FR = re.compile(r"^(\d+)\s*(?:er|e)?\s*(?:(?:&|et)\s*(\d+)\s*(?:e)?\s*)?dimanches? de (Carême|Pâques),\s*ant\.\s*(\d)\.?$")


def dims_de(m, latin):
    t = "Q" if m.group(3) in ("Quadragesimæ", "Carême") else "P"
    nums = [m.group(1)] + ([m.group(2)] if m.group(2) else [])
    return tuple(t + str(romain(x) if latin else int(x)) for x in nums), int(m.group(4))


def antiennes_dimanches(offices):
    """Psautier du tome II : antiennes propres de certains dimanches (« Dom. I Quadragesimæ, ant. 2. » /
    « 1er dimanche de Carême, ant. 2. »), données à la fin du psaume précédent. On les sépare et on les place,
    marquées « dim » (Q1, P5…), devant le psaume qu'elles introduisent, avec leur partition."""
    I = json.load(open(RACINE / "partitions" / "hg" / "index.json", encoding="utf-8"))
    parts = {}
    for x in I:
        m = LAB_LA.match(html.unescape(re.sub(r"\s+", " ", x.get("titre", ""))).replace("Dom.V", "Dom. V").replace("Dom.I", "Dom. I"))
        if m and x["fichiers"][0].startswith("hg2/"):
            ds, rang = dims_de(m, True)
            parts[(x.get("cle"), x.get("office"), ds[0], rang)] = x["fichiers"]
    n = 0
    for cle, els in offices.items():
        if not re.match(r"2:P/\d/dimanche\|", cle):
            continue
        cj, office = cle[2:].split("|")
        out = []
        for e in els:
            trouves = {}
            for lg, lab in (("la", LAB_LA), ("fr", LAB_FR)):
                garde, cur = [], None
                for x in e.get(lg, []):
                    t = html.unescape(re.sub(r"<[^>]+>", "", x[1])).replace("Dom.V", "Dom. V").replace("Dom.I", "Dom. I").strip()
                    m = lab.match(t)
                    if m:
                        ds, rang = dims_de(m, lg == "la")
                        cur = (ds, rang)
                        trouves.setdefault(cur, {"la": [], "fr": []})
                        continue
                    if cur:
                        if lg == "fr":
                            trouves[cur]["fr"].append(x)
                    else:
                        garde.append(x)
                e[lg] = garde
            out.append(e)
            for (ds, rang), v in trouves.items():
                if not v["fr"] and any(k[0] == ds and k[1] == rang for k in trouves if k != (ds, rang)):
                    continue
                out.append({"t": "antienne", "n": rang, "v": None, "dim": list(ds), "tla": f"Ant. {rang}.", "tfr": f"Ant. {rang}.",
                            "la": [], "fr": v["fr"], "partitions": parts.get((cj, office, ds[0], rang))})
                n += 1
        offices[cle] = out
    return n


# Débuts de psaumes dont la lettrine a éclaté en morceaux (relevé à la main, 17/11/2026) : début de ligne → correction
RETOUCHES_DEBUT = [("EL’Agneau", "L’Agneau"), ("EC’est lui", "C’est lui"), ("OJ’affirme", "J’affirme"), ("IL’espérance", "L’espérance"),
                   ("EL’un de vous", "L’un de vous"), ("IC’est maintenant", "C’est maintenant"),
                   ("Seigneur est mon berger:", "LE Seigneur est mon berger:"), ("L je ne manque", "je ne manque"),
                   ("S profondeurs je crie", "DES profondeurs je crie"), ("D Seigneur, écoute", "Seigneur, écoute"),
                   ("UEZ le Seigneur, tous", "LOUEZ le Seigneur, tous"), ("HUREUX qui pense", "HEUREUX qui pense"),
                   ("EIGNEUR, mon Dieu", "SEIGNEUR, mon Dieu"), ("S dans cette nuit", "dans cette nuit"),
                   ("UI qui frappa", "LUI qui frappa"), ("L éternel est son amour", "éternel est son amour"),
                   ("QU’ILsoit", "QU’IL soit"), ("QU’ILest", "QU’IL est")]


def retoucher_debuts(offices):
    n = 0
    for els in offices.values():
        for e in els:
            if e["t"] != "psaume":
                continue
            for x in e.get("fr", [])[:10]:
                nu = re.sub(r"<[^>]+>", "", x[1])
                for a, b in RETOUCHES_DEBUT:
                    if nu.startswith(a):
                        k = 0                      # partie commune en fin : seul le début change (le reste peut porter du gras)
                        while k < min(len(a), len(b)) and a[-1 - k] == b[-1 - k]:
                            k += 1
                        x[1] = b[:len(b) - k] + x[1][len(a) - k:]; n += 1
                        break
                if re.match(r"^Lfêtez-l", x[1]):
                    x[1] = re.sub(r"^Lfêtez-l(?:<b>)?[èïe](?:</b>)?", "fêtez-le", x[1]); n += 1
    return n


def main():
    offices, stats = construire()
    # propres des dimanches du temps ordinaire, lus à part
    for n, v in propres_dimanches_to(VOC).items():
        if n == 34 or not v["or_la"]:
            continue
        els = []
        if v["ant_fr"]:
            els.append({"t": "evangelique", "n": None, "v": None, "tla": "Ad canticum evangelicum, ant.", "tfr": "Ant. du cantique évangélique",
                        "la": [], "fr": v["ant_fr"], "partitionsAnnee": v.get("parts", {})})
        els.append({"t": "oraison", "n": None, "v": None, "tla": "Oratio", "tfr": "Oraison", "la": v["or_la"], "fr": v["or_fr"]})
        for k in [k for k in offices if k.startswith("1:TO/") and k.split("/")[1].split("|")[0] == str(n)]:
            del offices[k]
        for o in ("vepres1", "laudes", "vepres2"):
            offices[f"1:TO/{n}|{o}"] = els
    stats["antiennes_dimanches"] = antiennes_dimanches(offices)
    # laudes du Vendredi saint : leur début (ant. 1, Ps 50) avait été rangé sous le Jeudi saint
    if offices.get("2:F/jeudi-saint|laudes") and offices.get("2:F/vendredi-saint|laudes") and \
            any("PSALMUS 50" in (e.get("tla") or "") for e in offices["2:F/jeudi-saint|laudes"]) and \
            not any(e.get("n") == 1 for e in offices["2:F/vendredi-saint|laudes"]):
        offices["2:F/vendredi-saint|laudes"] = offices.pop("2:F/jeudi-saint|laudes") + offices["2:F/vendredi-saint|laudes"]
    stats["dimanches_to"] = sum(1 for k in offices if k.startswith("1:TO/") and k.endswith("|laudes"))
    for nom, h in hymnes_sexte(VOC).items():
        for temps, fichiers in h["partitions"].items():
            offices[f"0:S/sexte/{nom}/{temps}|milieu"] = [{"t": "hymne", "n": None, "v": None, "tla": "HYMNUS", "tfr": "HYMNE",
                                                           "la": h["la"], "fr": h["fr"], "partitions": fichiers}]
    # dimanches du psautier, milieu du jour : le livre donne l'hymne sur trois mélodies (Tierce, Sexte, None) ;
    # on note celle de Sexte, la seule heure retenue ici
    I = json.load(open(RACINE / "partitions" / "hg" / "index.json", encoding="utf-8"))
    sextes = {(x["fichiers"][0].split("/")[0], x.get("cle")): x["fichiers"] for x in I
              if x.get("office") == "milieu" and re.match(r"Ad\s*Sextam", x.get("titre", ""))}
    for cle, els in offices.items():
        m = re.match(r"(\d):(P/\d/dimanche)\|milieu$", cle)
        if m:
            for e in els:
                if e["t"] == "hymne" and sextes.get((f"hg{m.group(1)}", m.group(2))):
                    e["sexte"] = sextes[(f"hg{m.group(1)}", m.group(2))]
    stats["lettrines_recollees"] = recoller_lettrines(offices)
    stats["debuts_redecoupes"] = redecouper_debuts(offices)
    stats["debuts_retouches"] = retoucher_debuts(offices)      # en dernier : corrections à la main
    d = RACINE / "partitions" / "hg"
    (d / "offices.json").write_text(json.dumps(offices, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    print(f"{len(offices)} offices ; {dict(stats)}")


if __name__ == "__main__":
    main()
