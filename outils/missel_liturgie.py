#!/usr/bin/env python3
"""Ordinaire du Missel (« Liturgie de la messe », v7 avec bénédictions) → arbre pour la consultation du Missel.

Le fichier Word a des styles nommés : on lit document.xml directement (textutil perd ces styles).
  Prêtre / Prêtre + peuple / Antienne → paroles (gras dans le Missel) ; Peuple → réponses ;
  Note → consignes (rouge) ; Prêtre voix basse ; Titre1-6 → découpage.
Sortie : liste de chapitres [{id, titre, groupes: [{titre, pieces: [{id, titre, sous?, blocs}]}]}]
  bloc = {k: "dit"|"peuple"|"rub"|"bas"|"h"|"sous"|"ou", h: HTML réduit (i, br, span.rubrique-ligne, sup)}

Utilisé par construire_missel.py ; seul : python3 outils/missel_liturgie.py → résumé.
"""
import html
import re
import zipfile
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
FICHIER = RACINE / "sources_missel" / "ordinaire" / "missel-liturgie-de-la-messe-v7-avec-benedictions.docx"

ROUGES = re.compile(r'w:color w:val="(C00000|FF0000|C0504D|E36C0A|943634|B30000|CC0000|D60000)"', re.I)
STYLE_KIND = {"Prtre": "dit", "Prtrepeuple": "dit", "Antienneliturgique": "dit", "Lecture": "dit", "ChantRefrain": "dit",
              "ChantStrophe": "dit", "Peuple": "peuple", "Note": "rub", "Prtrevoixbasse": "bas", "-": "dit"}


def paragraphes(xml):
    """→ [(style, html, texte brut, lettrine?)] dans l'ordre du document (tableaux de mise en page compris)."""
    body = xml[xml.find("<w:body>"):]
    out = []
    for p in re.findall(r"<w:p\b[^>]*?(?:/>|>.*?</w:p>)", body, re.S):
        m = re.search(r'<w:pStyle w:val="([^"]*)"', p)
        st = m.group(1) if m else "-"
        cadre = "<w:framePr" in p
        h, brut = [], []
        for r in re.findall(r"<w:r\b[^>]*>.*?</w:r>", p, re.S):
            rpr = (re.search(r"<w:rPr>.*?</w:rPr>", r, re.S) or [""])[0] if "<w:rPr>" in r else ""
            rpr = rpr if isinstance(rpr, str) else rpr.group(0)
            rouge = bool(ROUGES.search(rpr)) or bool(re.search(r'w:rStyle w:val="(NoteCar|Lienhypertexte)"', rpr))
            ital = bool(re.search(r"<w:i/>|<w:i w:val=\"(1|true)\"/>", rpr))
            sup = 'w:vertAlign w:val="superscript"' in rpr or 'w:rStyle w:val="Appelnotedebasdep"' in rpr
            morceaux = []
            for x in re.findall(r"<w:t[^>]*>[^<]*</w:t>|<w:tab/>|<w:br/>|<w:cr/>|<w:noBreakHyphen/>|<w:sym [^>]*>", r):
                if x == "<w:tab/>": morceaux.append("\t")
                elif x in ("<w:br/>", "<w:cr/>"): morceaux.append("\n")
                elif x == "<w:noBreakHyphen/>": morceaux.append("-")
                elif x.startswith("<w:sym"): morceaux.append({"F058": "✠", "F0BA": "▸", "F0E0": "→"}.get((re.search(r'w:char="([0-9A-F]+)"', x) or [0, ""])[1], ""))
                else: morceaux.append(html.unescape(re.sub(r"<[^>]+>", "", x)))
            t = "".join(morceaux)
            if not t: continue
            brut.append(t)
            e = html.escape(t, quote=False)
            if sup: e = f"<sup>{e}</sup>"
            if ital: e = f"<i>{e}</i>"
            if rouge and st not in ("Note",) and not st.startswith("Titre"): e = f'<span class="rubrique-ligne">{e}</span>'
            h.append(e)
        out.append((st, "".join(h), "".join(brut), cadre))
    return out


