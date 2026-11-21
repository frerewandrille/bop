"""Contrôle des antiennes posées sous les psaumes : le psaume du texte figure-t-il sur l'étiquette de la partition ?
    python3 outils/controle_antiennes.py releve.json [...]
(relevés produits par : node outils/releve_antiennes.mjs "<url d'impression avec &apercu>" releve.json)
"""
import json, re, sys
from pathlib import Path
R = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(Path(__file__).parent))
from decouper_partitions import ids_etiquette
ETIQ = {}
for f in (R / "partitions").glob("*/pieces.json"):
    for x in json.loads(f.read_text()):
        if isinstance(x, dict) and "fichier" in x: ETIQ[f"{f.parent.name}/{x["fichier"]}"] = x
ORD = {}
o = json.loads((R / "partitions/ordo.json").read_text())
for k, e in o.items():
    if k.startswith("_"): continue
    for off in e["offices"].values():
        for p in off["pieces"]:
            if p["role"] == "antiennes":
                for f in p["f"]: ORD[f] = p.get("ids") or []
base = lambda i: re.sub(r"[AB]$", "", str(i).split("-")[0]).upper()
n = pb = sans = 0
for fichier in sys.argv[1:]:
    for a in json.loads(Path(fichier).read_text()):
        off = re.search(r"office-(\w+)", a["office"]); off = off.group(1) if off else "?"
        if off in ("complies", "milieu"): continue
        couverts = set()
        for k, e in enumerate(a["elts"], 1):
            n += 1
            ps = [base(i) for i in e["ids"]]
            if not e["imgs"] and (set(ps) & couverts or "*" in couverts):
                continue          # même antienne que le psaume précédent (« Psaume 5 & AT 4 »)
            if not e["imgs"]:
                sans += 1; print(f"  sans partition : {a['date']} {off} n°{k} ({','.join(e['ids'])}) — {a['nom'][:40]}"); continue
            for im in e["imgs"]:
                if im.startswith(("sb/", "hg")): continue
                x = ETIQ.get(im, {})
                ids = ORD.get(im) or ids_etiquette(x.get("dessous", "")) or [m for m in re.findall(r"Psaumes? (\d+)", x.get("dessous", ""))]
                couverts |= set(map(base, ids))
                d = x.get("dessous", "")
                suiv = ETIQ.get(re.sub(r"-(\d+)\.jpg$", lambda m: f"-{int(m.group(1)) + 1}.jpg", im), {})
                if re.search(r"dimanche|Jour de Pâques|Lundi,|Mardi &|Ascension", d) or (d and suiv.get("dessous") == d) or (len(e["imgs"]) == 1 and not ORD.get(im) and not x.get("ids")):
                    couverts |= set(ps) | {"*"}; continue      # antienne commune à plusieurs jours, ou étiquette de la pièce suivante
                if ids and not (set(map(base, ids)) & set(ps)):
                    pb += 1; print(f"  ERREUR : {a['date']} {off} n°{k} : texte = psaume {','.join(e['ids'])} ; partition {im} étiquetée « {x.get('dessous', '')[:50]} » {ids} — {a['nom'][:40]}")
        if a["autres"]:
            ants = [im for im in a["autres"] if ORD.get(im) is not None or ids_etiquette(ETIQ.get(im, {}).get("dessous", ""))]
            if ants: print(f"  antienne non placée (fin d'office) : {a['date']} {off} : {', '.join(ants[:4])} — {a['nom'][:40]}")
print(f"{n} psaumes contrôlés : {pb} erreur(s), {sans} sans partition.")
