"""
La Chaîne d'or (Catena aurea) de saint Thomas d'Aquin — module TAE de Biblia Universalis.
Pour chaque chapitre des quatre évangiles : liste de sections
  {"c1": ch. début, "v1": v. début, "c2": ch. fin, "v2": v. fin, "r": "5.1-3",
   "q": citation du verset (facultative), "x": [[auteur, source, html], ...]}
"""
import html
import re

# abréviations de la Chaîne d'or -> nom complet
AUTEURS = {
    "S. CHRYS.": "Saint Jean Chrysostome", "S. AUG.": "Saint Augustin", "BÈDE.": "Saint Bède le Vénérable",
    "S. JÉR.": "Saint Jérôme", "S. JÉRÔME.": "Saint Jérôme", "THÉOPHYL.": "Théophylacte", "THÉOPHYLACTE.": "Théophylacte",
    "ORIG.": "Origène", "S. GRÉG.": "Saint Grégoire le Grand", "S. AMBR.": "Saint Ambroise", "S. AMB.": "Saint Ambroise",
    "S. HIL.": "Saint Hilaire de Poitiers", "REMI.": "Remi d’Auxerre", "LA GLOSE.": "La Glose",
    "S. CYR.": "Saint Cyrille d’Alexandrie", "S. CYRIL.": "Saint Cyrille d’Alexandrie", "RAB.": "Raban Maur",
    "RABAN.": "Raban Maur", "ALCUIN.": "Alcuin", "S. BAS.": "Saint Basile", "S. BASIL.": "Saint Basile",
    "EUSÈBE.": "Eusèbe de Césarée", "EUSÈBE": "Eusèbe de Césarée", "S. GRÉG. DE NYSSE": "Saint Grégoire de Nysse",
    "S. GRÉG DE NYSSE.": "Saint Grégoire de Nysse", "S. ATHAN.": "Saint Athanase", "TITE DE BOSTR.": "Tite de Bostra",
    "TITE DE BOSTRA.": "Tite de Bostra", "GREC.": "Un Père grec", "GREC": "Un Père grec",
    "CH. DES PÈR. GR.": "Chaîne des Pères grecs", "CHAÎNE DES PÈRES GRECS.": "Chaîne des Pères grecs",
    "S. LÉON.": "Saint Léon le Grand", "S. CYPR.": "Saint Cyprien", "S. CYP.": "Saint Cyprien",
    "SEV.": "Sévère d’Antioche", "SEVER.": "Sévère d’Antioche", "SÉVÈRE.": "Sévère d’Antioche",
    "SÉVÈRE D’ANTIOCHE.": "Sévère d’Antioche", "SÉVÈRE d’ANTIOCHE.": "Sévère d’Antioche", "SÉVÈRE D’ANT.": "Sévère d’Antioche",
    "HAYM.": "Haymon d’Auxerre", "S. JEAN DAMASC.": "Saint Jean Damascène", "S. ISID.": "Saint Isidore",
    "ISID.": "Saint Isidore", "S. ISIDORE.": "Saint Isidore", "DIDYME.": "Didyme l’Aveugle", "DYDIME.": "Didyme l’Aveugle",
    "S. MAX.": "Saint Maxime le Confesseur", "S. MAXIME.": "Saint Maxime le Confesseur", "S. ANSELME.": "Saint Anselme",
    "S. ANSELME": "Saint Anselme", "S. DENYS D’ALEX.": "Saint Denys d’Alexandrie", "S. DENIS.": "Saint Denys",
    "VICTOR D’ANTIOCHE.": "Victor d’Antioche", "ÉVAGRE LE PONTIQUE.": "Évagre le Pontique", "ASTÉRIUS.": "Astérius",
    "SIMÉON.": "Siméon", "THÉOPHANE.": "Théophane", "THÉODOTE.": "Théodote", "JOSÈPHE.": "Flavius Josèphe",
    "JEAN, ÉVÊQUE.": "Jean, évêque", "CONCILE ŒCUMÉNIQUE.": "Concile œcuménique", "ALCUIN et BÈDE.": "Alcuin et saint Bède", "S. DAMASE.": "Saint Jean Damascène",
}

MARK = re.compile(
    r'<font color=green><b><small>—(?:&nbsp;|\s)*\(<i>([^<]*)</i>([^<)]*)\)\s*</small></b></font>\s*(?:\(<i>([^<]*?)</i>\)\.?)?',
    re.S)
RANGE = re.compile(r"(\d+)\.(\d+)(?:\s*[-–]\s*(?:(\d+)\.)?(\d+))?")


def nom(abbr):
    a = html.unescape(abbr).strip()
    if a in AUTEURS:
        return AUTEURS[a]
    a2 = re.sub(r"\.\s.*$", ".", a)  # « CONCILE ŒCUMÉNIQUE. Actes… »
    return AUTEURS.get(a2, a.rstrip(".").title())


def nettoie(s):
    s = re.sub(r"</p>\s*<p[^>]*>", "<br><br>", s)
    s = re.sub(r"<(?!/?(?:i|b|br|sup)\b)[^>]+>", "", s)
    s = re.sub(r"\s+", " ", s)
    s = re.sub(r"^(\s|<br>)+|(\s|<br>)+$", "", s)
    return re.sub(r"&(?!lt;|gt;|amp;)(#?\w+);", lambda m: html.unescape(m.group(0)), s).strip()


def parse_tae(c):
    out = []
    parts = re.split(r"<h2>([^<]*)</h2>", c)
    for i in range(1, len(parts), 2):
        m = RANGE.search(parts[i])
        if not m:
            continue
        c1, v1 = int(m.group(1)), int(m.group(2))
        c2 = int(m.group(3)) if m.group(3) else c1
        v2 = int(m.group(4)) if m.group(4) else v1
        body = parts[i + 1]
        bits = MARK.split(body)  # [avant, auteur, complément, source, texte, auteur, …]
        sec = {"c1": c1, "v1": v1, "c2": c2, "v2": v2, "r": parts[i].strip(), "x": []}
        q = nettoie(bits[0])
        if q:
            sec["q"] = q
        for j in range(1, len(bits), 4):
            t = nettoie(bits[j + 3])
            src = html.unescape(bits[j + 2] or "").strip()
            extra = html.unescape(bits[j + 1] or "").strip()
            if extra:
                src = (extra + (" — " + src if src else "")).strip()
            if t:
                sec["x"].append([nom(bits[j]), src, t])
        if sec["x"]:
            out.append(sec)
    return out
