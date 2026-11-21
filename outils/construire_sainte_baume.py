#!/usr/bin/env python3
"""Livrets de Sainte-Baume (fr. Max, LaTeX + LilyPond) → site/donnees/sainte_baume.json

Sources : sources_gouzes/sainte-baume/livrets-latex/
  « Carême Matines et Laudes fr. Max v.4.lytex »      (ordre des pièces ; v.3 corr. : textes des couplets de répons)
  « Carême Vêpres fr. Max.lytex »
  « Milieu du jour Gar.lytex »
  « Veillée pascale Choeur.lytex »
  « 1Index gouzantinus Carême.ods »                   (cote → texte de l'antienne)
Les partitions viennent des sources LilyPond de Gouzes déjà gravées (partitions/ly/pieces.json : source → image).

  python3 outils/construire_sainte_baume.py

Sortie (lue par site/js/saintebaume.js) :
  careme.offices.{lectures|laudes|vepres}["<semaine du psautier 1-4>/<jour>"] = [éléments]
      élément : {t: "ant", f, cote, si} | {t: "ps", id} | {t: "verset", v, r, si} | {t: "repons", a: [4 arguments]}
                | {t: "repons-si", si, label} | {t: "aller", si, label}
      si = jour concerné par une rubrique (« dimanche i », « mercredi des cendres », « lundi saint »…), sinon absent
  careme.repons.{laudes|vepres}[label] = {f: [images], couplets: [{titre, lignes}], ev: {f, cote}}
  careme.invitatoire = [{semaine 0-6, f, cote}] ; careme.canon = {partitions, jours: {"cendres/mercredi": [lignes]}}
  careme.lucernaire = {f, couplets} ; careme.hymnes = [{titre, f, passion}] ; careme.fin = {laudes|vepres: {preces, notre, benissons}}
  milieu = {hymnes, temps: {avent|noel|careme|paques: …}, semaines: {"1/lundi": {ant: {f, cote}, ps: [ids], verset: [v, r]}}}
  vigile = [{section, rubrique?, f: [images]}]   (Veillée pascale, version chœur)
  cotes = {cote: texte}                           (Index gouzantinus Carême)
"""
import json, os, re, unicodedata, zipfile, html as H

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(RACINE, "sources_gouzes", "sainte-baume", "livrets-latex")
SORTIE = os.path.join(RACINE, "site", "donnees", "sainte_baume.json")
NFC = lambda x: unicodedata.normalize("NFC", x)
PIECES = {NFC(p["source"]): p for p in json.load(open(os.path.join(RACINE, "partitions", "ly", "pieces.json")))}
manquants = []


def image(src):
    p = PIECES.get(NFC(src))
    if p and p.get("fichier"):
        return p["fichier"]
    manquants.append(src)
    return None


def cote(src):
    m = re.search(r"\b([A-Z]{1,2}) ?(\d{3}[a-z]?)\.ly$", src)
    return (m.group(1) + m.group(2)) if m else None


def incipit(src):
    b = os.path.splitext(os.path.basename(src))[0]
    b = re.sub(r"\s*\(R\)", "", re.sub(r"\s+[A-Z]{1,2} ?\d{3}[a-z]?$", "", b))
    return b.replace("...", "…").strip()


def decommenter(t):
    return re.sub(r"(?<!\\)%.*", "", t)


def arg(t, i):
    """argument entre accolades à partir de t[i] (espaces sautés) → (contenu, fin) ou (None, i)"""
    j = i
    while j < len(t) and t[j] in " \t":
        j += 1
    if j >= len(t) or t[j] != "{":
        return None, i
    n, k = 0, j
    while k < len(t):
        if t[k] == "{" and t[k - 1] != "\\":
            n += 1
        elif t[k] == "}" and t[k - 1] != "\\":
            n -= 1
            if n == 0:
                return t[j + 1:k], k + 1
        k += 1
    return t[j + 1:], len(t)


ROMAIN = {"I": 1, "V": 5, "X": 10, "L": 50, "C": 100}


def romain(s):
    v = 0
    for i, c in enumerate(s):
        x = ROMAIN[c]
        v += -x if i + 1 < len(s) and ROMAIN[s[i + 1]] > x else x
    return v


