# Bréviaire dominicain — psautier et Bible de Jérusalem

Un site de Liturgie des Heures et de prière pour les frères (Province dominicaine de Toulouse) :

- **Office** — Lectures, Laudes, Milieu du jour, Vêpres, Complies, pour n'importe quelle date (calendrier
  perpétuel romain de France, avec le propre de l'Ordre). Les psaumes et cantiques viennent du **psautier de
  la Bible de Jérusalem** (gras des inflexions, stiques, strophes), les lectures de la **Bible de Jérusalem**,
  les textes propres du jour de l'**AELF**. Six versions : 100 % AELF, romaine, romain gouzantin (carnets de
  la Province, partitions repliées), Sainte-Baume, gouzantine (Liturgie chorale du peuple de Dieu),
  latin-français (Les Heures grégoriennes).
- **Messe** — messe du jour (Missel romain, Missel et Lectionnaire de l'Ordre, lectures AELF), Missel à consulter.
- **Bible** — BJ avec l'original, le latin, les Pères, les dictionnaires, une recherche, une vue interlinéaire.
- **Bibliothèque** — Bénédicité, Prières (Compendium), Martyrologe, Frères défunts.
- **Export** des offices ou des messes d'une période en **PDF** (livret A5 ou A4) ou en **Word** ;
  **lecture sans réseau** d'une période enregistrée ; bouton **« Signaler »** une erreur.

## Où le trouver

- En ligne : <https://calm-flower-052e85c10.4.azurestaticapps.net> — on y entre avec un **identifiant et un mot
  de passe personnels**, une fois par appareil. Les comptes se gèrent dans la page « Comptes » (réservée au rôle
  « comptes ») ; voir `docs/CONNEXION.md`. Sur téléphone : « Ajouter à l'écran d'accueil ».
- Sur ce Mac, sans connexion : double-clic sur **« Lancer le bréviaire.command »** (le navigateur s'ouvre sur
  l'office du moment ; fermer la fenêtre du Terminal pour arrêter). La première fois, macOS peut refuser :
  clic droit → Ouvrir → Ouvrir.

Chaque réglage (versions, partitions, export, hors connexion…) est expliqué dans
**`docs/MODE-D-EMPLOI-REGLAGES.md`** ; d'où vient chaque texte et quels choix ont été faits, dans
**`docs/SOURCES-ET-CHOIX.md`**.

## Organisation du dossier

```
README.md                    cette notice
FONCTIONNEMENT.md            comment le site est construit (pour qui le reprend) — À LIRE EN PREMIER
Lancer le bréviaire.command  ouvre le site sur ce Mac
Mettre à jour les textes.command   refait psautier, Bible, calendrier, Gouzes après une correction des sources

site/          LE SITE publié : pages (.html), css/, js/ (programmes du navigateur), donnees/ (textes en .json),
               polices/, sw.js (lecture sans réseau), staticwebapp.config.json (réglages Azure)
bible/         la Bible, servie sous /bible/ ; ses propres programmes de fabrication (voir bible/LISEZMOI.md)
partitions/    images des partitions et leurs index (en ligne : dans l'entrepôt Azure privé)
api/           les petites fonctions en ligne : connexion, rôles, clé de l'entrepôt, signalements
outils/        l'atelier : programmes qui fabriquent données et partitions, et publient (voir outils/LISEZMOI.md)
tests/         contrôles automatiques : bash tests/tout.sh
sources_*/     vos documents d'origine (Word, PDF, tableaux), jamais modifiés par les programmes
docs/          notices : réglages, sources et choix, corriger une partition, mise en ligne, connexion,
               GitHub, audit de sécurité
archives/      ce qui ne sert plus (anciens plans, exemples, ancien journal) — voir archives/LISEZMOI.md
```

Fichiers cachés à la racine, jamais dans git : `.cle_signalements.txt`, `.cle_comptes.txt` (clés de secours),
`.secrets_connexion/` (secrets de la connexion). Les perdre n'efface rien en ligne, mais il faudrait les refaire
(`outils/preparer_connexion.sh`).

## Corriger quelque chose

| Pour corriger… | Où | Ensuite |
|---|---|---|
| un psaume, un verset de la Bible | les `.doc` de `sources_bible/` | « Mettre à jour les textes.command » |
| une partition (image, hymne, antienne d'un office) | `partitions/corrections.json` | voir `docs/CORRIGER-UNE-PARTITION.md` |
| le calendrier de l'Ordre | `site/donnees/propre_op.json` | voir `docs/MODE-D-EMPLOI-REGLAGES.md` § 3.2 |
| une date du calendrier romain | `outils/corrections_sanctoral.json` | `python3 outils/construire_calendrier.py` |
| une autre source (Gouzes, carnets, Missel, martyrologe…) | le fichier dans `sources_*/` | le programme indiqué dans `outils/LISEZMOI.md` |

Après toute correction : `bash tests/tout.sh` (tous les contrôles, quelques secondes), regarder le résultat
sur ce Mac, puis publier (`docs/MISE-EN-LIGNE-AZURE.md`).

## Ce qui est vérifié, ce qui ne l'est pas

Vérifié automatiquement par `bash tests/tout.sh` (20 contrôles) : le calendrier concorde avec l'AELF sur
2018-2027 ; les 779 références employées par l'AELF trouvent leur texte dans le psautier et la Bible ; chaque
jour de plusieurs années a son milieu du jour, ses complies, ses capitules, ses bénédictions de table, son
martyrologe ; chaque partition citée existe ; la répartition gouzantine, Sainte-Baume, les communs, le propre de
l'Ordre, la version latin-français se construisent sans manque ; la connexion fonctionne (essai sans Azure).

Vérifié à l'œil, par échantillons : le rendu à l'écran (ordinateur, téléphone) et en PDF A5.

Non vérifié : les fichiers Word n'ont jamais été ouverts dans Microsoft Word ; la lecture sans réseau et la
bulle « Signaler » sur un vrai iPhone ; chaque jour de l'année regardé à l'œil.

Limites connues :
- **Dates non publiées par l'AELF** (environ neuf mois à l'avance, et avant 2018) : le site reprend les textes
  propres du même jour liturgique d'une année publiée (mention en bas de l'office).
- Daniel 13 et 14 sont absents du fichier de la Bible : le texte de l'AELF est affiché à leur place.
- Les versets transposés par la Bible de Jérusalem (Ps 101, 29…) restent à leur place BJ.

## Droits

Le site est fermé par la connexion : il n'est ouvert qu'aux personnes qui ont un compte. Il contient des textes
dont l'utilisateur dit détenir les droits ou avoir l'accord (psautier et Bible de Jérusalem — « © Cerf, hors
commerce » —, carnets de la Province, polices Kepler d'Adobe, lectionnaire Bouchet) ; la liste des sources est
dans le pied de chaque page (« Sources et droits »). Le dépôt GitHub doit rester **privé**.
