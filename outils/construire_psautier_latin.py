#!/usr/bin/env python3
"""Psautier latin (Nova Vulgata, numérotation hébraïque des psaumes et des versets) pour l'Office des
lectures de la version « latin-français ».

Source : les chapitres de la Bible intégrée (bible/data/PSA/NNN.js, champ lat.NVU, par verset).
Sortie : site/donnees/psautier_latin.json = {"<n° hébreu>": {"<verset>": "texte"}}.
"""
import json
import pathlib
import re
import sys

RACINE = pathlib.Path(__file__).resolve().parent.parent
SRC = RACINE / "bible" / "data" / "PSA"
SORTIE = RACINE / "site" / "donnees" / "psautier_latin.json"


# lettres de l'acrostiche (« ALEPH. », « VAU. ») : la traduction liturgique française ne les donne pas
LETTRES = r"(ALEPH|BETH|GHIMEL|DALETH|HE|VAU|ZAIN|HETH|TETH|IOD|CAPH|LAMED|MEM|NUN|SAMECH|AIN|PHE|SADE|COPH|RES|SIN|TAU)"
# titres des psaumes (« Magistro chori. PSALMUS. David. ») : retirés en tête du verset 1
TITRE = re.compile(r"^(Magistro chori|PSALMUS|David|Asaph|Filiorum Core|Maskil|Miktam|Canticum\b|Precatio|Secundum|Ad modum|Fidibus"
                   r"|Ad tibias|Super octavam|Ad commemorandum|ALLELUIA|Laudes\b|Lamentatio|Ad gratiarum|Pro die Sabbati|Ad docendum"
                   r"|Ad cantandum|Heman|Idithun|Iduthun|Salomonis|Moysi|Oratio|Quando|Cum\b)")
# retouches à la main (le titre déborde sur le verset suivant)
RETOUCHES = {("18", "2"): lambda t: t.split("Dixit igitur: ", 1)[-1]}


def nettoyer(ps, v, t):
    t = re.sub(rf"\b{LETTRES}\.\s*", "", t)
    if (ps, v) in RETOUCHES:
        t = RETOUCHES[(ps, v)](t)
    if v == "1":
        # phrases du titre, une à une (« David, cum fugit a filio suo Absalom. »)
        while True:
            m = re.match(r"^([^.]*?(?:“[^”]*”[^.]*?)?)\.\s*", t)
            if not m or not TITRE.match(t) or len(m.group(1)) > 140:
                break
            t = t[m.end():]
    t = t.strip()
    return t[:1].upper() + t[1:] if t else t


def main():
    out = {}
    for n in range(1, 151):
        f = SRC / f"{n:03d}.js"
        if not f.exists():
            sys.exit(f"manque {f}")
        s = f.read_text(encoding="utf-8")
        d = json.loads(s[s.index("=") + 1:].strip().rstrip(";"))
        nvu = (d.get("lat") or {}).get("NVU") or {}
        if not nvu:
            sys.exit(f"Ps {n} : pas de texte Nova Vulgata")
        out[str(n)] = {v: nettoyer(str(n), v, " ".join(t.split())) for v, t in nvu.items()}
    SORTIE.write_text(json.dumps(out, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    print(f"{SORTIE.relative_to(RACINE)} : {len(out)} psaumes, {sum(len(x) for x in out.values())} versets, "
          f"{SORTIE.stat().st_size // 1024} Ko")


if __name__ == "__main__":
    main()
