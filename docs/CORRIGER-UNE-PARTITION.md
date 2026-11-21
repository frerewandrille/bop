# Corriger une partition soi-même

Tout se passe dans le dossier `partitions` (à côté du dossier `site`). On ne touche jamais au
programme : seulement à des images et à un petit fichier de corrections, `partitions/corrections.json`.

## 1. Repérer la partition

Ouvrir le bréviaire en local (« Lancer le bréviaire »), version **Province avec partitions**, et aller à
l'office concerné. Deux indications grises (jamais imprimées) servent aux corrections :

- sous chaque partition dépliée, **le nom de son image**, par exemple `sanctoral1/s-113-1.jpg`
  (carnet `sanctoral1`, page 113 du PDF, 1re pièce de la page) ;
- tout en bas de l'office, **la clé de l'office**, par exemple `10-18|vepres` (18 octobre, vêpres),
  `avent/2/mardi|laudes`, `ordinaire/14/jeudi|vepres`, `trinite|laudes`.

Les pages entières des carnets sont dans le même dossier : `partitions/sanctoral1/p-113.jpg`.

## 2. Trois sortes de correction

### a) L'image est mauvaise (mal coupée, il manque une ligne, mauvaise qualité)

1. Ouvrir la page entière (`p-113.jpg`) dans **Aperçu**, sélectionner à la souris la bonne zone,
   *Outils → Recadrer*, puis *Fichier → Exporter…* en JPEG dans `partitions/corrections/`,
   sous un nom simple sans accent ni espace : `luc-vepres-antienne1.jpg`.
   (On peut aussi y déposer une partition venue d'ailleurs : scan, capture d'écran d'un PDF.)
2. Dans `corrections.json`, à la rubrique `"remplacer"`, écrire l'ancienne image puis la nouvelle :

```json
"remplacer": {
  "sanctoral1/s-113-1.jpg": "corrections/luc-vepres-antienne1.jpg"
}
```

L'image est alors remplacée partout où elle sert. Pour mettre deux images à la place d'une :
`"sanctoral1/s-113-1.jpg": ["corrections/a.jpg", "corrections/b.jpg"]`.

### b) Une image n'a rien à faire là (gravure, pièce en trop)

```json
"retirer": ["sanctoral2/s-088-2.jpg"]
```

### c) Ce n'est pas la bonne pièce pour cet office (mauvaise hymne, mauvaise antienne, mauvais répons)

À la rubrique `"offices"`, écrire la clé de l'office, puis pour chaque rôle à corriger la liste des images :

```json
"offices": {
  "10-18|vepres": {
    "hymne": ["sanctoral1/s-052-1.jpg", "sanctoral1/s-053-1.jpg"],
    "antiennes": [["sanctoral1/s-113-1.jpg"], ["sanctoral1/s-114-1.jpg"]],
    "repons": ["sanctoral1/s-115-1.jpg", "sanctoral1/s-116-1.jpg"]
  }
}
```

- Rôles possibles : `invitatoire`, `lucernaire`, `hymne`, `antiennes`, `cantique`, `repons`,
  `benedictus`, `magnificat`, `priere`, `choral`, `tedeum`.
- Seuls les rôles écrits sont changés ; le reste de l'office ne bouge pas.
- Pour `antiennes`, un groupe entre crochets par psaume, dans l'ordre de l'office (1re antienne, 2e…).
- Pour supprimer un rôle : liste vide, `"hymne": []`.
- La clé peut aussi être une date précise, pour un seul jour : `"2027-10-18|vepres"`.

## 3. Règles d'écriture du fichier

- Guillemets droits `"` partout ; une virgule **entre** deux lignes d'une même rubrique, pas après la dernière.
- Ouvrir le fichier avec TextEdit (*Format → Convertir au format Texte*) ou tout éditeur de texte simple, pas Word.
- Vérifier ensuite : dans le Terminal, depuis le dossier du bréviaire,

```bash
python3 outils/verifier_corrections.py
```

  Le programme dit si le fichier se lit et si toutes les images citées existent.
- Recharger la page du bréviaire : la correction est visible tout de suite, sans rien relancer.

## 4. Mettre la correction en ligne

Les corrections sont publiées avec le reste à la prochaine mise en ligne (`docs/MISE-EN-LIGNE-AZURE.md`) :
le fichier `corrections.json` et le dossier `partitions/corrections/` partent avec les partitions.

## 5. Ce qu'il ne faut pas modifier

`partitions/ordo.json`, `index.json` et les `pieces.json` sont refabriqués par les outils : une correction
faite dedans serait perdue. `corrections.json` et le dossier `corrections/`, eux, ne sont jamais écrasés.

## Pour s'y retrouver

- `partitions/ordo-rapport.md` : pour chaque fête des deux carnets du sanctoral, ce qui a été relevé
  (hymne, antiennes, répons) et les images correspondantes.
- `node outils/audit_partitions.js --hymnes` : l'hymne retenue pour chaque jour d'une année liturgique.
