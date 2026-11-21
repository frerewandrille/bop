"""Liste des signalements d'erreurs reçus : python3 outils/signalements.py [--tout]

Lit signalements/*.jsonl (écrits par outils/serveur.py, une ligne par signalement) et écrit
signalements/a-traiter.md, rangé par provenance du texte (psautier BJ, Bible BJ, AELF, partition…).
Un signalement traité : ajouter son identifiant (une ligne) à signalements/traites.txt.
--tout : inclut les signalements déjà traités.
--azure : récupère d'abord les signalements du site en ligne (clé dans .cle_signalements.txt)
          → signalements/azure.jsonl (remplacé à chaque fois).
"""
import json, sys
from collections import defaultdict
from pathlib import Path

DOSSIER = Path(__file__).resolve().parent.parent / "signalements"


SITE_EN_LIGNE = "https://calm-flower-052e85c10.4.azurestaticapps.net"


def recuperer_azure():
    import subprocess
    # curl plutôt qu'urllib : le Python de python.org n'a pas toujours les certificats du Mac
    cle = (DOSSIER.parent / ".cle_signalements.txt").read_text("utf-8").strip()
    r = subprocess.run(["curl", "-sf", "--max-time", "30", "-H", f"x-cle: {cle}", f"{SITE_EN_LIGNE}/api/signalements"],
                       capture_output=True, text=True, check=True)
    liste = json.loads(r.stdout)
    DOSSIER.mkdir(exist_ok=True)
    (DOSSIER / "azure.jsonl").write_text("".join(json.dumps(s, ensure_ascii=False) + "\n" for s in liste), "utf-8")
    print(f"{len(liste)} signalement(s) récupéré(s) du site en ligne")


def main():
    tout = "--tout" in sys.argv
    if "--azure" in sys.argv:
        recuperer_azure()
    traites = set()
    f = DOSSIER / "traites.txt"
    if f.exists():
        traites = {l.split()[0] for l in f.read_text("utf-8").splitlines() if l.strip() and not l.startswith("#")}
    vus, groupes = set(), defaultdict(list)
    for fichier in sorted(DOSSIER.glob("*.jsonl")):
        for ligne in fichier.read_text("utf-8").splitlines():
            if not ligne.strip():
                continue
            s = json.loads(ligne)
            if s.get("id") in vus or ((s.get("id") in traites or s.get("traite")) and not tout):
                continue
            vus.add(s.get("id"))
            groupes[s.get("provenance") or "non précisé"].append(s)
    lignes = [f"# Signalements à traiter ({sum(map(len, groupes.values()))})", ""]
    for prov, liste in sorted(groupes.items(), key=lambda x: -len(x[1])):
        lignes += [f"## {prov} ({len(liste)})", ""]
        for s in sorted(liste, key=lambda s: (s.get("date", ""), s.get("office", ""))):
            lieu = " — ".join(x for x in (s.get("section"), s.get("piece")) if x)
            lignes.append(f"- **{s.get('date')} {s.get('office')}** ({s.get('version')}) {lieu}  `{s.get('id')}`")
            if s.get("passage"):
                lignes.append(f"  - passage : « {s['passage'][:300]} »")
            if s.get("commentaire"):
                lignes.append(f"  - remarque : {s['commentaire']}")
            if s.get("partitions"):
                lignes.append(f"  - partitions : {', '.join(s['partitions'])}")
            if s.get("cle"):
                lignes.append(f"  - clé de correction : `{s['cle']}`")
            lignes.append(f"  - ouvrir : http://localhost:8765/{s.get('adresse', '')}")
        lignes.append("")
    DOSSIER.mkdir(exist_ok=True)
    (DOSSIER / "a-traiter.md").write_text("\n".join(lignes), "utf-8")
    print("\n".join(lignes[:1]), "→", DOSSIER / "a-traiter.md")


if __name__ == "__main__":
    main()
