---
created: 2026-11-17T20:20
updated: 2026-11-20T20:30
---
# Le bréviaire en ligne (Azure)

Le site est un ensemble de fichiers (dossier `site` + partitions découpées) : ni serveur ni base de
données. Il est hébergé par **Azure Static Web Apps**, offre **Standard** (environ 9 € par mois,
prélevés sur les crédits Azure), **fermé par une connexion personnelle** : identifiant et mot de passe de
chaque frère (depuis le 19/11/2026, voir `docs/CONNEXION.md`). Vue d'ensemble : `FONCTIONNEMENT.md` § 5.

## Ce qui est en place (16/11/2026)

| | |
|---|---|
| Abonnement | « Azure subscription 1 » |
| Groupe de ressources | `breviaire` |
| Site | `breviaire-dominicain` (offre Standard) |
| Adresse | <https://calm-flower-052e85c10.4.azurestaticapps.net> |
| Protection | connexion par compte (service `breviaire-connexion`, <https://mango-bay-05d40a610.4.azurestaticapps.net>) |

La région affichée est « Central US » : West Europe refusait les nouveaux sites ce jour-là. Cela
ne ralentit rien : les pages sont servies par le réseau mondial de Microsoft, depuis l'Europe pour
les frères.

Publié le 16/11/2026. Ce qui est publié : le site, les partitions découpées des carnets (Perdrix, Sainte-Baume,
Marseille, Bordeaux) et celles des Heures grégoriennes (autorisation de la Communauté Saint-Martin
et de Solesmes à obtenir ou obtenue, selon ce que vous m'avez dit). La connexion protège le tout.

## L'entrepôt de fichiers (18/11/2026)

Les gros fichiers — **images des partitions** et **données de la Bible** (environ 450 Mo) — ne sont plus dans le
site mais dans un **entrepôt Azure** (compte de stockage `breviairefichiers`, France Central, groupe `breviaire`),
à l'adresse `https://breviairefichiers.blob.core.windows.net/$web/` (privée, voir ci-dessous). Le site lui-même ne pèse plus qu'une vingtaine de Mo :
la limite de 500 Mo ne gêne plus.

- `publier_azure.sh` envoie d'abord à l'entrepôt **les seuls fichiers nouveaux ou modifiés** (`outils/entrepot.py`),
  puis le site. Les publications sont donc bien plus rapides.
- Coût : stockage environ 1 centime par mois ; trafic : les 100 premiers Go par mois sont gratuits chez Azure.
- **L'entrepôt est privé (18/11/2026).** Un fichier n'est servi que si l'adresse porte la **clé d'accès** en lecture.
  Depuis la connexion par compte (19/11/2026), chaque appareil connecté reçoit une **clé courte** (valable 30 à
  45 jours, renouvelée seule) de la fonction `api/fichiers` ; aucune clé n'est plus écrite dans les pages.
  Les anciennes clés longues ont été révoquées (`python3 outils/cle_entrepot.py --revoquer`). Aucun entretien à prévoir.
- L'ancienne adresse publique (`breviairefichiers.z28.web.core.windows.net`, « site web statique » du compte de
  stockage) est désactivée. Ne pas la réactiver : elle ouvrirait de nouveau l'entrepôt à tous.
- Les fichiers ne sont lus que par le site du bréviaire (règle « CORS » de l'entrepôt, qui nomme l'adresse du site).
  **Si le site change d'adresse** (domaine personnalisé), ajouter la nouvelle adresse :
  `az storage cors add --account-name breviairefichiers --services b --methods GET HEAD OPTIONS --origins https://NOUVELLE-ADRESSE --allowed-headers "*" --max-age 86400`
- Options : `--entrepot-seul` (met seulement l'entrepôt à jour), `--garder-images` (laisse aussi les images dans le site).

## La Bible, sous /bible/ (18/11/2026)

Le même site publie aussi la Bible (dossier `bible/`, projet distinct) à l'adresse
<https://calm-flower-052e85c10.4.azurestaticapps.net/bible/>. `publier_azure.sh` l'ajoute à chaque publication
(`--sans-bible` pour s'en passer). Ensemble : environ 475 Mo, sous la limite de 500 Mo — si les partitions grossissent,
la publication s'arrête et le dit ; on pourra alors alléger la Bible (par exemple retirer un ou deux dictionnaires).
Le second site créé le même jour pour la Bible (`bible-dominicaine`) a été supprimé : plus rien n'est facturé pour lui.

## Donner accès aux frères

L'ancien mot de passe commun d'Azure (« Protection par mot de passe » du portail) est **désactivé** et doit le
rester : l'accès se fait par compte personnel. Créer, modifier, désactiver les comptes, donner les rôles
« signalements » et « comptes », régler les inscriptions : page **Comptes** du service de connexion. Tout est
expliqué dans `docs/CONNEXION.md`.

## Publier une mise à jour

Dans le Terminal du Mac :

```bash
cd ~/Downloads/psautier
```

**Si le programme, les données ou les partitions ont changé depuis la dernière publication**, relever
d'abord les partitions que le site affiche réellement (20 à 40 minutes, internet nécessaire ; seules
celles-là seront publiées) :

```bash
node outils/releve_images.mjs
```

Puis publier :

```bash
bash outils/publier_azure.sh
```

Si le relevé est plus ancien que le programme ou les données, la publication s'arrête et le dit. Pour
voir ce qui serait envoyé sans rien envoyer : `bash outils/publier_azure.sh --essai`.

La commande retrouve seule le droit de publier grâce à la connexion Azure de ce Mac (`az login`,
déjà faite ; à refaire si elle a expiré :

```bash
az login
```

). Elle copie le site et les partitions, recompresse les images pour le web, vérifie que le tout
reste sous la limite d'Azure (500 Mo), puis envoie. Compter quelques minutes. Le site en ligne est
remplacé ; recharger la page en forçant (⌘ + Maj + R) pour voir la nouvelle version.

Pour publier sans les partitions :

```bash
bash outils/publier_azure.sh --sans-partitions
```

## Une adresse à vous (facultatif)

Portail → breviaire-dominicain → **Domaines personnalisés** → **Ajouter** : par exemple
`breviaire.votre-site.fr`. Azure indique un enregistrement à créer chez le gestionnaire du nom de
domaine ; le certificat (https) est fourni gratuitement.

## Coût et arrêt

- Environ 9 € par mois, quel que soit le nombre de frères qui consultent (100 Go de trafic inclus).
- Pour tout arrêter : portail → groupe de ressources **breviaire** → **Supprimer le groupe de
  ressources**. Le site disparaît, plus rien n'est facturé.

## En cas de difficulté

- « jeton invalide » ou « not logged in » : refaire `az login`, puis relancer la publication.
- « Trop gros pour Azure » : prévenir ; il faudra alléger les images.
- Les textes propres (oraisons, antiennes de l'AELF) viennent d'api.aelf.org : sans connexion
  Internet, seuls les psaumes et la Bible s'affichent.
