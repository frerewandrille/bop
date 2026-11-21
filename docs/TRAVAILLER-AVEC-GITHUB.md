# Travailler avec GitHub — modifier, sauvegarder, publier, collaborer

Notice pour fr. Wandrille et pour toute personne invitée à travailler sur le bréviaire.
Écrite le 20/11/2026.

---

## 1. Le principe : deux outils, deux rôles

| Outil | À quoi il sert | Qui peut s'en servir |
|---|---|---|
| **GitHub** (dépôt privé `frwandrille/psautier`) | Garder l'historique de chaque modification (sauvegarde), travailler à plusieurs, relire les changements des autres | Vous et les personnes que vous invitez |
| **Votre Mac** (`bash outils/publier_azure.sh`) | Mettre le site en ligne sur Azure | Vous seul (le Mac a les clés d'Azure) |

GitHub **ne publie rien**. Une modification envoyée sur GitHub n'apparaît sur le site
qu'après une publication faite depuis le Mac. Vous restez donc maître de ce qui est en ligne.

Pourquoi ne pas faire publier GitHub automatiquement ? Parce que la publication a besoin de
choses qui ne sont pas (et ne doivent pas être) sur GitHub : les données de la Bible
(`bible/data/`), les mots de passe et clés, l'accès à l'entrepôt des images, et le relevé des
partitions utilisées (20 à 40 minutes dans un navigateur). On pourra y revenir plus tard.

---

## 2. Ce qui est sur GitHub, et ce qui n'y est pas

**Sur GitHub** : le site (`site/`), les programmes (`outils/`), les tests (`tests/`), les
partitions (`partitions/`), les sources (`sources_*`), les notices (`*.md`).

**Jamais sur GitHub** (exclus par le fichier `.gitignore`) :
- les mots de passe et clés : `.cle_signalements.txt`, `.cle_comptes.txt`, `.secrets_connexion/` ;
- les données de la Bible : `bible/data/` (reconstruites par `bible/extract.py`) ;
- les signalements reçus en local : `signalements/`.

⚠️ **Le dépôt doit rester privé.** Il contient des textes protégés (Bible de Jérusalem,
psautier, carnets de la Province, Heures grégoriennes, partitions de Gouzes). Toute personne
invitée voit **tous** ces fichiers : n'invitez que des personnes de confiance.

⚠️ Ne jamais ajouter de mot de passe ou de clé dans un fichier suivi par GitHub. Une fois
envoyé, il reste dans l'historique même si on l'efface ensuite.

---

## 3. Installer une fois pour toutes

1. Créer (ou retrouver) votre compte sur https://github.com.
2. Installer **GitHub Desktop** (gratuit) : https://desktop.github.com.
3. L'ouvrir, se connecter avec le compte GitHub.
4. Menu *File* → *Add Local Repository…* → choisir le dossier
   `~/Downloads/psautier`.

C'est tout. GitHub Desktop montre la liste des fichiers modifiés et, pour chacun, ce qui a
changé (en rouge : retiré ; en vert : ajouté).

---

## 4. Le rythme d'une modification

### a. Modifier
Seul, ou en demandant à Claude dans ce dossier. Avant de modifier à la main, lisez la
section « Règles à ne pas oublier » plus bas.

### b. Vérifier sur le Mac
```bash
python3 outils/serveur.py
```
Le navigateur s'ouvre sur http://localhost:8765 : regardez les offices concernés.
Pour arrêter le serveur : `ctrl + C` dans le terminal.

Puis les tests (ceux qui touchent à ce que vous avez modifié, ou tous) :
```bash
for t in tests/*.test.js; do echo "== $t"; node "$t" || break; done
```

### c. Sauvegarder sur GitHub
Dans GitHub Desktop :
1. vérifier la liste des fichiers modifiés (décocher ce qui ne doit pas partir) ;
2. écrire en bas à gauche une phrase qui dit ce qui a changé
   (ex. « Complies : antienne mariale du temps pascal corrigée ») ;
3. cliquer **Commit to main** (= enregistrer cette étape dans l'historique) ;
4. cliquer **Push origin** (= envoyer sur GitHub).

Sauvegardez souvent : une étape par modification cohérente, au moins une fois par jour de travail.

### d. Publier (quand vous le décidez)
Si les partitions ont changé, refaire d'abord le relevé des images utilisées :
```bash
node outils/releve_images.mjs
```
Puis :
```bash
bash outils/publier_azure.sh
```
Le détail (options, entrepôt, connexion) est dans `docs/MISE-EN-LIGNE-AZURE.md`.

### e. Revenir en arrière
Dans GitHub Desktop, onglet *History* : chaque étape enregistrée y figure. Clic droit sur une
étape → *Revert changes in commit* annule cette étape (en créant une nouvelle étape, rien n'est
perdu). En cas de doute, demandez à Claude avant de cliquer.

---

## 5. Inviter un collaborateur

1. Sur github.com, ouvrir le dépôt `frwandrille/psautier`.
2. *Settings* → *Collaborators* → *Add people* → saisir son identifiant GitHub.
3. Il reçoit une invitation par courriel et l'accepte.

### Protéger la version principale (à faire une fois)
Pour que rien n'entre sans votre accord :
*Settings* → *Branches* → *Add branch ruleset* (ou *Add rule*) → branche `main` →
cocher **Require a pull request before merging**.

### Comment travaille le collaborateur
1. Il installe GitHub Desktop, puis *File* → *Clone Repository…* → `frwandrille/psautier`
   (le dépôt pèse environ 1,6 Go : le premier téléchargement est long).
2. Avant de modifier, il crée sa propre copie de travail : menu *Branch* → *New Branch…*,
   avec un nom parlant (ex. `hymnes-avent`).
3. Il modifie, vérifie (`python3 outils/serveur.py`), enregistre (*Commit*) et envoie (*Push*).
4. Il clique **Create Pull Request** : c'est une proposition de changement, qui s'affiche sur
   github.com.

Ce qu'il ne pourra pas faire : publier sur Azure, ni voir la Bible complète en local
(les données `bible/data/` ne sont pas sur GitHub ; le reste du site fonctionne).

### Comment vous relisez une proposition
Sur github.com, onglet **Pull requests** :
- *Files changed* montre chaque modification ligne par ligne ;
- vous pouvez laisser un commentaire sur une ligne ;
- **Merge pull request** accepte la proposition ; *Close* la refuse.

Puis, dans GitHub Desktop, **Fetch origin** puis **Pull origin** pour récupérer sur le Mac ce
qui a été accepté, avant de vérifier et de publier.

Vous pouvez aussi demander à Claude : « relis la pull request n° 3 et dis-moi si elle casse quelque chose ».

---

## 6. Si un jour quelqu'un d'autre doit publier

À ne faire que si vous le décidez. Il lui faudrait :
- un accès à Azure : portail Azure → groupe de ressources `breviaire` →
  *Contrôle d'accès (IAM)* → *Ajouter une attribution de rôle* → rôle **Contributeur** ;
- une copie des données de la Bible (`bible/data/`) et des fichiers de secrets
  (à transmettre de la main à la main, jamais par GitHub) ;
- les outils du Mac : Azure CLI (`az login`), Node, Python, Brave.

Rappel : un verrou (`protection-breviaire`) empêche de supprimer quoi que ce soit dans ce groupe.

---

## 7. Règles à ne pas oublier

- Après toute modification d'un fichier `.js` ou `.css` : **changer son numéro `?v=N`** dans la
  page `.html` qui le charge, sinon les téléphones gardent l'ancienne version.
- Ne jamais réécrire `site/css/office.css` en entier : le modifier par petits morceaux.
- Ne jamais publier avec `--sans-connexion` : le site s'ouvrirait à tous.
- Faire tourner les tests avant de publier ; ils doivent rester verts.
- Garder à jour `CLAUDE.md` (carnet de bord du projet) : c'est lui que lit tout Claude qui
  reprend le travail, chez vous ou chez un collaborateur. Demandez à Claude de le compléter à
  la fin de chaque chantier.
- Ne pas déposer dans le dossier de fichiers de travail inutiles (images d'essai, `.zip`…) :
  ils partiraient sur GitHub.

---

## 8. Pour aller plus loin dans la reprise en main

À lire, dans cet ordre :
1. `README.md` — ce que fait le site, réglage par réglage ;
2. `FONCTIONNEMENT.md` — comment il est construit ;
3. `docs/MISE-EN-LIGNE-AZURE.md` — la publication en détail ;
4. `docs/MODE-D-EMPLOI-REGLAGES.md`, `docs/CORRIGER-UNE-PARTITION.md` — tâches courantes ;
5. `CLAUDE.md` — l'historique complet des décisions et les pièges connus.

Commandes en terminal (si vous préférez à GitHub Desktop) :
```bash
git status
```
```bash
git add -A && git commit -m "Ce qui a changé"
```
```bash
git push
```
```bash
git pull
```
