"""Propre de l'Ordre dans les carnets du sanctoral de la Province → site/donnees/offices_op.json

    python3 outils/offices_op.py

Pour chaque célébration de l'Ordre présente dans les carnets « Sanctoral » (septembre-janvier, février-août),
office par office : hymnes, psaumes (et cantiques), antiennes (texte transcrit à l'œil sur la partition + images),
répons, antienne évangélique, antiennes au choix. Images : partitions/op/<clé>-<n>.jpg, tirées des .docx des
carnets par outils/extraire_docx_sanctoral.py (numéros = ordre des images dans le carnet ; gravures écartées :
vérifiées à l'œil et par la densité d'encre, 01-28-09 et -30, 04-29-25 et -29…).
Relu image par image le 20/11/2026. Les renvois du carnet (« Psalmodie p. 138 », « Voir au 2 novembre »,
« Hymne p. 268 s. ») sont résolus ici.

Clés des psaumes : numéros du psautier (« 62 », « AT49 » = Dn 3, « NT8 » = Col 1…) ; « 88:2-19 » = versets choisis.
Un élément de psalmodie = une antienne pour un ou plusieurs psaumes (« Psaume 62 & AT 49 »).
« ferie » : antiennes propres sur les psaumes de la férie (mémoire de la Translation).
Les cantiques du NT gardent leur partition gravée (refrain) : rien à indiquer ici.
"""
from __future__ import annotations
import json
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
SORTIE = RACINE / "site" / "donnees" / "offices_op.json"


def f(cle, *ns):
    return [f"op/{cle}-{n:02d}.jpg" for n in ns]


def ant(texte, fichiers, ps=None, **x):
    d = {"ant": texte, "f": fichiers}
    if ps: d["ps"] = ps
    d.update(x)
    return d


def hy(titre, fichiers, **x):
    return {"titre": titre, "f": fichiers, **x}


# ── Pièces communes à plusieurs fêtes (mêmes images dans le carnet)
AU_SEIN = hy("Au sein de son Église", f("05-24", 2))
O_ROI = hy("Ô Roi de gloire", f("09-28", 6))
PUISSANCE = hy("Puissance et gloire", f("09-28", 1))
TOUSSAINT_HYMNES = [hy("Hymne 1 de la Toussaint", f("11-01", 3, 4)), hy("Hymne 2 de la Toussaint", f("11-01", 5, 6)),
                    hy("Hymne 3 de la Toussaint", f("11-01", 7, 8, 9)), hy("Hymne 4 de la Toussaint", f("11-01", 10))]
# saint Dominique (8 août) et sa Translation (24 mai) : mêmes antiennes
BIENHEUREUX_SOIF = ("Bienheureux celui qui a soif de Dieu, affamé de justice, pour le salut du monde.", f("05-24", 4, 5))
GRAND_DESIR = ("D’un grand désir, Dominique a désiré que tous les peuples te cherchent, Seigneur, et te chantent "
               "d’un cœur unanime, dans l’unité de ton Esprit.", f("05-24", 6, 7))
O_CHRIST_SAUVEUR = ("Ô Christ Sauveur, c’est dans le livre de ta Croix que Dominique apprit le chemin de la Vie.", f("05-24", 9))
SANS_SE_LASSER = ("Sans se lasser, Dominique a contemplé ta face, Seigneur, et son visage a rayonné de ta lumière.", f("05-24", 10, 11))
SERVITEUR = ("Voici le serviteur fidèle que le Seigneur a établi sur sa maison.", f("08-28", 6, 7))
DOMINIQUE_HYMNES = [AU_SEIN, hy("Dieu a donné son Fils", f("08-08", 3)), hy("Comme ils sont beaux", f("08-08", 4, 5)),
                    hy("Au ciel les Anges", f("08-08", 6))]
DOMINIQUE_REPONS = [hy("Jésus Sauveur", f("05-24", 12, 14, 15)), hy("Ô Jésus-Christ, notre Sauveur", f("08-08", 37, 38)),
                    hy("D’un grand désir, Dominique", f("08-08", 39, 40)), hy("Sans se lasser, Dominique", f("08-08", 41, 42, 43)),
                    hy("Mon Dieu, ma miséricorde", f("08-08", 44)), hy("O spem miram (grégorien)", f("08-08", 45))]
