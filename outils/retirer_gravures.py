#!/usr/bin/env python3
"""Gravures (illustrations) des carnets : on ne garde que les partitions (demande de l'utilisateur, 20/11/2026).

  python3 outils/retirer_gravures.py            # applique la liste GRAVURES ci-dessous
  python3 outils/retirer_gravures.py --voir F   # mesure une image (zone dessinée détectée)

Pour chaque image de la liste (vérifiée à l'œil) :
  - "page"  : page entière de gravure → ajoutée à « retirer » dans partitions/corrections.json ;
  - "bas"   : gravure sous la musique → l'image est coupée au-dessus de la gravure ;
  - ("zone", x0, y0, x1, y1) : gravure à côté de la musique → ce rectangle (fractions de la largeur et de la hauteur,
              relevées à l'œil) est blanchi, sauf les lignes de portée qui le traversent ;
  - "pave"  : pavé noir sur le bord droit → bord coupé.
Les images corrigées vont dans partitions/corrections/<carnet>-<nom>-sans-gravure.jpg et sont déclarées dans
« remplacer » (corrections.json). Lecture et écriture des images : sips (macOS) ↔ BMP, sans bibliothèque.
"""
import json, os, struct, subprocess, sys, tempfile

RACINE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
P = os.path.join(RACINE, "partitions")

GRAVURES = {
    "avent/p-226.jpg": "page", "noel/p-039.jpg": "page", "noel/p-177.jpg": "page", "paques/p-037.jpg": "page",
    "avent/h-057-1-1.jpg": "bas", "avent/h-199-1-2.jpg": "bas", "avent/h-203-1-2.jpg": "bas",
    "careme/h-203-1-1.jpg": "bas", "careme/h-207-1-1.jpg": "page", "careme/h-219-1-1.jpg": "bas",
    "noel/h-019-1-1.jpg": ("zone", .44, .72, .92, .97), "noel/h-051-1-1.jpg": "bas", "noel/h-059-1-1.jpg": ("zone", .46, .60, .88, .97), "noel/h-093-1-1.jpg": "bas",
    "noel/h-111-1-1.jpg": "bas", "noel/h-183-1-1.jpg": ("zone", .42, .62, .98, 1), "noel/h-201-1-2.jpg": "bas",
    "paques/h-179-1-1.jpg": "bas", "paques/h-235-1-1.jpg": ("zone", .55, .55, .95, 1), "paques/h-243-1-2.jpg": "bas",
    "sanctoral2/h-078-1-1.jpg": "bas", "sanctoral2/h-142-1-1.jpg": "bas", "sanctoral2/h-168-1-1.jpg": "bas",
    "sanctoral2/h-189-1-1.jpg": ("zone", .36, .72, .68, 1), "sanctoral2/h-259-1-1.jpg": "bas", "sanctoral2/h-284-1-1.jpg": "bas",
    "marseille/a-058-2.jpg": "pave", "marseille/a-070-1.jpg": "pave", "marseille/a-054-2.jpg": "pave",
}


