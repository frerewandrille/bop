# Bible chrétienne II — Les quatre Évangiles (numérisation)

Mère Élisabeth de Solms (traduction), Dom Claude Jean-Nesmy (parallèles), Mère Cécile Miville-Dechêne, *Bible chrétienne II — Les quatre Évangiles*, Anne Sigier / Desclée, 1988.

C'est le volume de **texte** : les quatre Évangiles en synopse, découpés en 376 § (plus le § 28 bis), chacun accompagné de ses **textes parallèles** de l'Ancien et du Nouveau Testament. Le volume des **commentaires** (II\*) est traité à part, dans le dossier parent `bible-chretienne/`. Les deux volumes utilisent la même numérotation des §.

Le PDF de départ est un scan sans texte de l'Internet Archive : 348 planches doubles, pages 2 à 653. Il n'est ni copié ni modifié.

## Refaire le travail

```bash
bash bible/bible-chretienne/textes/ocr.sh            # OCR, environ 4 min (déjà fait ; les pages faites sont sautées)
python3 bible/bible-chretienne/textes/analyse.py     # table.json, livre.json, livre.md, ../../data/bct/  (2 s)
```

Pour améliorer le résultat, il suffit de corriger `analyse.py` puis de le relancer : l'OCR ne se refait pas. Les erreurs de la Table générale se corrigent dans `CORRECTIONS_TABLE`, en tête du script.

## Ce qui est produit

| | |
|---|---|
| `travail/ocr/pPPP-1.tsv`, `-2.tsv` (et `.txt`) | OCR de chaque page, avec la position des mots (1 = page gauche, 2 = page droite de la planche PPP) |
| `travail/table/` | la Table générale relue à 500 dpi |
| `table.json` | la Table générale : pour chaque §, page, titre, partie, section, références Mt/Mc/Lc/Jn (ou renvoi « (§ 147) ») |
| `livre.json` | le livre structuré, § par § (voir ci-dessous) |
| `livre.md` | le même, lisible, pour relire |
| `../../data/bct/index.js` | pour la web app : `window.__BCT_INDEX` |
| `../../data/bct/s/<clé>.js` | pour la web app : un § complet, `window.__BCT` |

Chaque § contient :

- `n`, `titre`, `page`, `pages`, `partie`, `section` ;
- `refs` : les passages, `[code, ch1, v1, ch2, v2]` (codes MAT, MRK, LUK, JHN, comme dans `data/`) ;
- `table` : les références telles que la Table les donne, renvois compris ;
- `evangiles` (`ev` dans `data/bct`) : pour chaque Évangile, la liste `[ch, v, texte]` dans la traduction de Mère de Solms ;
- `paralleles` (`par`) : `ref` (« Dt 8,3 »), `livre`, `ch`, `v`, `theme` (le petit titre rouge du groupe, « Au principe »), `texte`, `page`, et parfois `marge` (références complémentaires de la marge).

`index.js` contient `sections` (la liste des §), `num` (n° de § → clé de fichier : « 28 bis » → `28bis`) et `chap` (`chap.MAT["5"]` → les § qui contiennent Mt 5).

## Comment le texte est reconnu

- Les § viennent de la **Table générale** (p. 645-653). La page 645 (§ 1-27), mal lue, est saisie à la main dans le script.
- Le changement de § se lit dans le **titre courant** des pages de gauche (« § 49-50 ») et dans les titres « 49. VOCATION DES DOUZE APÔTRES ».
- Le **texte des Évangiles** est découpé aux numéros de verset, puis chaque morceau est **rapproché du verset de la BJ** qui lui ressemble le plus (mots communs). C'est ce qui donne son Évangile, son chapitre et son verset, car les petits chiffres en exposant sont souvent mal lus. Environ 93 % des versets attendus sont retrouvés.
- Un **parallèle** est un bloc qui commence par une référence (« Dt 34 ») ; son premier verset est retrouvé de la même façon dans la BJ.

## Correction des fautes d'OCR (`corrige.py`)

