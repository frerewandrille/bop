#!/usr/bin/env python3
"""Martyrologes (trois éditions) et nécrologe de la Province → site/donnees/martyrologe.json, necrologe.json

Sources (sources_martyrologe/, copiées du Drive « Liturgie ») :
  romain-2014.docm     « Martyrologe romain 2014-2015 »  (couvent Saint-Thomas-d'Aquin, Rangueil, 2015)
  rangueil-2020.docm   « Martyrologe romain 2020 RANGUEIL CORR DONNEAUD »
  marseille-2020.pdf   « Martyrologe romain 2020 MARSEILLE » (couvent Saint-Lazare)
  catalogus-2026-necrologe.pdf  extrait du Catalogus 2026, « Mémoire de nos frères défunts »

Texte pris tel quel, gras gardé (noms des saints) ; l'italique général des fichiers Word est retiré.

martyrologe.json = { editions: {cle: nom}, intro: {annonce, conclusion, conclusionPascale},
                     jours: {cle: {"MM-JJ": [paragraphes html]}}, mobiles: {cle: {cleFete: {titre, texte[]}}} }
necrologe.json   = { jours: {"MM-JJ": [{annee, nom, lieu, note?}]}, sansJour: {"MM": [...]}, notes: {...} }
"""
import html, json, re, subprocess, tempfile, shutil, xml.etree.ElementTree as ET
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
SRC = RACINE / "sources_martyrologe"
DONNEES = RACINE / "site" / "donnees"

MOIS = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"]
TITRE_JOUR = re.compile(r"^(1er|\d{1,2})\s+(" + "|".join(MOIS) + r")\s*(\(.*\))?\s*(?:,\s*(.*)|\s(jour anniversaire.*))?$")

# fêtes mobiles : début du titre dans les sources → clé (voir site/js/martyrologe.js)
MOBILES = [
    ("Mémoire de la bienheureuse Vierge Marie", "marie-samedi"), ("Solennité de l'Épiphanie", "epiphanie"),
    ("Fête du baptême du Seigneur", "bapteme"), ("Mercredi des cendres", "cendres"),
    ("Dimanche des rameaux", "rameaux"), ("Dimanche de Pâques", "paques"),
    ("Solennité de l'Ascension", "ascension"), ("Solennité de la Pentecôte", "pentecote"),
    ("Solennité de la Sainte Trinité", "trinite"), ("Solennité du Saint Sacrement", "saint-sacrement"),
    ("Solennité du Sacré-Cœur", "sacre-coeur"), ("Mémoire du Cœur immaculé", "coeur-immacule"),
    ("Solennité du Christ Roi", "christ-roi"), ("Solennité de la Sainte Famille", "sainte-famille"),
]
APOS = lambda s: s.replace("’", "'")


def nettoyer(h):
    """html d'un paragraphe → html réduit à <b> et <sup>."""
    h = re.sub(r'<span class="Apple-converted-space">(.*?)</span>', lambda m: " " * len(m.group(1)), h)
    h = re.sub(r"</?(i|span|font|a)[^>]*>", "", h)
    h = re.sub(r"<(/?)(b|sup)(\s[^>]*)?>", r"<\1\2>", h)
    h = re.sub(r"<(?!/?(b|sup)>|br>)[^>]+>", "", h)
    h = re.sub(r"<br\s*/?>", "<br>", h)
    h = re.sub(r"</b>(\s*)<b>", r"\1", h)
    h = re.sub(r"<b>(\s*)</b>", r"\1", h)
    h = html.unescape(h).replace("&", "&amp;").replace("&amp;amp;", "&amp;")
    h = re.sub(r"[  ]+", " ", h).strip()
    h = re.sub(r"<b>\s+", " <b>", h); h = re.sub(r"\s+</b>", "</b> ", h)
    return re.sub(r" +", " ", h).strip()


def texte(h):
    return re.sub(r"<[^>]+>", "", h).replace("&amp;", "&").strip()


# ── lecture des sources en paragraphes (html réduit)
def paragraphes_word(docm):
    tmp = Path(tempfile.mkdtemp())
    try:
        docx = tmp / "f.docx"; shutil.copy(docm, docx)
        subprocess.run(["textutil", "-convert", "html", "-output", str(tmp / "f.html"), str(docx)], check=True)
        s = (tmp / "f.html").read_text(encoding="utf-8")
    finally:
        shutil.rmtree(tmp)
    return [nettoyer(p) for p in re.findall(r"<p[^>]*>(.*?)</p>", s, re.S)]


