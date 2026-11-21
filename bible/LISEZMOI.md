# Bible de Jérusalem — lecture, original, lectio

Construit à partir des modules de **Biblia Universalis 3**, qui ne sont que *lus*, jamais modifiés.

Ce dossier `bible/` est un projet à part, rangé dans le dossier du bréviaire. En ligne, la Bible est publiée **avec le bréviaire, sous `/bible/`** du même site : <https://calm-flower-052e85c10.4.azurestaticapps.net/bible/>. Un bouton dans chaque barre du haut mène de l'un à l'autre.

## Mise en route

1. Extraire les données une fois, puis après chaque mise à jour de Biblia Universalis (environ 20 s) :

   ```bash
   python3 bible/extract.py
   ```
2. Double-cliquer sur **« Ouvrir la Bible (ordinateur et téléphone).command »**. La fenêtre qui s'ouvre affiche :
   - l'adresse à taper **sur le téléphone**, par exemple `http://192.168.1.20:8790/`. Le téléphone doit être sur le même Wi-Fi que l'ordinateur.
   - la marche à suivre dans Safari : **Partager → « Sur l'écran d'accueil »**. La page s'ouvre ensuite comme une application.

   Laisser la fenêtre ouverte pendant la lecture. Rien n'est publié sur Internet.

## Sur le téléphone (`index.html`)

- **Bible** : livres de l'AT et du NT, chapitres, texte de la BJ avec titres et notes. « Reprendre la lecture » rouvre le dernier passage lu.
- **Toucher un verset** affiche dessous le grec ou l'hébreu mot à mot, ou le latin, ou les deux (réglage ⚙︎, séparé pour l'AT et le NT). Apparaissent aussi les boutons :
  - *Retenir* ;
  - *Les Pères* (✠) ;
  - *Notes BJ* ;
  - *Thèmes*.
- **Toucher un mot latin** ouvre sa fiche : mot de base, sens en français, analyse, et lien vers le Gaffiot en ligne. Biblia n'ayant pas de dictionnaire latin, ces fiches viennent de **Collatinus** (logiciel libre, licence GPL) : `python3 -m venv bible/.venv-latin && bible/.venv-latin/bin/pip install pycollatinus==0.1.6`, puis `bible/.venv-latin/bin/python bible/latin.py` après chaque extraction. 93 % des mots sont reconnus (les autres sont surtout des noms propres) ; quand plusieurs analyses sont possibles, toutes sont données.
- **Toucher un mot** grec ou hébreu ouvre sa fiche : analyse, Strong, dictionnaire (Bailly, Sander-Trenel) et concordance.
- **Thèmes** : les articles des dictionnaires qui **citent ce verset**. Le *Vocabulaire de théologie biblique* vient en premier, puis Westphal, Calmet, le Nouveau dictionnaire biblique, etc. Par exemple, Mt 5,8 renvoie au VTB « Béatitude », « Cœur », « Face », « Pur », « Voir ».
- **Recherche** (onglet du bas, ou « Chercher dans la Bible… » à l'accueil) :
  - un ou plusieurs mots : les versets qui les contiennent tous, quelle que soit leur forme (*pardon* trouve *pardonner*) ;
  - `"entre guillemets"` : l'expression exacte ; `-mot` : sans ce mot ; `berger*` : les mots qui commencent ainsi ;
  - une référence (`Jn 3,16`, `1 Co 13`, `Psaume 23`) : on y va, et l'on voit les articles de dictionnaire qui citent le verset ;
  - un mot grec ou hébreu (`ἀγάπη`, `חסד`) ou un numéro Strong (`G26`) : sa fiche et sa concordance ;
  - les résultats se comptent par domaine (Bible, notes de la BJ, Vulgate — toutes les formes d'un mot latin —, Pères, dictionnaires, Bible chrétienne) et se filtrent par Testament ou par livre.
  Les index se refont avec `python3 bible/recherche.py` (après `extract.py`, `latin.py` et les données de la Bible chrétienne).
- **Dictionnaires** (onglet du bas) : recherche dans les huit dictionnaires, sans tenir compte des accents. Dans un article, les références bibliques et les renvois sont cliquables.
- **Un passage** : sous chaque titre de la BJ, « Ce passage › » ouvre la péricope seule, avec deux onglets en bas :
  - *Texte* : le passage, les versets retenus surlignés ;
  - *Éclairages* : les versets retenus ; les **Pères de l'Église** (Chaîne d'or de saint Thomas, évangiles seulement), avec un filtre par auteur ; les **thèmes du passage** (VTB) ; les notes de la BJ.
- **Carnet** : jour après jour, les versets retenus. Il est gardé **sur ce téléphone seulement** et peut être exporté en texte.
- **Bible chrétienne** (Jean-Nesmy, de Solms, Miville-Dechêne, 1988). Ses deux volumes sont réunis § par § : le texte des Évangiles en synopse (II) et le commentaire (II\*).
  - Une **page par §** (`#/s/27`), avec trois onglets en bas :
    - *Synopse* : le texte des Évangiles dans la traduction de Mère de Solms. Sur le téléphone, on passe d'un Évangile à l'autre ; sur un écran large, ils sont en colonnes côte à côte. Le n° de verset ouvre la BJ ;
    - *Mis en regard* : les textes de l'Écriture placés en face, groupés par thème, avec un filtre Ancien / Nouveau Testament ;
    - *Commentaire* : le volume II\*.

    L'onglet choisi est gardé d'un § à l'autre. En tête, les références ouvrent la BJ ; les renvois de la Table (« Mc : voir § 147 ») mènent à l'autre §.
  - Dans le texte des Évangiles, un **repère « § 27 Les tentations… »** au début de chaque § ouvre cette page, sur l'Évangile qu'on lisait. On peut le masquer dans ⚙︎.
  - Sous un verset que le commentaire vise précisément, un bouton **✦ Commentaire**.
  - Dans *Éclairages*, une section **Bible chrétienne** en tête.
  - Le **sommaire** s'ouvre depuis la carte « Les Évangiles en synopse », sous les livres du Nouveau Testament. Il suit le plan du livre.
  - Les anciennes adresses `#/bc/<n>` et `#/bct/<clé>` mènent à la nouvelle page.

  Le texte vient d'un OCR non relu. Voir `bible-chretienne/LISEZMOI.md` et `bible-chretienne/textes/LISEZMOI.md`.
- **Commentaires** : dans *Éclairages* comme dans l'onglet *Commentaire* d'un §, un bouton choisit entre **Bible chrétienne** (commentaire de Dom Jean-Nesmy, § par §) et **Chaîne d'or · les Pères** (saint Thomas d'Aquin, verset par verset). Le choix est gardé.
- **Hors connexion** (lien en bas de l'accueil et en tête des réglages ⚙︎, adresse `#/horsligne`). Chacun coche ce qu'il veut lire sans réseau ; des choix rapides sont proposés (« Lectio des Évangiles », « Toute la Bible »…). Les paquets :
  - les quatre Évangiles (8 Mo) ;
  - le reste du Nouveau Testament (9 Mo) ;
  - les Psaumes, avec le Psautier du bréviaire (5 Mo) ;
  - l'Ancien Testament (68 Mo) ;
  - la Bible chrétienne (5 Mo) ;
  - les Pères, la Chaîne d'or (7 Mo) ;
  - les dictionnaires (58 Mo) ;
  - les fiches des mots (38 Mo).

  Ce qui est enregistré se met à jour tout seul quand on l'ouvre avec du réseau. Décocher un paquet le retire de l'appareil. Le bréviaire garde son propre enregistrement (ses offices), avec un lien vers celui-ci.
  - `horsligne.py` écrit la liste des paquets (`data/horsligne.js`). Il est relancé par `preparer_site.sh`.
  - `sw.js` est le service worker de la Bible. Il ressert les fichiers enregistrés, qu'ils viennent du site ou de l'entrepôt Azure.
  - Test fait le 18/11/2026 dans un navigateur réel (Brave sans fenêtre) : « Lectio des Évangiles » enregistrée (20 Mo, 1 025 fichiers), puis serveur arrêté. Matthieu 5 et le commentaire du § 50 se sont rouverts ; un livre non enregistré affiche un message clair. Le navigateur intégré à l'application Claude n'accepte pas les service workers : on ne peut pas y tester cette fonction.
- **Plan de lecture proposé** : un petit lien tout en bas de l'accueil ; il ouvre, à la demande, la péricope du jour et la lecture cursive (tirées du projet voisin `lectio-biblique` s'il est présent).