def piece_de_macro(nom):
    """\\PsaumeXXVIpI → "26" ; \\PsaumeIXa → "9A" ; \\CantiqueGIV → "AT4" ; \\CantiqueGNTX → "NT10" ; \\PsaumeCXVIIIpXIX → "118-19" """
    m = re.match(r"CantiqueGNT([IVXLC]+)$", nom)
    if m:
        return f"NT{romain(m.group(1))}"
    m = re.match(r"CantiqueG([IVXLC]+)$", nom)
    if m:
        return f"AT{romain(m.group(1))}"
    m = re.match(r"Psaume([IVXLC]+)([ab])?(?:p([IVXLC]+))?(Dir)?$", nom)
    if not m:
        return None
    n = romain(m.group(1))
    if n == 118 and m.group(3):
        return f"118-{romain(m.group(3))}"
    return f"{n}{(m.group(2) or '').upper()}"


def texte(s):
    """LaTeX du livret → HTML réduit (gras des inflexions, souligné), lignes séparées par \\n"""
    s = re.sub(r"\{\\scriptsize\s*/\}\s*\\mbox\{([^{}]*)\}", r" / \1", s)
    for _ in range(3):
        s = re.sub(r"\\gras\{([^{}]*)\}", r"<b>\1</b>", s)
        s = re.sub(r"\\underline\{([^{}]*)\}", r"<u>\1</u>", s)
        s = re.sub(r"\\(?:mbox|textbf|textit|emph|normalcolor)\{([^{}]*)\}", r"\1", s)
        s = re.sub(r"\\up\{([^{}]*)\}", r"\1", s)
    s = s.replace("\\og{}", "« ").replace("\\fg{}", " »").replace("\\og", "« ").replace("\\fg", " »")
    s = s.replace("\\\\", "\n").replace("\\par", "\n")
    s = re.sub(r"\\vers\{[^{}]*\}", "", s)
    s = re.sub(r"\\(bigskip|smallskip|medskip|pagebreak|newpage|null|noindent|hfill)\b", "", s)
    s = re.sub(r"\\vspace\{[^{}]*\}", "", s)
    s = s.replace("~", " ").replace("\\,", " ").replace("’", "'")
    s = re.sub(r"\\[a-zA-Z]+\*?", "", s).replace("{", "").replace("}", "")
    s = s.replace("<b></b>", "")
    lignes = [re.sub(r"\s+", " ", l).strip() for l in s.split("\n")]
    return [l.replace(" ' ", " ’ ") for l in lignes if l]


CMD = re.compile(r"\\(include\s*\"[^\"]+\"|[A-Za-z]+)")
ARITE = {"partie": 1, "Semaine": 1, "part": 1, "chapter": 1, "jour": 1, "jourHy": 1, "section": 1, "subsection": 1,
         "label": 1, "rubrique": 1, "Lectures": 0, "Laudes": 0, "paragraph": 1, "PsTitre": 1, "versLect": 2, "Repons": 4, "ReponsDi": 4,
         "ReponsSs": 4, "ReponsDiSs": 4, "ReponsG": 4}


def evenements(t):
    """suite d'événements (nom, arguments) ; \\dstr…\\fstr → ("strophe", lignes) ; texte libre → ("texte", brut)"""
    t = decommenter(NFC(t))
    t = t[t.index("\\begin{document}"):]
    i, dernier = 0, 0
    while True:
        m = CMD.search(t, i)
        if not m:
            break
        nom = m.group(1)
        avant = t[dernier:m.start()]
        if avant.strip():
            yield ("texte", avant)
        if nom.startswith("include") and '"' in nom:
            yield ("include", re.search(r"\"([^\"]+)\"", nom).group(1))
            i = dernier = m.end()
            continue
        if nom == "dstr" or nom == "dstrophe":
            fin = t.find("\\fstr", m.end())
            yield ("strophe", texte(t[m.end():fin]))
            i = dernier = fin + 5
            continue
        if re.match(r"(Psaume|Cantique)[A-Z]", nom):
            a1, k = arg(t, m.end())
            a2, k = arg(t, k)
            yield ("ps", nom)
            i = dernier = k
            continue
        n = ARITE.get(nom)
        if n is None:
            i = dernier = m.end()
            continue
        args, k = [], m.end()
        for _ in range(n):
            a, k = arg(t, k)
            args.append(a if a is not None else "")
        if nom == "rubrique":   # arguments facultatifs de mise en page
            for _ in range(2):
                a, k2 = arg(t, k)
                if a is not None and re.fullmatch(r"\s*[-\d.]*(ex|em|pt|mm)?\s*", a):
                    k = k2
        yield (nom, args)
        i = dernier = k


def propre(s):
    return re.sub(r"\s+", " ", " ".join(texte(s or ""))).strip()


def si_de(rub):
    """« Le dimanche I: » → « dimanche i » ; « Le mercredi des Cendres: » → « mercredi des cendres »"""
    r = propre(rub).rstrip(":. ").strip()
    m = re.match(r"(?:Le|Pendant la) (.+)$", r)
    if not m or "," in m.group(1) or "p." in r:
        return None
    return m.group(1).lower().replace("\u00a0", " ")


