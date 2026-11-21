"""Construit le sanctoral romain (célébrations à date fixe) pour le site → site/donnees/sanctoral.json

    python3 outils/construire_calendrier.py

- sanctoral.json : calendrier romain pour la France, relevé sur les « informations »
  AELF de 2018 à 2027 (outils/aelf_informations.json, voir recolter_aelf.py).
  Une célébration est retenue pour une date si l'AELF la donne ce jour-là au moins
  trois années (les fêtes mobiles, elles, changent de date : le calendrier les calcule).
- propre_op.json (calendrier de l'Ordre) n'est PLUS fait ici depuis le 20/11/2026 : c'est
  outils/construire_missel_op.py qui l'écrit, d'après le Missel de l'Ordre (degrés de la Province).
  L'ancien propre_op.toml (Calendarium 2019) est rangé dans archives/ : le relire ici aurait
  effacé ces degrés.
- corrections.json (facultatif, à éditer à la main) : remplace ou ajoute des entrées.
"""
from __future__ import annotations
import json
import re
from collections import Counter, defaultdict
from pathlib import Path

ICI = Path(__file__).resolve().parent
DONNEES = ICI.parent / "site" / "donnees"

TEMPORAL = re.compile(r"\b(dimanche|férie|semaine|octave|Avent|Carême|Pâques|Rameaux|Cendres|Pentecôte|Ascension|"
                      r"Trinité|Saint Sacrement|Sacré-C|Christ, Roi|Christ Roi|Sainte Famille|Baptême du Seigneur|"
                      r"Épiphanie|Nativité du Seigneur|Mère de l'Église|Mère de l’Église|Cœur immaculé|Coeur immacul|"
                      r"Jeudi saint|Vendredi saint|Samedi saint|Sainte Marie, Mère de Dieu|Jésus-Christ, Souverain prêtre|DÉDICACE DES ÉGLISES)\b", re.I)


def rang_de(info):
    deg = (info.get("degre") or "") + " " + (info.get("fete") or "") + " " + (info.get("ligne2") or "")
    l3 = (info.get("ligne3") or "")
    if "Solennité" in deg:
        return "solennité"
    if re.search(r"\bFête\b", deg):
        return "fête"
    if l3.startswith("Mémoire facultative") or "Mémoire facultative" == (info.get("degre") or ""):
        return "mémoire facultative"
    if l3.startswith("Mémoire") or (info.get("degre") or "") == "Mémoire":
        return "mémoire"
    return None


def nom_de(info, rang):
    jl = info.get("jour_liturgique_nom") or ""
    if jl.startswith("de la férie") or not jl or rang in ("mémoire", "mémoire facultative"):
        n = info.get("fete") or info.get("ligne2") or ""
    else:
        n = info.get("ligne1") or jl
    n = re.sub(r"\s*\((dimanche|semaine [IV]+ du Psautier)\)\s*$", "", n).strip()
    return n.replace("l'Eglise", "l'Église").replace("l’Eglise", "l’Église")


def sanctoral():
    infos = json.loads((ICI / "aelf_informations.json").read_text(encoding="utf-8"))
    par_date = defaultdict(Counter)
    couleur = {}
    secondaires = defaultdict(Counter)
    for d, info in infos.items():
        if "erreur" in info:
            continue
        rang = rang_de(info)
        if rang:
            nom = nom_de(info, rang)
            if nom and nom not in ("Solennité", "Fête", "Mémoire") and not (TEMPORAL.search(nom) and rang != "mémoire facultative" and "Saint" not in nom[:6]):
                par_date[d[5:]][(nom, rang)] += 1
                couleur[(nom, rang)] = info.get("couleur")
        m = re.match(r"^(.+?)\.\s*Mémoire facultative$", info.get("ligne3") or "")
        if m:
            secondaires[d[5:]][m.group(1).strip()] += 1
    total_nom = Counter()
    for c in par_date.values():
        for k, n in c.items():
            total_nom[k[0]] += n
    out = {}
    for mmjj, c in sorted(par_date.items()):
        (nom, rang), n = c.most_common(1)[0]
        # rang le plus élevé observé pour ce nom à cette date (un dimanche peut masquer une fête)
        rangs = [r for (nn, r) in c if nn == nom]
        for r in ("solennité", "fête", "mémoire", "mémoire facultative"):
            if r in rangs:
                rang = r
                break
        total = sum(v for (nn, _), v in c.items() if nn == nom)
        if total < 3 or total < 0.6 * total_nom[nom]:
            continue
        e = {"nom": nom, "rang": rang}
        if couleur.get((nom, rang)) == "rouge":
            e["couleur"] = "rouge"
        out[mmjj] = e
    for mmjj, c in secondaires.items():
        nom, n = c.most_common(1)[0]
        if n >= 2:
            out.setdefault(mmjj, {"nom": nom, "rang": "mémoire facultative"})
            if out[mmjj]["nom"] != nom:
                out[mmjj].setdefault("autres", []).append(nom)
    corr = ICI / "corrections_sanctoral.json"
    if corr.exists():
        for k, v in json.loads(corr.read_text(encoding="utf-8")).items():
            if v is None:
                out.pop(k, None)
            else:
                out[k] = v
    return out


if __name__ == "__main__":
    DONNEES.mkdir(parents=True, exist_ok=True)
    s = sanctoral()
    (DONNEES / "sanctoral.json").write_text(json.dumps(s, ensure_ascii=False, indent=0), encoding="utf-8")
    from collections import Counter as C
    print("sanctoral :", len(s), "dates", dict(C(v["rang"] for v in s.values())))