O_LUMEN = {"ant": "O lumen Ecclésiæ, doctor veritátis, rosa patiéntiæ, ebur castitátis, aquam sapiéntiæ propinásti gratis ; "
                  "prædicátor grátiæ, nos iunge beátis.", "f": f("08-08", 46), "latin": True}
REPONS_MARTYRS = [hy("Répons des martyrs", f("09-28", 9, 10))]

FETES = {
    "09-28": {
        "nom": "S. Guillaume Courtet et ses compagnons", "carnet": "Sanctoral (septembre-janvier)",
        "laudes": {"hymnes": [hy("Puissance et gloire", f("09-28", 1))], "psalmodie": [
            ant("Allez : enseignez tous les peuples ! Que l’univers voie le salut de Dieu !", f("09-28", 2, 3), ["62", "AT49"]),
            ant("Leur parole a retenti jusqu’aux lointains de la terre, et leur message jusqu’aux limites du monde.", f("09-28", 4, 5), ["149"])],
            "repons": REPONS_MARTYRS},
        "vepres": {"hymnes": [O_ROI], "psalmodie": [
            ant("Voici que je vous envoie comme des brebis au milieu des loups.", f("09-28", 7), ["114"]),
            ant("Celui qui perd sa vie à cause de moi la sauvera, et sa chair refleurira !", f("09-28", 8), ["115", "NT11"])],
            "repons": REPONS_MARTYRS},
    },
    "10-04": {
        "nom": "N. P. S. François d’Assise", "carnet": "Sanctoral (septembre-janvier)",
        "laudes": {"hymnes": [hy("Très-Haut, puissant et bon Seigneur", f("10-04", 1, 2))], "psalmodie": [
            ant("Que le Seigneur nous bénisse et nous garde, que le Seigneur nous découvre sa face et nous donne sa paix !", f("10-04", 3), ["62", "AT49"],
                ou=[ant("Que le Seigneur nous bénisse et nous garde… (autre mélodie)", f("10-04", 4))]),
            ant("Louez et bénissez mon Seigneur, rendez-lui grâce et servez-le en grande humilité !", f("10-04", 5, 6), ["149"])],
            "repons": [hy("Répons de saint François", f("10-04", 10, 11, 12))]},
        "vepres": {"hymnes": [hy("Très-Haut, puissant et bon Seigneur", f("10-04", 1, 2))], "psalmodie": [
            ant("Toi seul es fort, toi seul es grand, tu es le Très-Haut, le Tout-Puissant, toi, Père saint, Père du ciel et de la terre.",
                f("10-04", 7, 8), ["14", "111"]),
            {"ps": ["NT13"]}],
            "repons": [hy("Répons de saint François", f("10-04", 10, 11, 12))],
            "fin": [hy("Antienne mariale", f("10-04", 13))]},
    },
    "10-07": {
        "nom": "Notre-Dame du Rosaire", "carnet": "Sanctoral (septembre-janvier)",
        "laudes": {"hymnes": [hy("Ô Mère de Dieu, toute belle", f("10-07", 2, 3))], "psalmodie": [
            ant("Le Verbe s’est fait chair : bénie soit la Mère de Dieu, la Vierge qui porte en son sein le Dieu d’avant les siècles !",
                f("10-07", 4), ["62", "AT49"], mysteres="Mystères joyeux"),
            ant("Voici les noces de l’Agneau : vers lui s’avance dans l’allégresse son Épouse, vêtue d’une lumière éclatante.",
                f("10-07", 5), ["149"], mysteres="Mystères lumineux")],
            "repons": [hy("Répons des laudes du Rosaire", f("10-07", 7, 8))]},
        "vepres": {"lucernaire": [hy("Joyeuse lumière (Vierge Marie)", f("10-07", 9, 10))], "psalmodie": [
            ant("Jésus, ton enfant, ô Marie, sera un signe de contradiction, et un glaive de douleur, ô Marie, transpercera ton âme.",
                f("10-07", 11), ["121"], mysteres="Mystères douloureux"),
            ant("Le Roi, ton Bien-Aimé, désire ta beauté, ô Marie : entre dans son jardin, toi, la Reine des cieux !",
                f("10-07", 12), ["126", "NT6"], mysteres="Mystères glorieux")],
            "repons": [hy("Répons des vêpres du Rosaire", f("10-07", 13, 14))]},
    },
    "11-03": {
        "nom": "Saint Martin de Porrès, religieux", "carnet": "Sanctoral (septembre-janvier)",
        "laudes": {"hymnes": [hy("Heureux les pauvres", f("11-03", 2))], "psalmodie": [
            ant("Bienheureux ceux qui cherchent la paix, bienheureux les cœurs purs, car ils verront Dieu !", f("11-03", 3), ["62", "AT49"]),
            ant("Toutes les nations viendront te rendre gloire ; rassemble nos cœurs pour qu’ils t’adorent !", f("11-03", 4, 5, 6), ["149"])],
            "repons": [hy("Répons 1 de saint Martin de Porrès", f("11-03", 10, 11)), hy("Répons 2 de saint Martin de Porrès", f("11-03", 12, 13, 14))]},
        "vepres": {"hymnes": [hy("Heureux ceux que tu combles", f("11-03", 7))], "psalmodie": [
            ant("Voici le serviteur fidèle que le Seigneur a établi sur sa maison.", f("11-03", 8), ["14"]),
            ant("Tu as révélé ta Parole, Seigneur, pour illuminer le cœur des pauvres.", f("11-03", 9), ["111", "NT13"])],
            "repons": [hy("Répons 1 de saint Martin de Porrès", f("11-03", 10, 11)), hy("Répons 2 de saint Martin de Porrès", f("11-03", 12, 13, 14))]},
    },
    "11-07": {
        "nom": "Tous les Saints et Bienheureux de l’Ordre des Prêcheurs", "carnet": "Sanctoral (septembre-janvier)",
        "laudes": {"hymnes": TOUSSAINT_HYMNES, "renvoi": "hymnes et psalmodie de la Toussaint", "psalmodie": [
            ant("Dansez devant la face de Dieu ! Alléluia, alléluia ! Lui qui se lève comme un feu, et qui disperse l’ennemi.", f("11-01", 18), ["62", "AT49"]),
            ant("Alléluia, alléluia, alléluia, alléluia !", f("11-01", 19, 20), ["149"])],
            "repons": [hy("Répons de la Toussaint de l’Ordre", f("11-07", 4, 5))]},
        "vepres": {"hymnes": TOUSSAINT_HYMNES, "psalmodie": [
            ant("Heureux ceux dont la persévérance a gardé la loi du Seigneur et la foi en Jésus, notre Seigneur, suivant leur Père Dominique : "
                "heureux sont-ils dès à présent !", f("11-07", 2, 3), ["88:2-19", "97"]),
            {"ps": ["NT8"]}],
            "repons": [hy("Répons de la Toussaint de l’Ordre", f("11-07", 4, 5))]},
    },
    "11-08": {
        "nom": "Anniversaire de tous les frères et sœurs défunts de l’Ordre des Prêcheurs", "carnet": "Sanctoral (septembre-janvier)",
        "laudes": {"hymnes": [hy("Ô Christ, fontaine de la vie", f("11-02", 1, 2))], "renvoi": "office du 2 novembre", "psalmodie": [
            ant("Ma chair reposera dans l’espérance.", f("11-02", 3, 4), ["50", "AT25"]),
            ant("Illumine mes yeux, Seigneur, en ton salut ! Que dans un chant de joie je m’éveille des morts !", f("11-02", 6), ["145"])],
            "repons": [hy("Répons 1 des défunts", f("11-02", 11, 12)), hy("Répons 2 des défunts", f("11-02", 13, 14))]},
        "vepres": {"hymnes": [hy("Donne à ceux qui meurent le repos éternel", f("11-02", 7, 8))], "renvoi": "office du 2 novembre", "psalmodie": [
            ant("Je le crois, je verrai la bonté du Seigneur sur la terre des vivants !", f("11-02", 9), ["120"]),
            ant("Dans les profondeurs de la mort, le Seigneur a veillé ; il s’est relevé, aurore du salut.", f("11-02", 10), ["129", "NT7"])],
            "repons": [hy("Répons 1 des défunts", f("11-02", 11, 12)), hy("Répons 2 des défunts", f("11-02", 13, 14))]},
    },
    "11-15": {
        "nom": "Saint Albert le Grand, évêque et docteur", "carnet": "Sanctoral (septembre-janvier)",
        "laudes": {"hymnes": [hy("Au sein de son Église", f("11-15", 1))], "psalmodie": [
            ant("Je ne vous appelle plus serviteurs, mais amis : ce que j’ai appris de mon Père, je vous l’ai fait connaître.", f("11-15", 2), ["62", "AT49"]),
            ant("Un cantique pour moi, Seigneur, ta Parole !", f("11-15", 3), ["149"])],
            "repons": [hy("Répons de saint Albert", f("11-15", 8, 9))]},
        "vepres": {"hymnes": [O_ROI], "psalmodie": [
            ant("Si vous gardez ma Parole, vous connaîtrez la vérité, et la vérité vous rendra libres !", f("11-15", 4), ["14"]),
            ant("Méditant jour et nuit ta Parole, Seigneur, il a bâti sa maison sur le roc de ton amour.", f("11-15", 5, 6), ["111", "NT13"])],
            "repons": [hy("Répons de saint Albert", f("11-15", 8, 9))]},
    },
    "01-28": {
        "nom": "Saint Thomas d’Aquin, docteur", "carnet": "Sanctoral (septembre-janvier)",
        "laudes": {"hymnes": None, "psalmodie": [
            ant("Brûlante est ta parole, Seigneur mon Dieu : c’est pourquoi ton serviteur l’a aimée.", f("01-28", 10), ["62", "AT49"]),
            ant("Ce que nos yeux ont contemplé du Verbe de vie, nous l’annonçons pour votre joie, alléluia, alléluia !", f("01-28", 11), ["149"],
                ou=[ant("Le fruit de la lumière consiste en toute bonté, justice et vérité.", f("01-28", 12, 13, 14))])],
            "repons": [hy("Répons 1 de saint Thomas", f("01-28", 21, 22, 23, 24, 25)), hy("Répons 2 de saint Thomas", f("01-28", 26, 27, 28, 29))]},
        "vepres": {"hymnes": None, "psalmodie": [
            ant("Tout don parfait vient du Père des lumières : il nous a enfantés par la Parole de vérité.", f("01-28", 15), ["126"],
                ou=[ant("Puisque tu as demandé la Sagesse, j’exauce ta prière : je te donne un cœur sage et intelligent, dit le Seigneur.", f("01-28", 17, 18))]),
            ant("Celui qui fait la vérité vient à la lumière.", f("01-28", 16), ["110", "NT8"],
                ou=[ant("La Sagesse est la splendeur de la lumière éternelle, miroir sans tache de la gloire du Très-Haut.", f("01-28", 19, 20))])],
            "repons": [hy("Répons 1 de saint Thomas", f("01-28", 21, 22, 23, 24, 25)), hy("Répons 2 de saint Thomas", f("01-28", 26, 27, 28, 29))]},
        "_hymnes": [hy("Au sein de son Église", f("01-28", 2)),
                    hy("Loué sois-tu, Jésus, toi le témoin fidèle", f("01-28", 3), texte=[
                        ["Loué sois-tu Jésus, toi le témoin fidèle", "Pour saint Thomas que tu as revêtu de ton Esprit",
                         "Tu l’as mené sur le chemin de ton Royaume", "Et dans ton amour des hommes / tu as fait route avec lui."],
                        ["Loué sois-tu ô Christ pour saint Thomas notre frère", "Tu as rendu son cœur ardent pour les Écritures",
                         "Il contemplait ta beauté, toi qui t’es révélé", "Lui qui t’a désiré pour unique récompense."],
                        ["Loué sois-tu ô Christ pour saint Thomas notre frère", "Lui qui fut pour ton Église miroir de lumière et d’intelligence",
                         "Il nous enseigne les splendeurs du Verbe", "La profondeur des Écritures / et la voie très pure de ta vérité."],
                        ["Gloire au Père qui nous appelle à son Royaume", "Gloire au Christ Verbe de Dieu",
                         "Gloire à l’Esprit qui nous donne la vie", "Trinité bienheureuse / gloire à toi."]]),
                    hy("Thomas, toujours tourné vers Dieu", f("01-28", 4, 5, 6)),
                    hy("Thomas, chercheur du Dieu vivant (choral)", f("01-28", 7, 8))],
    },
    "04-29": {
        "nom": "Sainte Catherine de Sienne, vierge et docteur", "carnet": "Sanctoral (février-août)",
        "laudes": {"hymnes": None, "psalmodie": [
            ant("Mon âme a soif du Dieu de vie : quand le verrai-je face à face ?", f("04-29", 9), ["62", "AT49"],
                ou=[ant("Ton amour a consumé le mal par le bois de sa croix, et ce feu de douceur ne s’est jamais éteint.", f("04-29", 10))]),
            ant("J’entends mon Bien-Aimé : voici qu’il vient, sautant par les montagnes, bondissant sur les collines !", f("04-29", 11), ["149"],
                ou=[ant("Dans ta lumière, tu es Celui qui est, et moi, celle qui n’est pas !", f("04-29", 12))])],
            "repons": None},
        "vepres": {"hymnes": None, "psalmodie": [
            ant("Ma grâce te suffit, ma force se déploie dans ta faiblesse.", f("04-29", 13), ["30:20-25"],
                ou=[ant("Père, quel est le cœur qui n’éclaterait pas en voyant ta grandeur habiter notre humanité ?", f("04-29", 14, 15))]),
            ant("Bienheureux ceux qui cherchent la paix, bienheureux les cœurs purs, car ils verront Dieu !", f("04-29", 16), ["83", "NT11"])],
            "repons": None,
            "autres": [ant("Dépouille-nous, détache-nous de nous-mêmes, et revêts-nous de ton éternelle volonté !", f("04-29", 17)),
                       ant("Ouvre l’œil de notre intelligence, et nous te verrons face à face !", f("04-29", 18)),
                       ant("Offrez-moi la coupe de vos souffrances, et je l’emplirai de l’eau de ma grâce. Puisez vos larmes à la fontaine "
                           "de la charité : en y baignant le visage de l’Église, vous lui rendrez sa beauté.", f("04-29", 19)),
                       ant("Ô Christ, dans ton côté ouvert elle a trouvé refuge, rayonnant ta charité que ta grâce illumine.", f("04-29", 21))]},
        "_hymnes": [hy("Toi qui remontes des enfers", f("04-29", 1, 2, 3)), hy("Ô Dieu, ma joie", f("04-29", 4)),
                    hy("À son doigt", f("04-29", 5, 6, 8, 7))],
        "_repons": [hy("Répons 1 de sainte Catherine (versets 3 et 5)", f("04-29", 23, 24, 26, 27)),
                    hy("Répons 2 de sainte Catherine", f("04-29", 28, 30)), hy("Répons 3 de sainte Catherine", f("04-29", 31, 32, 33))],
    },
    "05-24": {
        "nom": "Translation de N. P. S. Dominique", "carnet": "Sanctoral (février-août)",
        "laudes": {"hymnes": None, "ferie": True, "psalmodie": [
            ant(BIENHEUREUX_SOIF[0], BIENHEUREUX_SOIF[1], None, sur="Psaume et cantique de l’Ancien Testament de la férie"),
            ant(GRAND_DESIR[0], GRAND_DESIR[1], None, sur="Psaume de la férie")],
            "repons": [DOMINIQUE_REPONS[0]]},
        "vepres": {"hymnes": None, "ferie": True, "psalmodie": [
            ant(O_CHRIST_SAUVEUR[0], O_CHRIST_SAUVEUR[1], None, sur="Psaume de la férie"),
            ant(SANS_SE_LASSER[0], SANS_SE_LASSER[1], None, sur="Psaume et cantique du Nouveau Testament de la férie")],
            "repons": [DOMINIQUE_REPONS[0]]},
        "_hymnes": [AU_SEIN, hy("Comme ils sont beaux", f("05-24", 3))],
    },
    "08-08": {
        "nom": "Notre Père saint Dominique", "carnet": "Sanctoral (février-août)",
        "vepres1": {"hymnes": None, "lucernaire": "ordo", "psalmodie": [
            ant(SERVITEUR[0], f("08-08", 7, 9), ["112"]),
            ant(BIENHEUREUX_SOIF[0], f("08-08", 11, 12), ["145", "NT11"])],
            "repons": DOMINIQUE_REPONS, "evangelique": O_LUMEN},
        "lectures": {"hymnes": None, "invitatoire": ant("Venez, adorons le Christ, ami des hommes : il a choisi Dominique pour annoncer "
                                                         "l’Évangile de miséricorde et de paix.", f("08-08", 13)),
                     "psalmodie": [ant(GRAND_DESIR[0], GRAND_DESIR[1], ["41"]), ant(SANS_SE_LASSER[0], SANS_SE_LASSER[1], ["76"]),
                                   ant(O_CHRIST_SAUVEUR[0], O_CHRIST_SAUVEUR[1], ["144:1-9"])],
                     "repons": DOMINIQUE_REPONS},
        "laudes": {"hymnes": None, "psalmodie": [
            ant(GRAND_DESIR[0], GRAND_DESIR[1], ["62", "AT49"]),
            ant("Méditant jour et nuit ta Parole, Seigneur, il a bâti sa maison sur le roc de ton amour.", f("08-08", 21, 22, 23), ["149"])],
            "repons": DOMINIQUE_REPONS},
        "vepres": {"hymnes": None, "lucernaire": "ordo", "psalmodie": [
            ant(SANS_SE_LASSER[0], SANS_SE_LASSER[1], ["115"]),
            ant(O_CHRIST_SAUVEUR[0], O_CHRIST_SAUVEUR[1], ["125", "NT6"])],
            "repons": DOMINIQUE_REPONS, "evangelique": O_LUMEN,
            "autres": [ant("De jour et de nuit, mon cri vers le Seigneur : « Que vont devenir les pécheurs ? » Que ta résurrection les illumine.", f("08-08", 27, 28)),
                       ant("La tendresse de Dieu irrigue la terre ; l’Évangile de la paix transfigure l’univers.", f("08-08", 29, 31))]},
        "_hymnes": DOMINIQUE_HYMNES,
    },
    "08-28": {
        "nom": "Saint Augustin, évêque et docteur", "carnet": "Sanctoral (février-août)",
        "laudes": {"hymnes": None, "psalmodie": [
            ant("Mon âme a soif du Dieu de vie : quand le verrai-je face à face ?", f("08-28", 3), ["62", "AT49"]),
            ant("Seigneur, en toi est la source de la vie : tu nous abreuves au torrent de tes délices !", f("08-28", 4), ["149"])],
            "repons": "ordo:02-14"},
        "vepres": {"hymnes": None, "psalmodie": [
            ant("Ma grâce te suffit, ma force se déploie dans ta faiblesse.", f("08-28", 5), ["14"]),
            ant(SERVITEUR[0], SERVITEUR[1], ["111", "NT13"])],
            "repons": "ordo:02-14"},
        "_hymnes": [hy("Tu es la source vive (saint Augustin)", f("08-28", 2)), AU_SEIN],
    },
}