ROMS = {"I": 1, "II": 2, "III": 3, "IV": 4}


# ── Carême : matines (office des lectures) et laudes, vêpres
def careme(chemin, office_unique=None, texte_v3=None):
    offices, repons, canon, invit, hymnes = {}, {}, {}, [], []
    lucernaire, fin, partitions_canon = None, {}, []
    sem = jour = off = None
    partie = chap = None
    si = None                  # rubrique en attente (s'applique à l'élément suivant)
    chap_label = None
    rep_cour = None
    attente_ev = False
    cle_canon = None
    sem_canon = None
    section = None
    evs = list(evenements(open(chemin, encoding="utf-8").read()))
    for nom, a in evs:
        if nom == "partie":
            partie = propre(a[0]); sem = None; chap = None; jour = None
            continue
        if nom == "Semaine":
            sem = ROMS.get(propre(a[0])); partie = "jours"; jour = None
            continue
        if nom in ("jour",):
            jour = propre(a[0]).lower(); off = office_unique
            continue
        if nom in ("Lectures", "Laudes"):
            off = nom.lower()
            continue
        if partie == "jours" and nom == "rubrique":
            r = propre(a[0])
            m = re.match(r"Le (.+?), répons p\.\s*Repons(\w+)", r) or re.match(r"Le (.+?), répons p\. .*?\{?Repons(\w+)", a[0])
            if m:
                offices.setdefault(off, {}).setdefault(f"{sem}/{jour}", []).append({"t": "repons-si", "si": m.group(1).lower(), "label": m.group(2)})
                continue
            m = re.search(r"Le (.+?), on prend la suite de l'office p\.\s*\\pageref\{(\w+)\}", a[0])
            if m:
                offices.setdefault(off, {}).setdefault(f"{sem}/{jour}", []).append({"t": "aller", "si": m.group(1).lower(), "label": m.group(2)})
                continue
            si = si_de(a[0])
            continue
        if partie == "jours" and sem and jour and off:
            L = offices.setdefault(off, {}).setdefault(f"{sem}/{jour}", [])
            if nom == "include" and "/" in a and not a.startswith("Ft"):
                e = {"t": "ant", "src": a, "f": image(a), "cote": cote(a), "inc": incipit(a)}
                if si:
                    e["si"] = si
                L.append(e); si = None
            elif nom == "ps":
                pid = piece_de_macro(a)
                if pid:
                    L.append({"t": "ps", "id": pid})
                si = None
            elif nom == "versLect":
                e = {"t": "verset", "v": propre(a[0]), "r": propre(a[1])}
                if si:
                    e["si"] = si
                L.append(e); si = None
            elif nom.startswith("Repons"):
                L.append({"t": "repons", "a": [propre(x) for x in a]})
            elif nom == "label":
                L.append({"t": "label", "label": a[0]})
            continue
        # ── parties communes
        if partie == "Invitatoire":
            if nom == "rubrique":
                r = propre(a[0]).lower()
                sem_canon = {"semaine des cendres": 0, "première semaine": 1, "deuxième semaine": 2, "troisième semaine": 3,
                             "quatrième semaine": 4, "cinquième semaine": 5, "semaine sainte": 6}.get(r)
            elif nom == "include" and sem_canon is not None and "/" in a:
                invit.append({"semaine": sem_canon, "f": image(a), "cote": cote(a), "inc": incipit(a)})
                sem_canon = None
            continue
        if partie == "Hymne":
            if nom == "include" and "/" in a:
                partitions_canon.append(image(a))
            elif nom == "chapter":
                chap = propre(a[0])
            elif nom in ("section", "jourHy"):
                j = propre(a[0]).lower()
                s = {"Semaine des Cendres": "cendres", "Semaine Sainte": "sem6"}.get(chap) or ("sem%d" % romain(chap.split()[-1]) if chap and chap.startswith("Semaine ") else None)
                cle_canon = f"{s}/{j}" if s else None
                if cle_canon:
                    canon[cle_canon] = []
            elif nom == "strophe" and cle_canon:
                canon[cle_canon].append(a)
            continue
        if partie == "Hymnes":   # vêpres : lucernaire et hymnes
            if nom == "section":
                section = propre(a[0])
            elif nom == "chapter":
                chap = propre(a[0])
            elif nom == "include" and "/" in a and not a.startswith("Ft"):
                if section == "Lucernaire":
                    lucernaire = {"f": image(a), "cote": cote(a), "couplets": []}
                else:
                    hymnes.append({"titre": section, "f": image(a), "cote": cote(a), "passion": chap == "Passion"})
            elif nom == "strophe" and section == "Lucernaire" and lucernaire:
                lignes = a
                if lignes and re.fullmatch(r"(\d+\.|1er dimanche|\de dimanche|[A-ZÉ][a-zé]+(?: Saint)?)", lignes[0]):
                    lucernaire["couplets"].append({"titre": lignes[0], "lignes": lignes[1:]})
                    continue
                m = re.match(r"^(\d+\.|1er dimanche|\de dimanche|[A-ZÉ][a-zé]+(?: Saint)?)\s+(.*)$", lignes[0]) if lignes else None
                lucernaire["couplets"].append({"titre": m.group(1) if m else "", "lignes": [m.group(2)] + lignes[1:] if m else lignes})
            continue
        if partie == "Répons":
            if nom == "chapter":
                chap = propre(a[0]); rep_cour = None; attente_ev = False
            elif nom == "label" and a[0].startswith("Repons"):
                rep_cour = repons.setdefault(a[0][6:], {"titre": chap, "f": [], "couplets": []})
            elif nom == "include" and "/" in a and not a.startswith("Ft"):
                if attente_ev and rep_cour is not None:
                    rep_cour["ev"] = {"f": image(a), "cote": cote(a), "src": a, "inc": incipit(a)}
                    attente_ev = False
                elif rep_cour is not None and a.startswith("Répons/"):
                    rep_cour["f"].append(image(a))
                    if "Cplts" not in a:
                        rep_cour["cote"] = cote(a); rep_cour["src"] = a
                elif chap in ("Preces", "Notre Père"):
                    k = "preces" if "Preces" in a else "benissons" if "Bénissons" in a else "notre" if "Notre" in a else None
                    if k:
                        fin[k] = image(a)
            elif nom == "rubrique" and "Antienne du cantique" in a[0]:
                attente_ev = True
            elif nom == "paragraph" and rep_cour is not None:
                rep_cour.setdefault("_par", []).append(a[0])
            continue
        if partie in ("Répons",) or chap in ("Preces", "Notre Père"):
            pass
    # couplets des répons : texte qui suit chaque \paragraph (relu dans le source, plus simple)
    for src in [chemin] + ([texte_v3] if texte_v3 else []):
        t = decommenter(open(src, encoding="utf-8").read())
        k = t.find("\\partie{Répons}")
        if k < 0:
            continue
        for m in re.finditer(r"\\label\{Repons(\w+)\}(.*?)(?=\\chapter|\\partie|\\end\{document\})", t[k:], re.S):
            r = repons.get(m.group(1))
            if r is None or r.get("couplets"):
                continue
            for p in re.finditer(r"\\paragraph\{([^}]*)\}(.*?)(?=\\paragraph\{|\\rubrique|\\par\\begin|\\begin\{lilypond\}|\\label|$)", m.group(2), re.S):
                lignes = texte(p.group(2))
                if lignes:
                    r["couplets"].append({"titre": propre(p.group(1)).rstrip("."), "lignes": lignes})
    for r in repons.values():
        r.pop("_par", None)
        r["f"] = [x for x in r["f"] if x]
    # Preces / Notre Père hors de la partie Répons (chapitres de fin)
    return {"offices": offices, "repons": repons, "canon": canon, "partitions_canon": [x for x in partitions_canon if x],
            "invitatoire": invit, "lucernaire": lucernaire, "hymnes": hymnes, "fin": fin}


