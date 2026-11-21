#!/usr/bin/env python3
"""Bénédictions de table de la Province de Toulouse → site/donnees/table.json

Source : sources_table/Bénédiction du repas A4 Garamond-1.pdf (copie du Drive LITURGIE,
99-Divers ; la variante « -1 » est la version corrigée : « … à toutes les nations »).

Le texte est pris tel quel (typographie de la source) ; seules les coupures de ligne
dues à la mise en page (« … au banquet du / Royaume, ») sont recollées.

Forme du fichier :
  semaine.midi[jour 0-6] = [formule 1, 2, 3, 4]       (0 = dimanche)
  soir.dimanche = formule (Emmaüs) ; soir.reste = {intro, jours[0-6]}
  apres = formule (midi et soir)
  propres[clé] = {titre, texte}   (temps de Noël, Carême, Pâques, sanctoral, fêtes)
  marie = {texte (avec « (x) »), x: {clé: complément}}
  autres = [5 formules « pendant l'année »] ; avent = formule
"""
import json, re, subprocess
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
SOURCE = RACINE / "sources_table" / "Bénédiction du repas A4 Garamond-1.pdf"
SORTIE = RACINE / "site" / "donnees" / "table.json"

JOURS = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"]

# intitulés des propres → clé utilisée par site/js/table.js
PROPRES = {
    "Nativité du Christ": "noel", "Épiphanie": "epiphanie", "Baptême du Christ": "bapteme",
    "Noces de Cana": "cana", "Présentation au Temple": "presentation",
    "Mercredi des Cendres": "cendres", "Dimanche des Rameaux": "rameaux", "Jeudi Saint": "jeudi-saint",
    "Vendredi Saint": "vendredi-saint", "Samedi Saint": "samedi-saint", "Dimanche de Pâques": "paques",
    "Ascension": "ascension", "Pentecôte": "pentecote", "Sainte Trinité": "trinite", "Sacré-Cœur": "sacre-coeur",
    "Apôtres": "apotres", "Évangélistes": "evangelistes", "Martyrs": "martyrs", "Défunts": "defunts",
    "28 janvier – Saint Thomas d’Aquin": "thomas", "19 mars – Saint Joseph": "joseph",
    "24 juin – Nativité de saint Jean-Baptiste": "jean-baptiste", "6 août – Transfiguration du Seigneur": "transfiguration",
    "24 mai et 8 août – Saint Dominique": "dominique", "14 septembre-La Croix glorieuse": "croix",
    "29 septembre-Les saints Archanges": "archanges", "4 octobre – Saint François d’Assise": "francois",
    "1er novembre – Fête de tous les saints": "toussaint",
}
# compléments du « (x) » marial, dans l'ordre de la source
MARIE_X = ["mere-de-dieu", "lourdes", "annonciation", "visitation", "coeur-immacule", "assomption",
           "reine", "nativite-marie", "douleurs", "rosaire", "presentation-marie", "immaculee"]


def lignes_source(*opts):
    txt = subprocess.run(["pdftotext", *opts, str(SOURCE), "-"], capture_output=True, text=True, check=True).stdout
    out = []
    for l in txt.replace("\f", "\n").split("\n"):
        l = l.strip()
        if re.fullmatch(r"\d{1,2}", l):        # numéro de page
            continue
        out.append(l)
    return out


def recoller(lignes):
    """Lignes d'une formule ; une ligne d'un ou deux mots sans ponctuation finale prolonge la précédente."""
    res = []
    for l in lignes:
        l = re.sub(r"\s+", " ", l).strip()
        if not l:
            continue
        if res and len(l.split()) <= 2 and not res[-1].rstrip().endswith((",", ".", "!", ":", ";", "?")) \
                and not l.startswith("R/"):
            res[-1] += " " + l
        else:
            res.append(l)
    return res


def blocs(lignes):
    """Découpe en paragraphes séparés par des lignes vides."""
    b, cur = [], []
    for l in lignes:
        if l:
            cur.append(l)
        elif cur:
            b.append(cur); cur = []
    if cur:
        b.append(cur)
    return b


def entre(L, debut, fin, apres=0):
    i = L.index(debut, apres)
    j = L.index(fin, i + 1) if fin else len(L)
    return i, j