def paragraphes_pdf(pdf):
    """pdftohtml -xml : lignes reconstruites, paragraphe = ligne vide (écart vertical) ; numéros de page retirés."""
    x = subprocess.run(["pdftohtml", "-q", "-xml", "-i", "-stdout", str(pdf)], capture_output=True, text=True, check=True).stdout
    racine = ET.fromstring(x.encode("utf-8"))
    paras = []
    for page in racine.iter("page"):
        hauteur = int(page.get("height"))
        lignes = {}
        for t in page.iter("text"):
            top = int(t.get("top"))
            if top > hauteur * 0.93 or top < hauteur * 0.03:     # pied et tête de page
                continue
            contenu = "".join(t.itertext())
            gras = t.find("b") is not None or t.find(".//b") is not None
            frag = html.escape(contenu, quote=False)
            if gras and contenu.strip(): frag = "<b>" + frag + "</b>"
            # même ligne : à 3 points près
            cle = next((k for k in lignes if abs(k - top) <= 3), top)
            lignes.setdefault(cle, []).append((int(t.get("left")), frag, contenu, int(t.get("left")) + int(t.get("width"))))
        prec, cur = None, []
        for top in sorted(lignes):
            elems = sorted(lignes[top])
            brut = "".join(e[2] for e in elems)
            if not brut.strip():                    # ligne vide → fin de paragraphe
                if cur: paras.append(cur); cur = []
                prec = top; continue
            if prec is not None and top - prec > 30 and cur:
                paras.append(cur); cur = []
            droite = max(e[3] for e in elems if e[2].strip())
            courte = droite < int(page.get("width")) * 0.72        # ligne qui s'arrête avant la marge : vers, titre
            cur.append("".join(e[1] for e in elems) + ("<br>" if courte else "")); prec = top
        if cur: paras.append(cur)                     # un paragraphe coupé par la page est recollé plus bas
        paras.append(None)                            # marque de changement de page
    # recoller les paragraphes coupés par un changement de page (pas de point final)
    out = []
    for i, p in enumerate(paras):
        if p is None: continue
        h = nettoyer(" ".join(p))
        h = re.sub(r"(\s*<br>\s*)+$", "", h).replace("<br> ", "<br>")
        if out and i > 0 and paras[i - 1] is None and out[-1] and not re.search(r"[.!?»\"]$", texte(out[-1])) \
                and not TITRE_JOUR.match(texte(h)) and not TITRE_JOUR.match(texte(out[-1])):
            out[-1] = out[-1] + " " + h
        else:
            out.append(h)
    return out


# ── découpage en jours et fêtes mobiles
def decouper(paras):
    jours, mobiles, ordre = {}, {}, []
    cle, mob, prec = None, None, (0, 0)
    for p in paras:
        t = texte(p)
        if not t:
            continue
        if re.fullmatch(r"F[ÊE]TES MOBILES", t.replace(" ", "").replace("FÊTES", "FÊTES ").replace("FÊtes", "FÊTES ").upper().replace("MOBILES", "MOBILES"), re.I) \
                or t.replace(" ", "").upper() == "FÊTESMOBILES":
            cle, mob = None, "?"; continue
        if mob is not None:
            m = next(((k, v) for k, v in MOBILES if APOS(t).lower().startswith(APOS(k).lower())), None)
            if m and len(t) < 200:
                mob = m[1]; mobiles[mob] = {"titre": t, "texte": []}; continue
            if mob != "?": mobiles[mob]["texte"].append(p)
            continue
        m = TITRE_JOUR.match(t)
        if m and len(t) < 200:
            j = 1 if m.group(1) == "1er" else int(m.group(1))
            mo = MOIS.index(m.group(2)) + 1
            if (mo, j) <= prec and prec[0] > mo:     # « 7 août » écrit à la place de « 7 septembre »
                mo = prec[0]
            prec = (mo, j)
            cle = f"{mo:02d}-{j:02d}"
            jours[cle] = []
            ann = m.group(4) or m.group(5)
            if ann: jours[cle].append(m.group(1) + " " + MOIS[mo - 1] + ", " + html.escape(ann, quote=False))
            continue
        if re.fullmatch(r"[A-ZÉÈÛÔ ]{4,}", t):          # JANVIER, FÉVRIER…
            continue
        if cle:
            jours[cle].append(p)
    return jours, mobiles


def intro(paras):
    t = [texte(p) for p in paras[:80]]
    return {
        "annonce": "Anniversaires inscrits au martyrologe du…",
        "conclusion": "Ailleurs enfin, anniversaires de nombreux autres saints dont le nom est inscrit au Livre de Vie.",
        "conclusionPascale": "Le même jour enfin, anniversaires d’une nuée d’autres témoins de toute race, langue et nation, entrés dans le Paradis du Christ.",
    }