def lire(f):
    tmp = tempfile.mktemp(suffix=".bmp")
    subprocess.run(["sips", "-s", "format", "bmp", f, "--out", tmp], capture_output=True, check=True)
    b = open(tmp, "rb").read(); os.remove(tmp)
    off = struct.unpack_from("<I", b, 10)[0]; w, h = struct.unpack_from("<ii", b, 18); bpp = struct.unpack_from("<H", b, 28)[0]
    bp = bpp // 8; pas = ((w * bp) + 3) & ~3; bas = h > 0; h = abs(h)
    g = []
    for y in range(h):
        base = off + ((h - 1 - y) if bas else y) * pas
        row = b[base: base + w * bp]
        g.append(bytearray((row[x] + row[x + 1] + row[x + 2]) // 3 for x in range(0, w * bp, bp)))
    return w, h, g


def ecrire(g, sortie):
    h = len(g); w = len(g[0]); pas = ((w * 3) + 3) & ~3
    corps = bytearray()
    for y in range(h - 1, -1, -1):
        r = bytearray()
        for v in g[y]:
            r += bytes((v, v, v))
        corps += r + b"\0" * (pas - w * 3)
    tete = b"BM" + struct.pack("<IHHI", 54 + len(corps), 0, 0, 54) + struct.pack("<IiiHHIIiiII", 40, w, h, 1, 24, 0, len(corps), 2835, 2835, 0, 0)
    tmp = tempfile.mktemp(suffix=".bmp")
    open(tmp, "wb").write(tete + corps)
    subprocess.run(["sips", "-s", "format", "jpeg", "-s", "formatOptions", "85", tmp, "--out", sortie], capture_output=True, check=True)
    os.remove(tmp)


def profils(g, x0=0, x1=None):
    w = len(g[0]); x1 = x1 or w
    sombre = [sum(1 for v in r[x0:x1] if v < 180) / (x1 - x0) for r in g]
    nonblanc = [sum(1 for v in r[x0:x1] if v < 230) / (x1 - x0) for r in g]
    return sombre, nonblanc


def zone_dessinee(g):
    """plus haute bande de lignes encrées sans ligne de portée (> 60 % de la largeur non blanche)"""
    h, w = len(g), len(g[0])
    a, c = profils(g)
    portee = [x > 0.6 for x in c]
    best = cur = y0 = by = 0
    for y in range(h):
        if a[y] > 0.04 and not portee[y]:
            if cur == 0: y0 = y
            cur += 1
            if cur > best: best, by = cur, y0
        else:
            cur = 0
    # colonnes de la gravure dans cette bande
    cols = [sum(1 for y in range(by, by + best) if g[y][x] < 180) / max(1, best) for x in range(w)]
    xs = [x for x, v in enumerate(cols) if v > 0.12]
    return by, by + best, (min(xs) if xs else 0), (max(xs) + 1 if xs else w)


def rogner_blanc(g):
    h = len(g)
    lignes = [y for y in range(h) if sum(1 for v in g[y] if v < 200) > 2]
    if not lignes:
        return g
    return g[max(0, lignes[0] - 8): min(h, lignes[-1] + 9)]


def corriger(f, mode):
    w, h, g = lire(os.path.join(P, f))
    if mode == "pave":
        # colonnes presque entièrement noires sur le bord droit
        noires = [x for x in range(w) if sum(1 for y in range(h) if g[y][x] < 80) > 0.6 * h]
        x0 = min(noires) if noires else w
        g = [r[:max(1, x0 - 4)] for r in g]
    elif mode == "bas":
        # coupé au-dessus de la gravure ; une courte ligne isolée juste au-dessus (sa légende) part avec elle
        y0, y1, x0, x1 = zone_dessinee(g)
        g = rogner_blanc(g[:max(1, y0 - max(6, w // 80))])
        blanc = [sum(1 for v in r if v < 200) <= 2 for r in g]
        n, y = 0, len(g) - 1
        while y > 0 and not blanc[y]: y -= 1                 # haut du dernier bloc
        bloc = len(g) - y
        if 0 < bloc < h * 0.05 and y > 0:      # reste de gravure ou légende : bien moins haut qu'une portée avec ses paroles
            g = rogner_blanc(g[:y])
    else:
        _, fx0, fy0, fx1, fy1 = mode
        X0, X1 = int(fx0 * w), min(w, int(fx1 * w) + 1)
        dehors = [x for x in range(w) if x < X0 or x >= X1]
        for y in range(int(fy0 * h), min(h, int(fy1 * h) + 1)):
            # ligne de portée qui traverse la gravure (elle se prolonge hors du rectangle) : gardée
            traverse = lambda y: X0 > 3 and X1 < w - 3 and min(g[y][X0 - 3:X0]) < 200 and min(g[y][X1:X1 + 3]) < 200
            if dehors and sum(1 for x in dehors if g[y][x] < 200) > 0.5 * len(dehors) and traverse(y):
                continue
            for x in range(X0, X1):
                g[y][x] = 255
    g = rogner_blanc(g)
    nom = f.replace("/", "-").replace(".jpg", "-sans-gravure.jpg")
    ecrire(g, os.path.join(P, "corrections", nom))
    return f"corrections/{nom}"


def main():
    if sys.argv[1:2] == ["--voir"]:
        w, h, g = lire(os.path.join(P, sys.argv[2]))
        print(w, h, zone_dessinee(g))
        return
    C = json.load(open(os.path.join(P, "corrections.json"), encoding="utf-8"))
    for f, mode in GRAVURES.items():
        if mode == "page":
            if f not in C["retirer"]:
                C["retirer"].append(f)
            print(f"{f} : retirée (gravure seule)")
            continue
        C["remplacer"][f] = corriger(f, mode)
        print(f"{f} → {C['remplacer'][f]} ({mode if isinstance(mode, str) else 'zone'})")
    json.dump(C, open(os.path.join(P, "corrections.json"), "w", encoding="utf-8"), ensure_ascii=False, indent=1)


if __name__ == "__main__":
    main()
