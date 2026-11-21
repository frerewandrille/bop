"""Ordo du carnet « Sanctoral septembre-janvier » refait depuis le .docx (20/11/2026) — appelé par construire_ordo.py,
ou seul pour corriger partitions/ordo.json :

    python3 outils/ordo_sept_jan.py

Le PDF « Sanctoral-sept-jan.pdf » (2024) est en retard sur le carnet, et le relevé automatique de ses pages laissait des
manques (Dédicace : une antienne sur deux aux laudes ; Présentation, Notre-Dame des Douleurs, sainte Thérèse : antiennes
absentes ; 28 janvier : la fin de l'hymne prise pour l'antienne du Ps 126). Les images viennent du .docx
(outils/extraire_docx_sanctoral.py --sept-jan → partitions/sj/<clé>-<n>.jpg, n = ordre des images dans le carnet) ;
le rôle de chaque image a été fixé en les regardant une à une, et contrôlé sur les pages imprimées quand l'ordre du .docx
ne suffisait pas (Croix glorieuse, Dédicace, saint Martin, saint André, Immaculée Conception). Gravures écartées.

Fêtes de l'Ordre (28 sept., 4 et 7 oct., 3, 7, 8, 15 nov., 28 janv., et 29 avril, 24 mai, 8 et 28 août du carnet
février-août) : converties depuis site/donnees/offices_op.json (même relecture, partitions/op/).
Les annexes (cantiques du NT, lucernaire festif, prières litaniques, antiennes mariales) restent celles du relevé du PDF.
"""
from __future__ import annotations
import json
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
CARNET = "sanctoral1"


def F(cle, *ns):
    return [f"sj/{cle}-{n:02d}.jpg" for n in ns]


def H(titre, f, alt=False): return {"role": "hymne", "f": f, "titre": titre, "alt": alt}
def LU(titre, f): return {"role": "lucernaire", "f": f, "titre": titre, "alt": False}
def IV(f, titre="Invitatoire"): return {"role": "invitatoire", "f": f, "titre": titre}
def R(titre, f, alt=False): return {"role": "repons", "f": f, "titre": titre, "alt": alt}
def CH(titre, f): return {"role": "choral", "f": f, "titre": titre}
def AC(f): return {"role": "acclamation", "f": f, "titre": "Acclamation de l’Évangile"}


def A(ps, f, alt=False):
    """Antienne d'un ou plusieurs psaumes (« 62 AT49 ») ; ps vide = psaume de la férie."""
    ids = ps.split() if ps else []
    txt = " & ".join(("Psaume " + i) if i[0].isdigit() else i.replace("AT", "AT ").replace("NT", "NT ") for i in ids) or "Psaume de la férie"
    d = {"role": "antiennes", "f": f, "ids": ids, "txt": txt, "libre": False, "alt": alt}
    if not ids: d["ferie"] = True
    return d


def NT(n): return {"role": "cantique", "nt": n, "annexe": True}


# ── pièces communes
LUC_FESTIF = {"role": "lucernaire", "annexe": "Lucernaire festif"}
LUC_APOTRES = LU("Joyeuse lumière (apôtres)", F("09-21", 7, 8))
LUC_MARIAL = LU("Joyeuse lumière (Vierge Marie)", F("09-08", 6, 7))
REP_MARTYRS = [R("Répons des martyrs", F("09-28", 9, 10))]
REP_PORRES = [R("Répons 1 de saint Martin de Porrès", F("11-03", 10, 11)), R("Répons 2 de saint Martin de Porrès", F("11-03", 12, 13, 14), True)]
O_MERE = H("Ô Mère de Dieu, toute belle", F("10-07", 2, 3))
VIVANT = H("Vivant auprès du Père", F("10-28", 6, 7))
PUISSANCE = H("Puissance et gloire", F("09-28", 1))
O_ROI = H("Ô Roi de gloire", F("09-28", 6))
CROIX_H = [H("Voici que les étendards", F("09-14", 4, 5, 6, 7)), H("Vexilla regis", F("09-14", 8, 9), True), H("Ton corps est brisé", F("09-14", 10, 11), True)]
CROIX_R = [R("Répons 1 de la Croix glorieuse", F("09-14", 25, 26, 27)), R("Répons 2 de la Croix glorieuse", F("09-14", 28, 29), True),
           R("Répons 3 de la Croix glorieuse", F("09-14", 30, 31), True)]
