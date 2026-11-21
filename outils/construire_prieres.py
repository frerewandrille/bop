#!/usr/bin/env python3
"""Prières et formules du Compendium du Catéchisme de l'Église catholique → site/donnees/prieres.json

Source : sources_compendium/compendium-fr.html (vatican.va, archive_2005_compendium-ccc_fr.html,
téléchargé le 18/11/2026) : appendice A (prières communes, français et latin), appendice B (formules),
Credo (début de la 1re partie) et Notre Père (4e partie), Dix commandements (formule catéchétique).
Latin des Béatitudes, de la règle d'or et des deux commandements : Nova Vulgata (bible/data, champ lat.NVU),
le Compendium ne les donnant qu'en français.

Le texte est pris tel quel ; seules corrections : accents latins détachés (« sæ´cula » → « sǽcula »),
espaces en trop. L'ordre et le regroupement sont ceux de la page « Prières » (voir GROUPES).
"""
import html, json, re
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
SRC = RACINE / "sources_compendium" / "compendium-fr.html"
SORTIE = RACINE / "site" / "donnees" / "prieres.json"
BIBLE = RACINE / "bible" / "data"


def lat(s):
    s = re.sub(r"æ´\s*", "ǽ", s); s = re.sub(r"Æ´\s*", "Ǽ", s)
    return s


def nettoie(l):
    return re.sub(r"\s+", " ", lat(l)).strip()


def paragraphes(seg):
    """<p> d'un passage → [(gras, [lignes])]."""
    out = []
    for p in re.findall(r"<p[^>]*>(.*?)</p>", seg, re.S):
        gras = bool(re.match(r"\s*(<span[^>]*>)?\s*(<font[^>]*>)?\s*<b>", p))
        t = re.sub(r"<br ?/?>", "\n", p)
        t = html.unescape(re.sub(r"<[^>]+>", "", t))
        lignes = [nettoie(x) for x in t.split("\n")]
        lignes = [x for x in lignes if x]
        if lignes: out.append((gras, lignes))
    return out


def sections(paras):
    """Titres en gras → {titre: [[paragraphes], ...occurrences]}."""
    res, cur = [], None
    for gras, lignes in paras:
        if gras:
            cur = [" ".join(lignes), []]; res.append(cur)
        elif cur:
            cur[1].append(lignes)
    return res


def vers(lignes):
    """Paragraphe latin sans retours à la ligne (Veni Sancte) : un vers par majuscule après ponctuation."""
    if len(lignes) > 1: return lignes
    return re.split(r"(?<=[,.;:!?])\s+(?=[A-ZÁÉÍÓÚÆ])", lignes[0])


def nvu(livre, ch, v1, v2):
    s = (BIBLE / livre / f"{ch:03d}.js").read_text(encoding="utf-8")
    d = json.loads(s[s.index("{"):s.rindex("}") + 1])
    lv = d["lat"]["NVU"]
    return [re.sub(r"[“”]", "", lv[str(v)]).strip() for v in range(v1, v2 + 1)]


