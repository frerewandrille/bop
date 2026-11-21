# Connexion par identifiant et mot de passe — comment elle marche

Demande du 19/11/2026 : remplacer le mot de passe commun du site par un **identifiant et un mot de passe
propres à chaque frère**, saisis **une seule fois par appareil**, sans compte Microsoft, Google ni courriel.

## Ce que voit un frère

1. Il ouvre le site : une page « Bréviaire dominicain — Connexion » s'affiche.
2. Il tape son identifiant (ex. `fr.pierre`) et son mot de passe.
3. Il arrive sur l'office du jour. Sur cet appareil, il ne retapera rien pendant **un an**, délai qui repart
   à chaque visite. Hors connexion, rien ne change (les offices enregistrés restent lisibles).

« Se déconnecter » (dans les réglages) efface la connexion de cet appareil.

## Ce que vous avez en main : la page « Comptes »

Page `comptes.html` (lien dans les réglages), ouverte avec la **clé d'administration** (demandée une fois) :
- créer un compte : identifiant, nom affiché, mot de passe (le site peut en proposer un) ;
- changer un mot de passe (frère qui l'a oublié) ;
- désactiver / réactiver un compte, ou le supprimer ;
- voir la date de dernière connexion de chacun.

Changer le mot de passe ou désactiver un compte **déconnecte ce frère sur tous ses appareils**.

### Inscription par la personne elle-même (ajout du 19/11/2026)

Sur la page de connexion, « Première visite ? Créer mon compte » : nom, identifiant (proposé d'après le nom,
ex. « Marie Dupont » → `marie.dupont`), mot de passe deux fois. Le compte est créé et la personne entre aussitôt.
Trois réglages, dans la page Comptes (bloc « Inscriptions ») :
- **Fermées** (par défaut) : seuls les comptes créés par vous ;
- **Libres** : toute personne qui a l'adresse du site peut se créer un compte. *Choix du lancement* : seuls des
  proches des frères connaissent l'adresse ;
- **Avec code** : il faut en plus le code d'inscription que vous donnez (le site peut en proposer un). *Prévu ensuite.*
Les comptes créés ainsi portent la mention « inscrit lui-même » ; vous pouvez les désactiver ou les supprimer.

## Comment c'est construit

> Le service de connexion est logé **à part**, sur un petit site Azure gratuit (`breviaire-connexion`) : logé dans le
> bréviaire lui-même, Azure tournait en rond et le site ne répondait plus (essai du 19/11/2026).

```
 navigateur ──► site (Azure)         refuse tout visiteur non connecté (règle Azure « authenticated »)
     │             │
     │             └─► « fournisseur de comptes » = notre service  /api/connexion/…
     │                   (même site, dossier api/connexion, sans dépendance)
     │                       ├─ page de connexion (identifiant + mot de passe)
     │                       ├─ vérifie le compte dans la table Azure « comptes »
     │                       └─ rend à Azure une attestation signée « c'est fr.pierre »
     └── mémoire de l'appareil : témoin « breviaire-compte », valable 1 an, renouvelé à chaque visite
```

- **Azure garde la porte** : toutes les pages, données, partitions et la Bible restent interdites sans
  connexion, exactement comme avec le mot de passe actuel. Seules la page de connexion, l'icône et le
  manifeste (nécessaires à l'écran d'accueil du téléphone) sont ouverts.
- **Notre service ne fait que dire qui est qui.** Il parle à Azure dans la langue standard des fournisseurs
  de comptes (OpenID Connect), celle qu'emploient Microsoft ou Google : Azure le traite comme l'un d'eux.
- Quand la session d'Azure expire, Azure redemande à notre service, qui reconnaît l'appareil (témoin d'un
  an) et répond aussitôt : le frère ne voit rien.
- **Mots de passe** : jamais gardés en clair, seulement une empreinte (scrypt) ; illisibles même pour vous.
  5 erreurs de suite → compte bloqué 15 minutes. Mot de passe libre : un caractère suffit (choix de l'utilisateur) ;
  un bouton peut en proposer un plus solide.
- **Comptes** : table `comptes` du compte de stockage qui garde déjà les signalements (aucun frais nouveau).

### Fichiers

| Fichier | Rôle |
|---|---|
| `api/connexion/index.js` | le service : page de connexion, attestation, comptes |
| `site/comptes.html` | page « Comptes » (vous) |
| `outils/connexion_azure.json` | réglages Azure de la connexion, ajoutés à la publication par `--connexion` |
| `outils/preparer_connexion.sh` | fabrique les secrets (clé de signature, clé d'administration) et les pose sur Azure |
| `tests/connexion.test.js` | essai complet sans Azure (`node tests/connexion.test.js`) |

### Réglages Azure (posés par `preparer_connexion.sh`, jamais dans git)

| Réglage | Contenu |
|---|---|
| `CONNEXION_CLIENT_ID`, `CONNEXION_CLIENT_SECRET` | identifient le site auprès du service |
| `CONNEXION_CLE_PRIVEE` | clé qui signe les attestations |
| `CONNEXION_ADMIN_CLE` | clé de la page « Comptes » (copie locale : `.cle_comptes.txt`) |
| `SIGNALEMENTS_STOCKAGE` | déjà en place : le compte de stockage |

## Mise en place, étape par étape

1. **Fait en local (19/11/2026)** : service, page Comptes, essai complet `node tests/connexion.test.js`.
2. **Essai sur Azure, sans toucher au site en ligne** *(votre accord requis)* : une petite Static Web App
   d'essai, Standard, avec une page vide (aucun texte protégé) et le service. On y vérifie : que Azure accepte
   notre service comme fournisseur ; la connexion depuis un ordinateur et depuis un téléphone (écran
   d'accueil compris) ; la durée réelle de la session Azure ; la déconnexion. Coût : quelques euros pour les
   jours d'essai, puis on la supprime.
   *Pourquoi pas sur le site lui-même ?* Le mot de passe actuel couvre aussi les environnements d'essai du
   site et empêcherait Azure d'interroger notre service.
3. **Création des comptes** *(vous)* : sur la page Comptes, avant la bascule, pour que chacun ait déjà le sien.
4. **Bascule** *(votre accord requis)* : publication avec `--connexion` ; puis vous retirez le mot de passe
   commun dans le portail Azure (« Mot de passe » → désactivé). Contrôle : un visiteur inconnu tombe sur la
   page de connexion ; un frère entre ; la Bible et les partitions s'affichent.
5. **Distribution** : vous donnez à chaque frère son identifiant et son mot de passe.

Retour en arrière possible à tout moment : republier sans `--connexion` et réactiver le mot de passe commun.

## Contournements possibles (bilan du 19/11/2026)

Constat ce jour-là : le mot de passe commun était **désactivé** sur Azure (site lisible par tous, clé de l'entrepôt comprise).

| Porte | Avec la connexion par compte |
|---|---|
| Pages, scripts, données, polices, Bible, partitions copiées dans le site | fermées (`/*` réservé aux connectés ; les routes existantes aussi, car la 1re règle qui correspond l'emporte) |
| Page de connexion, icônes, manifeste, robots.txt | ouverts (rien de protégé dedans) |
| Autres fournisseurs d'Azure (GitHub, Microsoft…) | désactivés d'office par un fournisseur personnalisé (documentation Azure) |
| Gestion des comptes | clé d'administration |
| Inscriptions « libres » | **porte ouverte voulue** : quiconque a l'adresse peut se créer un compte |
| Entrepôt (images des partitions, données de la Bible) | **corrigé** : plus de clé dans les pages ; chaque appareil connecté reçoit une clé de 30 à 45 jours, renouvelée seule ; l'ancienne clé longue est coupée à la bascule |
| Environnements d'essai d'Azure | aucun aujourd'hui ; chaque essai porterait sa propre configuration |
| Copies hors connexion sur un appareil | restent sur l'appareil d'un compte désactivé |

À vérifier sur le site d'essai : que la règle `/*` couvre aussi `/api/` (signalements) et que `/.auth/login/github` etc. répondent 404.

## Limites connues

- **Entrepôt des fichiers** (partitions, données de la Bible) : sa clé de lecture est écrite dans les pages,
  donc visible seulement par les personnes connectées. Un frère désactivé qui l'aurait recopiée pourrait encore lire
  ces fichiers jusqu'au changement de clé (`python3 outils/cle_entrepot.py --nouvelle`). Même situation qu'aujourd'hui.
- **iPhone, site ajouté à l'écran d'accueil** : il garde ses données à part de Safari ; une connexion dans
  chacun des deux sera sans doute nécessaire. À vérifier à l'étape 2.
- **Délai d'une désactivation** : effective quand la session Azure de l'appareil expire (durée à mesurer à
  l'étape 2 ; quelques heures selon les usages d'Azure).
- Sécurité moins forte qu'un compte Microsoft (pas de double vérification), suffisante pour des textes liturgiques.