TOUS_H = [H("Hymne 1 de la Toussaint", F("11-01", 3, 4)), H("Hymne 2 de la Toussaint", F("11-01", 5, 6), True),
          H("Hymne 3 de la Toussaint", F("11-01", 7, 8, 9), True), H("Hymne 4 de la Toussaint", F("11-01", 10), True)]
TOUS_R = [R("Répons 1 de la Toussaint", F("11-01", 23, 24, 25)), R("Répons 2 de la Toussaint", F("11-01", 26, 27), True),
          R("Répons 3 de la Toussaint", F("11-01", 28, 29, 30, 31), True)]
DED_H = [H("Béni sois-tu, Seigneur Jésus, pour ton Église sainte", F("11-09", 6, 7)), H("Ô Jérusalem, cité de Dieu", F("11-09", 8, 9, 10, 11, 12, 13), True),
         H("Jésus-Christ, pierre angulaire", F("11-09", 14, 15, 16, 17, 18, 19, 20, 21), True)]
DED_R = [R("Répons 1 de la Dédicace", F("11-09", 31, 32)), R("Répons 2 de la Dédicace", F("11-09", 33, 34, 35, 36, 37), True)]
CR_H = [H("Jesu, rex admirabilis", F("christ-roi", 2, 3, 4)), H("Hymne 2 du Christ-Roi", F("christ-roi", 5), True), H("Hymne 3 du Christ-Roi", F("christ-roi", 6), True)]
CR_R = [R("Répons du Christ-Roi", F("christ-roi", 24, 25))]
IMM_R = [R("Répons de l’Immaculée Conception", F("12-08", 15, 16, 17))]
PAUL_R = [R("Répons de la conversion de saint Paul", F("01-25", 12, 13))]

