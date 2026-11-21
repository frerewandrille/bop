# Archives — ce qui ne sert plus au site

Rien dans ce dossier n'est lu par le site ni par les programmes de `outils/`. On peut l'oublier ; on le
garde pour mémoire. Rangé le 20/11/2026, lors de la remise en ordre du dossier avant passation.

| Fichier ou dossier | Ce que c'était | Pourquoi il ne sert plus |
|---|---|---|
| `historique/AUDIT-2026-11-17.md` | Audit de performance (poids du site, images inutilisées) | Ses propositions ont été faites ou reprises dans `CLAUDE.md` |
| `historique/AUDIT-images-non-affichees.json` | Liste des images de partitions jamais affichées (17/11) | Remplacée par `partitions/images-utilisees.json`, refaite à chaque publication |
| `historique/PLAN-PARTITIONS-LILYPOND.md` | Plan et inventaire des partitions gouzantines LilyPond (19/11) | Fait (`outils/graver_lilypond.py`) ; le reste à faire est dans `CLAUDE.md` |
| `historique/PLAN-PRIERES-ET-RITUEL.md` | Plan : bénédicité, nécrologe, martyrologe, Compendium, rituel (18/11) | Étapes 1, 2, 4, 5 faites ; les étapes restantes (« Mon couvent », rituel des malades et de la pénitence) sont notées dans `CLAUDE.md` |
| `historique/JOURNAL-2026-11.md` | L'ancien `CLAUDE.md` complet : journal, séance par séance, du 10 au 20/11/2026 | Remplacé par un `CLAUDE.md` court ; le journal reste la mémoire détaillée de chaque choix |
| `exemples/` | PDF et Word d'exemple produits en novembre 2026 | Le gabarit a changé depuis ; un export du site en donne de nouveaux |
| `propre_op.toml` | Ancien calendrier de l'Ordre (Calendarium 2019) | Remplacé par `site/donnees/propre_op.json`, fait par `outils/construire_missel_op.py` d'après le Missel de l'Ordre. Le relire aurait effacé les degrés de la Province |
| `.mot_de_passe_site.txt` | Ancien mot de passe commun du site (caché, jamais dans git) | Le site se protège désormais par identifiant et mot de passe personnels (`docs/CONNEXION.md`) |
| `sauvegarde-avant-tri-2026-11-20.tar.gz` | Copie du code, des données et des documents juste avant ce rangement (sans images ni sources ; jamais dans git) | À supprimer quand on est sûr que tout marche |

Les fichiers temporaires laissés par l'outil de publication Azure (`.\…-app.zip`, 5 × 330 Mo) et quelques
images parasites (`--00N.pgm`) ont été mis à la **Corbeille** du Mac (dossier `breviaire-tri-2026-11-20`).
