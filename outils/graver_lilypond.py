#!/usr/bin/env python3
"""Partitions gouzantines gravées depuis leurs sources LilyPond.

Sources : sources_gouzes/lilypond/ (copie de « Partitions gouzantines », sans les .ly~ ; liens rétablis).
Sortie  : partitions/ly/<nom>.png   (une image recadrée par pièce, nom ASCII tiré du nom du fichier)
          partitions/ly/pieces.json (toutes les pièces : source, cote, paroles, image ou erreurs)
          partitions/ly/index.json  (lu par le site : texte d'antienne / refrain / hymne de gouzes.json → image,
                                     seulement quand les paroles de la source correspondent)
          partitions/ly/rapport.md  (rattachements, cotes fausses du tableau, textes sans source)

  python3 outils/graver_lilypond.py               # graver ce qui a changé, puis indexer
  python3 outils/graver_lilypond.py --tout        # tout regraver
  python3 outils/graver_lilypond.py --index       # indexer seulement
  python3 outils/graver_lilypond.py "B122" ...    # graver seulement ces fichiers (pas d'index)

Les « tons » (TonsDef.ly, TonsRDef.ly) et vowel-set.ly sont inclus d'office : dans la plupart des fichiers
leur \\include est en commentaire (ils étaient chargés par l'installation de LilyPond de l'auteur).
"""
import json, os, re, subprocess, sys, tempfile, unicodedata, concurrent.futures as cf
from difflib import SequenceMatcher

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SRC = os.path.join(RACINE, "sources_gouzes", "lilypond")
TECH = os.path.join(SRC, "Fichiers techniques")
TONS = os.path.join(SRC, "Tons")
SORTIE = os.path.join(RACINE, "partitions", "ly")
IGNORES = {"Fichiers techniques", "Tons"}
DPI = 200

INCLUSIONS = ("vowel-set.ly", "TonsDef.ly", "TonsRDef.ly")


def prelude(texte):
    """Fichiers techniques à inclure d'office : seulement ceux que la pièce n'inclut pas déjà
    (une double inclusion de vowel-set.ly casse \\apostrophe : le mot s'imprimait dans les paroles)."""
    actif = re.sub(r"%.*", "", texte)
    inc = [f for f in INCLUSIONS if f'\\include "{f}"' not in actif]
    return "".join(f'\\include "{f}"\n' for f in inc) + "\\paper { indent = 0 }\n"


def cote(nom):
    m = re.search(r"\b([A-Z]{1,2}) ?(\d{3}[a-z]?)$", nom)
    return (m.group(1) + m.group(2)) if m else None


def slug(rel):
    t = unicodedata.normalize("NFD", os.path.splitext(rel)[0]).encode("ascii", "ignore").decode().lower()
    return re.sub(r"[^a-z0-9]+", "-", t).strip("-")


# même normalisation que partitions.js (normal) : lettres sans accents, minuscules
def N(t):
    return re.sub(r"[^a-zA-Z]", "", unicodedata.normalize("NFD", t or "")).lower()


def sources(filtres=None):
    for dossier, _, fichiers in os.walk(SRC):
        rel = os.path.relpath(dossier, SRC)
        if rel.split(os.sep)[0] in IGNORES:
            continue
        for f in sorted(fichiers):
            if not f.endswith(".ly") or f.startswith(("0", "TonsDef", "TonsRDef")) or "(copier" in f:
                continue
            if filtres and not any(x in f for x in filtres):
                continue
            yield os.path.join(dossier, f)


# ── paroles d'un fichier .ly (blocs \lyricsto / \lyricmode / \addlyrics)
def _blocs(t):
    out = []
    for m in re.finditer(r'\\(?:lyricsto\s*"?[^"\s{]+"?|lyricmode|addlyrics)\s*\{', t):
        i = j = m.end(); d = 1
        while j < len(t) and d:
            d += t[j] == "{"; d -= t[j] == "}"; j += 1
        out.append(t[i:j - 1])
    return out


