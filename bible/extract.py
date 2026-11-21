#!/usr/bin/env python3
"""
Extrait de Biblia Universalis 3 les données nécessaires à la vue interlinéaire :

  - BJ  (JER.xml)  : texte de la Bible de Jérusalem, titres et notes, par verset
  - ATI (ATI.xml)  : AT interlinéaire hébreu (hébreu, translittération, glose, Strong, analyse)
  - NTI (NTI.xml)  : NT interlinéaire grec (grec, lemme, Strong, glose, analyse)
  - LSS (LSS.xml)  : Segond 1910 indexée Strong -> 2e glose possible, alignée mot à mot via Strong
  - NVU / VUC      : Nova Vulgata et Vulgate Clémentine (latin), par verset
  - SEP            : Septante (grec) pour les deutérocanoniques (pas d'interlinéaire hébreu)

Les fichiers de l'application ne sont que LUS. La sortie est écrite dans ./data/
sous forme de fichiers .js (window.__CH = {...}) pour fonctionner en file:// sans serveur.

Usage :  python3 extract.py ["/Applications/Biblia Universalis 3 (1.41).app"]
"""
import html
import json
import os
import re
import sys

APP = sys.argv[1] if len(sys.argv) > 1 else "/Applications/Biblia Universalis 3 (1.41).app"
BIB = os.path.join(APP, "Contents/Resources/bibles")
OUT = os.path.join(os.path.dirname(os.path.abspath(__file__)), "data")

# (code, nom BJ, abréviation BJ, testament)
BOOKS = [
    ("GEN", "Genèse", "Gn", "AT"), ("EXO", "Exode", "Ex", "AT"), ("LEV", "Lévitique", "Lv", "AT"),
    ("NUM", "Nombres", "Nb", "AT"), ("DEU", "Deutéronome", "Dt", "AT"), ("JOS", "Josué", "Jos", "AT"),
    ("JDG", "Juges", "Jg", "AT"), ("RUT", "Ruth", "Rt", "AT"), ("1SA", "1 Samuel", "1 S", "AT"),
    ("2SA", "2 Samuel", "2 S", "AT"), ("1KI", "1 Rois", "1 R", "AT"), ("2KI", "2 Rois", "2 R", "AT"),
    ("1CH", "1 Chroniques", "1 Ch", "AT"), ("2CH", "2 Chroniques", "2 Ch", "AT"), ("EZR", "Esdras", "Esd", "AT"),
    ("NEH", "Néhémie", "Ne", "AT"), ("TOB", "Tobie", "Tb", "AT"), ("JDT", "Judith", "Jdt", "AT"),
    ("EST", "Esther", "Est", "AT"), ("1MA", "1 Maccabées", "1 M", "AT"), ("2MA", "2 Maccabées", "2 M", "AT"),
    ("JOB", "Job", "Jb", "AT"), ("PSA", "Psaumes", "Ps", "AT"), ("PRO", "Proverbes", "Pr", "AT"),
    ("ECC", "Qohélet", "Qo", "AT"), ("SNG", "Cantique des cantiques", "Ct", "AT"), ("WIS", "Sagesse", "Sg", "AT"),
    ("SIR", "Siracide", "Si", "AT"), ("ISA", "Isaïe", "Is", "AT"), ("JER", "Jérémie", "Jr", "AT"),
    ("LAM", "Lamentations", "Lm", "AT"), ("BAR", "Baruch", "Ba", "AT"), ("LJE", "Lettre de Jérémie", "LJr", "AT"),
    ("EZK", "Ézéchiel", "Ez", "AT"), ("DAN", "Daniel", "Dn", "AT"), ("HOS", "Osée", "Os", "AT"),
    ("JOL", "Joël", "Jl", "AT"), ("AMO", "Amos", "Am", "AT"), ("OBA", "Abdias", "Ab", "AT"),
    ("JON", "Jonas", "Jon", "AT"), ("MIC", "Michée", "Mi", "AT"), ("NAM", "Nahum", "Na", "AT"),
    ("HAB", "Habaquq", "Ha", "AT"), ("ZEP", "Sophonie", "So", "AT"), ("HAG", "Aggée", "Ag", "AT"),
    ("ZEC", "Zacharie", "Za", "AT"), ("MAL", "Malachie", "Ml", "AT"),
    ("MAT", "Matthieu", "Mt", "NT"), ("MRK", "Marc", "Mc", "NT"), ("LUK", "Luc", "Lc", "NT"),
    ("JHN", "Jean", "Jn", "NT"), ("ACT", "Actes des Apôtres", "Ac", "NT"), ("ROM", "Romains", "Rm", "NT"),
    ("1CO", "1 Corinthiens", "1 Co", "NT"), ("2CO", "2 Corinthiens", "2 Co", "NT"), ("GAL", "Galates", "Ga", "NT"),
    ("EPH", "Éphésiens", "Ep", "NT"), ("PHP", "Philippiens", "Ph", "NT"), ("COL", "Colossiens", "Col", "NT"),
    ("1TH", "1 Thessaloniciens", "1 Th", "NT"), ("2TH", "2 Thessaloniciens", "2 Th", "NT"),
    ("1TI", "1 Timothée", "1 Tm", "NT"), ("2TI", "2 Timothée", "2 Tm", "NT"), ("TIT", "Tite", "Tt", "NT"),
    ("PHM", "Philémon", "Phm", "NT"), ("HEB", "Hébreux", "He", "NT"), ("JAS", "Jacques", "Jc", "NT"),
    ("1PE", "1 Pierre", "1 P", "NT"), ("2PE", "2 Pierre", "2 P", "NT"), ("1JN", "1 Jean", "1 Jn", "NT"),
    ("2JN", "2 Jean", "2 Jn", "NT"), ("3JN", "3 Jean", "3 Jn", "NT"), ("JUD", "Jude", "Jude", "NT"),
    ("REV", "Apocalypse", "Ap", "NT"),
]