def nettoyer(h):
    """HTML d'un paragraphe : retours à la ligne, tabulations (« R/ » puis texte ; colonnes), espaces."""
    h = h.replace(" ", " ")
    h = re.sub(r"</i><i>|</span><span class=\"rubrique-ligne\">", "", h)
    h = re.sub(r'<span class="rubrique-ligne">(R/|V/|R\.|V\.)\s*</span>\t*\s*', lambda m: m.group(1)[0] + "/\t", h)
    h = re.sub(r'^<span class="rubrique-ligne">([A-ZÉÈÀÔÎÂ])</span>', r"\1", h)
    h = re.sub(r"[ \t]*\n[ \t]*", "<br>", h)
    h = re.sub(r'(^|<br>)\t+', r"\1", h)
    h = re.sub(r'<span class="rubrique-ligne">\t+', '<span class="rubrique-ligne">', h)
    # signes (✠, †, N., ▸) : en rouge dans la ligne ; consignes : sur leur ligne
    h = re.sub(r'<span class="rubrique-ligne">([▸•])\s*([A-ZÉÈÀÔÎÂ])</span>', r'<span class="signe">\1</span> \2', h)   # ▸ + lettrine
    h = re.sub(r'<span class="rubrique-ligne">\s*([^<]{1,3}?)\s*</span>', lambda m: f'<span class="signe">{m.group(1)}</span>' if m.group(1).strip() else " ", h)
    h = re.sub(r'(?:<br>)+</span>', "</span>", h)                       # consigne en fin de ligne : sa propre ligne suffit
    h = re.sub(r'(</span>)\t+', r"\1 ", h)
    h = re.sub(r"^(R/|V/)\t*", r'<span class="rv">\1</span> ', h)
    h = re.sub(r"(<br>)(R/|V/)\t*", r'\1<span class="rv">\2</span> ', h)
    h = re.sub(r"(?<![\w>])(R|V)/\t+", r'<span class="rv">\1/</span> ', h)
    h = re.sub(r"^\t+", "", h)
    h = re.sub(r"\t+", '<span class="tab"> </span>', h)
    h = re.sub(r"═+", "", h)
    h = re.sub(r'<span class="rubrique-ligne">\s*</span>|<i>\s*</i>', " ", h)
    h = re.sub(r"(<br>\s*)+$", "", h)
    h = re.sub(r" {2,}", " ", h)
    return h.strip()


def titre_propre(t):
    t = re.sub(r"\s+", " ", t.replace("\t", " ")).strip()
    t = re.sub(r"(chrismale|particulières)(et|lors)\b", r"\1 \2", t)
    m = re.match(r"^(I{1,3}|IV) ?([A-ZÉÈ][a-zé’'].*)$", t)            # « IL’Église en marche » → « I – L’Église en marche »
    if m: t = f"{m.group(1)} – {m.group(2)}"
    return t.rstrip(" .")


def slug(t):
    import unicodedata
    s = unicodedata.normalize("NFD", t.lower())
    s = "".join(c for c in s if unicodedata.category(c) != "Mn")
    return re.sub(r"[^a-z0-9]+", "-", s).strip("-")[:60]


