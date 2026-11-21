"""Capitules (lectures brèves) des laudes et vêpres de la Province dominicaine de Toulouse.

Transcrits à la main d'après « Lectures Office Province Toulouse.pdf » (8 pages scannées),
corrections manuscrites comprises. Produit site/donnees/capitules.json.
    python3 outils/capitules_province.py

Clés de jour : dim lun mar mer jeu ven sam ; « sam » sous VÊPRES = 1res vêpres du dimanche.
"""
import json
from pathlib import Path

J = ["dim", "lun", "mar", "mer", "jeu", "ven", "sam"]
def sem(*refs, jours=J):
    return dict(zip(jours, refs))

VJ = ["sam", "dim", "lun", "mar", "mer", "jeu", "ven"]   # vêpres : samedi (1res vêpres), dimanche (2es), lundi…

C = {
 # ─── Temps ordinaire : cycle de 8 semaines (semaine I = dimanches 1, 9, 17, 25, 33)
 "to": {
  "laudes": {
   "1": sem("Gn 1, 1-5", "Sg 1, 1-7", "Sg 1, 11-15", "Dt 4, 5-8", "Dt 30, 11-14", "Sg 6, 12-19", "Sg 7, 7-14"),
   "2": sem("Ex 20, 1-17", "Mi 4, 1-5", "Is 43, 1-7", "Is 43, 8-13", "Is 44, 1-5", "Sg 12, 19-22", "Pr 30, 5-9"),
   "3": sem("Dt 6, 4-9", "Ba 3, 9-14", "Ba 3, 32 – 4, 4", "Si 3, 1-16", "Si 3, 17-29", "Si 3, 30 – 4, 10", "Am 9, 11-15"),
   "4": sem("Dt 26, 1-11", "Is 44, 21-23", "Is 45, 9-13", "Is 46, 3-5", "Pr 1, 1-7", "Pr 2, 1-9", "Dt 26, 16-19"),
   "5": sem("Is 55, 6-11", "Si 4, 20-31", "Si 5, 1-8", "Dn 2, 20-23", "Os 11, 7-9", "Os 14, 2-10", "Dt 8, 11-20"),
   "6": sem("Jr 33, 6-11", "Pr 3, 1-12", "Pr 3, 13-20", "Pr 3, 27-35", "Za 8, 1-8", "Ex 23, 1-9", "Ex 23, 10-12"),
   "7": sem("Ez 36, 22-28", "Is 48, 16-19", "Is 54, 5-10", "Si 6, 5-17", "Si 17, 1-14", "Si 18, 8-14", "Is 56, 1-7"),
   "8": sem("Ez 37, 11-14", "Pr 4, 20-27", "Pr 8, 22-31", "Is 63, 7-14", "Is 64, 3-7", "Dt 30, 1-5", "Is 40, 25-31"),
  },
  "vepres": {
   "1": sem("Rm 13, 11-14", "2 Co 4, 3-6", "Rm 6, 20-23", "Rm 7, 14-25", "Col 1, 9-12", "1 Co 9, 19-23", "Ga 2, 19-21", jours=VJ),
   "2": sem("Rm 5, 1-9", "Ap 5, 6-10", "Rm 8, 1-4", "2 Tm 2, 22-26", "2 Tm 3, 14-17", "Jc 1, 22-27", "Col 3, 5-11", jours=VJ),
   "3": sem("Ep 3, 14-21", "Ac 2, 42-47", "Rm 12, 3-8", "Rm 12, 9-13", "Rm 12, 14-21", "1 P 4, 7-11", "2 Co 12, 7-10", jours=VJ),
   "4": sem("Rm 3, 21-26", "1 Co 2, 1-5", "Jc 2, 5-13", "2 Th 3, 7-13", "Ep 2, 13-18", "1 P 5, 5-11", "1 Jn 3, 4-10", jours=VJ),
   "5": sem("1 Tm 2, 1-8", "Ap 7, 9-12", "Jc 3, 13-18", "1 Tm 6, 7-10", "1 Jn 2, 3-6", "Rm 15, 1-6", "Col 1, 24-29", jours=VJ),
   "6": sem("Ph 4, 4-9", "Ac 4, 32-35", "1 P 1, 22-25", "Jc 4, 7-12", "Rm 11, 25-32", "Rm 11, 33-36", "1 Jn 3, 1-3", jours=VJ),
   "7": sem("Ga 3, 23-29", "1 Jn 5, 5-13", "Rm 8, 31-39", "2 Tm 4, 1-5", "2 P 1, 3-11", "2 P 1, 19-21", "Col 4, 2-6", jours=VJ),
   "8": sem("Col 1, 3-6", "2 Tm 2, 8-13", "Col 3, 12-17", "Ep 5, 15-20", "Jc 3, 2b-10", "1 Jn 4, 7-13", "1 Jn 4, 14-21", jours=VJ),
  },
 },
 # ─── Avent
 "avent": {
  "laudes": {
   "1": sem("Dn 7, 9-14", "Ml 3, 1-4", "Ml 3, 16b-20a", "Is 33, 13-16", "So 3, 18b-20", "Is 40, 6-8", "Is 45, 8"),
   "2": sem("Gn 17, 1-8", "Is 51, 1-3", "Nb 24, 15-17a", "Gn 49, 8-10", "Is 49, 8-12", "Jr 33, 14-18", "Is 63, 15-19"),
   "3": sem("Ml 3, 23-24", "Is 62, 10-12", "So 3, 11-13", "Is 65, 24-25", "Is 44, 1-5", "Mi 2, 12-13", "Is 52, 7-10"),
   "4": {"dim": "Jdt 13, 18-20"},
   "dates": {"12-17": "Sg 6, 22", "12-18": "Jr 31, 1-6", "12-19": "Is 11, 10-12", "12-20": "Is 22, 20-23", "12-21": "Is 42, 5-7",
             "12-22": "Za 9, 9-10", "12-23": "Is 7, 13-15", "12-24": "Za 2, 14-17"},
  },
  "vepres": {
   "1": sem("Ap 22, 16-21", "2 P 3, 8-14", "1 Th 5, 1-9", "1 Th 5, 16-24", "Ph 3, 13-21", "Ph 4, 4-9", "1 Co 1, 7-9", jours=VJ),
   "2": sem("Rm 9, 1-5", "1 Co 15, 45-49", "1 P 1, 3-9", "1 P 1, 10-12", "Rm 4, 18-22", "2 P 1, 19-21", "Ep 1, 9-12", jours=VJ),
   "3": sem("Jc 5, 7-11", "Jc 5, 16-18", "Jude 20-25", "He 10, 36-39", "Rm 11, 25-29", "1 Co 1, 7-9", "1 Th 5, 16-24", jours=VJ),
   "dates": {"12-17": "Rm 11, 33-36", "12-18": "1 P 1, 13-16", "12-19": "Ac 13, 22-25", "12-20": "Ap 22, 16-17",
             "12-21": "1 Jn 2, 7-10", "12-22": "1 Tm 6, 13-16", "12-23": "Ap 21, 1-4"},
  },
 },
 # ─── Noël et Épiphanie
 "noel": {
  "laudes": {
   "dates": {"12-25": "He 1, 1-12", "12-26": "Ac 6, 2-6", "12-27": "Ac 4, 19-20", "12-28": "Ap 14, 4-5", "12-29": "He 1, 1-4",
             "12-30": "Is 9, 5", "12-31": "Is 4, 2-3", "01-01": "Mi 5, 1-4a", "01-02": "Is 49, 8-11", "01-03": "Is 62, 10-12",
             "01-04": "Is 45, 22-25", "01-05": "Sg 7, 24-27", "01-06": "Is 61, 1-3", "01-07": "Is 9, 5"},
   "sainte-famille": "Dt 5, 16", "epiphanie": "Is 52, 7-10", "bapteme": "Is 61, 1-3",
   "apres-epiphanie": sem("Is 9, 5", "Is 4, 2-3", "Is 49, 8-11", "Is 62, 10-12", "Is 45, 22-25", "Sg 7, 24-27", jours=J[1:]),
  },
  "vepres": {
   "dates": {"12-24": "Ga 4, 4-5", "12-25": "1 Jn 1, 1-3", "12-26": "1 Jn 1, 5-7", "12-27": "Rm 8, 3-4", "12-28": "Ep 2, 3-5",
             "12-29": "1 Jn 1, 1-3", "12-30": "2 P 1, 1-8", "12-31": "Ga 4, 4-7", "01-01": "1 Jn 1, 1-3", "01-02": "Col 1, 11-17",
             "01-03": "1 Jn 1, 5-7", "01-04": "Rm 8, 3-4", "01-05": "1 Jn 5, 20", "01-06": "Ac 10, 34-38"},
   "sainte-famille": {"vepres1": "2 Co 8, 9", "vepres2": "Ph 2, 6-7"},
   "epiphanie": {"vepres1": "2 Tm 1, 9-10", "vepres2": "Tt 3, 4-5"},
   "bapteme": {"vepres1": "Ac 10, 34-38", "vepres2": "1 Jn 5, 5-8"},
   "apres-epiphanie": sem("2 P 1, 3-4", "Ep 2, 3-5", "Col 1, 11-17", "1 Jn 1, 5-7", "Rm 8, 3-4", jours=J[1:6]),
  },
 },
 # ─── Carême (semaines II et IV valent aussi pour les jours après les Cendres)
 "careme": {
  "laudes": {
   "impair": {"dim1": "Dt 8, 1-6", "dim3": "Ex 17, 1-7", **sem("Ex 19, 3-8", "Dt 4, 32-40", "Is 1, 10-18", "Dt 30, 15-20", "Is 53, 6-12", "Jr 17, 5-10", jours=J[1:])},
   "pair": {"dim2": "Ex 34, 29-35", "dim4": "Is 42, 5-7", **sem("Dt 5, 32 – 6, 9", "Dt 7, 6-12", "Jl 2, 12-17", "1 R 8, 28-30", "Is 52, 13 – 53, 5", "Jr 9, 22-23", jours=J[1:])},
   "5": sem("Ez 37, 11-14", "Jr 8, 18-23", "Jr 11, 18-20", "Jr 20, 7-13", "Za 12, 9 – 13, 1", "Is 50, 4-10", "Nb 9, 1-5"),
   "6": sem("Za 9, 9-10", "Si 2, 1-11", "Sg 3, 1-8", "Sg 5, 1-7", jours=J[:4]),
  },
  "vepres": {
   "impair": {"dim1": {"vepres1": "Rm 5, 12-19", "vepres2": "Ep 6, 10-18"}, "dim3": {"vepres1": "1 Co 10, 1-4", "vepres2": "Ep 5, 25-32"},
              **sem("Ph 1, 27-30", "Col 1, 21-27", "Jc 1, 16-27", "Ep 4, 25 – 5, 2", "Ga 2, 19 – 3, 1", jours=J[1:6])},
   "pair": {"dim2": {"vepres1": "2 P 1, 16-19", "vepres2": "2 Co 3, 12-18"}, "dim4": {"vepres1": "2 Co 4, 1-6", "vepres2": "1 Jn 1, 5-10"},
            **sem("Ph 2, 12-16a", "2 Co 5, 14 – 6, 2", "1 P 4, 12-16", "Ga 5, 14-25", "Ph 3, 4-14", jours=J[1:6])},
   "5": {"dim5": {"vepres1": "1 Co 15, 50-57", "vepres2": "Rm 6, 2-11"},
         **sem("1 Co 1, 17-25", "1 Co 1, 27-31", "Rm 5, 6-11", "He 2, 5-13", "He 2, 14-18", jours=J[1:6])},
   "6": {"dim6": {"vepres1": "1 P 1, 17-21", "vepres2": "Ac 13, 26-30"}, **sem("He 5, 1-10", "He 9, 11-14", "He 12, 1-4", jours=J[1:4])},
  },
 },
 "triduum": {
  "tenebres": {"jeu": ["Ex 12, 21-27", "Sg 2, 10-22", "Ph 2, 6-11"], "ven": ["Gn 37, 15-25a", "Jb 16, 6-22", "He 5, 5-10"],
               "sam": ["Gn 2, 1-4a", "He 4, 3-11", "1 P 3, 18-22"]},
  "vepres-samedi": "1 Co 5, 6b-8",
 },
 # ─── Temps pascal
 "paques": {
  "laudes": {
   "1": sem("Ct 1, 1 – 2, 7", "Ct 2, 8 – 3, 5", "Ct 3, 6 – 5, 1", "Ct 5, 2 – 6, 3", "Ct 6, 4 – 7, 10a", "Ct 7, 10b – 8, 5", "Ct 8, 6-14"),
   "impair": sem("Ac 2, 22-28", "Ac 2, 29-36", "Ac 2, 36-41", "Ac 3, 12-21", "He 7, 17-28", "He 10, 11-18", "Ap 1, 4-8"),
   "pair": sem("Ac 10, 34-43", "Ac 4, 7-12", "Ac 5, 26-33", "Ac 13, 26-39", "He 9, 11-14", "He 9, 24-28", "Ap 1, 9-19"),
   "apres-ascension": sem("Ez 47, 1-12", "Ez 36, 23-28", "Jr 31, 31-34", "Nb 11, 16-17.24-29", "Sg 7, 22 – 8, 1", "Ac 1, 1-5", "Ac 1, 6-8"),
   "ascension": "2 R 2, 5-15", "pentecote": "Ez 37, 1-10",
  },
  "vepres": {
   "paques": "1 Co 15, 1-8",
   "impair": sem("1 Co 15, 1-8", "1 P 1, 1-9", "Rm 8, 5-11", "Col 2, 6-15", "Ep 2, 1-6", "Rm 1, 1-7", "1 P 3, 18-22", jours=VJ),
   "pair": sem("1 Co 15, 12-28", "1 P 2, 4-10", "Rm 10, 5-13", "Ep 1, 15-23", "Col 3, 1-11", "Ph 2, 5-11", "2 Tm 2, 1-13", jours=VJ),
   "apres-ascension": sem("Rm 8, 12-17", "Rm 8, 18-27", "1 Co 2, 7-16", "1 Co 3, 10-17", "1 Co 12, 1-11", "Ep 3, 14-21", "Ep 4, 1-6", jours=VJ),
   "ascension": {"vepres1": "Col 3, 1-4", "vepres2": "Ep 4, 7-13"},
   "pentecote": {"vepres1": "Tt 3, 4-7", "vepres2": "1 Jn 2, 24-28"},
  },
 },
 # ─── Fêtes du Seigneur après la Pentecôte
 "fetes": {
  "trinite": {"vepres1": "Ga 4, 4-7", "laudes": "1 Co 12, 4-6", "vepres2": "Ep 4, 3-6"},
  "saint-sacrement": {"vepres1": "1 Co 10, 16-17", "laudes": "Pr 9, 1-5", "vepres2": "1 Co 11, 23-25"},
  "sacre-coeur": {"vepres1": "Rm 8, 31-39", "laudes": "Jr 31, 31-34", "vepres2": "Rm 5, 6-11"},
  "christ-roi": {"vepres1": "Ep 1, 17-23", "laudes": "Ap 1, 4-6", "vepres2": "1 Co 15, 22-28"},
 },
 # ─── Sanctoral (tableau imprimé « Capitules pour Laudes et Vêpres — Sanctoral », reçu le 11/11/2026)
 "communs": {
  "dedicace": {"vepres1": "Ep 2, 19-22", "laudes": "Is 56, 7-8", "vepres2": "Ap 21, 9-14"},
  "vierge-marie": {"vepres1": "Ga 4, 4-5", "laudes": "Is 61, 10", "vepres2": "Ga 4, 4-5"},
  "apotres": {"vepres1": "Ac 2, 42-45", "laudes": "Ep 2, 19-22", "vepres2": "Ep 4, 11-13"},
  "martyrs": {"vepres1": "Rm 8, 35-39", "laudes": "2 Co 1, 3-5", "vepres2": "1 P 4, 13-14"},
  "pasteurs": {"vepres1": "1 P 5, 1-4", "laudes": "He 13, 7-9", "vepres2": "1 P 5, 1-4"},
  "docteurs": {"vepres1": "Jc 3, 17-18", "laudes": "Sg 7, 13-14", "vepres2": "Jc 3, 17-18"},
  "vierges": {"vepres1": "1 Co 7, 32-34", "laudes": "Ct 8, 7", "vepres2": "1 Co 7, 32-34"},
  "saints": {"vepres1": "Ph 3, 7-8", "laudes": "Rm 12, 1-2", "vepres2": "Rm 8, 28-30"},
  "defunts": {"laudes": "1 Th 4, 14-18", "vepres2": "1 Co 15, 55-57"},
 },
 "sanctoral": {
  "01-07": {"nom": "S. Raymond de Peñafort", "laudes": "Ga 5, 13-18", "vepres2": "1 Jn 2, 3-6"},
  "01-18": {"nom": "Ste Marguerite de Hongrie", "laudes": "Col 3, 12-13", "vepres2": "Rm 6, 4-6"},
  "01-25": {"nom": "Conversion de S. Paul", "laudes": "Ac 26, 16-18", "vepres2": "1 Co 15, 9-10"},
  "01-28": {"nom": "S. Thomas d'Aquin", "laudes": "1 Co 2, 6-10", "vepres2": "1 Co 12, 7-11"},
  "02-02": {"nom": "Présentation", "vepres1": "He 10, 5-7", "laudes": "Ml 3, 1", "vepres2": "He 4, 15-16"},
  "02-04": {"nom": "Ste Catherine de Ricci", "laudes": "2 Co 4, 8-11", "vepres2": "Ap 19, 6-9"},
  "02-22": {"nom": "Chaire de S. Pierre", "laudes": "Ac 15, 7-9", "vepres2": "1 P 1, 3-5"},
  "03-19": {"nom": "S. Joseph", "vepres1": "Col 3, 23-24", "laudes": "2 S 7, 28-29", "vepres2": "Si 3, 1-16", "incertain": "2es vêpres : « Ecc. 3, 1-16 » écrit à la main"},
  "03-25": {"nom": "Annonciation", "vepres1": "1 Jn 1, 1-4", "laudes": "Ph 2, 6-7", "vepres2": "1 Jn 1, 1-4"},
  "05-05": {"nom": "S. Vincent Ferrier (5 avril dans le tableau)", "laudes": "Jr 31, 28", "vepres2": "2 P 3, 10-15"},
  "04-20": {"nom": "Ste Agnès de Montepulciano", "laudes": "Sg 7, 7-10", "vepres2": "Rm 15, 5-6"},
  "04-25": {"nom": "S. Marc", "laudes": "1 Co 15, 1-4", "vepres2": "Col 1, 3-6"},
  "04-29": {"nom": "Ste Catherine de Sienne", "laudes": "2 Co 4, 10-11", "vepres2": "1 Co 2, 11-13"},
  "04-30": {"nom": "S. Pie V", "laudes": "2 Co 6, 3-7", "vepres2": "1 Co 3, 10-11"},
  "05-01": {"nom": "S. Joseph artisan", "laudes": "2 S 7, 28-29", "vepres2": "Col 3, 23-24"},
  "05-08": {"nom": "Notre-Dame, patronne de l'Ordre", "laudes": "Ac 1, 11-14", "vepres2": "Ap 12, 3-6"},
  "05-10": {"nom": "S. Antonin de Florence", "laudes": "1 Th 2, 2-4", "vepres2": "Col 1, 9-11"},
  "05-24": {"nom": "Translation de S. Dominique", "laudes": "Ep 3, 8-9", "vepres2": "Ph 1, 3-8"},
  "05-31": {"nom": "Visitation", "laudes": "Jl 2, 27 – 3, 1", "vepres2": "1 P 5, 5-7"},
  "06-04": {"nom": "S. Pierre de Vérone", "laudes": "2 Tm 1, 8-10", "vepres2": "1 Tm 6, 11-14"},
  "06-24": {"nom": "Nativité de S. Jean-Baptiste", "vepres1": "Ac 13, 23-25", "laudes": "Ml 3, 23-24", "vepres2": "Ac 13, 23-25"},
  "06-29": {"nom": "S. Pierre et S. Paul", "vepres1": "Rm 1, 1-7", "laudes": "1 P 4, 13-14", "vepres2": "1 Co 15, 3-8"},
  "07-22": {"nom": "Ste Marie-Madeleine", "laudes": "Sg 1, 1-2", "vepres2": "Rm 8, 28-30"},
  "07-26": {"nom": "S. Joachim et Ste Anne", "laudes": "Is 55, 3", "vepres2": "Rm 9, 4-5"},
  "08-06": {"nom": "Transfiguration", "vepres1": "Ph 3, 20-21", "laudes": "Ap 21, 23-24", "vepres2": "Rm 8, 16-17"},
  "08-08": {"nom": "S. Dominique", "vepres1": "2 Tm 4, 1-2", "laudes": "Ep 3, 8-9", "vepres2": "Ph 1, 3-8"},
  "08-15": {"nom": "Assomption", "vepres1": "Rm 8, 28-30", "laudes": "Is 61, 10", "vepres2": "1 Co 15, 22-23"},
  "08-17": {"nom": "S. Hyacinthe", "laudes": "1 Tm 2, 4-6", "vepres2": "1 Co 9, 16-17"},
  "08-23": {"nom": "Ste Rose de Lima", "laudes": "Os 2, 16-22", "vepres2": "Rm 8, 18-21"},
  "08-28": {"nom": "S. Augustin", "laudes": "Rm 13, 12-14", "vepres2": "1 Jn 1, 1-3"},
  "08-29": {"nom": "Martyre de S. Jean-Baptiste", "laudes": "Is 49, 1-2", "vepres2": "Ac 13, 23-25"},
  "09-08": {"nom": "Nativité de la Vierge Marie", "laudes": "Is 11, 1-2", "vepres2": "Rm 9, 4-5"},
  "09-14": {"nom": "Croix glorieuse", "laudes": "He 2, 9-10", "vepres2": "1 Co 1, 23-24"},
  "09-15": {"nom": "Notre-Dame des Douleurs", "laudes": "Col 1, 24-25", "vepres2": "2 Tm 2, 10-12"},
  "09-18": {"nom": "S. Jean Macias", "laudes": "Tb 4, 16-20", "vepres2": "1 Jn 3, 16-18"},
  "09-29": {"nom": "Saints Archanges", "laudes": "Gn 28, 12-13", "vepres2": "Ap 1, 4-5"},
  "10-02": {"nom": "Saints Anges gardiens", "laudes": "Ex 23, 20-21", "vepres2": "Ap 8, 3-4"},
  "10-04": {"nom": "S. François d'Assise", "laudes": "Ga 3, 19-20", "incertain": "laudes : le tableau imprimé porte Ga 3, 19-20 (peut-être Ga 2, 19-20 ?)", "vepres2": "Ga 6, 14-18"},
  "10-07": {"nom": "Notre-Dame du Rosaire", "vepres1": "Ga 4, 4-5", "laudes": "Ph 2, 8-11", "vepres2": "Ac 1, 11-14"},
  "10-09": {"nom": "S. Louis Bertrand", "laudes": "1 Co 9, 22-23", "vepres2": "Ep 3, 2-7"},
  "10-18": {"nom": "S. Luc", "laudes": "1 Co 15, 1-4", "vepres2": "Col 1, 3-6"},
  "11-01": {"nom": "Toussaint", "vepres1": "He 12, 22-24", "laudes": "Ep 1, 17-18", "vepres2": "2 Co 6, 16 – 7, 1"},
  "11-03": {"nom": "S. Martin de Porrès", "laudes": "Rm 12, 4-8", "vepres2": "1 Co 12, 28-31"},
  "11-07": {"nom": "Tous les saints de l'Ordre", "laudes": "1 Jn 1, 5-7", "vepres2": "Ph 1, 3-8"},
  "11-15": {"nom": "S. Albert le Grand", "laudes": "Jb 38, 4-7", "vepres2": "Rm 12, 4-8"},
  "12-08": {"nom": "Immaculée Conception", "vepres1": "Rm 8, 28-30", "laudes": "Is 43, 1-2", "vepres2": "Rm 5, 18-21"},
 },
}

if __name__ == "__main__":
    out = Path(__file__).resolve().parent.parent / "site" / "donnees" / "capitules.json"
    out.write_text(json.dumps(C, ensure_ascii=False, indent=0), encoding="utf-8")
    n = 0
    def compte(x):
        global n
        if isinstance(x, str): n += 1
        elif isinstance(x, dict): [compte(v) for k, v in x.items() if k not in ("nom", "incertain")]
        elif isinstance(x, list): [compte(v) for v in x]
    compte(C)
    print(f"{n} capitules → {out}")
