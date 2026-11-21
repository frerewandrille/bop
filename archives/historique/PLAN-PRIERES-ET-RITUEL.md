# Plan d'action — prières, rituel, martyrologe, nécrologe, bénédictions de table

Établi le 18/11/2026. Rien n'est encore fait. Ce document dit **dans quel ordre**, **ce que je fais**,
**ce dont j'ai besoin de vous** et **à quoi on reconnaît qu'une étape est finie**.

## Principe

Ces nouveautés ne se mélangent pas à la construction des offices (qui reste intacte). Elles prennent
place dans un menu en haut de l'écran : **Office · À table · Prières · Rituel**. Le martyrologe et le
nécrologe suivent la date choisie, comme l'office.

Chaque recueil a :
- sa source (un de vos documents, jamais de mémoire) ;
- un petit programme qui la transforme en fichier de données (`site/donnees/…json`) ;
- un affichage à l'écran, une impression (PDF/Word) et la lecture hors connexion ;
- le bouton « Signaler une erreur » ;
- un test automatique qui vérifie que rien ne manque.

---

## Étape 0 — Décisions préalables (vous)

À trancher avant de commencer, ou au fil des étapes :

| Question | Pourquoi | Valeur par défaut si vous ne dites rien |
|---|---|---|
| **Public ou réservé ?** Le site est en ligne sans mot de passe. | Le nécrologe contient des noms ; les rituels officiels (AELF, éditeurs) sont sous droits. | Bénédictions de table et Compendium publics ; nécrologe et rituel **réservés** (mot de passe) |
| **À quel moment dit-on le De profundis ?** | Décide où il apparaît (après une heure, au réfectoire, au chapitre). | Section « À table », après la bénédiction de midi |
| **Quels couvents** proposer dans « Mon couvent » ? | Martyrologe local, nécrologe, saints diocésains. | Couvents de la Province de Toulouse |
| **Latin ?** pour les bénédictions et les prières | Double travail de saisie. | Français seul, latin là où la source le donne |

---

## Étape 1 — Bénédictions de table ✅ faite le 18/11/2026 (publiée le 18/11/2026)

**Source** : Drive LITURGIE › 99-Divers › « Bénédictions repas province Toulouse BENEDICITE »
(4 PDF : A4 et A5, deux variantes « -1 » légèrement différentes). Contenu relevé : temps ordinaire,
midi et soir, avant le repas pour chaque jour de la semaine, après le repas (midi et soir), puis
Mercredi des Cendres, Jeudi, Vendredi et Samedi saints, Dimanche de Pâques…

**Ce que je fais**
1. Lire le PDF et ranger chaque formule par temps × jour × repas (midi/soir) × moment (avant/après) ;
   relever les autres temps (Avent, Noël, Carême, Pâques) que le document contient.
2. Le site choisit seul la bonne bénédiction selon la date (le calendrier connaît déjà le temps
   liturgique et les jours saints).
3. Onglet « À table » : la bénédiction du jour, midi et soir ; impression d'une carte A5 par temps
   pour le réfectoire.

**De vous** : laquelle des deux variantes fait foi (« … Garamond » ou « … Garamond-1 ») ; existe-t-il
des partitions (chantées certains jours) ?

**Fini quand** : chaque jour de l'année 2026-2027 affiche une bénédiction, sans trou ; carte A5 regardée.

**Ampleur** : petite (une séance).

---

## Étape 2 — De profundis et nécrologe provincial (nécrologe ✅ 18/11/2026, avec le martyrologe ; texte du De profundis : en attente)

**Source** : ❌ non trouvée dans le Drive. Il me faut le nécrologe de la Province (liste, tableau ou
livret : jour, mois, nom, couvent, année de décès) et le texte du De profundis que vous dites
(psaume 129 de quelle traduction, versets, oraison finale).

**Ce que je fais**
1. Fichier de données « jour du mois → frères défunts ».
2. Affichage : « Aujourd'hui nous faisons mémoire de fr. N., mort à … en … », puis le De profundis
   et l'oraison. Placé à l'endroit choisi à l'étape 0.
3. Ajout possible au livret PDF d'une période (case à cocher dans la fenêtre d'export).

**Fini quand** : chaque date du nécrologe apparaît une fois, le 29 février compris ; jours sans
défunt traités (rien, ou la formule générale).

**Ampleur** : petite une fois la source reçue ; la saisie dépend de la forme du nécrologe
(tableau = rapide, livret scanné = long).

---

## Étape 3 — Réglage « Mon couvent »

