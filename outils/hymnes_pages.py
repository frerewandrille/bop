#!/usr/bin/env python3
"""Images « d'un seul tenant » pour les hymnes (demande de l'utilisateur, 17/11/2026).

Le découpage (decouper_partitions.py) coupe parfois une hymne en plusieurs morceaux sur la même
page (s-077-1, s-077-2 : les paroles entre les portées tombent dans le vide). Pour chaque page d'un
carnet et chaque suite de pièces k..m de cette page, on fabrique h-NNN-k-m.jpg : la zone qui va du
haut de la pièce k au bas de la pièce m, avec une marge généreuse (sans mordre sur les pièces
voisines qui ne font pas partie de la suite). Le site (Partitions.figure, rôle hymne/lucernaire)
remplace alors les morceaux d'une même page par cette image unique.

    python3 outils/hymnes_pages.py [carnet ...]     (par défaut : les carnets de la Province)
"""
import json, subprocess, sys
from collections import defaultdict
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent / "partitions"
CARNETS = ["to", "avent", "careme", "paques", "noel", "sanctoral1", "sanctoral2"]
MARGE = 38          # pixels (rendu 110 dpi ≈ 9 mm)
MARGE_X = 22


def taille(img):
    out = subprocess.run(["sips", "-g", "pixelWidth", "-g", "pixelHeight", str(img)], capture_output=True, text=True).stdout
    w = int(out.split("pixelWidth:")[1].split()[0]); h = int(out.split("pixelHeight:")[1].split()[0])
    return w, h


def carnet(code):
    dossier = RACINE / code
    pieces = json.loads((dossier / "pieces.json").read_text())
    par_page = defaultdict(list)
    for p in pieces:
        par_page[p["page"]].append(p)
    faits = 0
    for page, ps in sorted(par_page.items()):
        ps.sort(key=lambda p: p["n"])
        src = dossier / f"p-{page:03d}.jpg"
        if not src.exists():
            continue
        W, H = taille(src)
        for i, a in enumerate(ps):
            for j in range(i, len(ps)):
                b = ps[j]
                avant = ps[i - 1] if i > 0 else None
                apres = ps[j + 1] if j + 1 < len(ps) else None
                haut = a["y0"] - MARGE
                if avant: haut = max(haut, (avant["y1"] + a["y0"]) // 2)
                bas = b["y1"] + MARGE
                if apres: bas = min(bas, (b["y1"] + apres["y0"]) // 2)
                haut, bas = max(0, haut), min(H - 45, bas)      # ne pas prendre le numéro de page
                bloc = ps[i:j + 1]
                g = max(0, min(p["x0"] for p in bloc) - MARGE_X)
                d = min(W, max(p["x1"] for p in bloc) + MARGE_X)
                sortie = dossier / f"h-{page:03d}-{a['n']}-{b['n']}.jpg"
                if sortie.exists() and sortie.stat().st_mtime > src.stat().st_mtime:
                    continue
                subprocess.run(["sips", "-c", str(bas - haut), str(d - g), "--cropOffset", str(haut), str(g),
                                str(src), "--out", str(sortie)], capture_output=True, check=True)
                faits += 1
    print(f"{code} : {faits} image(s) fabriquée(s)")


if __name__ == "__main__":
    for c in sys.argv[1:] or CARNETS:
        carnet(c)
