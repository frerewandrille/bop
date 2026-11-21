"""Index de recherche de la Bible (page « Recherche » du téléphone, recherche.js).

    python3 bible/recherche.py        (après extract.py, latin.py et les données de la Bible chrétienne)

Écrit bible/data/rech/ :
  <portée>/docs.js        window.__RD   liste des documents (un verset, une note, un extrait des Pères…)
  <portée>/i/<xx>.js      window.__RI   {mot: [n° de document, en écarts]} pour les mots commençant par xx
  <portée>/t/<groupe>.js  window.__RT   {n° de document: texte}, pour afficher les extraits
  orig.js                 window.__RO   formes et lemmes grecs et hébreux → numéros Strong
Portées : bj (texte de la BJ et ses titres), notes (notes de la BJ), lat (Nova Vulgata, avec les lemmes de
Collatinus si data/latin existe), peres (Chaîne d'or), dico (8 dictionnaires, titres et textes),
bc (Bible chrétienne, commentaire).
La façon de découper les mots est la même que dans recherche.js (fonction mots()) : la changer aux deux endroits.
"""
import glob, json, os, re, unicodedata

ICI = os.path.dirname(os.path.abspath(__file__))
DATA = os.path.join(ICI, "data")
OUT = os.path.join(DATA, "rech")


def lire(f):
    s = open(f, encoding="utf8").read()
    return json.loads(s[s.index("=") + 1:].rstrip().rstrip(";"))


def ecrire(rel, var, obj):
    p = os.path.join(OUT, rel)
    os.makedirs(os.path.dirname(p), exist_ok=True)
    with open(p, "w", encoding="utf8") as fh:
        fh.write(f"window.{var}=" + json.dumps(obj, ensure_ascii=False, separators=(",", ":")) + ";\n")


def texte(h):
    """HTML → texte simple (sans les appels de note)."""
    h = re.sub(r'<sup[^>]*>.*?</sup>', "", h or "")
    h = re.sub(r"<br\s*/?>|</p>|</li>", " ", h)
    h = re.sub(r"<[^>]+>", "", h)
    h = h.replace("&nbsp;", " ").replace("&amp;", "&").replace("&lt;", "<").replace("&gt;", ">").replace("&quot;", '"')
    return re.sub(r"\s+", " ", h).strip()


def norm(s):
    s = unicodedata.normalize("NFD", s.lower())
    s = "".join(c for c in s if not unicodedata.combining(c))
    return s.replace("æ", "ae").replace("œ", "oe")


def mots(s):
    return re.findall(r"[a-z0-9]+", norm(s))


class Index:
    def __init__(self, nom):
        self.nom, self.docs, self.post, self.textes = nom, [], {}, {}

    def ajouter(self, meta, txt, groupe=None, garder=True, extra=()):
        n = len(self.docs)
        self.docs.append(meta)
        for m in set(mots(txt)) | set(extra):
            self.post.setdefault(m, []).append(n)
        if garder and groupe is not None:
            self.textes.setdefault(groupe, {})[n] = txt
        return n

    def ecrire(self):
        docs = self.docs
        if self.nom in ("bj", "lat"):
            # versets : par chapitre [livre, chapitre, [n° des versets]] (le navigateur refait la liste à plat)
            docs, prec = [], None
            for b, c, v in self.docs:
                if (b, c) != prec:
                    docs.append([b, c, []]); prec = (b, c)
                docs[-1][2].append(v)
            docs = {"chapitres": docs}
        elif self.nom == "peres":
            # auteurs et sources en tables : [livre, ch1, v1, ch2, v2, n° auteur, n° source]
            A, S = [], []
            def idx(t, x):
                if x not in t: t.append(x)
                return t.index(x)
            docs = {"auteurs": A, "sources": S, "d": [d[:5] + [idx(A, d[5]), idx(S, d[6])] for d in self.docs]}
        elif self.nom == "bc":
            # sections en table : [n° de section dans la table, page]
            T = []
            for d in self.docs:
                if not T or T[-1][0] != d[0]: T.append(d[:3])
            pos = {t[0]: i for i, t in enumerate(T)}
            docs = {"sections": T, "d": [[pos[d[0]], d[3]] for d in self.docs]}
        ecrire(f"{self.nom}/docs.js", "__RD", docs)
        parts = {}
        for m, l in self.post.items():
            # « @mot » (lemme latin) → fichier _m ; « #mot » (mot d'un titre de dictionnaire) → fichier ~m
            cle = (m[:2] if len(m) > 1 else m + "_").replace("@", "_").replace("#", "~")
            ec, prec = [], 0
            for x in sorted(set(l)):
                ec.append(x - prec); prec = x
            parts.setdefault(cle, {})[m] = ec
        for cle, d in parts.items():
            ecrire(f"{self.nom}/i/{cle}.js", "__RI", d)
        for g, d in self.textes.items():
            ecrire(f"{self.nom}/t/{g}.js", "__RT", d)
        taille = sum(os.path.getsize(f) for f in glob.glob(os.path.join(OUT, self.nom, "**", "*.js"), recursive=True))
        print(f"  {self.nom:6s} {len(self.docs):6d} documents, {len(self.post):6d} mots, {taille // 1048576} Mo")


