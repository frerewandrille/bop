"""Lecture du texte d'un ancien fichier Word (.doc, Word 97-2003), sans dépendance.

Le format .doc est un « fichier composé » (CFB) contenant un flux WordDocument
et une table des morceaux de texte (piece table). On reconstitue le texte brut.
Les mises en forme (gras…) ne sont pas lues ici : pour le psautier, on passe
par l'outil `textutil` de macOS, qui les conserve (voir construire_donnees.py).
"""
from __future__ import annotations
import struct
from pathlib import Path

FIN = 0xFFFFFFFE
LIBRE = 0xFFFFFFFF


class FichierCompose:
    def __init__(self, donnees: bytes):
        self.d = donnees
        if donnees[:8] != bytes.fromhex("D0CF11E0A1B11AE1"):
            raise ValueError("ce n'est pas un fichier Word 97-2003 (.doc)")
        self.secteur = 1 << struct.unpack_from("<H", donnees, 30)[0]
        self.mini = 1 << struct.unpack_from("<H", donnees, 32)[0]
        nb_fat, dir1, = struct.unpack_from("<II", donnees, 44)[0], struct.unpack_from("<I", donnees, 48)[0]
        self.seuil_mini = struct.unpack_from("<I", donnees, 56)[0]
        minifat1, nb_minifat, difat1, nb_difat = struct.unpack_from("<IIII", donnees, 60)
        difat = list(struct.unpack_from("<109I", donnees, 76))
        s = difat1
        for _ in range(nb_difat):
            bloc = self._secteur(s)
            n = self.secteur // 4
            vals = struct.unpack_from(f"<{n}I", bloc)
            difat += vals[:-1]
            s = vals[-1]
        fat_secteurs = [x for x in difat if x not in (FIN, LIBRE)][:nb_fat]
        self.fat = []
        for x in fat_secteurs:
            self.fat += struct.unpack_from(f"<{self.secteur // 4}I", self._secteur(x))
        self.entrees = {}
        rep = self._chaine(dir1)
        racine = None
        for i in range(0, len(rep), 128):
            e = rep[i:i + 128]
            lnom = struct.unpack_from("<H", e, 64)[0]
            nom = e[:max(lnom - 2, 0)].decode("utf-16le", "replace")
            typ = e[66]
            debut, taille = struct.unpack_from("<II", e, 116)[0], struct.unpack_from("<I", e, 120)[0]
            if typ == 5:
                racine = (debut, taille)
            elif typ == 2:
                self.entrees[nom] = (debut, taille)
        self.flux_mini = self._chaine(racine[0])[:racine[1]] if racine else b""
        self.minifat = []
        if nb_minifat:
            b = self._chaine(minifat1)
            self.minifat = list(struct.unpack_from(f"<{len(b) // 4}I", b))

    def _secteur(self, n: int) -> bytes:
        o = (n + 1) * self.secteur
        return self.d[o:o + self.secteur]

    def _chaine(self, debut: int) -> bytes:
        morceaux, s, vus = [], debut, 0
        while s not in (FIN, LIBRE) and vus < len(self.fat) + 1:
            morceaux.append(self._secteur(s))
            s = self.fat[s]
            vus += 1
        return b"".join(morceaux)

    def flux(self, nom: str) -> bytes:
        debut, taille = self.entrees[nom]
        if taille < self.seuil_mini:
            out, s = [], debut
            while s not in (FIN, LIBRE):
                o = s * self.mini
                out.append(self.flux_mini[o:o + self.mini])
                s = self.minifat[s]
            return b"".join(out)[:taille]
        return self._chaine(debut)[:taille]


def texte_doc(chemin: Path) -> str:
    cf = FichierCompose(Path(chemin).read_bytes())
    wd = cf.flux("WordDocument")
    drapeaux = struct.unpack_from("<H", wd, 0x0A)[0]
    table = cf.flux("1Table" if drapeaux & 0x0200 else "0Table")
    fc_clx, lcb_clx = struct.unpack_from("<II", wd, 0x01A2)
    clx = table[fc_clx:fc_clx + lcb_clx]
    i = 0
    while clx[i] == 1:  # propriétés de mise en forme préalables : ignorées
        i += 3 + struct.unpack_from("<H", clx, i + 1)[0]
    if clx[i] != 2:
        raise ValueError("table des morceaux introuvable")
    lcb = struct.unpack_from("<I", clx, i + 1)[0]
    plc = clx[i + 5:i + 5 + lcb]
    n = (lcb - 4) // 12
    cps = struct.unpack_from(f"<{n + 1}I", plc)
    morceaux = []
    for k in range(n):
        fc = struct.unpack_from("<I", plc, 4 * (n + 1) + 8 * k + 2)[0]
        nb = cps[k + 1] - cps[k]
        if fc & 0x40000000:
            o = (fc & 0x3FFFFFFF) // 2
            morceaux.append(wd[o:o + nb].decode("cp1252", "replace"))
        else:
            morceaux.append(wd[fc:fc + 2 * nb].decode("utf-16le", "replace"))
    t = "".join(morceaux)
    for a, b in (("\r", "\n"), ("\x07", "\t"), ("\x0b", "\n"), ("\x0c", "\n")):
        t = t.replace(a, b)
    return t