Le même correcteur sert aux deux volumes : `textes/analyse.py` l'applique au texte (versets, parallèles, titres), et `../analyse.py` au commentaire (paragraphes, titres). Il juge **mot à mot, d'après le contexte**, puis applique les **corrections choisies à la main**.

1. **Références**
   - Le texte de la BJ : 27 000 formes, leurs fréquences, les paires de mots voisins.
   - Le **correcteur orthographique français de macOS** (`orthographe_mac.js`). Tout mot qu'il reconnaît est tenu pour juste et n'est pas touché, sauf contexte flagrant (« tes veux » → « tes yeux »). Ses réponses sont gardées dans `travail/orthographe_mac.tsv`.
   - Le latin de la Vulgate de l'application : les citations latines ne sont jamais corrigées.
   - Le vocabulaire des dictionnaires bibliques de l'application.
2. **Pour un mot faux**, il compare les propositions de macOS et les confusions typiques de l'OCR, et garde celle qui s'accorde le mieux avec les mots voisins :
   - 1/l/i, J/f, r/t, c/e, v/y, accents ;
   - première lettre perdue au bord d'une colonne (« es frères » → « ses frères ») ;
   - mots collés (« Carilest » → « Car il est ») ;
   - trait d'union perdu (« Retiretoi » → « Retire-toi ») ;
   - apostrophe perdue (« J al » → « j'ai »).

   Une proposition n'est retenue que si elle ressemble à une vraie faute d'OCR : lettre fine oubliée, trait parasite, lettre de forme voisine, jamais la fin du mot (accord, conjugaison).
3. **Ce qui n'est jamais touché**
   - les noms à majuscule en milieu de phrase, et les noms d'auteurs après une initiale ;
   - les sigles et les petites capitales ;
   - les mots grecs ou latins entre guillemets ;
   - les morceaux de mots coupés en fin de ligne.
4. **Corrections choisies à la main**, pour les passages que seul le contexte permet de rétablir (colonnes entremêlées, renvois de marge, mots tronqués) :
   - `corrections_manuelles.tsv` pour le volume II ;
   - `../corrections_manuelles.tsv` pour le commentaire.

   Une ligne = forme lue, tabulation, forme corrigée. On peut en ajouter, puis relancer les deux scripts.

**Relevés.**
- Toutes les corrections faites : `corrections.tsv` (volume II) et `../corrections.tsv` (commentaire), avec le nombre de fois, la forme lue et la forme corrigée. Les choix manuels y sont marqués « (choix) ».
- Les mots qui restent inconnus de tous les lexiques : `python3 bible/bible-chretienne/textes/outils_douteux.py` les écrit, avec leur contexte, dans `travail/douteux_II.txt` et `travail/douteux_II_etoile.txt`. Ce sont surtout des noms propres, du grec translittéré et des termes savants justes.

**Tester une phrase** : `python3 bible/bible-chretienne/textes/corrige.py "Carilest écrit"`.

## Limites connues

- **Texte corrigé, mais pas relu en entier par une personne**. Il reste des fautes :
  - des mots justes en eux-mêmes mais faux dans leur phrase, que le correcteur n'a pas osé changer ;
  - des passages où deux colonnes se sont mêlées ;
  - quelques débris de références de marge.

  La ponctuation n'est pas corrigée.
- Les **chiffres cerclés** ①–⑥ (type de parallèle : historique, messianique, moral, eschatologique, thématique, harmonique) ne sont pas reconnus par l'OCR. Ils ne sont donc pas dans les données.
- Quelques textes parallèles sans référence lisible sont pris pour la suite du parallèle précédent, ou rattachés à tort à un verset d'Évangile.
- Un verset coupé entre deux pages peut être partagé entre deux §.
- Dans la web app, ces données forment les onglets *Synopse* et *Mis en regard* de la page d'un § (`#/s/<clé>`, voir `../../LISEZMOI.md`). Attention : `preparer_site.sh` copie `data/`, donc la prochaine publication mettrait en ligne `data/bct` (2,4 Mo). C'est un livre sous droits (© Anne Sigier et Desclée, 1988).
