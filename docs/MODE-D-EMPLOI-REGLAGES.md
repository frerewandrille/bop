# Mode d'emploi des réglages du bréviaire

Ce document dit, pour **chaque réglage**, où il se trouve, ce qu'il change et comment le modifier.
Il y a trois sortes de réglages :

1. **les réglages à l'écran** (⚙, fenêtre « PDF / Word », menus de l'office) : chacun peut les changer, ils
   sont retenus par le navigateur de l'appareil, rien n'est à republier ;
2. **les liens directs** (adresse de la page) : pour ouvrir un office précis ou produire un PDF d'un clic ;
3. **les réglages de fond** (fichiers du dossier) : ils changent le bréviaire pour tout le monde ; après
   modification, il faut relancer une commande, puis republier le site s'il est en ligne.

> Les commandes indiquées se tapent dans le **Terminal**, après s'être placé dans le dossier du bréviaire :
> `cd ~/Downloads/psautier`. Une commande qui échoue ne casse rien : l'ancien fichier reste en place.

---

## 1. Les réglages à l'écran

### 1.1 Barre du haut

| Élément | Ce qu'il fait |
|---|---|
| Date, flèches ‹ › | Choisit le jour. « Aujourd'hui » revient au jour même et à l'office de l'heure. |
| Onglets Lectures, Laudes, Milieu, Vêpres, Complies | Choisit l'office. À l'ouverture, l'office est choisi selon l'heure : avant 5 h Lectures, avant 11 h Laudes, avant 15 h Milieu, avant 20 h Vêpres, ensuite Complies (pour changer ces heures, voir 3.9). |
| Communs (bouton à gauche de « PDF / Word ») | Ouvre le recueil des communs des saints, comme le bouton « Missel » de la Messe : une carte par commun, puis la page du commun avec son contenu (hymne, psaumes, antiennes, lecture brève, antiennes évangéliques, oraison, avec les variantes du jour) et le bouton « Prendre ce commun le … » pour le jour de la barre — **même un jour sans mémoire**. « Aucun commun ce jour » le retire. Le bouton se rappuie pour revenir à l'office. |
| (en-tête de l'office) Commun : | Les jours de saint, aux laudes, au milieu du jour et aux vêpres : menu « Commun » sous le menu « Office ». « aucun (textes du jour) » garde les textes de l'AELF ; sinon apôtres, martyrs, pasteurs, docteurs, vierges, saints, saintes, Vierge Marie, dédicace, défunts… (Les Heures grégoriennes, tome III), avec la précision (« pour un évêque »…) et les psaumes (du commun ou de la férie). Le commun suggéré est celui que le Missel indique pour ce saint, sinon d'après son nom. **Fêtes et mémoires de l'Ordre** (S. Dominique, S. Thomas d'Aquin, Ste Rose…) : l'AELF n'en donne pas les textes, le commun suggéré s'applique d'office (« aucun » pour le refuser). La provenance de chaque partie est écrite à droite de son titre (« du commun », « du propre (AELF) »…). Le choix est gardé pour la date et vaut pour l'export. Aux vêpres de la veille d'un dimanche ou d'une solennité, c'est le commun du lendemain qui compte. |
| (en-tête de l'office) Psaumes : | Version « Romain gouzantin » (et Sainte-Baume), laudes et vêpres des **mémoires que le carnet du sanctoral traite comme des fêtes** (Notre-Dame des Douleurs, S. Martin de Tours, Ste Agnès…) : « de la férie (AELF) », comme le veut le rang de mémoire, ou « du carnet de la Province » : les psaumes de l'étiquette du carnet (Ps 62, Dn 3, Ps 149…), chaque antienne du carnet (partition) sous son psaume. Le choix est gardé pour la date et vaut pour l'export. Absent si un commun est choisi à la main. |
| PDF / Word | Ouvre la fenêtre de production (voir 1.3). |
| ⚙ | Ouvre les réglages (voir 1.2). |

### 1.2 Fenêtre ⚙ Réglages

Les réglages sont **propres à chaque appareil et à chaque navigateur** (ordinateur, téléphone…). Ils
s'appliquent dès qu'on clique, sans bouton « Enregistrer ».

| Réglage | Effet | Par défaut |
|---|---|---|
| **Propre de l'Ordre des Prêcheurs** | Ajoute au calendrier romain les fêtes et mémoires de l'Ordre (`site/donnees/propre_op.json`). Décoché : calendrier romain de France seul. | coché |
| **Version de l'office** | La façon de dire l'office (voir le tableau suivant). | Romaine |
| **Invitatoire aux Laudes** | Place l'invitatoire en tête des laudes. Décoché : il est omis (on suppose que l'office des lectures l'a déjà dit). | coché |
| **Capitules de la Province** | Lectures brèves des laudes et vêpres selon le tableau de la Province (texte de la Bible de Jérusalem). Décoché : lecture brève de l'AELF. | coché |
| **Oraison mise en premier** | « liturgique (AELF) » ou « des Heures grégoriennes ». Vaut pour les laudes, le milieu du jour, les vêpres et les complies, tous les jours de l'année : l'oraison est cherchée dans les trois tomes des Heures grégoriennes (temps, fêtes, saints, complies). Si les deux textes sont les mêmes (la conclusion « Par Jésus Christ… » n'est pas comptée), une seule est montrée ; sinon l'autre reste proposée, repliée. Rien n'est proposé pour un saint que le livre ne donne pas (fêtes propres de l'Ordre surtout). Aux complies de la Province, l'oraison du livret reste la première, sauf si « des Heures grégoriennes » est choisi. Sans effet dans les versions « 100 % AELF » et latin-français. | liturgique |
| **Heure du milieu du jour** | Tierce, Sexte ou None : donne l'hymne et le titre de l'office. Les **trois capitules** (lecture brève de tierce, de sexte et de none) sont toujours montrés, chacun sous son titre, à l'écran comme à l'impression, avec leur répons bref quand le livret de la Province ne donne pas de verset. De même pour les **trois oraisons** quand elles diffèrent (féries surtout) ; les jours de fête, où l'oraison est la même, une seule. Version latin-français : les trois capitules et oraisons des Heures grégoriennes quand le livre les donne. | Sexte |
| **Prières psalmiques dépliées** | Les prières « Prions » après les psaumes sont ouvertes d'emblée. Sinon un clic les ouvre. | décoché |
| **Partitions dépliées d'emblée** | (Seulement dans les versions avec partitions.) Ouvre toutes les partitions à l'affichage. Sinon : « ▸ Partition » à déplier. | décoché |
| **Taille du texte** | De 14 à 26 points. | 18 |
| **Thème** | Clair, sombre, ou selon le réglage de l'appareil. En thème sombre, les partitions sont inversées (blanc sur noir). | selon l'appareil |

**Les six versions de l'office**

| Version | Ce qu'on obtient |
|---|---|
| 100 % AELF | Exactement l'AELF : calendrier, psaumes, lectures, invitatoire, oraison. Ni propre OP, ni capitules, ni partitions, ni psautier BJ. Les psaumes (même traduction que l'AELF) sont pris dans le Psautier.doc de la Province, avec ses inflexions en gras et sa disposition des stiques. Les fonctions PDF/Word restent. |
| Romaine | La Liturgie des Heures de l'AELF, avec **vos** psaumes (psautier BJ) et **votre** Bible. |
| Romain gouzantin | Hymne, antiennes de Gouzes et répons écrits des carnets de la Province, chaque texte suivi de sa partition repliée (si les partitions sont présentes ; sinon le texte seul). Une seule version depuis le 20/11/2026 : l'ancienne « avec les partitions » y a été fusionnée. |
| Sainte-Baume | La version Province avec les partitions, plus les livrets de Sainte-Baume (fr. Max) : au Carême, vigiles, laudes et vêpres selon le livret (une antienne par psaume, répons de la semaine avec le couplet du jour, antiennes du Benedictus et du Magnificat, lucernaire et hymnes au choix aux vêpres, preces et Notre Père en ton du Carême) ; toute l'année, le milieu du jour du livret (psaumes, antienne et verset du jour ; antienne et verset du temps en Avent, à Noël, au Carême et au temps pascal) ; au temps ordinaire, la répartition « Antiennes des offices Ste Baume » (antiennes des matines du dimanche, des laudes et des vêpres, psaumes et antiennes du milieu du jour), avec leurs partitions. Aux fêtes, c'est la Province. (Apparaît si les partitions sont présentes.) |
| Gouzantine | La Liturgie chorale du peuple de Dieu (psalmodie, antiennes et tons de Gouzes, litanies, Grand Canon, Ténèbres), avec les partitions connues. Ce qui manque vient de l'AELF, signalé en bas. |
| Latin-français | L'office des *Heures grégoriennes*, latin et français en regard, avec les partitions. Pas d'office des lectures. |

**Hors connexion** (bloc visible quand le navigateur le permet) : « Une semaine », « 30 jours » ou « Une
période choisie » (100 jours au plus), puis **Enregistrer**. Les cinq offices de chaque jour sont gardés sur
l'appareil **dans la version choisie à ce moment-là**. « Effacer » libère la place. Sur iPhone/iPad, ajouter
d'abord le site à l'écran d'accueil (sinon Safari efface au bout de quelques jours).

### 1.3 Fenêtre « PDF / Word »

| Réglage | Effet |
|---|---|
| Du … au … | La période (400 jours au plus par fichier ; quelques secondes par jour). |
| Offices | Cocher ceux à inclure (par défaut Laudes, Vêpres, Complies). |
| Office des lectures : deuxième lecture | Lecture de l'AELF, ou lectionnaire dominicain (J.-R. Bouchet) quand il propose une lecture. Le choix est retenu pour la fois suivante. |
| Livret A5 / A4 | Format de page. A5 : marges de livret 15/13/16 mm ; A4 : 22 mm. |
| Chaque office sur une nouvelle page | Saut de page avant chaque office. |
| Inclure les partitions | Partitions dépliées dans le PDF et insérées comme images dans le Word. |
| PDF / Word | PDF : la fenêtre d'impression s'ouvre, choisir « Enregistrer au format PDF ». Word : un fichier .docx est téléchargé (il faut les polices Kepler installées sur l'ordinateur qui l'ouvre, sinon Word prend une police voisine). |

Les réglages ⚙ en cours (calendrier, version, capitules…) s'appliquent au fichier.

### 1.4 Sur la page de l'office

- **« Office : … »** sous le titre : les jours de fête non solennelle ou de mémoire, choisir l'office du saint
  ou celui de la férie. Le choix est retenu **pour cette date** (aussi dans le PDF et le Word).
- **Sections repliables** (▸) : hymnes au choix, partitions, « Ou bien, en grégorien », lectures du
  lectionnaire Bouchet et de l'AELF, intercessions. Un clic les ouvre.
- **Signaler** : sélectionner un passage → bulle « Signaler » ; ou le lien en bas de l'office, ou sous une
  partition. Le signalement part avec la date, l'office, la version et l'endroit. (En ligne, ils restent pour
  l'instant sur l'appareil : la réception sur Azure n'est pas installée.)

---

## 2. Les liens directs (adresse de la page)

**Ouvrir un office** : ajouter `#AAAA-MM-JJ/office` à l'adresse.
Exemple : `…/#2026-12-25/vepres`. Offices : `lectures`, `laudes`, `milieu`, `vepres`, `complies`.

**Produire un PDF ou un Word d'un clic** : `…/?imprimer=DÉBUT..FIN` puis, au choix, séparés par `&` :

| Paramètre | Valeurs | Par défaut |
|---|---|---|
| `imprimer` | `2026-12-01..2026-12-31` (ou une seule date) | — (obligatoire) |
| `offices` | liste séparée par des virgules : `laudes,vepres` | `laudes,vepres,complies` |
| `commun` | `pasteurs`, `pasteurs:un évêque`, `martyr::ferie` (commun : précision : `ferie` pour les psaumes de la férie) — pour tous les jours de la période | celui choisi sur l'appareil |
| `version` | `aelf`, `romaine`, `province` (PDF sans partitions, sauf si `partitions` est ajouté), `province-partitions` (même version, partitions incluses), `sainte-baume`, `gouzantine`, `latin` (les versions avec partitions les incluent) | celle de l'appareil |
| `op` | `0` pour enlever le propre OP | celui de l'appareil |
| `lecture2` | `bouchet` ou `aelf` | celui de l'appareil |
| `format` | `A5` ou `A4` | `A5` |
| `saut` | `0` pour ne pas changer de page à chaque office | saut de page |
| `sortie` | `docx` pour un fichier Word | PDF |
| `partitions` | (sans valeur) inclure les partitions, si `version` n'est pas donné ou vaut `province` | sans |
| `apercu` | (sans valeur) afficher sans ouvrir la fenêtre d'impression | — |

Exemple : `…/?imprimer=2027-02-17..2027-02-23&offices=laudes,vepres&version=province-partitions&format=A5`

---

## 3. Les réglages de fond (fichiers)

Pour chacun : **le fichier**, **ce qu'on y change**, **ce qu'il faut relancer ensuite**. Quand une
modification touche le site (`site/…`), la republier ensuite (voir 3.12).

### 3.1 Le psautier et la Bible

- **Fichiers** : dans le dossier `sources_bible/` : `Psautier de la Bible de Jérusalem (Provincia Tolosana) 1.93.doc`,
  `Bible de Jérusalem.doc` (garder ces noms).
- **Changer** : corriger le texte dans Word. Le gras (inflexions), l'italique, les sauts de strophe sont repris.
- **Ensuite** : double-clic sur **« Mettre à jour les textes.command »**. Puis
  `bash tests/tout.sh` (chaque référence AELF doit trouver son texte, etc.).

### 3.2 Le calendrier de l'Ordre (propre OP)

- **Fichier** : `site/donnees/propre_op.json`, fabriqué par `python3 outils/construire_missel_op.py` d'après
  le calendrier du Missel de l'Ordre (degrés de la Province de Toulouse). Une célébration :
  ```
  "01-28": { "nom": "S. Thomas d'Aquin, prêtre et docteur de l'Église", "rang": "fête" }
  ```
  Rangs possibles : `solennité`, `fête`, `mémoire`, `mémoire facultative`, `anniversaire`. Ajouter
  `"couleur": "Rouge"` pour un martyr.
- **Changer** : corriger le fichier à la main (avec soin : une virgule oubliée et le site ne s'ouvre plus),
  ou, si le changement vient d'une nouvelle édition du Missel de l'Ordre, relancer `construire_missel_op.py`
  (qui garde les noms déjà en usage, mais **refait les degrés** d'après le Missel).
- **Ensuite** : `bash tests/tout.sh`.
- L'ancien fichier `propre_op.toml` (Calendarium 2019) est rangé dans `archives/` : il ne sert plus.

### 3.3 Corrections du calendrier romain

- **Fichier** : `outils/corrections_sanctoral.json`. On y corrige une date que l'AELF donne mal ou qu'on
  veut autrement : `"MM-JJ": { "nom": "…", "rang": "fête", "niveau": 5 }`, ou `"MM-JJ": null` pour
  supprimer. (Niveaux : 3 solennité, 5 fête, 10-12 mémoire — demander en cas de doute.)
- **Ensuite** : `python3 outils/construire_calendrier.py`, puis `node tests/calendrier.test.js`.

### 3.4 Liturgie chorale (Gouzes)

- **Fichiers** : dans `sources_gouzes/` — le tableau `Offices Gouzes répartition, traduction.xlsx`, les
  documents « Antiennes écrites AVENT (V2) », « Antiennes écrites CAREME », « Répons … », « Preces …
  Litanies … », « Ténèbres Preces ».
- **Changer** : corriger le texte ou une case du tableau, en gardant la présentation.
- **Ensuite** : double-clic sur « Mettre à jour les textes.command » (il relance aussi Gouzes), puis
  `node tests/gouzes.test.js`.
- **Alternances** (semaines I/II du Carême et du temps pascal, cycle de 8 semaines des répons) : elles
  sont écrites dans le programme (`site/js/gouzes.js`). Pour les changer, le demander à Claude.

### 3.5 Capitules de la Province

- **Fichier** : `outils/capitules_province.py` — par temps et par office, une ligne par semaine avec sept
  références (dimanche → samedi), écrites comme dans le tableau imprimé :
  `"1": sem("Gn 1, 1-5", "Sg 1, 1-7", …)`. Les lectures douteuses portent « incertain ».
- **Ensuite** : `python3 outils/capitules_province.py`, puis `node tests/capitules.test.js` (chaque
  référence doit être lisible dans la Bible).

### 3.6 Milieu du jour, complies, prière du président, lectionnaire

| Contenu | Source | Commande à relancer | Contrôle |
|---|---|---|---|
| Milieu du jour | « Office du milieu du jour (carnet Province) » .docx + .pdf | `python3 outils/construire_milieu.py "sources_gouzes/Office du milieu du jour (carnet Province).docx" "sources_gouzes/Office du milieu du jour (carnet Province).pdf"` | `node tests/milieu.test.js` |
| Complies | textes saisis dans `outils/construire_complies.py` | `python3 outils/construire_complies.py` | `node tests/complies.test.js` |
| Prière du président, provinces de l'Ordre, oraisons des Heures grégoriennes | « Intercessions preces Vêpres.docx », « Preces Litanies … et oraisons de semaines.doc » | `python3 outils/construire_president.py` | regarder des vêpres |
| Lectionnaire Bouchet | `sources_gouzes/bouchet/lectionnaire Bouchet.docx` | `python3 outils/construire_bouchet.py` | `node tests/bouchet.test.js` |
| Version latin-français | les 3 tomes des Heures grégoriennes | `python3 outils/construire_offices_latins.py` | `node tests/latin.test.js` |

### 3.7 Partitions

- **Remplacer ou retirer une partition** : `partitions/corrections.json`, marche à suivre pas à pas dans
  **`docs/CORRIGER-UNE-PARTITION.md`**. Contrôle : `python3 outils/verifier_corrections.py`.
- **Ordo du sanctoral** (quelle partition à quelle fête) : relevé automatiquement par
  `python3 outils/construire_ordo.py "<dossier des carnets>"` ; les retouches à la main sont dans la
  fonction `retoucher()` de ce fichier. Contrôle : `node tests/sanctoral.test.js`.
- **Hymnes, intercessions, canon du temps** (Avent, Carême, Pâques, dimanches du temps ordinaire) : table
  des pages du carnet dans `site/js/partitions.js` (`hymnesTemps`, `prieresTemps`, `CANON`). Pour la
  changer, le demander à Claude en donnant la page du carnet.
- **Un carnet a été refait** (nouveau PDF) : rendre les pages, puis indexer, puis découper —
  `bash outils/rendre_partitions.sh "<dossier des carnets>"`, `python3 outils/indexer_partitions.py "<dossier>"`,
  `python3 outils/decouper_partitions.py <code> "<carnet.pdf>"`, `python3 outils/marquer_musique.py <code>`.
  ⚠️ Ne pas redécouper le livret des **complies** : les numéros des pièces changeraient.
- Audit d'ensemble : `node outils/audit_partitions.js`.

### 3.8 Psaume invitatoire selon le jour

- **Fichier** : `site/js/offices.js`, ligne `const INVITATOIRE = ["94", "23", "99", "66", "23", "66", "99"];`
  — dans l'ordre dimanche, lundi, mardi, mercredi, jeudi, vendredi, samedi. (Le dimanche et les fêtes
  prennent toujours le 94.)
- **Ensuite** : changer le numéro `?v=` (voir 3.11).

### 3.9 Réglages par défaut pour un nouvel appareil, office selon l'heure

- **Fichier** : `site/js/app.js`.
  - Ligne `const DEFAUT = { propreOP: true, repartition: "romaine", … taille: 18, theme: "auto" … }` : ce
    qu'un nouvel appareil voit avant tout réglage. `repartition` : `"aelf"`, `"romaine"`,
    `"romaine-gouzes"` (Province), `"gouzantine"`, `"latin"`.
  - Fonction `officeDuMoment()` : les heures de bascule (5, 11, 15, 20).
  - Penser à cocher le même choix dans `site/index.html` (attribut `checked`) pour que la fenêtre ⚙ soit
    cohérente.
- **Limites** : 400 jours par PDF (`app.js`, « 400 ») ; 100 jours hors connexion (`site/js/horsligne.js`).
- **Ensuite** : changer le numéro `?v=` (voir 3.11).

### 3.10 Apparence : couleurs, polices, mise en page du PDF

- **Couleurs** : `site/css/office.css`, tout en haut (`--fond`, `--texte`, `--rouge` des rubriques,
  `--accent`…) ; le thème sombre juste en dessous (`:root[data-theme="dark"]`).
- **Polices** : `site/css/polices.css` (Kepler). Pour refaire les fichiers de police :
  `bash outils/polices_kepler.sh`.
- **PDF** : `site/css/impression.css` (tailles, titres) ; marges, titre courant et numéro de page dans
  `site/js/app.js`, fonction `produirePdf` ; page de titre (« Ordre des Prêcheurs », « Liturgie des
  Heures ») au même endroit.
- **Word** : `site/js/docx.js` (marges, polices, pied de page).
- **Ensuite** : changer le numéro `?v=` (voir 3.11) et regarder un PDF.

### 3.11 Après toute modification de `site/js` ou `site/css`

Dans la page qui charge le fichier (`site/index.html`, `messe.html`…), augmenter son numéro `?v=N`
(par exemple `js/offices.js?v=115` → `?v=116`) : sinon les navigateurs gardent l'ancienne version (les fichiers
versionnés sont gardés longtemps par le service worker). Puis `bash tests/tout.sh`. Si on ajoute un fichier au site, l'ajouter aussi à la liste `COQUE`
de `site/sw.js` (lecture hors connexion).

### 3.12 Mise en ligne (Azure)

- **Relever les partitions utilisées** (après tout changement du programme, des données ou des carnets) :
  `node outils/releve_images.mjs` (20 à 40 minutes). Il construit quatre années d’offices dans toutes les
  variantes et écrit `partitions/images-utilisees.json` : seules ces images sont publiées.
- **Publier** : `bash outils/publier_azure.sh` (site + partitions), `--sans-partitions` (site seul),
  `--essai` (prépare sans envoyer), `--forcer` (publie malgré un relevé ancien, déconseillé). Notice
  complète : `docs/MISE-EN-LIGNE-AZURE.md`.
- **Dans le script** : nom du site et groupe (`NOM`, `GROUPE`, en tête), qualité des images publiées
  (`formatOptions 45` : de 0 à 100, plus haut = plus net et plus lourd), garde-fou de taille (490 Mo).
- **Accès au site** : par identifiant et mot de passe personnels (connexion par compte, `docs/CONNEXION.md`) ;
  les comptes se gèrent dans la page Comptes du service de connexion. L'ancien mot de passe commun d'Azure
  est désactivé et doit le rester. Toute publication garde la connexion (implicite dans `publier_azure.sh`).
- **Durée de cache** (combien de temps un navigateur garde un fichier sans redemander) :
  `site/staticwebapp.config.json`.
- Les archives `.\…-app.zip` que l'outil d'Azure laissait à la racine du dossier (330 Mo chacune) sont
  désormais créées dans un dossier temporaire et effacées. Celles d'avant le 17/11/2026 peuvent être supprimées.

### 3.13 Utilisation sur cet ordinateur

- **Lancer** : double-clic sur « Lancer le bréviaire.command » (adresse `http://localhost:8765`). Pour
  changer le port, modifier `8765` dans ce fichier.
- Les **signalements** reçus en local sont dans `signalements/` ; `python3 outils/signalements.py` les
  range dans `signalements/a-traiter.md`.

---

## 4. Contrôles à relancer (tous doivent rester sans erreur)

```bash
node tests/calendrier.test.js
node tests/offices.test.js
node tests/milieu.test.js
node tests/gouzes.test.js
node tests/capitules.test.js
node tests/capitules_jours.test.js
node tests/sanctoral.test.js
node tests/complies.test.js
node tests/bouchet.test.js
node tests/latin.test.js
node tests/signaler.test.js
node tests/communs.test.js
```
