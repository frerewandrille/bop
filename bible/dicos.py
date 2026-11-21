"""
Dictionnaires bibliques de Biblia Universalis -> data/dico/ et data/dref/

  data/dico/index.js   window.__DICO = {"d": [{"c": "VTB", "n": "Vocabulaire de théologie biblique"}, …],
                                        "t": {"VTB": [["CŒUR", n° de paquet], …], …}}
  data/dico/VTB/003.js window.__ART = {"CŒUR": html, …}           (paquets d'environ 300 Ko)
  data/dref/MAT.js     window.__DREF = {"5.8": [[n° dico, n° article], …]}
                       = les articles qui CITENT ce verset (index inversé des références)
"""
import html
import json
import os
import re

DICOS = [
    ("VTB", "Vocabulaire de théologie biblique"),
    ("NDB", "Nouveau dictionnaire biblique"),
    ("WES", "Dictionnaire Westphal"),
    ("CAL", "Dictionnaire de Calmet"),
    ("BOS", "Dictionnaire de Bost"),
    ("DBT", "Dictionnaire biblique pour tous"),
    ("DNP", "Dictionnaire des noms propres"),
    ("LEL", "Lexique de la Bible (Lelièvre)"),
]
PACK = 300_000
MAX_RANGE = 40  # au-delà, une référence est trop large pour être utile verset par verset

REF = re.compile(r'<a class="ref" href="r\.php\?v=\w+&r=([^"]+)">(.*?)</a>', re.S)
INNER = re.compile(r'<a[^>]*href="d\.php\?d=(\w+)&f=[^/"]*/([^"]+?)\.html"[^>]*>(.*?)</a>', re.S)


def unent(s):
    return re.sub(r"&(?!lt;|gt;|amp;)(#?\w+);", lambda m: html.unescape(m.group(0)), s)


def clean(c, code):
    c = re.sub(r"(?s)^.*?<body>", "", c)
    c = re.sub(r"(?s)</body>.*$", "", c)
    c = re.sub(r"(?s)<script.*?</script>", "", c)
    c = re.sub(r"(?s)<table[^>]*>(?:(?!</table>).)*?(?:&#x25C4;|◄|►|back\.png).*?</table>\s*(<hr>)?", "", c, count=1)
    c = REF.sub(lambda m: f'<a class="ref" data-r="{m.group(1)}">{m.group(2)}</a>', c)
    c = INNER.sub(lambda m: f'<a class="dlink" data-dico="{m.group(1)}|{html.unescape(m.group(2))}">{m.group(3)}</a>', c)
    c = re.sub(r'<a (?![^>]*data-(?:r|dico)=)[^>]*>(.*?)</a>', r"\1", c, flags=re.S)
    c = re.sub(r"<img[^>]*>", "", c)
    c = re.sub(r'\s(?:width|align|cellpadding|cellspacing|style|bgcolor|face|size)="?[^"\s>]*"?', "", c)
    c = re.sub(r"\n\s*", "\n", c)
    return unent(c).strip()


def refs_of(r):
    """« MAT5.8 », « MAT5.1-12 », « PSA92.11;133.2 », « 1CO13.4-7 » -> [(livre, ch, v), …]"""
    out, book = [], None
    for part in r.split(";"):
        m = re.match(r"^([1-3]?[A-Z]{2,3})?(\d+)\.(\d+)(?:-(\d+))?$", part.strip())
        if not m:
            continue
        book = m.group(1) or book
        if not book:
            continue
        c, a = int(m.group(2)), int(m.group(3))
        b = int(m.group(4)) if m.group(4) else a
        if b < a or b - a > MAX_RANGE:
            b = a
        out += [(book, c, v) for v in range(a, b + 1)]
    return out


def extraire(app, out_dir, Module):
    base = os.path.join(app, "Contents/Resources/dictionnaires")
    index = {"d": [], "t": {}}
    dref = {}
    for di, (code, nom) in enumerate(DICOS):
        path = os.path.join(base, code + ".xml")
        if not os.path.exists(path):
            continue
        mod = Module(path)
        titles, pack, size, npack = [], {}, 0, 0

        def flush():
            nonlocal pack, size, npack
            if pack:
                write(os.path.join(out_dir, "dico", code, f"{npack:03d}.js"), "__ART", pack)
                npack += 1
                pack, size = {}, 0

        names = sorted((n for n in mod.toc if n.endswith(".html") and "/" in n
                        and not n.split("/", 1)[1].startswith(" ") and "A-Z" not in n),
                       key=lambda n: n.split("/", 1)[1].lower())
        for name in names:
            title = name.split("/", 1)[1][:-5]
            raw = mod.get(name) or ""
            art = clean(raw, code)
            if len(re.sub(r"<[^>]+>", "", art).strip()) < 20:
                continue
            ei = len(titles)
            titles.append([title, npack])
            pack[title] = art
            size += len(art.encode())
            seen = set()
            for r in re.findall(r'r\.php\?v=\w+&r=([^"&]+)', raw):
                for (b, c, v) in refs_of(r):
                    k = (b, c, v)
                    if k in seen:
                        continue
                    seen.add(k)
                    dref.setdefault(b, {}).setdefault(f"{c}.{v}", []).append([di, ei])
            if size > PACK:
                flush()
        flush()
        index["d"].append({"c": code, "n": nom, "i": di})
        index["t"][code] = titles
        print(f"  {code} : {len(titles)} articles")
    write(os.path.join(out_dir, "dico", "index.js"), "__DICO", index)
    for b, m in dref.items():
        write(os.path.join(out_dir, "dref", b + ".js"), "__DREF", m)
    print(f"  index des citations : {sum(len(m) for m in dref.values())} versets cités")


def write(path, var, obj):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf8") as f:
        f.write(f"window.{var}=")
        json.dump(obj, f, ensure_ascii=False, separators=(",", ":"))
        f.write(";\n")