def depuis_ordo(ordo, cle, off, role, titre):
    """Pièces déjà découpées dans les PDF des carnets (partitions/ordo.json) : lucernaire festif, répons d'une autre fête."""
    e = ordo.get(cle, {}).get("offices", {})
    o = e.get(off) or e.get("laudes") or {}
    fs = [x for p in o.get("pieces", []) if p["role"] == role for x in p["f"]]
    return [{"titre": titre, "f": list(dict.fromkeys(fs))}] if fs else []


def main():
    ordo = json.loads((RACINE / "partitions" / "ordo.json").read_text(encoding="utf-8"))
    out = {}
    for cle, e in FETES.items():
        d = {"nom": e["nom"], "carnet": e["carnet"], "offices": {}}
        for off in ("vepres1", "lectures", "laudes", "vepres"):
            o = e.get(off)
            if not o: continue
            o = dict(o)
            if o.get("hymnes") is None: o["hymnes"] = e.get("_hymnes", [])
            if o.get("repons") is None: o["repons"] = e.get("_repons", [])
            if o.get("lucernaire") == "ordo": o["lucernaire"] = depuis_ordo(ordo, cle, off, "lucernaire", "Lucernaire festif")
            if isinstance(o.get("repons"), str) and o["repons"].startswith("ordo:"):
                o["repons"] = depuis_ordo(ordo, o["repons"][5:], off, "repons", "Répons (renvoi du carnet : p. 8)")
            d["offices"][off] = o
        out[cle] = d
    SORTIE.write_text(json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    # contrôle : toutes les images existent
    manque = [x for v in out.values() for o in v["offices"].values() for x in json.dumps(o, ensure_ascii=False).split('"') if x.startswith("op/") and not (RACINE / "partitions" / x).exists()]
    print(f"{SORTIE.relative_to(RACINE)} : {len(out)} fêtes, {sum(len(v['offices']) for v in out.values())} offices ; images absentes : {manque or 'aucune'}")


if __name__ == "__main__":
    main()