# --------------------------------------------------------------------------- lecture des .xml BU3
class Module:
    def __init__(self, code):
        self.code = code
        path = code if code.endswith(".xml") else os.path.join(BIB, code + ".xml")
        with open(path, "rb") as f:
            self.d = f.read()
        m = re.search(rb"<addresses>.*?<toc><addr>(\d+)</addr><size>(\d+)</size>", self.d, re.S)
        a, s = int(m.group(1)), int(m.group(2))
        self.toc = {n.decode(): int(x) for n, x in re.findall(rb"<name>([^<]+)</name><addr>(\d+)</addr>", self.d[a:a + s])}

    def get(self, name):
        a = self.toc.get(name)
        if a is None:
            return None
        m = re.match(rb"<file>\s*<size>(\d+)</size>\s*<data>", self.d[a:a + 200])
        st = a + m.end()
        return self.d[st:st + int(m.group(1))].decode("utf8", "replace")

    def chapters(self, book):
        return sorted(int(n[len(book) + 1:len(book) + 4]) for n in self.toc if n.startswith(book + "/") and n[len(book) + 1:len(book) + 4].isdigit())

    def chap(self, book, c):
        return self.get(f"{book}/{c:03d}.html")


def txt(s):
    s = re.sub(r"<[^>]+>", "", s)
    return re.sub(r"\s+", " ", html.unescape(s)).strip()


VNUM = re.compile(r'<span class="([cv])n">([^<]*)</span>')


def split_verses(c):
    """Découpe un chapitre en segments (numéro, html) selon les marqueurs <v/>.
    <span class="cn"> porte le numéro du CHAPITRE mais marque le verset 1."""
    out = []
    for seg in c.split("<v/>"):
        m = VNUM.search(seg)
        num = None
        if m:
            num = "1" if m.group(1) == "c" else m.group(2).strip()
        out.append((num, seg, m))
    return out


def unent(s):
    """Décode les entités HTML sauf celles qui protègent le balisage."""
    return re.sub(r"&(?!lt;|gt;|amp;)(#?\w+);", lambda m: html.unescape(m.group(0)), s)


