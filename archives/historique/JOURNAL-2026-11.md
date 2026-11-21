> **Journal archivé le 20/11/2026.** Ceci est l'ancien `CLAUDE.md`, tenu séance par séance du 10 au 20/11/2026,
> conservé tel quel comme mémoire détaillée de chaque choix. Le `CLAUDE.md` de la racine en garde l'essentiel.
> Les chemins cités ici sont ceux d'avant le rangement du 20/11/2026 (par ex. `PLAN-CONNEXION.md` est devenu
> `docs/CONNEXION.md`, les `.doc` de la racine sont dans `sources_bible/`, `propre_op.toml` est dans `archives/`).

# Bréviaire (psautier BJ) — brief de reprise

Projet distinct de Lectio (dossier voisin `lectio-biblique`, dont le CLAUDE.md du dossier parent
parle). Même utilisateur : religieux dominicain, non développeur ; répondre en français, sans
jargon, dire ce qui est testé ou non. `README.md` = notice pour lui.

## Demande d'origine (10/11/2026)

« Le même site que bref.reparemoneglise.com, avec ma traduction de la Bible et des psaumes » :
calendrier perpétuel, interface pour produire les offices d'une période en PDF, hébergeable comme
le site modèle, AELF pour le reste. Conserver **le gras des inflexions** et **l'espacement des
stiques et strophes**. Décisions prises avec lui :
- calendrier romain (France) + propre OP (option, activée par défaut) ;
- trois répartitions : romaine (AELF), romaine + antiennes de Gouzes, gouzantine (11/11/2026) ;
- site **public** (il affirme détenir les droits ; prévenu du « © Cerf, hors commerce ») ;
- offices : Lectures, Laudes, Milieu du jour (ajouté le 11/11/2026), Vêpres, Complies (pas la messe).

## Architecture

Site statique (`site/`), aucune dépendance. Le navigateur interroge api.aelf.org (CORS ouvert)
pour les textes propres ; psaumes/cantiques et lectures viennent des JSON construits depuis les .doc.
- `js/calendrier.js` : temporal calculé + `sanctoral.json` (relevé sur l'AELF 2018-2027 par
  `outils/construire_calendrier.py`, corrections manuelles dans `outils/corrections_sanctoral.json`)
  + `propre_op.json` (depuis `propre_op.toml`, copié de Lectio). Préséance, transferts de solennités.
- `js/aelf.js` : l'AELF ne publie que 2018-2027 ; hors fenêtre, on prend le même jour liturgique
  d'une année couverte (clé temporale, + cycle A/B/C le dimanche ; clé sanctorale ; mémoire =
  psalmodie de la férie équivalente).
- `js/textes.js` : `Psautier.trouver(refAELF, versetsAELF)` relie une référence AELF (« 101 - I »,
  « 118-18 », « CANTIQUE (Ap 4-5) », « Lc 1 ») à une pièce du psautier et la découpe par plages de
  versets (le psautier ne numérote pas chaque verset ; les transpositions BJ restent en place).
  `Bible.lire(ref)` : références AELF tolérantes (« cf. », « 9_10 », « 3. 8b »…).
- `js/offices.js` : assemblage ; tout HTML AELF passe par `propre()` (liste blanche de balises).
- Impression : `?imprimer=AAAA-MM-JJ..AAAA-MM-JJ&offices=laudes,vepres&format=A5[&apercu]`.

## Données