def paroles(chemin):
    t = open(chemin, encoding="utf-8", errors="replace").read()
    res = []
    for b in _blocs(t):
        b = re.sub(r"%.*", "", b)
        b = re.sub(r"\\(?:set|override|once\s+\\override|tweak)\s+[\w.-]+\s*=\s*#?'?(\"[^\"]*\"|\([^()]*\)|\S+)", " ", b)
        b = re.sub(r"(?<=\w)\d+\.*", "", b)          # durées collées aux syllabes (« Jé4 », « ru2. »)
        b = re.sub(r"\\repeat\s+\w+\s+\d+", " ", b)
        b = re.sub(r"\\markup\s*\{([^{}]*)\}", r" \1 ", b)
        b = re.sub(r"\\[a-zA-Z-]+(\s*#\S+)?", "", b)
        b = re.sub(r'"([^"]*)"', r"\1", b)
        b = b.replace("--", "").replace("__", "").replace("_", " ").replace("~", " ")
        b = re.sub(r"[{}<>]", " ", b)
        res.append(" ".join(b.split()))
    return res


def graver(chemin):
    rel = os.path.relpath(chemin, SRC)
    nom = slug(rel)
    with tempfile.TemporaryDirectory() as tmp:
        cible = os.path.join(tmp, "x")
        pre = os.path.join(tmp, "prelude.ly")
        open(pre, "w").write(prelude(open(chemin, encoding="utf-8", errors="replace").read()))
        cmd = ["lilypond", "-s", "--png", f"-dresolution={DPI}", "-dpixmap-format=pnggray", "-dcrop", "-dno-point-and-click",
               f"-dinclude-settings={pre}", "-I", TECH, "-I", TONS, "-o", cible, os.path.basename(chemin)]
        p = subprocess.run(cmd, cwd=os.path.dirname(os.path.realpath(chemin)), capture_output=True, text=True, timeout=240)
        erreurs = [l.replace(SRC + "/", "") for l in p.stderr.splitlines() if re.search(r"[Ee]rr(eu)?r", l)]
        png = cible + ".cropped.png"
        ok = os.path.exists(png)
        if ok:   # 16 niveaux de gris suffisent (notes noires sur blanc) : ~8 fois plus léger qu'un JPEG
            q = subprocess.run(["pngquant", "16", "--force", "--output", os.path.join(SORTIE, nom + ".png"), png], capture_output=True)
            if q.returncode not in (0, 99):
                os.replace(png, os.path.join(SORTIE, nom + ".png"))
    return {"source": rel, "fichier": f"ly/{nom}.png" if ok else None, "erreurs": erreurs[:5]}


def graver_tout(liste, forcer):
    a_faire = []
    for c in liste:
        jpg = os.path.join(SORTIE, slug(os.path.relpath(c, SRC)) + ".png")
        if forcer or not os.path.exists(jpg) or os.path.getmtime(jpg) < os.path.getmtime(os.path.realpath(c)):
            a_faire.append(c)
    print(f"{len(a_faire)} pièce(s) à graver sur {len(liste)}")
    res = {}
    with cf.ThreadPoolExecutor(max_workers=os.cpu_count() or 4) as ex:
        for r in ex.map(graver, a_faire):
            res[r["source"]] = r
            if not r["fichier"]:
                print("ÉCHEC " + r["source"])
    return res


# ── index : rattacher les textes de gouzes.json aux pièces gravées
# fichiers « Cantiques NT » → numéro du cantique dans le psautier (site/donnees/psautier.json)
NT_FICHIERS = {"NT4": r"Rm 6 K022", "NT5": r"2Co 5", "NT6": r"Ep 2 C503", "NT7": r"Ph 2", "NT8": r"Col 1",
               "NT10": r"1P 2", "NT11": r"Ap 4-5", "NT12": r"Ap 11-12", "NT13": r"Ap 15", "NT14": r"Ap 19"}
