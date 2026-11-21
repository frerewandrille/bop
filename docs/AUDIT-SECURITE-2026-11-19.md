# Audit de sécurité — Bréviaire dominicain

**Date :** 19 novembre 2026
**Périmètre :** page d'accueil (`site/index.html`), site Azure `breviaire-dominicain`, service de connexion `breviaire-connexion`, fonctions `api/` (connexion, rôles, fichiers, signalements), entrepôt `breviairefichiers`, outils de publication.
**Méthode :** revue du code source (« boîte blanche ») et six requêtes de contrôle passives sur le site en ligne (en-têtes, redirections). **Pas** de test d'intrusion actif, pas de connexion au site en ligne, pas d'accès au portail Azure : les réglages du compte Microsoft/Azure (double authentification, droits, journaux) n'ont pas été vus.
**Classification :** document interne. Il décrit des points faibles : ne pas le diffuser au-delà de ceux qui administrent le site.

---

## 0. Décisions de l'administrateur (19/11/2026)

| Constat | Décision |
|---|---|
| C1 inscription libre | **Risque accepté** pour le lancement ; passage au mode « code » plus tard |
| C2 un seul Mac, un seul compte | **Retenu, priorité** : protéger d'abord Azure (double authentification, sauvegarde des secrets, puis second administrateur) |
| C3 mots de passe libres | **Risque accepté** |
| C4 appareils connectés sans fin | **Risque accepté** |
| C5 clé de l'entrepôt partagée | **Risque accepté** (enjeu limité, contournement délibéré nécessaire) |
| C6 en-têtes de protection | `X-Frame-Options` et `Permissions-Policy` **ajoutés** le 19/11 (en ligne à la prochaine publication) ; CSP écartée |
| C7 copies après déconnexion | **Risque accepté** |
| Clés d'accès (passkeys) | **Écarté** pour l'instant (complexité) |

---

## 1. Synthèse

| | |
|---|---|
| **Niveau de risque global** | **Modéré**, et bien maîtrisé pour un site privé à petits moyens |
| **Points forts** | Tout le site est derrière une connexion ; aucun secret dans le code ni dans git ; aucune dépendance logicielle tierce ; mots de passe correctement chiffrés ; journal de bord du projet très complet |
| **Point le plus urgent** | Les inscriptions sont **libres** : toute personne qui arrive sur la page de connexion peut se créer un compte et entrer. La porte est fermée à clé, mais la clé est accrochée à côté. |
| **Deuxième point** | Tout repose sur **un seul Mac et un seul compte Azure**. Leur protection (double authentification, sauvegarde des secrets) compte plus que tout le reste. |