## Sur l'ordinateur (`interlineaire.html`)

C'est la vue interlinéaire complète : la BJ à gauche, l'hébreu ou le grec mot à mot à droite. Le menu « Sous la BJ » propose grec, latin ou les deux, et un lien mène à la version téléphone.

## Fichiers

| | |
|---|---|
| `extract.py` | extraction : bibles (JER, ATI, NTI, LSS, NVU, VUC, SEP, SEF), lexiques HEB/GRC, Chaîne d'or (TAE), dictionnaires |
| `recherche.py`, `recherche.js`, `recherche.css` | recherche (index dans data/rech/, environ 46 Mo, dans l'entrepôt) |
| `latin.py`, `collatinus/lemmes.fr` | fiches des mots latins (Collatinus) |
| `peres.py`, `dicos.py`, `plan_lectio.py` | Chaîne d'or ; dictionnaires et index des citations ; lien avec le plan Lectio |
| `index.html`, `lectio.js/.css` | version téléphone (page d'accueil de la Bible) |
| `interlineaire.html`, `app.js`, `style.css` | vue interlinéaire (ordinateur) |
| `preparer_site.sh` | copie les fichiers publiables ; appelé par `../outils/publier_azure.sh` |
| `horsligne.py`, `sw.js` | lecture hors connexion : liste des paquets, service worker |
| `liens.js` | adresse du bréviaire pour le bouton de passage |
| `serveur.py` | serveur local pour le téléphone |
| `bible-chretienne/` | numérisation de la *Bible chrétienne II\** (commentaire) : OCR, analyse, puis `data/bc/` (`python3 bible/bible-chretienne/analyse.py`) |
| `bible-chretienne/textes/` | numérisation de la *Bible chrétienne II* (Évangiles en synopse, textes mis en regard) : `data/bct/` (`python3 bible/bible-chretienne/textes/analyse.py`) |
| `data/` | données extraites (environ 195 Mo), hors de git, reconstruites par `extract.py` |

## Mise en ligne

La Bible part avec le bréviaire :

```bash
cd ~/Downloads/psautier
bash outils/publier_azure.sh
```

Après une nouvelle extraction (`python3 bible/extract.py`), relancer cette même commande. La Bible est fermée par la même connexion par compte que le bréviaire (depuis le 19/11/2026 ; elle était publique du 18 au 19/11), et non indexée par les moteurs de recherche. Ensemble, bréviaire et Bible font environ 475 Mo pour 500 Mo permis par Azure.
