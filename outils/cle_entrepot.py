"""Clés LONGUES de lecture de l'entrepôt Azure (compte « breviairefichiers », conteneur $web, privé depuis le 18/11/2026).

Depuis la connexion par compte (19/11/2026), ces clés longues ne servent PLUS : chaque appareil connecté reçoit une
clé courte de /api/fichiers/cle.js (api/fichiers). Ce programme reste pour couper toute ancienne clé (--revoquer),
ou en secours si l'on publiait un jour sans connexion (publier_azure.sh --sans-connexion pose alors la clé longue
dans les pages, <meta name="fichiers-cle">).

    python3 outils/cle_entrepot.py            → prolonge la règle d’accès (10 ans) et affiche la clé
    python3 outils/cle_entrepot.py --lire     → affiche la clé sans rien changer sur Azure
    python3 outils/cle_entrepot.py --nouvelle → nouvelle clé ; l'ancienne cesse aussitôt de marcher
                                                (à faire si la clé a circulé hors de la communauté)
    python3 outils/cle_entrepot.py --revoquer → supprime toutes les clés longues (connexion par compte : les appareils
                                                reçoivent des clés courtes de /api/fichiers/cle.js, voir docs/CONNEXION.md)

La clé dépend d'une « règle d'accès » nommée lecture-N, rangée sur le conteneur : la date d'expiration est
dans la règle, pas dans la clé. Prolonger la règle garde donc la même clé (les images déjà dans le cache
des navigateurs restent valables) ; supprimer la règle annule la clé.
Le droit de modifier vient de la connexion Azure de ce Mac (az login)."""
import datetime, json, os, re, subprocess, sys

COMPTE = os.environ.get("AZURE_FICHIERS", "breviairefichiers")
GROUPE = os.environ.get("AZURE_SWA_GROUPE", "breviaire")
CONTENEUR = "$web"
DUREE = datetime.timedelta(days=3653)   # 10 ans : la sécurité vient de la révocation (--nouvelle), pas de l’expiration


def az(*args):
    r = subprocess.run(["az", *args], capture_output=True, text=True)
    if r.returncode:
        sys.exit("Azure a refusé : " + (r.stderr.strip().splitlines() or ["?"])[-1])
    return r.stdout


def main():
    lire, nouvelle, revoquer = "--lire" in sys.argv, "--nouvelle" in sys.argv, "--revoquer" in sys.argv
    cle = az("storage", "account", "keys", "list", "-n", COMPTE, "-g", GROUPE, "--query", "[0].value", "-o", "tsv").strip()
    acces = ["--account-name", COMPTE, "--account-key", cle]
    regles = json.loads(az("storage", "container", "policy", "list", "-c", CONTENEUR, *acces, "-o", "json") or "{}")
    noms = sorted((n for n in regles if re.fullmatch(r"lecture-\d+", n)), key=lambda n: int(n.split("-")[1]))
    if revoquer:
        for ancien in noms:
            az("storage", "container", "policy", "delete", "-c", CONTENEUR, "-n", ancien, *acces, "-o", "none")
        print(f"Clés longues supprimées : {', '.join(noms) or 'aucune'}.", file=sys.stderr)
        return
    fin = (datetime.datetime.now(datetime.timezone.utc) + DUREE).strftime("%Y-%m-%dT%H:%MZ")
    if lire:
        if not noms:
            sys.exit("Aucune clé : lancez « python3 outils/cle_entrepot.py » une première fois.")
        nom = noms[-1]
    elif nouvelle or not noms:
        nom = f"lecture-{int(noms[-1].split('-')[1]) + 1 if noms else 1}"
        az("storage", "container", "policy", "create", "-c", CONTENEUR, "-n", nom, "--permissions", "r", "--expiry", fin, *acces, "-o", "none")
        for ancien in noms:
            az("storage", "container", "policy", "delete", "-c", CONTENEUR, "-n", ancien, *acces, "-o", "none")
    else:
        nom = noms[-1]
        az("storage", "container", "policy", "update", "-c", CONTENEUR, "-n", nom, "--permissions", "r", "--expiry", fin, *acces, "-o", "none")
    sas = az("storage", "container", "generate-sas", "-n", CONTENEUR, "--policy-name", nom, "--https-only", *acces, "-o", "tsv").strip()
    if not lire:
        print(f"Règle {nom} valable jusqu'au {fin[:10]}.", file=sys.stderr)
    print(sas)


if __name__ == "__main__":
    main()