- Psautier : `textutil` (macOS) → HTML qui garde gras/italique/exposants ; numérotation grecque
  (comme l'AELF), 174 pièces (Ps 9A/B, 18A/B, 113A/B, 118 en 22 sections `118-1`…), cantiques
  `AT1`-`AT59`, `NT1`-`NT14` (NT1 Magnificat, NT2 Benedictus, NT3 Nunc dimittis). Lettres
  hébraïques saisies en police translittérée (a=aleph…) → converties. « PRIONS » = prière psalmique.
- Bible : .doc Word 97 illisible par textutil → `outils/lire_word.py` (lecteur CFB/piece table).
  Daniel 13-14 absents de la source ; 1 Ch 2 et Jr 25 sans titre (rétablis) ; prologue du Siracide
  = chapitre 0.

## Tests (doivent rester verts)

```
node tests/calendrier.test.js     # calendrier vs AELF, 2018-2027 : 0 écart
node tests/offices.test.js        # chaque référence AELF relevée trouve son texte, sans manque ni excès
node tests/milieu.test.js         # milieu du jour : psaumes, verset, hymne, partition chaque jour
node tests/offices_op.test.js     # propre de l'Ordre des carnets : psaumes, images, chaque fête trouvée
```
Relevés AELF (références et noms seulement, jamais de textes) : `outils/recolter_aelf.py`,
`outils/recolter_references.py`.

## Pièges

- `python3 -m http.server` se bloque au démarrage sur ce Mac (recherche DNS) → `outils/serveur.py`.
- Le lanceur intégré de l'app (preview_start) ne démarre pas non plus : lancer le serveur via Bash.
- PDF de contrôle : Brave headless piloté par DevTools (attendre `body[data-pret="1"]`) ;
  `--print-to-pdf` simple reste bloqué.
- Changer `?v=N` dans index.html après modification de JS/CSS (cache navigateur).

## Liturgie chorale (Gouzes) — fait le 11/11/2026

- Sources : `sources_gouzes/` (xlsx + docx/doc). `outils/construire_gouzes.py` (tableau : TO, ROM,
  temps pascal) appelle `outils/construire_gouzes_docs.py` (Avent, Carême, répons, litanies,
  Ténèbres, Grand Canon) → `site/donnees/gouzes.json` = {offices: {clé: {psalmodie, evangelique,
  invitatoire}}, textes: {hymnes, repons, preces, canon, tenebres, …}}.
- `site/js/gouzes.js` : `Gouzes.resoudre(jour, office, mode)` choisit les clés (voir README pour
  les choix d'alternance, validés par l'utilisateur le 11/11/2026). `offices.js` affiche ; repli AELF signalé.
- Modes : "romaine" | "romaine-gouzes" | "gouzantine" (préférence `repartition`).
- Export Word : `site/js/docx.js` (ZIP stocké + WordprocessingML) ; test :
  `?imprimer=…&sortie=docx&apercu` laisse le fichier en base64 dans `window.__docx`.
- Test : `node tests/gouzes.test.js`.

## Carnets de la Province (« Perdrix ») et partitions — 11/11/2026

- Source : Drive partagé LITURGIE/02-Liturgie-des-Heures/Carnets PERDRIX (PDF Pages : images de
  partitions + titre de page en texte). L'utilisateur dit : « ceux en vigueur pour tous les jours ».
- `outils/rendre_partitions.sh` → `partitions/<carnet>/p-NNN.jpg` (110 dpi, ~240 Mo, HORS de `site/`).
  `outils/indexer_partitions.py` → `partitions/index.json` (pièces étiquetées : office, rôle, jours,
  semaines, année, cotes, nt) + `site/donnees/province.json` (cotes des antiennes du Carême, public).
- `site/js/partitions.js` : choix des pages ; `outils/serveur.py` sert `/partitions/` en local.
  Décision par défaut (non confirmée explicitement) : partitions non publiées en ligne.
- Mode "romaine-gouzes" renommé « Province de Toulouse (carnets) » ; Carême = antiennes par cote
  (`Gouzes.antiennesProvince`), NT du carnet aux vêpres ; fêtes/solennités → psalmodie AELF.
- Capitules : transcrits à la main dans `outils/capitules_province.py` → `site/donnees/capitules.json` ;
  `site/js/capitules.js` ; tests `node tests/capitules.test.js` (toutes les réf. lisibles) et
  `node tests/capitules_jours.test.js`. Lectures douteuses marquées « incertain » dans les données.
- Non faits : images dans l'export Word ; livrets Gouzes scannés.
- 11/11 : corrigé un bogue du calendrier (1-2 déc. avant l'Avent pris pour l'octave de Noël) ;
  le test calendrier n'a plus d'exception.

## Milieu du jour et jours saints — 11/11/2026

- Carnet « Office du milieu du jour (carnet Province) » (.docx + .pdf dans `sources_gouzes/`) →
  `outils/construire_milieu.py` → `site/donnees/milieu.json` (hymnes par temps, `hebdo[sem][jour]`,
  69 `blocs` de fêtes/temps/communs, chacun avec ses `pages` de partition). `site/js/milieu.js` :
  `Milieu.pour(j)`. Partitions : `partitions/milieu/` (carnet ajouté à `rendre_partitions.sh`),
  affichées par `offices.js` sans passer par `partitions/index.json`.
- AELF : l'office s'appelle `sexte` dans l'API. Gouzantine TO : `G/to/{sem}/{jour}/milieu` du tableau.
- Jours saints : `site/donnees/jours_saints.json` (saisi à la main depuis « Complies jours Saints.pdf ») ;
  `joursSaintsLaudes` / `joursSaintsComplies` dans `offices.js`, hors mode romaine.
- L'AELF ne publie que ~9 mois à l'avance (404 au-delà, même dans 2027) : `AELF.office` se replie
  alors sur `equivalents(iso, true)`.
- Données JSON chargées avec `cache: "no-cache"` (le navigateur gardait d'anciennes versions) ;
  milieu/jours_saints/capitules/province attendus avant le premier affichage.
- Solennité sans propre : psaumes graduels série II (validé par l'utilisateur le 11/11/2026).
- Test : `node tests/milieu.test.js`.

## Partitions sous leur texte, complies OP, milieu du jour de Marseille — 11-12/11/2026

Demande : « la partition de l'hymne sans la page du livret, puis une antienne, un psaume, une
antienne… et le répons au bon endroit ; toujours le texte puis la partition en dessous ».
- `outils/decouper_partitions.py <code> <pdf>` : repère les portées (lignes très encrées) sur un
  rendu 110 dpi, regroupe en pièces (coupure aux intertitres « … : », aux grands blancs, aux
  étiquettes « Psaume … » à côté du ton), recadre `partitions/<code>/p-NNN.jpg` avec sips →
  `s-NNN-K.jpg` + `pieces.json` (ids des psaumes de l'étiquette, cotes K…).
- `Partitions.piecesPour(j, office)` + `placeur()` dans `offices.js` : hymne, invitatoire,
  lucernaire, antiennes (cote, puis id du psaume, puis numéro de base), répons, Benedictus/
  Magnificat, prières ; le reste à la fin. Seulement hors répartition romaine.
- Complies : livret de Bordeaux 2009 (`sources_gouzes/Completorium Bx.pdf`, vectoriel) →
  `outils/construire_complies.py` (textes saisis, pièces `complies/s-PPP-N.jpg` nommées à la main :
  **relancer le découpage de ce livret change les numéros → revérifier construire_complies.py**).
  `compliesOP()` dans `offices.js`.
- Milieu du jour : livret de Marseille 2020 (`sources_gouzes/Office de Milieu du Jour 2020 Marseille.pdf`,
  images) ; `construire_milieu.py` prend les images à leur position (pdftohtml -xml), les rattache
  aux jours/blocs par les intertitres (petites capitales recollées), texte d'antienne : tableau
  Gouzes par section du Ps 118, sinon `TRANSCRITES` (lu à l'œil ; l'OCR tesseract est inutilisable
  sur ces partitions). Hymnes grégoriennes : `HYMNES_G` (zones en unités pdftohtml), `TEMPS_G`.
- Capitules du sanctoral : tableau imprimé reçu (photo) → 22 févr., 15 août, Archanges, Dédicace,
  Vierges, Défunts corrigés ; 4 oct. « Ga 3, 19-20 » imprimé (Ga 2, 19-20 ?) marqué incertain.

## Trois versions, partitions repliables, Sainte-Baume, Azure — 16/11/2026

Demande : antiennes et répons « d'abord en texte, puis en partition avec une section repliable »,
de même pour les choix d'antiennes ; trois versions (simple / avec partitions / gouzantine) ;
mise en ligne sur Azure.
- Réglage `version` (index.html, `VERSIONS` dans app.js) → (`repartition`, `partitions`) :
  romaine | province (romaine-gouzes, sans partitions) | province-partitions | gouzantine.
  L'option « avec partitions » n'apparaît que si `partitions/index.json` se charge.
  URL d'impression : `&version=…` (implique les partitions ou non).
- `Partitions.figure()` → `<details class="partition-pliee">` (ouvert si `Partitions.ouvertes`,
  vrai à l'impression avec partitions ; replié masqué à l'impression).
- Sainte-Baume : `outils/indexer_sainte_baume.py` (images InDesign à leur position, titre
  « Psaume N » au-dessus, jour/office par titres et titres courants) → `partitions/sb/pieces.json`
  avec texte/cote du tableau `R/to/{sem}/{jour}/{office}` (même ordre). `Partitions.sbPour` (Province,
  temps ordinaire, hors fêtes ; vêpres du samedi = semaine du dimanche suivant).
- Gouzantine : pas de placeur ; `partitionTexte()` via `Partitions.parTexte` (Sainte-Baume,
  cotes du Carême via `Gouzes.antienneDeCote`). Couverture mesurée : 209/583.
- Les antiennes non rattachées vont en fin d'office, plus en tête de la psalmodie.
- Azure : `site/staticwebapp.config.json`, `outils/publier_azure.sh` (SWA CLI via npx, jeton
  demandé), notice `MISE-EN-LIGNE-AZURE.md`. Partitions ≈ 372 Mo > 250 Mo de l'offre gratuite →
  Standard + mot de passe si l'utilisateur veut les publier. Rien n'a été déployé.
- Contrôle PDF : `node outils/pdf_controle.mjs "<url>" sortie.pdf` (Brave headless).
- Non intégré : « Les Heures Grégoriennes » (3 tomes, ~2 150 p. pour le tome I) — reçus le 16/11.

## En attente de l'utilisateur

- Ouvrir un .docx dans Word pour contrôle.
- Forme de la doxologie (courte actuellement ; l'AELF utilise « …au Dieu qui est, qui était et qui vient… »).
- Textes propres des fêtes OP (non fournis par l'AELF) : à saisir s'il le souhaite.
- Capitules : 19 mars (Si 3, 1-16 ?) et Carême jeudi vêpres (rature ?) ; 4 octobre « Ga 3, 19-20 »
  tel qu'imprimé (Ga 2, 19-20 ?). Carnet sanctoral (février-août) annoncé par l'utilisateur.

## Choix sanctoral/temporal, Word avec images, Heures grégoriennes, Azure en ligne — 16/11/2026 (suite)

- Prière psalmique repliée (`<details class="priere-psalmique">`), dépliée si préférence `priere`.
- Choix d'office : `Calendrier.jour(date, {choix})` → `choixPossibles` (temporal niveau ≥ 6 non
  mobile + saint niveau 5-12) ; menu `select[data-choix-date]` dans l'en-tête, mémorisé dans
  `pref.choix[date]`. `AELF.office(nom, iso, j)` → `equivalentsChoix` (férie d'une autre année
  quand on choisit le temporal un jour de saint).
- Word : `Docx.creer` asynchrone, images JPEG en ligne (DrawingML). Une notation **modifiable**
  (MusicXML/GABC) n'existe pas : il faudrait les sources des éditeurs ou une saisie à la main.
- Heures grégoriennes (3 tomes) : `decouper_partitions.py` (mode strict + `gregorien` : coupe aux
  « Ad Benedictus », « ant. N », « Responsorium », et aux intertitres Preces/Oratio… collés sous la
  dernière portée) → `partitions/hg1-3/` ; `outils/indexer_heures_gregoriennes.py` →
  `partitions/hg/index.json` (clé de jour, office, rôle, rang, variante, traduction française de la
  page en regard). Les antiennes latines ne correspondent pas aux antiennes françaises de l'AELF :
  proposées seulement en **alternative** (« Ou bien, en grégorien »), avec leur propre traduction,
  là où aucune partition n'existe. Dimanches TO (antienne par année A/B/C) non utilisés.
- Azure : abonnement « Azure subscription 1 », groupe `breviaire`, Static Web App
  `breviaire-dominicain` **Standard**, Central US (West Europe refusait les nouveaux clients),
  https://calm-flower-052e85c10.4.azurestaticapps.net. Mot de passe sur tout le site (basicAuth,
  posé par `az rest`) ; mot de passe provisoire dans `.mot_de_passe_site.txt` (gitignoré), à
  remplacer par l'utilisateur dans le portail. `outils/publier_azure.sh` : jeton via `az`, copie
  des pièces découpées + 38 pages entières encore utilisées, recompression `sips` qualité 60,
  garde-fou 490 Mo.

## Version « latin-français » (Heures grégoriennes) — 16/11/2026

Demande : « la version en latin et en français dans une nouvelle version du psautier ; la
construction des offices jusqu'ici ne doit pas être impactée : une autre façon de dire l'office ».
- Texte : Ghostscript txtwrite (`sources_gouzes/heures-gregoriennes/gs/gs-<tome>-NNNN.txt`), qui garde
  les codes des voyelles marquées (police Antiphonaire) ; pdftotext les perd. Table dans
  `construire_offices_latins.py` (SUR, AMBIGUS e/i/é résolus par le vocabulaire, LATIN ǽ/œ́/ý).
- `outils/construire_offices_latins.py` → `partitions/hg/offices.json` {"<tome>:<clé>|<office>": [éléments]}.
  Page latine (paire) + page française (impaire) appariées par SequenceMatcher sur les types de
  sections ; clés comme l'indexeur (+ `K/<jour>` pour les complies, marque `h` tierce/sexte/none au
  milieu du jour) ; titres courants pris dans pdftotext (Ghostscript colle les mots) ; lettrines
  recollées par le vocabulaire (en excluant les débuts de psaume, où les mots sont coupés) ;
  psaume en plusieurs parties : la partie « II » après « Ant. 2. » devient un psaume.
- `site/js/latin.js` : `Latin.construire(j, office, options, {entete, bloc})`, appelé en tête de
  `Offices.construire` seulement si `repartition === "latin"`. Version `latin` dans `VERSIONS`
  (app.js), radio `#version-latin` visible si `offices.json` se charge. Docx : `.bilingue` → tableau.
- Contrôle : PDF A5 (17/02/2027 vêpres+complies) relu ; offices de 19 jours × 4 heures construits
  sans erreur.
- 16/11/2026 : publié sur Azure (site + partitions + version latin-français), protection vérifiée
  (sans mot de passe → redirection `/.auth/basicAuth/login`). Contrôle avec mot de passe : à faire
  par l'utilisateur (Claude ne saisit pas de mot de passe sur un site en production).
- Téléphone : `.cadre > main { min-width: 0 }` (le menu « Office : » élargissait la page à 500 px).

## Sanctoral selon les carnets, table des hymnes, corrections à la main — 16/11/2026 (soir)

Demande : vérifier la présence de tous les offices du sanctoral ; reprendre partitions, hymnes et antiennes
« indiquées » par les 7 livrets Perdrix ; vérifier chaque hymne ; notice pour corriger une partition soi-même.
- Constat : le carnet du sanctoral n'était **pas branché** (`pour()` filtrait par carnet du temps). Carnet
  `sanctoral2` (Sanctoral-Fév-Août.pdf, 411 p.) rendu et découpé.
- `outils/marquer_musique.py` : champ `nature` dans `pieces.json` (gravures = pièces centrées et sombres,
  densité d'encre > 14 % ; lignes de titre) → ignorées partout.
- `outils/construire_ordo.py "<dossier carnets>"` → `partitions/ordo.json` + `partitions/ordo-rapport.md` :
  56 fêtes, 142 offices. Lit les pages d'office (titre, pièces, étiquettes « Psaume N » sous l'antienne,
  « ou », renvois « Hymne p. N »). Les renvois imprimés sont en retard de 1 à 5 pages (pages ajoutées) :
  on prend la pièce du bon rôle la plus proche **vers l'avant**. Retouches à la main dans `retoucher()`.
- Site : `Partitions.ordoPour(j, office, optsJour)` (clé `MM-JJ`, `trinite`, `saint-sacrement`, `sacre-coeur`,
  `christ-roi` ; 1res vêpres la veille) ; `offices.js/piecesDuJour` ; antiennes posées par psaume puis dans l'ordre.
  Hymne du carnet affichée d'abord, hymne AELF repliée (`details.hymne-aelf`).
- `Partitions.hymnesTemps(j, office)` : table explicite (pages PDF) des hymnes, lucernaires, invitatoires
  pour TO dimanches, Avent, Carême, temps pascal (remplace le choix par titres pour ces rôles).
- Corrections de l'utilisateur : `partitions/corrections.json` (`remplacer`, `retirer`, `offices`) +
  `partitions/corrections/` ; notice `CORRIGER-UNE-PARTITION.md` ; `outils/verifier_corrections.py`.
  Nom du fichier affiché sous chaque partition, clé de l'office en bas (non imprimés).
- Tests : `node tests/sanctoral.test.js` ; audit : `node outils/audit_partitions.js [--hymnes|--tout]`.
- **Reste à faire** (audit : ~325 offices du temps avec doublon ou manque) : livret de Noël (offices par
  date, même forme que le sanctoral → étendre `construire_ordo.py`) ; antiennes des dimanches d'Avent et de
  Pâques (pages « 1er dimanche : Psaume 140 ») ; répons en double ; Carême laudes de férie sans hymne
  (canon de saint André : à quel office ?). Textes des antiennes du sanctoral non transcrits (images seules).
- Questions posées à l'utilisateur : hymnes numérotées I-V/VI/VII des féries (Avent, temps pascal) : par jour,
  par semaine ou au choix ? (affichées « au choix » en attendant).
- Non publié sur Azure à cette date (`publier_azure.sh` mis à jour : corrections, pages entières de l'ordo).

### Suite du 16/11/2026 : livret de Noël, antiennes et répons du temps, canon de Carême

- Réponses de l'utilisateur : les hymnes numérotées (I à VII) sont **au choix**, en sections repliables ;
  en Carême le **canon de saint André tient lieu d'hymne** (mis aux vigiles et aux laudes des féries :
  texte `Gouzes.canonDuJour(j)`, pages `pagesCanon(j)` du livret, p. 28-57).
- `outils/ordo_noel.py` (appelé par `construire_ordo.py`) : offices du livret de Noël décrits à la main
  d'après son sommaire → clés `12-25`…`12-31`, `01-01`, `sainte-famille`, `epiphanie`, `bapteme`,
  `noel-ferie-<jour>` (2-7 janvier = lundi-samedi), `cana` (2e dim. TO année C), `appel` (3e dim. TO, A et B),
  `02-02`. ordo.json : 76 entrées, 203 offices. `Partitions.cleOrdo` fait la correspondance.
- `hymnesTemps` donne aussi antiennes, répons, cantiques, prières (Avent dimanches et féries, Carême
  répons des féries, temps pascal : octave, dimanches 3-6, Ascension, 7e dimanche, Pentecôte) ; tout rôle
  présent dans la table remplace le choix par titres. `filtre` = expression cherchée dans l'étiquette de la
  pièce (« 2e dimanche », « mercredi »…) pour les pages qui portent les antiennes de plusieurs dimanches.
- Audit (`node outils/audit_partitions.js`) : ~30 offices signalés sur l'année (Triduum traité ailleurs,
  24 décembre, 13 dimanches TO à « 3 pages d'antiennes » = pages de suite). Non contrôlé à l'œil office par office.
- Incertain : cantique NT du dimanche en Carême (p. 180-185, sans titre de jour dans le livret) ; vêpres de
  l'octave de Noël (ligne tronquée dans le texte du PDF : « Lucernaire p. 4 ou Hymne p. 6… »).

### Soir du 16/11/2026 : antiennes, complies, légendes

- Remarques de l'utilisateur : « je vois des erreurs de partition, notamment des antiennes » ; replier les hymnes
  (le chantre déplie celle qu'il veut) ; afficher le capitule des complies ; pas de description inutile sous les partitions.
- Contrôle des antiennes : `node outils/releve_antiennes.mjs "<url d'impression &apercu>" releve.json` (relève dans la
  page, pour chaque psaume, les images posées dessous) puis `python3 outils/controle_antiennes.py releve*.json`.
- Corrigé : Sainte-Baume ne se mêle plus au carnet de la Province (SB seulement si le carnet ne donne aucune antienne) ;
  `placeur.psalmodie` réécrit (cote, psaume de l'étiquette — le psaume avant le cantique —, puis rang habituel :
  laudes 1re/3e pièce, vêpres 1re/2e) ; antiennes communes à plusieurs dimanches (Avent, Pâques : `filtre "*"`) placées
  par rang ; veille d'une solennité en semaine : l'office reste celui du jour, les pièces des Ires vêpres vont en fin
  d'office (rôle `veille`), car l'AELF ne donne pas ces premières vêpres.
- Légende d'une partition seulement si elle aide à choisir (hymnes, « ou bien », « au choix ») ; nom de fichier et clé
  de correction affichés **en local seulement** (`Partitions.local`). Pièces « ou bien » toujours repliées.
- Complies (Completorium Bx, même fichier que `sources_gouzes/`) : capitules = texte imprimé du livret
  (`lecture_texte`, les demi-versets ne se lisaient pas bien dans la BJ) ; hymnes en `details.choix-hymne`
  (première dépliée à l'impression, `options.impression`) ; ajout O spem miram, Pie Pater, Magne Pater, Benedictus
  Redemptor. Non repris : les 8 « Prières à notre Père saint Dominique » (p. 50-51), ton du cantique après le
  IIIe dimanche de Carême (non découpé).
- À voir : Christ-Roi 2026 (21-22 nov.) : les psaumes affichés (AELF) ne sont pas ceux du carnet (Ps 112/116, 149).
- 16/11 (fin) : hymnes du milieu du jour en `details.choix-hymne` (une section par proposition, la première dépliée à
  l'impression) ; fin des complies : partitions du Salve, de l'O Lumen, etc. toujours proposées, repliées
  (`figure(…, { ferme: true })`), même dans la version sans partitions. Azure : publié le 16/11 au soir (images qualité 45) ;
  la protection par mot de passe était désactivée (environnements : aucun) — l'utilisateur la rétablit lui-même.

### Prière du président, provinces, oraison au choix — 17/11/2026

- Sources reçues (copiées dans `sources_gouzes/`) : « Intercessions preces Vêpres.docx » (formule des vêpres « Pour le Maître
  de l'Ordre… », provinces de l'Ordre par jour du mois, mois impairs / pairs ; « Faisant mémoire… ») et « Preces Litanies des
  Laudes et Vêpres et oraisons de semaines.doc » (oraisons des Heures grégoriennes, semaines I-IV, laudes/milieu/vêpres).
- `outils/construire_president.py` → `site/donnees/president.json` ; `Offices.chargerPresident`.
- `president(j, office)` : avant le Notre Père des laudes et vêpres (hors version romaine), en italique : aux vêpres la
  formule avec l'intention du jour, puis « Faisant mémoire… » avec le saint du jour (`saintDuJour`) ; dessous, discret,
  « Aujourd'hui, nous prions pour : … ». Mois pairs : la liste s'arrête au 26 (rien du 27 au 31).
- `oraisonAuChoix` : féries du temps ordinaire (laudes, milieu, vêpres) : oraison liturgique ou des Heures grégoriennes,
  l'autre repliée ; réglage `#opt-oraison` (`pref.oraison`). Les litanies de ce nouveau document ne sont pas reprises
  (celles de `gouzes.json` viennent de l'ancien fichier).
- Non publié sur Azure.

### Gabarit des exports PDF et Word — 17/11/2026

- Critique de design (skill design-critique) puis refonte : `@page` avec titre courant (« Liturgie des Heures — période »)
  et numéro de page (boîtes de marge, absentes de la page de titre), marges de livret (A5 : 15/13/16 mm), page de titre
  (surtitre, titre, filet, période, offices), en-tête d'office centré avec filet rouge, intitulés de section 7,5 pt.
  CSS dans `impression.css`, `@page` injecté par `produirePdf` (app.js).
- Word (`docx.js`) : mêmes choix — page de titre, en-tête centré avec filet (`filet`), pied de page numéroté
  (`word/footer1.xml`, `titlePg`), marges 13 mm en A5, paroles du président en italique. XML validé ; **non ouvert dans Word**.
- Exemples à la racine : « Exemple - nouveau gabarit, 15 juin 2027 (A5) » (.pdf et .docx). Non publié sur Azure.

## Audit et lecture hors connexion — 16/11/2026 (nuit)

- Demande : audit, puis « enregistrer 30 jours d'offices » (une semaine, 30 jours ou une période) pour lire sans réseau.
- `site/sw.js` (service worker) : fichiers du site = réseau d'abord, copie gardée si le réseau manque ou tarde (4 s) ;
  images de partitions = copie gardée d'abord, et gardées **seulement** par l'enregistrement. Liste `COQUE` à tenir à
  jour quand on ajoute un script ou un fichier de `donnees/`. Ne touche pas à `/.auth/` (mot de passe Azure).
- `site/js/horsligne.js` : `HorsLigne.enregistrer(debut, fin, offices, options, version, suivi)` construit chaque office
  (les textes AELF se rangent seuls), puis garde les fichiers déjà demandés par la page et les images des offices.
  Bloc « Hors connexion » des réglages (`horsLigne()` dans app.js) ; 100 jours au plus.
- `site/js/aelf.js` : mémoire des réponses AELF passée de localStorage (5 Mo, vidé quand plein) à Cache Storage
  (`breviaire-aelf-1`) ; date non publiée (404) notée `{__absent}` et redemandée au plus une fois par jour.
- Contrôle : `node outils/controle_horsligne.mjs [jours] [version]` (Brave sans fenêtre : enregistre, coupe serveur et
  réseau, relit). Passé : 7 j romaine, 30 j province-partitions (150 offices, 462 partitions, 74 Mo), 7 j latin.
  Le navigateur intégré de l'app Claude refuse les service workers : ne pas s'en servir pour ce contrôle.
- Non testé : sur un vrai téléphone (iPhone : ajouter à l'écran d'accueil, sinon Safari efface après ~7 jours) ; sur
  Azure avec le mot de passe actif. Non publié.
- Indexation interdite (accord de l'utilisateur) : `robots.txt`, balise meta, en-tête `X-Robots-Tag`.
- Audit, restant à traiter : icônes PNG pour l'écran d'accueil ; règle CSP ; faille théorique de `propre()` (balise non
  refermée) ; sauvegarde git (une semaine non enregistrée) ; Ires vêpres des solennités ; tierce/none.
- Une autre session modifiait `app.js`, `index.html`, `offices.js` le même soir (`president.json`, option oraison).

### Intercessions des carnets, allègements — 17/11/2026

- Laudes : plus de « Aujourd'hui, nous prions pour : … » (gardé aux vêpres). Plus de mention « Capitule de la Province
  de Toulouse — … » sous la Parole de Dieu.
- `Partitions.prieresTemps(j, office)` (partitions.js) : louanges (laudes) / intercessions (vêpres) + Notre Père des carnets du
  temps — TO : 8 semaines (`((semaine-1)%8)+1`, pages lues dans `index.json`) ; Avent dimanches 78-80 / 28-29, féries 190-191 /
  224-226 ; Carême et Semaine sainte 282-283 (même page pour laudes et vêpres : le sommaire annonce « Preces des Vêpres p. 284 »
  mais cette page est l'Ave Regina) ; Pâques octave 20-23 / 38-40, ensuite 350-351 / 352-353 ; Noël 42-43 / 48-49 (aussi dans l'ordo).
  Fêtes ≤ 8 : annexe « VIe mode » du sanctoral (aussi aux Ires vêpres, `niv` dans `ordoPour`) ; mémoires avec ordo : celles du temps.
- `placeur` (offices.js) : pièces `priere` regroupées en une seule section, repliée à l'écran, imprimée dans le PDF et le Word.
- Les intercessions sont dépliées dans le PDF et le Word (`placeur(…, impression)`), repliées à l'écran.
- `decouper_partitions.py` : une image sans mot du PDF collée juste au-dessus d'une pièce (intonation « En paix, prions le
  Seigneur » à portée courte) est rattachée à la pièce. Relancé seulement sur `to` pages 280, 283, 295 (puis `marquer_musique.py to`) ;
  les pages des intercessions des autres carnets ne changent pas. Ne pas relancer tout le carnet des complies (numéros des pièces).

### Oraison unique, invitatoire par jour — 17/11/2026

- « Capitules identiques entre le liturgique et les Heures grégoriennes » = l'oraison « Ou bien : Oraison des Heures
  grégoriennes » (`oraisonAuChoix`). `memeTexte()` (offices.js) : si les deux textes sont presque les mêmes (≥ 85 % de mots
  communs, accents et « Amen » ignorés), une seule est affichée. Constaté : toujours le cas au milieu du jour ; aux laudes
  et vêpres, l'AELF donne souvent une autre oraison → le choix reste proposé.
- Psaume invitatoire choisi par `psaumeInvitatoire(j, d)` (toutes versions françaises) : dimanches et fêtes (niveau ≤ 8) 94,
  lundi 23, mardi 99, mercredi 66, jeudi 23, vendredi 66, samedi 99 (table de l'utilisateur) ; antienne inchangée.

### Version « 100 % AELF » — 17/11/2026

- Demande : « la même chose qu'AELF, mais avec nos fonctions d'export ». Réglage `version=aelf` (VERSIONS dans app.js,
  radio dans index.html) → `repartition: "aelf"`. Dans `Offices.construire`, drapeau `AELF_PUR` puis options ramenées à
  la romaine sans propre OP, capitules, partitions, oraison des Heures grégoriennes ni choix d'office.
  `psaume()` → `psaumeAELF()` (texte AELF, syllabes accentuées soulignées `<u>`, « Gloire au Père » ajouté sauf Dn 3) ;
  `lecture()` → texte AELF ; invitatoire = celui de l'AELF (pas la table par jour).
- Word : `<u>` → `<w:u>` (docx.js). Contrôlé : 5 offices du 12/01/2027 à l'écran, PDF A5 regardé, .docx (XML valide) non ouvert dans Word.

### Polices Kepler Std — 17/11/2026

- Demande : utiliser les Kepler Std (Adobe, .otf dans ~/Library/Fonts), « la police qui convient pour chaque usage ».
- `outils/polices_kepler.sh` (fonttools + brotli) → `site/polices/kepler-*.woff2` (19 styles, latin + ponctuation, ~48 Ko chacun).
  `css/polices.css` : familles par taille optique — « Kepler Texte » (Regular/Italic/Medium/Bold…, corps), « Kepler Legende »
  (Caption : intitulés de section, références, numéros de verset, tons, résumés repliables), « Kepler Soustitre » (Subhead :
  titre d'office à l'impression, titre des réglages), « Kepler Titre » (Display : titre d'office à l'écran, page de titre).
  Variables `--serif`, `--legende`, `--soustitre`, `--titre` ; l'interface (barre, réglages, avertissements) reste en `--sans`.
  Titre courant et numéro de page du PDF (`@page` dans app.js) en Kepler Legende. Pas de Semibold droit en taille texte : 600 = Bold.
- Word : police par défaut « Kepler Std », titres « Kepler Std Disp/Subh », petits intitulés « Kepler Std Medium Capt »
  (polices non incorporées au .docx : il faut Kepler installé sur l'ordinateur qui ouvre le fichier).
- PDF : polices incorporées (Chrome les met en Type 3, rendu correct). Contrôlé : PDF A5 laudes regardé, écran regardé, .docx (XML valide).
- **Licence** : Kepler Std est une police Adobe ; la licence de bureau permet l'incorporation dans PDF/Word, mais publier
  les fichiers de police sur un site web demande en principe une licence web (ou Adobe Fonts). À trancher par l'utilisateur
  avant le déploiement sur Azure.

### Revue de la version latin-français — 17/11/2026

Demande : « passer en revue l'office grégorien et corriger toutes les erreurs, par exemple le Magnificat ».
- Banc d'essai : `node tests/latin.test.js` (4 heures × 365 jours, sans navigateur ; `TOUT=1` liste tout ;
  `node tests/latin.test.js 2027-01-31 vepres` affiche un office en texte). Reste 1 remarque : vêpres du Samedi saint
  sans répons bref (conforme au livre).
- Extraction (`outils/construire_offices_latins.py`, relancer après toute modification) :
  lettres marquées du français (codes \x01-\x08, \t, \x0b, \x0c) départagées e/é/è/ê/i par un vocabulaire (Heures
  grégoriennes + Bible et psautier BJ) — « bénissèz », « tèrre », « fèls » corrigés ; lettrines déplacées recollées
  (`recoller_lettrines`), petites capitales collées redécoupées (`redecouper_debuts` : « C’EST », « AD TE »…),
  débuts de psaumes irréguliers corrigés à la main (`RETOUCHES_DEBUT`) ; hymnes de Sexte de l'Ordinaire
  (`0:S/sexte/<var>/<temps>|milieu`) ; propres des dimanches du TO relus page par page (`propres_dimanches_to` :
  antienne A/B/C + partition par année `partitionsAnnee`, oraison) ; antiennes propres des dimanches de Carême et
  de Pâques du psautier du tome II (`antiennes_dimanches`, champ `dim` Q1…P7) ; Vendredi saint recousu.
- Affichage (`site/js/latin.js`) : Magnificat/Benedictus/Nunc dimittis sans la page suivante ; consignes et renvois
  de page retirés (`sansConsignes`, `FIN_TEXTE`) ; prose (lectures, intercessions, oraisons) recollée sans coupures ;
  mots coupés en fin de ligne recollés (`recoupe`) ; antienne du dimanche selon l'année ; antienne mariale des
  complies selon le temps (latin traditionnel, traduction du livre) ; Commun des saints pour les fêtes
  (`communDe`, d'après « De Communi … » ou la page citée) ; octave de Pâques = antiennes de Pâques ; cantique
  1 P 2 en Carême ; hymne des 1res vêpres reprise des 2es ; partitions chargées tout de suite à l'impression.
- Contrôlé : PDF A5 du 31/01/2027 (milieu, vêpres, complies) regardé. Non vérifié à l'œil : chaque jour de l'année ;
  le texte latin des antiennes reste celui des images. Non publié sur Azure.

### Lectionnaire patristique dominicain (J.-R. Bouchet) — 17/11/2026

- Demande : à l'Office des lectures, proposer au choix, en section repliée, les lectures du « Lectionnaire pour les
  dimanches et pour les fêtes » (J.-R. Bouchet o.p.), quand il en propose une.
- Source copiée dans `sources_gouzes/bouchet/lectionnaire Bouchet.docx` ; `outils/construire_bouchet.py` (textutil) →
  `site/donnees/bouchet.json` (148 entrées, 199 lectures ; clé = clé temporale AELF « careme-2-3 », « trinite »…, ou
  « MM-JJ », ou « autres-avent / feries-17-24 / autres-noel / autres-epiphanie / autres-paques / autres-pentecote / autres-to »).
  Titres d'auteur reconnus par motif + mot-clé (sinon les vers « Du sein de la Vierge » passaient pour des titres) ; « II » → « Il ».
- `site/js/bouchet.js` : `Bouchet.cles(j)` = propres du jour (temporal, Cana en année C, sanctoral à la date de la célébration ;
  la date du jour seulement si niveau > 6) ; à défaut, les « autres lectures » du temps (semaine après la Pentecôte →
  `autres-pentecote`). Variantes « Année C » filtrées par cycle ; S. Vincent Ferrier : 5 avril (romain) / 5 mai (propre OP).
  Rendu dans `offices.js` (sauf versions « 100 % AELF » et latin-français).
- Présentation (demandée par l'utilisateur, 17/11/2026) : sous « Deuxième lecture », deux `<details class="choix-lecture2">`
  repliés : « Lectionnaire dominicain (J.-R. Bouchet) » (une lecture en clair, plusieurs : chacune repliée) et « Lecture de
  l'AELF » (avec son répons). Sans proposition du lectionnaire : AELF comme avant. Pâques : section du lectionnaire seule.
- Impression : choix **dans la fenêtre d'export** (`input[name=pdf-lecture2]`, `pref.lecture2` = "aelf" | "bouchet",
  `options.lecture2`, URL `&lecture2=bouchet`). `Bouchet.rendu(j, o, esc)` → `{ section, imprime }` : jour propre → toutes les
  lectures de l'entrée ; « autres lectures » → une, à tour de rôle (jours depuis 1970 modulo le nombre). L'ancien choix par
  date (bouton « Retenir », `pref.bouchet`) est supprimé. Contrôlé : PDF A5 et .docx de Noël 2026 (3 leçons), PDF AELF.
  Test : `node tests/bouchet.test.js [date]`.
- Toutes les entrées sont atteignables : Pâques (pas d'office des lectures à l'AELF) → le lectionnaire est proposé sous le
  message (à l’impression : seulement si l’export choisit le lectionnaire) ; « Dédicace de l'église cathédrale » proposée avec celle de l'église
  locale (22 oct.). Jours sans proposition : lundi, mardi, jeudi, samedi de Carême (le livre n'en donne pas). Erreurs de reconnaissance de caractères de la source laissées (« Royaume des deux » pour « cieux »…).
- Azure : l'utilisateur veut le publier « à l'avenir » (17/11/2026) ; rien n'est à ajouter à `publier_azure.sh` (copie de `site/`
  entier ; `sw.js` connaît bouchet.js/json). Pas encore déployé. Livre publié : l'utilisateur dit vouloir le mettre en ligne.

### Signaler une erreur — 17/11/2026

Demande : « une façon de signaler les erreurs », la plus simple possible pour l'utilisateur (choix validé : pas de
courriel, réception sur Azure ; étape 1 = le site et la réception locale).
- `site/js/signaler.js` : bulle « Signaler » sur une sélection dans `#office`, lien en bas de l'office (« À quel
  endroit ? » = titres des sections), lien sous chaque `details.partition-pliee`. `Signaler.decorer(#office, contexte)`
  appelé par `afficher()` (app.js) : ajouts au DOM seulement, jamais au HTML d'`Offices.construire` (PDF/Word intacts).
  Contexte joint : date, office, version, réglages (sans choix/bouchet), section, pièce, `provenance` (déduite des
  classes : psautier BJ, Bible BJ, AELF, partition, Bouchet, Heures grégoriennes…), images, clé `cleJour|office`.
- Réserve `localStorage["breviaire-signalements"]` ; POST `api/signalements` (relatif), renvoi au chargement, à
  l'événement `online` et à chaque nouveau signalement ; réponse non OK = gardé.
- Local : `outils/serveur.py` `do_POST` → `signalements/AAAA-MM.jsonl` (64 Ko max, doublons d'id ignorés) ;
  `outils/signalements.py` → `signalements/a-traiter.md` par provenance ; `signalements/traites.txt` = ids traités.
  Un serveur lancé avant ce changement répond 501 au POST : les signalements restent en réserve jusqu'au redémarrage.
- Contrôlé (navigateur de l'app, 17/11) : sélection → bulle → envoi reçu ; lien de bas d'office ; hors connexion
  (gardé puis renvoyé) ; partition (format téléphone 375 px, pas de débordement) ; rien dans l'aperçu d'impression.
  Non testé : vrai téléphone (sélection tactile iOS/Android, position de la bulle sous le menu système).
- **À faire (étape 2, avec accord de l'utilisateur)** : API gérée de la Static Web App (`site/api/`, fonction
  `signalements`, stockage Table Azure) derrière le mot de passe du site, page « Signalements » ; `publier_azure.sh`
  devra passer `--api-location`. Rien n'est créé sur Azure.
- 17/11/2026 (soir) : publié sur Azure à la demande de l'utilisateur (site + partitions, 369 Mo). Décisions de l'utilisateur :
  **publier les polices Kepler et le lectionnaire Bouchet**. Contrôle en ligne : vêpres du 17/11 construites, Kepler chargée,
  lien de signalement présent, pas d'erreur. `api/signalements` répond 405 (pas d'API) → signalements gardés sur les appareils.
  Le site répond **sans mot de passe** (protection toujours désactivée).
- 17/11/2026 (soir) : la bulle « Signaler » n'apparaissait plus en ligne : une autre session avait réécrit `office.css` et
  effacé les styles du signalement. Styles remis (fin d'office.css), `?v=78`, garde-fou `node tests/signaler.test.js`.
  Republié ; bulle vérifiée sur le site en ligne (ordinateur). **Ne pas réécrire office.css en entier** : modifier par morceaux.
- 17/11/2026 (nuit) : sur un vrai téléphone, la bulle ne s'affichait pas (signalé par l'utilisateur). Sur écran tactile
  (`pointer: coarse` ou `hover: none`) : barre fixe « Signaler ce passage » en bas de l'écran (`.bulle-bas`), la dernière
  sélection est gardée 1,5 s (toucher la barre peut défaire la sélection) ; déclenchement aussi sur `touchend`/`mouseup`.
  Testé en émulation téléphone (navigateur de l'app) ; simulateur iOS indisponible (Xcode non installé). Republié (`?v=79`).

### Audit, mode d'emploi, publication allégée — 17/11/2026

- Rapport : `AUDIT-2026-11-17.md` (mesures : 3 années d'offices construites dans Brave, poids du chargement, documents
  non utilisés). Mode d'emploi de chaque réglage : `MODE-D-EMPLOI-REGLAGES.md` (à tenir à jour avec les réglages).
- `outils/releve_images.mjs [années]` : construit dans Brave sans fenêtre chaque office (4 années ; 3 versions avec partitions, écran
  et impression, avec/sans propre OP, chaque choix saint/férie et les vêpres de la veille) depuis l'Avent de l'année
  liturgique en cours → `partitions/images-utilisees.json` (datée du **début** du relevé : un fichier modifié pendant le relevé la rend
  ancienne). Aucune liste écrite s'il y a une erreur. 17/11 : 5 055 images (2025-11-30 → 2029-12-02), ≈ 12 min ;
  publié sur Azure le 17/11 à 21 h 20 avec la liste de la session « partitions » (4 771 images, 282 Mo au total, ?v=84) ;
  contrôle en ligne : images listées 200, non listées 404, laudes+vêpres 17/11 province-partitions sans image cassée.
- `outils/publier_azure.sh` : publie les JSON de `partitions/`, `corrections/` et **seulement les images de la liste** ;
  refuse si un .js/.json du site ou des partitions est plus récent que la liste (`--forcer` pour passer outre) ; sans
  liste, ancienne sélection. `pieces.json` publiés allégés (x0/y0/x1/y1, dedans, ecart_dessus retirés : non lus par le
  site). `--essai` : prépare sans envoyer. L'outil SWA est lancé depuis le dossier temporaire (il laissait des
  `.\…-app.zip` de 330 Mo à la racine ; ils sont dans `.gitignore`).
- Restent proposés (non faits) : charger `hg/offices.json` (6,8 Mo), `hg/index.json`, `bouchet.json` à la demande ;
  6 polices au lieu de 19 dans `COQUE` (sw.js) ; cache long des js/css versionnés ; README en retard (partitions publiées,
  partitions dans Word).
- 17/11/2026 (nuit) : **étape 2 faite** (accord de l'utilisateur). `api/` (racine du dépôt) = fonction Azure gérée, modèle
  function.json, Node 20, sans dépendance : POST (ouvert) / GET et PUT `?id&mois&traite` (en-tête `x-cle`). Table Azure
  appelée en REST signé SharedKeyLite. Azure : compte de stockage `breviairesignal6065` (francecentral, Standard_LRS,
  groupe `breviaire`), table `signalements` (PartitionKey = AAAA-MM, RowKey = id) ; réglages de la Static Web App
  `SIGNALEMENTS_STOCKAGE` (chaîne de connexion) et `SIGNALEMENTS_CLE` (= `.cle_signalements.txt`, gitignoré).
  `publier_azure.sh` copie `api/` et passe `--api-location`. Page `site/signalements.html` (clé gardée en localStorage),
  lien dans les réglages. En local, `serveur.py` sert aussi GET/PUT (sans clé ; traités → `signalements/traites.txt`).
  `outils/signalements.py --azure` (curl : le Python de python.org n'a pas les certificats). Contrôlé en ligne : envoi
  depuis le site → table → récupération ; 401 sans clé ; PUT ; essais effacés de la table. Claude n'a pas saisi la clé
  dans la page en ligne (site de production) : affichage de la liste avec clé non vu en ligne (vu en local).

### Répartition hebdomadaire du milieu du jour et des vigiles (gouzantine) — 17/11/2026

- Feuille imprimée reçue (photo) : `FEUILLE` dans `site/js/gouzes.js` (semaine du psautier 1-4 × jour). Milieu du jour :
  section du Ps 118 + psaume fixe du jour (33, 41, 42, 62, 80, 102), dimanche 117 ou 22-75, vendredi sem. III Ps 21,
  lundi sem. I 18B ; vigiles du lundi au samedi (le dimanche : pas de feuille → propres du temps ou AELF).
- Ordre : propres gouzantins du temps (Avent, Carême, Pâques…) d'abord, puis la feuille ; elle remplace l'ancien
  milieu du jour gouzantin du TO (`G/to/*/milieu`, une seule section du 118) et la psalmodie AELF des vigiles.
  Jamais aux fêtes/solennités, octaves, Triduum, Pentecôte (`feuilleAdmise`).
- Antiennes : milieu du jour = antienne de Gouzes de la section du 118 (tableau du TO) ; hors TO ou sans section,
  antienne du carnet du milieu du jour. **Vigiles : psaumes sans antienne** (la feuille n'en donne pas ; choix confirmé par l'utilisateur le 17/11/2026).
- Ps 9 grec = 9A + 9B en un seul psaume ; Ps 77 coupé 1-39 / 40-72.
- 17/11/2026 (soir) : publié sur Azure (relevé des images refait avant) ; vérifié en ligne : 15/06/2027 vigiles Ps 61-70-74, milieu Ps 118 XIII + 41.

### Hymnes d'un seul tenant, premières corrections — 17/11/2026 (nuit)

- Corrections de l'utilisateur (`partitions/corrections.json`) : to/p-078 (gravure) retirée ; to/s-093-1 → page 93 entière ;
  sb/vepres-2-018-1-12 (en fait l'antienne du Ps 61 du **mercredi**, rangée comme cantique NT11 du mardi : l'index Sainte-Baume
  est peut-être décalé ailleurs en semaine 2) → cantique Ap 4-5, pages 207-208 recadrées (`partitions/corrections/`).
- Demande : « pour les hymnes, une seule capture par page, moins serrée ». `outils/hymnes_pages.py [carnets]` fabrique pour
  chaque page des 7 carnets Perdrix et chaque suite de pièces k..m l'image `h-NNN-k-m.jpg` (marge 38 px, sans mordre sur
  les pièces voisines). `Partitions.figure(…, { role })` : rôles hymne et lucernaire → `dUnTenant()` remplace les morceaux
  consécutifs d'une même page par l'image h-. `placeur.grouper` (offices.js) réunit les pièces hymne/lucernaire consécutives
  de même titre. **Relancer `hymnes_pages.py` après tout nouveau découpage d'un carnet.** Contrôlé : 17/11-31/12/2026 et
  10/02-20/05/2027 (aucune image manquante, plus deux morceaux d'une même page).
- Répons de Gouzes écrits en version Province (`romaine-gouzes`, avec ou sans partitions) : `Gouzes.resoudre` pose
  `res.repons` (+ `reponsProvince`) aux laudes et vêpres hors fêtes (niveau ≤ 8 du sanctoral exclu) ; `offices.js` les met
  à la place du répons bref, celui de l'AELF replié dessous (« Ou bien : répons bref de l'AELF », masqué à l'impression).
  Texte du TO avec retours à la ligne : `sources_gouzes/Répons du temps ordinaire (8 semaines).txt` (envoyé par l'utilisateur)
  → `outils/repons_to_lignes.py` (appelé par construire_gouzes.py, ou seul pour corriger gouzes.json). Contrôlé : PDF A5 vêpres 18/11/2026.
- Suite (même soir) : « pas trop de découpage ». `dUnTenant` s'applique désormais à **toutes** les figures (morceaux
  consécutifs d'une même page → une image h-) ; `placeur.grouper` réunit les pièces successives de même rôle et même titre
  (sauf les antiennes, posées sous leur psaume). Pages en vis-à-vis du livret (PDF paire à gauche + impaire suivante, 2-3,
  4-5…) : `<div class="double-page">` côte à côte sur écran ≥ 760 px (fin d'office.css), l'une sous l'autre sur téléphone
  et à l'impression. Contrôlé : 29/11/2026-15/01/2027 (5 offices) et 08/02-30/06/2027 : aucune image manquante.
- Antiennes (règle de l'utilisateur, 17/11 nuit) : pages titrées « jour + semaine » (« Laudes - Mardi I ») coupées de haut en bas
  entre le titre et les étiquettes « Psaume … » (étiquettes exclues) : `outils/antiennes_pages.py` (lit le texte des PDF Perdrix
  dans le Drive) → `partitions/<carnet>/a-NNN-i.jpg` + `partitions/decoupes.json` {pages: remplace la liste de pieces.json de ces
  pages (ids de l'étiquette, cotes lues dans la zone), fichiers: anciennes s- → a-}. Chargé par `chargerDecoupes()` (partitions.js).
  190 pages (to 52, avent 30, careme 80, paques 28). **Relancer après tout nouveau découpage d'un carnet.**
- Cantiques du NT (rôle `cantique`) : pages deux par deux côte à côte quel que soit leur rang dans le livret (`figure`).

### Psautier AELF à inflexions pour la version « 100 % AELF » — 17/11/2026

- Demande : dans la version « 100 % AELF », remplacer les psaumes de l'AELF par ceux du « Psautier.doc » (Drive Liturgie,
  Couvent de Lille, même traduction), inflexions soulignées → **gras** (le souligné de l'AELF passe aussi en gras).
- Source copiée : `sources_aelf/Psautier-AELF.doc` ; `outils/construire_psautier_aelf.py` → `site/donnees/psautier_aelf.json`
  (même forme que psautier.json : 174 psaumes/parties, cantiques AT1-AT44 + AT9a/AT9b, NT1-NT12 **numérotation de ce fichier**,
  retrouvés par livre/chapitre/versets ; passages entre crochets écartés ; lignes « I », « II » = coupures de strophe).
- `textes.js` : `creerPsautier()` → `Psautier` (BJ) et `PsautierAELF` (chargé à la demande par `Offices.construire` en version aelf).
  `versetsAELF()` lit « R/ 6 », « (R/) 15 », « R/ 2 8 » ; `ajuster(sel, texteAELF)` règle les bords de la sélection sur le texte
  AELF (coupure au milieu d'un verset) et retire les passages absents de l'AELF (≥ 3 lignes). Cantiques filtrés par versets.
- `offices.js/psaumeAELF` : psautier à inflexions, sinon texte AELF avec `<u>` → `<b>`.
- Contrôles : `node tests/psautier_aelf.test.js` (242 références, 0 manque) ; comparaison mot à mot avec l'AELF sur 4 semaines
  (11/01-07/02/2027, 269 psaumes distincts) : restent les refrains doxologiques que l'AELF ajoute à certains cantiques NT
  (« À toi la gloire… »), le refrain facultatif du Ps 45 après v. 4, Ps 88-IV v. 20 (texte différent), Dn 3 « à toi la louange ».
  PDF A5 du 18/01/2027 regardé. Non publié sur Azure.

### Lien avec la Bible — 18/11/2026

- Bouton « ✠ Bible » (`#vers-bible`, styles en ligne, pas de changement de ?v) dans `.barre-droite` de `site/index.html` →
  https://kind-coast-01bef8e10.5.azurestaticapps.net (projet voisin `~/Downloads/interlin`, Static Web App `bible-dominicaine`,
  groupe `breviaire`, Standard, Central US, mot de passe provisoire dans `interlin/.mot_de_passe_site.txt`). Publiée par
  `interlin/publier_azure.sh`. La Bible a le bouton inverse (`interlin/liens.js`). Bréviaire republié le 18/11 avec ce bouton (et tous les changements en attente) ; vérifié en ligne.
- 18/11/2026 (suite) : barre du haut sur une seule ligne (logo, ‹ date ›, aujourd'hui, Bible, export PDF/Word, réglages) ;
  offices au milieu au-delà de 1100 px, en dessous sinon (grille, fin d'office.css, office.css?v=87). Icônes SVG en ligne
  (`.ico`) : calendrier (aujourd'hui, visible aussi sur téléphone), livre à croix rouge (Bible), document + flèche (export).
  Sur téléphone (≤ 760 px), icônes seules. Contrôlé à 360, 375, 900, 1280 px. Publié le 18/11, vérifié en ligne.

### Bible intégrée sous /bible/ — 18/11/2026

- Demande : intégrer la Bible dans ce dossier et dans le même site Azure, « bien cloisonné ». Le projet `~/Downloads/interlin`
  est **déplacé** dans `bible/` (son propre LISEZMOI.md ; ses programmes Python, sa page, ses données `bible/data/`
  gitignorées, ~195 Mo). Aucun fichier de la Bible dans `site/`.
- Pages renommées : `bible/index.html` = page téléphone (ex-lectio.html), `bible/interlineaire.html` = vue ordinateur.
- Données allégées (251 → ~195 Mo) : `compacter()` dans extract.py range définitions Strong et analyses développées une
  fois dans `data/mots.js` ; `remplir` (lectio.js) et le chargement d'app.js les remettent.
- Liens : `#vers-bible` → `bible/` ; `bible/liens.js` → `../` (ou le site en ligne si la Bible est servie seule, port 8790).
- `outils/serveur.py` sert `bible/` sous `/bible/` (sans .py/.sh/.md/.command/.txt) ; `site/sw.js` ne touche pas à `/bible/` ;
  `staticwebapp.config.json` : cache de `/bible/data/*` et `/bible/polices/*`, `.woff2`.
- `outils/publier_azure.sh` appelle `bible/preparer_site.sh "$DIST/bible"` (option `--sans-bible`). Total 475 Mo (garde-fou 490).
- Décision de l'utilisateur : un seul site, **tout public** (prévenu des droits BJ/VTB/interlinéaires). Site `bible-dominicaine`
  supprimé. Publié et vérifié en ligne le 18/11 (passage bréviaire → Bible → grec de Mt 5).
- 18/11/2026 (suite) : Bible — plan de lecture réduit à un lien discret « Plan de lecture proposé » en bas de l'accueil
  (carte ouverte à la demande, ×) ; étapes lectio/meditatio/oratio/contemplatio remplacées par deux onglets « Texte » et
  « Éclairages » (ids internes lectio/meditatio gardés ; anciennes adresses → Texte) ; oratio, contemplatio et minuteur supprimés ;
  « Lectio sur ce passage » → « Ce passage ». Plan déployé en petits caractères gris, sans cadre ; lectio.css/js?v=2. Vérifié en local. Non publié.
- 18/11/2026 (suite) : mots latins touchables (téléphone et vue ordinateur). Biblia n'a pas de dictionnaire latin :
  Collatinus (pycollatinus 0.1.6, GPL, dans bible/.venv-latin gitignoré ; une ligne corrigée pour Python 3.14) + sens
  français `bible/collatinus/lemmes.fr` (dépôt biblissima/collatinus). `bible/latin.py` → `bible/data/latin/` (~7 Mo :
  lemmes.js + une table par lettre). Fiche : lemmes (ceux qui ont un sens d'abord), sens, analyses, lien gaffiot.fr/#lemme.
  54 000 formes, 7 % non reconnues (noms propres). Total publié estimé ~482 Mo / 490. Non publié.
  Une autre session (« Bible chrétienne Jean-Nesmy ») modifie en parallèle lectio.js/css et index.html (data/bc).

### Entrepôt Azure pour les gros fichiers — 18/11/2026

- Demande : solution « entrepôt » pour sortir de la limite de 500 Mo. Compte de stockage `breviairefichiers` (francecentral,
  Standard_LRS, site web statique, conteneur `$web`, https://breviairefichiers.z28.web.core.windows.net/), CORS GET/HEAD/OPTIONS
  pour https://calm-flower-052e85c10.4.azurestaticapps.net et http://localhost:8765.
- Adresse portée par `<meta name="fichiers" content="">` (vide en local) dans site/index.html, bible/index.html,
  bible/interlineaire.html ; `publier_azure.sh` la remplit (bible : `…/bible/`). partitions.js (`FICHIERS`, image(), img()),
  latin.js (img), bible/lectio.js load(), bible/app.js loadScript() préfixent. books.js reste sur le site.
- Hors connexion : sw.js sert les images *.web.core.windows.net/partitions/… depuis la boîte IMAGES, rangées sous
  l'adresse du site (horsligne.js cleDe) → les partitions déjà enregistrées restent valables.
- `outils/entrepot.py` : envoi différentiel (MD5), retrait des fichiers disparus sous partitions/ et bible/data/ seulement
  (et seulement pour les dossiers présents dans l'envoi). publier_azure.sh : `--entrepot-seul`, `--garder-images`.
- Essai : site 19 Mo, entrepôt 7 419 fichiers / 452 Mo.
- Essai local (copie sans images ni données, adresse de l'entrepôt posée) : 6/6 partitions des vêpres du 29/11/2026, Bible Mt 5 (grec, Pères, vue ordinateur) lus depuis l'entrepôt. Bascule en ligne : pas encore faite (attend l'accord de l'utilisateur ; prévoir --garder-images la première fois).
- 18/11/2026 : bascule faite (--forcer --garder-images ; Bible chrétienne data/bc et data/bct incluses, accord explicite de l'utilisateur). Vérifié en ligne : 15/15 partitions des vêpres du 29/11 servies par l'entrepôt ; Bible Jn 1 (grec) lue depuis l'entrepôt. Prochaine publication : sans --garder-images (le site retombe à ~20 Mo). Hors connexion sur vrai téléphone : non vérifié.
- 18/11/2026 (suite, Bible) : titre de péricope (dernier titre de niveau ≥ 3) = lien `a.peri-l[data-lectio]` (chip « Ce passage » supprimé) ;
  accueil en trois catégories AT / Psaumes / NT (O.test "PS") ; Psaumes : choix « Psautier » (../donnees/psautier.json du
  bréviaire, route #/ps/<id>, numérotation liturgique, lien vers la BJ via hebreu()) ou « Bible de Jérusalem » (grille 1-150) ;
  synopse (viewSec/renderOnglet) : « Côte à côte » (toutes largeurs, colonnes défilantes sous 900 px) ou « Un Évangile »,
  + colonne/bloc « En regard » (O.synCols, O.synRegard). Vérifié en local (375 et 1280 px). Non publié.

### Office des lectures en version latin-français — 18/11/2026

- Demande : les Heures grégoriennes n'ont pas d'Office des lectures → « répartition AELF avec les psaumes en latin, latin d'un
  côté, traduction de l'autre ; AELF en français pour le reste ».
- `outils/construire_psautier_latin.py` → `site/donnees/psautier_latin.json` (Nova Vulgata, depuis `bible/data/PSA/*.js`, champ
  lat.NVU ; numérotation hébraïque ; titres et lettres de l'acrostiche retirés ; 18,2 retouché). 208 Ko, dans `COQUE` (sw.js).
- `offices.js` : `LATIN_LECT` (version latin + lectures) → construit comme « 100 % AELF » ; `psaume()` → `Latin.psaumeLectures`
  (latin.js) : une rangée par strophe AELF, à gauche les versets latins que la strophe porte (refrains R/ repris), à droite le texte
  AELF (inflexions en gras) ; Gloria bilingue ; Te Deum latin en regard (`Latin.teDeum`). Pas de lectionnaire Bouchet ici.
- Contrôle : PDF A5 du 01/11 et 19/11/2026 regardés ; 864 psaumes relevés de l'Office des lectures : tous trouvés (Ps 11,9 et
  43,27 fondus dans le verset précédent par la source). Latin sans accents (Nova Vulgata), contrairement aux Heures grégoriennes. Non publié.
- 18/11/2026 : publié (--forcer, sans --garder-images : le site ne contient plus les images, 19 Mo) avec les changements Bible (péricopes, Psaumes/Psautier, synopse) et ceux de la session « Psautier Office des lectures ». L'utilisateur a demandé d'arrêter la publication alors qu'elle venait de se terminer.
- 18/11/2026 (suite, Bible) : **Recherche** — `bible/recherche.py` → `bible/data/rech/` (46 Mo, ~3 000 fichiers : portées bj, notes,
  lat (+ lemmes Collatinus « @lemme »), peres, dico (+ titres « #mot » → fichiers ~x), bc ; index par 2 premières lettres,
  identifiants en écarts ; textes par livre / chapitre / section ; orig.js grec-hébreu → Strong). `bible/recherche.js` (+ .css) :
  route #/r/<requête>/<portée>, onglet « Recherche », lien à l'accueil ; ET des mots, préfixe dès 4 lettres, "expression",
  -exclusion, mot*, références (→ passage + articles citant le verset via data/dref), grec/hébreu/Strong (→ lexSheet).
  lectio.js expose `window.BibleApp` (route « r » ajoutée). Vérifié en local (375 px). Non publié.
- 18/11/2026 : recherche publiée (2e envoi : bible/preparer_site.sh ne copiait pas recherche.js/.css — liste corrigée). Vérifié en ligne : « pardon » → Bible 107, Notes 37, Pères 180, Dictionnaires 490, Bible chrétienne 89 ; index lus depuis l'entrepôt.

### Logo harpe — 18/11/2026

- La croix ✠ (logo de la barre et `site/icone.svg`) est remplacée par la harpe de la couverture du Psautier (photo envoyée par
  l'utilisateur, vectorisée avec potrace). Logo = SVG en ligne `svg.harpe` dans `.logo` (index.html, couleur `--rouge` via
  currentColor, styles en fin d'office.css, ?v=91) ; icône = même carré rouge #7a1f1f, harpe #fbf8f2 (`icone.svg?v=2`).
  Le lien « ✠ Bréviaire » de la Bible garde sa croix. Vérifié en local (1024 et 375 px). Publié le 18/11 (--forcer), vérifié en ligne.

### Oraisons des Heures grégoriennes, tierce/sexte/none — 18/11/2026

- Constat : le réglage « Oraison » ne jouait qu'aux féries du TO (laudes, milieu, vêpres), avec le tableau de
  `president.json` (oraisons du psautier seulement) ; au milieu du jour les deux textes étaient toujours les mêmes.
- `Latin.oraison(j, office, heure, {propreOP})` (latin.js) : cherche dans `partitions/hg/offices.json` (3 tomes).
  Saint (niveau ≤ 12 ; au milieu du jour ≤ 8, sinon férie) : intertitres « Le 14 décembre » suivis (`PAR_DATE` : la page
  D/MM-JJ commence souvent par l'oraison du saint précédent), date d'origine d'une fête déplacée (`cleSanctoral`), commun ;
  l'oraison doit **nommer** le saint (le livre suit le calendrier de Saint-Martin : saint Hubert le 3 nov.) ; fête propre OP
  seulement si le même saint est au romain (`Calendrier.romainDu`). Temps forts, dimanches, fêtes : oraison propre (celle des
  laudes au milieu du jour, comme l'AELF) avant le psautier ; féries du TO : psautier, par heure (champ `h`).
  Complies : 7 oraisons du tome I + « soir des solennités » (`oraisonsComplies`).
- `offices.js` : `oraisonGregorienne` / `oraisonAuChoix` partout (laudes, milieu, vêpres, complies AELF) ; `compliesOP` :
  HG en plus (ou en premier si réglage « gregoriennes »). `memeTexte` ignore la conclusion.
- Année 2026-11-29 → 2027-11-27 : oraison trouvée laudes 353/364, vêpres 356/364, milieu 362/364, complies 364/364
  (manques = saints absents du livre). Échantillon (1 jour sur 5) : choix proposé laudes 11/49, vêpres 17/49, milieu 3/49, complies 42/49.
- Milieu du jour : réglage `heure` (`#opt-heure`, `pref.heure`, URL `&heure=`) → `AELF.office(tierce|sexte|none)` ;
  `autresHeures()` : lectures + répons des deux autres heures en `details.autre-heure` (écran seulement). Latin : `heure` aussi.
- Contrôlé dans le navigateur de l'app (milieu 18/11 en none, complies Province). Publié le 18/11 (--forcer, office.css?v=92) ;
  vérifié en ligne : complies et vêpres du 18/11 avec « Ou bien : oraison des Heures grégoriennes », milieu en tierce + 2 autres heures.
- Icônes PNG (18/11) : `site/apple-touch-icon.png` (180 px, carré plein : l'iPhone arrondit lui-même et ignore le SVG),
  `icone-192.png`, `icone-512.png` (manifeste). Fabriquées depuis la harpe vectorisée (potrace -g puis Pillow, rendu ×4 réduit).

### Bénédiction de la table — 18/11/2026

- Étape 1 du `PLAN-PRIERES-ET-RITUEL.md` (plan accepté par l'utilisateur : bénédictions, De profundis/nécrologe,
  « Mon couvent », martyrologe, Compendium, rituel des malades et de la pénitence).
- Source : Drive LITURGIE/99-Divers/« Bénédictions repas province Toulouse BENEDICITE » → copiée dans `sources_table/`
  (la variante « -1 » est la version corrigée). `outils/construire_table.py` → `site/donnees/table.json`
  (texte tel quel ; colonnes « Dimanche : … » et « (x) » marial lues avec `pdftotext -layout`).
- Page à part `site/table.html` + `js/table.js` (`Table.pour(j, D)`, `Table.rendu`) + `css/table.css` ; n'utilise que
  `calendrier.js` (rien dans `Offices.construire`). Bouton `#vers-table` dans la barre d'index.html ; office.css :
  barre resserrée ≤ 420 px (sinon débordement de 13 px à 375 px). Fichiers ajoutés à `COQUE` (sw.js).
- Formule de midi = n° de la semaine du psautier (**confirmé par l'utilisateur le 18/11/2026**).
- **Hypothèses à confirmer par l'utilisateur** : mémoires facultatives
  reconnues seulement un jour de férie ; martyrs dès la mémoire obligatoire ; propres seulement à midi (le livret les
  met sous « Midi ») ; Noces de Cana = 2e dimanche TO année C (comme le carnet de Noël).
- Fautes de la source laissées telles quelles : « Loué sus-tu » (Pentecôte), « Bénis sois-tu » (plusieurs),
  « qui a visité » (Samedi saint), « siècles de siècles » (Avent), « bénis-nous , » ; à corriger avec son accord.
- Test : `node tests/table.test.js` (2024-2044, avec et sans propre OP). Contrôlé : écran 1280/375/360 px, PDF A5 de Noël.
  Non publié sur Azure.

### Martyrologe et nécrologe — 18/11/2026

- Sources reçues (copiées dans `sources_martyrologe/`) : « Martyrologe romain 2014-2015 (1).docm » (= `romain-2014.docm`,
  en fait l'édition Rangueil 2015, avec les anniversaires de l'archevêque de Toulouse), « Martyrologe romain 2020 MARSEILLE.pdf »,
  « Martyrologe romain 2020 RANGUEIL CORR DONNEAUD.docm », et l'extrait du Catalogus 2026 « Mémoire de nos frères défunts ».
  Consigne de l'utilisateur : frères défunts en liste selon le jour, ceux du 29 février « le jour précédent » (le catalogue,
  lui, dit le 1er mars : la consigne de l'utilisateur est suivie).
- `outils/construire_martyrologe.py` → `site/donnees/martyrologe.json` ({editions, intro, jours[ed][MM-JJ] = html réduit
  b/sup/br, mobiles[ed][clé], remarques}) et `necrologe.json` ({jours, sansJour, notes}). Word : textutil → html ;
  PDF de Marseille : pdftohtml -xml (gras, retours à la ligne des vers courts). Retouches de Marseille (`retoucher_marseille`) :
  page du 24-25 mars illisible (25 mars repris de Toulouse), titre « 22 septembre » absent, paragraphes coupés par les pages
  recollés, proclamation de Noël et fêtes mobiles en vers reprises de Toulouse quand les mots sont les mêmes, Baptême collé
  à l'Épiphanie. Source Word : « 7 août » écrit pour « 7 septembre » (corrigé par l'ordre des dates).
- `site/js/martyrologe.js` (`Martyrologe.pour/rendu`), page `site/martyrologe.html` (préférence `pref.martyrologe`, défaut
  « romain » ; `pref.martyrologeLecture` = "jour" | "veille", demandé par l'utilisateur : « certains la veille, d'autres le jour
  même » ; la veille, éloges, fête mobile, conclusion pascale et frères défunts sont ceux du lendemain). Onglets communs « À table · Martyrologe » (`.pages-annexes`, css/table.css) ; bouton d'index renommé
  « Recueils » (`#vers-table`). sw.js : 4 fichiers ajoutés à `COQUE` (martyrologe.json ≈ 1,2 Mo).
- Non repris : les réponses chantées « Tous les frères répondent : » (absentes des sources : sans doute des partitions) ;
  « Mémoire de la bienheureuse Vierge Marie (souvent le samedi) » n'est jamais affichée (quel samedi ?).
- Test : `node tests/martyrologe.test.js`. Contrôlé : écran 1280/375 px, PDF du 28/02/2027. Non publié sur Azure.

### Prières et formules du Compendium — 18/11/2026

- Demande : « la partie sur les formules catéchétiques et les prières », bien organisée, « le français en parallèle du latin »,
  source : vatican.va archive_2005_compendium-ccc_fr.html (copiée dans `sources_compendium/compendium-fr.html`, iso-8859-1).
- `outils/construire_prieres.py` → `site/donnees/prieres.json` {source, droits, groupes[{id, titre, intro?, formules?, pieces[{id, titre,
  titreLatin?, fr: [[lignes]], la?, ref?, note?, prose?, temps?/hors?, rosaire?, laSource?}]}]}. Appariement FR/LA explicite (titres de
  l'appendice, 1re occurrence = français pour les titres en double). Notre Père coupé en 9 propositions (`coupe`), Credo et actes en prose.
  Dix commandements : formule catéchétique reconstituée (le tableau à 3 colonnes est aplati dans la page). Latin de Mt 5/7/22 : Nova
  Vulgata (`bible/data/MAT`). Source : n° 6 des fruits absent (signalé), accents « æ´ » → « ǽ ».
- `site/js/prieres.js` + `site/prieres.html` (3e onglet des Recueils, `pref.prieresLangue`), styles en fin de `css/table.css`.
  sw.js : 3 fichiers ajoutés à `COQUE`. Test : `node tests/prieres.test.js`. Contrôlé : écran 800/375 px, recherche, PDF.
- Droits : texte du Compendium © Libreria Editrice Vaticana ; à signaler avant toute publication. Non publié sur Azure.
- 18/11/2026 (soir) : **publié sur Azure** à la demande de l'utilisateur (bénédictions de table, martyrologe, nécrologe, prières),
  après un nouveau relevé des images (4 776, 0 erreur). Vérifié en ligne : bouton « Recueils » → À table → Martyrologe → Prières
  → « ‹ Offices » (même date), données chargées.

### Barre des menus, Bibliothèque, Messe, unification, effet de flou — 18-19/11/2026

- **Barre des menus** commune `site/js/menu.js` + `site/css/menu.css` : Office · Messe · Bible · Bibliothèque (marque « Bréviaire
  dominicain » à gauche sur ordinateur ; quatre cases icône + nom sur téléphone). Incluse **juste après `<body>`** sur toutes les pages
  (y compris `bible/index.html` et `bible/interlineaire.html` par `../js/menu.js`) pour ne pas décaler la page. Elle masque dans
  l'index `#vers-bible`, `#vers-table`, le logo ; dans la Bible `#vers-breviaire`. Pas de « Réglages » dans le menu (demande de
  l'utilisateur) : bouton `#ouvrir-reglages` (icône + « Réglages ») à droite de « PDF / Word » dans la barre des offices.
  `./?reglages=1` ouvre encore les réglages des offices.
- **Bibliothèque** : `bibliotheque.html` (rayons avec aperçu du jour, barre de date), onglets communs `js/bibliotheque.js`
  (`Bibliotheque.onglets/PAGES/preferences`) : Bénédicité (`table.html`, renommé), Prières, Martyrologe, Frères défunts
  (`defunts.html` + `js/defunts.js` : mémoire du jour, De profundis = Ps 129 du psautier BJ sans le gras des inflexions + Nova
  Vulgata Ps 130, Repos éternel du Compendium, nécrologe entier par mois avec recherche).
- **Messe** : `messe.html` + `js/messe.js` + `css/messe.css`. Lectures et psaume : AELF (`AELF.brut("messes", date)`, même cache que
  les offices ; date non publiée → `AELF.equivalents(date, true)`). Propres : `outils/construire_missel.py` → `site/donnees/missel.json`
  (178 jours, temporal seul) depuis `sources_missel/MR Temporal 0x….docx` (textutil html : gras = texte dit, rouge = consignes,
  lettrines ≥ 30 px ; coquilles de la source gérées : « DOUVERTURE », « RIÈRE », « CO MMUNION », titre collé). `Messe.cle(j)` :
  avent-S-J / avent-12-JJ, clés de Noël, noel-ferie-J (janvier), careme-S-J, paques-S-J, ascension, trinite…, ordinaire-N (messe
  de la semaine). Toute l'année 2026-2027 a ses propres, sauf le Samedi saint. Messes multiples (Noël, Pâques, Ascension, Jeudi
  saint…) en onglets ; jour de saint : avertissement (sanctoral non fourni), textes de la férie. Signes de chant * + / en rouge.
- **Unification** (fin de `css/table.css`) : pages de la bibliothèque avec la même barre en grille qu'office.css, mêmes boutons à
  icône (Aujourd'hui, Imprimer), en-tête comme `.entete-office` (filet de couleur liturgique, date en petites capitales, titre rouge 1,9 em).
- **Effet de flou** (enquête) : en ligne, polices, CSS et JS n'étaient gardés que 30 s (`max-age=30, must-revalidate`) et le service
  worker allait d'abord au réseau (jusqu'à 4 s) : à chaque changement de section, les 19 polices étaient redemandées, le texte
  s'affichait en police de secours puis « sautait » sur Kepler (`font-display: swap`). Corrigé : `sw.js` `gardeDAbord()` pour les
  `.woff2` et toute adresse avec `?v=` (clé = adresse complète, version comprise) ; `staticwebapp.config.json` : `/polices/*` un an,
  `immutable`. **Conséquence : toute modification d'un .js/.css doit changer son `?v=N`**, sinon l'ancienne version reste servie.
  Le menu inséré en bas de page faisait aussi descendre la page : il est désormais en tête.
- Calendrier : corrigé un défaut (féries de l'Avent tombant fin novembre prises pour les féries du 17-24 décembre : nom
  « 30 décembre (férie de l'Avent) » et niveau 9). Tests verts.
- Contrôlé en local (serveur `outils/serveur.py 8781`, celui du port 8765 ne sert pas `/bible/`) : ordinateur 800 px et téléphone 375 px,
  offices, messe (Noël, Christ-Roi, saint, Carême, Pâques, date non publiée), bibliothèque, Bible. Effet de flou : cause et correction
  non vérifiées en ligne (le navigateur de l'app n'a pas de service worker). **Non publié.**

### Prières en bibliothèque, chants de Bordeaux aux complies — 19/11/2026

- Demande : « que la section prière fasse plus bibliothèque, sans proposer quelque chose pour un jour précis ». `js/prieres.js` réécrit :
  `sommaire(D)` (table des matières, chapitres I-VI), `chapitre(D, id, langue)`, `piece(D, id, langue)` (fil d'Ariane, précédent /
  suivant), `resultats()` pour la recherche. Adresses : `prieres.html` / `#chapitre/<id>` / `#<id>`. Plus d'encadré « Aujourd'hui »,
  de badge « de saison » ni de mystères du jour ; la page ne charge plus le calendrier ; les onglets n'y mettent pas de date.
- Demande : « il manque les partitions des complies (grégoriennes, Bordeaux) ». Constat : elles n'étaient branchées que dans les versions
  Province et Gouzantine (`compliesOP`, hors romaine). Ajouté : `choixBordeaux(j, options)` (offices.js, choix de l'hymne, du répons,
  de l'antienne et des psaumes — désormais utilisé aussi par `compliesOP`) et `chantsBordeaux(j, options)` : section repliée en fin de
  complies, versions romaine et latin-français (hors Triduum), par l'enveloppe `construire()` → `construireOffice()`. Contrôlé sur
  13 dates (Avent, Noël, Carême, Pâques, Pentecôte, Assomption, TO) en Province et en romaine. Images déjà dans la liste publiée.
- 19/11/2026 : **publié sur Azure** (demande de l'utilisateur), après un nouveau relevé des images (4 776, 0 erreur). Vérifié en ligne : menu
  Office · Messe · Bible · Bibliothèque, ⚙ Réglages après « PDF / Word », Messe du 19/11, Prières (table des matières), complies
  (romaine : 12 chants de Bordeaux ; Province : 13 partitions, images servies par l'entrepôt), polices `max-age=31536000, immutable`.
  Disparition du « flou » sur un vrai téléphone : à confirmer par l'utilisateur (le navigateur de l'app n'a pas de service worker).

### Messe : sanctoral et choix de la messe ; bouton Office — 19/11/2026

- Bouton « Office » du menu : son lien était vide hors de l'index (`racine` = "") → il restait sur la page (Messe, Bibliothèque).
  Corrigé : `accueil = racine || "./"` (menu.js?v=5).
- Sanctoral du Missel reçu : `sources_missel/sanctoral/` (MR Sanctoral 01-12 .docx, Propre de France.docx). `construire_missel.py` :
  `extraire_sanctoral()` → `missel.json > saints["MM-JJ"] = [{titre, rang, notice, commun, source (romain|France), messes:[…]}]`
  (228 saints, 202 dates ; titres en capitales remis en casse par `casse()`). Absents des fichiers : 5 oct. (Faustine), 11 oct. (Jean XXIII),
  22 oct. (Jean-Paul II).
- `Messe.options(j, missel)` : messes du saint (Missel, cette date) + messe de la férie si le jour l'admet ; pas de saint un dimanche,
  une solennité ou un jour privilégié du temporal (niveau < 9). Défaut : le saint du calendrier (rapprochement des noms), sinon la férie.
  Menu « Messe : » dans l'en-tête (`select[data-choix-messe]`, retenu dans `pref.messeChoix[date]`), comme le choix d'office.
  Pièces absentes du propre du saint (mémoires : souvent la seule prière) : prises à la férie, marquées « De la férie », avec la phrase
  « Le Missel renvoie au commun … » (communs non fournis). Plusieurs messes au Missel (2 novembre) : onglets du Missel.
- Testé : toute l'année 2026-2027, chaque choix possible, sans erreur ; navigateur : 21/11 (mémoire ↔ férie), bouton Office. Non publié.
- Communs (« 03 Communs/MR Communs.docx » → `sources_missel/communs/`) : `extraire_communs()` → `missel.json > communs` = 60 formulaires
  {commun, partie (I., II. : temps), cas (A., B.), num, messe}. `Messe.commun(saint, j, missel)` : 1re alternative de l'indication du saint
  (« Commun des martyrs : pour une vierge martyre, ou … »), rapprochement des mots (Vierge/Marie comptent), temps pascal / Avent / Noël,
  premier formulaire. Ordre : propre du saint → commun (« Du commun ») → férie (« De la férie »). Testé : 118 indications de commun sur
  l'année, toutes trouvées.
- Ordinaire (« missel-romain-nouvelle-traduction…pourmalvoyant.docx » → `sources_missel/ordinaire/`) : `extraire_ordinaire()` → Gloria et
  Credo (français, latin replié). `Messe.gloriaCredo(j, saint, duCalendrier)` : Gloria dimanches hors Avent/Carême, solennités, fêtes,
  octaves, Jeudi saint ; Credo dimanches et solennités (pas les jours d'octave) ; rien aux défunts ; rang du calendrier quand le saint
  choisi est la célébration du jour (fêtes OP : S. Thomas d'Aquin = fête). Insertion : Gloria avant la prière, Credo après l'évangile.
- Non intégré (vu dans le dossier) : livrets du Triduum (office de la Passion : le Vendredi saint n'a que sa prière dans le temporal), PGMR,
  mélodies, prières eucharistiques, préfaces.
- 19/11/2026 : **publié** (`--forcer` : depuis le dernier relevé des images, seuls messe.js, menu.js, missel.json ont changé). Vérifié en ligne.
- Triduum (demande du 19/11/2026) : livrets « Missel et lectionnaire » (Cène, Passion, Vigile pascale) et fascicules « La Passion »
  (Mt/Jn, Mc/Lc) → `sources_missel/triduum/`. `blocs_livret()` (construire_missel.py) : sections = paragraphes gras numérotés
  « N.<tab>Titre<tab>réf » dont le n° croît (sinon : numérotation interne, ex. acclamations du cierge) ; consignes = paragraphes
  numérotés non gras, rouges, ou phrases descriptives (`CONSIGNE`) ; rôles de la Passion (L, D, F, A ; ✠ = paroles de Jésus après
  « L. … : ») ; notes générales du début repliées. `missel.json > livrets {cene, passion, vigile}`, `passions {A, B, C}`.
  messe.js : messe AELF nommée Cène / Passion du Seigneur / Veillée pascale → le livret entier (`livret()`), sommaire par sections ;
  Rameaux (« Messe de la Passion ») : Passion à plusieurs voix de l'année, repliée après l'évangile. `Messe.joli()` : noms AELF
  sans capitales. Vérifié dans le navigateur (3-5 avril 2026, 29 mars 2026), année entière sans erreur. Non publié.
- 19/11/2026 : Triduum **publié** (--forcer : seuls messe.js, missel.json, messe.html changés depuis le relevé des images). Constat : le site
  demande désormais le **mot de passe** (basicAuth rétabli par l'utilisateur) ; Claude n'y saisit rien : contrôle en ligne des pages
  du Triduum laissé à l'utilisateur (vérifiées en local).
- 19/11/2026 : iPhone (site ouvert depuis l'écran d'accueil) : le haut de la page passait sous la barre d'état. Toutes les pages :
  `viewport-fit=cover`, `apple-mobile-web-app-capable`, `…-status-bar-style default` ; menu.css : marge haute = `env(safe-area-inset-top)`
  + 6 px (+ 12 px en `display-mode: standalone`), barres collantes (`.barre`, `#top` de la Bible) arrêtées sous la barre d'état, bande de
  fond fixe sous la barre d'état (`body::before`). Non vérifiable sans iPhone (l'émulation n'a pas d'encoche) : à confirmer par l'utilisateur.
  Publié le 19/11/2026 (--forcer : seuls des .html et menu.css changés).

### Mot de passe du site, entrepôt privé — 18/11/2026

- Mot de passe : la protection ne couvrait que les environnements intermédiaires (`applicableEnvironmentsMode`
  StagingEnvironments). L'utilisateur l'a passée lui-même dans le portail à « production et intermédiaires »
  (AllEnvironments) ; vérifié : toute adresse du site → 302 vers `/.auth/basicAuth/login`. Claude ne connaît pas le mot de passe.
- Entrepôt rendu **privé** (choix de l'utilisateur) : lecture par `https://breviairefichiers.blob.core.windows.net/$web/`
  + clé SAS liée à une règle d'accès du conteneur (`lecture-N`, lecture seule, expiration dans la règle) :
  `outils/cle_entrepot.py` (prolonge de 10 ans — demande de l'utilisateur : rien à refaire — et affiche ; `--lire` ; `--nouvelle` = révocation). La clé ne change pas
  quand on prolonge (cache des images gardé). `publier_azure.sh` remplit `<meta name="fichiers">` et
  `<meta name="fichiers-cle">` (site/index.html, bible/index.html, bible/interlineaire.html) ; clé jamais dans git.
- Code : `entrepot(chemin)` dans partitions.js (exposé `Partitions.entrepot`, utilisé par latin.js), bible/app.js,
  bible/lectio.js. Service workers et horsligne.js : hôtes `*.web.core.windows.net` ou `*.blob.core.windows.net`,
  `/$web` retiré de la clé de rangement → partitions déjà enregistrées hors connexion toujours valables.
- « Site web statique » du compte de stockage désactivé (sinon `…z28.web.core.windows.net` restait public). Ne pas réactiver.
- Contrôlé en local (copie d'essai liée à l'entrepôt) : 40/40 partitions Province, 7/7 latin, Bible (texte, recherche,
  interlinéaire). Export Word et hors connexion : à contrôler en ligne (CORS limité à l'adresse du site et à localhost:8765).

### Milieu du jour : trois capitules et trois oraisons — 18/11/2026

- Demande : « les 3 capitules pour tierce, sexte et none », puis « de même pour les oraisons ».
- `offices.js` : `troisHeures()` (remplace `autresHeures`, l'ancienne section repliée non imprimée) → bloc « Parole de Dieu »
  `.trois-heures` avec `section.capitule-heure` + `h4.intitule-heure` (Tierce, Sexte, None), lecture AELF de chaque heure
  (texte BJ), répons bref de chaque heure seulement sans verset du carnet ; plus de bloc « Répons » séparé dans ce cas.
  `oraisonsTroisHeures()` : `oraisonContenu()` (ex-corps d'`oraisonAuChoix`, HG de l'heure via `options.heure`) pour chaque
  heure ; une seule oraison si les trois sont les mêmes (`memeTexte`, fêtes). Écran, PDF et Word (h4 rouge gras).
- `latin.js` : `parHeure(t)` (éléments marqués `h`, ou 3 non marqués = tierce/sexte/none) pour `lecture` et `oraison`.
  Les Heures grégoriennes donnent 3 capitules pour 232 des 277 offices du milieu du jour (pas un seul comme on le croyait).
- Le réglage `heure` garde l'hymne, le titre et le répons du carnet. Contrôlé : 19/01/2027 (5 versions), Noël, Pâques,
  Christ-Roi ; PDF A5 Province regardé. Non publié.
- 19/11/2026 : bouton des réglages des offices remis à l'ancien visuel (`bouton icone` « ⚙ »). Même barre partout : à droite,
  le bouton d'export/impression (même icône document + flèche) puis ⚙ ; sur Messe et Bibliothèque, `#reglages-lien` (menu.js) ouvre
  les réglages des offices (`./?reglages=1`) ; dans la Bible, ses boutons `#top .icon` (‹ et ⚙ de la Bible) ont la forme des boutons
  du site (menu.css). `.barre-droite` collée au bord droit. Vérifié à 375 px sur les 5 pages. Non publié.
  Publié le 19/11/2026 (--forcer : seuls des .html, menu.js et menu.css changés).

### Messe : export, rubriques, boutons — 19/11/2026

- Boutons : plus de ⚙ sur la Messe ni dans la Bibliothèque (demande de l'utilisateur) ; ⚙ de la Bible = exactement `.bouton.icone` des offices
  (menu.css, caractère « ⚙ » posé par menu.js).
- Export de la messe : bouton « PDF / Word » (même icône que les offices) → `dialog#export` (période, A5/A4, nouvelle page par messe,
  avec ou sans rubriques, PDF ou Word). `produire()` dans messe.html : toutes les messes de chaque jour, choix saint/férie repris,
  rubriques longues dépliées ; PDF = page de titre « Ordre des Prêcheurs / Missel romain / période », titre courant « Missel romain —
  période », n° de page (même gabarit qu'impression.css) ; Word = `Docx.creer` (docx.js). Adresse d'essai :
  `messe.html?imprimer=AAAA-MM-JJ..AAAA-MM-JJ&format=A5[&sortie=docx][&rubriques=0]&apercu`. Contrôlé : PDF A5 (21-22/11/2026), .docx (24-25/12) XML valide ; non ouvert dans Word.
- Rubriques (« ça fait un peu fourre-tout ») : trois niveaux. Ce qu'on dit : noir. Ce qu'on fait : rouge, petit, italique, rubriques
  consécutives groupées sous un filet rouge (`div.rubriques`), les longues (> 260 car.) repliées sur leur 1re phrase, « Ou bien » en
  séparateur centré. D'où vient le texte : à droite du titre de section (`h3 .meta` : référence, « du commun », « de la férie »),
  avertissements en « Notes » de fin (`aside.notes-messe`), notice du saint repliée. Livrets : titres de tête redondants supprimés,
  parties (« Rites initiaux », « Liturgie de la Parole »…) en intertitres centrés (`h4.partie`). Seulement dans la Messe (offices inchangés).
- Non publié.
- Bouton d'export de la Messe (et « Imprimer » de la Bibliothèque) au même endroit que « PDF / Word » des offices : cale invisible de la taille du ⚙ (`span.bouton.icone.cale`, menu.css). Vérifié : même position au pixel près, 375 px et ordinateur.
  Publié le 19/11/2026 (--forcer : messe.js/css, menu.css, .html changés ; offices et partitions intacts).

### Connexion par identifiant et mot de passe — 19/11/2026

- Demande : remplacer le mot de passe commun par un identifiant + mot de passe par frère, « une seule fois par appareil »,
  sans compte Microsoft (les frères n'en ont pas tous) ; Salesforce écarté (licences payantes, deux services à relier).
  Plan pour l'utilisateur : `PLAN-CONNEXION.md`.
- `api/connexion/index.js` (route `connexion/{*chemin}`) = fournisseur OpenID Connect maison : Azure SWA (Standard, « custom
  OIDC provider » `breviaire`) garde la porte (`/*` → authenticated), ce service dit qui est qui. Page de connexion servie par
  la fonction (autonome : seuls /icone.svg et les icônes sont ouverts). Témoin d'appareil `breviaire-compte` 1 an (Path=/api/connexion),
  renouvelé à chaque reconnexion silencieuse ; codes et témoins signés HMAC, id_token RS256 ; mots de passe scrypt ;
  5 erreurs → 15 min de blocage ; `version` du compte incrémentée (nouveau mot de passe, désactivation) = appareils oubliés.
  Comptes : table `comptes` du stockage des signalements (`SIGNALEMENTS_STOCKAGE`).
- `site/comptes.html` (clé `CONNEXION_ADMIN_CLE`, copie locale `.cle_comptes.txt`) ; lien dans les réglages ; « Connecté : … ·
  Se déconnecter » affiché par un petit script en fin d'index.html d'après `/.auth/me` (rien sans connexion par compte).
- `site/sw.js` ne touche plus à `/api/`. `outils/connexion_azure.json` + `publier_azure.sh --connexion` (routes ouvertes d'abord,
  `authenticated` ajouté aux routes existantes — la 1re route qui correspond l'emporte —, `/*` fermé, 401 → /.auth/login/breviaire).
  `outils/preparer_connexion.sh` : secrets dans `.secrets_connexion/` (gitignoré) + réglages Azure.
- Tests : `node tests/connexion.test.js` (17 essais, joue Azure et le navigateur) ; essai visuel `node outils/essai_connexion.js`
  (port 8791, clé essai-local-1234). Contrôlé : page de connexion à 375 px, page Comptes, connexion puis reconnexion silencieuse.
- Inscription par la personne elle-même (demande du 19/11) : `action=inscrire` dans `authorize`, lien « Créer mon compte » ;
  réglage `GET/PUT /api/connexion/inscription` {mode: fermee|libre|code, code}, rangé dans la table comme ligne `-inscription`
  (filtrée de la liste) ; comptes marqués `origine: "inscription"`. Choix de l'utilisateur : **libres au lancement** (seuls des
  proches des frères ont l'adresse), **avec code ensuite**. Identifiant proposé « prénom.nom » (ce ne sont pas que des frères).
  Le petit script de la page est dans un gabarit `…` : barres obliques inverses doublées, pas d'accent grave dans les commentaires.
- **Non vérifié** : qu'Azure accepte ce fournisseur (pas d'essai sur Azure) ; durée de la session Azure ; iPhone écran d'accueil.
  Étape suivante proposée : Static Web App d'essai séparée (le mot de passe actuel couvre aussi les environnements d'essai du site).
- **Service logé À PART** (19/11) : dans le site qu'il protège, Azure tournait en rond (environnement d'essai figé, même
  /icone.svg ne répondait plus) — pour servir une page il lit la description du fournisseur… dans ce même site. Site Azure
  `breviaire-connexion` (offre gratuite, https://mango-bay-05d40a610.4.azurestaticapps.net) : api/connexion + comptes.html
  (sans polices Kepler) + icône ; publié par `outils/publier_connexion.sh`. `CONNEXION_SITES` = sites autorisés (retour et
  déconnexion `?retour=`). Le bréviaire ne publie plus api/connexion ni comptes.html ; `<meta name="connexion">` (index.html)
  porte l'adresse du service. `preparer_connexion.sh` règle les deux sites (`AZURE_SWA_ENV=essai` pour un essai).
- **Entrepôt** : plus de clé dans les pages avec `--connexion`. `api/fichiers` (route fichiers/cle.js, réservée aux connectés,
  vérifie aussi `x-ms-client-principal`) signe une clé de lecture (SAS service, conteneur $web, `ENTREPOT_STOCKAGE`), même clé
  pour tous pendant 15 jours, valable 30-45 jours. `site/js/cle-fichiers.js` (avant partitions.js, bible/app.js, bible/lectio.js)
  la garde en localStorage et la renouvelle en arrière-plan ; `window.CLE_FICHIERS`. Après la bascule :
  `python3 outils/cle_entrepot.py --revoquer` coupe l'ancienne clé longue (une publication sans --connexion en recrée une).
- Essai Azure (19/11) : environnement `essai` du bréviaire (https://calm-flower-052e85c10-essai.centralus.4.azurestaticapps.net) :
  toutes les adresses (pages, données, polices, Bible, /api/*, /.auth/login/github|aad) → 302 vers la connexion ; manifeste 200 ;
  chemin complet jusqu'à notre page de connexion vérifié. Inscriptions mises en mode **libre**. Connexion complète (échange du
  code) : à faire par l'utilisateur (Claude ne se connecte pas sur un site hébergé). Nom de domaine en attente
  « praedicatio.onmicrosoft.com » supprimé. Ne pas multiplier les requêtes vers Azure (demande de l'utilisateur).
- Mots de passe (19/11, demande de l'utilisateur) : **aucune contrainte**, au moins un caractère (200 au plus) ; la protection
  contre qui devine = blocage 5 erreurs / 15 min. Bouton facultatif « Me proposer un mot de passe » (4 mots latins + nombre,
  `MOTS_LATINS` dans api/connexion, même liste dans comptes.html). Service republié.
- **Basculé en ligne le 19/11/2026** après l'essai réussi de l'utilisateur (inscription + connexion sur l'environnement d'essai) :
  `preparer_connexion.sh` puis `publier_azure.sh --connexion --forcer`. Vérifié : toutes les adresses → connexion (manifeste
  seul ouvert), parcours jusqu'à la page du service. Ancienne clé longue de l'entrepôt révoquée (`--revoquer` : lecture-1
  supprimée, 403 vérifié ; clé courte 200). Environnement `essai` supprimé. Mot de passe commun Azure : désactivé (inutile).
  **Toute publication suivante doit garder `--connexion`** (sinon le site s'ouvre à tous et une clé longue est recréée).
  Le service se republie seul avec `outils/publier_connexion.sh`. Inscriptions : mode libre.
- **Rôles** (19/11, demande de l'utilisateur, deux rôles distincts) : « signalements » (voit les signalements reçus) et
  « comptes » (gère comptes et inscriptions). Champ `roles` du compte (cases dans comptes.html) → claim `breviaire_roles` de
  l'attestation → `api/roles` (rolesSource d'Azure, dans connexion_azure.json) → règles `routesRoles` : signalements.html et
  GET/PUT /api/signalements réservés au rôle (POST ouvert à tout connecté). api/signalements accepte le rôle à la place de la clé ;
  le service de connexion accepte, pour la gestion, le témoin d'appareil d'une personne qui a le rôle « comptes » (clé en secours).
  Liens des réglages visibles selon `/.auth/me` (tous en local). Rôle pris en compte côté Azure à la connexion suivante.
  `wandrille` a les deux rôles. Publié (service + bréviaire). Vérifié par l'utilisateur (19/11) : après déconnexion/reconnexion,
  les deux liens apparaissent et les deux pages s'ouvrent sans clé (Azure appelle bien api/roles).

### Audit de sécurité, pied de page des droits — 19/11/2026

- Rapport : `AUDIT-SECURITE-2026-11-19.md` (section 0 = décisions de l'utilisateur). Risques **acceptés** : inscription libre au
  lancement, mots de passe libres, appareils connectés sans fin, clé de l'entrepôt commune, copies gardées après déconnexion ;
  passkeys écartées. Priorité de l'utilisateur : protéger le compte Azure (double authentification, sauvegarde des secrets).
- `staticwebapp.config.json` : `X-Frame-Options: DENY` et `Permissions-Policy` (caméra, micro, position, paiement, USB) ajoutés.
  Pas de CSP (risque de casse jugé supérieur au gain).
- Pied de page commun « Sources et droits » posé par `menu.js` (liste `SOURCES`, repliable) sur toutes les pages, Bible comprise ;
  l'ancien `footer.pied` d'index.html est supprimé ; masqué à l'impression. menu.js?v=8, menu.css?v=9. Vérifié en local
  (offices 1024 px, Bible et Messe 375 px). Publié le 19/11 (--forcer) ; les deux en-têtes vérifiés en ligne.
- Azure (19/11/2026) : budget `alerte-mensuelle` (30 €/mois, courriels au compte praedicatio à 80 %/100 % réels et 100 % prévu) ;
  verrou `protection-breviaire` (CanNotDelete) sur le groupe `breviaire` : **le retirer avant de supprimer quoi que ce soit**
  (ressource, environnement d'essai d'une Static Web App) : `az lock delete --name protection-breviaire -g breviaire`.
- Indexation (19/11/2026) : `robots.txt`, `X-Robots-Tag` (site et service) et balise meta noindex sur toutes les pages ;
  ajoutée aux deux pages de la Bible, et `X-Robots-Tag` aux réponses de `api/connexion` (tests verts). Publié le 19/11, vérifié en ligne.

### Sources LilyPond des partitions gouzantines — 19/11/2026 (essai)

- Reçu : `~/Downloads/Partitions gouzantines` (sources LilyPond de fr. Matthieu) et Drive LITURGIE/03-Gouzes/GOUZES LIVRETS
  ORIGINAUX (35 livrets scannés, 600 dpi, sans texte). Inventaire et plan : `PLAN-PARTITIONS-LILYPOND.md`.
- Copie : `sources_gouzes/lilypond/` (liens Linux rétablis en vrais liens : même pièce sous plusieurs cotes).
  LilyPond 2.26 (Homebrew). `outils/graver_lilypond.py [mots…] [--sortie D]` → par défaut `partitions/ly/` + `rapport.json`.
- Gravure : `python3 outils/graver_lilypond.py` (seulement ce qui a changé ; `--tout`, `--index`, ou des mots du nom de fichier)
  → `partitions/ly/<nom-ascii>.png` (200 dpi, gris, `pngquant 16` : ~30 Ko par antienne ; le JPEG pesait 8 fois plus),
  `pieces.json` (interne, non publié), `index.json` (publié), `rapport.md`. 1 014/1 041 gravées.
  Inclusions d'office (`vowel-set.ly`, `TonsDef.ly`, `TonsRDef.ly`) **seulement si la pièce ne les inclut pas** : une double
  inclusion de vowel-set.ly imprimait le mot « apostrophe » dans les paroles.
- Rattachement (index.json : 40 premières lettres du texte → image) : texte de gouzes.json (antiennes, invitatoires, refrains de
  répons, 1re strophe des hymnes) comparé aux **paroles de la source** ; par la cote si les paroles concordent, sinon par le texte
  seul (≥ 25 lettres, le texte doit **ouvrir** une partie de la pièce ; jamais un fichier « Cplts » = versets de répons, ni un texte
  fait d'alléluias, ni une pièce hors du dossier Hymnes pour une hymne). 360/465 textes rattachés ; cotes du tableau fausses ou
  décalées (« À toi la louange » G073 → B122 ; C403/C405). Psaumes du tableau
  comparés à l'Index gouzantinus : concordants (écarts = sections du Ps 118, antiennes à plusieurs psaumes).
- Site (version gouzantine seulement, `PARTITIONS_ACTIVES`) : `Partitions.grave(t)` (chargé par `chargerLY`) passe avant les
  découpes de carnets dans `parTexte` ; `partitionGravee` sous hymnes et répons (offices.js), invitatoire. Province inchangée.
- Word (docx.js) : PNG acceptés (dimensions IHDR, 200 dpi pour `partitions/ly/`), image plus haute que la page réduite.
- **Province avec partitions** (19/11 soir, demande : « revoir la répartition Province » ; document de référence
  « Répartition ROMAINE.docx », Drive Liturgie : psautier romain 4 semaines, AT 1-59 et NT I-XIV = numérotation du site) :
  `gravees()` dans `placeur` (offices.js) : antienne gravée (par son texte) **à la place** de la découpe du carnet ; cantique
  du NT gravé (`index.json > cantiques` : NT4 Rm 6 … NT14 Ap 19, table `NT_FICHIERS` de graver_lilypond.py ; pas de NT9)
  **au début du cantique** (demande de l'utilisateur : « au début du cantique et non à la fin ») : sous l'antienne si le
  cantique ouvre l'élément, sinon juste avant son titre (Carême, dimanche : antienne propre sous l'antienne, Ps 113B, puis 1 P 2).
  Sans gravure, les pages « cantique » du carnet vont au même endroit. Gouzantine : cantique gravé si l'antienne n'a pas de
  partition (« Alléluia » d'Ap 19) et sur la psalmodie AELF de repli. Année 2026-27 contrôlée : seuls manquent les jours de
  saints de l'Ordre (commun, sans carnets) et NT9. **Publié le 20/11/2026** par l'utilisateur (relevé : 4 790 images dont
  354 gravées ; l'entrepôt a retiré 444 images devenues inutiles). Vérifié sans compte : adresses → connexion.
- 20/11/2026 : partition des intercessions (louanges des laudes, intercessions des vêpres) **au début** de la section, sous son
  titre (`enTete()` dans offices.js, au lieu de `dans()` qui l'ajoutait à la fin) ; offices.js?v=107. Contrôlé : Province (écran,
  PDF A5 du 18/01/2027) ; la litanie gouzantine n'a pas de partition. Publié le 20/11.
- 20/11/2026 : carnet du TO, page 99 = **fin du Gloria des laudes du vendredi** (suite de la p. 98), indexée à tort comme hymne
  des vêpres du vendredi (titre « Vêpres » et texte de « Dieu d'Abraham » sur la page). Signalé par l'utilisateur. Retouche
  `SUITES` dans `outils/indexer_partitions.py` (appliquée aussi à `partitions/index.json` sans relancer l'indexeur). Vérifié sur
  l'année : plus aucune vêpres avec la p. 99 ; elle suit le Gloria aux laudes des vendredis. Publié le 20/11 (--forcer).
- 20/11/2026 : **gravures** (illustrations) encore affichées comme partitions (signalé : to/h-083, Crucifixion après l'hymne des
  vêpres du vendredi I & III). Cause : `marquer_musique.py` ne mesure l'encre que des pièces centrées (x0 > 14,5 % de la page).
  Densité d'encre mesurée sur toutes les images affichées (> 16 %, puis vérifiées à l'œil) → `partitions/corrections.json`
  (index intact, demande de l'utilisateur) : retirées (s-, h-, p-) to 83, noel 9, paques 108 et 198, sanctoral1 35 et 150,
  sanctoral2 75, 100 et 218 (gravures seules) ; to s-096-2 (gravure entourée du texte de l'hymne, sans notes) ; **recadrées**
  (musique gardée, attention : certaines images mêlent les deux) noel 258, sanctoral2 226 ; Marseille a-056-1, a-056-2, a-057-2
  (pavé noir à droite). `sips -c` recadre de façon peu fiable : recadrage fait en Python (BMP). Relevé : aucune de ces images
  n'est plus affichée. Publié le 20/11 (entrepôt : 5 envoyées, 15 retirées).
- 20/11/2026 : partition du **répons sous le titre « Répons »**, avant le texte (lectures, laudes, vêpres, complies OP ; Carême :
  la partition du 2e répons sous « Ou bien : »). `reponsG` ne pose plus de partition ; `partRep`/`partRepL` dans offices.js.
  Contrôlé : 488 offices (1 jour sur 6), PDF A5 vêpres 18/01/2027. Publié le 20/11 (--forcer).
- Contrôlé : laudes du 21/02/2027 (8 gravures, bien placées), PDF A5 regardé, .docx (XML valide, non ouvert dans Word).
- **En ligne** depuis la publication du 19/11/2026 au soir (faite par l'utilisateur) : 342 images `partitions/ly/` dans l'entrepôt
  (vérifié avec `az storage blob list`) ; affichage connecté non vérifié par Claude.
- Non fait : 27 échecs de gravure (Présidence surtout) ; 103 textes sans source ; mise en page de l'auteur (`Ft-*.ly`, titres) ;
  livrets scannés en repli ; matériel de messe.

### Missel à consulter (bouton « Missel » de la Messe) — 19/11/2026

- Demande : « intégrer le Missel dans un bouton à côté de l'export de la messe », tous les textes, de manière organisée.
- `outils/missel_liturgie.py` (appelé par `construire_missel.py`) lit **directement le XML** de
  `sources_missel/ordinaire/missel-liturgie-de-la-messe-v7-avec-benedictions.docx` (styles Word nommés : Prtre, Peuple,
  Prtrepeuple, Note, Prtrevoixbasse, Titre0-6 ; NoteCar/Lienhypertexte = rouge ; symboles Wingdings F058 = ✠) →
  `missel.json > liturgie` : Ordinaire (20), Préfaces (89, en 12 groupes), Prières eucharistiques (14), Bénédictions
  solennelles et prières sur le peuple (22). Tables des matières du fichier ignorées. Les autres clés de missel.json inchangées.
- `messe.js > Messe.livre` : `index(missel)` (7 chapitres : Ordinaire, Préfaces, PE, Propre du temps + Triduum, Propre des
  saints par mois, Communs, Bénédictions ; 617 textes), `vue(missel, chemin, q)`, `chercher` (titres puis texte).
  Adresses `#missel`, `#missel/<chapitre>/<pièce>`, `#missel?q=…` (messe.html : `afficherMissel`, « Imprimer ce texte »).
- Messe du jour (écran seulement, `opts.renvois`) : bloc « Préface et prière eucharistique » après la prière sur les offrandes :
  préface propre (`PREFACE_PROPRE`), préfaces du temps, PE I-IV et réconciliation. Absent des exports PDF/Word.
- Contrôlé : 617 pièces rendues sans erreur ; 365 jours × chaque choix de messe sans erreur ; écran 800 px et 375 px.
  Non vérifié : PDF de « Imprimer ce texte ». Non publié.

### Commun des saints au choix (Heures grégoriennes) — 19/11/2026

- Demande : « à partir des Heures grégoriennes et éventuellement d'AELF, la sélection des communs pour l'office ; un bouton à
  gauche de l'export ». Bouton `#ouvrir-commun` (index.html, visible si `partitions/hg/communs.json` se charge) → `dialog#commun` :
  commun (suggéré par `Communs.suggerer(j)` d'après le nom du saint), précision (« pour un évêque »…), lieu (dédicace), psaumes du
  commun ou de la férie (défaut : commun si fête, férie si mémoire), période. Retenu dans `pref.communs[date] = {id, pour, psaumes, lieu}`,
  passé en `options.communs` (écran, export, hors connexion) ; URL d'impression `&commun=id[:pour][:ferie]`.
- `outils/construire_communs.py` → `partitions/hg/communs.json` (≈ 650 Ko, privé comme offices.json) : pièces du tome III
  rattachées à leur commun **par la page** (offices.json mêlait « plusieurs martyrs » et « plusieurs saints » sous C/autre, et la page
  de titre restait au commun précédent ; la dédicace commence sous CSM/11-11). Segments par variante (temps pascal, Carême,
  « pour … », rang, lieu), strophes propres des hymnes des pasteurs/défunts + suite commune, partie II d'un psaume rangée sous
  l'antienne, lettrines (`RETOUCHES`), oraisons coupées avant l'invitatoire collé. `BASE` : plusieurs-saints → saints, docteurs →
  pasteurs, martyrs → martyr pour ce qui manque. Relancer après `construire_offices_latins.py`.
- `site/js/communs.js` : `Communs.pour(choix, j, office)` (variantes choisies, « (T.P. Alléluia.) » selon le temps), `latin()` (éléments
  bruts insérés dans les candidats de `Latin.construire`, après le propre du saint ; l'autre commun deviné par le livre retiré).
  `offices.js` : laudes/vêpres → hymne (AELF repliée), psalmodie du commun (`psalmodieCommun`, psautier BJ ; partitions latines repliées
  en version avec partitions), lecture brève (Bible BJ), répons, antienne évangélique, intercessions (`precesCommun`), oraison
  (`oraisonCommun` : jour de saint → AELF d'abord) ; partitions des carnets et Gouzes non utilisés ces jours-là ; milieu du jour → antienne
  + trois capitules avec versets. Vêpres veille de dimanche/solennité : commun du lendemain (vepres1), sinon aucun. Lectures, complies : inchangés.
- Test : `node tests/communs.test.js` (12 communs, 496 offices, psaumes et lectures retrouvés). Contrôlé : PDF A5 Province du 07/12/2026
  (pasteurs, pour un évêque), écran 1280 et 375 px, version latin-français construite. Non publié sur Azure ; non ouvert dans Word.
- Limites : version latin-français : consignes du livre (« Aux solennités : », « Oratio propria… ») encore visibles dans les pièces du
  commun ; « N. » non remplacé par le nom du saint ; pas de premières vêpres d'un commun choisi un jour de semaine.
- **Révision du même jour** (demande : « un meilleur moyen d'intégrer le commun », puis « comme pour le Missel ») : bouton et fenêtre
  supprimés. Menus « Commun : » dans l'en-tête de l'office (`ligneCommun`/`avecCommun` dans offices.js, `select[data-commun-date]` +
  `changerCommun` dans app.js), jours de saint ou de mémoire facultative, laudes/milieu/vêpres. `communDuJour(j, options)` :
  `pref.communs[date]` ({id…} ou "aucun"), sinon **d'office pour les célébrations de l'Ordre** (source op, niveau ≤ 11 ; l'AELF n'a pas
  leurs textes) avec le commun suggéré (psaumes du commun si fête, de la férie si mémoire) ; aussi pour la version latin-français.
  Suggestion : indication du Missel (`indications` de communs.json, tirées de `missel.json > saints[].commun` par
  `indications_missel()`, 141 saints), sinon le nom. « saint N. » remplacé par le nom du saint (`nommer`). Provenance à droite du titre
  de chaque partie (`provenance()` : « du commun », « du propre (AELF) », « du jour romain (AELF) », « de la férie ») ; oraison des
  jours de l'Ordre : celle du commun d'abord. `.commun-choisi` visible seulement à l'impression. Vérifié : 28/01/2027 (Thomas d'Aquin,
  d'office), 07-08/08/2027 (S. Dominique, Ires vêpres du commun la veille), menus (aucun / autre commun / précision), latin. Non publié.
- **Bouton « Communs »** (19/11/2026, demande : « la même disposition que le Missel romain, pour choisir ce commun même sans
  mémoire ») : `#ouvrir-communs` à gauche de « PDF / Word » (même forme que `#ouvrir-missel` de la Messe, `aria-pressed`). Adresses
  `#communs` (cartes des 12 communs, celui du jour marqué) et `#communs/<id>` (formulaire précision / psaumes [/ lieu] → « Prendre ce
  commun le JJ/MM/AAAA », « Aucun commun ce jour » ; aperçu de chaque office avec les variantes du jour). `Communs.vue(id, j, choisi)`
  (communs.js), `afficherCommuns()` / `routeCommuns` dans app.js (la date de la barre reste celle de la vue ; un rechargement direct
  sur #communs repart d'aujourd'hui). `Offices.communDuJour` exporté. Retrait d'un commun appliqué d'office → "aucun".
  Vérifié : férie du 13/07/2027 (pasteurs, pour un évêque, pris puis retiré), 28/01/2027 (refus du commun d'office), 375 px. Non publié.
- 19/11/2026 : **publié sur Azure** par l'utilisateur (`bash outils/publier_azure.sh`, connexion implicite) après un relevé des images
  (5 224, 0 erreur ; `releve_images.mjs` ajoute désormais toutes les partitions de `communs.json`, 233). Vérifié sans compte :
  pages et données → 302 vers la connexion. Contrôle avec compte (bouton Communs, 28/01/2027) laissé à l'utilisateur.

### Version « Sainte-Baume », livrets de fr. Max — 20/11/2026

- Reçu : ~/Downloads/Partitions Ste Baume (livrets LaTeX + LilyPond de fr. Max). Copiés (sources .lytex et .ods seulement) dans
  `sources_gouzes/sainte-baume/livrets-latex/`. Les pièces citées sont les sources de Gouzes déjà gravées (`partitions/ly/`, 197/198 ;
  manque « Nous avons péché (R) K811 »). Le psautier LaTeX du dossier = notre psautier BJ (rien de neuf).
- `outils/construire_sainte_baume.py` → `site/donnees/sainte_baume.json` : Carême (v.4 ; textes des couplets de répons pris dans la v.3),
  vêpres, milieu du jour, Veillée pascale (version chœur), textes d'antiennes par cote (Index gouzantinus Carême).
  Éléments par « semaine du psautier/jour » avec `si` = rubrique « Le dimanche I », « Le mercredi des Cendres »… ; renvois « on prend la
  suite de l'office p. … » (Cendres → vendredi III, jeudi saint → vendredi III) résolus en cherchant l'office qui nomme le jour.
- `site/js/saintebaume.js` : `SainteBaume.careme(j, office)`, `milieu(j)`, `lucernaire(j)`, `hymnesVepres(j)`.
- Décisions de l'utilisateur (20/11/2026) : **nouvelle version** `sainte-baume` (VERSIONS dans app.js) = Province avec partitions
  (`options.saintebaume`, répartition ramenée à romaine-gouzes dans `construireOffice`) + livrets là où ils donnent quelque chose ;
  Province inchangée sauf partitions de meilleure qualité **quand on sait où les mettre** ; partitions de la Vigile dans la Messe.
- Carême (Cendres → mercredi saint ; jeudi saint : office des lectures seulement ; pas aux fêtes, ni aux vêpres veille de solennité) :
  psalmodie de l'AELF avec les antiennes du livret rattachées par numéro de psaume (`psalmodieSB`), cantique du NT du livret aux vêpres
  (gravé) ; féries des vigiles **sans antienne** (comme le livret) ; verset des vigiles ; invitatoire de la semaine ; canon (intro + refrain
  gravés) ; vêpres : lucernaire (couplets 1, 2, du jour, 3-5) et hymnes au choix (Passion en Semaine sainte, au choix les vendredis et
  la 5e semaine) ; répons du livret (refrain gravé, couplet du jour + doxologie ; répons bref de l'AELF replié) ; antienne évangélique
  quand le livret en donne une (dimanches, Cendres, Semaine sainte), sinon l'AELF ; preces, Notre Père, « Bénissons » en ton du Carême.
- Milieu du jour (toute l'année, sauf fêtes/solennités/Triduum → Province) : psaumes de la semaine du livret (≠ feuille gouzantine),
  antienne et verset du jour, ou du temps (Avent, Noël avant/après l'Épiphanie, Carême avant/après le 5e dimanche, Pâques octave/après) ;
  hymnes du livret (TO : « Le jour est dans tout son éclat » / Rector potens ; Carême et Pâques : leur hymne).
- Temps ordinaire, version Sainte-Baume : antiennes de Sainte-Baume (`sbPour`) d'abord, celles du carnet retirées.
- Toutes versions : canon de saint André avec le gras des inflexions (`Gouzes.remplacerCanon`, 44 jours, textes concordants ≥ 0,89 ;
  jeudi saint ajouté) ; textes d'antiennes par cote (`Gouzes.ajouterCotes`).
- Province : `graverCarnet` (offices.js) remplace une pièce de carnet à **une seule cote** (invitatoire, hymne, lucernaire, répons,
  antienne évangélique…) par la même pièce gravée (`Partitions.parCote`, table `cotes` de `partitions/ly/index.json`, ajoutée par
  `graver_lilypond.py --index`), et retire la suite de cette pièce découpée sur la même page ; antiennes de psalmodie : gravure par le
  texte, sinon par la cote affichée. Mesuré sur 27 offices : 35 → 44 gravures.
- Messe : `messe.html` charge `sainte_baume.json` ; `chantsVigile()` (messe.js) pose les partitions repliées sous la section du Missel
  correspondante (feu, procession, Annonce, lectures 1-7, Alléluia, Aspersion ; communion en fin). `messe.html` a désormais les balises
  `fichiers`/`fichiers-cle` et `cle-fichiers.js` ; `publier_azure.sh` les remplit aussi pour messe.html.
- `releve_images.mjs` : version sainte-baume + toutes les images de `sainte_baume.json`. CSS : en A5, partitions limitées à 170 mm de haut
  (une partition trop haute faisait sauter une page blanche).
- Test : `node tests/saintebaume.test.js` (Carême 2027-2031, milieu du jour 2027). Contrôlé : écran (15/02, 03/03, 13/02/2027),
  PDF A5 laudes/milieu/vêpres du 15/02/2027, .docx (XML valide, non ouvert dans Word), Vigile (28/03/2027). Non publié sur Azure.

### Sainte-Baume complète (temps ordinaire), gravures retirées — 20/11/2026

- Reçu (Drive LITURGIE/03-Gouzes/GOUZES TEXTES, copiés dans `sources_gouzes/sainte-baume/textes/`) : « Antiennes des offices
  Ste Baume.docx » (3 tableaux semaine I-IV × jour : matines + laudes, milieu du jour/sexte, vêpres) et « Répons laudes et
  vêpres.doc » (**identique** à `sources_gouzes/Répons laudes et vêpres.doc`, déjà dans gouzes.json : rien de neuf).
- `construire_sainte_baume.py` → `sainte_baume.json > ordinaire` : `{lectures|laudes|vepres}["sem/jour"]` = [{id, partie?, ant?}] ;
  dimanche : une ligne matines puis une ligne laudes ; en semaine, une seule cellule (1re entrée = matines). Antiennes notées par
  leur début (« 62 Mon âme ») : texte retrouvé dans le recueil de Gouzes et `partitions/sb/pieces.json` (même psaume d'abord,
  abréviations « S. », « Xst », « tte »… développées), cote → gravure LilyPond, sinon image des livrets indexés de Sainte-Baume
  (`sb`, la n-ième antienne d'un même psaume prend la n-ième image). Cantiques de l'AT : `id: "AT"` (celui de l'AELF).
  `milieu["sem/jour"]` = groupes {ps, ant: {cote, inc, f}} (l'antienne suit ses psaumes dans le tableau ; deux le dimanche II/IV).
- Les psaumes de la répartition = ceux du psautier romain (vérifié sur les échantillons) : `psalmodieSB` prend la psalmodie de
  l'AELF et pose les antiennes par numéro de psaume, sans repli « dans l'ordre » au temps ordinaire (`strict`) ; cantique du NT
  des vêpres : celui de l'AELF, avec sa gravure.
- `SainteBaume.ordinaire(j, office)` : temps ordinaire, féries, dimanches et mémoires (pas les fêtes, ni la Trinité, le Christ-Roi…) ;
  samedi soir = « Samedi » de la semaine du dimanche suivant. Le carnet de la Province reste pour hymnes, répons, intercessions
  (ses antiennes et cantiques retirés). Matines de semaine sans antienne (comme le tableau).
- Milieu du jour : psaumes et antiennes du tableau (sexte) au lieu du livret LaTeX (différences : dimanches A302/A502-A503/A602/
  A603-A601 au lieu de « Voici le jour »/C209, vendredi III F246 au lieu de K751) ; aux temps forts, l'antienne du temps sur ces psaumes.
- Restent sans texte complet (début seul affiché, partition présente) : 15 antiennes (liste à la construction) ; « Créatures »
  (cantique Dn 3, dimanches I et III) sans texte ni partition.
- Gravures (« elles ne m'intéressent pas ; ne garder que les partitions ») : détection sur les 4 426 images publiées (bande encrée
  sans portée), vérification à l'œil → `outils/retirer_gravures.py` (liste GRAVURES) : 5 pages de gravure seule retirées
  (avent p-226, noel p-039 et p-177, paques p-037, careme h-207) ; 16 coupées sous la musique (« bas ») ; 5 gravures à côté de la
  musique blanchies (rectangle relevé à l'œil, les portées qui traversent gardées) ; 3 pavés noirs (Marseille a-054-2, a-058-2,
  a-070-1) coupés. Images dans `partitions/corrections/*-sans-gravure.jpg`, déclarées dans corrections.json.
  `Partitions.figure` applique désormais les corrections **aussi après** `dUnTenant` (les images h-… assemblées n'étaient pas corrigées).
  Non traité : une gravure dans une image non publiée, ou plus petite que le seuil de détection (≈ 60 points sur 300 de large).
- **Publié sur Azure le 20/11/2026** (demande de l'utilisateur) : relevé des images refait (4 886 images, 4 versions dont
  sainte-baume, 0 erreur), `bash outils/publier_azure.sh` (connexion implicite). Entrepôt : 161 fichiers envoyés (images corrigées,
  Vigile, gravures), 57 retirés (dont les pages de gravure). Vérifié sans compte : pages et données → connexion ; entrepôt refusé sans
  clé ; images corrigées et partitions de la Vigile présentes, avent/p-226 absente. Affichage connecté non vérifié par Claude.

### Propre de l'Ordre : Missel et Lectionnaire OP — 20/11/2026

- Reçu (Drive LITURGIE/01-Missel-et-Eucharistie/OP, copiés dans `sources_missel/op/`) : `missel_OP.pdf` (194 p.) et
  `lectionnaire_OP.pdf` (60 p.), édition partielle et provisoire de juin 2026 (LaTeX). Lus par `pdftohtml -xml` (rouge = rubriques,
  gras = texte dit, italique = notices, lettrines et petites capitales recollées).
- `outils/construire_missel_op.py` → `site/donnees/missel_op.json` {calendrier (147 entrées, degré, provinces, italique = martyrologe),
  preface (« Esprit et vocation du Prêcheur »), saints MM-JJ (136 messes : notice, commun, rubriques, ouverture, priere, offrandes,
  preface, communion, apres, benediction, peuple), votives (Notre-Dame Patronne), communs (21), lectures (11 jours)} ; texte au format
  de missel.json, « § » = rubrique. Titres des messes pris au calendrier de l'Ordre. **Réécrit aussi `site/donnees/propre_op.json`**
  (calendrier des offices) : degrés du calendrier OP ; degrés de la **Province de Toulouse** entre [ ] appliqués (hypothèse : la
  Province de l'utilisateur) ; doublon du calendrier romain sans degré plus haut → non repris (sauf entrée déjà présente) ; noms déjà
  en usage gardés (relancer : le script relit l'ancien fichier). Ajouts : 3 janv. Saint Nom de Jésus, 15 mai André Abellon, 29 mai
  Guillaume Arnaud, 4 juil. + Catherine Jarrige, 12 août J.-G. Rhem, 6 sept. Bertrand de Garrigues, 22 oct. Dédicace de l'église dont on
  ignore la date : **proposée au choix (mémoire facultative, `AU_CHOIX`), pas imposée** (décision de l'utilisateur, 20/11/2026).
- Offices : `site/js/propreop.js` (`PropreOP.saint/priere/vueCalendrier`) ; `avecOraisonOP` (offices.js) : jour de saint qui a une
  messe au Missel de l'Ordre → sa PRIÈRE d'abord, autres prières du Missel OP et oraison AELF/commun/HG repliées (lectures, laudes,
  milieu, vêpres ; pas les complies). Psaumes et capitules inchangés. Bouton « Calendrier OP » (`#ouvrir-cal-op`, `#calendrier-op`,
  à gauche de « Communs ») : calendrier par mois, degré, provinces, prière (et notice) repliées.
- Messe (`messe.js`) : messes du Missel OP proposées en plus de celles du Missel romain (par défaut si c'est la célébration du jour) ;
  saint OP sans texte → sa notice va à la messe romaine du même saint. Notice repliée, rubriques, préface propre (sinon préface de
  l'Ordre repliée), bénédiction solennelle, communs du Missel OP ; lectures du Lectionnaire OP à la place de l'AELF (AELF repliée).
  Bouton « Missel OP » (`#ouvrir-missel-op`, `#missel-op/…`) à gauche de « Missel » : `Messe.livreOP` (calendrier, préface, propre des
  saints, messe votive, communs, lectionnaire), même vue que le Missel romain (`vueLivre` paramétrée).
- Test : `node tests/missel_op.test.js`. Contrôlé dans le navigateur (8 août, 28 janv., 7 janv., Missel OP, calendrier OP, 375 px).
  Publié sur Azure le 20/11/2026 (--forcer : partitions inchangées) ; pages protégées par la connexion vérifiées. Lacunes de la source : Girotti, Ghika, Pie Albert del Corona, Ghattas, Narcisse Martillo, Alexandre Longo,
  Bonaventure García Paredes, martyrs du Vietnam (titre seul) ; Marie-Madeleine renvoie au Missel romain ; renvois de pages des
  communs (p. 175…) décalés dans la source → commun choisi par les mots.

### Fusion des deux « Romain gouzantin » — 20/11/2026

- Demande : une seule version « Romain gouzantin », partitions repliées (les deux ne différaient que par les sections
  « Partition » repliées et les propositions grégoriennes).
- index.html : choix « Romain gouzantin — avec les partitions » (`#version-partitions`) retiré ; app.js `VERSIONS.province`
  = `["romaine-gouzes", true]`, `province-partitions` gardé comme alias ; `versionDe` → toujours `province` ;
  préférences anciennes `romaine-gouzes` + `partitions:false` passées à `true` au chargement. app.js v=97.
- Impression par URL : `version=province` garde un PDF sans partitions (sauf `&partitions`), `province-partitions` les inclut.
- Hors ligne : en romain gouzantin, l'enregistrement prend désormais aussi les images (≈ 74 Mo pour 30 jours).


### Propre de l'Ordre dans les carnets du sanctoral — 20/11/2026

- Demande : « nous avons oublié le sanctoral, le propre de l'Ordre » ; bien présenter le propre de l'Ordre chaque fois que les
  carnets du sanctoral le donnent, avec les prières du Missel OP. Reçu : `Sanctoral-Fév-Août.docx`, `Sanctoral-sept-jan.docx`
  (exportés de Pages le 20/11, dans le Drive Carnets PERDRIX). **Le PDF `Sanctoral-sept-jan.pdf` date de 2024 et est en retard sur
  le carnet** (28 janv. : page des vêpres = fin de l'hymne) ; le .docx a chaque partition en image séparée, nette (≈ 3 400 px).
- Constat : les jours de l'Ordre, le commun appliqué d'office (`communDuJour`, `CM.auto`) écartait tout le carnet (hymne, psaumes,
  antiennes, répons) et le capitule de la Province.
- `outils/extraire_docx_sanctoral.py "<dossier carnets>" [--liste]` → `partitions/op/<clé>-<n>.jpg` (900 px ; recadrage du carnet ;
  sips recadre au centre si le décalage vaut 0 → au moins 1). `outils/offices_op.py` → `site/donnees/offices_op.json` : 12 fêtes
  (28 sept. au choix, 4 et 7 oct., 3, 7, 8 [au choix, = 2 nov.], 15 nov., 28 janv., 29 avril, 24 mai [antiennes sur les psaumes de la
  férie], 8 août [1res vêpres, vigiles], 28 août), 26 offices : hymnes, psaumes (`88:2-19` = versets), antiennes **transcrites à l'œil**
  + images, « ou bien », antiennes au choix, répons, antienne évangélique, lucernaire ; renvois du carnet résolus (Toussaint,
  2 nov., p. 8 → `ordo.json`). Gravures écartées (vérifiées à l'œil + densité d'encre).
- Site : `PropreOP.chargerOffices` / `PropreOP.carnet(j, office)` (propreop.js ; fête de l'Ordre choisie ou du jour, ou saint romain
  au même nom : Catherine de Sienne ; 1res vêpres d'une solennité). `offices.js` : `OPC` (versions Province et Sainte-Baume, propre
  OP, pas si un commun est choisi **à la main**) → `psalmodieOP`, `antiennesOPFerie`, `hymneOP`, `reponsOP`, `noteOP` ; capitule de la
  Province (`Capitules.pour` → `sanctoral: true`) avant celui du commun ; commun d'office gardé pour antienne évangélique,
  intercession, oraison repliée ; prière du Missel OP d'abord (inchangé) ; prières litaniques et Te Deum des annexes (ordo).
  Sans partitions : textes des antiennes, hymne en texte (commun/AELF) avec les titres du carnet. Romain, gouzantin, latin : inchangés.
- `app.js` charge `offices_op` ; `sw.js` le garde hors ligne ; `releve_images.mjs` ajoute toutes les images d'`offices_op.json`.
- Test : `node tests/offices_op.test.js`. Contrôlé dans le navigateur : 28/01, 07/10, 03/11, 07/11, 15/11, 04/10, 29/04, 24/05,
  07-08/08, 28/08, 28/09 et 08/11 choisis ; sans partitions ; Sainte-Baume ; aperçu PDF. **Non publié.**
- Reste : titres d'hymnes de saint François et des répons non vérifiés un à un (ordo de sept-jan : refait, voir plus bas).

### Lectionnaire Bouchet : contrôle des fêtes des carnets et du temps ordinaire — 20/11/2026

- Audit 2026-11-29 → 2029-11-30 (propre OP) : fêtes des carnets du sanctoral, dimanches du TO (numéros justes, aucun sans lecture).
- Corrigé dans `bouchet.js` : (1) fête ou solennité du sanctoral qui remplace un dimanche ou une férie de Carême (S. Dominique et
  Assomption 2027 un dimanche, S. Joseph en Carême, Transfiguration 2028, S. Jean-Baptiste 2029) : la lecture du dimanche passait
  **avant** celle de la fête (et c'était elle qu'on imprimait) → lecture de la fête seule ; (2) saint au calendrier non célébré
  (mémoire facultative non choisie : B. Henri Suso, S. Joseph artisan, S. Antonin, Saint nom de Jésus, défunts OP le 8 nov., dédicace
  du 22 oct.) : lectures du temps d'abord (imprimées), celle du saint au choix ; choisi → celle du saint seule. Vigiles (23 et 28 juin,
  14 août) inchangées. index.html bouchet.js v=87.
- Fêtes des carnets sans lecture dans le livre (lectures du temps proposées) : S. Martin de Porrès, Translation de S. Dominique,
  Ste Agnès, S. Barnabé, Ste Brigitte, Ste Thérèse-Bénédicte, Anges gardiens, S. Martin de Tours, Ss. Cyrille et Méthode, S. Benoît.

### Carnet du sanctoral septembre-janvier refait depuis le .docx — 20/11/2026

- `extraire_docx_sanctoral.py "<dossier>" --sept-jan` → `partitions/sj/<clé>-<n>.jpg` (463 images, 19 fêtes + annexes). Lecture
  complète du .docx (`suite_complete`) : la lecture par paragraphe perdait 7 images posées dans des cadres de texte (dont « Venez à
  moi », saint Matthieu, et 6 de la Dédicace) ; image208 du .docx a une somme de contrôle fausse (lue quand même).
- `outils/ordo_sept_jan.py` (appelé par `construire_ordo.py` après `ordo_noel`, ou seul) remplace dans `partitions/ordo.json`
  les 19 fêtes du carnet (images relues une à une ; ordre du .docx = ordre de la page, sauf vigiles de la Dédicace, contrôlées sur
  la page imprimée) et les 12 fêtes de l'Ordre (converties d'`offices_op.json`, images `op/`). Corrigé au passage : Dédicace
  (laudes : une antienne sur deux ; vigiles : Ps 83 sans antienne), Notre-Dame des Douleurs, sainte Thérèse, Présentation
  (antiennes absentes), Christ-Roi, Immaculée Conception (antiennes des vigiles et des laudes), 28 janvier. Annexes (cantiques
  du NT, lucernaire festif, prières litaniques, antiennes mariales) : celles du PDF. Anges gardiens, vêpres : hymnes des laudes.
- `offices.js` `piecesDuJour(…, idsAELF)` : veille d'une solennité en semaine, si l'AELF donne les psaumes des premières vêpres
  (mêmes numéros que le carnet), les pièces du carnet vont à leur place et non en fin d'office (aucun cas trouvé 2026-2029 ;
  offices.js?v=114). Hymne « Puissance et gloire » ajoutée aux laudes du 28 sept. (Courtet, `offices_op.py`).
- Contrôlé : 35 offices (sept. 2027-janv. 2028), antiennes sous leur psaume ; tests verts. **Non publié** (nouvelles images :
  `partitions/sj/`, 81 Mo avant recompression ; le relevé des images les prendra).
- **Psaumes du carnet au choix** (demande de l'utilisateur, 20/11/2026) : aux mémoires dont l'ordo donne des antiennes avec psaumes
  (pas « de la férie ») — laudes et vêpres, Province/Sainte-Baume, sans commun choisi à la main — menu « Psaumes : de la férie (AELF) /
  du carnet de la Province » dans l'en-tête (`lignePsaumes`, `select[data-psaumes-date]`, `pref.psaumesCarnet[date]` = true,
  `options.psaumesCarnet`). `psalmodieCarnet()` : psaumes de chaque étiquette (psaume, puis AT, puis NT), antienne = « antienne du
  carnet (partition) », partitions posées par le placeur. Défaut : férie. offices.js?v=115, app.js?v=99. Contrôlé : 15/09, 11/11/2027,
  21/01/2028 (laudes, vêpres, les deux choix), menu à l'écran.
- Constaté auparavant : aux **mémoires** que le carnet traite comme des fêtes (Notre-Dame des Douleurs,
  S. Martin de Tours, Ste Agnès, Ste Thérèse, Présentation…), l'AELF donne les psaumes de la férie : les antiennes du carnet
  (écrites pour Ps 62/149, 114/115…) ne trouvent pas toutes leur psaume ; certaines sont remplacées par la gravure de l'antienne AELF.
- **Publié sur Azure le 20/11/2026** (demande de l'utilisateur) : relevé des images refait (5 040 images, 5 versions, 0 erreur ;
  271 de `sj/`, 183 de `op/`), `bash outils/publier_azure.sh` (connexion implicite). Entrepôt : 458 envoyés, 302 retirés (anciennes
  découpes du PDF sept-jan devenues inutiles). Vérifié sans compte : pages et données → connexion. Affichage connecté non vu par Claude.
