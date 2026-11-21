#!/usr/bin/env python3
"""Lectionnaire patristique dominicain (J.-R. Bouchet) → site/donnees/bouchet.json

    python3 outils/construire_bouchet.py ["sources_gouzes/bouchet/lectionnaire Bouchet.docx"]

Le .docx est lu par textutil (macOS), qui garde les retraits (tabulations, espaces) des lignes.
Chaque entrée du lectionnaire (titre du sommaire) reçoit une clé du calendrier du site :
  - temporal : clé AELF du jour (« avent-1-0 », « careme-2-3 », « paques-6-4 », « trinite »…) ;
  - sanctoral : « MM-JJ » ;
  - lectures « au choix » d'un temps : « autres-avent », « autres-noel », « autres-epiphanie »,
    « autres-paques », « autres-pentecote », « autres-to », « feries-17-24 ».
Chaque entrée : { titre, note?, lectures: [{ lecon?, citation?, ref?, auteur, texte: [[ligne, forme], …] (0 prose, 1 vers, 2 vers en retrait) }] }.
"""
import json, re, subprocess, sys
from pathlib import Path

R = Path(__file__).resolve().parent.parent
SRC = Path(sys.argv[1]) if len(sys.argv) > 1 else R / "sources_gouzes/bouchet/lectionnaire Bouchet.docx"
SORTIE = R / "site/donnees/bouchet.json"

ORD = ["Premier", "Deuxième", "Troisième", "Quatrième", "Cinquième", "Sixième", "Septième", "Huitième", "Neuvième",
       "Dixième", "Onzième", "Douzième", "Treizième", "Quatorzième", "Quinzième", "Seizième", "Dix-septième",
       "Dix-huitième", "Dix-neuvième", "Vingtième", "Vingt et unième", "Vingt-deuxième", "Vingt-troisième",
       "Vingt-quatrième", "Vingt-cinquième", "Vingt-sixième", "Vingt-septième", "Vingt-huitième", "Vingt-neuvième",
       "Trentième", "Trente et unième", "Trente-deuxième", "Trente-troisième"]
N = {o.lower(): i + 1 for i, o in enumerate(ORD)}

# titres du temporal → clé (les dimanches et les jours de Carême sont calculés plus bas)
TEMPORAL = {
    "Autres lectures pour le temps de l'Avent": "autres-avent",
    "Les sept fériés préparatoires à Noël": "feries-17-24",
    "Noël": "noel", "La sainte famille": "sainte-famille",
    "Autres lectures pour le temps de Noël": "autres-noel",
    "Epiphanie": "epiphanie", "Baptême du Christ": "bapteme", "Les Noces de Cana": "cana",
    "Autres lectures pour l'Epiphanie": "autres-epiphanie",
    "Mercredi des Cendres": "careme-0-3", "Vendredi après les Cendres": "careme-0-5",
    "Dimanche des Rameaux et de la Passion": "careme-6-0", "Lundi saint": "careme-6-1", "Mardi saint": "careme-6-2",
    "Mercredi saint": "careme-6-3", "Jeudi saint": "careme-6-4", "Vendredi saint": "careme-6-5", "Samedi saint": "careme-6-6",
    "Pâques": "paques-1-0", "Autres lectures pour le temps de Pâques": "autres-paques",
    "Vigile de l'Ascension": "paques-6-3", "Ascension": "paques-6-4",
    "Vigile de Pentecôte": "paques-7-6", "Pentecôte": "paques-8-0",
    "Autres lectures pour le temps de la Pentecôte": "autres-pentecote",
    "Fête de la Sainte-Trinité": "trinite", "Fête du Saint-Sacrement": "saint-sacrement", "Fête du Sacré-Cœur": "sacre-coeur",
    "Solennité du Christ-Roi": "christ-roi", "Autres lectures pour le temps ordinaire": "autres-to",
    "Dédicace de l'église locale": "10-22", "Dédicace de l'église cathédrale": "dedicace-cathedrale",
}
MOIS = {"JANVIER": 1, "FEVRIER": 2, "FÉVRIER": 2, "MARS": 3, "AVRIL": 4, "MAI": 5, "JUIN": 6, "JUILLET": 7,
        "AOUT": 8, "AOÛT": 8, "SEPTEMBRE": 9, "OCTOBRE": 10, "NOVEMBRE": 11, "DECEMBRE": 12, "DÉCEMBRE": 12}
TEMPS = {"TEMPS DE L'AVENT", "OCTAVE PRÉPARATOIRE A NOËL DU 17 AU 24 DÉCEMBRE", "TEMPS DE NOËL", "TEMPS DE CAREME",
         "TEMPS PASCAL", "TEMPS DE LA PENTECÔTE", "SOLENNITÉS DU SEIGNEUR", "TEMPS ORDINAIRE", "SANCTORAL"}
LECONS = re.compile(r"^(PREMIER|PREMI[ÈE]RE|DEUXI[ÈE]ME|TROISI[ÈE]ME) (LE[ÇC]ON|NOCTURNE)$")
AUTEUR = re.compile(r"^(Sermon|Homélie|Hymne|Canon|Prière|Passion|Première apologie|Lettre|Commentaire|D'une|De l[a'’ ]|De saint|De sainte|Du |Des |De la )")
# un titre d'auteur nomme quelqu'un ou un document (sinon c'est un vers : « Du sein de la Vierge »)
AUTEUR_MOT = re.compile(r"\b(saint|sainte|bienheureux|liturgie|Épître|Constitution|Exorde|bulle|témoins|écrits|lettres?|commentaire|Mémoire|apologie|Église)\b", re.I)
REF = re.compile(r"((?:Saint )?[A-ZÉÈÂÎÏÔ][A-Za-zÉÈÂÎÏÔéèâîïôë]+ \d+, ?\d+(?:-\d+)?(?: [a-c](?: et [a-c])?)?)\s*$")
REF_BIBLE = re.compile(r"^(?:[1-3] )?[A-ZÉ][a-zéèêëï]+ \d+, [\d ,ab-]+$")   # titres des lectures des nocturnes


