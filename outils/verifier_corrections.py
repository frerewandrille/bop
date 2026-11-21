"""Vérifie partitions/corrections.json : le fichier se lit-il, les images citées existent-elles ?
    python3 outils/verifier_corrections.py
"""
import json, sys
from pathlib import Path
P = Path(__file__).resolve().parent.parent / "partitions"
try:
    c = json.loads((P / "corrections.json").read_text(encoding="utf-8"))
except Exception as e:
    sys.exit(f"corrections.json ne se lit pas : {e}\n→ vérifier les virgules, les guillemets droits \" et les crochets.")
pb = []
ROLES = {"invitatoire", "lucernaire", "hymne", "antiennes", "cantique", "repons", "benedictus", "magnificat", "priere", "choral", "tedeum"}
def existe(f, ou):
    if not (P / f).exists(): pb.append(f"{ou} : l'image « {f} » n'existe pas dans le dossier partitions")
for a, b in c.get("remplacer", {}).items():
    existe(a, "remplacer"); [existe(x, "remplacer") for x in ([b] if isinstance(b, str) else b)]
for cle, o in c.get("offices", {}).items():
    if "|" not in cle or cle.split("|")[1] not in ("laudes", "vepres", "lectures"): pb.append(f"clé « {cle} » : attendu « jour|laudes », « jour|vepres » ou « jour|lectures »")
    for role, v in o.items():
        if role not in ROLES: pb.append(f"{cle} : rôle inconnu « {role} » (possibles : {', '.join(sorted(ROLES))})")
        for gr in (v if v and isinstance(v[0], list) else [v]):
            for f in gr: existe(f, cle)
print("\n".join(pb) if pb else f"corrections.json est correct : {len(c.get('remplacer', {}))} remplacement(s), {len(c.get('retirer', []))} retrait(s), {len(c.get('offices', {}))} office(s) corrigé(s).")
sys.exit(1 if pb else 0)