def fin_de_livret(chemin):
    """preces, Notre Père, Bénissons (ton du Carême) : dernières pièces du livret"""
    t = decommenter(open(chemin, encoding="utf-8").read())
    out = {}
    for m in re.finditer(r"\\include\s*\"((?:Antiennes|Présidence|Répons|Ordinaires)/[^\"]*(?:Preces|Notre Père|Bénissons)[^\"]*)\"", t):
        k = "preces" if "Preces" in m.group(1) else "benissons" if "Bénissons" in m.group(1) else "notre"
        out[k] = image(m.group(1))
    return out


# ── Milieu du jour
TEMPS_MDJ = {"Avent": "avent", "Nativité": "noel", "Carême": "careme", "Temps pascal": "paques"}


def milieu(chemin):
    out = {"hymnes": [], "temps": {}, "semaines": {}}
    partie = section = jour = sem = None
    rub = None
    hy = []
    for nom, a in evenements(open(chemin, encoding="utf-8").read()):
        if nom == "part":
            partie = propre(a[0]); section = None; jour = None
            sem = romain(partie.split()[-1]) if partie.startswith("Semaine") else None
            if hy and partie != "Hymnes":
                out["hymnes"].append(hy); hy = []
            continue
        if partie == "Hymnes":
            if nom == "strophe":
                hy.append(a)
            elif nom == "rubrique":
                if hy:
                    out["hymnes"].append(hy); hy = []
            continue
        if partie == "Propre du Temps":
            if nom == "section":
                section = TEMPS_MDJ.get(propre(a[0]))
                out["temps"].setdefault(section, {"hymne": [], "antiennes": [], "versets": []}); rub = None
            elif not section:
                continue
            elif nom == "rubrique":
                rub = propre(a[0])
            elif nom == "strophe":
                out["temps"][section]["hymne"].append(a)
            elif nom == "include" and "/" in a and not a.startswith("Ft"):
                out["temps"][section]["antiennes"].append({"f": image(a), "cote": cote(a), "inc": incipit(a), **({"quand": rub} if rub else {})})
            elif nom == "versLect":
                out["temps"][section]["versets"].append({"v": propre(a[0]), "r": propre(a[1]), **({"quand": rub} if rub else {})})
            continue
        if sem:
            if nom == "jour":
                jour = propre(a[0]).lower()
                out["semaines"][f"{sem}/{jour}"] = {"ps": []}
            elif not jour:
                continue
            elif nom == "include" and "/" in a and not a.startswith("Ft"):
                out["semaines"][f"{sem}/{jour}"]["ant"] = {"f": image(a), "cote": cote(a), "inc": incipit(a)}
            elif nom == "ps":
                pid = piece_de_macro(a)
                if pid:
                    out["semaines"][f"{sem}/{jour}"]["ps"].append(pid)
            elif nom == "versLect":
                out["semaines"][f"{sem}/{jour}"]["verset"] = [propre(a[0]), propre(a[1])]
    if hy:
        out["hymnes"].append(hy)
    return out