# Préfaces : groupes dans l'ordre du Missel
GROUPES_PREFACES = [
    ("Avent", r"Avent"), ("Noël et Épiphanie", r"Nativité|Épiphanie"), ("Carême", r"Carême"),
    ("Passion et Semaine sainte", r"Passion|Rameaux|chrismale|Cène"), ("Temps pascal", r"Pâques|Ascension|Pentecôte"),
    ("Dimanches du Temps ordinaire", r"dimanches du Temps ordinaire"), ("Préfaces communes", r"Préface commune"),
    ("Fêtes du Seigneur", r"Trinité|Annonciation|Baptême|Sacré|Croix|Eucharistie|Présentation|Christ Roi|Transfiguration|Saint-Esprit"),
    ("Vierge Marie", r"Vierge Marie|Immaculée|Assomption"),
    ("Saints", r"anges|Jean-Baptiste|Joseph|Pierre et Paul|Apôtres|saints|vierges|Madeleine"),
    ("Sacrements et circonstances", r"ordination|mariage|vie religieuse|dédicace|unité"),
    ("Défunts", r"défunts"),
]
NOUVELLE_PIECE_ROUGE = re.compile(r"^(Bénédiction et aspersion|Bénédictions solennelles|Prières sur le peuple|Annexe à la liturgie)")