def main():
    s = SRC.read_text(encoding="iso-8859-1")

    # ── appendice
    i = s.find('<a name="APPENDICE">'); j = s.find("ABR", s.find("FORMULES DE LA DOCTRINE", i + 2000))
    app = sections(paragraphes(s[i:j]))
    occ = {}
    for titre, corps in app:
        occ.setdefault(titre, []).append(corps)
    A = lambda t, n=0: occ[t][n]

    # ── Credo et Notre Père
    k = s.find("Symbole des Ap", s.find("LE CREDO", 30000))
    credo = {t: c for t, c in sections(paragraphes(s[k - 300:k + 12000]))}
    k = [m.start() for m in re.finditer("LA PRI&Egrave;RE DU SEIGNEUR", s)][-1]
    pater = {t: c for t, c in sections(paragraphes(s[k:k + 4000]))}
    # Notre Père : une proposition par ligne, pour lire le français et le latin en regard
    coupe = lambda t, debuts: [x.strip() for x in re.split(r"\s*(?=" + "|".join(debuts) + ")", re.sub(r",(?=\S)", ", ", t)) if x.strip()]
    pater_fr = coupe(pater["Notre Père"][0][0], ["que ton", "que ta", "Donne-nous", "pardonne-nous", "comme nous", "et ne nous", "mais délivre"])
    pater_la = coupe(re.sub(r"\.(?=\S)", ". ", pater["Pater Noster"][0][0]), ["sanctif", "advéniat", "fiat", "Panem", "et dimítte", "sicut et nos", "et ne nos", "sed líbera"])
    assert len(pater_fr) == len(pater_la) == 9, (pater_fr, pater_la)

    # ── Dix commandements : la formule catéchétique est mêlée aux textes de l'Exode et du Deutéronome
    #    dans la page (tableau à trois colonnes aplati) : on reprend ses dix phrases, dans l'ordre.
    k = s.find("Formule cat&eacute;ch&eacute;tique")
    bloc = html.unescape(re.sub(r"<[^>]+>", "", s[k:s.find("</p>", s.find("<p", k + 10))]))
    bloc = nettoie(bloc.replace("Formule catéchétique", ""))
    debut = re.match(r"(Un seul Dieu.*?parfaitement\.)\s*(Son saint nom.*?faux serment\.)", bloc)
    fin = bloc[bloc.index("Le jour du Seigneur garderas"):]
    dix = [debut.group(1), debut.group(2)] + [x.strip() for x in re.split(r"(?<=\.)\s+", fin) if x.strip()]
    assert len(dix) == 10, dix

    # ── formules (appendice B) depuis le texte, plus sûr pour les listes numérotées
    seg = s[s.find("FORMULES DE LA DOCTRINE", i + 2000):j]
    seg = re.sub(r"</?(i|b|span|font)\b[^>]*>", "", seg)              # balises de mise en forme : sans coupure
    txt = html.unescape(re.sub(r"<[^>]+>", "\n", re.sub(r"<br ?/?>", "\n", seg)))
    txt = [nettoie(x) for x in txt.split("\n") if nettoie(x)]

    def liste(titre_debut, suivant):
        a = next(n for n, x in enumerate(txt) if x.startswith(titre_debut))
        b = next(n for n, x in enumerate(txt) if n > a and x.startswith(suivant)) if suivant else len(txt)
        corps = " ".join(txt[a + 1:b])
        return [x.strip() for x in re.split(r"(?=(?<!\d)\d{1,2}\.\s)", corps) if x.strip()]

    beat = next(n for n, x in enumerate(txt) if x.startswith("Les Béatitudes"))
    beatitudes = [x.strip() for x in re.split(r"(?<=!)\s+", txt[beat + 1]) if x.strip()]
    regle = txt[next(n for n, x in enumerate(txt) if x.startswith("La règle d’or")) + 1]

    def piece(id, titre, fr, la=None, titre_la=None, **kw):
        p = {"id": id, "titre": titre, "fr": fr}
        if titre_la: p["titreLatin"] = titre_la
        if la: p["la"] = la
        p.update(kw)
        return p

    blocs = lambda paras: [list(x) for x in paras]
    def pr(id, titre, tfr, tla, titre_la, nfr=0, nla=0, **kw):
        return piece(id, titre, blocs(A(tfr, nfr)), [vers(x) for x in A(tla, nla)] if tla else None, titre_la, **kw)

    angelus = A("ANGELUS"); angelus_la = A("ANGELUS DOMINI")
    regina = A("REGINA CÆLI", 0); regina_la = A("REGINA CÆLI", 1)

    groupes = [
        {"id": "essentiel", "titre": "Les prières de chaque jour", "pieces": [
            pr("signe-de-croix", "Signe de la croix", "SIGNE DE LA CROIX", "SIGNUM CRUCIS", "Signum crucis"),
            piece("notre-pere", "Notre Père", [pater_fr], [pater_la], "Pater noster"),
            pr("je-vous-salue", "Je vous salue, Marie", "JE VOUS SALUE, MARIE", "AVE MARIA", "Ave Maria"),
            pr("gloire-au-pere", "Gloire au Père", "DOXOLOGIE", "GLORIA PATRI", "Gloria Patri"),
            piece("symbole-des-apotres", "Symbole des Apôtres", blocs(credo["Symbole des Apôtres"]),
                  blocs(credo["Symbolum Apostolicum"]), "Symbolum Apostolicum"),
            piece("credo-nicee", "Credo de Nicée-Constantinople", blocs(credo["Credo de Nicée-Constantinople"]),
                  blocs(credo["Symbolum Nicænum Constantinopolitanum"]), "Symbolum Nicænum Constantinopolitanum"),
        ]},
        {"id": "marie", "titre": "Avec la Vierge Marie", "pieces": [
            piece("angelus", "Angélus", blocs(angelus), blocs(angelus_la), "Angelus Domini", hors="paques",
                  note="Hors du temps pascal."),
            piece("regina-caeli", "Regina cæli", blocs(regina), blocs(regina_la), "Regina cæli", temps="paques",
                  note="Au temps pascal, à la place de l’Angélus."),
            pr("salve-regina", "Salve Regina", "SALVE REGINA", "SALVE, REGINA", "Salve, Regina"),
            pr("sub-tuum", "Sous l’abri de ta miséricorde", "SUB TUUM", "SUB TUUM", "Sub tuum præsidium", 0, 1),
            pr("souvenez-vous", "Souvenez-vous", "SOUVENEZ-VOUS", "MEMORARE", "Memorare"),
            piece("rosaire", "Le Rosaire", blocs(A("ROSAIRE")), blocs(A("ROSARIUM")), "Rosarium", rosaire=True),
            pr("magnificat", "Magnificat", "MAGNIFICAT", "MAGNIFICAT", "Magnificat", 0, 1, ref="Lc 1, 46-55"),
        ]},
        {"id": "christ-esprit", "titre": "Le Christ et l’Esprit Saint", "pieces": [
            pr("veni-creator", "Viens, Esprit Créateur", "VENI CREATOR", "VENI CREATOR SPIRITUS", "Veni, Creator Spiritus"),
            pr("veni-sancte", "Viens, Esprit Saint", "VENI, SANCTE SPIRITUS", "VENI, SANCTE SPIRITUS", "Veni, Sancte Spiritus", 0, 1,
               note="Séquence de la Pentecôte."),
            pr("ame-du-christ", "Âme du Christ", "ÂME DU CHRIST", "ANIMA CHRISTI", "Anima Christi"),
            pr("te-deum", "Te Deum", "TE DEUM", "TE DEUM", "Te Deum", 0, 1),
            pr("benedictus", "Benedictus", "BENEDICTUS", "BENEDICTUS", "Benedictus", 0, 1, ref="Lc 1, 68-79"),
        ]},
        {"id": "actes", "titre": "Actes et prières personnelles", "pieces": [
            pr("acte-de-foi", "Acte de foi", "ACTE DE FOI", "ACTUS FIDEI", "Actus fidei"),
            pr("acte-d-esperance", "Acte d’espérance", "ACTE D’ESPÉRANCE", "ACTUS SPEI", "Actus spei"),
            pr("acte-de-charite", "Acte de charité", "ACTE DE CHARITÉ", "ACTUS CARITATIS", "Actus caritatis"),
            pr("acte-de-contrition", "Acte de contrition", "ACTE DE CONTRITION", "ACTUS CONTRITIONIS", "Actus contritionis"),
            pr("ange-de-dieu", "Ange de Dieu", "ANGE DE DIEU", "ANGELE DEI", "Angele Dei"),
            pr("repos-eternel", "Le repos éternel (pour les défunts)", "LE REPOS ÉTERNEL", "REQUIEM ÆTERNAM", "Requiem æternam"),
        ]},
        {"id": "orient", "titre": "Prières des Églises d’Orient", "intro": "Le Compendium les donne en français seulement.", "pieces": [
            piece("encens", "Prière de l’encens", blocs(A("PRIÈRE DE L’ENCENS")), note=None),
            piece("adieu-autel", "Adieu à l’autel, avant de quitter l’église après la liturgie",
                  blocs(A("PRIÈRE DE « L’ADIEU À l’AUTEL » AVANT DE QUITTER L’ÉGLISE APRÈS LA LITURGIE"))),
            piece("defunts-byzantin", "Prière pour les défunts", blocs(A("PRIÈRE POUR LES DÉFUNTS"))),
        ]},
        {"id": "formules", "titre": "Formules de la doctrine catholique", "formules": True,
         "intro": "Le Compendium donne ces formules en français. Le latin de l’Écriture est celui de la Nova Vulgata.", "pieces": [
            piece("dix-commandements", "Les dix commandements", [dix], ref="Ex 20, 2-17 ; Dt 5, 6-21",
                  note="Formule catéchétique."),
            piece("deux-commandements", "Les deux commandements de la charité",
                  [liste("Les deux commandement", "La règle d’or")], [nvu("MAT", 22, 37, 39)], "Mt 22, 37-39",
                  ref="Mt 22, 37-39", laSource="Nova Vulgata"),
            piece("regle-d-or", "La règle d’or", [[regle]], [nvu("MAT", 7, 12, 12)], "Mt 7, 12", ref="Mt 7, 12", laSource="Nova Vulgata"),
            piece("beatitudes", "Les Béatitudes", [beatitudes], [nvu("MAT", 5, 3, 12)], "Mt 5, 3-12", ref="Mt 5, 3-12", laSource="Nova Vulgata"),
            piece("preceptes", "Les cinq préceptes de l’Église", [liste("Les cinq préceptes", "Les sept œuvres de miséricorde corporelle")]),
            piece("vertus-theologales", "Les trois vertus théologales", [liste("Les trois vertus", "Les quatre vertus")]),
            piece("vertus-cardinales", "Les quatre vertus cardinales", [liste("Les quatre vertus", "Le sept dons")]),
            piece("dons", "Les sept dons du Saint-Esprit", [liste("Le sept dons", "Les douze fruits")]),
            piece("fruits", "Les douze fruits du Saint-Esprit", [liste("Les douze fruits", "Les cinq préceptes")],
                  note="Le n° 6 manque dans le texte publié sur le site du Vatican."),
            piece("misericorde-corporelle", "Les sept œuvres de miséricorde corporelle",
                  [liste("Les sept œuvres de miséricorde corporelle", "Les sept œuvres de miséricorde spirituelle")]),
            piece("misericorde-spirituelle", "Les sept œuvres de miséricorde spirituelle",
                  [liste("Les sept œuvres de miséricorde spirituelle", "Le sept péchés")]),
            piece("peches-capitaux", "Les sept péchés capitaux", [liste("Le sept péchés", "Les quatre fins")]),
            piece("fins-dernieres", "Les quatre fins de l’homme", [liste("Les quatre fins", None)]),
        ]},
    ]
    # « (Tradition copte) » : première ligne → note
    for g in groupes:
        for p in g["pieces"]:
            if p.get("note") is None: p.pop("note", None)
            if p["fr"] and len(p["fr"][0]) == 1 and re.fullmatch(r"\(Tradition .*\)", p["fr"][0][0]):
                p["note"] = p["fr"][0][0].strip("()"); p["fr"] = p["fr"][1:]
    # prières en prose : les retours à la ligne de la page ne sont que ceux de la colonne imprimée
    PROSE = {"souvenez-vous", "acte-de-foi", "acte-d-esperance", "acte-de-charite", "acte-de-contrition",
             "encens", "adieu-autel", "defunts-byzantin", "symbole-des-apotres", "credo-nicee"}
    for g in groupes:
        for p in g["pieces"]:
            if p["id"] in PROSE:
                for cle in ("fr", "la"):
                    if p.get(cle):
                        p[cle] = [[re.sub(r"(?<=[a-zé])\.(?=[A-ZÉ])", ". ", " ".join(b))] for b in p[cle]]
                p["prose"] = True
    # Rosaire : la prière finale (dernier paragraphe) est en prose
    for g in groupes:
        for p in g["pieces"]:
            if p["id"] == "rosaire":
                for cle in ("fr", "la"):
                    p[cle][-1] = [" ".join(p[cle][-1])]
    data = {"source": "Compendium du Catéchisme de l’Église catholique (2005), appendice, vatican.va",
            "droits": "© Libreria Editrice Vaticana", "groupes": groupes}
    SORTIE.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
    n = sum(len(g["pieces"]) for g in groupes)
    print(f"{SORTIE.relative_to(RACINE)} : {len(groupes)} groupes, {n} pièces")
    for g in groupes:
        for p in g["pieces"]:
            nf = sum(len(b) for b in p["fr"]); nl = sum(len(b) for b in p.get("la", []))
            print(f"  {p['id']:24} fr {len(p['fr'])} bl/{nf:3} l   la {len(p.get('la', []))} bl/{nl:3} l")


if __name__ == "__main__":
    main()