ENTREES = {
    "09-08": ("Nativité de la Vierge Marie", {
        "laudes": [H("Réjouis-toi, ô Mère du Sauveur", F("09-08", 1, 2)), A("62 AT49", F("09-08", 3)), A("149", F("09-08", 4, 5)),
                   R("Répons de la Nativité de la Vierge Marie", F("09-08", 10, 11))],
        "vepres": [LUC_MARIAL, A("121", F("09-08", 8)), A("126 NT6", F("09-08", 9)), NT(6), R("Répons de la Nativité de la Vierge Marie", F("09-08", 10, 11))]}),
    "09-14": ("La Croix glorieuse", {
        "vepres1": [LUC_FESTIF, *CROIX_H, A("146", F("09-14", 12)), A("147", F("09-14", 13)), NT(7), *CROIX_R],
        "lectures": [IV(F("09-14", 2)), *CROIX_H, A("2", F("09-14", 14, 15)), A("8", F("09-14", 16, 17)), A("95", F("09-14", 18)), *CROIX_R,
                     AC(F("09-14", 32)), CH("Ta Croix est notre gloire (choral, ou Te Deum)", F("09-14", 34, 35))],
        "laudes": [IV(F("09-14", 2)), *CROIX_H, A("62 AT49", F("09-14", 19)), A("149", F("09-14", 20)), *CROIX_R],
        "vepres": [*CROIX_H, A("109", F("09-14", 21, 23)), A("115 NT11", F("09-14", 22, 24)), NT(11), *CROIX_R]}),
    "09-15": ("Notre-Dame des Douleurs", {
        "laudes": [H("Elle est debout, près de la Croix", F("09-15", 1, 2)), A("62 AT49", F("09-15", 3)), A("149", F("09-15", 4)),
                   R("Répons de Notre-Dame des Douleurs", F("09-15", 9, 10))],
        "vepres": [H("Elle est debout, près de la Croix", F("09-15", 5, 6)), A("121", F("09-15", 7)), A("126 NT6", F("09-15", 8)), NT(6),
                   R("Répons de Notre-Dame des Douleurs", F("09-15", 9, 10))]}),
    "09-21": ("Saint Matthieu, apôtre et évangéliste", {
        "laudes": [H("Béni sois-tu, Seigneur (saint Matthieu)", F("09-21", 1, 2)), A("62 AT49", F("09-21", 3)), A("62 AT49", F("09-21", 4, 5), alt=True),
                   A("149", F("09-21", 6)), R("Répons de saint Matthieu", F("09-21", 12, 13))],
        "vepres": [LUC_APOTRES, A("115", F("09-21", 9)), A("125 NT6", F("09-21", 11)), NT(6), R("Répons de saint Matthieu", F("09-21", 12, 13))]}),
    "09-29": ("Saints Michel, Gabriel et Raphaël, archanges", {
        "laudes": [H("Hymne 1 des Archanges", F("09-29", 1)), H("Hymne 2 des Archanges", F("09-29", 2), True), H("Hymne 3 des Archanges", F("09-29", 3, 5), True),
                   A("62 AT49", F("09-29", 6)), A("149", F("09-29", 7)), R("Répons des Archanges", F("09-29", 12, 13))],
        "vepres": [H("Hymne 1 des Archanges", F("09-29", 1)), H("Hymne 2 des Archanges", F("09-29", 2), True), H("Hymne 3 des Archanges", F("09-29", 3, 5), True),
                   A("8", F("09-29", 8, 9)), A("137 NT8", F("09-29", 10, 11)), NT(8), R("Répons des Archanges", F("09-29", 12, 13))]}),
    "10-01": ("Sainte Thérèse de l’Enfant-Jésus", {
        "laudes": [H("Daigne m’unir", F("10-01", 1, 2)), A("", F("10-01", 3)), A("", F("10-01", 4, 5)), R("Répons de sainte Thérèse", F("10-01", 12, 13, 14, 15))],
        "vepres": [LU("Joyeuse lumière (sainte Thérèse)", F("10-01", 7, 8)), A("", F("10-01", 9)), A("", F("10-01", 10, 11)),
                   R("Répons de sainte Thérèse", F("10-01", 12, 13, 14, 15))]}),
    "10-02": ("Les saints Anges gardiens", {
        "laudes": [H("Hymne 1 des Archanges", F("09-29", 1)), H("Hymne 2 des Archanges", F("09-29", 2), True),
                   A("62 AT49", F("09-29", 6)), A("149", F("09-29", 7)), R("Répons des Anges gardiens", F("10-02", 5))],
        "vepres": [H("Hymne 1 des Archanges", F("09-29", 1)), H("Hymne 2 des Archanges", F("09-29", 2), True),   # hymnes des laudes (le carnet n'en donne pas)
                   A("33", F("10-02", 1, 2)), NT(12), {**A("", F("10-02", 4)), "libre": True, "txt": "Vous verrez les cieux ouverts (au choix)"},
                   R("Répons des Anges gardiens", F("10-02", 5))]}),
    "10-18": ("Saint Luc, évangéliste", {
        "laudes": [H("Béni sois-tu, Seigneur (saint Luc)", F("10-18", 1, 2)), A("62 AT49", F("10-18", 3)), A("62 AT49", F("10-18", 4, 5), alt=True),
                   A("149", F("10-18", 6)), R("Répons de saint Luc", F("10-18", 10, 11))],
        "vepres": [LUC_APOTRES, A("115", F("10-18", 8)), A("125 NT6", F("10-18", 9)), NT(6), R("Répons de saint Luc", F("10-18", 10, 11))]}),
    "10-28": ("Saint Simon et saint Jude, apôtres", {
        "laudes": [H("Béni sois-tu, Seigneur (saints Simon et Jude)", F("10-28", 1, 2)), A("62 AT49", F("10-28", 3)), A("149", F("10-28", 4)),
                   R("Répons de saints Simon et Jude", F("10-28", 11, 12))],
        "vepres": [VIVANT, A("115", F("10-28", 8)), A("125 NT6", F("10-28", 9)), NT(6), R("Répons de saints Simon et Jude", F("10-28", 11, 12))]}),
    "11-01": ("Fête de tous les Saints", {
        "vepres1": [LUC_FESTIF, *TOUS_H, A("112", F("11-01", 11)), A("147", F("11-01", 12)), NT(14), *TOUS_R],
        "lectures": [IV(F("11-01", 2)), *TOUS_H, A("8", F("11-01", 14)), A("14", F("11-01", 15, 16)), A("15", F("11-01", 17)), *TOUS_R,
                     AC(F("11-01", 33)), CH("Choral de la Toussaint", F("11-01", 34))],
        "laudes": [IV(F("11-01", 2)), *TOUS_H, A("62 AT49", F("11-01", 18)), A("149", F("11-01", 19, 20)), *TOUS_R],
        "vepres": [*TOUS_H, A("109", F("11-01", 21)), A("115 NT11", F("11-01", 22)), NT(11), *TOUS_R]}),
    "11-02": ("Commémoration de tous les fidèles défunts", {
        "laudes": [H("Ô Christ, fontaine de la vie", F("11-02", 1, 2)), A("50 AT25", F("11-02", 3, 4)), A("145", F("11-02", 6)),
                   R("Répons 1 des défunts", F("11-02", 11, 12)), R("Répons 2 des défunts", F("11-02", 13, 14), True)],
        "vepres": [H("Donne à ceux qui meurent le repos éternel", F("11-02", 7, 8)), A("120", F("11-02", 9)), A("129 NT7", F("11-02", 10)), NT(7),
                   R("Répons 1 des défunts", F("11-02", 11, 12)), R("Répons 2 des défunts", F("11-02", 13, 14), True)]}),
    "11-09": ("Dédicace de la basilique du Latran", {
        "vepres1": [LUC_FESTIF, *DED_H, A("146", F("11-09", 22)), A("147", F("11-09", 23)), NT(14), *DED_R],
        "lectures": [IV(F("11-09", 2, 3), "Invitatoire 1"), {**IV(F("11-09", 4, 5), "Invitatoire 2"), "alt": True}, *DED_H,
                     A("23", F("11-09", 24)), A("83", F("11-09", 26)), A("86", F("11-09", 25)), *DED_R, AC(F("11-09", 38))],
        "laudes": [IV(F("11-09", 2, 3), "Invitatoire 1"), *DED_H, A("62 AT49", F("11-09", 27)), A("149", F("11-09", 28)), *DED_R],
        "vepres": [*DED_H, A("45", F("11-09", 29)), A("121 NT14", F("11-09", 30)), NT(14), *DED_R]}),
    "11-11": ("Saint Martin de Tours, évêque", {
        "laudes": [H("Hymne de saint Martin", F("11-11", 5, 6)), H("Martin, tu es l’apôtre (choral)", F("11-11", 2, 3, 4), True),
                   A("62 AT49", F("11-11", 7)), A("149", F("11-11", 8, 9)), *REP_PORRES],
        "vepres": [H("Hymne de saint Martin", F("11-11", 5, 6)), H("Martin, tu es l’apôtre (choral)", F("11-11", 2, 3, 4), True),
                   A("14", F("11-11", 10)), A("111 NT13", F("11-11", 11, 12)), NT(13), *REP_PORRES]}),
    "11-21": ("Présentation de la Vierge Marie", {
        "laudes": [H("Réjouis-toi, ô Mère du Sauveur (Présentation)", F("11-21", 1, 2)), A("", F("11-21", 3)), R("Répons de la Présentation", F("11-21", 7, 8))],
        "vepres": [O_MERE, A("", F("11-21", 5)), A("", F("11-21", 6)), R("Répons de la Présentation", F("11-21", 7, 8))]}),
    "11-30": ("Saint André, apôtre", {
        "laudes": [H("Béni sois-tu, Seigneur (saint André)", F("11-30", 1, 2)), A("62 AT49", F("11-30", 3)), A("149", F("11-30", 4, 5)),
                   R("Répons de saint André", F("11-30", 9, 10))],
        "vepres": [LUC_APOTRES, A("115", F("11-30", 6)), A("125 NT6", F("11-30", 7)), NT(6), R("Répons de saint André", F("11-30", 9, 10))]}),
    "christ-roi": ("Le Christ, Roi de l’univers", {
        "vepres1": [LUC_FESTIF, *CR_H, A("142 AT41", F("christ-roi", 7)), A("112", F("christ-roi", 8, 9)), A("116 NT11", F("christ-roi", 10)), NT(11), *CR_R],
        "lectures": [IV(F("christ-roi", 1)), *CR_H, A("2", F("christ-roi", 11)), A("71", F("christ-roi", 12, 13)), A("71", F("christ-roi", 14)), *CR_R,
                     AC(F("christ-roi", 26))],
        "laudes": [IV(F("christ-roi", 1)), *CR_H, A("62 AT49", F("christ-roi", 16)), A("149", F("christ-roi", 17)), *CR_R],
        "vepres": [*CR_H, A("109", F("christ-roi", 18, 19, 20)), A("144 NT14", F("christ-roi", 21, 22)), NT(14), *CR_R]}),
    "12-08": ("L’Immaculée Conception de la Vierge Marie", {
        "vepres1": [LUC_MARIAL, A("112 147", F("12-08", 1)), NT(6), *IMM_R],
        "lectures": [IV(F("12-08", 2)), H("Réjouis-toi, ô Mère du Sauveur (Immaculée)", F("12-08", 3, 4)),
                     A("23", F("12-08", 5)), A("45", F("12-08", 9)), A("86", F("12-08", 8)), *IMM_R, AC(F("12-08", 18))],
        "laudes": [IV(F("12-08", 2)), O_MERE, A("62 AT49", F("12-08", 9)), A("149", F("12-08", 10, 11)), *IMM_R],
        "vepres": [LUC_MARIAL, A("121", F("12-08", 13)), A("126 NT6", F("12-08", 14)), NT(6), *IMM_R]}),
    "01-21": ("Sainte Agnès, vierge et martyre", {
        "laudes": [H("Dans la prière et dans la foi", F("01-21", 1)), A("62 AT49", F("01-21", 2)), A("149", F("01-21", 3)), *REP_MARTYRS],
        "vepres": [PUISSANCE, A("114", F("01-21", 5)), A("115 NT11", F("01-21", 6)), NT(11), *REP_MARTYRS]}),
    "01-25": ("Conversion de saint Paul, apôtre", {
        "laudes": [H("Toi qui as fait de Pierre et de Paul", F("01-25", 2, 3)), A("62 AT49", F("01-25", 4, 5)), A("62 AT49", F("01-25", 6), alt=True),
                   A("149", F("01-25", 7)), *PAUL_R],
        "vepres": [VIVANT, A("115", F("01-25", 8)), A("115", F("01-25", 9), alt=True), A("125 NT6", F("01-25", 10)), A("125 NT6", F("01-25", 11), alt=True),
                   NT(6), *PAUL_R]}),
}


