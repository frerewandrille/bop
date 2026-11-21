# Sources et choix, une à une

Ce document réunit les explications détaillées, source par source : d'où vient chaque texte, quelles
décisions ont été prises (et validées) pour le ranger dans l'office, comment refaire les données.
Il a été tiré du `README.md` le 20/11/2026 (qui ne garde plus que l'essentiel). Pour le fonctionnement
technique d'ensemble, voir `FONCTIONNEMENT.md` ; pour chaque réglage, `MODE-D-EMPLOI-REGLAGES.md`.
Les dates indiquent quand une décision a été prise ; le journal complet est dans
`archives/historique/JOURNAL-2026-11.md`.

## Liturgie chorale du peuple de Dieu (Gouzes)

Réglages ⚙ → « Gouzantine ». L'office prend alors, quand le recueil les fournit :

- la **psalmodie gouzantine** avec ses antiennes, leur cote et leur ton (temps ordinaire sur
  4 semaines ; Avent : dimanches, semaines I à III, 17-23 décembre ; Carême : semaines I et II en
  alternance, dimanches, Cendres ; temps pascal, Ascension, Pentecôte ; Ténèbres du Triduum) ;
- les **antiennes du Magnificat et du Benedictus** propres (antiennes « Ô », « Réjouis-toi, Marie »…),
  les **invitatoires** du Carême et des dimanches de Pâques ;
- les **hymnes** de l'Avent et du Carême, les **chorals** des dimanches ;
- les **répons** à versets : laudes et vêpres (cycle de 8 semaines), dimanches (8 semaines),
  versets des mémoires de saints, Avent ;
- les **litanies** (preces) du fr. Dominique Cerbelaud, à la place des intercessions, toute
  l'année — y compris saint Thomas d'Aquin, saint Dominique, tous les saints de l'Ordre ;
- au Carême, le **Grand Canon de saint André de Crète**, section du jour, à l'Office des lectures ;
- les **preces des Ténèbres** du Triduum.

Ce que le recueil ne donne pas (lectures, oraisons, Complies, temps de Noël, octave de Pâques,
fêtes) vient de l'AELF, avec une mention en bas de l'office.
L'option « Romaine, antiennes de Gouzes » garde la répartition romaine du temps ordinaire avec
les antiennes de Gouzes.

Sources (dossier `sources_gouzes`) : le tableau « Offices Gouzes répartition, traduction.xlsx »,
« Antiennes écrites AVENT (V2) », « Antiennes écrites CAREME », les répons (laudes et vêpres,
vigiles, mémoire des saints), les « Preces / Litanies », les « Ténèbres Preces ».
« TRID GOUZES » est une présentation du Triduum, sans texte d'office : non repris.
Après modification d'un de ces fichiers : double-clic sur « Mettre à jour les textes.command ».

Choix d'organisation (validés le 11 novembre 2026) :
- semaines I / II du Carême : I en semaines 1, 3, 5 ; II en semaines 2, 4, Semaine sainte ; les
  jeudi-samedi après les Cendres prennent la semaine II ;
- semaines I / II du temps pascal : I en 2e, 4e, 6e semaine ; II en 3e et 5e ;
- répons (cycle de 8 semaines) : semaine 1 du temps ordinaire = répons I, semaine 9 = I…
- laudes de la semaine préparatoire : l'antienne encadre le psaume (64…), puis le cantique et le
  dernier psaume sont chantés sans antienne propre ;
- un psaume chanté sous deux ou trois antiennes (« 16 a / 16 b », ou « 39 » deux fois) est coupé
  en parties égales, aux limites de strophes ;
- l'office des Ténèbres donne les débuts d'antiennes et de répons (le recueil n'a que les incipit) ;
  le texte des Lamentations n'y est pas.

## Carnets de la Province et partitions

Les carnets de chœur de la Province (« carnets Perdrix » : temps ordinaire, Avent, Noël,
Carême, temps pascal, sanctoral de septembre à janvier) sont intégrés :

- **Partitions** : chaque partition est découpée pièce par pièce et placée **sous son texte** :
  l'hymne, puis chaque antienne avant son psaume (reconnue par l'étiquette du carnet,
  « Psaume 41 & AT 15 », ou par sa cote au Carême, « K 731 »), le répons, l'antienne du
  Benedictus ou du Magnificat, le lucernaire, les louanges ou intercessions. Ce qui n'a pas pu
  être rattaché à un texte est regroupé à la fin de l'office (« Autres partitions du carnet »).
  Pour le PDF et le Word, cocher « Inclure les partitions ».
- **Version « Romain gouzantin »** (⚙ → Version de l'office) : psalmodie romaine avec les
  antiennes de Gouzes ; au Carême, l'antienne du jour d'après sa cote dans le carnet (K 731…),
  et le cantique du NT prescrit par le carnet aux vêpres.

**Où sont les partitions** : dans le dossier `partitions` (à côté de `site`). En ligne, seules les images
réellement affichées sont publiées, dans l'entrepôt Azure **privé**, lisible seulement par les personnes
connectées. Les carnets portent « Province dominicaine de Toulouse — Ne pas emporter ».

Après modification d'un carnet (PDF exporté de Pages), dans le Terminal :
`bash outils/rendre_partitions.sh "<dossier des carnets>"`, puis
`python3 outils/indexer_partitions.py "<dossier des carnets>"`, puis le découpage en pièces :
`python3 outils/decouper_partitions.py to "<carnet .pdf>"` (un couple code / fichier par carnet).

Limites : le choix des pages se fait d'après leur titre ; quand le carnet propose plusieurs
hymnes au choix (Avent, Carême), toutes sont proposées, repliées. Les livrets Gouzes numérisés (A à V)
ne sont pas intégrés : ce sont des scans sans texte (des partitions gravées depuis les sources LilyPond
les remplacent en partie, `partitions/ly/`).

### Livrets de Sainte-Baume (psalmodie des quatre semaines)

Les livrets « Matines-Laudes » et « Vêpres » de Sainte-Baume (copiés dans
`sources_gouzes/sainte-baume`) donnent, pour chaque psaume du psautier romain des quatre
semaines, l'antienne de Gouzes en partition. Ils servent de modèle à l'enchaînement
antienne → partition → psaume, et leurs partitions (122) sont placées sous les antiennes de la
version « Province » au temps ordinaire, laudes et vêpres (l'office des lectures n'en a presque
pas). Le texte de chaque antienne vient du tableau de la Province. Outil :
`python3 outils/indexer_sainte_baume.py` → `partitions/sb/`.

Pour la version gouzantine, la partition est retrouvée **par le texte de l'antienne**
(Sainte-Baume, carnet du Carême par sa cote, livret de Marseille) : 209 antiennes sur 583 du
tableau gouzantin en ont une. Les autres n'ont que leur texte.

### « Les Heures grégoriennes » (Communauté Saint-Martin, 3 tomes)

Copiés dans `sources_gouzes/heures-gregoriennes`, découpés pièce par pièce
(`outils/decouper_partitions.py hg1 …`) et indexés par jour, office et rôle
(`outils/indexer_heures_gregoriennes.py` → `partitions/hg/index.json`).
Leurs antiennes et répons sont ceux de la Liturgie des Heures **latine** : ils ne correspondent
pas aux textes de l'AELF (la version française a ses propres antiennes). Ils sont donc proposés
**au choix**, avec leur propre texte (la traduction imprimée en regard dans le livre), puis la
partition : « Ou bien, en grégorien (latin) ». Ils complètent les éléments qui n'ont pas de
partition (hymne, antiennes, répons, antienne du Benedictus/Magnificat), dans les versions avec
partitions. La variante du temps (pascal, Carême, Avent, Noël) est prise quand elle existe. Les
dimanches du temps ordinaire ne sont pas repris (une seule antienne par année A/B/C dans ce livre).

### Version « latin-français » (une autre façon de dire l'office)

Réglages → Version de l'office → **Latin-français (Les Heures grégoriennes)**. Les autres versions
ne changent pas : celle-ci est construite à part, entièrement à partir des trois tomes.

- **Ce qui est affiché** : introduction, hymne (partition de la première strophe, puis les autres
  strophes en latin ; traduction en regard), psalmodie (antienne notée, psaume en latin et en
  français vers par vers, Gloria Patri, reprise de l'antienne), lecture brève, répons, cantique
  évangélique avec son antienne, prières d'intercession, oraison, conclusion. Laudes, milieu du
  jour (Sexte), vêpres, complies. Pas d'Office des lectures (le livre ne le donne pas).
- **Le texte latin des antiennes et des répons** est celui de leur partition : le livre ne
  l'imprime pas à part. Leur traduction française est écrite en regard.
- **Les syllabes marquées pour le chant** dans le français du livre sont en **gras**.
- **Choix du texte** : le tome selon le temps (I : Avent, Noël, temps ordinaire ; II : Carême,
  temps pascal ; III : sanctoral et communs), puis du plus propre au plus commun (fête, date,
  temps, psautier). Aux laudes des fêtes, psaumes du dimanche de la Ire semaine ; aux vêpres, les
  psaumes propres quand le livre les donne. Au milieu du jour, la lecture et l'oraison de Sexte.
- **À l'écran** : deux colonnes (une seule sur téléphone). **En PDF** : deux colonnes. **En
  Word** : un tableau à deux colonnes par élément.
- Fabrication : Ghostscript lit le texte des PDF (il garde les lettres marquées que les autres
  outils perdent), puis `python3 outils/construire_offices_latins.py` → `partitions/hg/offices.json`.
- **Limites connues** : environ 5 % des débuts de psaumes gardent une lettrine mal recollée
  (« ELL’Agneau »…) ; aux vêpres des fêtes dont les psaumes sont au commun, les psaumes du jour
  sont pris (signalé) ; le milieu du jour des solennités prend la psalmodie du jour.

## Lectionnaire patristique dominicain (J.-R. Bouchet)

À l'Office des lectures, sous l'intitulé « Deuxième lecture », deux sections repliées : « Lectionnaire dominicain
(J.-R. Bouchet) » et « Lecture de l'AELF » (avec son répons). On déplie celle que l'on veut lire.

Le lectionnaire donne une lecture propre les dimanches, aux fêtes du Seigneur, les mercredis et vendredis de Carême,
en Semaine sainte (avec les trois nocturnes du Triduum), au sanctoral et aux vigiles ; les autres jours, il propose
ses « autres lectures » du temps (Avent, féries du 17 au 24 décembre, Noël, Épiphanie, temps pascal, semaine de la
Pentecôte, temps ordinaire). Les lundis, mardis, jeudis et samedis de Carême, il ne propose rien : seule la lecture
de l'AELF est alors affichée.

**Impression (PDF et Word)** : dans la fenêtre « PDF / Word », rubrique « Office des lectures : deuxième lecture »,
choisir « Lecture de l'AELF » ou « Lectionnaire dominicain ». Avec le lectionnaire : les jours propres, toutes ses
lectures du jour (les trois leçons de Noël, par exemple) ; les autres jours, une de ses « autres lectures » du temps,
prise à tour de rôle ; les jours où il ne propose rien, la lecture de l'AELF. Le choix est gardé pour la fois suivante.

Si le fichier Word du lectionnaire est modifié : `python3 outils/construire_bouchet.py`, puis `node tests/bouchet.test.js`.

## Capitules de la Province

Les lectures brèves des laudes et des vêpres suivent le tableau de la Province de Toulouse
(« Lectures Office Province Toulouse.pdf », transcrit dans `outils/capitules_province.py`),
le texte étant pris dans la Bible de Jérusalem. Une mention « Capitule de la Province » le
signale. Réglage ⚙ : « Capitules de la Province » (activé par défaut, dans toutes les répartitions).
Temps ordinaire sur huit semaines (semaine I = dimanches 1, 9, 17, 25, 33) ; Avent ; Noël et
Épiphanie ; Carême (semaines I-III / II-IV) ; temps pascal ; fêtes du Seigneur ; communs et
propre des saints (y compris ceux de l'Ordre). Au Triduum, en mode Province ou gouzantine,
l'Office des lectures reçoit les trois lectures des Ténèbres du tableau.
Le Triduum (laudes, et vêpres des jeudi et vendredi saints) garde la lecture brève de l'AELF.

## Office du milieu du jour

Onglet « Milieu ». Sources : le livret « Office de Milieu du Jour » du couvent de Marseille (2020)
pour les antiennes en partition et les hymnes grégoriennes, et le carnet de la Province (même
contenu, texte propre) pour les psaumes et les versets ; `outils/construire_milieu.py` →
`site/donnees/milieu.json`.
- **Répartitions Province et gouzantine** :
  - hymne au choix : les hymnes françaises du temps, puis les hymnes grégoriennes du temps
    (*Nunc Sancte*, *Rector potens*, *Rerum Deus*, *Dicamus laudes* ; mélodies propres aux
    solennités, à l'Avent, à Noël ; *Venite servi*, *Qua Christus*, *Ternis ter horis* au Carême ;
    *Iam surgit*, *Dei fide*, *Hæc hora* au temps pascal), chacune avec sa traduction puis sa partition ;
  - psalmodie : l'antienne (texte, puis partition avec le ton), les psaumes, l'antienne ;
  - psaumes et verset du jour, des temps propres, des fêtes et du sanctoral selon le carnet ; fêtes
    sans propre : antienne et psaumes de la férie, verset du commun ; solennités sans propre :
    psaumes graduels de la série II (validé).
  - En gouzantine, au temps ordinaire, la section du Ps 118 et l'antienne du tableau Gouzes.
- **Répartition romaine** : la sexte de l'AELF.
- Dans tous les cas : lecture brève et oraison de l'AELF (sexte), conclusion « Bénissons le Seigneur ».

Le texte des antiennes vient du tableau Gouzes quand le jour porte une section du Ps 118 ; les
autres (dimanches, fêtes, communs) ont été lus sur les partitions du livret et saisis dans
`outils/construire_milieu.py` (`TRANSCRITES`).

## Complies (répartitions Province et gouzantine)

D'après le livret « Liturgie des Heures — Complies », Propre de l'Ordre des Prêcheurs,
Bordeaux 2009 (`outils/construire_complies.py` → `site/donnees/complies.json`), chaque texte
suivi de sa partition grégorienne :
introduction (et acte pénitentiel avec saint Dominique), hymne du temps (*Te lucis* selon les
féries, samedis, dimanches, Avent, Noël ; *Christe qui lux es* et « Ô Christ, tu es la lumière »
au Carême ; *Iesu nostra redemptio* au temps pascal ; strophes mariales aux fêtes de la Vierge),
psaumes du jour sans antienne (samedi et veille des solennités : Ps 4 et 133 ; dimanche et soir
des solennités : Ps 90 ; lundi 85 ; mardi 142 ; mercredi 30 et 129 ; jeudi 15 ; vendredi 87),
lecture brève du livret, répons du temps (*In manus tuas*, *In pace*, *Media vita*, *Christus
factus est*, *Hæc dies*), cantique de Syméon avec l'antienne du temps ou de la fête et son ton,
prière « Visite cette maison » et bénédiction (ou la prière du jour selon l'usage romain),
procession : *Salve Regina* et *O Lumen*. Les jeudi et vendredi saints gardent les complies du
livret de la communauté.

## Jours saints (répartitions Province et gouzantine)

D'après le livret de la communauté (« Complies jours Saints.pdf », `site/donnees/jours_saints.json`) :
- **Laudes des jeudi, vendredi et samedi saints** : signe de croix en silence ; Ps 50, cantique
  (Jonas, Habacuc ou Ézéchias), Ps 95 ou 96, avec leurs antiennes ; ni lecture ni répons ;
  Benedictus avec antienne ; oraison « Regarde, Seigneur… » sans litanie ni Notre Père.
- **Complies des jeudi et vendredi saints** : Ps 90 ; antienne *Christus factus est* au lieu
  du répons ; Nunc dimittis sans antienne ; oraison ; ni bénédiction ni Salve Regina.
- Pas de doxologie après les psaumes et cantiques.
En répartition romaine, ce sont les offices de l'AELF.

## Signaler une erreur

Pour signaler une faute, il suffit de **sélectionner le passage** (au doigt ou à la souris) : une bulle
« Signaler » apparaît dessous. On peut aussi utiliser le lien « Signaler une erreur dans cet office », tout en
bas de l'office, ou celui qui se trouve sous chaque partition dépliée. Une phrase d'explication est facultative,
puis on appuie sur « Envoyer ». La date, l'office, la version, le psaume ou la lecture et l'origine du texte
sont joints automatiquement. Rien de tout cela n'est imprimé.

- Sans connexion, le signalement est gardé sur l'appareil et part tout seul quand le réseau revient.
- Sur cet ordinateur (« Lancer le bréviaire »), les signalements arrivent dans le dossier `signalements/`
  (un fichier par mois). Pour en avoir la liste rangée :
  `python3 outils/signalements.py` → `signalements/a-traiter.md`. Un signalement traité : recopier son
  identifiant dans `signalements/traites.txt` (ou bouton « Marquer comme traité » de la page
  http://localhost:8765/signalements.html). Vous pouvez aussi simplement me dire « traite les signalements ».
- **Sur le site en ligne**, les signalements arrivent sur Azure (table `signalements`). Pour les lire : Réglages (⚙)
  → « Signalements d'erreurs reçus » (page `signalements.html`). La page est réservée aux comptes qui ont le rôle
  « signalements » (donné dans la page Comptes, voir `docs/CONNEXION.md`). Chaque signalement a un bouton
  « Ouvrir l'office » et un bouton « Marquer comme traité ».
- Sur l'ordinateur, `python3 outils/signalements.py --azure` récupère aussi ceux du site en ligne.

## Lire les offices sans réseau

Réglages (⚙), bloc « Hors connexion » : choisissez une semaine, 30 jours ou une période, puis « Enregistrer ».
Les cinq offices de chaque jour sont gardés sur l'appareil, dans la version choisie (avec ses partitions).
Il faut être connecté pendant l'enregistrement ; comptez environ 75 Mo pour 30 jours avec partitions.
« Effacer » libère la place. Sur iPhone ou iPad, ajoutez d'abord le site à l'écran d'accueil.

## Bénédiction de la table

Menu « Bibliothèque » → « Bénédicité » : la page `table.html` donne, pour la date
choisie, la bénédiction de midi, celle du soir et l'action de grâces après le repas, d'après le livret
« Bénédictions du repas » de la Province de Toulouse (version corrigée « A4 Garamond-1 »).
- **Midi** : la formule propre quand le livret en donne une (temps de Noël, Carême, Semaine sainte, Pâques,
  Ascension, Pentecôte, Trinité, Sacré-Cœur, fêtes de la Vierge, apôtres, évangélistes, martyrs, défunts,
  saint Thomas, saint Joseph, saint Jean-Baptiste, Transfiguration, saint Dominique, Croix glorieuse,
  Archanges, saint François, Toussaint). Sinon, des quatre formules du jour de la semaine, celle qui porte
  le numéro de la semaine du psautier (I à IV). Les autres formules restent proposées, repliées.
  En Avent, la prière « Au temps de l'Avent » est proposée en plus.
- **Soir** : « Le jour déjà touche à sa fin… » avec la fin de phrase du jour ; le dimanche, la formule d'Emmaüs d'abord.
- « Imprimer » donne une page A5 (sans les formules repliées). La page s'ouvre aussi sans réseau.
Pour refaire les données après une correction du livret : `python3 outils/construire_table.py` ;
contrôle : `node tests/table.test.js` (ou `node tests/table.test.js 2026-12-25` pour voir un jour).

## Martyrologe et mémoire des frères défunts

Menu « Bibliothèque » → « Martyrologe », page `martyrologe.html` :
- menu « Lecture » : le jour même, ou la veille (on lit alors le martyrologe et les frères défunts du lendemain) ;
- les éloges du jour dans l'édition choisie (menu « Édition », retenu sur l'appareil) : martyrologe « romain »
  (fichier « Martyrologe romain 2014-2015 », Rangueil 2015), Marseille (couvent Saint-Lazare, 2020),
  Toulouse-Rangueil (2020, corrections du fr. Donneaud) ;
- les jours de fête mobile (Épiphanie avec l'annonce des fêtes de l'année, dates remplies ; Baptême, Cendres,
  Rameaux, Pâques, Ascension, Pentecôte, Trinité, Saint-Sacrement, Sacré-Cœur, Cœur immaculé, Christ-Roi,
  Sainte Famille), l'éloge propre vient d'abord ;
- la conclusion « Ailleurs enfin… », ou « Le même jour enfin… » au temps pascal ;
- « Mémoire de nos frères défunts » : les frères du Catalogus 2026 morts ce jour-là (année et lieu).
- Le 28 février des années non bissextiles, on lit aussi le 29 février (éloges et frères défunts).
  Les trois frères dont le catalogue ne donne que le mois sont nommés le 1er du mois.
Refaire les données : `python3 outils/construire_martyrologe.py` ; contrôle : `node tests/martyrologe.test.js`
(ou `node tests/martyrologe.test.js 2027-01-03 marseille`).

## Prières et formules (Compendium)

Menu « Bibliothèque » → « Prières » (`prieres.html`) : l'appendice du Compendium du Catéchisme de l'Église catholique
(vatican.va), plus le Credo et le Notre Père, rangés en six groupes :
1. Les prières de chaque jour (signe de croix, Notre Père, Je vous salue, Gloire au Père, deux Credo) ;
2. Avec la Vierge Marie (Angélus, Regina cæli, Salve Regina, Sub tuum, Souvenez-vous, Rosaire, Magnificat) ;
3. Le Christ et l'Esprit Saint (Veni Creator, Veni Sancte Spiritus, Âme du Christ, Te Deum, Benedictus) ;
4. Actes et prières personnelles (actes de foi, d'espérance, de charité, de contrition ; Ange de Dieu ; Repos éternel) ;
5. Prières des Églises d'Orient (français seulement) ;
6. Formules de la doctrine (dix commandements, deux commandements, règle d'or, Béatitudes, préceptes, vertus, dons,
   fruits, œuvres de miséricorde, péchés capitaux, fins de l'homme).
- Rangées comme un livre (19/11/2026) : une **table des matières** en six chapitres ; on ouvre une prière, ou un chapitre entier,
  avec « Précédent / Suivant » et un fil « Prières › chapitre › prière ». Rien ne dépend du jour.
- En haut : recherche (sans accents, résultats en liste), et le choix **Français / Les deux / Latin** (retenu sur l'appareil). En « Les deux »,
  le français et le latin sont mis ligne à ligne en regard quand ils ont le même découpage, sinon côte à côte
  (l'un sous l'autre sur téléphone).
- Latin des Béatitudes, de la règle d'or et des deux commandements : Nova Vulgata (le Compendium ne les donne qu'en français).
  Les listes (vertus, dons, péchés…) n'ont pas de latin dans la source.
Refaire les données : `python3 outils/construire_prieres.py` ; contrôle : `node tests/prieres.test.js`.

## Barre des menus, Messe, Bibliothèque

En haut de chaque page : **Office · Messe · Bible · Bibliothèque**. Les réglages sont dans la barre des offices, à droite de
« PDF / Word ».
- **Messe** : la messe du jour, dans l'ordre de la célébration : antienne d'ouverture et prière (Missel romain), lectures, psaume
  et acclamation (AELF), prière sur les offrandes, antienne de la communion, prière après la communion, prière sur le peuple
  (Missel). Quand le jour a plusieurs messes (Noël, Pâques, Ascension…), on les choisit dans les onglets. Les jours de saint, un menu « Messe : »
  propose la messe du saint (sanctoral du Missel, propre de France) ou celle de la férie, comme le choix d'office ; ce que le saint n'a
  pas en propre (souvent tout sauf la prière, pour une mémoire) est pris au commun indiqué par le Missel (« Du commun ») ou, à défaut, à la férie (« De la férie »).
  Le Gloria et le Credo s'ajoutent à leur place quand le Missel les prescrit (le latin est replié dessous).
  Refaire les données du Missel : `python3 outils/construire_missel.py`.
- **Bibliothèque** : Bénédicité, Prières, Martyrologe, Frères défunts (mémoire du jour, De profundis, nécrologe complet avec recherche).

## Complies : chants grégoriens du livret de Bordeaux dans toutes les versions

Dans les versions **Romaine** et **latin-français**, les complies se terminent par une section « Chants grégoriens (complies de
l'Ordre, Bordeaux 2009) » : introduction, hymne, répons, antienne du cantique de Syméon, prière, bénédiction et antiennes de la
procession, chacune repliée (on déplie celle qu'on chante). Les pièces sont choisies selon le temps et le jour, comme dans les
versions de la Province. (Les versions Province et Gouzantine avaient déjà ces partitions ; la version « 100 % AELF » n'en a pas.)

## Version « Sainte-Baume » (livrets de fr. Max)

Réglages → Version de l'office → **Sainte-Baume**. C'est le romain gouzantin (carnets de la Province, partitions
repliées) complété par les livrets de fr. Max (`sources_gouzes/sainte-baume/`, `outils/construire_sainte_baume.py`
→ `site/donnees/sainte_baume.json`) : Carême (vigiles, laudes, vêpres : antiennes, lucernaire, hymnes au choix,
répons, canon de saint André), milieu du jour toute l'année (psaumes de la semaine, antienne et verset), et,
au temps ordinaire, les antiennes du tableau « Antiennes des offices Ste Baume ». Les partitions sont celles
gravées depuis les sources LilyPond de Gouzes (`partitions/ly/`). Les partitions de la Vigile pascale sont
posées dans la page Messe. Fêtes et solennités : romain gouzantin. Contrôle : `node tests/saintebaume.test.js`.

## Propre de l'Ordre des Prêcheurs

- **Calendrier** : `site/donnees/propre_op.json`, tiré du calendrier du Missel de l'Ordre (édition provisoire de
  juin 2026), avec les degrés de la Province de Toulouse (`outils/construire_missel_op.py`). Bouton « Calendrier OP »
  de la page des offices. La Dédicace de l'église dont on ignore la date (22 octobre) est proposée au choix.
- **Offices** : quand les carnets du sanctoral de la Province donnent l'office d'une fête de l'Ordre (12 fêtes,
  26 offices : S. Thomas, S. Dominique, Ste Catherine…), il est pris tel quel (hymne, psaumes, antiennes, répons ;
  `outils/offices_op.py` → `offices_op.json`), avec la prière du Missel de l'Ordre. Sinon, le commun des saints
  est appliqué d'office (voir ci-dessous). Versions Province et Sainte-Baume.
- **Messe** : messes du Missel de l'Ordre et lectures du Lectionnaire de l'Ordre, en plus du Missel romain ;
  bouton « Missel OP » pour le consulter. Contrôles : `node tests/missel_op.test.js`, `node tests/offices_op.test.js`.

## Communs des saints

Bouton « Communs » de la page des offices, et menu « Commun : » sous le titre les jours de saint : on choisit un
commun des « Heures grégoriennes » (tome III, `outils/construire_communs.py` → `partitions/hg/communs.json`),
sa précision (« pour un évêque »…) et les psaumes (du commun ou de la férie). Le choix est retenu pour la date.
Appliqué d'office aux célébrations de l'Ordre que l'AELF ne fournit pas. Contrôle : `node tests/communs.test.js`.

## Messe : Missel romain et Triduum

Propres du temporal et du sanctoral (`sources_missel/`, `outils/construire_missel.py` → `site/donnees/missel.json`),
communs, Gloria et Credo à leur place, livrets du Triduum (Cène, Passion à plusieurs voix, Vigile pascale) ;
lectures et psaume de l'AELF. Bouton « Missel » : consultation de l'ordinaire, des préfaces, des prières
eucharistiques, des bénédictions. Export PDF / Word comme pour les offices.

## La Bible

Menu « Bible » : la Bible de Jérusalem avec l'original (grec, hébreu), le latin (Nova Vulgata), les Pères (Chaîne
d'or), les dictionnaires, la Bible chrétienne, une recherche, et une vue interlinéaire sur ordinateur. Les données
sont tirées de Biblia Universalis par les programmes de `bible/` (voir `bible/LISEZMOI.md`) ; en ligne, elles sont
dans l'entrepôt Azure privé.