# ── nécrologe
def necrologe():
    txt = subprocess.run(["pdftotext", "-layout", str(SRC / "catalogus-2026-necrologe.pdf"), "-"], capture_output=True, text=True, check=True).stdout
    jours, sans = {}, {}
    MOIS_ABR = {"Janv": 1, "Févr": 2, "Mars": 3, "Avril": 4, "Mai": 5, "Juin": 6, "Juil": 7, "Août": 8, "Sept": 9, "Oct": 10, "Nov": 11, "Déc": 12}

    def couper(reste):
        parts = re.split(r"\s{2,}", reste.strip())
        if len(parts) == 1:
            m = re.match(r"^(.*\))\s+(\S.*)$", reste.strip())
            parts = [m.group(1), m.group(2)] if m else [reste.strip(), ""]
        nom, lieu = parts[0], " ".join(parts[1:])
        note = None
        if re.search(r"[A-ZÉ]3$", nom):
            nom = nom[:-1]; note = "bienheureux"
        return nom.strip(), lieu.strip(), note

    for l in txt.split("\n"):
        m = re.match(r"^\s*(\d{2})\.(\d{2})\.(\d{4})\s+(.*)$", l)
        if m:
            nom, lieu, note = couper(m.group(4))
            e = {"annee": int(m.group(3)), "nom": nom, "lieu": lieu}
            if note: e["note"] = note
            jours.setdefault(f"{m.group(2)}-{m.group(1)}", []).append(e)
            continue
        m = re.match(r"^\s*([A-ZÉ][a-zéû]+)\.?\s+(\d{4})\s+(.*)$", l)
        if m and m.group(1)[:5].rstrip(".") in [k[:5] for k in MOIS_ABR]:
            mo = next(v for k, v in MOIS_ABR.items() if k[:4] == m.group(1)[:4])
            nom, lieu, note = couper(m.group(3))
            sans.setdefault(f"{mo:02d}", []).append({"annee": int(m.group(2)), "nom": nom, "lieu": lieu})
    n = sum(len(v) for v in jours.values()) + sum(len(v) for v in sans.values())
    return {
        "source": "Catalogus 2026 de la Province de Toulouse, « Mémoire de nos frères défunts »",
        "jours": dict(sorted(jours.items())), "sansJour": sans,
        "notes": {
            "lettres": "(c) coopérateur ; (d) diacre ; (e) évêque ; (f) familier ; (t) tertiaire.",
            "lieux": "Le lieu peut être celui de la dernière assignation, du décès ou de l’inhumation.",
            "bienheureux": "Ce défunt ayant été reconnu bienheureux, lors du De profundis de ce jour, plutôt que de prier pour lui, on pourra confier nos frères défunts à son intercession.",
        },
    }, n


def retoucher_marseille(jours, toulouse):
    """Défauts du PDF de Marseille, corrigés à la main (notés dans « remarques »)."""
    rem = {}
    # paragraphes coupés par un changement de page : la suite (sans gras) se trouve, dans l'édition
    # de Toulouse, au milieu d'un paragraphe → recollée au précédent
    norm = lambda h: re.sub(r"\W+", " ", texte(h)).strip().lower()
    corps = [norm(x) for v in toulouse.values() for x in v]
    for k, v in jours.items():
        out = []
        for x in v:
            n = norm(x)[:50]
            if out and "<b>" not in x and n and (n[0].islower() or (len(n) >= 8 and any(c.find(n) > 0 for c in corps))):
                out[-1] = out[-1] + " " + x
            else:
                out.append(x)
        jours[k] = out
    # textes en vers (proclamation de Noël) : le PDF colle les vers ; si les mots sont ceux de Toulouse,
    # on prend la mise en lignes de Toulouse
    mots = lambda L: re.sub(r"[^a-zà-ÿ0-9]+", " ", " ".join(texte(x) for x in L).lower()).split()
    t25 = toulouse["12-25"]; it = next(n for n, x in enumerate(t25) if texte(x).startswith("Poursuivre en disant"))
    m25 = jours["12-25"]; im = next((n for n, x in enumerate(m25) if "Poursuivre en disant" in texte(x)), None)
    if im is not None:
        bloc = texte(m25[im]); avant = m25[:im] + [m25[im][:m25[im].find("Poursuivre en disant")]]
        if [w for w in mots(avant) if w not in "o"] == [w for w in mots(t25[:it]) if w not in "o"] or \
                mots(avant)[:40] == mots(t25[:it])[:40]:
            jours["12-25"] = t25[:it + 1] + m25[im + 1:]
            rem["12-25"] = "Proclamation de la Nativité : mise en lignes reprise de l’édition de Toulouse (même texte)."
    # page du 24-25 mars : la proclamation de l'Annonciation est une image mêlée au texte → illisible
    j24 = jours["03-24"]
    i = next(n for n, x in enumerate(j24) if "´" in texte(x) or "`" in texte(x))
    jours["03-24"] = j24[:i]
    jours["03-25"] = list(toulouse["03-25"])
    rem["03-25"] = "Page illisible dans le PDF de Marseille : texte repris de l’édition de Toulouse (2020)."
    # le PDF n'a pas de titre « 22 septembre » : le 21 se poursuit avec les éloges du 22
    j21 = jours["09-21"]
    i = next(n for n, x in enumerate(j21) if texte(x).startswith("À Agaune"))
    jours["09-21"], jours["09-22"] = j21[:i], j21[i:]
    rem["09-22"] = "Le titre « 22 septembre » manque dans le PDF de Marseille ; saint Silvain (Toulouse) n’y figure pas."
    return dict(sorted(jours.items())), rem