def depuis_offices_op(e):
    """Une fête de offices_op.json (propre de l'Ordre) → offices de l'ordo."""
    res = {}
    for off, o in e["offices"].items():
        p = []
        if o.get("invitatoire"): p.append(IV(o["invitatoire"]["f"]))
        p += [LU(x["titre"], x["f"]) for x in o.get("lucernaire") or []]
        p += [H(x["titre"], x["f"], n > 0) for n, x in enumerate(o.get("hymnes") or [])]
        for el in o.get("psalmodie") or []:
            ps = [x.split(":")[0] for x in el.get("ps") or []]
            if el.get("f"): p.append(A(" ".join(ps), el["f"]))
            p += [A(" ".join(ps), x["f"], alt=True) for x in el.get("ou") or []]
            p += [NT(int(x[2:])) for x in ps if x.startswith("NT")]
        p += [R(x["titre"], x["f"], n > 0) for n, x in enumerate(o.get("repons") or [])]
        if o.get("evangelique"): p.append({"role": "magnificat" if off.startswith("vepres") else "benedictus", "f": o["evangelique"]["f"], "titre": "Antienne évangélique"})
        p += [{**A("", x["f"]), "libre": True, "txt": "Antienne au choix"} for x in o.get("autres") or []]
        p += [{"role": "mariale", "f": x["f"], "titre": x["titre"]} for x in o.get("fin") or []]
        res[off] = p
    return res


