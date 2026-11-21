# Partitions gouzantines : inventaire et plan — 19/11/2026

## Ce qu'il y a

### 1. `~/Downloads/Partitions gouzantines` — les fichiers sources des partitions (LilyPond)

LilyPond est un logiciel de gravure musicale : chaque pièce y est **écrite en texte** (notes, paroles,
voix). On peut donc la regraver nettement, la corriger note par note, en changer la taille ou le ton.
C'est la « notation modifiable » qui manquait jusqu'ici (voir CLAUDE.md, 16/11 : « il faudrait les
sources des éditeurs »). Les fichiers viennent d'un ordinateur Linux (« frmatthieu »), version 2.24.

| Dossier | Pièces .ly | Remarque |
|---|---|---|
| Antiennes | 583 | nom = début du texte + **cote** (« À toi la louange B122 ») ; refrain à 3-4 voix + soliste |
| Hymnes | 152 | 70 PDF déjà gravés à côté |
| Répons | 154 | + 3 .doc (répons laudes/vêpres, mémoire des saints, vigiles) et Refrains.ods |
| Communions, Alléluias, Ordinaires | 27 + 25 + 29 | messe : Gayraud, Sylvanès, 1er mode, Credos, Notre Père K062, quelques .gabc grégoriens |
| Présidence | 35 | Preces I-VIII et Carême, « Seigneur, ouvre mes lèvres », « Dieu, viens à mon aide », Bénissons |
| Cantiques NT | 14 | Ph 2, Col 1, Ep 2, Ap 4-5, 11-12, 15, 19, 1 P 2, Rm 6… |
| Veillée pascale | 17 (+19 archives) | Exsultet 2021, répons après chaque lecture |
| Tons, Antiennes3vx, Divers | 10 + 7 + 2 | tons des psaumes |
| Fichiers techniques | 90 | `vowel-set.ly`, `TonsDef.ly`… (nécessaires pour graver) + **Index gouzantinus.ods** |

- 1 164 fichiers .ly (+ 773 copies de sauvegarde `.ly~` à ignorer), 95 PDF.
- **721 cotes distinctes** ont leur source. Le site (gouzes.json) utilise 535 cotes : **361 ont leur source
  LilyPond**, 174 non (surtout les « Alleluia » B401-B406, des pièces A, B5xx, B9xx…).
- `Index gouzantinus.ods` : 846 lignes psaume ↔ cote ↔ texte de l'antienne (classées par psaume,
  par lettre, par ordre alphabétique, Pâques, Noël).
- 5 PDF ne sont que des liens Linux cassés (91 octets) : sans importance.

### 2. Drive LITURGIE/03-Gouzes/GOUZES LIVRETS ORIGINAUX — les livrets imprimés, scannés

35 PDF, 549 Mo, **images scannées à 600 dpi sans texte** : Vigiles (A, 144 p.), Laudes (B, 214 p.),
Vêpres (C, 118 p.), Cantiques NT, Dans la paix (complies, D), Avent (G), Noël (H), Épiphanie (J),
Carême (K), Semaine sainte I-II (L), Vigile pascale et Pâques I-III (M, N), Vierge Marie (S),
Apôtres (T), et pour la messe : Sylvanès, Rangueil/Ermitage/Noël, Huit messes brèves, Alléluias,
chants d'entrée/méditation/offertoire, dominical A/B/C, psaumes Bayard A/B/C.
Chaque page porte en tête la cote imprimée (« B 012 — LAUDES — Hymne du matin : 2e semaine ») : la
lettre de la cote = le livret (B = Laudes, K = Carême…).

## Ce qu'on peut en faire

1. **Graver les partitions gouzantines depuis les sources** (cœur du chantier) : chaque pièce devient
   une image vectorielle nette (SVG), juste la pièce, à la bonne largeur, au lieu d'une découpe de page
   scannée. Rattachement direct par la **cote**, que `gouzes.json` connaît déjà → beaucoup plus de
   pièces trouvées dans la version gouzantine (couverture mesurée le 16/11 : 209/583).
2. **Corrections faciles** : une fausse note se corrige dans le .ly et se regrave (au lieu de
   remplacer une image dans `partitions/corrections/`).