def cle_temporal(titre):
    if titre in TEMPORAL: return TEMPORAL[titre]
    m = re.match(r"^(.+?) (dimanche|mercredi|vendredi) (de l'Avent|de Carême|de Pâques|du temps ordinaire)$", titre)
    if not m: return None
    n = N[m.group(1).lower()]
    js = {"dimanche": 0, "mercredi": 3, "vendredi": 5}[m.group(2)]
    t = {"de l'Avent": "avent", "de Carême": "careme", "de Pâques": "paques", "du temps ordinaire": "ordinaire"}[m.group(3)]
    return f"{t}-{n}-{js}"


def lignes_source():
    txt = subprocess.run(["textutil", "-convert", "txt", "-stdout", str(SRC)], capture_output=True, text=True, check=True).stdout
    L = txt.split("\n")
    fin = next(i for i, l in enumerate(L) if l.strip() == "Sommaire")
    sommaire = [re.sub(r"\t\d+$", "", l).strip() for l in L[fin + 1:] if l.strip()]
    return L[:fin], sommaire


def construire():
    L, sommaire = lignes_source()
    titres = set(sommaire) | {"Quatrième mercredi de Carême"}           # absent du sommaire
    debut = next(i for i, l in enumerate(L) if l.strip() == "TEMPS DE L'AVENT")
    entrees, cles = {}, []
    cour = None; lec = None; marque = None; date = None; sanctoral = False; en_tete = []

    def nouvelle_lecture(auteur):
        nonlocal lec
        lec = {"auteur": auteur, "texte": []}
        if marque: lec["lecon"] = marque
        cit = " ".join(x for x in en_tete if not x.startswith("(")).strip()
        if cit:
            m = REF.search(cit)
            if m: lec["ref"] = m.group(1).strip(); cit = cit[:m.start()].strip()
            if cit: lec["citation"] = re.sub(r"\bII(?= [a-zàâéèêîôû])", "Il", cit)
        en_tete.clear()
        cour["lectures"].append(lec)

    for l in L[debut:]:
        s = l.strip().replace(" ", " ").strip()
        if not s: continue
        retrait = l[:1] in ("\t", " ", "\u00a0") and not l.startswith(" (")
        if s in TEMPS:
            sanctoral = s == "SANCTORAL"; continue
        md = re.match(r"^(\d+)(?:er)? ([A-ZÉÛ ]+)$", s)
        if sanctoral and md and md.group(2).replace(" ", "") in MOIS:
            date = f"{MOIS[md.group(2).replace(' ', '')]:02d}-{int(md.group(1)):02d}"; continue
        if not retrait and s in titres:
            cle = TEMPORAL.get(s) if s in TEMPORAL else (date if sanctoral else cle_temporal(s))
            if cle is None: raise SystemExit(f"Pas de clé pour « {s} »")
            cour = {"titre": s, "lectures": []}; lec = None; marque = None; en_tete.clear()
            cles.append((cle, cour)); continue
        if cour is None: continue
        if re.match(r"^\((.+)\)$", s) and not cour["lectures"]:
            cour["note"] = s[1:-1]; continue
        if LECONS.match(s):
            marque = s.capitalize(); lec = None; continue
        if not retrait and (AUTEUR.match(s) and AUTEUR_MOT.search(s) and len(s) < 140 and not s.endswith((",", ";", ":")) or (marque or "").endswith("nocturne") and REF_BIBLE.match(s)):
            nouvelle_lecture(s); continue
        if lec is None:
            en_tete.append(s); continue
        s = re.sub(r"\bII(?= [a-zàâéèêîôû])", "Il", s)          # « II » pour « Il » (reconnaissance de caractères)
        lec["texte"].append([s, 0 if len(s) >= 110 else 2 if retrait else 1])   # prose | vers | vers en retrait

    # même clé deux fois (3e dimanche de Pâques, année C ; S. Vincent Ferrier en Carême / au temps pascal)
    for cle, e in cles:
        if cle in entrees:
            entrees[cle].setdefault("variantes", []).append(e)
        else:
            entrees[cle] = e
    return entrees


def main():
    e = construire()
    # S. Vincent Ferrier : le 5 avril dans le lectionnaire, le 5 mai au propre de l'Ordre (temps pascal)
    vf = e.get("04-05")
    if vf and vf.get("variantes"):
        pascal = vf["variantes"][0]
        e["05-05"] = {**pascal, "note": "au temps pascal ; le lectionnaire le place au 5 avril"}
    for k, v in e.items():
        for x in [v] + v.get("variantes", []):
            for l in x["lectures"]:
                if not l["texte"]: print(f"!! {k} {x['titre']} : lecture sans texte ({l['auteur']})")
    out = {"source": "Jean-René Bouchet o.p., Lectionnaire pour les dimanches et pour les fêtes (lectionnaire patristique dominicain), présenté par É. T. de Clermont-Tonnerre o.p. et M.-A. Vannier",
           "entrees": e}
    SORTIE.write_text(json.dumps(out, ensure_ascii=False, separators=(",", ":")))
    n = sum(len(x["lectures"]) for v in e.values() for x in [v] + v.get("variantes", []))
    print(f"{len(e)} entrées, {n} lectures → {SORTIE.relative_to(R)} ({SORTIE.stat().st_size // 1024} Ko)")


if __name__ == "__main__":
    main()
