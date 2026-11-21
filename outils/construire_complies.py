"""Complies selon le livret « Liturgie des Heures — Complies », Propre de l'Ordre des Prêcheurs,
Bordeaux 2009 (sources_gouzes/Completorium Bx.pdf) → site/donnees/complies.json

Textes relevés dans le livret ; les partitions sont les pièces découpées par
outils/decouper_partitions.py (partitions/complies/s-PPP-N.jpg, PPP = page du PDF).

    python3 outils/construire_complies.py
"""
import json
from pathlib import Path

P = lambda *f: [f"complies/{x}.jpg" for x in f]

TE_LUCIS = [
    ["Avant la fin de la lumière,", "nous te prions, Dieu créateur,", "pour que, fidèle à ta bonté,", "tu nous protèges, tu nous gardes."],
    ["Que loin de nous s’enfuient les songes,", "et les angoisses de la nuit ;", "préserve-nous de l’ennemi,", "que ton amour sans fin nous garde."],
]
TE_LUCIS_DOX = ["Exauce-nous, Dieu, notre Père,", "par Jésus Christ, notre Seigneur,", "dans l’unité du Saint-Esprit,", "régnant sans fin dans tous les siècles. Amen."]
DOX_NOEL = ["Gloire à toi, Seigneur, Fils Unique,", "Jésus qui es né de la Vierge,", "avec le Père et l’Esprit-Saint", "pour tous les siècles éternels. Amen."]
DOX_EPIPHANIE = ["Gloire à toi, Seigneur, Fils Unique,", "qui es apparu aujourd’hui,", "avec le Père et l’Esprit-Saint", "pour tous les siècles éternels. Amen."]
MARIE = ["Marie, Mère de toute grâce,", "Mère de la miséricorde,", "protège-nous de l’ennemi", "accueille-nous à notre mort."]

IESU = [
    ["Ô Jésus, notre rédempteur,", "amour qui comble nos désirs,", "Dieu créateur de l’univers,", "Verbe fait chair aux derniers temps."],
    ["Quel amour a pu te pousser", "à te charger de nos péchés", "innocent, à subir la mort", "pour nous arracher à la mort."],
    ["Des enfers tu forces les portes,", "des captifs tu brises les chaînes ;", "vainqueur par un noble triomphe,", "tu sièges à la droite du Père."],
    ["Que ton indulgence t’entraîne", "à réparer tous nos malheurs,", "à nous placer devant ta face", "dans ta lumière bienheureuse."],
]
IESU_FIN = {
    "paques": [["Ô Créateur, nous te prions", "dans la joie des fêtes pascales,", "que ton peuple soit défendu", "de l’ennemi qui le menace."],
               ["Gloire à toi, Seigneur Jésus Christ,", "ressuscité d’entre les morts,", "avec le Père et dans l’Esprit,", "aux trois la même adoration.", "Amen. Alléluia."]],
    "ascension": [["Seigneur Jésus, sois notre joie,", "toi qui seras notre bonheur ;", "que notre gloire soit en toi", "à travers les siècles sans fin."],
                  ["Gloire à toi, Seigneur Jésus-Christ,", "qui montes au-dessus des étoiles,", "avec le Père et l’Esprit-Saint", "pour tous les siècles éternels. Amen."]],
    "pentecote": [["Auparavant tu as rempli", "les cœurs sanctifiés par ta grâce,", "pardonne en ce jour nos péchés,", "donne la paix à notre temps."],
                  ["Gloire au Père et au Fils Unique,", "ainsi qu’à l’Esprit Paraclet,", "que le Fils envoie à son peuple", "l’onction céleste du Saint-Esprit. Amen."]],
}
# Hymne du Carême, transcrite de la partition (p. 9 du livret)
O_CHRIST = [
    ["Ô Christ, tu es la lumière et le jour,", "chasse en la nuit toute ténèbre ;", "Lumière engendrée de la lumière,", "annonçant la lumière sans déclin."],
    ["Nous te prions, Seigneur de sainteté,", "protège-nous en cette nuit ;", "qu’en toi nous trouvions notre paix", "et notre nuit sera paisible."],
    ["Qu’un lourd sommeil ne tombe pas sur nous,", "que l’ennemi ne nous surprenne ;", "libère nos corps de tous péchés,", "qu’ils ne soient pas coupables devant toi."],
    ["Que nos yeux goûtent un sommeil paisible,", "que notre cœur veille toujours ;", "et que ta droite nous protège", "et nous garde à jamais en ton amour."],
    ["Viens et regarde, toi le défenseur,", "repousse au loin notre ennemi ;", "dirige et conduis tes serviteurs,", "que tu as rachetés par ton sang."],
    ["Garde mémoire, Seigneur, de tes enfants,", "chargés du poids de leur péché ;", "toi le défenseur de notre âme,", "aide-nous, Seigneur, dans le combat."],
    ["Fais-nous ce don, toi le Père tout-puissant,", "par Jésus Christ notre Seigneur,", "qui vit pour les siècles éternels", "et règne avec l’Esprit de sainteté. Amen."],
]
AUTRES_HYMNES = [
    {"titre": "En toi, Seigneur, nos vies reposent", "strophes": [
        ["En toi, Seigneur, nos vies reposent", "et prennent force dans la nuit ;", "tu nous prépares à ton aurore", "et tu nous gardes dans l’Esprit."],
        ["Déjà levé sur d’autres terres,", "le jour éveille les cités,", "ami des hommes vois leur peine", "et donne-leur la joie d’aimer."],
        ["Vainqueur du mal et des ténèbres,", "ô Fils de Dieu ressuscité,", "délivre-nous de l’adversaire", "et conduis-nous vers ta clarté. Amen."]]},
    {"titre": "L’heure s’avance : fais-nous grâce", "strophes": [
        ["L’heure s’avance : fais-nous grâce,", "toi dont le jour n’a pas de fin ;", "reste avec nous quand tout s’efface,", "Dieu des lumières sans déclin."],
        ["Tu sais toi-même où sont nos peines :", "porte au Royaume nos travaux ;", "sans toi, notre œuvre serait vaine,", "viens préparer les temps nouveaux."],
        ["Comme un veilleur attend l’aurore", "nous appelons le jour promis ;", "mais si la nuit demeure encore,", "tiens-nous déjà pour tes amis."],
        ["Dieu qui sans cesse nous enfantes,", "à toi ces derniers mots du jour ;", "l’Esprit du Christ en nous les chante", "et les confie à ton amour. Amen."]]},
]