# --------------------------------------------------------------------------- BJ
REF = re.compile(r'<a class="ref" href="r\.php\?v=\w+&r=([^"]+)">(.*?)</a>', re.S)


def clean_bj(s):
    s = REF.sub(lambda m: f'<a class="ref" data-r="{m.group(1)}">{m.group(2)}</a>', s)
    s = re.sub(r'<span class="nn">([^<]*)</span>', r'<sup class="nn" data-n="\1">\1</sup>', s)
    s = re.sub(r"<br\s*/?>", "<br>", s)
    s = re.sub(r"</?blockquote>", " ", s)  # marqueur de poésie
    s = re.sub(r"<(?!/?(?:i|b|br|sup|a)\b)[^>]+>", "", s)  # ne garde que i, b, br, sup, a
    s = re.sub(r"[ \t\r\n]+", " ", s)
    s = re.sub(r" \s*( \s*)*", "<br>", s)
    s = re.sub(r"^(\s|<br>)+|(\s|<br>)+$", "", s)
    return unent(s).strip()


def parse_bj(c):
    verses, pending_heads = [], []
    for num, seg, m in split_verses(c):
        notes = []

        def grab(mm):
            k = re.search(r'<span class="nn">([^<]*)</span>', mm.group(1))
            body = re.sub(r'^\s*<span class="nn">[^<]*</span>\s*', "", mm.group(1))
            notes.append([k.group(1) if k else "", clean_bj(body)])
            return ""

        seg = re.sub(r'<p class="note">(.*?)</p>', grab, seg, flags=re.S)
        seg = re.sub(r"<intro>.*?</intro>", "", seg, flags=re.S)
        heads = []

        def head(mm):
            heads.append([int(mm.group(1)), clean_bj(mm.group(2))])
            return "\u0000"

        seg = re.sub(r"<h([1-4])[^>]*>(.*?)</h\1>", head, seg, flags=re.S)
        if num is None:
            pending_heads += heads
            if verses and notes:
                verses[-1]["n"] += notes
            continue
        # Un segment peut contenir plusieurs versets (ex. Est 1,1a-1r) et des titres
        # placés après le texte (ils introduisent alors le verset suivant).
        # Du texte avant le premier numéro (ex. Gn 2,4a, séparé de 4b par un titre)
        # devient un demi-verset « 4a ».
        hi, cur, buf, first, pre, pre_split = 0, None, "", True, "", None
        for tok in re.split(r'(<span class="[cv]n">[^<]*</span>|\u0000)', seg):
            if tok == "\u0000":
                pending_heads.append(heads[hi]); hi += 1
                continue
            mm = VNUM.fullmatch(tok)
            if mm:
                if cur is not None:
                    cur["t"] = clean_bj(buf)
                num = "1" if mm.group(1) == "c" else mm.group(2).strip()
                carry = ""
                if cur is None and clean_bj(pre) and len(pending_heads) == pre_split:
                    # pas de titre entre ce texte et le numéro (lettre acrostiche, début de stique…) :
                    # on le garde en tête du verset
                    carry = pre
                elif cur is None and clean_bj(pre):
                    pv = {"v": num + "a" if num.isdigit() else (num[:-1] + "a" if num.endswith("b") else num + "'"), "t": clean_bj(pre), "n": notes}
                    notes = []
                    if pending_heads[:pre_split]:
                        pv["h"] = pending_heads[:pre_split]
                    pending_heads = pending_heads[pre_split:]
                    verses.append(pv)
                cur = {"v": num, "t": "", "n": notes if first else []}
                first = False
                if pending_heads:
                    cur["h"], pending_heads = pending_heads, []
                verses.append(cur)
                buf = carry
            elif cur is not None and not pending_heads:
                buf += tok
            elif cur is None:
                if pre_split is None and clean_bj(tok):
                    pre_split = len(pending_heads)
                pre += tok
        if cur is not None:
            cur["t"] = clean_bj(buf)
    return verses


