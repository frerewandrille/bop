"""Transforme les deux fichiers Word en données pour le site.

    python3 outils/construire_donnees.py

Entrées (dossier sources_bible/) :
    « Psautier de la Bible de Jérusalem (Provincia Tolosana) 1.93.doc »
    « Bible de Jérusalem.doc »
Sorties (site/donnees/) :
    psautier.json          psaumes et cantiques, avec le gras des inflexions,
                           les stiques, les strophes, les retraits, les acrostiches
    bible/<livre>.json     un fichier par livre : {chapitre: {verset: texte}}
    bible/index.json       liste des livres, anomalies relevées à l'import

Le psautier est lu par `textutil` (fourni avec macOS) qui garde le gras ;
la Bible par lire_word.py (texte seul).
"""
from __future__ import annotations
import html as H
import json
import re
import subprocess
import sys
import tempfile
import unicodedata
from pathlib import Path

ICI = Path(__file__).resolve().parent
RACINE = ICI.parent
sys.path.insert(0, str(ICI))
from lire_word import texte_doc  # noqa: E402

DONNEES = RACINE / "site" / "donnees"

# ───────────────────────────── Bible ─────────────────────────────

# (code, nom, chapitres, titre exact dans le fichier source)
LIVRES = [
    ("Gn", "Genèse", 50, "La Genèse"), ("Ex", "Exode", 40, "L’Exode"),
    ("Lv", "Lévitique", 27, "Le Lévitique"), ("Nb", "Nombres", 36, "Les Nombres"),
    ("Dt", "Deutéronome", 34, "Le Deutéronome"), ("Jos", "Josué", 24, "Le livre de Josué"),
    ("Jg", "Juges", 21, "Le livre de Juges"), ("Rt", "Ruth", 4, "Le livre de Ruth"),
    ("1S", "1 Samuel", 31, "Le premier livre de Samuel"), ("2S", "2 Samuel", 24, "Le deuxième livre de Samuel"),
    ("1R", "1 Rois", 22, "Le premier livre des Rois"), ("2R", "2 Rois", 25, "Le deuxième livre des Rois"),
    ("1Ch", "1 Chroniques", 29, "Le premier livre des Chroniques"),
    ("2Ch", "2 Chroniques", 36, "Le deuxième livre des Chroniques"),
    ("Esd", "Esdras", 10, "Le livre d’Esdras"), ("Ne", "Néhémie", 13, "Le livre de Néhémie"),
    ("Tb", "Tobie", 14, "Le livre de Tobie"), ("Jdt", "Judith", 16, "Le livre de Judith"),
    ("Est", "Esther", 10, "Le livre d’Esther"), ("1M", "1 Maccabées", 16, "Le premier livre des Maccabées"),
    ("2M", "2 Maccabées", 15, "Le deuxième livre des Maccabées"), ("Jb", "Job", 42, "Le livre de Job"),
    ("Ps", "Psaumes", 150, "Les Psaumes"), ("Pr", "Proverbes", 31, "Les Proverbes"),
    ("Qo", "Qohélet", 12, "L’Écclésiaste (Qohélet)"), ("Ct", "Cantique des cantiques", 8, "Le Cantique des Cantiques"),
    ("Sg", "Sagesse", 19, "Sagesse de Salomon"), ("Si", "Siracide", 51, "L’Écclésiastique (Siracide)"),
    ("Is", "Isaïe", 66, "Le livre d’Isaïe"), ("Jr", "Jérémie", 52, "Le livre de Jérémie"),
    ("Lm", "Lamentations", 5, "Les Lamentations"), ("Ba", "Baruch", 6, "Le livre de Baruch"),
    ("Ez", "Ézéchiel", 48, "Le livre d’Ézéchiel"), ("Dn", "Daniel", 14, "Le livre de Daniel"),
    ("Os", "Osée", 14, "Le livre d’Osée"), ("Jl", "Joël", 4, "Le livre de Joël"),
    ("Am", "Amos", 9, "Le livre d’Amos"), ("Ab", "Abdias", 1, "Le livre d’Abdias"),
    ("Jon", "Jonas", 4, "Le livre de Jonas"), ("Mi", "Michée", 7, "Le livre de Michée"),
    ("Na", "Nahum", 3, "Le livre de Nahum"), ("Ha", "Habaquq", 3, "Le livre d’Habaquq"),
    ("So", "Sophonie", 3, "Le livre de Sophonie"), ("Ag", "Aggée", 2, "Le livre d’Aggée"),
    ("Za", "Zacharie", 14, "Le livre de Zacharie"), ("Ml", "Malachie", 3, "Le livre de Malachie"),
    ("Mt", "Matthieu", 28, "L’Évangile selon St Matthieu"), ("Mc", "Marc", 16, "L’Évangile selon St Marc"),
    ("Lc", "Luc", 24, "L’Évangile selon St Luc"), ("Jn", "Jean", 21, "L’Évangile selon St Jean"),
    ("Ac", "Actes des Apôtres", 28, "Les Actes des Apôtres"), ("Rm", "Romains", 16, "Épître aux Romains"),
    ("1Co", "1 Corinthiens", 16, "Première Épître aux Corinthiens"),
    ("2Co", "2 Corinthiens", 13, "Deuxième Épître aux Corinthiens"),
    ("Ga", "Galates", 6, "Épître aux Galates"), ("Ep", "Éphésiens", 6, "Épître aux Éphésiens"),
    ("Ph", "Philippiens", 4, "Épître aux Philippiens"), ("Col", "Colossiens", 4, "Épître aux Colossiens"),
    ("1Th", "1 Thessaloniciens", 5, "Première Épître aux Thessaloniciens"),
    ("2Th", "2 Thessaloniciens", 3, "Deuxième Épître aux Thessaloniciens"),
    ("1Tm", "1 Timothée", 6, "Première Épître à Timothée"), ("2Tm", "2 Timothée", 4, "Deuxième Épître à Timothée"),
    ("Tt", "Tite", 3, "Épître à Tite"), ("Phm", "Philémon", 1, "Épître à Philémon"),
    ("He", "Hébreux", 13, "Épitre aux Hébreux"), ("Jc", "Jacques", 5, "L’Épître de St Jacques"),
    ("1P", "1 Pierre", 5, "Première Épître de St Pierre"), ("2P", "2 Pierre", 3, "Deuxième Épître de St Pierre"),
    ("1Jn", "1 Jean", 5, "Première Épître de St Jean"), ("2Jn", "2 Jean", 1, "Deuxième Épître de St Jean"),
    ("3Jn", "3 Jean", 1, "Troisième Épître de St Jean"), ("Jude", "Jude", 1, "L’Épître de St Jude"),
    ("Ap", "Apocalypse", 22, "L’Apocalypse"),
]
PAR_TITRE = {t: c for c, _, _, t in LIVRES}
RE_CHAPITRE = re.compile(r"^(?:Chapitre|Psaume)\s+(\d+)\s*$", re.I)
RE_VERSET = re.compile(r"^(\d+)\s+(\S.*)$")
RE_NUM_INCRUSTE = re.compile(r"(?:^|(?<=\s))(\d{1,3})\s\s+")