# ── Veillée pascale (version chœur) : partitions par section
def vigile(chemin):
    out, chap = [], None
    for nom, a in evenements(open(chemin, encoding="utf-8").read()):
        if nom == "chapter":
            chap = propre(a[0])
        elif nom == "section":
            out.append({"partie": chap, "section": propre(a[0]), "elements": []})
        elif nom == "rubrique" and out:
            out[-1]["elements"].append({"rubrique": propre(a[0])})
        elif nom == "include" and out and "/" in a and not a.startswith("Ft"):
            f = image(a)
            if f and not "Commandes" in a:
                out[-1]["elements"].append({"f": f})
            elif "Exsultet" in a:
                f = PIECES.get(NFC("Veillée pascale/Exsultet 2021.ly"), {}).get("fichier")
                if f and not any(e.get("f") == f for e in out[-1]["elements"]):
                    out[-1]["elements"].append({"f": f})
    return [s for s in out if s["elements"]]


def index_gouzantinus(chemin):
    x = zipfile.ZipFile(chemin).read("content.xml").decode()
    cotes = {}
    for r in re.findall(r"<table:table-row[^>]*>(.*?)</table:table-row>", x, re.S):
        cells = [H.unescape(re.sub(r"<[^>]+>", "", c)).strip() for c in re.findall(r"<table:table-cell[^>]*>(.*?)</table:table-cell>", r, re.S)]
        cells = [c for c in cells if c]
        for i, c in enumerate(cells[:-1]):
            if re.fullmatch(r"[A-Z] ?\d{3}", c) and len(cells[i + 1]) > 12 and not re.fullmatch(r"[A-Z] ?\d{3}", cells[i + 1]):
                cotes.setdefault(c.replace(" ", ""), cells[i + 1].replace("’", "'"))
                break
    return cotes


# ── Temps ordinaire : « Antiennes des offices Ste Baume.docx » (tableau semaine I-IV × jour)
#    matines (office des lectures) et laudes, milieu du jour (sexte), vêpres. Antiennes notées par leur début
#    (« 62 Mon âme ») : texte complet retrouvé dans le recueil de Gouzes et les livrets indexés de Sainte-Baume.
DOCX_TO = os.path.join(RACINE, "sources_gouzes", "sainte-baume", "textes", "Antiennes des offices Ste Baume.docx")
JOURS = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"]
ABREV = [(r"\bS\.", "Seigneur"), (r"\bXst\b", "Christ"), (r"\btte\b", "toute"), (r"\bttes\b", "toutes"), (r"\bts\b", "tous"),
         (r"\bns\b", "nous"), (r"\bds\b", "dans"), (r"\bmrt\b", "mort"), (r"\bH\.", "hommes"), (r"\bT\.", "terre"), (r"\bP\.", "Père")]