def fix_numbering(code, c, verses):
    """Numéros de verset en double dans la BJ :
    - coquille isolée (2 Ch 35 : « 2 » au lieu de « 19 ») -> corrigée ;
    - série doublée : Dn 3,24-90 (additions grecques, puis 24-33 de l'araméen) -> la 1re série
      est marquée « g » (grec seulement) ; Si 1 (prologue du traducteur, puis 1,1-30) -> « x »."""
    cnt = {}
    for v in verses:
        cnt[v["v"]] = cnt.get(v["v"], 0) + 1
    for i, v in enumerate(verses):
        if cnt[v["v"]] == 2 and i > 0 and v["v"].isdigit() and verses[i - 1]["v"].isdigit():
            p = int(verses[i - 1]["v"])
            nxt = verses[i + 1]["v"] if i + 1 < len(verses) else ""
            if int(v["v"]) < p and str(p + 1) not in cnt and nxt == str(p + 2):
                cnt[v["v"]] -= 1
                v["v"] = str(p + 1)
                cnt[v["v"]] = 1
    dups = [k for k, n in cnt.items() if n > 1]
    if not dups:
        return
    first = min(i for i, v in enumerate(verses) if v["v"] in dups)
    second = next(i for i, v in enumerate(verses) if i > first and v["v"] == verses[first]["v"])
    for v in verses[first:second]:
        if code == "SIR" and c == 1:
            v["x"] = "Prologue du traducteur grec"
            v["id"] = "P" + v["v"]
        else:
            v["g"] = v["v"]
            v["id"] = "G" + v["v"]


# --------------------------------------------------------------------------- interlinéaires
TABLE = re.compile(r'<table align="(?:right|left)" dir="(?:rtl|ltr)" frame="lhs">(.*?)</table>', re.S)
TD = re.compile(r"<td[^>]*>(.*?)</td>", re.S)
STRONG = re.compile(r'href="h\.php\?c=STR&f=([HG]\d+)" title="([^"]*)"')
NOTE = re.compile(r'href="g\*(\w+)\*([^"]+)"><span title="[^"]*">([^<]*)<')


def parse_ati(c):
    """AT : par mot [strong, définition, translit, hébreu, hébreu segmenté, glose, morph court, morph long, notes]"""
    res = {}
    for num, seg, _ in split_verses(c):
        if num is None:
            continue
        words = []
        for tb in TABLE.findall(seg):
            tds = TD.findall(tb)
            if len(tds) < 5 or "Ezra SIL" not in tb:
                continue
            sm = STRONG.search(tds[0])
            heb = re.search(r'<span title="([^"]*)">([^<]*)</span>', tds[2])
            morph = re.search(r'<a href="" title="([^"]*)">([^<]*)</a>', tds[4])
            notes = [[a, b, lbl] for a, b, lbl in NOTE.findall(tds[4])]
            words.append({
                "s": sm.group(1) if sm else "",
                "d": html.unescape(sm.group(2)).lstrip("• ").strip() if sm else "",
                "tr": txt(tds[1]),
                "w": html.unescape(heb.group(2)) if heb else txt(tds[2]),
                "seg": html.unescape(heb.group(1)) if heb else "",
                "g": txt(tds[3]),
                "m": txt(morph.group(2)) if morph else txt(tds[4]),
                "ml": html.unescape(morph.group(1)).strip() if morph else "",
                "nt": notes,
            })
        res[num] = words
    return res


def parse_nti(c):
    """NT : par mot [grec, lemme, strong, définition, glose, morph court, morph long]"""
    res = {}
    for num, seg, _ in split_verses(c):
        if num is None:
            continue
        words = []
        for tb in TABLE.findall(seg):
            if "STR&f=G" not in tb:
                continue
            tds = TD.findall(tb)
            if len(tds) < 6:
                continue
            sm = STRONG.search(tds[3])
            morph = re.search(r'title="([^"]*)">\s*([^<]*)</a>', tds[5], re.S)
            g = re.sub(r"<small>(.*?)</small>", r"\1", tds[4], flags=re.S)
            words.append({
                "w": txt(tds[0]),
                "l": txt(tds[1]),
                "s": sm.group(1) if sm else "",
                "d": html.unescape(sm.group(2)).strip() if sm else "",
                "g": txt(g),
                "m": txt(morph.group(2)) if morph else txt(tds[5]),
                "ml": html.unescape(morph.group(1)).replace(" ", " ").replace("•", "").strip().replace("\n", " · ") if morph else "",
            })
        res[num] = words
    return res