**En clair.** Le travail fait est sérieux, au-dessus de ce qu'on voit d'ordinaire sur des sites de cette taille. Le service de connexion fait maison respecte les bonnes pratiques de base. Les risques qui restent viennent surtout de **choix de confort** (inscription libre, mot de passe d'une lettre, appareil connecté pour toujours). Ils sont légitimes, mais il faut les prendre en connaissance de cause. Quatre actions, sans programmation, enlèvent l'essentiel du risque (§ 6, « Cette semaine »).

### Cotation

| Niveau | Nombre | Constats |
|---|---|---|
| Élevé | 2 | C1 inscription libre · C2 un seul Mac, un seul administrateur |
| Moyen | 5 | C3 mots de passe et essais répétés · C4 appareils connectés sans fin · C5 clé de l'entrepôt partagée · C6 en-têtes de protection absents · C7 la déconnexion laisse des copies |
| Faible | 6 | C8 à C13 |
| Information | 4 | C14 à C17 |

Échelle : **Élevé** = exploitable sans compétence particulière, avec un impact réel ; **Moyen** = demande une circonstance (vol d'un téléphone, liste de noms) ou a un impact limité ; **Faible** = défense en profondeur.

---

## 2. Contexte et menaces retenues

**Ce qu'on protège**

1. **Les textes sous droits** : psautier et Bible de Jérusalem, lectionnaire Bouchet, polices Kepler, partitions des carnets. C'est l'enjeu principal : une fuite engage la responsabilité du propriétaire du site envers les éditeurs.
2. **Les comptes** : nom, identifiant, date de dernière connexion, rôles. Ce sont des données personnelles, donc soumises au RGPD, même si elles sont peu nombreuses.
3. **Le compte Azure** : payant (offre Standard). Un abus peut coûter de l'argent ; une prise de contrôle permet tout.
4. **Les signalements** et le nécrologe : peu sensibles.

**Qui peut attaquer, de façon réaliste**

- Des **robots** qui parcourent Internet : ils trouvent les adresses `*.azurestaticapps.net`, essaient des mots de passe courants et cherchent des fichiers oubliés.
- Une **personne curieuse** qui a reçu le lien d'un proche.
- Une personne qui veut **récupérer les textes** en masse.
- La **perte ou le vol** d'un téléphone ou de l'ordinateur d'administration.

On ne retient pas l'attaquant ciblé et doté de moyens : il n'a pas de raison de viser ce site.

---

## 3. Ce qui est bien fait

- **Fermeture par défaut.** La règle `/*` → `authenticated` ferme tout sauf les icônes et le manifeste. Vérifié en ligne : la page d'accueil, les données (`/donnees/missel.json`) et l'API répondent par une redirection vers la connexion. La publication ajoute la protection d'office (`--connexion` implicite), et un oubli ne rouvre donc pas le site.
- **Mots de passe** chiffrés avec *scrypt* et un sel propre à chaque compte, comparaisons à durée constante, même temps de réponse pour un identifiant inconnu (on ne peut pas deviner quels comptes existent par le chronométrage).
- **Service de connexion** conforme sur l'essentiel : adresse de retour limitée aux sites autorisés et au seul chemin `/.auth/login/…/callback`, secret client exigé, codes signés valables 2 minutes, attestation signée RSA, prise en charge de PKCE, page de connexion avec en-têtes de protection (CSP, `X-Frame-Options: DENY`), témoin d'appareil `HttpOnly; Secure; SameSite=Lax` limité à `/api/connexion`.
- **Révocation** possible : changer le mot de passe ou désactiver le compte fait oublier tous les appareils (champ `version`).
- **Rôles séparés** (« signalements », « comptes ») appliqués par Azure lui-même, avec une seconde vérification dans les fonctions.
- **Entrepôt privé** : le site web statique public est désactivé, la lecture passe par une clé signée délivrée aux seules personnes connectées, et l'ancienne clé longue a été révoquée.
- **Aucune dépendance** npm ni Python dans ce qui est publié, ce qui supprime presque tout le risque lié aux bibliothèques tierces.
- **Secrets hors de git** : `.gitignore` couvre `.secrets_connexion/`, `.cle_*.txt`, `.mot_de_passe_site.txt`, et aucun secret n'apparaît dans l'historique. Les fichiers ont les droits `600`/`700`. Le dépôt GitHub n'est pas public.
- **Échappement** systématique (`esc()`) dans les pages de gestion (Comptes, Signalements) et sur la page de connexion.
- **Indexation interdite** (`robots.txt`, balise meta, en-tête `X-Robots-Tag`) et HTTPS imposé (HSTS fourni par Azure).

---

## 4. Constats détaillés

### C1 — Inscription libre : n'importe qui peut entrer · **Élevé**

**Constat.** Le réglage d'inscription est en mode `libre`. Toute personne qui ouvre l'adresse du site est renvoyée vers la page de connexion, qui affiche « Créer mon compte ». Il suffit d'un nom, d'un identifiant et d'un mot de passe d'une lettre pour obtenir **le même accès qu'un frère** : tous les textes, plus la clé de lecture de l'entrepôt (Bible, partitions).

**Risque.** Le contrôle d'accès n'a d'effet que tant que l'adresse reste confidentielle. Or une adresse finit toujours par circuler : message transféré, capture d'écran, historique d'un ordinateur partagé, robot qui recense les sous-domaines Azure. C'est le scénario le plus probable de diffusion non voulue des textes sous droits.

**Recommandation.**
- **Tout de suite** (rien à programmer) : page Comptes, passer les inscriptions en mode **« code »** et donner le code oralement ou par message privé. C'était le plan prévu (« libres au lancement, avec code ensuite »).
- **Ensuite** (petit développement) : un mode « **sur validation** », où le compte créé reste inactif jusqu'à ce qu'une personne ayant le rôle « comptes » le valide. C'est la seule façon de savoir qui entre, même si le code circule.
- Changer le code de temps en temps et après chaque vague d'inscriptions.

### C2 — Un seul Mac, un seul administrateur, un seul compte Azure · **Élevé**

**Constat.** Le Mac d'administration contient en clair la clé de signature des attestations, le secret client, la clé d'administration des comptes et la clé des signalements, et il est connecté en permanence à Azure (`az login`) avec le droit de tout modifier. Une seule personne sait administrer.

**Risque.**
- **Vol ou piratage du Mac** : la personne qui le détient peut fabriquer des attestations pour n'importe qui, lire et modifier tous les comptes, ou supprimer les ressources Azure.
- **Prise du compte Microsoft** (hameçonnage, mot de passe réutilisé) : même effet, plus la facturation.
- **Indisponibilité de l'administrateur** : personne ne peut réinitialiser un mot de passe ni corriger le site.

**Recommandation.**
1. **Double authentification** obligatoire sur le compte Microsoft qui possède l'abonnement Azure (application Microsoft Authenticator ou clé physique). À vérifier en priorité : c'est la mesure la plus rentable de toute la liste.
2. **FileVault** activé sur le Mac (chiffrement du disque), avec verrouillage automatique de l'écran.
3. Copier les secrets (`.secrets_connexion/`, `.cle_comptes.txt`) dans un **gestionnaire de mots de passe** (celui d'Apple, 1Password, Bitwarden). Ils servent alors de sauvegarde, et le Mac n'en reste pas l'unique dépositaire.
4. **Un second administrateur** : un frère de confiance avec un compte Azure séparé (rôle « Contributeur » sur le groupe `breviaire` seulement) et le rôle « comptes » sur le site, ainsi qu'une courte fiche « que faire si… ».
5. **Alerte de budget** Azure (par exemple un courriel à 30 € par mois) : elle prévient aussi bien d'un abus que d'une erreur.
6. Une fois que le rôle « comptes » a fait ses preuves, **vider `CONNEXION_ADMIN_CLE`** (clé de secours qui donne tous les pouvoirs sans connexion), ou au moins la garder ailleurs que sur le Mac.

### C3 — Mots de passe libres et essais répétés · **Moyen**

**Constat.** Un mot de passe d'un seul caractère est accepté (choix délibéré du 19/11/2026). La seule protection est le blocage : 5 erreurs bloquent le compte 15 minutes. Les essais ne sont limités ni par adresse ni sur l'ensemble des comptes. Les identifiants suivent la forme `prenom.nom`, donc faciles à deviner à partir d'un annuaire de la Province.

**Risque.**
- **Essais en largeur** : un robot essaie quatre mots de passe courants (« 1234 », « azerty », « jesus », le prénom) sur chaque identifiant probable. Il reste sous le seuil de blocage et peut recommencer toutes les 15 minutes, soit environ 380 essais par compte et par jour. Avec des mots de passe très courts, la réussite devient probable en quelques jours.
- **Blocage malveillant** : la même technique peut bloquer un frère sans fin.

**Recommandation** (en respectant le souhait de simplicité) :
- Refuser **seulement l'évident** : moins de 6 caractères, un mot de passe identique à l'identifiant, ou présent dans une courte liste des 1 000 mots de passe les plus courants (fichier embarqué, sans dépendance). Le bouton « Me proposer un mot de passe » (quatre mots latins) reste la voie conseillée.
- Ajouter un **frein global** : au-delà de N échecs par heure sur l'ensemble du service (par exemple 30), imposer une attente de quelques secondes à chaque essai et prévenir l'administrateur (ligne dans la table, affichée sur la page Comptes).
- Remplacer le blocage sec par un **délai croissant** (1 s, 2 s, 4 s… plafonné), qui gêne le robot sans bloquer le frère.

### C4 — Appareils connectés sans fin · **Moyen**

**Constat.** Le témoin d'appareil vaut un an et se renouvelle à chaque visite : un téléphone utilisé reste connecté indéfiniment. Personne ne voit la liste de ses appareils, et un frère ne peut pas « déconnecter tous mes appareils » lui-même.

**Risque.** Un téléphone perdu, vendu ou prêté donne accès au site jusqu'à ce que l'administrateur pense à changer le mot de passe du compte.

**Recommandation.**
- Expiration après **90 jours sans usage** (le renouvellement à chaque visite garde le confort des frères assidus).
- Un bouton « **Déconnecter tous mes appareils** » pour chaque frère (il incrémente `version`, mécanisme déjà en place).
- Une ligne dans la notice : « téléphone perdu → prévenir l'administrateur, qui change le mot de passe ».

### C5 — Clé de lecture de l'entrepôt commune à tous · **Moyen**

**Constat.** Tous les appareils reçoivent la **même** clé, valable 30 à 45 jours, qui ouvre **tout** le conteneur (Bible, partitions, données). Elle est gardée dans le stockage du navigateur, d'où on peut la copier.

**Risque.** Une personne connectée, même pour une seule visite (voir C1), peut copier la clé et télécharger tout l'entrepôt (environ 450 Mo de contenus sous droits) depuis n'importe quel outil, pendant plus d'un mois, même après la désactivation de son compte. Le téléchargement massif consomme aussi de la bande passante payante.

**Recommandation.**
- Raccourcir : clé valable **7 jours**, renouvelée tous les 3 jours. Le mécanisme existe déjà, il n'y a que des constantes à changer, et le cache des navigateurs reste efficace.
- Activer les **journaux de lecture** du compte de stockage, avec une alerte sur un volume sortant anormal (par exemple plus de 2 Go par jour).
- À plus long terme, si le risque de copie devient sérieux : servir les fichiers par une fonction qui vérifie la connexion à chaque demande. C'est plus coûteux, et la mesure ne se justifie que sur un signal concret.

### C6 — En-têtes de protection absents sur le site principal · **Moyen**

**Constat.** Le site principal envoie `nosniff`, `Referrer-Policy` et HSTS (vérifié en ligne). Il **n'envoie pas** de règle de sécurité du contenu (CSP), ni d'interdiction d'affichage dans un cadre (`frame-ancestors` ou `X-Frame-Options`), ni de `Permissions-Policy`. Le service de connexion, lui, envoie `X-Frame-Options: DENY`.

**Risque.** Sans CSP, la moindre faille d'injection (voir C9) devient exploitable. Sans interdiction de cadre, une page tierce peut afficher le site sous un calque trompeur (« détournement de clic ») ; l'impact est faible ici, car il n'y a ni paiement ni action grave en un clic.

**Recommandation** (dans `globalHeaders` de `staticwebapp.config.json`) :
```
"X-Frame-Options": "DENY",
"Permissions-Policy": "camera=(), microphone=(), geolocation=(), payment=()",
"Cross-Origin-Opener-Policy": "same-origin",
"Content-Security-Policy-Report-Only": "default-src 'self'; img-src 'self' data: blob: https://breviairefichiers.blob.core.windows.net; connect-src 'self' https://api.aelf.org https://breviairefichiers.blob.core.windows.net; font-src 'self'; style-src 'self' 'unsafe-inline'; script-src 'self'; frame-ancestors 'none'; base-uri 'self'; form-action 'self'"
```
Commencer en mode « *Report-Only* » (rien n'est bloqué, on observe), déplacer le petit script en ligne de fin d'`index.html` dans un fichier `.js`, puis passer en mode bloquant. **À tester page par page** (Messe, Bible, export Word) avant de bloquer.

### C7 — « Se déconnecter » laisse les copies sur l'appareil · **Moyen**

**Constat.** La déconnexion ferme la session Azure et oublie l'appareil côté service. Elle **ne vide pas** les copies gardées par le service worker (pages, données, partitions enregistrées), ni la mémoire AELF, ni la clé de l'entrepôt dans `localStorage`.

**Risque.** Sur un ordinateur partagé (bibliothèque du couvent, poste d'accueil), la personne suivante peut relire hors connexion les textes enregistrés et réutiliser la clé de l'entrepôt.

**Recommandation.** Avant de partir vers le service de déconnexion : `caches.delete(...)` pour les boîtes `breviaire-*`, suppression de `breviaire-cle-fichiers`, et désinscription du service worker. Proposer une case « garder les offices enregistrés sur cet appareil » pour les téléphones personnels.

### C8 — Défense en profondeur sur la gestion des comptes · **Faible**

**Constat.** Une personne qui a le rôle « comptes » gère les comptes avec son seul témoin d'appareil (`SameSite=Lax`). Les navigateurs actuels n'envoient pas ce témoin lors d'une modification venue d'un autre site, mais `POST /comptes` accepte aussi un formulaire ordinaire.

**Recommandation.** Pour toute modification, exiger `Content-Type: application/json` **ou** un en-tête maison (`X-Breviaire: 1`) : un autre site ne peut pas les poser sans autorisation CORS. Coût : deux lignes.

### C9 — Nettoyage du HTML de l'AELF par expressions régulières · **Faible**

**Constat.** `propre()` (`site/js/offices.js:115`) filtre les balises avec des expressions régulières. Comme le note déjà le journal du projet, une balise non refermée en fin de texte peut passer et se refermer sur le HTML qui suit.

**Risque.** Faible : la source est l'AELF, en HTTPS. Le scénario supposerait une compromission de l'AELF ou de sa mémoire locale.

**Recommandation.** Analyser avec `DOMParser`, puis reconstruire en ne gardant que les balises permises et sans aucun attribut (une trentaine de lignes, sans dépendance). La CSP (C6) couvre le reste.

### C10 — Signalements : écriture ouverte et écrasement possible · **Faible**

**Constat.** Toute personne connectée peut écrire des signalements sans limite de nombre. Un envoi qui reprend l'identifiant d'un signalement existant le **remplace**, ce qui le remet aussi « à traiter ».

**Recommandation.** Insertion seule (création refusée si la ligne existe), limite simple (par exemple 50 par appareil et par jour) et nom du compte joint au signalement (l'en-tête d'Azure le fournit). On sait ainsi qui écrit quoi.

### C11 — Code d'échange réutilisable pendant 2 minutes · **Faible**

**Constat.** Le code remis à Azure n'est pas marqué comme « utilisé » : il resterait valable pendant sa durée de 2 minutes s'il était intercepté.

**Risque.** Très faible : l'échange exige aussi le secret client, connu seulement d'Azure.

**Recommandation.** Noter l'empreinte des codes utilisés (ligne de table, 2 minutes) et refuser un second usage. Optionnel.

### C12 — Page de connexion : `form-action *` · **Faible**

**Constat.** La CSP de la page de connexion autorise l'envoi des formulaires vers n'importe quelle adresse.

**Recommandation.** `form-action 'self' https://calm-flower-052e85c10.4.azurestaticapps.net`, c'est-à-dire les sites de `CONNEXION_SITES`, générés dynamiquement.

### C13 — Outil de publication téléchargé à chaque envoi · **Faible**

**Constat.** `npx --yes @azure/static-web-apps-cli` télécharge la **dernière** version de l'outil à chaque publication, sur le Mac qui détient tous les secrets.

**Risque.** Celui d'une chaîne d'approvisionnement : un paquet piégé, même brièvement, s'exécuterait avec tous les droits de l'administrateur.

**Recommandation.** Fixer la version (`@azure/static-web-apps-cli@2.0.x`, celle utilisée aujourd'hui) et ne la changer que délibérément.

### C14 — Données personnelles et hébergement · **Information**

- La table des comptes est en France (francecentral), mais les sites et fonctions Azure tournent dans la région **Central US** : des données de compte transitent hors de l'Union européenne. Les clauses contractuelles de Microsoft le couvrent, mais il faut le dire aux personnes concernées.
- Recommandation : une courte **mention d'information** sur la page de connexion (ce qui est gardé : nom, identifiant, date de dernière connexion ; pourquoi ; qui y a accès ; comment demander la suppression). Le nécrologe concerne des défunts : il n'entre pas dans le RGPD, mais la discrétion reste de mise.

### C15 — Sauvegardes · **Information**

- Le dépôt git a beaucoup de changements **non enregistrés** depuis le 18/11 (Messe, Bibliothèque, connexion, API) : un incident sur le Mac les ferait perdre. Recommandation : enregistrer (commit) et envoyer (push) vers GitHub au moins une fois par semaine.
- La table `comptes` n'a pas de sauvegarde. Un export mensuel (script de quelques lignes) suffit.

### C16 — Droits sur les contenus · **Information**

La fermeture du site par connexion réduit fortement le risque juridique noté plus tôt (Cerf, Bible de Jérusalem, Kepler, Bouchet). Ce bénéfice ne tient que si C1 est corrigé. La licence web des polices Kepler reste à vérifier.

### C17 — Ce qui n'a pas pu être vérifié · **Information**

Réglages du compte Microsoft et de l'abonnement (double authentification, personnes ayant accès, journaux d'activité), configuration réseau du compte de stockage, comportement sur iPhone en mode « écran d'accueil », durée réelle de la session Azure. À contrôler dans le portail Azure (une demi-heure, avec l'administrateur).

---

## 5. Comment le faire évoluer

**Vers où aller.** Le site n'a pas besoin d'une sécurité de banque. Il lui faut une sécurité **proportionnée et durable**, qui ne dépende pas d'une seule personne. Trois idées guident les recommandations :

1. **Savoir qui entre** : inscription sur code, puis sur validation, et des comptes nominatifs.
2. **Pouvoir reprendre la main** : révoquer un appareil, être deux administrateurs, avoir des sauvegardes.
3. **Limiter ce qu'une seule fuite permet** : clés courtes, copies effacées à la déconnexion, alertes de volume.

**Évolution à considérer à moyen terme : les clés d'accès (« passkeys »).** Elles correspondent exactement au souhait de départ (« une seule fois par appareil, sans compte Microsoft »). Le téléphone ou l'ordinateur crée une clé, déverrouillée par Face ID ou l'empreinte digitale, et il n'y a plus de mot de passe à retenir, à deviner ou à se faire voler. Le service de connexion maison peut l'ajouter (norme WebAuthn, sans dépendance). Le mot de passe resterait en secours. C3 disparaît alors presque entièrement.

---

## 6. Plan d'action

### Cette semaine — sans programmation (≈ 1 h)

| # | Action | Constat | Qui |
|---|---|---|---|
| 1 | Inscriptions en mode **« code »** (page Comptes) | C1 | Administrateur |
| 2 | **Double authentification** sur le compte Microsoft/Azure | C2 | Administrateur |
| 3 | **Alerte de budget** Azure | C2, C5 | Administrateur (portail) |
| 4 | Secrets copiés dans un gestionnaire de mots de passe ; FileVault vérifié | C2 | Administrateur |
| 5 | Enregistrer et envoyer le dépôt git | C15 | Claude, sur demande |

### Ce mois-ci — petits développements (≈ 1 à 2 jours au total)

| # | Action | Constat |
|---|---|---|
| 6 | En-têtes de protection, CSP d'abord en observation | C6 |
| 7 | La déconnexion vide les copies et la clé de l'entrepôt | C7 |
| 8 | Refus des mots de passe évidents, délai croissant, frein global | C3 |
| 9 | Clé de l'entrepôt à 7 jours | C5 |
| 10 | Expiration des appareils après 90 jours sans usage ; « Déconnecter tous mes appareils » | C4 |
| 11 | En-tête obligatoire sur les modifications ; `form-action` ; version de l'outil fixée ; signalements en insertion seule | C8, C10, C12, C13 |

### Ce trimestre — consolidation

| # | Action | Constat |
|---|---|---|
| 12 | Inscription sur validation | C1 |
| 13 | Second administrateur et fiche « que faire si… » | C2 |
| 14 | CSP bloquante ; nettoyage du HTML de l'AELF par `DOMParser` | C6, C9 |
| 15 | Mention d'information RGPD ; export mensuel des comptes | C14, C15 |
| 16 | Revue des réglages Azure dans le portail (avec l'administrateur) | C17 |
| 17 | Étude des clés d'accès (passkeys) | C3, C4 |

**Ensuite :** relire cet audit **une fois par an**, ou à chaque changement important (ouverture à d'autres couvents, nouvelle fonction qui reçoit des données, nouveau type de contenu sous droits).

---

## Annexe — Contrôle du compte Azure (19/11/2026, lecture seule, outil `az`)

| Point | Constat |
|---|---|
| Double authentification | **Oui** : la connexion d'administration en cours a été faite avec mot de passe + second facteur (`amr: pwd, mfa`) |
| Accès à l'abonnement | Une seule personne (propriétaire) ; seule elle a agi sur l'abonnement depuis 30 jours |
| Stockage | TLS 1.2 minimum, HTTPS seul, aucun accès public aux fichiers |
| **Accès élevé** | « Administrateur de l'accès utilisateur » à la racine `/` : interrupteur « Gestion de l'accès pour les ressources Azure » laissé sur Oui → **retiré le 19/11** (`az role assignment delete … --scope /`) ; le compte reste propriétaire de l'abonnement |
| Administrateurs globaux | Deux : le compte personnel et `admin@` ; la sécurité de `admin@` compte autant que celle du compte personnel |
| Autres comptes de l'annuaire | 11 comptes (dont boîtes partagées et un invité) ; leur double authentification n'est pas lisible sans licence Entra P1 ; paramètres de sécurité par défaut non lisibles par l'outil |
| Alerte de budget | **Créée le 19/11** : budget « alerte-mensuelle » de 30 €/mois, courriels à 80 % et 100 % réels, et 100 % prévu |
| Protection contre la suppression | **Verrou « protection-breviaire » (CanNotDelete) posé le 19/11** sur le groupe `breviaire` ; corbeille des fichiers désactivée (entrepôt reconstituable depuis le Mac ; la table des comptes, elle, ne l'est pas) |
| Ressources sans rapport | Ressources d'essai « learn » (Foundry, Application Insights) dans deux autres groupes : à supprimer si elles ne servent plus |