def N(t):
    return re.sub(r"[^a-z]", "", unicodedata.normalize("NFD", t or "").lower())


def tableaux_docx(chemin):
    x = zipfile.ZipFile(chemin).read("word/document.xml").decode()
    def cell(c):
        return [H.unescape("".join(re.findall(r"<w:t[^>]*>([^<]*)</w:t>", p))).replace("\u00a0", " ").strip()
                for p in re.findall(r"<w:p[ >].*?</w:p>", c, re.S)]
    return [[[cell(c) for c in re.findall(r"<w:tc>.*?</w:tc>", r, re.S)] for r in re.findall(r"<w:tr[ >].*?</w:tr>", t, re.S)]
            for t in re.findall(r"<w:tbl>.*?</w:tbl>", x, re.S)]


ROM_P = {"I": 1, "II": 2, "III": 3}


def piece_to(t):
    """« 17-I » → ("17", partie 1) ; « 118-19 » → ("118-19") ; « 9a » → ("9A") ; « 1 Ch 29 » → cantique de l'AT"""
    t = t.strip()
    m = re.match(r"^(\d+)([ab])?(?:-(\d+|I{1,3}))?\b", t)
    if not m or re.match(r"^\d\s?(?:Ch|S|R|P|Co|M)\s?\d", t):     # « 1 Ch 29 », « 1S2 »
        return {"id": "AT"} if re.match(r"^(\d\s?(?:Ch|S|R|P|Co|M)\s?\d|[A-Z][a-z]{0,2}\s?\d)", t) else None
    n = m.group(1)
    if n == "118" and m.group(3) and m.group(3).isdigit():
        return {"id": f"118-{m.group(3)}"}
    e = {"id": n + (m.group(2) or "").upper()}
    if m.group(3) in ROM_P:
        e["partie"] = ROM_P[m.group(3)]
    return e


def pool_antiennes():
    """antiennes connues : (texte, cote, ids des psaumes) — recueil de Gouzes (tous offices), livrets de Sainte-Baume indexés"""
    G = json.load(open(os.path.join(RACINE, "site", "donnees", "gouzes.json")))
    pool = []
    for k, o in G["offices"].items():
        for e in (o.get("psalmodie") or []) + ([o["evangelique"]] if o.get("evangelique") else []):
            if e and e.get("ant"):
                pool.append({"ant": e["ant"], "cote": (e.get("cote") or "").replace(" ", "") or None,
                             "ids": [p.get("id") for p in e.get("pieces", [])], "r": k.startswith("R/")})
    for x in json.load(open(os.path.join(RACINE, "partitions", "sb", "pieces.json"))):
        if x.get("ant"):
            pool.append({"ant": x["ant"], "cote": (x.get("cote") or "").replace(" ", "") or None, "ids": x.get("ids", []), "r": True})
    return pool


def resoudre_antienne(inc, pid, pool):
    """début d'antienne (« Au matin ») → {ant, cote} : même psaume d'abord, puis tout le recueil"""
    t = inc
    for a, b in ABREV:
        t = re.sub(a, b, t)
    n = N(t)
    if len(n) < 3:
        return None
    def score(x):
        a = N(x["ant"])
        if not a.startswith(n[:max(6, min(len(n), 18))]):
            return -1
        return 3 * (pid in (x["ids"] or [])) + x["r"] + (len(n) >= 18)
    c = sorted(((score(x), x) for x in pool), key=lambda s: -s[0])
    return c[0][1] if c and c[0][0] >= 0 else None


def ly_par_paroles(inc):
    """antienne gravée dont les paroles commencent comme l'incipit (sa cote)"""
    t = inc
    for a, b in ABREV:
        t = re.sub(a, b, t)
    n = N(t)[:18]
    if len(n) < 8:
        return None
    for p in PIECES.values():
        if p.get("dossier") == "Antiennes" and p.get("cote") and p.get("fichier") and N(p.get("paroles", "")).startswith(n):
            return p
    return None