# --------------------------------------------------------------------------- Segond + Strong (2e glose)
LSS_TOK = re.compile(r'<a class="glossaire" href="h\.php\?c=STR&f=([HG])(\d+)"[^>]*>[^<]*</a>')


def parse_lss(c, hebrew):
    """Pour chaque verset : liste ordonnée de (strong, morceau de texte Segond qui le précède)."""
    res = {}
    for num, seg, m in split_verses(c):
        if num is None:
            continue
        seg = seg[m.end():]
        pairs, last = [], 0
        for mm in LSS_TOK.finditer(seg):
            n = int(mm.group(2))
            chunk = txt(seg[last:mm.start()])
            last = mm.end()
            if hebrew and n > 8674:  # codes TVM (temps/voix/mode) de Strong, pas des lexèmes
                continue
            pairs.append([f"{mm.group(1)}{n}", chunk.strip(" ,.;:!?«»“”() ")])
        res[num] = pairs
    return res


def align_lss(il, lss):
    """Ajoute à chaque mot interlinéaire la glose Segond correspondant à son Strong (champ 'sg')."""
    for v, words in il.items():
        pool = [list(p) + [False] for p in lss.get(v, [])]
        for w in words:
            w["sg"] = ""
            if not w.get("s"):
                continue
            for p in pool:
                if not p[2] and p[0] == w["s"]:
                    p[2] = True
                    w["sg"] = p[1] if p[1] else "–"
                    break


# --------------------------------------------------------------------------- texte simple par verset
def parse_plain(c):
    res = {}
    if not c:
        return res
    c = re.sub(r'<p class="note">.*?</p>', "", c, flags=re.S)
    c = re.sub(r"<h\d[^>]*>.*?</h\d>", "", c, flags=re.S)
    for num, seg, m in split_verses(c):
        if num is None:
            continue
        res[num] = txt(seg[m.end():])
    return res


def parse_sef(c):
    """Septante en français (SEF) : ne garde que le grec (les traductions sont en <font color=...>)."""
    res = {}
    if not c:
        return res
    c = re.sub(r"<font color=(?:darkblue|green)>.*?</font>", "", c, flags=re.S)
    c = re.sub(r'<span class="note">.*?</span>', "", c, flags=re.S)
    c = re.sub(r"<h\d[^>]*>.*?</h\d>", "", c, flags=re.S)
    for num, seg, m in split_verses(c):
        if num is None:
            continue
        t = txt(seg[m.end():]).replace("[inexistant]", "").strip()
        if t:
            res[num] = t
    return res


def greek_ot(sep, sef, code, c):
    g = parse_sef(sef.chap(code, c))
    g.update(parse_plain(sep.chap(code, c)))  # la Septuaginta (Rahlfs) prime quand elle existe
    return g


# --------------------------------------------------------------------------- glossaire (notes ATI/NTI, introductions BJ)
def dump_glossary(mod, wanted, fname):
    out = {}
    for name in wanted:
        c = mod.get(f"glossaire/{name}.html")
        if c:
            c = re.sub(r"<(script|style|head|title)[^>]*>.*?</\1>", "", c, flags=re.S)
            c = re.sub(r"<(?!/?(?:p|i|b|br|sup|sub|ul|ol|li|h\d|table|tr|td|blockquote|font|span)\b)[^>]+>", "", c)
            out[name] = c.strip()
    write_js(fname, "__GLOSS", out)