C = {
    "source": "Liturgie des Heures — Complies, Propre de l’Ordre des Prêcheurs, Bordeaux 2009",
    "introduction": {
        "texte": ["V/ Dieu, viens à mon aide.", "R/ Seigneur, à notre secours.",
                  "Gloire au Père, et au Fils, et au Saint Esprit, au Dieu qui est, qui était, et qui vient, pour les siècles des siècles. Amen. Alléluia."],
        "rubrique": "En Carême, on omet l’alléluia.",
        "partition": P("s-004-1"),
        "penitence": {
            "rubrique": "Bref examen de conscience à genoux.",
            "confiteor": ["Je confesse à Dieu tout-puissant,", "à la bienheureuse Marie toujours vierge,", "à notre Père saint Dominique", "à tous les saints et à vous, mes frères,",
                          "que j’ai beaucoup péché", "par pensée, par parole, par action et par omission.", "C’est ma faute. Je vous demande de prier pour moi."],
            "absolution": ["Que Dieu tout-puissant nous fasse miséricorde,", "qu’il nous pardonne nos péchés, nous délivre de tout mal,",
                           "qu’il nous garde et nous affermisse dans le bien", "et qu’il nous conduise à la vie éternelle.", "R/ Amen."],
        },
    },
    # hymnes : texte français ; partitions grégoriennes selon le temps
    "hymnes": {
        "to-ferie": {"titre": "Te lucis ante terminum", "strophes": TE_LUCIS + [TE_LUCIS_DOX], "partition": P("s-006-1"), "note": "Féries de l’Avent et du temps ordinaire"},
        "to-samedi": {"titre": "Te lucis ante terminum", "strophes": TE_LUCIS + [TE_LUCIS_DOX], "partition": P("s-006-2", "s-007-1"), "note": "Samedis du temps ordinaire"},
        "to-dimanche": {"titre": "Te lucis ante terminum", "strophes": TE_LUCIS + [TE_LUCIS_DOX], "partition": P("s-007-2"), "note": "Dimanches du temps ordinaire"},
        "avent-dimanche": {"titre": "Te lucis ante terminum", "strophes": TE_LUCIS + [TE_LUCIS_DOX], "partition": P("s-009-1"), "note": "Dimanches de l’Avent"},
        "noel": {"titre": "Te lucis ante terminum", "strophes": TE_LUCIS + [DOX_NOEL], "partition": P("s-010-1", "s-010-2"), "note": "Temps de Noël, avant l’Épiphanie"},
        "noel-epiphanie": {"titre": "Te lucis ante terminum", "strophes": TE_LUCIS + [DOX_EPIPHANIE], "partition": P("s-010-1", "s-010-3"), "note": "Temps de Noël, après l’Épiphanie"},
        "careme": {"titre": "Ô Christ, tu es la lumière et le jour", "strophes": O_CHRIST, "partition": P("s-011-1"),
                   "gregorien": {"titre": "Christe qui lux es et dies", "partition": P("s-012-1", "s-013-1")}},
        "paques": {"titre": "Iesu nostra redemptio", "strophes": IESU + IESU_FIN["paques"], "partition": P("s-016-1", "s-017-1"), "note": "Jusqu’à l’Ascension"},
        "ascension": {"titre": "Iesu nostra redemptio", "strophes": IESU + IESU_FIN["ascension"], "partition": P("s-016-1", "s-017-2"), "note": "Entre l’Ascension et la Pentecôte"},
        "pentecote": {"titre": "Iesu nostra redemptio", "strophes": IESU + IESU_FIN["pentecote"], "partition": P("s-016-1", "s-018-1"), "note": "À la Pentecôte"},
        "marie": {"titre": "Te lucis ante terminum", "strophes": TE_LUCIS + [MARIE, DOX_NOEL], "partition": P("s-019-1"), "note": "Fêtes et solennités de la Vierge Marie"},
        "marie-careme": {"partition": P("s-013-2"), "note": "Strophe mariale avant la doxologie (Carême)"},
        "marie-paques": {"partition": P("s-018-2"), "note": "Strophe mariale avant la doxologie (temps pascal)"},
        "autres": AUTRES_HYMNES,
    },
    # psaumes du jour (numérotation grecque) et lecture brève
    "jours": {
        "samedi": {"titre": "Samedi et la veille des solennités", "psaumes": [{"id": "4"}, {"id": "133"}], "lecture": "Dt 6, 4-8a", "lecture_texte": "Écoute, Israël : le Seigneur notre Dieu est l’Unique. Tu aimeras le Seigneur ton Dieu de tout ton cœur, de toute ton âme et de toute ta force. Ces commandements que je te donne aujourd’hui resteront gravés dans ton cœur. Tu les rediras à tes fils, tu les répéteras sans cesse, à la maison ou en voyage, que tu sois couché ou que tu sois levé."},
        "dimanche": {"titre": "Dimanche et le soir des solennités", "psaumes": [{"id": "90"}], "lecture": "Ap 22, 4-5", "lecture_texte": "Les serviteurs de Dieu verront son visage, et son nom sera écrit sur leur front. La nuit n’existera plus, ils n’auront plus besoin de la lumière d’une lampe ni de la lumière du soleil, parce que le Seigneur Dieu les illuminera, et ils régneront pour les siècles des siècles."},
        "lundi": {"psaumes": [{"id": "85"}], "lecture": "1 Th 5, 9b-10", "lecture_texte": "Dieu nous a destinés à entrer en possession du salut par notre Seigneur Jésus Christ, mort pour nous afin de nous faire vivre avec lui, que nous soyons encore éveillés ou déjà endormis dans la mort."},
        "mardi": {"psaumes": [{"id": "142"}], "lecture": "1 P 5, 8-9a", "lecture_texte": "Soyez sobres, soyez vigilants : votre adversaire, le démon, comme un lion qui rugit, va et vient, à la recherche de sa proie. Résistez-lui avec la force de la foi."},
        "mercredi": {"psaumes": [{"id": "30", "versets": "2-9"}, {"id": "129"}], "lecture": "Ep 4, 30.32", "lecture_texte": "En vue de votre délivrance, vous avez reçu en vous la marque du Saint-Esprit de Dieu : ne le contristez pas. Soyez entre vous pleins de générosité et de tendresse. Pardonnez-vous les uns aux autres, comme Dieu vous a pardonné dans le Christ."},
        "jeudi": {"psaumes": [{"id": "15"}], "lecture": "1 Th 5, 23", "lecture_texte": "Que le Dieu de la paix lui-même vous sanctifie tout entiers, et qu’il garde parfaits et sans reproche votre esprit, votre âme et votre corps, pour la venue de notre Seigneur Jésus Christ."},
        "vendredi": {"psaumes": [{"id": "87"}], "lecture": "Cf. Jr 14, 7a.9b", "lecture_texte": "Si nos fautes parlent contre nous, agis, Seigneur, pour l’honneur de ton nom ! Tu es au milieu de nous, et ton nom a été invoqué sur nous ; ne nous abandonne pas, Seigneur, notre Dieu."},
    },
    "repons": {
        "to": {"texte": ["R/ En tes mains, Seigneur, je remets mon esprit. * En tes mains.", "V/ C’est toi qui nous rachètes, Seigneur, Dieu de vérité. * En tes mains.",
                         "Gloire au Père, et au Fils, et au Saint Esprit. * En tes mains."], "partition": P("s-030-1")},
        "noel": {"texte": ["R/ En tes mains, Seigneur, je remets mon esprit. * Alléluia, alléluia.", "V/ C’est toi qui nous rachètes, Seigneur, Dieu de vérité. * Alléluia, alléluia.",
                           "Gloire au Père, et au Fils, et au Saint Esprit. * En tes mains."], "partition": P("s-032-1")},
        "careme": {"texte": ["R/ En paix je me couche, aussitôt je m’endors et me repose.", "V/ J’accorde le sommeil à mes yeux et le repos à mes paupières."], "partition": P("s-033-2")},
        "media-vita": {"rubrique": "Spécialement les samedis, les dimanches, aux solennités, aux fêtes et aux jours de la Semaine sainte",
                       "texte": ["R/ Au plein midi de notre vie, voici la mort. Auprès de qui chercher secours sinon auprès de toi, Seigneur, toi dont pourtant nos péchés provoquent justement le courroux. * Ô trois fois Saint ! Dieu Saint, Saint Fort, Saint et miséricordieux Sauveur, ne nous livre pas aux angoisses de la mort.",
                                 "V/ Au temps de notre vieillesse ne nous rejette pas ; quand nos forces seront défaillantes, ne nous abandonne pas, Seigneur."], "partition": P("s-034-1")},
        "triduum": {"rubrique": "À la place du répons bref on chante le verset :", "texte": ["Le Christ s’est fait pour nous obéissant jusqu’à la mort, et la mort de la croix."], "partition": P("s-037-1")},
        "octave-paques": {"rubrique": "Le dimanche de la Résurrection et durant l’octave, à la place du répons bref on chante le verset :",
                          "texte": ["Voici le jour que le Seigneur a fait : vivons-le dans la joie et l’allégresse, alléluia."], "partition": P("s-037-2")},
        "paques": {"texte": ["R/ En tes mains, Seigneur, je remets mon esprit. * Alléluia, alléluia.", "V/ C’est toi qui nous rachètes, Seigneur, Dieu de vérité. * Alléluia, alléluia.",
                             "Gloire au Père, et au Fils, et au Saint Esprit. * En tes mains."], "partition": P("s-038-1")},
    },
    # antiennes du cantique de Syméon (latin, traduction) et ton du cantique
    "antiennes": {
        "to": {"latin": "Salva nos, Domine, vigilantes, custodi nos dormientes : ut vigilemus cum Christo, et requiescamus in pace.",
               "texte": "Sauve-nous, Seigneur, quand nous veillons ; garde-nous Seigneur, quand nous dormons, et nous veillerons avec le Christ, et nous reposerons en paix.",
               "partition": P("s-030-2"), "ton": P("s-031-1")},
        "noel": {"latin": "Alleluia. Verbum caro factum est, alleluia : et habitavit in nobis, alleluia, alleluia.",
                 "texte": "Alléluia, le Verbe s’est fait chair, alléluia : et il demeuré parmi nous, alléluia.", "partition": P("s-032-2"), "ton": P("s-033-1")},
        "noel-epiphanie": {"latin": "Alleluia. Omnes de Saba venient, alleluia : aurum et tus deferentes, alleluia, alleluia.",
                           "texte": "Alléluia. Tous ceux de Saba viendront, alléluia : portant l’or et l’encens, alléluia.", "partition": P("s-032-3"), "ton": P("s-033-1")},
        "careme": {"latin": "Evigila super nos, æterne Salvator, ne nos apprehendat callidus tentator : quia tu factus es nobis sempiternus adiutor.",
                   "texte": "Veille sur nous, Sauveur éternel, afin que nous échappions aux ruses du tentateur. Pour toujours, tu es notre aide.",
                   "partition": P("s-035-1"), "ton": P("s-035-2")},
        "careme-3": {"latin": "O Rex gloriose inter sanctos tuos, qui semper es laudabilis et tamen ineffabilis : tu in nobis es, Domine, et nomen sanctum tuum invocatum est super nos : ne derelinquas nos, Deus noster : ut in die iudicii nos collocare digneris inter sanctos et electos tuos, Rex benedicte.",
                     "texte": "Ô Roi glorieux dans l’assemblée des saints, digne de toute louange et pourtant ineffable ; tu es en nous, Seigneur, et ton saint nom a été invoqué sur nous : ne nous abandonne pas, Seigneur notre Dieu. Au jour du jugement, daigne nous recevoir parmi les saints et les élus : ô Roi béni.",
                     "partition": P("s-036-1"), "ton": []},
        "paques": {"latin": "Alleluia. Resurrexit Dominus, alleluia : sicut dixit vobis, alleluia, alleluia.",
                   "texte": "Alléluia, le Seigneur est ressuscité, alléluia, comme il vous l’avait dit, alléluia.", "partition": P("s-038-2"), "ton": P("s-039-3")},
        "ascension": {"latin": "Alleluia. Ascendens Christus in altum, alleluia : captivam duxit captivitatem, alleluia, alleluia.",
                      "texte": "Alléluia, le Christ est monté au ciel, alléluia, il a asservi la servitude, alléluia.", "partition": P("s-039-1"), "ton": P("s-039-3")},
        "pentecote": {"latin": "Alleluia. Spiritus Paraclitus, alleluia : docebit vos omnia, alleluia, alleluia.",
                      "texte": "Alléluia, l’Esprit de vérité, alléluia, vous enseignera toutes choses, alléluia.", "partition": P("s-039-2"), "ton": P("s-039-3")},
        "presentation": {"latin": "Nunc dimittis, Domine, servum tuum in pace, quia viderunt oculi mei salutare tuum.",
                         "texte": "Maintenant, ô Maître souverain, tu peux laisser ton serviteur s’en aller en paix, car mes yeux ont vu ton salut.", "partition": P("s-040-1"), "ton": P("s-040-2")},
        "annonciation": {"latin": "Ecce ancilla Domini : fiat mihi secundum verbum tuum. (T. P. alleluia.)",
                         "texte": "Voici la servante du Seigneur : qu’il me soit fait selon ta parole.", "partition": P("s-041-1"), "ton": P("s-041-2")},
        "saint-sacrement": {"latin": "Alleluia. Panis quem ego dedero, alleluia : caro mea est pro mundi vita, alleluia, alleluia.",
                            "texte": "Alléluia, le pain que je donnerai, alléluia, c’est ma chair pour la vie du monde, alléluia.", "partition": P("s-042-1"), "ton": P("s-042-3")},
        "sacre-coeur": {"latin": "Alleluia. Haurietis in gaudio, alleluia : de fontibus Salvatoris, alleluia, alleluia.",
                        "texte": "Alléluia, exultant de joie, vous puiserez aux sources du salut, alléluia.", "partition": P("s-042-2"), "ton": P("s-042-3")},
        "marie": {"latin": "Sub tuum præsidium confugimus, sancta Dei Genitrix : nostras deprecationes ne despicias in necessitatibus, sed a periculis cunctis libera nos semper, Virgo benedicta. (T. P. alleluia.)",
                  "texte": "Sous l’abri de ta miséricorde, nous nous réfugions, sainte Mère de Dieu. Ne méprise pas nos prières quand nous sommes dans l’épreuve, mais de tous les dangers délivre-nous toujours, Vierge bienheureuse.",
                  "partition": P("s-043-1"), "ton": P("s-043-2")},
    },
    "priere": {
        "oraison": "Visite cette maison, Seigneur, et repousse loin d’elle toutes les embûches de l’ennemi ; que tes saints anges viennent l’habiter pour nous garder dans la paix et que ta bénédiction demeure sur nous à jamais. Par Jésus, le Christ, notre Seigneur. R/ Amen.",
        "benediction": "Que le Seigneur nous bénisse, qu’il nous accorde une nuit tranquille et nous garde dans la paix. R/ Amen.",
        "partition_oraison": P("s-044-1"), "partition_benediction": P("s-044-2"),
        # ou bien, selon l'usage romain
        "jours": {
            "veille-solennite": ["Dieu du ciel et de la terre, nous levons les mains vers toi pour te bénir, car tu nous as bénis en ton Fils bien-aimé. Dans la nuit que tu nous donnes pour unir notre prière à la sienne, nous te supplions de nous bénir encore. Par Jésus le Christ, notre Seigneur. R/ Amen.",
                                 "Que le Seigneur nous bénisse, qu’il nous accorde une nuit tranquille et nous garde dans la paix. R/ Amen."],
            "soir-solennite": ["Nous t’en supplions, Seigneur, visite cette maison, repousse loin d’elle toutes les embûches de l’ennemi ; que tes saints anges viennent l’habiter pour nous garder dans la paix, et que ta bénédiction demeure à jamais sur nous. Par Jésus, le Christ, notre Seigneur. R/ Amen.",
                               "Que le Seigneur nous bénisse et nous garde, le Père, le Fils, et le Saint-Esprit. R/ Amen."],
            "samedi": ["Dieu éternel, tu as écouté la prière de ton Christ, et tu l’as délivré de la mort ; ne permets pas que nos cœurs se troublent, rassure-nous dans notre nuit, comble-nous de ta joie, et nous attendrons dans le silence et la paix que se lève sur nous la lumière de la Résurrection. Par Jésus, le Christ, notre Seigneur. R/ Amen.",
                       "Que le Seigneur nous bénisse, qu’il nous accorde une nuit tranquille et nous garde dans la paix. R/ Amen."],
            "dimanche": ["Notre Seigneur et notre Dieu, tu nous as fait entendre ton amour au matin de la Résurrection ; quand viendra pour nous le moment de mourir, que ton souffle de vie nous conduise en ta présence. Par Jésus, le Christ, notre Seigneur. R/ Amen.",
                         "Ou bien : Seigneur Dieu, notre Maître souverain, tu as illuminé nos yeux par la lumière de ton Verbe éternel ; alors qu’il fait nuit maintenant, garde nos âmes dans ta paix, et quand notre vie s’éteindra, laisse-nous aller dans ton paradis avec ton Fils, Jésus Christ, notre Seigneur. R/ Amen.",
                         "Que le Seigneur nous bénisse et nous garde, le Père, le Fils, et le Saint-Esprit. R/ Amen."],
            "lundi": ["Seigneur, tandis que nous dormirons en paix, fais germer et grandir jusqu’à la moisson la semence du Royaume des cieux que nous avons jetée en terre par le travail de cette journée. Par Jésus, le Christ, notre Seigneur. R/ Amen.",
                      "Que le Seigneur fasse resplendir sur nous son visage et nous accorde sa grâce. R/ Amen."],
            "mardi": ["Dieu qui es fidèle et juste, réponds à ton Église en prière, comme tu as répondu à Jésus, ton serviteur. Quand le souffle en elle s’épuise, fais-la vivre du souffle de ton Esprit : qu’elle médite sur l’œuvre de tes mains, pour avancer, libre et confiante, vers le matin de sa Pâque. Par Jésus, le Christ, notre Seigneur. R/ Amen.",
                      "Que le Seigneur tourne vers nous son visage et nous apporte la paix. R/ Amen."],
            "mercredi": ["Seigneur Jésus Christ dont le joug est facile et le fardeau léger, nous venons remettre en tes mains le fardeau de ce jour, accorde-nous de trouver près de toi le repos. Toi qui règnes pour les siècles des siècles. R/ Amen.",
                         "Que Dieu, dans sa toute-puissance, éloigne de nous le mal, et nous tienne en sa bénédiction. R/ Amen."],
            "jeudi": ["Seigneur, notre part d’héritage, donne-nous de ne chercher qu’en toi notre bonheur et d’attendre avec confiance, au-delà de la nuit de notre mort, la joie de vivre en ta présence. Par Jésus le Christ, notre Seigneur. R/ Amen.",
                      "Que la paix de Dieu garde notre cœur et nos pensées dans le Christ Jésus, notre Seigneur. R/ Amen."],
            "vendredi": ["Seigneur notre Dieu, que la splendeur de la Résurrection nous illumine, pour que nous puissions échapper à l’ombre de la mort et parvenir à la lumière éternelle dans ton Royaume. Par Jésus, le Christ, notre Seigneur. R/ Amen.",
                         "Que le Seigneur qui nous a sauvés par sa croix soit pour nous la résurrection et la vie. R/ Amen."],
        },
    },
    "procession": [
        {"titre": "Salve Regina", "latin": "Salve, Regina, Mater misericordiæ, vita, dulcedo et spes nostra, salve. Ad te clamamus exsules filii Hevæ. Ad te suspiramus gementes et flentes in hac lacrimarum valle. Eia ergo, advocata nostra, illos tuos misericordes oculos ad nos converte. Et Iesum, benedictum fructum ventris tui, nobis post hoc exsilium ostende. O clemens, o pia, o dulcis Virgo Maria. (T. P. Alleluia.)",
         "suite": ["V/ Daigne recevoir mes louanges, ô Vierge sainte (T. P. alléluia).", "R/ Rends-moi fort contre tes ennemis (T. P. alléluia).",
                   "Prions. Accorde à tes serviteurs, Dieu très bon, de posséder la santé de l’âme et du corps, et par la glorieuse intercession de la sainte Vierge Marie, d’être libérés des tristesses de ce monde, et de goûter les joies de l’éternité. Par Jésus, le Christ, notre Seigneur. R/ Amen."],
         "partition": P("s-048-1")},
        {"titre": "O Lumen", "latin": "O lumen Ecclesiæ, doctor veritatis, rosa patientiæ, ebur castitatis, aquam sapientiæ propinasti gratis : prædicator gratiæ, nos iunge beatis. (T. P. Alleluia.)",
         "suite": ["V/ Notre Père saint Dominique, prie pour nous (T. P. alléluia).", "R/ Afin que nous devenions dignes des promesses du Christ (T. P. alléluia).",
                   "Prions. Nous t’en prions, Dieu tout-puissant, tandis que nos péchés nous oppressent, fais que protégés par notre Père saint Dominique, nous reprenions courage. Par Jésus, le Christ, notre Seigneur. R/ Amen."],
         "partition": P("s-049-1")},
        {"titre": "O spem miram", "latin": "O spem miram quam dedisti mortis hora te flentibus, dum post mortem promisisti te profuturum fratribus. Imple, Pater, quod dixisti, nos tuis iuvans precibus. (T. P. Alleluia.) Qui tot signis claruisti in ægrorum corporibus, nobis opem ferens Christi, ægris medere moribus. Imple. Gloria Patri, et Filio, et Spiritui Sancto. Imple.",
         "suite": ["V/ Notre Père saint Dominique, prie pour nous (T. P. alléluia).", "R/ Afin que nous devenions dignes des promesses du Christ (T. P. alléluia).",
                   "Prions. Tu as voulu, Seigneur, éclairer ton Église par les mérites et les enseignements de saint Dominique notre Père ; permets qu’à sa prière, elle ne manque jamais de tes secours ici-bas, et poursuive sa croissance éternelle. Par Jésus, le Christ, notre Seigneur. R/ Amen."],
         "partition": P("s-050-1")},
        {"titre": "Antiennes à notre Père saint Dominique — Pie Pater", "latin": "Pie Pater Dominice, tuorum memor operum, sta coram summo Iudice pro tuo cœtu pauperum. (T. P. Alleluia.)",
         "suite": ["Juste père Dominique, souviens-toi de ton œuvre ; intercède devant le Juge suprême pour les pauvres que tu as rassemblés."], "partition": P("s-051-1")},
        {"titre": "Magne Pater", "latin": "Magne Pater sancte Dominice, mortis hora nos tecum suscipe, et hic semper nos pie respice. (T. P. Alleluia.)",
         "suite": ["Magnifique Père saint Dominique, accueille-nous chez toi à l’heure de la mort et prends toujours soin de nous avec dévouement."], "partition": P("s-051-2")},
        {"titre": "Benedictus Redemptor", "latin": "Benedictus Redemptor omnium, qui saluti providens hominum, mundo dedit sanctum Dominicum.",
         "suite": ["Béni soit le Rédempteur de tous, qui a donné saint Dominique au monde pour procurer le salut aux hommes."], "partition": P("s-052-1")},
    ],
}

if __name__ == "__main__":
    out = Path(__file__).resolve().parent.parent / "site" / "donnees" / "complies.json"
    out.write_text(json.dumps(C, ensure_ascii=False, indent=0), encoding="utf-8")
    print("complies →", out)