def ordinaire(chemin, ly_cotes, sb_pieces):
    tabs = tableaux_docx(chemin)
    pool = pool_antiennes()
    out = {"lectures": {}, "laudes": {}, "milieu": {}, "vepres": {}}
    sans = []

    vus = {}
    def sb_image(office, sem, jour, pid):
        xs = [x for x in sb_pieces if x["office"] == office and x["semaine"] == sem and x["jour"] == jour and pid in (x.get("ids") or []) and x.get("partition")]
        if not xs:
            return None, None
        cle = (office, sem, jour, pid)
        n = vus.get(cle, 0); vus[cle] = n + 1
        if len(xs) == 1:
            fs = xs[0]["partition"]
            fs = [fs[n]] if len(fs) > 1 and n < len(fs) else fs if n == 0 else None
            return fs, (xs[0].get("cote") or "").replace(" ", "") or None
        x = xs[min(n, len(xs) - 1)]
        return x["partition"], (x.get("cote") or "").replace(" ", "") or None

    def element(ligne, office, sem, jour):
        e = piece_to(ligne)
        if not e:
            return None
        reste = re.sub(r"^(\d?\s?[A-Z][a-z]{0,3}\.?\s?\d+(?:,\s?\d+)?(?:-\d+)?|\d+[ab]?(?:-(?:\d+|I{1,3}))?(?:\s*\([^)]*\))?)\s*-?\s*", "", ligne).strip()
        if reste and not re.fullmatch(r"\d.*|3 enfants", reste):
            a = resoudre_antienne(reste, e["id"], pool)
            fs, cote_sb = sb_image(office, sem, jour, e["id"])
            cote = (a or {}).get("cote") or cote_sb or (ly_par_paroles(reste) or {}).get("cote")
            f = ly_cotes.get(cote, [None])[0] if cote else None
            e["ant"] = {"inc": reste.rstrip(" .") , **({"texte": a["ant"]} if a else {}), **({"cote": cote} if cote else {}),
                        **({"f": f} if f else {"sb": fs} if fs else {})}
            if not a:
                sans.append(f"{office} {sem}/{jour} : « {reste} »")
            # cantique dont l'antienne n'est connue que par un mot (« Créatures ») : ni texte ni partition → pas d'antienne
            if e["id"] == "AT" and not a and not e["ant"].get("f") and not e["ant"].get("sb"):
                del e["ant"]
        return e

    def elements_de(lignes, off, sem, jour):
        els = []
        for l in lignes:
            morceaux = re.split(r"\s\+\s|\s-\s(?=\d)", l) if re.match(r"^\d+[ab]?(-\w+)?\s(\+|-)\s\d", l) else [l]
            for morceau in morceaux:
                e = element(morceau, off, sem, jour)
                if e:
                    els.append(e)
                elif els and off == "lectures" and jour == "dimanche":   # « La Terre s'est rassasiée » : autre partie du même psaume
                    a = resoudre_antienne(l, els[-1]["id"], pool)
                    fs, cote_sb = sb_image(off, sem, jour, els[-1]["id"])
                    cote = (a or {}).get("cote") or cote_sb
                    f = ly_cotes.get(cote, [None])[0] if cote else None
                    els.append({"id": els[-1]["id"], "ant": {"inc": l, **({"texte": a["ant"]} if a else {}), **({"cote": cote} if cote else {}),
                                                              **({"f": f} if f else {"sb": fs} if fs else {})}})
                    if not a:
                        sans.append(f"{off} {sem}/{jour} : « {l} »")
        return els

    # tableau 1 : matines + laudes
    jour = None
    for r in tabs[0][1:]:
        nom = r[0][0].strip().lower() if r[0] and r[0][0] else None
        if nom:
            jour = nom
        for sem in range(1, 5):
            lignes = [l for l in r[sem] if l] if sem < len(r) else []
            # dimanche : une ligne pour les matines, la suivante pour les laudes ;
            # en semaine, une seule ligne : 1re entrée = psaumes des matines, puis les trois pièces des laudes
            if jour == "dimanche":
                parts = [("lectures" if nom else "laudes", lignes)]
            else:
                parts = [("lectures", lignes[:1]), ("laudes", lignes[1:])]
            for off, ls in parts:
                out[off][f"{sem}/{jour}"] = elements_de(ls, off, sem, jour)
    # tableau 2 : milieu du jour (psaumes et cote de l'antienne)
    for r in tabs[1][1:]:
        jour = r[0][0].strip().lower()
        for sem in range(1, 5):
            cel = [l for l in r[sem] if l]
            groupes, ps = [], []          # psaumes chantés sous chaque antienne (l'antienne suit ses psaumes dans le tableau)
            for i, l in enumerate(cel):
                m = re.match(r"Ant\.\s*([A-Z])\s?(\d{3})", l)
                if m:
                    c = m.group(1) + m.group(2)
                    texte = cel[i + 1] if i + 1 < len(cel) and not re.match(r"^(Ant|\d)", cel[i + 1]) else None
                    a = resoudre_antienne(texte, None, pool) if texte else None
                    groupes.append({"ps": ps, "ant": {"cote": c, **({"inc": texte.strip()} if texte else {}), **({"texte": a["ant"]} if a and (a.get("cote") in (None, c)) else {}),
                                                      **({"f": ly_cotes[c][0]} if c in ly_cotes else {})}})
                    ps = []
                    continue
                e = piece_to(l)
                if e and e["id"] != "AT" and not (ps and ps[-1] == e["id"]) and not any(e["id"] in g["ps"] for g in groupes):
                    ps.append(e["id"])
            if ps and groupes:
                groupes[-1]["ps"] += ps
            out["milieu"][f"{sem}/{jour}"] = groupes
    # tableau 3 : vêpres (samedi = premières vêpres du dimanche)
    for r in tabs[2][1:]:
        jour = r[0][0].strip().lower()
        for sem in range(1, 5):
            out["vepres"][f"{sem}/{jour}"] = [e for e in (element(l, "vepres", sem, jour) for l in r[sem] if l) if e]
    return out, sans