def extraire(fichier=FICHIER):
    with zipfile.ZipFile(fichier) as z:
        xml = z.read("word/document.xml").decode("utf-8")
    P = paragraphes(xml)
    pieces = []           # [{titre, partie, blocs, sous}]
    partie = None         # Titre1 : Rites initiaux, Liturgie de la Parole…
    zone = "ordinaire"    # ordinaire | benedictions | peuple
    sousgroupe = None     # bénédictions : « I – Temporal »…
    cur = None
    lettrine = ""
    sauter = False        # tables des matières du fichier (le sommaire du site les remplace)

    def nouvelle(titre, **kw):
        nonlocal cur
        cur = {"titre": titre, "partie": partie, "zone": zone, "groupe": sousgroupe, "blocs": [], **kw}
        pieces.append(cur)

    for st, h, brut, cadre in P:
        t = brut.strip()
        if not t: continue
        if (cadre and len(t) <= 2 or re.fullmatch(r"[A-ZÉÈÀÔÎ]", t)) and not st.startswith("Titre"):
            lettrine = html.escape(t); continue
        if lettrine:
            h = lettrine + h.lstrip(); t = brut; lettrine = ""
        if st in ("Titre0",): continue
        if st in ("Titre1", "Titre1rouge"):
            sauter = False
            if st == "Titre1rouge" or re.match(r"^bénédictions", t, re.I):
                zone = "benedictions"; cur = None; continue
            partie = titre_propre(t); cur = None
            if partie == "Rite de conclusion": nouvelle(partie)
            continue
        if st == "Titre2rouge" and NOUVELLE_PIECE_ROUGE.match(t):
            sauter = False
            if t.startswith("Annexe"): nouvelle("Notes sur les prières eucharistiques de l’annexe"); continue
            if t.startswith("Bénédictions solennelles"): zone = "benedictions"; sousgroupe = None; cur = None; continue
            if t.startswith("Prières sur le peuple"): zone = "peuple"; nouvelle("Prières sur le peuple"); continue
            nouvelle(titre_propre(t)); continue
        if st == "Titre2":
            tt = titre_propre(t)
            if tt.startswith("Table des"): sauter = True; cur = None; continue
            sauter = False
            if zone == "benedictions": sousgroupe = re.sub(r"^(I+V?)\s*[–.-]\s*", "", tt); cur = None; continue
            nouvelle(tt); continue
        if sauter: continue
        if st == "Titre6" and zone == "benedictions":
            nouvelle(titre_propre(t)); continue
        if cur is None:
            if zone == "benedictions": continue
            nouvelle(partie or "Liturgie de la messe")
        if st == "Titre5":
            if not cur["blocs"] and "sous" not in cur: cur["sous"] = titre_propre(t)
            else: cur["blocs"].append({"k": "sous", "h": nettoyer(h)})
            continue
        if st.startswith("Titre"):        # Titre2rouge (formules), Titre3, Titre4 (antiennes), Titre6
            parts = brut.strip().split("\t")
            titre = html.escape(titre_propre(parts[0]))
            m = re.match(r"^(\d+)\.\s*(.*)$", parts[0].strip())   # « 85.Commémoration des vivants »
            if m: titre = html.escape(titre_propre(m.group(2)))
            ref = html.escape(" ".join(x.strip() for x in parts[1:] if x.strip()))
            if not ref:
                m2 = re.match(r"^(Antienne \d+)(.+)$", parts[0].strip())
                if m2: titre, ref = html.escape(m2.group(1)), html.escape(m2.group(2).strip())
            cur["blocs"].append({"k": "h", "h": titre + (f' <span class="ref">{ref}</span>' if ref else "")})
            continue
        if st == "Interligne": continue
        k = STYLE_KIND.get(st, "dit")
        hh = nettoyer(h)
        if k == "rub":
            hh = re.sub(r"^(\d{1,3})\.(<span class=\"tab\"> </span>)?\s*", r'<span class="num">\1.</span> ', hh)
            if re.fullmatch(r"(Ou bien|Ou)\s*:?", t, re.I): cur["blocs"].append({"k": "ou", "h": "ou bien"}); continue
        cur["blocs"].append({"k": k, "h": hh})

    # → chapitres
    def piece(p, titre=None):
        d = {"id": slug(titre or p["titre"]), "titre": titre or p["titre"], "blocs": p["blocs"]}
        if p.get("sous"): d["sous"] = p["sous"]
        return d
    ordinaire, prefaces, pe, bened, peuple = {}, {}, [], {}, []
    for p in pieces:
        if not p["blocs"]: continue
        t = p["titre"]
        if p["zone"] == "peuple": peuple.append(piece(p)); continue
        if p["zone"] == "benedictions": bened.setdefault(p["groupe"] or "Bénédictions", []).append(piece(p)); continue
        if re.search(r"Préface", t):
            g = next((nom for nom, rx in GROUPES_PREFACES if re.search(rx, t)), "Autres préfaces")
            prefaces.setdefault(g, []).append(piece(p)); continue
        if re.match(r"^(Prière eucharistique .|Manière de proclamer|Notes sur les prières|I{1,3} –|IV –)", t):
            if re.match(r"^(I{1,3}|IV) –", t): pe.append(piece(p, "Circonstances particulières " + t))
            else: pe.append(piece(p))
            continue
        ordinaire.setdefault(p["partie"] or "Liturgie de la messe", []).append(piece(p))
    # identifiants uniques
    vus = {}
    def uniques(lst):
        for x in lst:
            b = x["id"]; n = vus.get(b, 0); vus[b] = n + 1
            if n: x["id"] = f"{b}-{n + 1}"
        return lst
    ordre_pref = [nom for nom, _ in GROUPES_PREFACES] + ["Autres préfaces"]
    return [
        {"id": "ordinaire", "titre": "Ordinaire de la messe", "groupes": [{"titre": k, "pieces": uniques(v)} for k, v in ordinaire.items()]},
        {"id": "prefaces", "titre": "Préfaces", "groupes": [{"titre": k, "pieces": uniques(prefaces[k])} for k in ordre_pref if k in prefaces]},
        {"id": "prieres-eucharistiques", "titre": "Prières eucharistiques", "groupes": [{"titre": "", "pieces": uniques(pe)}]},
        {"id": "benedictions", "titre": "Bénédictions solennelles et prières sur le peuple",
         "groupes": [{"titre": k, "pieces": uniques(v)} for k, v in bened.items()] + ([{"titre": "Prières sur le peuple", "pieces": uniques(peuple)}] if peuple else [])},
    ]


if __name__ == "__main__":
    for c in extraire():
        print("■", c["titre"])
        for g in c["groupes"]:
            print("  ▸", g["titre"], "—", len(g["pieces"]), "pièces")
            for p in g["pieces"]:
                print("     ", p["id"], "|", p["titre"], "|", p.get("sous", ""), "|", len(p["blocs"]), "blocs")
