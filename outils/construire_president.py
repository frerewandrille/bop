"""Prière du président avant le Notre Père (laudes, vêpres), provinces de l'Ordre par jour du mois, et oraisons
des Heures grégoriennes pour les quatre semaines → site/donnees/president.json

    python3 outils/construire_president.py

Sources (sources_gouzes/) :
  « Intercessions preces Vêpres.docx » : formule des vêpres, liste des provinces (mois impairs / pairs), « Faisant mémoire… »
  « Preces  Litanies des Laudes et Vêpres et oraisons de semaines.doc » : oraisons (Les Heures grégoriennes), semaines I à IV.
"""
import json, re, subprocess
from pathlib import Path

R = Path(__file__).resolve().parent.parent
SRC = R / "sources_gouzes"


def texte(f):
    return subprocess.run(["textutil", "-convert", "txt", "-stdout", str(f)], capture_output=True, text=True).stdout


def provinces():
    t = texte(SRC / "Intercessions preces Vêpres.docx")
    blocs = re.split(r"MOIS (IMPAIRS|PAIRS)", t)
    out = {}
    for nom, corps in zip(blocs[1::2], blocs[2::2]):
        d = {}
        for m in re.finditer(r"^\s*(\d{1,2})(?:er)?\s*:\s*(.+?)\s*$", corps, re.M):
            d[int(m.group(1))] = m.group(2).rstrip(". ").strip()
        out[nom.lower()] = d
    f = re.search(r"(Pour le Maître de l’Ordre.*?prions le Seigneur\.)", t, re.S).group(1)
    f = re.sub(r"pour la \*…+\.? \[ou : pour le/la/les \*…+\]", "{intention}", re.sub(r"\s+", " ", f))
    mem = re.sub(r"\s+", " ", re.search(r"(Faisant mémoire.*?notre Dieu\.)", t, re.S).group(1))
    mem = re.sub(r"de saint\(e\) …+\.?/du bienheureux \(de la bienheureuse\) \[[^\]]*\], ", "{saint}", mem)
    assert "{intention}" in f and "{saint}" in mem, (f, mem)
    return out, f, mem


JOURS = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"]
ROM = {"I": 1, "II": 2, "III": 3, "IV": 4, "Ι": 1, "ΙΙ": 2, "ΙΙΙ": 3}


def oraisons():
    t = texte(SRC / "Preces  Litanies des Laudes et Vêpres et oraisons de semaines.doc")
    ls = [l.strip() for l in t.split("\n")]
    a = next(i for i, l in enumerate(ls) if l == "Semaine I")
    b = next(i for i, l in enumerate(ls) if l.startswith("Temps de l’Avent"))
    out, sem, jour, office, i = {}, 0, None, None, a
    while i < b:
        l = ls[i]
        m = re.fullmatch(r"Semaine\s+([IVΙ]+)", l)
        if m: sem = ROM[m.group(1)]
        m = re.fullmatch(r"(Dimanche|Lundi|Mardi|Mercredi|Jeudi|Vendredi|Samedi)(\s+[IVΙ]+)?", l)
        if m: jour = m.group(1).lower()
        if re.fullmatch(r"(PREMIÈRES VÊPRES|LAUDES|MILIEU DU JOUR|VÊPRES|DEUXIÈMES? VÊPRES)", l):
            office = {"PREMIÈRES VÊPRES": "vepres1", "LAUDES": "laudes", "MILIEU DU JOUR": "milieu", "VÊPRES": "vepres"}.get(l, "vepres2")
        if re.fullmatch(r"Oraison\s*[⎡]?", l) and jour and jour != "dimanche":
            corps, i = [], i + 1
            while i < b and ls[i] and not re.fullmatch(r"(LAUDES|MILIEU DU JOUR|VÊPRES|PREMIÈRES VÊPRES|Oraison.*|Semaine.*|(Dimanche|Lundi|Mardi|Mercredi|Jeudi|Vendredi|Samedi)(\s+[IVΙ]+)?)", ls[i]):
                corps.append(ls[i]); i += 1
            if corps: out[f"{sem}/{jour}/{office}"] = " ".join(corps)
            continue
        i += 1
    return out


if __name__ == "__main__":
    prov, formule, memoire = provinces()
    o = oraisons()
    d = {"source": "Intercessions pour les preces de vêpres ; Litanies et oraisons (oraisons : Les Heures grégoriennes), Marseille 2023",
         "provinces": prov, "formule_vepres": formule, "memoire": memoire, "oraisons": o}
    (R / "site" / "donnees" / "president.json").write_text(json.dumps(d, ensure_ascii=False, indent=0), encoding="utf-8")
    print(f"provinces : {len(prov['impairs'])} jours (mois impairs), {len(prov['pairs'])} (mois pairs) ; oraisons : {len(o)}")
    manque = [f"{s}/{j}/{of}" for s in range(1, 5) for j in JOURS[1:] for of in ("laudes", "milieu", "vepres") if f"{s}/{j}/{of}" not in o and not (j == "samedi" and of == "vepres")]
    print("oraisons manquantes :", manque or "aucune")
    print(formule); print(memoire); print(o["1/lundi/laudes"][:120]); print(prov["impairs"].get(16), "|", prov["pairs"].get(26))
