# Bible chrétienne II* — Commentaires (numérisation)

Dom Claude Jean-Nesmy, Mère Élisabeth de Solms, Mère Cécile Miville-Dechêne, *Bible chrétienne II\* — Commentaires*, Anne Sigier / Desclée, 1988. Commentaire des quatre Évangiles, découpé en § (péricopes de la synopse, § 1 à 376), avec les Pères et les textes de l'Ancien Testament.

Le PDF de départ est un scan sans texte (436 planches doubles, pages IX à 792). Il n'est ni copié ni modifié.

## Refaire le travail

```bash
bash bible/bible-chretienne/ocr.sh "chemin/du/livre.pdf"   # OCR, environ 10 min, déjà fait
python3 bible/bible-chretienne/table.py                    # Table générale -> table.json
python3 bible/bible-chretienne/analyse.py                  # livre.json, livre.md, ../data/bc/
```

`ocr.sh` saute les pages déjà faites. Pour améliorer le résultat, il suffit de corriger `analyse.py` puis de le relancer : l'OCR ne se refait pas.

## Ce qui est produit

| | |
|---|---|
| `ocr/NNN-g.txt`, `NNN-d.txt` | texte brut de chaque page (g = gauche, d = droite de la planche NNN) |
| `table.json` | la Table générale : pour chaque §, page, titre, partie, section, références Mt/Mc/Lc/Jn |
| `livre.json` | le livre structuré : l'introduction, puis 370 sections (§ ou groupes de §). Chaque section a un titre, une page et ses versets ; ses paragraphes sont typés |
| `livre.md` | le même texte, lisible, pour relire. Chaque paragraphe indique sa page |
| `../data/bc/index.js` | pour la web app : la liste des § et, pour chaque livre et chapitre, les § qui le commentent |
| `../data/bc/s/NNN.js` | pour la web app : une section complète (`window.__BC`) |

Les types de paragraphes sont les suivants :

- `texte` : le commentaire courant ;
- `verset` : un paragraphe qui commence par des références (« Mc 4,38; Lc 8,24; (Mt 8,25) — … »). Il est rattaché à ces versets (`refs`) ;
- `pere` : une citation d'un Père ou d'un auteur (« JÉRÔME : … »), avec son auteur ;
- `at` : un texte de l'Ancien Testament mis en regard (le signe ▸ du livre) ;
- `note` : une note de bas de page.

Les codes des livres (MAT, MRK, LUK, JHN) et la forme des fichiers (`window.__…` par fichier) suivent ceux de la Chaîne d'or (`data/tae/`). Elles sont utilisées par la page téléphone (`lectio.js`) : repères de § dans le texte, bouton « ✦ Commentaire », section dans Éclairages, page `#/bc/NNN`, sommaire `#/bc`. Voir `../LISEZMOI.md`. `analyse.py` efface et refait `data/bc/` à chaque passage ; l'autre volume (BC II, le texte) est rangé à part, dans `data/bct/`.

## Correction de l'OCR

`analyse.py` passe désormais chaque paragraphe au correcteur du volume de texte (`textes/corrige.py` : lexique de la BJ, correcteur orthographique de macOS, latin de la Vulgate, choix d'après le contexte). Il applique ensuite les corrections choisies à la main de `corrections_manuelles.tsv`. Toutes les corrections sont relevées dans `corrections.tsv`. Le détail est dans `textes/LISEZMOI.md`.

Pour essayer sans réécrire `../data/bc`, préfixer la commande par `BCT_SANS_DATA=1`.

## Limites connues

- C'est un **texte d'OCR corrigé automatiquement et en partie à la main**, mais pas relu en entier. Il reste des fautes, surtout dans les passages en colonnes, les sigles et le grec translittéré.
- Quelques paragraphes sont coupés au mauvais endroit, ou reçoivent à tort le type « Père ».
- Quelques § de la table n'ont pas de titre propre dans le texte (8, 93, 198, 200, 201, 277, 336, 341, 343, 344, 350…). Ce sont pour la plupart des renvois (« Voir au § … ») ou des § commentés avec un autre.
- `data/` est copié par `preparer_site.sh` : la prochaine publication mettra donc `data/bc/` en ligne (environ 5 Mo). Le site approche la limite d'Azure (environ 482 Mo sur 500 Mo avec `data/latin`) : vérifier la taille avant de publier. C'est un livre sous droits (© Anne Sigier et Desclée, 1988).
