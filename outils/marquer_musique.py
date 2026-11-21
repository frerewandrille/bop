"""Marque, dans partitions/<carnet>/pieces.json, la nature de chaque pièce découpée :
  "nature": "musique" (portées), "texte" (strophes sans musique), "image" (gravure, vignette) ou "titre" (ligne de texte).
Les gravures et les lignes de titre ne sont pas des partitions : l'ordo et le site les ignorent.

    python3 outils/marquer_musique.py sanctoral1 sanctoral2 …
"""
import json, struct, subprocess, sys, tempfile
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent


def lire_bmp(f):
    d = Path(f).read_bytes()
    off = struct.unpack_from("<I", d, 10)[0]
    w, h = struct.unpack_from("<ii", d, 18)
    bpp = struct.unpack_from("<H", d, 28)[0]
    haut = abs(h)
    pas = ((w * bpp + 31) // 32) * 4
    k = bpp // 8
    lignes = []
    for y in range(haut):
        r = d[off + y * pas: off + y * pas + w * k]
        lignes.append(r[::k] if k > 1 else r)      # un canal suffit (gris)
    if h > 0: lignes.reverse()
    return w, haut, lignes


ENCRE = bytes(1 if i < 140 else 0 for i in range(256))


def nature(f, x0, larg_page, haut):
    """Seules les pièces centrées (loin de la marge gauche) sont examinées : gravure ou partition étroite ?"""
    if haut < 75: return "titre", 0
    if x0 <= 0.145 * larg_page: return "musique", -1
    with tempfile.TemporaryDirectory() as t:
        b = Path(t) / "x.bmp"
        subprocess.run(["sips", "-s", "format", "bmp", str(f), "--out", str(b)], capture_output=True, check=True)
        w, h, lignes = lire_bmp(b)
    # une gravure est sombre partout ; une partition est surtout blanche
    noir = sum(l.translate(ENCRE).count(1) for l in lignes) / max(1, w * h)
    return ("image" if noir > 0.14 else "musique"), round(noir * 100)


if __name__ == "__main__":
    for code in sys.argv[1:]:
        d = RACINE / "partitions" / code
        P = json.loads((d / "pieces.json").read_text())
        larg = 641 if code == "careme" else 900
        n = {}
        for x in P:
            x["nature"], x["lignes"] = nature(d / x["fichier"], x["x0"], larg, x["y1"] - x["y0"])
            n[x["nature"]] = n.get(x["nature"], 0) + 1
        (d / "pieces.json").write_text(json.dumps(P, ensure_ascii=False, indent=0), encoding="utf-8")
        print(code, n)