**Ce que je fais** : un choix unique dans les réglages, gardé sur l'appareil. Il ne change rien aux
offices pour l'instant ; il sert au nécrologe (étape 2) et au martyrologe (étape 4). Plus tard, il
pourra ajouter les saints propres du diocèse au calendrier des offices.

**De vous** : la liste des couvents et, pour chacun, la ville et le diocèse.

**Ampleur** : petite.

---

## Étape 4 — Martyrologe avec les éloges propres des couvents ✅ 18/11/2026 (trois éditions : romain, Marseille, Toulouse-Rangueil ; publié le 18/11/2026)

**Source** : ❌ non trouvée. Il faut :
- le **Martyrologe romain** en français (édition que vous utilisez) — 365 notices, plus les fêtes mobiles ;
- les **éloges propres de l'Ordre** (martyrologe dominicain) ;
- les **ajouts locaux** de chaque couvent ou diocèse.

**Ce que je fais**
1. Fichier de données par jour ; formule d'annonce de la veille (« Demain, … ») ; fêtes mobiles
   placées par le calendrier déjà existant.
2. Après les éloges romains et dominicains, ceux du couvent choisi.
3. Ajout possible au livret PDF d'une période, pour le lecteur.

**Points de vigilance** : droits de la traduction française du Martyrologe (à vérifier avant mise en
ligne publique) ; volume de saisie si la source n'est qu'imprimée.

**Fini quand** : 366 jours remplis, test « aucun jour vide » vert, une semaine imprimée et relue.

**Ampleur** : grande (le plus gros travail de saisie).

---

## Étape 5 — Compendium : formules et prières ✅ 18/11/2026 (source : vatican.va ; publié le 18/11/2026)

**Source** : ❌ non trouvée dans le Drive. La partie « Prières communes » et « Formules de la
doctrine catholique » de l'appendice du Compendium du Catéchisme (texte français et latin). Me dire
quelle édition vous voulez suivre, ou me fournir le fichier.

**Ce que je fais**
1. Onglet « Prières » : sommaire (prières ; formules : commandements, sacrements, vertus, dons de
   l'Esprit, œuvres de miséricorde, péchés capitaux, fins dernières…).
2. Latin et français côte à côte quand la source les donne.
3. Recherche, favoris, impression d'une prière seule.

**Fini quand** : toutes les pièces de la source présentes (comptées), affichage téléphone vérifié.

**Ampleur** : moyenne.

---

## Étape 6 — Rituel : malades et pénitence

**Source** : ❌ non trouvée (le Drive contient les rituels du baptême, du mariage et des funérailles,
pas ceux des malades ni de la pénitence). Il faut :
- « Sacrements pour les malades » : visite, communion, onction (rite ordinaire, dans la messe, en
  danger de mort), viatique, recommandation des mourants, prière au moment de la mort ;
- « Célébrer la pénitence et la réconciliation » : rite pour un seul pénitent (formule
  d'absolution), éventuellement célébration communautaire.

**Ce que je fais**
1. Onglet « Rituel » : on choisit la situation, puis la célébration se déroule pas à pas
   (rubriques en rouge, paroles du prêtre et réponses distinguées).
2. Mode **gros caractères** ; lecture **sans réseau** garantie (enregistré d'office sur l'appareil).
3. Impression de fiches A5.

**Points de vigilance** : textes officiels sous droits → réservé par mot de passe ; formules
sacramentelles à reproduire **exactement** : relecture ligne à ligne par vous avant toute mise en ligne.

**Fini quand** : chaque rite affiché, comparé au rituel imprimé, relu et validé par vous ; lu hors
connexion sur un vrai téléphone.

**Ampleur** : moyenne à grande, surtout la relecture.

---

## Étape 7 — Publication

Après chaque étape validée (et non toutes à la fin) : mise à jour des fichiers gardés hors connexion,
du mode d'emploi des réglages et du README, puis publication sur Azure **avec votre accord**. Si des
parties sont réservées, rétablir d'abord le mot de passe du site (aujourd'hui désactivé) ou créer
un espace protégé à part.

---

## Résumé : ce que j'attends de vous

| Étape | À fournir ou décider |
|---|---|
| 0 | Public/réservé, moment du De profundis, liste des couvents, latin |
| 1 | Laquelle des deux variantes des bénédictions fait foi ; partitions éventuelles |
| 2 | Nécrologe de la Province ; texte du De profundis et de l'oraison |
| 3 | Couvents (ville, diocèse) |
| 4 | Martyrologe romain français, martyrologe de l'Ordre, ajouts locaux |
| 5 | Édition du Compendium |
| 6 | Rituels des malades et de la pénitence ; relecture finale |

Je peux commencer l'étape 1 tout de suite : sa source est déjà dans le Drive.