def main():
    ml = os.path.join(SRC, "Carême Matines et Laudes fr. Max v.4.lytex")
    ml3 = os.path.join(SRC, "Carême Matines et Laudes fr. Max v.3 corr.lytex")
    vp = os.path.join(SRC, "Carême Vêpres fr. Max.lytex")
    a = careme(ml, texte_v3=ml3)
    b = careme(vp, office_unique="vepres")
    for x in (a, b):
        for o in x["offices"].values():
            for L in o.values():
                for e in L:
                    e.pop("src", None)
    donnees = {
        "source": "Livrets de Sainte-Baume (fr. Max) : Carême Matines et Laudes v.4, Carême Vêpres, Milieu du jour, Veillée pascale",
        "careme": {
            "offices": {**a["offices"], **b["offices"]},
            "repons": {"laudes": a["repons"], "vepres": b["repons"]},
            "invitatoire": a["invitatoire"],
            "canon": {"partitions": a["partitions_canon"], "jours": a["canon"]},
            "lucernaire": b["lucernaire"],
            "hymnes": b["hymnes"],
            "fin": {"laudes": fin_de_livret(ml), "vepres": fin_de_livret(vp)},
        },
        "milieu": milieu(os.path.join(SRC, "Milieu du jour Gar.lytex")),
        "vigile": vigile(os.path.join(SRC, "Veillée pascale Choeur.lytex")),
        "cotes": index_gouzantinus(os.path.join(SRC, "1Index gouzantinus Carême.ods")),
    }
    ly_cotes = json.load(open(os.path.join(RACINE, "partitions", "ly", "index.json"))).get("cotes", {})
    to, sans = ordinaire(DOCX_TO, ly_cotes, json.load(open(os.path.join(RACINE, "partitions", "sb", "pieces.json"))))
    donnees["ordinaire"] = to
    for r in list(donnees["careme"]["repons"]["laudes"].values()) + list(donnees["careme"]["repons"]["vepres"].values()):
        r.pop("src", None)
        if r.get("ev"):
            r["ev"].pop("src", None)
    json.dump(donnees, open(SORTIE, "w"), ensure_ascii=False, separators=(",", ":"))
    c = donnees["careme"]
    print(f"{SORTIE} : {os.path.getsize(SORTIE) // 1024} Ko")
    for o, v in c["offices"].items():
        print(f"  {o} : {len(v)} jours, {sum(1 for L in v.values() for e in L if e['t'] == 'ant')} antiennes")
    print(f"  répons laudes {sorted(c['repons']['laudes'])} ; vêpres {sorted(c['repons']['vepres'])}")
    print(f"  canon : {len(c['canon']['jours'])} jours ; invitatoires {len(c['invitatoire'])} ; hymnes vêpres {len(c['hymnes'])} ; lucernaire {len((c['lucernaire'] or {}).get('couplets', []))} couplets")
    print(f"  milieu : {len(donnees['milieu']['semaines'])} jours, temps {sorted(donnees['milieu']['temps'])}, {len(donnees['milieu']['hymnes'])} hymnes")
    print(f"  vigile : {len(donnees['vigile'])} sections ; cotes : {len(donnees['cotes'])}")
    n_ant = sum(1 for o in ("lectures", "laudes", "vepres") for L in to[o].values() for e in L if e.get("ant"))
    print(f"  temps ordinaire : {n_ant} antiennes ; texte non retrouvé : {len(sans)}")
    for x in sans:
        print("    " + x)
    if manquants:
        print("  partitions non gravées :", sorted(set(manquants)))


if __name__ == "__main__":
    main()
