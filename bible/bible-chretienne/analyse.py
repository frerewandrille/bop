"""Bible chrétienne II* (Commentaires des Évangiles, 1988) : du texte OCR (ocr/*.txt) aux données.

    python3 bible/bible-chretienne/analyse.py

Produit, dans ce dossier :
  livre.json  — le livre structuré : introduction, puis chaque § (titre, page, références,
                paragraphes typés : texte, verset, Père, Ancien Testament, note) ;
  livre.md    — le même en texte lisible, pour relire et corriger l'OCR ;
et pour la Bible en ligne, dans ../data/bc/ :
  index.js    — window.__BC_INDEX : liste des § et, par livre et chapitre, les § qui le commentent ;
  s/NNN.js    — window.__BC : un § (paragraphes et versets visés).
"""
import json, os, re, glob
from collections import Counter

D = os.path.dirname(os.path.abspath(__file__))
OCR = os.path.join(D, "ocr")
APP = os.path.join(D, "..", "data", "bc")
EV = {"Mt": "MAT", "Mc": "MRK", "Lc": "LUK", "Jn": "JHN"}
DEBUT, FIN = (6, "d"), (408, "g")  # Introduction (p. IX) … dernière page avant les tables (p. 792)


def page_livre(p, cote):
    """Numéro de page imprimé : planche PDF p, côté g/d."""
    n = 2 * p - (24 if cote == "g" else 23)
    if n >= 1:
        return str(n)
    n = 2 * p - (4 if cote == "g" else 3)
    r = ""
    for v, s in ((10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")):
        while n >= v:
            r += s; n -= v
    return r


# ---------- nettoyage de l'OCR ----------
def corrige(s):
    s = re.sub(r"^[._\-‘'`,]+ ?(?=[$§&8] ?\d)", "", s)
    s = re.sub(r"^(?:8|&|\$\.?|S|Ÿ) ?(?=\d{1,3}(?:-\d+)?[.,] ?[A-ZÀ-Ý«(])", "§ ", s)
    s = re.sub(r"\$ ?\.?(?=\d)", "§ ", s)
    s = re.sub(r"\b(?:Le|Lec|Lce)(?= \d+[,.]\d)", "Lc", s)
    s = re.sub(r"\b(?:Me|Mec|Mce)(?= \d+[,.]\d)", "Mc", s)
    s = re.sub(r"\bIn(?= \d+,\d)", "Jn", s)
    s = re.sub(r"\b(Mt|Mc|Lc|Jn)(?=\d+,\d)", r"\1 ", s)
    s = re.sub(r"\b(Mt|Mc|Lc|Jn) (\d+)\.(\d)", r"\1 \2,\3", s)
    s = re.sub(r"(?<=[\s(«])/(a|e|es|ui|eur|eurs|à)\b", r"l\1", s)  # italique : « /a » = « la »
    s = re.sub(r"(?<=[\s(])[/#] (?=(?:[1-3] )?[A-Z][a-zé]{0,3} \d)", "▸ ", s)  # renvoi aux textes de l'A.T.
    s = s.replace("’", "'").replace("‘", "'").replace("< ", "« ").replace(" >", " »")
    s = re.sub(r"«(?=\S)", "« ", s); s = re.sub(r"(?<=\S)»", " »", s)
    return s


ENTETE = re.compile(r"^(?:[§$] ?[\d ,.\-–]+.*|\d{1,3}|[IVXL]{1,6}|.{0,6})$")


def lire_pages():
    pages = []
    for p in range(DEBUT[0], FIN[0] + 1):
        for cote in "gd":
            if (p, cote) < DEBUT or (p, cote) > FIN:
                continue
            f = os.path.join(OCR, f"{p:03d}-{cote}.txt")
            if not os.path.exists(f):
                continue
            lignes = open(f, encoding="utf-8").read().replace("\f", "").split("\n")
            entete = ""
            while lignes and not lignes[0].strip():
                lignes.pop(0)
            if lignes and len(lignes[0]) < 45 and ENTETE.match(lignes[0].strip()) and not re.search(r"[A-ZÀ-Ý]{4,}", lignes[0]):
                entete = lignes.pop(0).strip()
            pages.append({"page": page_livre(p, cote), "entete": corrige(entete), "lignes": [corrige(l.rstrip()) for l in lignes]})
    return pages


# ---------- paragraphes ----------
PERE = re.compile(r"^((?:SAINT |S\. )?[A-ZÀ-ÝŒ][A-ZÀ-ÝŒ'\- .]{2,}(?: (?:DE|D'|DU|LE|LA) ?[A-ZÀ-ÝŒ][A-ZÀ-ÝŒ'\- .]+)*) ?: (.*)$")
REFS = r"(?:\(?(?:Mt|Mc|Lc|Jn) \d+,[\dab\-.;, ]+\)?[;,]? ?)+"
VERSET = re.compile(r"^(" + REFS + r")\s*(?:[:—–-]|$)\s*(.*)$")
AT = re.compile(r"^(?:▸|[#1/|!I]) ?(?=(?:[1-3] )?(?!Mt|Mc|Lc|Jn)[A-Z][a-zé]{0,3} \d)")
NOTE = re.compile(r"^\((\d{1,2})\) ")
TITRE = re.compile(r"^§ ?(\d+(?: ?[-–] ?\d+)?(?: et \d+)?(?: ?bis| ?ter)?)[.,] (.+)$")


def est_titre(reste):
    if re.match(r"^[^:]{3,80}: ?\(?(?:Mt|Mc|Lc|Jn) \d+,", reste):  # « § 145. mission des Douze: Mc 6,7-13 »
        return True
    if re.match(r"^\(?(?:Mt|Mc|Lc|Jn) \d+,", reste):  # « § 80. Jn 3,31-36 — … » : titre dans la table
        return True
    tete = re.split(r"\s*(?::|—|–|\. )", reste)[0]
    lettres = re.sub(r"[^A-Za-zÀ-ÿŒœ]", "", tete)
    return len(lettres) >= 4 and sum(c.isupper() for c in lettres) / len(lettres) > 0.6


def coupe_titre(reste):
    """« LA TEMPÊTE APAISÉE : Mc 4,35-41 ; Lc … — Mc est plus … » -> titre, références, début du texte."""
    if re.match(r"^\(?(?:Mt|Mc|Lc|Jn) \d+,", reste):
        titre, suite = "", reste
    else:
        m = re.match(r"^(.*?)\s*(?::|\. (?=[A-ZÀ-Ý])|—|$)\s*(.*)$", reste)
        titre, suite = m.group(1), m.group(2)
    m = re.match(r"^((?:\(?(?:Mt|Mc|Lc|Jn)? ?\d+, ?[\d\-–.;,ab ]+\)?(?:= § \d+\)?)?[;,]? ?)*)\s*(?:[—–]\s*(.*))?$", suite)
    if m and m.group(1).strip():
        return titre.strip(), m.group(1).strip(" ;,"), (m.group(2) or "").strip()
    return titre.strip(), "", suite.strip()


def paragraphes(pages, vocab):
    """Rassemble les lignes en paragraphes (lignes vides ou débuts typés), recolle les coupures de mots."""
    paras, cur = [], None

    def fin():
        nonlocal cur
        if cur and cur["t"].strip():
            paras.append(cur)
        cur = None

    for pg in pages:
        for l in pg["lignes"]:
            s = l.strip()
            if not s:
                fin(); continue
            nouveau = TITRE.match(s) and est_titre(TITRE.match(s).group(2))
            fin_phrase = cur is None or re.search(r"[.!?»)]$", cur["t"])
            nouveau = nouveau or NOTE.match(s) or (fin_phrase and (PERE.match(s) or AT.match(s) or VERSET.match(s)))
            if nouveau:
                fin()
            if cur is None:
                cur = {"t": s, "page": pg["page"], "entete": pg["entete"]}
            elif re.search(r"\w-$", cur["t"]) and s[:1].isalpha():
                avant = re.search(r"(\S+)-$", cur["t"]).group(1)
                apres = re.match(r"([\w']+)", s).group(1)
                mot = re.sub(r"\W", "", (avant + apres).lower())
                trait = s[0].isupper() or not avant[-1:].isalpha() or vocab[(avant + "-" + apres).lower()] > vocab[mot] \
                    or apres.lower() in ("même", "mêmes", "là", "ci", "t", "être", "dire", "delà", "dessus", "dessous")
                cur["t"] = cur["t"][:-1] + ("-" if trait else "") + s
            else:
                cur["t"] += " " + s
    fin()
    return paras


# ---------- références ----------
def refs_de(texte, livre=None):
    """« Mc 4,38; Lc 8,24; (Mt 8,25) » -> [["MRK",4,38,4,38], …]. Sans abréviation : livre donné."""
    out, lv = [], livre
    texte = texte.replace("]", "1").replace("l", "1").replace("à", "-").replace(" ", "")
    for m in re.finditer(r"(Mt|Mc|Lc|Jn)?(\d+),([\dab.\-]+)(?:-(\d+),(\d+))?", texte):
        if m.group(1):
            lv = EV[m.group(1)]
        if not lv:
            continue
        c = int(m.group(2))
        if m.group(4):  # 2,18-3,6
            v1 = int(re.match(r"\d+", m.group(3)).group())
            out.append([lv, c, v1, int(m.group(4)), int(re.match(r"\d+", m.group(5)).group())])
            continue
        for bout in m.group(3).split("."):
            n = [int(x) for x in re.findall(r"\d+", bout)]
            if n:
                out.append([lv, c, n[0], c, n[-1] if len(n) > 1 and n[-1] >= n[0] else n[0]])
    return out


DERNIER = [0]


def plausible(n, page, tab):
    """Un « § 9. … » trouvé p. 349, entre les § 120 et 122, est un renvoi et non un titre :
    on garde un titre proche du § précédent, ou proche de la page que lui donne la table."""
    k = int(re.match(r"\d+", n).group())
    e = tab.get(str(k)) or {}
    proche = abs(k - DERNIER[0]) <= 12 or (e.get("page") and str(page).isdigit() and abs(int(page) - e["page"]) <= 25)
    if proche:
        DERNIER[0] = k
    return bool(proche)


def refs_table(n, table):
    """Références d'un § (ou d'un groupe « 51-59 », « 339-340 et 344 ») d'après la Table générale."""
    nums = set()
    for a, b in re.findall(r"(\d+)(?:-(\d+))?", n):
        a = int(a); b = int(b) if b else a
        if b < a:  # « 295-96 »
            b = int(str(a)[:-len(str(b))] + str(b))
        nums.update(range(a, b + 1))
    out = []
    for e in table:
        premier = int(re.match(r"\d+", e["n"]).group())
        if premier in nums:
            out += [r for ev in ("Mt", "Mc", "Lc", "Jn") if e.get(ev) for r in refs_de(e[ev], EV[ev])]
    return [list(r) for r in dict.fromkeys(tuple(r) for r in out)]


# plan du livre (Table générale) : partie, section, premier §
PLAN = [("I. Préludes", "1. Les deux prologues", 1), ("I. Préludes", "2. L'enfance de Jésus", 3),
        ("I. Préludes", "3. Baptême et tentation", 19),
        ("II. Les premiers temps", "1. Premiers miracles, premières controverses", 28),
        ("II. Les premiers temps", "2. Le Sermon sur la Montagne", 50),
        ("II. Les premiers temps", "3. L'évangélisation des foules", 77),
        ("III. Jésus prépare l'avenir", "1. La conception de l'Église", 146),
        ("III. Jésus prépare l'avenir", "2. La montée à Jérusalem", 183),
        ("III. Jésus prépare l'avenir", "3. Ministère en Judée", 246),
        ("IV. Le sacrifice pascal", "1. Les derniers jours", 279),
        ("IV. Le sacrifice pascal", "2. La dernière Cène", 312),
        ("IV. Le sacrifice pascal", "3. La Passion", 335),
        ("IV. Le sacrifice pascal", "4. La Résurrection", 359)]


def place(n):
    m = re.match(r"\d+", n)
    if not m:
        return "", ""
    p = [x for x in PLAN if x[2] <= int(m.group())]
    return p[-1][:2] if p else ("", "")


def casse(titre, maj):
    """« LE POSSÉDÉ DE GADARA » -> « Le possédé de Gadara » (noms propres d'après leur usage dans le livre)."""
    if not titre or sum(c.isupper() for c in titre) < 0.6 * sum(c.isalpha() for c in titre):
        return titre
    mots = re.split(r"(\W+)", titre.lower())
    out = []
    for i, w in enumerate(mots):
        if w and w[0].isalpha() and maj.get(w, 0) > 0:
            w = w[0].upper() + w[1:]
        out.append(w)
    t = "".join(out)
    i = next((k for k, c in enumerate(t) if c.isalpha()), 0)
    return t[:i] + t[i:i + 1].upper() + t[i + 1:]


def pour_app(livre):
    """Fichiers de la Bible en ligne (data/bc/) :
    index.js     window.__BC_INDEX = {livre, sections: [{i, n, t, p, r, partie, section}], num: {« 141 »: i}}
    s/NNN.js     window.__BC = une section (titre, références, paragraphes)
    LIV/CCC.js   window.__BCC = {s: [[i, c1, v1, c2, v2], …] les § qui portent sur ce chapitre,
                                 v: [[c1, v1, c2, v2, i, paragraphe], …] les paragraphes qui visent un verset}"""
    import shutil
    # noms propres : mots écrits avec majuscule hors début de phrase plus souvent qu'en minuscule
    cpt = Counter()
    for s in livre["sections"]:
        for q in s["paras"]:
            for m in re.finditer(r"(?<=[a-zé,;] )([A-Za-zÀ-ÿŒœ]+)", q["t"]):
                w = m.group(1)
                cpt[w.lower()] += 1 if w[0].isupper() and not w.isupper() else -1
    maj = {w: n for w, n in cpt.items() if n > 0 and len(w) > 1}
    table = json.load(open(os.path.join(D, "table.json"), encoding="utf-8"))
    titres = {re.match(r"\d+", e["n"]).group(): e["titre"] for e in table}
    for t in table:  # noms propres des titres de la table
        for w in re.findall(r"(?<=\s)([A-ZÀ-Ý][a-zà-ÿ]{3,})", t["titre"]):
            maj[w.lower()] = 1
    for w in ("dieu", "christ", "jésus", "esprit", "seigneur", "père", "fils", "royaume", "temple"):
        maj[w] = 1

    if os.path.isdir(APP):
        shutil.rmtree(APP)
    os.makedirs(os.path.join(APP, "s"))
    index, num, chap = [], {}, {}
    for i, s in enumerate(livre["sections"]):
        cle = f"{i:03d}"
        titre = re.sub(r"\s+(?:[IV]+|I[lT1])\.\s+[A-ZÀ-Ý'’ ]{3,}.*$", "", s.get("titre_table") or "") or casse(s["titre"], maj)
        titre = re.sub(r"\s*\(?(?:Mt|Mc|Lc|Jn) \d+,.*$", "", titre).strip(" :—-")  # références restées dans le titre
        if not titre:
            m = re.match(r"\d+", s["n"])
            titre = (titres.get(m.group(), "") if m else "") or s.get("refs_texte", "") or "Suite du commentaire"
        s = dict(s, titre=titre, i=cle)
        s.pop("titre_table", None)
        index.append({"i": cle, "n": s["n"], "t": titre, "p": s["page"], "r": s.get("refs", []),
                      "partie": place(s["n"])[0], "section": place(s["n"])[1]})
        for a, b in re.findall(r"(\d+)(?:-(\d+))?", s["n"]):  # « 141-143 » répond à 141, 142, 143
            a = int(a); b = int(b) if b and int(b) > a else a
            for k in range(a, b + 1):
                if str(k) not in num or s["n"] == str(k):
                    num[str(k)] = cle
        for lv, c1, v1, c2, v2 in s.get("refs", []):
            for c in range(c1, c2 + 1):
                chap.setdefault(lv, {}).setdefault(c, {"s": [], "v": []})["s"].append([cle, c1, v1, c2, v2])
        for j, q in enumerate(s["paras"]):
            for lv, c1, v1, c2, v2 in q.get("refs", []):
                for c in range(c1, c2 + 1):
                    chap.setdefault(lv, {}).setdefault(c, {"s": [], "v": []})["v"].append([c1, v1, c2, v2, cle, j])
        with open(os.path.join(APP, "s", cle + ".js"), "w", encoding="utf-8") as f:
            f.write("window.__BC=" + json.dumps(s, ensure_ascii=False, separators=(",", ":")) + ";\n")
    for lv, cs in chap.items():
        os.makedirs(os.path.join(APP, lv), exist_ok=True)
        for c, d in cs.items():
            with open(os.path.join(APP, lv, f"{c:03d}.js"), "w", encoding="utf-8") as f:
                f.write("window.__BCC=" + json.dumps(d, ensure_ascii=False, separators=(",", ":")) + ";\n")
    with open(os.path.join(APP, "index.js"), "w", encoding="utf-8") as f:
        f.write("window.__BC_INDEX=" + json.dumps({"livre": {k: livre[k] for k in ("titre", "auteurs", "edition")},
                                                  "sections": index, "num": num},
                                                 ensure_ascii=False, separators=(",", ":")) + ";\n")


def main():
    pages = lire_pages()
    vocab = Counter(w.lower() for pg in pages for l in pg["lignes"] for w in re.findall(r"[A-Za-zÀ-ÿŒœ]+(?:-[A-Za-zÀ-ÿŒœ]+)*(?!-$)", l))
    table = json.load(open(os.path.join(D, "table.json"), encoding="utf-8"))
    tab = {}
    for e in table:
        tab.setdefault(e["n"].replace(" ", ""), e)

    livre = {"titre": "Bible chrétienne II* — Commentaires",
             "auteurs": "Dom Claude Jean-Nesmy ; Mère Élisabeth de Solms ; Mère Cécile Miville-Dechêne",
             "edition": "Éditions Anne Sigier / Desclée, 1988",
             "sections": []}
    sec = {"n": "intro", "titre": "Introduction générale à Bible chrétienne II", "page": pages[0]["page"], "paras": []}
    livre["sections"].append(sec)
    for p in paragraphes(pages, vocab):
        t = p["t"]
        m = TITRE.match(t)
        if m and est_titre(m.group(2)) and plausible(m.group(1), p["page"], tab):
            n = re.sub(r"\s+", "", m.group(1)).replace("–", "-").replace("et", " et ")
            titre, refs, reste = coupe_titre(m.group(2))
            e = tab.get(n) or tab.get(n.split("-")[0]) or {}
            sec = {"n": n, "titre": titre or e.get("titre", ""), "titre_table": tab[n]["titre"] if n in tab else "", "page": p["page"],
                   "partie": e.get("partie", ""), "section": e.get("section", ""),
                   "refs_texte": refs, "refs": refs_de(refs) or refs_table(n, table),
                   "paras": []}
            livre["sections"].append(sec)
            if not reste:
                continue
            p = dict(p, t=reste)
            t = reste
        para = {"t": t, "page": p["page"]}
        if (m := NOTE.match(t)):
            para.update(k="note", n=m.group(1), t=t[m.end():])
        elif AT.match(t):
            para.update(k="at", t=AT.sub("", t))
        elif (m := PERE.match(t)) and len(m.group(1)) < 40 and m.group(1).strip() not in ("TOB", "BJ", "N.B", "NB"):
            para.update(k="pere", auteur=m.group(1).strip().title(), t=m.group(2))
        elif (m := VERSET.match(t)):
            para.update(k="verset", ref=m.group(1).strip(" ;,"), refs=refs_de(m.group(1)), t=m.group(2))
        else:
            para["k"] = "texte"
        # versets visés par la page (en-tête courant « § 50, Mt 5,4-5 »)
        if p["entete"] and (r := refs_de(p["entete"])):
            para["page_refs"] = r
        sec["paras"].append(para)

    # fautes d'OCR, mot à mot, d'après le contexte : même correcteur que le volume de texte (textes/corrige.py),
    # puis les corrections choisies à la main (corrections_manuelles.tsv) ; relevé dans corrections.tsv
    import sys
    sys.path.insert(0, os.path.join(D, "textes"))
    from corrige import Correcteur
    C = Correcteur(); C.manuelles(os.path.join(D, "corrections_manuelles.tsv"))
    C.prepare([sec["titre"] for sec in livre["sections"]] + [p["t"] for sec in livre["sections"] for p in sec["paras"]])
    for sec in livre["sections"]:
        sec["titre"] = C.applique_manuelles(C.texte(sec["titre"]))
        for para in sec["paras"]:
            para["t"] = C.applique_manuelles(C.texte(para["t"]))
    C.releve(os.path.join(D, "corrections.tsv"))
    print(f"corrections : {sum(C.faites.values())} ({len(C.faites)} formes) — voir corrections.tsv")

    json.dump(livre, open(os.path.join(D, "livre.json"), "w", encoding="utf-8"), ensure_ascii=False, indent=1)

    # lecture
    with open(os.path.join(D, "livre.md"), "w", encoding="utf-8") as f:
        f.write(f"# {livre['titre']}\n\n{livre['auteurs']} — {livre['edition']}\n\n")
        f.write("> Texte obtenu par OCR, non relu. Chaque paragraphe porte sa page (p. N).\n\n")
        for s in livre["sections"]:
            f.write(f"\n## § {s['n']}. {s['titre']}" + (f" — {s['refs_texte']}" if s.get("refs_texte") else "") + f"  (p. {s['page']})\n\n")
            for q in s["paras"]:
                pre = {"verset": f"**{q.get('ref', '')}** — ", "pere": f"**{q.get('auteur', '')}** : ",
                       "at": "▸ ", "note": f"({q.get('n')}) "}.get(q["k"], "")
                f.write(f"{pre}{q['t']}  ⟨p. {q['page']}⟩\n\n")

    if os.environ.get("BCT_SANS_DATA"): print("data/bc non écrit (BCT_SANS_DATA)")
    else: pour_app(livre)

    # bilan
    vus = {s["n"] for s in livre["sections"]}
    manquants = [e["n"] for e in table if e.get("page") and e["n"].replace(" ", "") not in vus
                 and not any(e["n"].split("-")[0] == v.split("-")[0] for v in vus)]
    kinds = Counter(q["k"] for s in livre["sections"] for q in s["paras"])
    print(f"{len(livre['sections'])} sections, {sum(kinds.values())} paragraphes {dict(kinds)}")
    print("§ de la table non trouvés dans le texte :", " ".join(manquants) or "aucun")
    print("Taille des données app :", sum(os.path.getsize(x) for x in glob.glob(os.path.join(APP, "**", "*.js"), recursive=True)) // 1024, "Ko")


if __name__ == "__main__":
    main()