def _decouper(num, contenu):
    """Versets restés incrustés dans une ligne (« 37 38  texte ») ; texte vide = verset omis."""
    morceaux, courant, pos = [], num, 0
    for m in RE_NUM_INCRUSTE.finditer(contenu):
        if int(m.group(1)) == courant + 1:
            morceaux.append((courant, contenu[pos:m.start()].strip()))
            courant, pos = courant + 1, m.end()
    morceaux.append((courant, contenu[pos:].strip()))
    return morceaux


def analyser_bible(texte):
    livres, anomalies, omis = {}, [], []
    livre = chap = verset = None
    lettrine = False
    for no, brute in enumerate(texte.split("\n"), 1):
        ligne = re.sub(r"[\x00-\x08\x0e-\x1f]", "", brute).strip()
        if not ligne or "HYPERLINK" in ligne or "TOC \\" in ligne:
            continue
        if ligne in PAR_TITRE:
            livre, chap, verset = PAR_TITRE[ligne], None, None
            livres[livre] = {}
            continue
        if livre is None:
            continue
        m = RE_CHAPITRE.match(ligne)
        if m:
            chap, verset, lettrine = int(m.group(1)), None, False
            livres[livre].setdefault(chap, {})
            continue
        if chap is None:
            continue
        if ligne.isdigit() and int(ligne) == chap:
            lettrine = True  # numéro de chapitre en lettrine, sur sa propre ligne
            continue
        ligne = re.sub(rf"^{chap}:(\d+)\s", r"\1  ", ligne)  # « 29:1  … » (Ex 29)
        m = RE_VERSET.match(ligne)
        if m and m.group(1) == "1" and verset is not None and verset > 1 and livres[livre][chap]:
            # Le verset 1 revient sans titre de chapitre : soit un prologue (Siracide),
            # soit un titre « Chapitre N » oublié dans la source.
            if livre == "Si" and chap == 1:
                livres[livre][0] = livres[livre].pop(1)
                livres[livre][1] = {}
            else:
                anomalies.append(f"{livre} {chap + 1} : titre de chapitre absent de la source, rétabli (l. {no})")
                chap += 1
                livres[livre].setdefault(chap, {})
                lettrine = True
        if m and verset is not None and int(m.group(1)) > verset + 20:
            m = None  # nombre en début de ligne (« 10000 talents… ») : suite du verset
        if m:
            num, contenu = m.group(1), m.group(2)
            if not lettrine and not livres[livre][chap] and num.startswith(str(chap)) and len(num) > len(str(chap)):
                num = num[len(str(chap)):]  # « 11 » = chapitre 1, verset 1
            for verset, morceau in _decouper(int(num), contenu):
                if not morceau:
                    omis.append(f"{livre} {chap},{verset}")
                    continue
                if verset in livres[livre][chap]:
                    anomalies.append(f"{livre} {chap},{verset} : verset en double (l. {no})")
                livres[livre][chap][verset] = morceau
        elif len(ligne) < 70 and ligne[-1:] not in ".,;:!?»\"”…" and ligne[:1].isupper():
            continue  # intertitre
        elif verset is not None:
            livres[livre][chap][verset] += " " + ligne
        else:
            anomalies.append(f"{livre} {chap} : ligne non reconnue « {ligne[:50]} » (l. {no})")
    return livres, anomalies, omis