3. **Pour le téléphone** : possibilité de graver aussi la seule mélodie (sans alto/basse), plus lisible.
4. **Livrets scannés** = repli pour les 174 cotes sans source, et contrôle visuel des gravures.
5. **Plus tard, pour la page Messe** : alléluias, communions, ordinaires, Exsultet, Veillée pascale.

## Action proposée

**Étape 1 — essai (environ une heure, rien de publié)**
- Installer LilyPond sur ce Mac (`brew install lilypond`, version 2.26 : outil de fabrication
  seulement, rien n'est ajouté au site). Les fichiers 2.24 se convertissent avec `convert-ly`.
- Copier les sources dans `sources_gouzes/lilypond/` (sans les `.ly~`), les fichiers techniques à
  côté pour que les `\include` fonctionnent.
- Graver 10 pièces variées (antienne, hymne, répons, cantique NT, preces) en SVG recadré ;
  les comparer aux pages scannées des livrets ; vous montrer le résultat.

**Étape 2 — tout graver et brancher**
- `outils/graver_lilypond.py` → `partitions/ly/<cote>.svg` + `partitions/ly/index.json`
  (cote, titre, dossier, psaume d'après l'Index gouzantinus) ; rapport des pièces qui ne se gravent pas.
- `partitions.js` : dans la version gouzantine (et Province quand la cote est connue), la gravure
  LilyPond passe avant les découpes de pages ; repli sur l'existant sinon.
- Contrôle : relevé des images sur l'année, audit, PDF A5 regardé, Word (les SVG devront être
  convertis en PNG pour Word).

**Étape 3 — compléments** : livrets scannés pour les cotes manquantes ; répons des .doc ;
mélodie seule pour le téléphone ; matériel de messe.

## Questions pour vous

- Accord pour installer LilyPond sur le Mac ?
- Les partitions gravées seront-elles publiées en ligne (site protégé par connexion) ? Ce sont des
  compositions d'André Gouzes (droits de Sylvanès) : comme pour les carnets, à votre appréciation.
- Ces sources sont-elles la version de référence (plus récente que les livrets imprimés) ?

## Résultat de l'essai — 19/11/2026

- LilyPond 2.26 installé (Homebrew). Sources copiées dans `sources_gouzes/lilypond/` (sans les `.ly~`, 35 Mo).
- ~90 fichiers étaient des liens Linux devenus de petits fichiers texte (« /home/frmatthieu/… ») : une même pièce
  rangée sous plusieurs cotes (ex. « Tu es mon Fils » J151 = C203 = H851 = S151), et `TonsDef.ly` / `TonsRDef.ly`.
  Rétablis en vrais liens ; 2 introuvables retirés (`0Antiennes.pdf`, « Marie, cours vers tes frères »).
- `outils/graver_lilypond.py` : grave en SVG recadré, inclut d'office `vowel-set.ly`, `TonsDef.ly`, `TonsRDef.ly`
  (leur `\include` est en commentaire dans la plupart des fichiers).
- **1 004 pièces gravées sur 1 049** sans retouche ; 718 cotes ; **360 des 535 cotes du site**.
  Échecs : surtout Présidence (17), Alléluias (6), Hymnes (6), Veillée pascale (5) — non examinés.
- Comparé au livret de Carême scanné (K049 « Ô Créateur », p. 28) : même mélodie, mêmes paroles.
- Poids : ≈ 100 Ko par SVG (99 Mo pour tout) : à alléger avant publication (les glyphes sont recopiés dans chaque fichier).
- Différences avec les PDF de l'auteur : pas de titre, pas son réglage de mise en page (`Ft-*.ly`), syllabes non
  centrées sur la voyelle (`centrer`, désactivé dans les sources). Police du texte : celle de LilyPond (pourrait être Kepler).
- Livrets scannés : la cote en tête de page se lit par OCR (tesseract) sur une partie des pages seulement
  (« K 001 - CAREME - Lucernaire » oui, d'autres non) ; pages en vis-à-vis.

## Étape 2 faite — 19/11/2026

Branché dans la version gouzantine (voir CLAUDE.md, « Sources LilyPond »). Images en PNG gris allégé (10,7 Mo pour les
355 images utilisées, au lieu de 82 Mo en JPEG). Rapport des rattachements : `partitions/ly/rapport.md`. Non publié.
