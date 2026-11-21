# `outils/` — l'atelier

Programmes qui tournent **sur le Mac**, jamais en ligne. Ils lisent les documents d'origine (`sources_*/`,
Drive « LITURGIE ») et fabriquent ce que le site lit : `site/donnees/*.json` et `partitions/`. On ne les
relance **que si une source change**. Après chaque relance : `bash tests/tout.sh`.

Chaque programme dit en tête, en français, ce qu'il lit, ce qu'il écrit et comment le lancer.
Besoins : Python 3 (≥ 3.11), Node (≥ 20), et selon les cas `openpyxl` (tableaux Gouzes), poppler
(`pdftotext`, `pdftohtml`, `pdftoppm`), Ghostscript, LilyPond, `pngquant`, Brave ou Chrome, `az` (Azure).
`textutil` et `sips` sont fournis avec macOS.

## 1. Données des textes → `site/donnees/`

| Programme | Lit | Écrit |
|---|---|---|
| `construire_donnees.py` (+ `lire_word.py`) | `sources_bible/*.doc` (Psautier BJ, Bible BJ) | `psautier.json`, `bible/` |
| `construire_calendrier.py` (+ `recolter_aelf.py`) | `aelf_informations.json` (relevé AELF 2018-2027), `corrections_sanctoral.json` | `sanctoral.json` |
| `construire_gouzes.py` (+ `construire_gouzes_docs.py`, `lire_docx.py`, `repons_to_lignes.py`) | tableau et documents de `sources_gouzes/` | `gouzes.json` |
| `construire_sainte_baume.py` | `sources_gouzes/sainte-baume/` | `sainte_baume.json` |
| `construire_milieu.py` | carnet du milieu du jour (.docx + .pdf), livret de Marseille | `milieu.json` (+ images `partitions/milieu`, `marseille`) |
| `construire_complies.py` | livret des complies de Bordeaux | `complies.json` |
| `capitules_province.py` | (textes saisis dans le programme) | `capitules.json` |
| `construire_bouchet.py` | lectionnaire Bouchet (.docx) | `bouchet.json` |
| `construire_president.py` | documents des intercessions et oraisons | `president.json` |
| `construire_psautier_aelf.py` | `sources_aelf/Psautier-AELF.doc` | `psautier_aelf.json` |
| `construire_psautier_latin.py` | `bible/data/PSA/` (Nova Vulgata) | `psautier_latin.json` |
| `construire_missel.py` (+ `missel_liturgie.py`) | `sources_missel/` (Missel romain, Triduum, communs, ordinaire) | `missel.json` |
| `construire_missel_op.py` | `sources_missel/op/` (Missel et Lectionnaire de l'Ordre) | `missel_op.json` **et `propre_op.json`** (calendrier de l'Ordre) |
| `offices_op.py` | carnets du sanctoral (.docx) | `offices_op.json` |
| `construire_martyrologe.py` | `sources_martyrologe/` | `martyrologe.json`, `necrologe.json` |
| `construire_table.py` | `sources_table/` | `table.json` |
| `construire_prieres.py` | `sources_compendium/` | `prieres.json` |

`jours_saints.json` est saisi à la main (pas de programme). Le double-clic « Mettre à jour les textes.command »
(à la racine) relance les trois premiers.

## 2. Partitions → `partitions/`

Chaîne des carnets « Perdrix » de la Province, **dans cet ordre** :

1. `rendre_partitions.sh` — PDF des carnets → images de pages `partitions/<carnet>/p-NNN.jpg`
2. `decouper_partitions.py` — pages → une image par pièce (`s-NNN-K.jpg`) + `pieces.json`
3. `marquer_musique.py` — distingue musique, texte, gravures dans `pieces.json`
4. `indexer_partitions.py` — `partitions/index.json` (office, rôle, jours de chaque pièce) + `site/donnees/province.json`
5. `hymnes_pages.py`, `antiennes_pages.py` — images d'un seul tenant (`h-…`, `a-…`) + `decoupes.json`
6. `construire_ordo.py` (+ `ordo_noel.py`, `ordo_sept_jan.py`, `extraire_docx_sanctoral.py`) — fêtes des carnets → `ordo.json`

**Attention** : ne jamais relancer le découpage du livret des complies (les numéros des pièces changeraient,
`construire_complies.py` les cite à la main) ; relancer 5 et 6 après tout nouveau découpage d'un carnet.

Autres sources de partitions :

| Programme | Écrit |
|---|---|
| `indexer_sainte_baume.py` | `partitions/sb/` (antiennes des livrets de Sainte-Baume) |
| `indexer_heures_gregoriennes.py`, `construire_offices_latins.py`, `construire_communs.py` | `partitions/hg/` (version latin-français, communs) |
| `graver_lilypond.py` | `partitions/ly/` (pièces gravées depuis les sources LilyPond de Gouzes) |
| `retirer_gravures.py` | images sans gravure dans `partitions/corrections/` |

Corrections à la main : `partitions/corrections.json` (notice : `docs/CORRIGER-UNE-PARTITION.md`), contrôle
par `verifier_corrections.py`. Elles ne sont jamais écrasées par les programmes ci-dessus.

## 3. Publication et Azure

| Programme | Rôle |
|---|---|
| `releve_images.mjs` | Liste des images vraiment affichées (`partitions/images-utilisees.json`), à refaire avant publication (≈ 15 min) |
| `publier_azure.sh` | **Publie le site** (Static Web App + entrepôt). `--essai` pour voir sans envoyer |
| `entrepot.py` | Envoi différentiel des images et des données de la Bible dans l'entrepôt (appelé par le précédent) |
| `publier_connexion.sh` | Publie le service de connexion (site à part « breviaire-connexion ») |
| `preparer_connexion.sh` | Pose une fois les secrets de la connexion (dans `.secrets_connexion/` et sur Azure) |
| `connexion_azure.json` | Règles d'accès ajoutées à la configuration du site à chaque publication |
| `cle_entrepot.py` | Révoque les anciennes clés longues de l'entrepôt (secours) |
| `polices_kepler.sh` | Refait les polices `site/polices/*.woff2` depuis les Kepler installées |

## 4. Sur le Mac, au quotidien

| Programme | Rôle |
|---|---|
| `serveur.py` | Serveur local (double-clic « Lancer le bréviaire.command ») : sert `site/`, `partitions/`, `bible/`, reçoit les signalements |
| `signalements.py` | Liste des signalements reçus (`--azure` : ceux du site en ligne) |
| `essai_connexion.js` | Essai local de la page de connexion (port 8791) |

## 5. Contrôles ponctuels (les contrôles réguliers sont dans `tests/`)

| Programme | Rôle |
|---|---|
| `pdf_controle.mjs` | Fabrique un PDF ou un Word d'une adresse du site, pour regarder le rendu |
| `controle_horsligne.mjs` | Vérifie la lecture sans réseau dans un vrai navigateur |
| `releve_antiennes.mjs` puis `controle_antiennes.py` | Vérifie que chaque antienne est posée sous le bon psaume |
| `audit_partitions.js` | Ce que le site retient comme partitions, jour par jour, et les manques |
| `recolter_references.py` | Relève les références AELF (`aelf_references.json`) utilisées par deux tests |
