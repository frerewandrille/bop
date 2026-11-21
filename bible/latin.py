"""Analyse des mots latins de la Vulgate (Nova Vulgata, Clémentine) pour la fiche « mot latin ».

Biblia Universalis n'a pas de dictionnaire latin. On utilise Collatinus (Y. Ouvrard, Ph. Verkerk,
licence GNU GPL), dans sa version Python « pycollatinus », et ses sens français (collatinus/lemmes.fr).

Une fois (environnement à part, dans bible/.venv-latin, hors de git) :
    python3 -m venv bible/.venv-latin
    bible/.venv-latin/bin/pip install pycollatinus==0.1.6
    (corriger une ligne trop ancienne : voir corriger_pycollatinus() plus bas, fait automatiquement)
Puis, après chaque  python3 bible/extract.py :
    bible/.venv-latin/bin/python bible/latin.py

Écrit data/latin/lemmes.js  (window.__LEM = [[clé, mot, sens], …])
  et  data/latin/<lettre>.js (window.__LAT = {forme: [[n° du lemme, "analyse ; analyse"], …]}).
"""
import glob, json, os, re, unicodedata

ICI = os.path.dirname(os.path.abspath(__file__))
DATA = os.path.join(ICI, "data")


def corriger_pycollatinus():
    import importlib.util
    spec = importlib.util.find_spec("pycollatinus")
    f = os.path.join(os.path.dirname(spec.origin), "util.py")
    s = open(f).read()
    if "from collections import OrderedDict, Callable" in s:
        open(f, "w").write(s.replace("from collections import OrderedDict, Callable",
                                     "from collections import OrderedDict\nfrom collections.abc import Callable"))


def cle_forme(w):
    w = unicodedata.normalize("NFD", w.lower())
    return "".join(c for c in w if not unicodedata.combining(c)).replace("æ", "ae").replace("œ", "oe")


def uv(k):
    """Collatinus écrit ses clés avec u et i (uerbum) ; lemmes.fr avec v et j (verbum)."""
    return k.lower().replace("v", "u").replace("j", "i")


def main():
    corriger_pycollatinus()
    from pycollatinus import Lemmatiseur
    L = Lemmatiseur()
    sens = {}
    for l in open(os.path.join(ICI, "collatinus", "lemmes.fr"), encoding="utf8"):
        if ":" in l and not l.startswith("!"):
            k, v = l.rstrip("\n").split(":", 1)
            sens[uv(k)] = v
    formes = {}
    for f in glob.glob(os.path.join(DATA, "*", "[0-9][0-9][0-9].js")):
        s = open(f, encoding="utf8").read()
        d = json.loads(s[s.index("=") + 1:].rstrip().rstrip(";"))
        for txt in (d.get("lat") or {}).values():
            for t in (txt or {}).values():
                for w in re.findall(r"[A-Za-zÀ-ÿæœÆŒ]+", re.sub(r"<[^>]+>", " ", t)):
                    k = cle_forme(w)
                    formes[k] = formes.get(k, 0) + 1
    print(f"{len(formes)} formes différentes")
    lemmes, num, sortie, rates = [], {}, {}, 0
    for k in sorted(formes):
        try:
            res = L.lemmatise(k, pos=True, get_lemma_object=True)
        except Exception:
            res = []
        par = {}
        for r in res:
            lo = r["lemma"]
            if not hasattr(lo, "cle"):          # forme irrégulière : on remonte à son lemme
                lo = getattr(lo, "_lemme", None)
                if lo is None or not hasattr(lo, "cle"):
                    continue
            c = lo.cle()
            par.setdefault(c, (lo, []))
            m = r.get("morph") or ""
            if m and m != "-" and m not in par[c][1]:
                par[c][1].append(m)
        if not par:
            rates += 1
            continue
        # d'abord les lemmes qui ont un sens, parmi eux celui qui est la forme elle-même (caritas → caritas, pas careo),
        # puis les plus fréquents (nombre d'occurrences selon Collatinus)
        def rang(x):
            lo = x[0]
            c = uv(re.sub(r"\d+$", "", lo.cle()))
            return (not sens.get(uv(lo.cle())) and not sens.get(c), c != uv(k), -(lo.nbOcc() if hasattr(lo, "nbOcc") else 0))
        lst = sorted(par.values(), key=rang)[:3]
        out = []
        for lo, ms in lst:
            c = lo.cle()
            if c not in num:
                num[c] = len(lemmes)
                lemmes.append([c, lo.gr(), sens.get(uv(c)) or sens.get(uv(re.sub(r"\d+$", "", c))) or ""])
            out.append([num[c], " ; ".join(ms[:4])])
        sortie.setdefault(k[0], {})[k] = out
    os.makedirs(os.path.join(DATA, "latin"), exist_ok=True)
    def ecrire(nom, var, obj):
        with open(os.path.join(DATA, "latin", nom), "w", encoding="utf8") as fh:
            fh.write(f"window.{var}=" + json.dumps(obj, ensure_ascii=False, separators=(",", ":")) + ";\n")
    ecrire("lemmes.js", "__LEM", lemmes)
    for lettre, d in sortie.items():
        ecrire(f"{lettre}.js", "__LAT", d)
    print(f"{len(lemmes)} lemmes ; {rates} formes non reconnues ({100 * rates // max(1, len(formes))} %)")


if __name__ == "__main__":
    main()