def clean_lex(c):
    """Article de lexique (HEB = Strong + Sander-Trenel, GRC = Strong + Bailly) -> HTML allégé."""
    c = re.sub(r"(?s)^.*?<body>", "", c)
    c = re.sub(r"(?s)</body>.*$", "", c)
    c = re.sub(r"(?s)<table[^>]*>(?:(?!</table>).)*images/(?:back|forward)\.png.*?</table>", "", c)
    c = REF.sub(lambda m: f'<a class="ref" data-r="{m.group(1)}">{m.group(2)}</a>', c)
    c = re.sub(r'<a class="glossaire"[^>]*>.*?</a>(&nbsp;)?', "", c, flags=re.S)
    c = re.sub(r"<a [^>]*href=\"(?!#)[^\"]*\"[^>]*>(.*?)</a>", r"\1", c, flags=re.S)
    c = re.sub(r"<img[^>]*>", "", c)
    c = re.sub(r'\s(?:width|align|cellpadding|cellspacing|style)="[^"]*"', "", c)
    c = re.sub(r"<p></p>", "", c)
    c = re.sub(r'<td class="strong">\s*Introduction\s*</td>', "", c)
    c = re.sub(r'(?s)<table><tr><td class="rehaut">.*?</table>', "", c)
    c = re.sub(r"\n\s*", "\n", c)
    return unent(c).strip()