def appliquer(ordo, notes=None):
    ann = {}
    for c, liste in (ordo.get("_annexes") or {}).items():
        for a in liste: ann.setdefault(c, []).append(a)
    # lucernaire festif (annexe du carnet) : relevé avant de remplacer les fêtes qui le citent
    festifs = {}
    for e in ordo.values():
        if isinstance(e, dict) and e.get("carnet"):
            for o in e.get("offices", {}).values():
                for q in o["pieces"]:
                    if q["role"] == "lucernaire" and q.get("titre") == "Lucernaire festif": festifs.setdefault(e["carnet"], q)
    def resoudre(carnet, pieces):
        out = []
        for x in pieces:
            if x.get("annexe") and x["role"] == "cantique":
                a = next((y for y in ann.get(carnet, []) if y["role"] == "cantique" and y.get("nt") == x["nt"]), None)
                if a: out.append({"role": "cantique", "f": a["f"], "titre": f"Cantique NT {x['nt']}", "nt": x["nt"]})
            elif x.get("annexe") and x["role"] == "lucernaire":
                a = festifs.get(carnet)
                if a: out.append(dict(a))
            else:
                out.append({k: v for k, v in x.items() if k != "annexe"})
        return out
    n = 0
    for cle, (nom, offices) in ENTREES.items():
        ancien = ordo.get(cle) or {}
        ordo[cle] = {"nom": ancien.get("nom") or nom, "carnet": CARNET, "page": ancien.get("page"), "source": "docx",
                     "offices": {off: {"titre": off, "page": None, "pieces": resoudre(CARNET, p)} for off, p in offices.items()},
                     "propres": ancien.get("propres", [])}
        n += 1
    op = RACINE / "site" / "donnees" / "offices_op.json"
    if op.exists():
        for cle, e in json.loads(op.read_text(encoding="utf-8")).items():
            carnet = "sanctoral1" if "septembre" in e.get("carnet", "") else "sanctoral2"
            ancien = ordo.get(cle) or {}
            offs = {off: {"titre": off, "page": None, "pieces": resoudre(carnet, p)} for off, p in depuis_offices_op(e).items()}
            ordo[cle] = {"nom": ancien.get("nom") or e["nom"], "carnet": carnet, "page": ancien.get("page"), "source": "docx",
                         "offices": offs, "propres": ancien.get("propres", []), **({"comme": "11-02"} if cle == "11-08" else {})}
            n += 1
    if notes is not None: notes.append(f"ordo_sept_jan : {n} fêtes reprises depuis les .docx des carnets")
    return ordo


if __name__ == "__main__":
    p = RACINE / "partitions" / "ordo.json"
    ordo = json.loads(p.read_text(encoding="utf-8"))
    ordo = appliquer(ordo)
    manque = sorted({f for e in ordo.values() if isinstance(e, dict) and e.get("source") == "docx" for o in e["offices"].values()
                     for x in o["pieces"] for f in x.get("f", []) if not (RACINE / "partitions" / f).exists()})
    p.write_text(json.dumps(ordo, ensure_ascii=False, indent=0), encoding="utf-8")
    print(f"partitions/ordo.json : {sum(1 for e in ordo.values() if isinstance(e, dict) and e.get('source') == 'docx')} fêtes depuis les .docx ; images absentes : {manque or 'aucune'}")