VARIANTES = re.compile(r"\b(cplts\d?|bis|v\.? ?\d|sop|a4|txt orig)\b", re.I)


def accord(texte, p):
    a = N(texte)[:40]
    if not a or not p:
        return 0.0
    if a in p:
        return 1.0
    pas = max(1, len(a) // 8)
    return max(SequenceMatcher(None, a, p[i:i + len(a)]).ratio() for i in range(0, max(1, len(p) - len(a) + 1), pas))


def indexer(nouvelles):
    chemin_pieces = os.path.join(SORTIE, "pieces.json")
    anciennes = {}
    if os.path.exists(chemin_pieces):
        anciennes = {x["source"]: x for x in json.load(open(chemin_pieces))}
    pieces = []
    for c in sources():
        rel = os.path.relpath(c, SRC)
        nom = slug(rel)
        r = nouvelles.get(rel) or anciennes.get(rel) or {}
        jpg = os.path.join(SORTIE, nom + ".png")
        pieces.append({"source": rel, "dossier": rel.split(os.sep)[0], "cote": cote(os.path.splitext(os.path.basename(rel))[0]),
                       "variante": bool(VARIANTES.search(os.path.basename(rel))), "lien": os.path.islink(c),
                       "fichier": f"ly/{nom}.png" if os.path.exists(jpg) else None,
                       "erreurs": r.get("erreurs", []), "paroles": " / ".join(paroles(c))[:400]})
    json.dump(pieces, open(chemin_pieces, "w"), ensure_ascii=False, indent=1)

    gravees = [x for x in pieces if x["fichier"]]
    for x in gravees:
        x["_p"] = N(x["paroles"])
        x["_debuts"] = [N(b)[:60] for b in x["paroles"].split(" / ") if N(b)]
    par_cote = {}
    for x in gravees:
        if x["cote"]:
            par_cote.setdefault(x["cote"], []).append(x)

    def meilleure(cands):   # la version principale avant « Cplts », « bis », « v.2 »…
        return sorted(cands, key=lambda x: (x["variante"], x["lien"], len(x["source"])))[0]

    G = json.load(open(os.path.join(RACINE, "site", "donnees", "gouzes.json")))
    textes = []   # (genre, clé gouzes, cote, texte)
    for k, v in G["offices"].items():
        for e in (v.get("psalmodie") or []) + ([v["evangelique"]] if v.get("evangelique") else []) + ([v["invitatoire"]] if isinstance(v.get("invitatoire"), dict) else []):
            if e and e.get("ant"):
                textes.append(("antienne", k, e.get("cote"), e["ant"]))
    T = G["textes"]
    for k, h in (T.get("hymnes") or {}).items():
        if h.get("strophes"):
            textes.append(("hymne", k, h.get("cote"), re.sub(r"^\s*\d+\.\s*", "", " ".join(h["strophes"][0]))))
    for k, r in (T.get("repons") or {}).items():
        if r.get("refrain"):
            textes.append(("repons", k, r.get("cote"), r["refrain"]))
    for e in T.get("invitatoires_careme") or []:
        if e.get("ant"):
            textes.append(("invitatoire", "careme", e.get("cote"), e["ant"]))

    index, vus, rap = {}, set(), {"cote": [], "texte": [], "cote_fausse": [], "sans": []}
    for genre, k, c, t in textes:
        cle = N(t)[:40]
        if len(cle) < 8 or cle in vus:
            continue
        vus.add(cle)
        c = (c or "").replace(" ", "")
        cands = [x for x in par_cote.get(c, []) if accord(t, x["_p"]) >= 0.85]
        if cands:
            x = meilleure(cands); index[cle] = x["fichier"]; rap["cote"].append((genre, k, c, t, x["source"])); continue
        if len(cle) >= 25 and re.sub(r"alleluia", "", N(t)):
            # sans cote concordante : le texte doit ouvrir une partie de la pièce (pas un verset au milieu d'un fichier « Cplts »)
            scores = [(max([accord(t, d) for d in x["_debuts"]] or [0]), x) for x in gravees]
            # ni les « Cplts » (versets des répons), ni une pièce d'un autre genre pour une hymne
            bons = [x for s, x in scores if s >= 0.9 and "cplts" not in x["source"].lower()
                    and (genre != "hymne" or x["dossier"] == "Hymnes")]
            if bons:
                x = meilleure(bons); index[cle] = x["fichier"]
                rap["cote_fausse" if c and c in par_cote else "texte"].append((genre, k, c, t, x["source"])); continue
        rap["sans"].append((genre, k, c, t, "source présente, paroles différentes" if c in par_cote else ""))

    # cantiques du NT gravés en entier (refrain + versets), par numéro du psautier (NT VI = Ep 1… comme la répartition romaine)
    cantiques = {}
    for nt, motif in NT_FICHIERS.items():
        c = [x for x in gravees if x["dossier"] == "Cantiques NT" and re.match(motif, os.path.basename(x["source"]))]
        if c:
            cantiques[nt] = meilleure(c)["fichier"]
    # cote → pièce principale (+ ses versets « Cplts » pour un répons) : pour remplacer une découpe de carnet
    # portant la même cote (version Province) et pour les livrets de Sainte-Baume
    cotes = {}
    for c, xs in par_cote.items():
        princ = [x for x in xs if "cplts" not in x["source"].lower()]
        if not princ:
            continue
        x = meilleure(princ)
        cpl = [y for y in xs if "cplts" in y["source"].lower() and y["dossier"] == x["dossier"]]
        cotes[c] = [x["fichier"]] + ([meilleure(cpl)["fichier"]] if cpl and x["dossier"] == "Répons" else [])
    json.dump({"source": "Liturgie chorale du peuple de Dieu (A. Gouzes), gravé avec LilyPond depuis les sources",
               "textes": index, "cantiques": cantiques, "cotes": cotes}, open(os.path.join(SORTIE, "index.json"), "w"), ensure_ascii=False, indent=0)

    with open(os.path.join(SORTIE, "rapport.md"), "w") as f:
        f.write(f"# Partitions gravées (LilyPond) — rattachement aux textes de gouzes.json\n\n")
        f.write(f"- Pièces : {len(pieces)} ; gravées : {len(gravees)} ; échecs : {len(pieces) - len(gravees)}\n")
        f.write(f"- Textes distincts du tableau : {len(vus)} ; rattachés : {len(index)} "
                f"(par cote {len(rap['cote'])}, par le texte {len(rap['texte'])}, cote du tableau fausse {len(rap['cote_fausse'])}) ; "
                f"sans partition gravée : {len(rap['sans'])}\n\n")
        for titre, cle in (("Cote du tableau fausse (rattaché par le texte)", "cote_fausse"), ("Sans cote, rattaché par le texte", "texte"),
                           ("Sans partition gravée", "sans")):
            f.write(f"## {titre}\n\n")
            for genre, k, c, t, s in rap[cle]:
                f.write(f"- {genre} `{k}` {c or '—'} « {t[:70]} » {('→ ' + s) if s else ''}\n")
            f.write("\n")
        f.write("## Échecs de gravure\n\n")
        for x in pieces:
            if not x["fichier"]:
                f.write(f"- {x['source']} : {(x['erreurs'] or ['?'])[0][:160]}\n")
    print(f"index : {len(index)} textes rattachés ; {len(rap['sans'])} sans partition ; voir partitions/ly/rapport.md")


def main():
    args = sys.argv[1:]
    os.makedirs(SORTIE, exist_ok=True)
    if "--index" in args:
        indexer({}); return
    forcer = "--tout" in args
    filtres = [a for a in args if not a.startswith("--")]
    liste = list(sources(filtres or None))
    res = graver_tout(liste, forcer or bool(filtres))
    if not filtres:
        indexer(res)


if __name__ == "__main__":
    main()
