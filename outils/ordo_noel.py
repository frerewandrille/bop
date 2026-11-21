"""Offices du livret « Noël & Épiphanie », décrits office par office d'après son sommaire et ses renvois
(« Hymne p. 50 », « Antiennes p. 37 & 38 ou p. 52 & 53 », « Répons p. 54 »…). Pages = pages du PDF (= pages imprimées).
Appelé par construire_ordo.py ; les entrées rejoignent partitions/ordo.json.
"""
import json
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
NT = {7: (241, 243), 14: (244, 245), 6: (246, 248), 11: (249, 250), 8: (251, 253), 12: (254, 256), 13: (257, 258)}


def ajouter(ordo, notes):
    f = RACINE / "partitions" / "noel" / "pieces.json"
    if not f.exists():
        notes.append("noel : découpage absent"); return ordo
    par_page = {}
    for x in json.loads(f.read_text()):
        if x.get("nature") in ("image", "titre"): continue
        par_page.setdefault(x["page"], []).append(x)

    def fich(a, b=None):
        out = []
        for p in range(a, (b or a) + 1):
            ps = par_page.get(p)
            out += [f"noel/{x['fichier']}" for x in ps] if ps else [f"noel/p-{p:03d}.jpg"]
        return out

    def P(role, titre, a, b=None, alt=False, **k):
        return {"role": role, "titre": titre, "f": fich(a, b), "alt": alt, **k}

    def A(a, b=None, alt=False, libre=False):
        """Antiennes des pages a..b : une par étiquette « Psaume N » (les images sans étiquette vont avec la suivante)."""
        out, tampon = [], []
        for p in range(a, (b or a) + 1):
            for x in par_page.get(p, []):
                tampon.append(f"noel/{x['fichier']}")
                ids = x.get("ids") or []
                if ids and str(x.get("dessous", "")).startswith(("Psaume", "Ps")):
                    out.append({"role": "antiennes", "f": tampon, "ids": ids, "txt": x["dessous"], "alt": alt, "libre": libre}); tampon = []
        if tampon:
            if out and not alt: out[-1]["f"] += tampon
            else: out.append({"role": "antiennes", "f": tampon, "ids": [], "txt": "", "alt": alt, "libre": libre})
        return out

    def C(n): return {"role": "cantique", "titre": f"Cantique NT {n}", "f": fich(*NT[n]), "nt": n}
    LUC, HY = P("lucernaire", "Lucernaire de Noël", 4, 5), P("hymne", "Hymne de Noël", 6, 7)
    INV = P("invitatoire", "Invitatoire de Noël", 13, 17)
    TD = P("tedeum", "Te Deum", 33, 35)
    RV = P("repons", "Répons des vêpres de Noël", 10, 11)
    RL = P("repons", "Répons des laudes de Noël", 40, 41)
    R = [P("repons", "Répons 1 - Vigiles de Noël", 26, 27), P("repons", "Répons 2 - Vigiles de Noël", 28, 29), P("repons", "Répons 3 - Vigiles de Noël", 30, 31)]
    MAG = P("magnificat", "Magnificat (Noël et octave)", 47)
    PL, PV = P("priere", "Prière litanique des laudes", 42, 43), P("priere", "Prière litanique des vêpres", 48, 49)
    # antiennes des laudes de Noël et de l'octave (p. 37 : Ps 62 ou 92 & AT 49 ; p. 38-39 : Ps 149 ou 148)
    AL = [{"role": "antiennes", "f": fich(37), "ids": ["62", "92", "117", "AT49", "AT48"], "txt": "Psaume 62 (octave - 92) - Cantique AT 49"},
          {"role": "antiennes", "f": fich(38, 39), "ids": ["149", "148", "150"], "txt": "Psaume 149 (octave 148)"}]
    VEP_OCT = [LUC, HY] + A(44) + A(46) + [C(8), RV, MAG, PV]      # vêpres de l'octave
    LAUDES_OCT = [P("hymne", "Hymne des laudes de Noël", 36)] + AL + [RL, PL]

    def fete(cle, nom, page, **offices):
        ordo[cle] = {"nom": nom, "carnet": "noel", "page": page,
                     "offices": {k: {"titre": f"{k} — {nom}", "page": page, "pieces": [dict(x) for x in v]} for k, v in offices.items()}}

    fete("12-25", "Nativité du Seigneur", 4,
         vepres1=[LUC, HY] + A(8, 9) + [C(7), RV, P("magnificat", "Magnificat (1res vêpres de Noël)", 12), PV],
         lectures=[INV, P("hymne", "Hymne des vigiles de Noël", 18, 19)] + A(20, 22) + [R[0], dict(R[1], alt=True), dict(R[2], alt=True), TD],
         laudes=LAUDES_OCT,
         vepres=[LUC, HY] + A(44, 45) + [C(8), RV, MAG, PV])
    for cle, nom, page, hy, ant, rep in [("12-26", "Saint Étienne, premier martyr", 50, (50, 51), (52, 53), (54, 55)),
                                         ("12-27", "Saint Jean, apôtre et évangéliste", 57, (58, 59), (60, 61), (62, 63)),
                                         ("12-28", "Les Saints Innocents, martyrs", 65, (66, 67), (68, 69), (70, 71))]:
        H, Rp = P("hymne", f"Hymne — {nom}", *hy), P("repons", f"Répons — {nom}", *rep)
        fete(cle, nom, page,
             lectures=[INV, H] + A(*ant) + [Rp],
             laudes=[H] + AL + A(*ant, alt=True, libre=True) + [Rp, PL],
             vepres=VEP_OCT)
    for cle, n, page, ant, k in [("12-29", 5, 73, (74, 75), 0), ("12-30", 6, 77, (78, 79), 1), ("12-31", 7, 81, (82, 83), 2)]:
        fete(cle, f"{n}e jour dans l'octave de Noël", page,
             lectures=[INV, P("hymne", "Hymne des vigiles de Noël", 18, 19)] + A(*ant) + [R[k]],
             laudes=LAUDES_OCT, vepres=VEP_OCT)
    HM, RM = P("hymne", "Hymne de la Mère de Dieu", 86), P("repons", "Répons de la Mère de Dieu", 91, 93)
    fete("01-01", "Sainte Marie, Mère de Dieu", 85,
         vepres1=[LUC, HM] + A(44) + A(46) + [C(6), RM, MAG, PV],
         lectures=[INV, HM] + A(88, 90) + [RM, TD],
         laudes=[HM] + AL + [RM, PL],
         vepres=[LUC, HM] + A(95, 96) + [C(6), RM, MAG, PV])
    fete("sainte-famille", "La Sainte Famille", 97,
         vepres1=[LUC, HY] + A(8, 9) + [C(6), RV, PV],
         lectures=[INV, P("hymne", "Hymne des vigiles de Noël", 18, 19)] + A(99, 100) + [R[2], TD],
         laudes=LAUDES_OCT, vepres=VEP_OCT)
    LE, HE = P("lucernaire", "Lucernaire de l'Épiphanie", 106, 107), P("hymne", "Hymne de l'Épiphanie", 108, 109)
    RE = [P("repons", "Répons 1 de l'Épiphanie", 118, 119), P("repons", "Répons 2 de l'Épiphanie", 120, 121), P("repons", "Répons 3 de l'Épiphanie", 122, 123)]
    IE = P("invitatoire", "Invitatoire de l'Épiphanie", 111, 114)
    fete("epiphanie", "Épiphanie du Seigneur", 105,
         vepres1=[LE, HE] + A(110) + [C(13), RE[1], PV],
         lectures=[IE, HE] + A(116, 117) + [RE[0], dict(RE[1], alt=True), dict(RE[2], alt=True), TD, P("choral", "Choral de l'Épiphanie", 136, 137)],
         laudes=[HE] + A(125, 126) + [RE[0], PL],
         vepres=[LE, HE] + A(127, 128) + [C(13), RE[1], PV])
    # féries du temps de Noël : hymnes et répons au choix, antiennes par jour
    HF = [P("hymne", t, a, b, alt=i > 0) for i, (t, a, b) in enumerate([("Peuple fidèle", 138, 138), ("Dans un profond silence", 139, 139),
          ("Quand vient la plénitude des temps", 140, 140), ("L'enfant est né à Bethléem", 141, 141), ("Splendeur jaillie du sein de Dieu", 143, 143)])]
    GL = [P("hymne", "Gloria gouzantin", 130, 131, alt=True), P("hymne", "Gloria mozarabe", 132, 133, alt=True)]
    RFL = [P("repons", "Répons 1 des laudes", 156, 157), P("repons", "Répons 2 des laudes", 158, 159, alt=True)]
    RFV = [P("repons", "Répons 1 des vêpres", 160, 161), P("repons", "Répons 2 des vêpres", 162, 163, alt=True), P("repons", "Répons 3 des vêpres", 164, 165, alt=True)]
    NTJ = {"lundi": 6, "mardi": 11, "mercredi": 8, "jeudi": 12, "vendredi": 13}
    for i, jour in enumerate(["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"]):
        off = {"laudes": HF + GL + A(144 + 2 * i) + RFL + [PL]}
        if jour != "samedi": off["vepres"] = HF + A(145 + 2 * i) + [C(NTJ[jour])] + RFV + [PV]
        fete(f"noel-ferie-{jour}", f"Férie du temps de Noël ({i + 2} janvier ou {jour} après l'Épiphanie)", 144 + 2 * i, **off)
    LB, HB = P("lucernaire", "Lucernaire du Baptême", 166, 167), P("hymne", "Hymne du Baptême", 168, 169)
    RB = P("repons", "Répons du Baptême du Seigneur", 178, 179)
    fete("bapteme", "Baptême du Seigneur", 166,
         vepres1=[LB, HB] + A(170) + [C(11), RB, PV],
         lectures=[P("invitatoire", "Invitatoire du Baptême", 171, 174), HB] + A(175, 176) + [P("repons", "Répons 1 du Baptême du Seigneur", 177), dict(RB, alt=True), TD, P("choral", "Choral du Baptême du Seigneur", 182, 183)],
         laudes=[HB] + A(184) + [RB, PL],
         vepres=[LB, HB] + A(185, 186) + [C(13), RB, PV])
    HC, RC = P("hymne", "Hymne de Cana", 190, 191), P("repons", "Répons des Noces de Cana", 196, 197)
    fete("cana", "Dimanche des noces de Cana (2e dimanche du temps ordinaire, année C)", 187,
         vepres1=[P("lucernaire", "Lucernaire de Cana", 188, 189), HC] + A(192) + [C(7), RC],
         lectures=[HC] + A(193, 195) + [RC, TD, P("choral", "Choral de Cana", 200, 201)],
         laudes=[HC] + A(202) + [RC],
         vepres=[HC] + A(203, 204) + [C(14), RC])
    HA, RA = P("hymne", "Hymne de l'appel des disciples", 206, 207), P("repons", "Répons 1 des vêpres (temps de Noël)", 160, 161)
    fete("appel", "Dimanche de l'appel des disciples (3e dimanche du temps ordinaire, années A et B)", 205,
         vepres1=[LE, HA] + A(208) + [C(7), RA],
         lectures=[IE, HA] + A(209, 210) + [RA, TD],
         laudes=[HA] + A(212, 213) + [RA],
         vepres=[LE, HA] + A(214, 215) + [C(14), RA])
    LP, HP = P("lucernaire", "Lucernaire de la Présentation", 218, 219), P("hymne", "Hymne de la Présentation", 220, 223)
    RP = P("repons", "Répons de la Présentation", 232, 233)
    fete("02-02", "Présentation du Seigneur au Temple", 217,
         vepres1=[LP, HP] + A(224) + [C(7), RP, PV],
         lectures=[P("invitatoire", "Invitatoire de la Présentation", 225, 228), HP] + A(230, 231) + [RP, TD, P("choral", "Choral de la Présentation", 236, 237)],
         laudes=[HP] + A(230, 231) + [RP, PL],
         vepres=[LP, HP] + A(239) + [C(8), RP, PV])
    return ordo
