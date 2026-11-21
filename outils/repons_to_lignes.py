#!/usr/bin/env python3
"""Répons de Gouzes du temps ordinaire (8 semaines, laudes et vêpres) avec leurs retours à la ligne.

Source : « sources_gouzes/Répons du temps ordinaire (8 semaines).txt » (texte envoyé par l'utilisateur
le 17/11/2026). Remplace le refrain et les versets de textes.repons["to/N/laudes|vepres"] de gouzes.json
(les autres champs, dont les versets des saints, restent). Appelé par construire_gouzes.py ;
seul : `python3 outils/repons_to_lignes.py` corrige gouzes.json en place.
"""
import json, re
from pathlib import Path

ICI = Path(__file__).resolve().parent
SOURCE = ICI.parent / "sources_gouzes" / "Répons du temps ordinaire (8 semaines).txt"
GOUZES = ICI.parent / "site" / "donnees" / "gouzes.json"
ROM = {"I": 1, "II": 2, "III": 3, "IV": 4, "V": 5, "VI": 6, "VII": 7, "VIII": 8}
QUAND = {"lun": "lun", "mar": "mar", "mer": "mer", "jeu": "jeu", "ven": "ven", "sam": "sam", "dox": "dox", "mag": "mag"}


def lire():
    out, cle, r, v = {}, None, None, None
    sem = None
    for brut in SOURCE.read_text(encoding="utf-8").splitlines():
        l = brut.strip()
        if not l:
            continue
        m = re.match(r"^Semaine ([IVX]+)$", l)
        if m: sem = ROM[m.group(1)]; continue
        if l in ("Laudes", "Vêpres"):
            cle = f"to/{sem}/{'laudes' if l == 'Laudes' else 'vepres'}"
            r = out[cle] = {"refrain": [], "versets": []}; v = None; continue
        if l == "Répons": continue
        if re.match(r"^[BC] \d{3}$", l): r["cote"] = l; continue
        m = re.match(r"^(\d+)\.\s*\((\w+)\.?\)\s*(.*)$", l)
        if m:
            v = {"n": int(m.group(1)), "quand": QUAND[m.group(2).lower()[:3]], "lignes": [m.group(3)]}
            r["versets"].append(v); continue
        (v["lignes"] if v else r["refrain"]).append(l)
    for r in out.values():
        r["refrain"] = "\n".join(r["refrain"])
        for v in r["versets"]:
            v["texte"] = "\n".join(v.pop("lignes"))
    return out


def appliquer(textes):
    reps = textes.setdefault("repons", {})
    for cle, r in lire().items():
        ancien = reps.get(cle, {})
        reps[cle] = {**ancien, "cote": r.get("cote", ancien.get("cote")), "refrain": r["refrain"], "versets": r["versets"]}
    return textes


if __name__ == "__main__":
    d = json.loads(GOUZES.read_text(encoding="utf-8"))
    appliquer(d["textes"])
    GOUZES.write_text(json.dumps(d, ensure_ascii=False, indent=0), encoding="utf-8")
    print("Répons du temps ordinaire : 16 répons mis à jour (retours à la ligne)")