def extract_lexicon(code, prefix):
    """Écrit data/lex/H12.js (H1200-H1299), etc. Chaque fichier : { 'H1254': html, ... }"""
    path = os.path.join(APP, "Contents/Resources/dictionnaires", code + ".xml")
    if not os.path.exists(path):
        print("  ! lexique absent :", code)
        return 0
    old = globals()["BIB"]
    globals()["BIB"] = os.path.dirname(path)
    try:
        mod = Module(code)
    finally:
        globals()["BIB"] = old
    buckets = {}
    for name in mod.toc:
        m = re.match(r"^[^/]+/(\d+)([a-z]?) ", name)
        if not m:
            continue
        key = f"{prefix}{int(m.group(1))}{m.group(2)}"
        buckets.setdefault(int(m.group(1)) // 100, {})[key] = clean_lex(mod.get(name))
    for b, entries in buckets.items():
        write_js(f"lex/{prefix}{b}.js", "__LEX", entries)
    return sum(len(e) for e in buckets.values())


def compacter(il, mots):
    """Allège les mots de l'interlinéaire : la définition Strong (d) et l'analyse développée (ml) se répètent
    à chaque occurrence ; on les range une fois dans mots.js (par numéro Strong / code d'analyse) et on ne
    garde dans le chapitre que les valeurs qui diffèrent de la table. Les champs vides sont omis.
    Le navigateur les remet en place au chargement (fonction « remplir » de lectio.js et app.js)."""
    for ws in il.values():
        for w in ws:
            for k, cle in (("d", "s"), ("ml", "m")):
                if k in w and w.get(cle):
                    t = mots[k].setdefault(w[cle], w[k])
                    if t == w[k]:
                        del w[k]
            for k in [k for k, x in w.items() if x == "" or x == []]:
                del w[k]


def write_js(rel, var, obj):
    path = os.path.join(OUT, rel)
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf8") as f:
        f.write(f"window.{var}=")
        json.dump(obj, f, ensure_ascii=False, separators=(",", ":"))
        f.write(";\n")


def main():
    print("Lecture des modules…")
    jer, ati, nti, lss = Module("JER"), Module("ATI"), Module("NTI"), Module("LSS")
    lat = {"NVU": Module("NVU"), "VUC": Module("VUC")}
    sep, sef = Module("SEP"), Module("SEF")
    books_out, ati_notes, nti_notes, conc = [], set(), set(), {}
    mots = {"d": {}, "ml": {}}
    for code, name, abbr, test in BOOKS:
        chs = jer.chapters(code)
        if not chs:
            print("  ! livre absent de la BJ :", code)
            continue
        src = "ATI" if test == "AT" and ati.chapters(code) else ("NTI" if test == "NT" else "SEP")
        books_out.append({"c": code, "n": name, "a": abbr, "t": test, "ch": chs, "src": src})
        print(f"  {code} ({len(chs)} ch., {src})")
        for c in chs:
            ch = {"b": code, "c": c, "src": src}
            raw = jer.chap(code, c) or ""
            ch["bj"] = parse_bj(raw)
            fix_numbering(code, c, ch["bj"])
            intro = re.findall(r'<intro>.*?g\.php\?v=JER&g=([^"]+)".*?</intro>', raw, re.S)
            if intro:
                ch["intro"] = [html.unescape(i) for i in intro]
            csrc = src
            if src == "ATI" and not ati.chap(code, c):
                csrc = ch["src"] = "SEP"  # ex. Daniel 13-14 : grec seulement
            if csrc == "ATI":
                il = parse_ati(ati.chap(code, c))
                align_lss(il, parse_lss(lss.chap(code, c) or "", True))
                for ws in il.values():
                    for w in ws:
                        for n in w["nt"]:
                            ati_notes.add(n[1])
                ch["il"] = il
                # additions grecques (Est, Dn 3…) : versets BJ sans hébreu -> on joint la Septante
                if any(v["v"] not in il for v in ch["bj"]):
                    ch["gr"] = greek_ot(sep, sef, code, c)
            elif csrc == "NTI":
                il = parse_nti(nti.chap(code, c) or "")
                align_lss(il, parse_lss(lss.chap(code, c) or "", False))
                ch["il"] = il
            else:
                ch["gr"] = greek_ot(sep, sef, code, c)
            ch["lat"] = {k: parse_plain(m.chap(code, c)) for k, m in lat.items()}
            for v, ws in ch.get("il", {}).items():
                for w in ws:
                    if w["s"]:
                        lst = conc.setdefault(w["s"], [])
                        ref = f"{code}{c}.{v}"
                        if not lst or lst[-1][0] != ref:
                            lst.append([ref, w["g"]])
            compacter(ch.get("il", {}), mots)
            write_js(f"{code}/{c:03d}.js", "__CH", ch)
    write_js("books.js", "__BOOKS", books_out)
    write_js("mots.js", "__MOTS", mots)
    print("Concordance Strong…")
    buckets = {}
    for s, lst in conc.items():
        buckets.setdefault(s[0] + str(int(re.sub(r"\D", "", s)) // 100), {})[s] = lst
    for b, entries in buckets.items():
        write_js(f"conc/{b}.js", "__CONC", entries)
    print("Glossaires…")
    dump_glossary(ati, sorted(ati_notes), "gloss_ATI.js")
    # Introductions de la BJ
    intros = sorted(n[len("glossaire/"):-5] for n in jer.toc if n.startswith("glossaire/"))
    dump_glossary(jer, intros, "gloss_JER.js")
    print("Lexiques Strong…")
    print("  hébreu :", extract_lexicon("HEB", "H"), "articles")
    print("  grec   :", extract_lexicon("GRC", "G"), "articles")
    print("Chaîne d'or (Pères de l'Église, évangiles)…")
    import peres
    tae_path = os.path.join(APP, "Contents/Resources/commentaires/TAE.xml")
    if os.path.exists(tae_path):
        old = globals()["BIB"]
        globals()["BIB"] = os.path.dirname(tae_path)
        try:
            tae = Module("TAE")
        finally:
            globals()["BIB"] = old
        n = 0
        for code in ("MAT", "MRK", "LUK", "JHN"):
            for c in tae.chapters(code):
                secs = peres.parse_tae(tae.chap(code, c))
                n += sum(len(s["x"]) for s in secs)
                write_js(f"tae/{code}/{c:03d}.js", "__TAE", secs)
        print(f"  {n} extraits")
    print("Dictionnaires…")
    import dicos
    dicos.extraire(APP, OUT, Module)
    print("Plan de lecture…")
    import plan_lectio
    plan_lectio.exporter(os.environ.get("LECTIO_DIR", os.path.expanduser("~/Downloads/lectio-biblique")), OUT, books_out)
    print("Terminé ->", OUT)


if __name__ == "__main__":
    main()
