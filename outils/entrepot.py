"""Entrepôt Azure (compte de stockage « breviairefichiers », conteneur $web, PRIVÉ : lu avec une clé) :
les gros fichiers du site y sont rangés — images des partitions, données de la Bible — pour ne pas
dépasser les 500 Mo de la Static Web App. Appelé par outils/publier_azure.sh ; ne pas lancer seul sans raison.
(La fonction « site web statique » du compte est désactivée exprès : ne pas la réactiver, elle rendrait tout public.)

    python3 outils/entrepot.py DOSSIER [--essai]

DOSSIER contient les fichiers à leur place définitive (partitions/…, bible/data/…).
N'envoie que les fichiers nouveaux ou modifiés (empreinte MD5 comparée à celle de l'entrepôt) et retire
de l'entrepôt, sous partitions/ et bible/data/ seulement, ceux qui n'existent plus ici.
Le droit d'écrire vient de la connexion Azure de ce Mac (az login)."""
import base64, hashlib, json, os, shutil, subprocess, sys, tempfile

COMPTE = os.environ.get("AZURE_FICHIERS", "breviairefichiers")
GROUPE = os.environ.get("AZURE_SWA_GROUPE", "breviaire")
GERES = ("partitions/", "bible/data/")
CACHE = {"partitions/": "public, max-age=604800", "bible/data/": "public, max-age=86400"}


def az(*args):
    r = subprocess.run(["az", *args], capture_output=True, text=True)
    if r.returncode:
        sys.exit("Azure a refusé : " + (r.stderr.strip().splitlines() or ["?"])[-1])
    return r.stdout


def main():
    dossier, essai = sys.argv[1], "--essai" in sys.argv
    cle = az("storage", "account", "keys", "list", "-n", COMPTE, "-g", GROUPE, "--query", "[0].value", "-o", "tsv").strip()
    acces = ["--account-name", COMPTE, "--account-key", cle]
    en_ligne = {b["name"]: (b["properties"]["contentSettings"] or {}).get("contentMd5")
                for b in json.loads(az("storage", "blob", "list", "-c", "$web", *acces, "--num-results", "*", "-o", "json"))}
    locaux = {}
    for racine, _, fichiers in os.walk(dossier):
        for f in fichiers:
            p = os.path.join(racine, f)
            locaux[os.path.relpath(p, dossier).replace(os.sep, "/")] = p
    a_envoyer = [n for n, p in locaux.items()
                 if en_ligne.get(n) != base64.b64encode(hashlib.md5(open(p, "rb").read()).digest()).decode()]
    # on ne retire que sous les dossiers présents dans cet envoi (--sans-partitions ou --sans-bible ne vident rien)
    geres = tuple(g for g in GERES if any(n.startswith(g) for n in locaux))
    a_retirer = [n for n in en_ligne if geres and n.startswith(geres) and n not in locaux]
    taille = sum(os.path.getsize(locaux[n]) for n in a_envoyer) // 1048576
    print(f"Entrepôt : {len(locaux)} fichiers ; {len(a_envoyer)} à envoyer ({taille} Mo), {len(a_retirer)} à retirer.")
    if essai:
        return
    # envoi groupé par type de fichier (durée de garde différente), depuis un dossier ne contenant que les fichiers changés
    for prefixe, garde in CACHE.items():
        lot = [n for n in a_envoyer if n.startswith(prefixe)]
        if not lot:
            continue
        tmp = tempfile.mkdtemp()
        for n in lot:
            os.makedirs(os.path.dirname(os.path.join(tmp, n)), exist_ok=True)
            shutil.copy(locaux[n], os.path.join(tmp, n))
        az("storage", "blob", "upload-batch", "-d", "$web", "-s", tmp, *acces, "--overwrite", "true",
           "--content-cache-control", garde, "--max-connections", "8", "-o", "none")
        shutil.rmtree(tmp)
        print(f"  {len(lot)} fichiers envoyés sous {prefixe}")
    autres = [n for n in a_envoyer if not n.startswith(tuple(CACHE))]
    for n in autres:
        az("storage", "blob", "upload", "-c", "$web", "-n", n, "-f", locaux[n], *acces, "--overwrite", "true", "-o", "none")
    for i in range(0, len(a_retirer), 250):
        lot = a_retirer[i:i + 250]
        for n in lot:
            az("storage", "blob", "delete", "-c", "$web", "-n", n, *acces, "-o", "none")
    if a_retirer:
        print(f"  {len(a_retirer)} fichiers retirés")


if __name__ == "__main__":
    main()