def main():
    EDITIONS = [
        ("romain", "Martyrologe romain (Rangueil, 2014-2015)", lambda: paragraphes_word(SRC / "romain-2014.docm")),
        ("marseille", "Couvent Saint-Lazare, Marseille (2020)", lambda: paragraphes_pdf(SRC / "marseille-2020.pdf")),
        ("toulouse", "Couvent Saint-Thomas-d’Aquin, Toulouse-Rangueil (2020)", lambda: paragraphes_word(SRC / "rangueil-2020.docm")),
    ]
    data = {"editions": {}, "jours": {}, "mobiles": {}, "remarques": {}}
    toulouse, toulouse_mob = decouper(paragraphes_word(SRC / "rangueil-2020.docm"))
    for cle, nom, lire in EDITIONS:
        paras = lire()
        jours, mobiles = decouper(paras)
        if cle == "marseille":
            jours, data["remarques"]["marseille"] = retoucher_marseille(jours, toulouse)
            # fêtes mobiles en vers : même règle que la proclamation de Noël
            mots = lambda L: re.sub(r"[^a-zà-ÿ0-9]+", " ", " ".join(texte(x) for x in L).lower()).split()
            # « … martyrologe du… Fête du baptême du Seigneur » : titre collé à la fin de l'Épiphanie
            ep = mobiles.get("epiphanie", {}).get("texte", [])
            i = next((n for n, x in enumerate(ep) if texte(x).endswith("Fête du baptême du Seigneur")), None)
            if i is not None and "bapteme" not in mobiles:
                mobiles["bapteme"] = {"titre": "Fête du baptême du Seigneur", "texte": ep[i + 1:]}
                ep[i] = ep[i][:ep[i].rfind("Fête du baptême")].strip()
                del ep[i + 1:]
            for k, m in mobiles.items():
                t = toulouse_mob.get(k)
                if not t: continue
                consigne = [x for x in m["texte"] if texte(x).startswith("Avant de commencer")]
                reste = [x for x in m["texte"] if x not in consigne]
                mt = mots(t["texte"])
                if mots(reste)[:len(mt)] == mt:          # le reste éventuel est un titre suivant mal coupé
                    m["texte"] = consigne + t["texte"]
            tout = " ".join(" ".join(mots(m["texte"])) + " " + " ".join(mots([m["titre"]])) for m in mobiles.values())
            tout_brut = " ".join(" ".join(mots(x["texte"] + [x["titre"]])) for x in mobiles.values())
            for k, t in toulouse_mob.items():           # fête collée à la précédente dans le PDF (Baptême)
                if k not in mobiles and " ".join(mots(t["texte"]))[:200] in tout_brut:
                    mobiles[k] = t
                    data["remarques"]["marseille"]["mobile-" + k] = "Titre collé à la fête précédente dans le PDF : texte de Toulouse (identique)."
        data["editions"][cle] = nom
        data["jours"][cle] = dict(sorted(jours.items()))
        data["mobiles"][cle] = mobiles
        vides = [k for k, v in jours.items() if not v]
        print(f"{cle:10} {len(jours)} jours, {sum(len(v) for v in jours.values())} éloges, "
              f"{len(mobiles)} fêtes mobiles ; jours vides : {vides or 'aucun'}")
        if cle == "romain": data["intro"] = intro(paras)
    (DONNEES / "martyrologe.json").write_text(json.dumps(data, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    nec, n = necrologe()
    (DONNEES / "necrologe.json").write_text(json.dumps(nec, ensure_ascii=False, indent=0), encoding="utf-8")
    print(f"nécrologe : {n} frères ({sum(len(v) for v in nec['sansJour'].values())} sans jour précis)")


if __name__ == "__main__":
    main()