def main():
    L = lignes_source()
    data = {"source": SOURCE.name, "semaine": {"midi": {}}, "soir": {}, "propres": {}, "marie": {}, "autres": []}

    # ── Temps ordinaire, midi : 4 formules par jour
    i0 = L.index("Midi")
    i_soir = L.index("Soir")
    for n, jour in enumerate(JOURS):
        a = L.index(jour, i0)
        b = L.index(JOURS[n + 1], a + 1) if n < 6 else i_soir
        texte = [l for l in L[a + 1:b]]
        formules, cur = [], []
        for l in texte:
            m = re.match(r"^([1-4])\s*–\s*(.*)", l)
            if m:
                if cur: formules.append(cur)
                cur = [m.group(2)]
            elif l and cur is not None:
                cur.append(l)
        if cur: formules.append(cur)
        assert len(formules) == 4, (jour, len(formules))
        data["semaine"]["midi"][str(n)] = [recoller(f) for f in formules]

    # ── Soir
    a = L.index("Dimanche", i_soir)
    ob = L.index("Ou bien :", a)
    data["soir"]["dimanche"] = recoller(L[a + 1:ob])
    i_md = L.index("Midi & soir", ob)
    intro = [l for l in L[ob + 1:i_md] if l and not re.match(r"^(" + "|".join(JOURS) + r")\s*:", l)]
    intro = intro[:intro.index("bénis notre repas") + 1]
    # les jours et leur fin de phrase sont en deux colonnes : texte avec la mise en page
    M = lignes_source("-layout")
    a = M.index("Ou bien :")
    jours, cle = {}, None
    for l in M[a + 1:]:
        if l.startswith("Midi & soir"):
            break
        m = re.match(r"^(" + "|".join(JOURS) + r")\s*:\s*(.*)", l)
        if m:
            cle = str(JOURS.index(m.group(1))); jours[cle] = [m.group(2)]
        elif cle and l:
            jours[cle].append(l)
    assert len(jours) == 7, jours
    data["soir"]["reste"] = {"intro": recoller(intro), "jours": {k: re.sub(r"\s+", " ", " ".join(v)) for k, v in jours.items()}}

    # ── Après le repas
    i_t = L.index("TEMPORAL")
    a = L.index("Après le repas", i_md)
    data["apres"] = recoller(L[a + 1:i_t])

    # ── Propres (temporal, sanctoral, fêtes)
    i_s = L.index("SANCTORAL")
    i_f = L.index("Fêtes dans l’année")
    i_a = L.index("AUTRES PRIERES")
    ignore = {"Midi", "Avant le repas", "Temps de Noël", "Temps de Pâques", "SANCTORAL", "TEMPORAL", "Fêtes dans l’année"}
    cle, cur = None, []

    def ranger():
        if cle and cur:
            data["propres"][cle] = {"titre": titre, "texte": recoller(cur)}

    titre = None
    k = i_t + 1
    while k < i_a:
        l = L[k]
        if l == "Bienheureuse Vierge Marie":            # traité à part
            ranger(); cle = None; cur = []
            j = L.index("Apôtres", k)
            zone = L[k + 1:j]
            ix = next(n for n, x in enumerate(zone) if x.startswith("(x)"))
            data["marie"]["texte"] = recoller(zone[:ix])
            M = lignes_source("-layout")
            a = next(n for n, x in enumerate(M) if x.startswith("(x)"))
            vals = []
            for x in M[a:]:
                if x.startswith("Apôtres"):
                    break
                x = x[3:].strip() if x.startswith("(x)") else x
                m = re.match(r"^(.+?)\s*:\s*(.+?)…?$", x)
                if m: vals.append(m.group(2).strip().rstrip("…").strip())
            assert len(vals) == len(MARIE_X), vals
            data["marie"]["x"] = dict(zip(MARIE_X, vals))
            k = j
            continue
        if l in PROPRES:
            ranger(); cle, titre, cur = PROPRES[l], l, []
        elif l in ignore or not l:
            pass
        elif cle:
            cur.append(l)
        k += 1
    ranger()
    manquent = set(PROPRES.values()) - set(data["propres"])
    assert not manquent, manquent

    # ── Autres prières (pendant l'année, Avent)
    i_av = L.index("Au temps de l’Avent")
    zone = L[L.index("Pendant l’année", i_a) + 1:i_av]
    cur = []
    for l in zone:
        m = re.match(r"^([1-5])\s*–\s*(.*)", l)
        if m:
            if cur: data["autres"].append(recoller(cur))
            cur = [m.group(2)]
        elif l:
            cur.append(l)
    if cur: data["autres"].append(recoller(cur))
    assert len(data["autres"]) == 5
    data["avent"] = recoller(L[i_av + 1:])

    # « R/Amen » collé en fin de ligne → ligne à part, comme dans la source imprimée
    def amen(x):
        if isinstance(x, list) and all(isinstance(s, str) for s in x):
            out = []
            for s in x:
                m = re.match(r"^(.*?)\s*R/\s*Amen\.?$", s)
                if m and m.group(1): out += [m.group(1), "R/ Amen."]
                elif m: out.append("R/ Amen.")
                else: out.append(s)
            return out
        if isinstance(x, list): return [amen(y) for y in x]
        if isinstance(x, dict): return {k: amen(v) for k, v in x.items()}
        return x
    data = amen(data)
    data["soir"]["reste"]["jours"] = {k: re.sub(r"\s*R/\s*Amen\.?$", "", v) for k, v in data["soir"]["reste"]["jours"].items()}

    SORTIE.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
    n = sum(len(v) for v in data["semaine"]["midi"].values()) + len(data["propres"]) + len(data["autres"]) + 4
    print(f"{SORTIE.relative_to(RACINE)} : {n} formules, {len(data['propres'])} propres, {len(data['marie']['x'])} fêtes mariales")


if __name__ == "__main__":
    main()