def controler_bible(livres, omis):
    pb = []
    for code, nom, n, _ in LIVRES:
        chaps = livres.get(code)
        if not chaps:
            pb.append(f"{nom} : livre introuvable")
            continue
        if sorted(c for c in chaps if c) != list(range(1, n + 1)):
            manque = sorted(set(range(1, n + 1)) - set(chaps))
            pb.append(f"{nom} : chapitres manquants {manque}" if manque else f"{nom} : chapitres en trop {sorted(set(chaps) - set(range(0, n + 1)))}")
        for c, vs in sorted(chaps.items()):
            nums = sorted(vs)
            if not nums:
                pb.append(f"{code} {c} : chapitre vide")
                continue
            trous = sorted(set(range(1, nums[-1] + 1)) - set(nums) - {int(o.split(",")[1]) for o in omis if o.startswith(f"{code} {c},")})
            if trous:
                pb.append(f"{code} {c} : versets absents {trous}")
    return pb


def construire_bible(source: Path):
    texte = texte_doc(source)
    livres, anomalies, omis = analyser_bible(texte)
    anomalies += controler_bible(livres, omis)
    dossier = DONNEES / "bible"
    dossier.mkdir(parents=True, exist_ok=True)
    for code, chaps in livres.items():
        (dossier / f"{code}.json").write_text(json.dumps(
            {str(c): {str(v): t for v, t in sorted(vs.items())} for c, vs in sorted(chaps.items())},
            ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    index = {"traduction": "Bible de Jérusalem",
             "livres": [{"code": c, "nom": n, "chapitres": k} for c, n, k, _ in LIVRES if c in livres],
             "versets_omis": omis, "anomalies": anomalies}
    (dossier / "index.json").write_text(json.dumps(index, ensure_ascii=False, indent=1), encoding="utf-8")
    nv = sum(len(v) for ch in livres.values() for v in ch.values())
    print(f"Bible : {len(livres)} livres, {nv} versets, {len(anomalies)} anomalies (voir site/donnees/bible/index.json)")
    return anomalies

# ──────────────────────────── Psautier ────────────────────────────

# Les lettres hébraïques des psaumes alphabétiques sont saisies dans une police
# hébraïque « translittérée » : a = aleph, b = beth, g = gimel…
HEBREU = {"a": "א", "b": "ב", "g": "ג", "d": "ד", "h": "ה", "w": "ו", "z": "ז", "x": "ח",
          "j": "ט", "y": "י", "k": "כ", "l": "ל", "m": "מ", "n": "נ", "s": "ס", "[": "ע",
          "p": "פ", "c": "צ", "q": "ק", "r": "ר", "v": "ש", "t": "ת"}
ROMAINS = {"I": 1, "II": 2, "III": 3, "IV": 4, "V": 5, "VI": 6, "VII": 7, "VIII": 8, "IX": 9, "X": 10,
           "XI": 11, "XII": 12, "XIII": 13, "XIV": 14, "XV": 15, "XVI": 16, "XVII": 17, "XVIII": 18,
           "XIX": 19, "XX": 20, "XXI": 21, "XXII": 22}


def html_psautier(source: Path) -> str:
    with tempfile.TemporaryDirectory() as tmp:
        sortie = Path(tmp) / "p.html"
        subprocess.run(["textutil", "-convert", "html", "-output", str(sortie), str(source)], check=True)
        return sortie.read_text(encoding="utf-8")


def _texte(h: str) -> str:
    return H.unescape(re.sub(r"<[^>]+>", "", h)).replace("\xa0", " ")


def _nettoyer(h: str) -> str:
    """Garde <b> et <i>, retire le reste ; fusionne les balises adjacentes."""
    h = re.sub(r"<span class=\"Apple-tab-span\">\t</span>", "\t", h)
    h = re.sub(r"<sup>\s*([^<]+?)\s*</sup>", "\x05\\1\x06", h)  # verset en cours de ligne
    h = re.sub(r"</?(?:span|font|a)[^>]*>", "", h)
    h = re.sub(r"<br>", "", h)
    h = re.sub(r"<b></b>|<i></i>", "", h)
    h = re.sub(r"</b><b>", "", h)
    h = re.sub(r"</i><i>", "", h)
    h = H.unescape(h).replace("\xa0", " ")
    h = h.replace("&", "&amp;").replace("<b>", "\x01").replace("</b>", "\x02").replace("<i>", "\x03").replace("</i>", "\x04")
    h = h.replace("<", "&lt;").replace(">", "&gt;")
    h = h.replace("\x01", "<b>").replace("\x02", "</b>").replace("\x03", "<i>").replace("\x04", "</i>")
    h = h.replace("\x05", '<sup class="v">').replace("\x06", "</sup>")
    h = re.sub(r"<i>(\s*)</i>|<b>(\s*)</b>", lambda m: m.group(1) or m.group(2) or "", h)
    return re.sub(r"[ \t]+", " ", h).strip()


MINUSCULES = {"cantique", "chant", "prière", "éloge", "du", "de", "des", "d", "la", "le", "les", "livre", "serviteur",
              "enfants", "trois", "créatures", "lamentation", "épître", "aux", "à", "l", "première", "deuxième"}


def casse_titre(t: str) -> str:
    """« 2E CANTIQUE DU LIVRE D’ISAÏE » → « 2e cantique du livre d’Isaïe »."""
    t = re.sub(r"\s+", " ", t).strip()
    ordinal = re.compile(r"^(?:(\d+)|(IV|I{1,3}))(ERE|ER|E)$", re.I)
    out = []
    for m in re.split(r"(\s+|’|')", t):
        o = ordinal.match(m) if m else None
        if not m.strip() or m in "’'":
            out.append(m)
        elif o:
            out.append((o.group(1) or o.group(2).upper()) + o.group(3).lower())
        elif m.lower() in MINUSCULES:
            out.append(m.lower())
        else:
            out.append(m[:1].upper() + m[1:].lower())
    r = "".join(out)
    return r[:1].upper() + r[1:]


def analyser_psautier(source_html: str):
    css = dict(re.findall(r"p\.(p\d+) \{([^}]*)\}", source_html))

    def retrait(classe):
        st = css.get(classe, "")
        m = re.search(r"margin: [-\d.]+px [-\d.]+px [-\d.]+px ([-\d.]+)px", st)
        t = re.search(r"text-indent: (-?[\d.]+)px", st)
        return (float(m.group(1)) if m else 0) + (float(t.group(1)) if t else 0)

    paras = re.findall(r'<p class="(p\d+)">(.*?)</p>', source_html, re.S)
    pieces, ordre = {}, []
    courant = None
    section = None  # "psaumes", "cantiques AT", "cantiques NT"
    etat = "texte"  # ou "priere"
    strophe = []
    lettre_attente = None

    def fermer_strophe():
        nonlocal strophe, lettre_attente
        if courant is not None and strophe:
            courant["strophes"].append({"lignes": strophe} | ({"lettre": lettre_attente} if lettre_attente else {}))
            lettre_attente = None
        strophe = []

    def nouvelle(pid, titre, genre):
        nonlocal courant, etat
        fermer_strophe()
        courant = {"id": pid, "titre": titre, "genre": genre, "ref": None, "strophes": [], "priere": []}
        pieces[pid] = courant
        ordre.append(pid)
        etat = "texte"

    for classe, brut in paras:
        t = _texte(brut).strip()
        tc = re.sub(r"\s+", " ", t)
        # ── titres de section
        if tc in ("Psaumes",):
            section = "psaumes"; continue
        if tc.startswith("Cantiques de l’Ancien Testament"):
            fermer_strophe(); section = "AT"; continue
        if tc.startswith("Cantiques du Nouveau Testament"):
            fermer_strophe(); section = "NT"; continue
        if section is None:
            continue
        # ── titres de pièce
        m = re.match(r"^PSAUME\s+(\d+)\s*([AB])?\s*([IVX]+)?$", tc)
        if section == "psaumes" and m:
            num, ab, rom = m.groups()
            pid = num + (ab or "") + (f"-{ROMAINS[rom]}" if rom else "")
            nouvelle(pid, f"Psaume {num}{ab or ''}" + (f" {rom}" if rom else ""), "psaume")
            continue
        m = re.match(r"^AT\s*(\d+)\s+(.+)$", tc)
        if section == "AT" and m:
            nouvelle(f"AT{m.group(1)}", casse_titre(m.group(2).strip()), "cantique AT")
            continue
        m = re.match(r"^Cantique\s+([IVX]+)\s+(.+)$", tc)
        if section == "NT" and m:
            nouvelle(f"NT{ROMAINS[m.group(1)]}", casse_titre(m.group(2).strip()), "cantique NT")
            continue
        if courant is None:
            continue
        # ── référence d'un cantique : « (Ex 15, 1-18) »
        if courant["ref"] is None and courant["genre"] != "psaume" and re.match(r"^\(.*\d.*\)$", tc) and not courant["strophes"] and not strophe:
            courant["ref"] = tc[1:-1].strip()
            continue
        # ── prière psalmique
        if tc == "PRIONS":
            fermer_strophe(); etat = "priere"; continue
        if etat == "priere":
            if tc:
                courant["priere"].append(_nettoyer(brut))
            continue
        # ── ligne vide : fin de strophe
        if not tc:
            fermer_strophe(); continue
        # ── lettre hébraïque seule (psaumes alphabétiques)
        mlet = re.match(r"^\(?([a-z\[])\)?(?:\s*\(?([a-z\[])\)?)?$", tc)
        if mlet and len(tc) <= 7:
            fermer_strophe()
            lettre_attente = " ".join(HEBREU.get(x, x) for x in mlet.groups() if x)
            continue
        # ── stique
        h = re.sub(r"<span class=\"Apple-tab-span\">\t</span>", "\t", brut)
        h = re.sub(r"<i>((?:\s|\xa0|&nbsp;)*)</i>", r"\1", h)
        lettre = None
        mi = re.match(r"^(?:<span[^>]*>)?(?:<b>)?\(?([a-z\[])\)?(?:</b>)?(?:</span>)?(?:\t+|\s+(?=(?:<span[^>]*>)*<sup>))", h)
        if mi:
            lettre = HEBREU.get(mi.group(1), mi.group(1))
            h = h[mi.end():]
        verset = None
        mv = re.match(r"^\s*(?:<span[^>]*>|<b>\s*</b>|\s)*<sup>([^<]+)</sup>\s*(?:</span>)*", h)
        if mv:
            verset = mv.group(1).strip()
            h = h[mv.end():]
        else:
            mv = re.match(r"^\s*(\d{1,3}[ab]?)\s+(?=\S)", _texte(h))
            if mv and not _texte(h).startswith(mv.group(1) + " %"):
                # numéro de verset non mis en exposant
                n = mv.group(1)
                h2 = re.sub(r"^(\s*(?:<[^>]+>)*\s*)" + re.escape(n) + r"\s+", r"\1", h, count=1)
                if h2 != h:
                    verset, h = n, h2
        texte = _nettoyer(h)
        if not texte and not verset:
            continue
        ligne = {"t": texte}
        if verset:
            ligne["v"] = verset
        if lettre:
            ligne["l"] = lettre
        ligne["_r"] = retrait(classe)
        strophe.append(ligne)
    fermer_strophe()

    # Retraits : relatifs au retrait le plus courant de la pièce, en paliers de ~1 cm
    for p in pieces.values():
        rs = [l["_r"] for s in p["strophes"] for l in s["lignes"]]
        if rs:
            base = min(rs)
            for s in p["strophes"]:
                for l in s["lignes"]:
                    r = round((l.pop("_r") - base) / 28)
                    if r > 0:
                        l["r"] = min(r, 3)
    return pieces, ordre


def construire_psautier(source: Path):
    pieces, ordre = analyser_psautier(html_psautier(source))
    sortie = {"titre": "Psautier de la Bible de Jérusalem (Provincia Tolosana)",
              "ordre": ordre, "pieces": pieces}
    (DONNEES / "psautier.json").write_text(json.dumps(sortie, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    nps = sum(1 for p in pieces.values() if p["genre"] == "psaume")
    nat = sum(1 for p in pieces.values() if p["genre"] == "cantique AT")
    nnt = sum(1 for p in pieces.values() if p["genre"] == "cantique NT")
    print(f"Psautier : {nps} psaumes (ou parties), {nat} cantiques AT, {nnt} cantiques NT")
    sans_ref = [p["id"] for p in pieces.values() if p["genre"] != "psaume" and not p["ref"]]
    if sans_ref:
        print("  cantiques sans référence :", sans_ref)
    return pieces


SOURCES = RACINE / "sources_bible"


def trouver(motif: str) -> Path:
    for f in sorted(SOURCES.glob("*.doc")):
        if motif.lower() in unicodedata.normalize("NFC", f.name).lower():
            return f
    raise SystemExit(f"Fichier introuvable dans {SOURCES} : *{motif}*.doc")


if __name__ == "__main__":
    DONNEES.mkdir(parents=True, exist_ok=True)
    construire_psautier(trouver("Psautier"))
    anomalies = construire_bible(trouver("Bible de J"))
    for a in anomalies[:60]:
        print("  ", a)