def main():
    import shutil
    shutil.rmtree(OUT, ignore_errors=True)
    books = lire(os.path.join(DATA, "books.js"))
    bi = {b["c"]: i for i, b in enumerate(books)}
    bj, notes, lat = Index("bj"), Index("notes"), Index("lat")
    # Collatinus : forme latine → lemmes (data/latin, voir latin.py), pour chercher toutes les formes d'un mot
    lem, lat_formes = [], {}
    if os.path.exists(os.path.join(DATA, "latin", "lemmes.js")):
        lem = lire(os.path.join(DATA, "latin", "lemmes.js"))
        for f in glob.glob(os.path.join(DATA, "latin", "*.js")):
            if not f.endswith("lemmes.js"):
                lat_formes.update(lire(f))
    def lemmes_latins(t):
        out = set()
        for m in mots(t):
            for n, _ in lat_formes.get(m, [])[:2]:
                out.add("@" + norm(re.sub(r"\d+$", "", lem[n][0])).replace("v", "u").replace("j", "i"))
        return out
    grec, hebreu = {}, {}
    def orig_norm(w, heb):
        w = unicodedata.normalize("NFD", w)
        w = "".join(c for c in w if not unicodedata.combining(c) and not ("֑" <= c <= "ׇ"))
        w = re.sub(r"[^\w]", "", w.lower()).replace("ς", "σ")
        return w
    for b in books:
        for c in b["ch"]:
            f = os.path.join(DATA, b["c"], f"{c:03d}.js")
            if not os.path.exists(f):
                continue
            ch = lire(f)
            for v in ch.get("bj", []):
                titres = " ".join(texte(t) for _, t in v.get("h", []))
                t = texte(v.get("t", ""))
                bj.ajouter([bi[b["c"]], c, v["v"]], t + (" " + titres if titres else ""), b["c"], garder=False)
                bj.textes.setdefault(b["c"], {})[len(bj.docs) - 1] = t
                for k, nh in v.get("n", []):
                    notes.ajouter([bi[b["c"]], c, v["v"], k], texte(nh), b["c"])
            for v, t in (ch.get("lat", {}).get("NVU") or {}).items():
                t = texte(t)
                lat.ajouter([bi[b["c"]], c, v], t, b["c"], extra=lemmes_latins(t))
            for ws in (ch.get("il") or {}).values():
                for w in ws:
                    s = w.get("s")
                    if not s:
                        continue
                    heb = s.startswith("H")
                    d = hebreu if heb else grec
                    for x in (w.get("w"), w.get("l")):
                        if x:
                            k = orig_norm(x, heb)
                            if k:
                                d.setdefault(k, set()).add(s)
    bj.ecrire(); notes.ecrire(); lat.ecrire()
    # Pères : Chaîne d'or
    peres = Index("peres")
    for f in sorted(glob.glob(os.path.join(DATA, "tae", "*", "*.js"))):
        b = os.path.basename(os.path.dirname(f))
        for s in lire(f):
            for a, src, h in s.get("x", []):
                peres.ajouter([bi[b], s["c1"], s["v1"], s["c2"], s["v2"], a, src], texte(h), f"{b}{s['c1']}", extra=set(mots(a)))
    peres.ecrire()
    # dictionnaires : titres et textes (le texte n'est pas gardé : il est lu à l'ouverture de l'article)
    dico = Index("dico")
    di = lire(os.path.join(DATA, "dico", "index.js"))
    for d in di["d"]:
        for f in sorted(glob.glob(os.path.join(DATA, "dico", d["c"], "*.js"))):
            for titre, h in lire(f).items():
                t = texte(h)
                dico.ajouter([d["i"], titre], titre + " " + t, garder=False, extra={"#" + m for m in mots(titre)})
    dico.ecrire()
    # Bible chrétienne, commentaire (volume II*), si présent
    if os.path.exists(os.path.join(DATA, "bc", "index.js")):
        bc = Index("bc")
        for s in lire(os.path.join(DATA, "bc", "index.js"))["sections"]:
            f = os.path.join(DATA, "bc", "s", f"{s['i']}.js")
            if not os.path.exists(f):
                continue
            for p in lire(f).get("paras", []):
                bc.ajouter([s["i"], s["n"], s["t"], p.get("page", "")], texte(p.get("t", "")), s["i"])
        bc.ecrire()
    ecrire("orig.js", "__RO", {"g": {k: sorted(v) for k, v in grec.items()}, "h": {k: sorted(v) for k, v in hebreu.items()}})
    print(f"  grec : {len(grec)} formes ; hébreu : {len(hebreu)} formes")
    tot = sum(os.path.getsize(f) for f in glob.glob(os.path.join(OUT, "**", "*.js"), recursive=True))
    print(f"Index de recherche : {tot // 1048576} Mo dans {OUT}")


if __name__ == "__main__":
    main()
