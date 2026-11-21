#!/usr/bin/env python3
"""Propre de l'Ordre des Prêcheurs : Missel et Lectionnaire (édition provisoire, juin 2026, LaTeX)
→ site/donnees/missel_op.json  (et site/donnees/propre_op.json, le calendrier de l'Ordre pour les offices)

Sources : sources_missel/op/missel_OP.pdf et lectionnaire_OP.pdf (Drive LITURGIE/01-Missel-et-Eucharistie/OP),
lues par pdftohtml -xml (police, couleur, position de chaque morceau de texte). Dans ces PDF :
  rouge (#bf3f14) = rubriques, dates, intitulés ; gras = ce qui se dit ; italique = notices ;
  lettrines (hauteur ≥ 40) et petites capitales = morceaux à recoller ; en-têtes courants en haut de page (top < 45).

missel_op.json = {
  calendrier: [{mmjj, nom, rang, martyrologe (en italique : pas de degré), provinces: [{province, rang}], note}],
  preface: {titre, sous, texte},                         préface des saints de l'Ordre (« Esprit et vocation du Prêcheur »)
  saints: {"MM-JJ": [{titre, rang, notice, commun, rubriques, source: "op", messes: [{ouverture, priere, offrandes,
            preface, communion, apres, benediction, peuple}]}]},  même forme que missel.json > saints
  votives: [ …idem, sans date (« Un jour au choix en mai ») ],
  communs: [{commun, cas, messe}],
  lectures: {"MM-JJ": [{titre, rang, lectures: [{type, titre, sous, intro, ref, refrain, texte, ou}]}]}
}
texte = [paragraphes [lignes]] ; une ligne qui commence par « § » est une rubrique (en rouge) ;
« Ou bien — réf » sépare deux textes au choix.
"""
import json, re, subprocess, sys
import xml.etree.ElementTree as ET
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
SRC = RACINE / "sources_missel" / "op"
SORTIE = RACINE / "site" / "donnees" / "missel_op.json"
PROPRE = RACINE / "site" / "donnees" / "propre_op.json"

MOIS = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"]
RX_DATE = re.compile(r"(?:^|,\s*)(\d{1,2})(?:er)?\s+(" + "|".join(MOIS) + r")\s*$", re.I)
ROUGE, BLEU = "#bf3f14", "#065f8f"


# ── lecture du XML de pdftohtml → lignes {page, top, left, right, t, rouge, gras, ital, haut, centre}
def xml_de(pdf):
    out = SRC / (pdf.stem + ".xml")
    if not out.exists() or out.stat().st_mtime < pdf.stat().st_mtime:
        subprocess.run(["pdftohtml", "-xml", "-i", "-q", "-nodrm", str(pdf), str(out.with_suffix(""))], check=True)
    return out


def lignes(pdf):
    src = re.sub(r"<!DOCTYPE[^>]*>", "", xml_de(pdf).read_text(encoding="utf-8"))
    root = ET.fromstring(src)
    fonts, res = {}, []
    for page in root.iter("page"):
        n, W = int(page.get("number")), int(page.get("width"))
        for f in page.iter("fontspec"):
            fonts[f.get("id")] = dict(size=int(f.get("size")), fam=f.get("family"), color=f.get("color"))
        els = []
        for t in page.iter("text"):
            txt = "".join(t.itertext())
            if not txt.strip(): continue
            f = fonts[t.get("font")]
            top, h = int(t.get("top")), int(t.get("height"))
            if top < 45: continue                                    # en-tête courant, numéro de page
            if f["fam"].endswith(("CMSY10", "MSAM10")) and txt.strip() in ("□", "", "⊓", "⊔"): continue   # repères de page
            els.append(dict(top=top, h=h, left=int(t.get("left")), w=int(t.get("width")), t=txt,
                            gras=any(c.tag == "b" for c in t.iter()), ital="Ital" in f["fam"],
                            rouge=f["color"] == ROUGE, size=f["size"]))
        # lettrines : rattachées à la ligne qui suit (même hauteur que leur haut)
        lettr = [e for e in els if e["h"] >= 40 and len(e["t"].strip()) <= 2]
        autres = [e for e in els if e not in lettr]
        groupes = []
        for e in sorted(autres, key=lambda e: (e["top"] + e["h"] / 2, e["left"])):
            c = e["top"] + e["h"] / 2
            if groupes and abs(groupes[-1]["c"] - c) <= 5: groupes[-1]["els"].append(e)
            else: groupes.append({"c": c, "els": [e]})
        for L in lettr:
            cible = min((g for g in groupes if g["c"] >= L["top"] - 2), key=lambda g: g["c"], default=None)
            if cible: L["lettrine"] = True; cible["els"].append(L)
        for g in groupes:
            es = sorted(g["els"], key=lambda e: e["left"])
            # un morceau loin à droite (référence biblique, degré) est séparé du reste
            corps, droite = [es[0]], []
            for e in es[1:]:
                fin = max(x["left"] + x["w"] for x in corps)
                (droite if e["left"] - fin > 40 and e["left"] > W * 0.55 and not droite and not e.get("lettrine") else (droite if droite else corps)).append(e)
            def joindre(xs):
                s, fin = "", None
                for x in xs:
                    t = x["t"]
                    if fin is not None and x["left"] - fin > 2.5 and not s.endswith(("’", "'")) and not t.startswith(("’",)): s += " "
                    s += t; fin = x["left"] + x["w"]
                return re.sub(r"\s+", " ", s).strip()
            t = joindre(corps)
            if any(x.get("lettrine") for x in corps):              # « S » + « EIGNEUR » → « Seigneur »
                t = re.sub(r"^(\w)\s*([A-ZÀ-Ÿ’']+)\b", lambda m: m.group(1) + m.group(2).lower(), t)
            principaux = [x for x in corps if not x.get("lettrine")] or corps
            tete = []
            for x in corps:
                if x.get("lettrine"): continue
                if x["rouge"] and x["gras"]: tete.append(x)
                else: break
            res.append(dict(page=n, tete=joindre(tete) if tete else "", top=int(g["c"]), left=corps[0]["left"], right=max(x["left"] + x["w"] for x in corps), W=W, t=t,
                            droite=joindre(droite) if droite else "",
                            rouge=all(x["rouge"] for x in principaux if x["t"].strip() not in ("(", ")", ",")),
                            gras=sum(len(x["t"]) for x in principaux if x["gras"]) > sum(len(x["t"]) for x in principaux) / 2,
                            ital=sum(len(x["t"]) for x in principaux if x["ital"]) > sum(len(x["t"]) for x in principaux) / 2,
                            haut=max(x["h"] for x in principaux), taille=max(x["size"] for x in principaux),
                            centre=abs((corps[0]["left"] + max(x["left"] + x["w"] for x in corps)) / 2 - W / 2) < 40 and corps[0]["left"] > W * 0.18))
    return res


PETITS = {"de", "du", "des", "et", "la", "le", "les", "en", "à", "au", "aux", "ou", "sur", "son", "ses", "sa", "leurs", "leur",
          "prêtre", "prêtres", "vierge", "vierges", "docteur", "évêque", "martyr", "martyrs", "pape", "religieux", "religieuse",
          "diacre", "mère", "père", "famille", "compagnons", "frère", "laïc", "patronne", "dont", "on", "ignore", "jour",
          "consécration", "anniversaire", "église", "ordre", "prêcheurs", "seigneur", "temple", "défunts", "sœurs", "frères",
          "bienfaiteurs", "familiers", "approbation", "pères", "mères", "dédicace", "vigile", "translation", "fête", "sœur"}
GARDES = {"église": "Église", "ordre": "Ordre", "prêcheurs": "Prêcheurs", "seigneur": "Seigneur", "temple": "Temple"}


def casse(t):
    """« SAINT THOMAS D’AQUIN » → « Saint Thomas d’Aquin » ; laisse tel quel un titre déjà en minuscules."""
    if t.upper() != t: return t
    mots = []
    for i, w in enumerate(t.lower().split()):
        m = re.match(r"^([dl]’)(.+)$", w)
        if m: mots.append(m.group(1) + m.group(2)[:1].upper() + m.group(2)[1:]); continue
        nu = w.strip(",.;:()")
        if nu in GARDES: mots.append(w.replace(nu, GARDES[nu])); continue
        if i and nu in PETITS: mots.append(w); continue
        mots.append("-".join(x[:1].upper() + x[1:] for x in w.split("-")))
    s = " ".join(mots)
    return re.sub(r"\bN\. ?P\. ?S\.", "N. P. S.", s.replace("N. p. s.", "N. P. S.")).replace("Bses ", "Bses ").replace("Bse ", "Bse ")


RANGS = [("solennité", r"^solennit[ée]"), ("fête", r"^f\s?[êe]te(?! patronale)"), ("mémoire facultative", r"^m[ée]m(\.|oire) facultative"),
         ("mémoire", r"^m[ée]m(\.|oire) (o[bl]{2}igatoire|olbigatoire)"), ("fête patronale", r"^f\s?[êe]te patronale")]


def rang_de(t):
    t = t.strip().lower()
    for r, rx in RANGS:
        if re.search(rx, t): return r
    return None


# ── Calendrier (pages avant le propre des saints)
def calendrier(L):
    cal, cur_mois, cur_jour, prec = [], None, None, None
    for l in L:
        if l["page"] > 12 or re.match(r"^PROPRE DES SAINTS", l["t"]): break
        t = l["t"]
        if t.upper() in [m.upper() for m in MOIS] and l["rouge"]: cur_mois = [m.upper() for m in MOIS].index(t.upper()) + 1; continue
        if not cur_mois: continue
        if re.match(r"^En mai les", t) or (prec is None and False): pass
        m = re.match(r"^(\d{1,2})\s+(.*)$", t)
        crochet = re.match(r"^\[\s*(.*?)\s*\]?$", t)
        if crochet and re.match(r"^\[", t):
            inner = crochet.group(1)
            dr = (l["droite"] or "").rstrip("] ").strip()
            if re.match(r"^Province", inner) and prec:
                prec["provinces"].append({"province": inner.strip(), "rang": rang_de(dr) or dr})
                continue
            if m is None: pass
        if m:
            cur_jour = int(m.group(1)); t = m.group(2)
        elif re.match(r"^(En mai|\(n’importe|des Prêcheurs \(surtout)", t) or (prec and not l["droite"] and l["left"] < 100 and cur_mois == 5 and "célébrations votives" in (prec.get("note") or "") + t):
            continue
        if cur_jour is None: continue
        # suite d'un nom sur deux lignes (« S. THOMAS D’AQUIN, PRÊTRE ET DOCTEUR DE » / « L’ÉGLISE  Fête »)
        if not m and prec and prec["mmjj"] == f"{cur_mois:02d}-{cur_jour:02d}" and not prec["fini"] and not re.match(r"^(S\.|Ste|Saint|Sainte|B\.|Bse|Bb\.|Bses|Ss|Saints|N\. ?P\.|Anniversaire|Vigile|Translation|Notre|Tous)", t):
            prec["nom"] += " " + t.strip()
            if l["droite"]: prec["rang"] = rang_de(l["droite"]) or prec["rang"]; prec["fini"] = True
            continue
        nom = t.strip()
        bracket = nom.startswith("[")
        nom = nom.strip("[] ")
        e = {"mmjj": f"{cur_mois:02d}-{cur_jour:02d}", "nom": nom, "rang": rang_de((l["droite"] or "").strip("[] ")) or "",
             "martyrologe": bool(l["ital"]), "romain": bracket, "provinces": [], "fini": bool(l["droite"])}
        cal.append(e); prec = e
    for e in cal:
        e.pop("fini", None)
        e["nom"] = casse_mixte(e["nom"])
    return cal


def casse_mixte(n):
    """Noms du calendrier dont une partie est en petites capitales (« S. THOMAS D’AQUIN, PRÊTRE ET DOCTEUR DE L’ÉGLISE »)."""
    n = corriger(re.sub(r"\s+", " ", n).strip()).replace("Ascenscion", "Ascension").replace("Barhélemy", "Barthélemy")
    if re.search(r"[a-zé]{3}", n.replace("S. ", "")) and not re.match(r"^[A-ZÀ-Ÿ.’' ]{8,}", n): return n
    tete, sep, queue = n.partition(",")
    return casse(tete) + (", " + queue.strip().lower().replace("l’église", "l’Église") if sep else "")


# ── Sections des messes
SECTIONS = [("ouverture", r"^ANTIENNE D\s?’\s?OUVERTURE"), ("communion", r"^ANTIENNE DE LA COMMUNION"),
            ("offrandes", r"^PRIÈRE SUR LES OFFRANDES"), ("apres", r"^PRIÈRE APRÈS LA COMMUNION"),
            ("peuple", r"^PRIÈRE SUR LE PEUPLE"), ("benediction", r"^BÉNÉDICTION SOLENNELLE"),
            ("preface", r"^PRÉFACE"), ("priere", r"^PRIÈRE$")]


def section_de(l):
    t = l["tete"] if l.get("tete") else (l["t"] if l["rouge"] and l["gras"] else "")
    if not t: return None
    for k, rx in SECTIONS:
        if re.match(rx, t.replace(" ’", "’").replace("’ ", "’")): return k
    return None


CONCL = re.compile(r"^(Par (Jésus|le Christ|lui)|Lui qui (vit|règne)|Toi qui (vis|règnes)|Qui vit et règne)")


FIX = [("D ˜ung-La.c", "Dũng-Lạc"), ("Dũng-La.c", "Dũng-Lạc"), ("Dũng-La .c", "Dũng-Lạc"), ("DŨNG-LA . C", "DŨNG-LẠC"), ("Rodzi ´nska", "Rodzińska"), ("Rodzi ´ns", "Rodzińs"), (", Pape", ", pape"), ("110˙000", "110 000")]


def corriger(t):
    for a, b in FIX: t = t.replace(a, b)
    return t


def ligne_texte(t):
    t = corriger(t)
    t = re.sub(r"\b([RV])\.\s*⌉", r"⌉\1.", t)
    t = re.sub(r"(^|(?<=[.!?:;»]) )([RV])\.\s+", lambda m: m.group(1) + m.group(2) + "/ ", t)
    t = t.replace("⌉R.", "R/").replace("⌉ R.", "R/").replace("⌉V.", "V/").replace("⌉ V.", "V/").replace("⌉", "")
    return re.sub(r"\s+", " ", t).strip()


class Section:
    def __init__(self, ref=""):
        self.ref, self.paras, self.cur, self.lastTop, self.lastPage = ref, [], [], None, None

    def ajouter(self, l):
        t = ligne_texte(l["t"])
        if not t: return
        rub = l["rouge"] and not l["gras"]
        if re.match(r"^ou bien\s*:?$", t, re.I):
            self.couper(); self.paras.append(["Ou bien" + (f" — {l['droite']}" if l["droite"] else "")]); return
        if rub:
            self.couper(); self.paras.append(["§" + t]); return
        # nouveau paragraphe : grand blanc, ou conclusion de la prière
        saut = self.lastTop is not None and self.lastPage == l["page"] and l["top"] - self.lastTop > 30
        if self.cur and (saut or CONCL.match(t)): self.couper()
        self.cur.append(t); self.lastTop, self.lastPage = l["top"], l["page"]

    def couper(self):
        if self.cur: self.paras.append(self.cur); self.cur = []

    def fin(self):
        self.couper()
        # rubriques consécutives fusionnées (une consigne coupée en plusieurs lignes)
        out = []
        for p in self.paras:
            if out and p[0].startswith("§") and out[-1][0].startswith("§") and len(out[-1]) == 1 and not re.search(r"[.:]$", out[-1][0]):
                out[-1] = [out[-1][0] + " " + p[0][1:]]
            else: out.append(p)
        r = {"ref": self.ref, "texte": out}
        if getattr(self, "sous", ""): r["sous"] = self.sous
        return r if any(not p[0].startswith("§") for p in out) or out else None


def propre_des_saints(L):
    """→ (preface, saints {mmjj: [...]}, votives [...], communs [...])"""
    debut = next(i for i, l in enumerate(L) if l["t"].startswith("PROPRE DES SAINTS"))
    fin_c = next((i for i, l in enumerate(L) if l["t"].startswith("TABLE")), len(L))
    i_communs = next(i for i, l in enumerate(L) if l["t"] == "COMMUN DES SAINTS")
    saints, votives, communs = {}, [], []
    preface = None
    cur = None            # entrée en cours (saint, préface, commun)
    sec = None; messe = None
    etat = "tete"         # tete (titre, rang), notice, corps
    mois = None
    def fermer_sec():
        nonlocal sec
        if sec and cur is not None and messe is not None:
            k, s = sec
            r = s.fin()
            if r and r["texte"]:
                if k in messe:                                   # deuxième pièce du même nom : alternative
                    messe[k]["texte"] += [["Ou bien" + (f" — {r['ref']}" if r["ref"] else "")]] + r["texte"]
                else: messe[k] = r
        sec = None
    def nouvelle(e, cle):
        nonlocal cur, messe, etat
        fermer_sec()
        cur = e; messe = {}; e["messes"] = [messe]; etat = "tete"
        if cle == "votive": votives.append(e)
        elif cle == "commun": communs.append(e)
        elif cle: saints.setdefault(cle, []).append(e)
    i = debut + 1
    while i < fin_c:
        l = L[i]; t = l["t"]; i += 1
        # préface de l'Ordre (avant janvier)
        if t.startswith("PRÉFACE POUR LES SAINTS") and not saints:
            fermer_sec(); preface = {"titre": "Préface des saints et bienheureux de l’Ordre des Prêcheurs", "sous": "", "texte": []}
            cur = preface; messe = {}; sec = ("preface", Section()); etat = "corps"; continue
        if preface is not None and cur is preface and l["centre"] and re.match(r"^(B IENHEUREUX|BIENHEUREUX|DE L’O|DE L’ORDRE|Esprit)", t):
            if t.startswith("Esprit"): preface["sous"] = t
            continue
        if t.upper() in [m.upper() for m in MOIS] and l["rouge"] and l["centre"]:
            if cur is preface and sec:
                preface["texte"] = sec[1].fin()["texte"]; sec = None; cur = None
            mois = [m.upper() for m in MOIS].index(t.upper()) + 1; continue
        if i - 1 >= i_communs:
            # communs : « COMMUN DES MARTYRS » ; « 1. Pour plusieurs martyrs, hors du temps pascal »
            if re.match(r"^COMMUN DES? ", t) and t != "COMMUN DES SAINTS":
                L_commun[0] = "Commun " + casse(t)[7:].lower().replace("vierge marie", "Vierge Marie"); continue
            m = re.match(r"^(\d+)\.\s+(.*)$", t)
            if m and l["centre"]:
                nouvelle({"commun": L_commun[0], "cas": m.group(2).strip(), "num": m.group(1)}, "commun"); etat = "corps"; continue
            if t == "COMMUN DES SAINTS" or (cur is None or "commun" not in cur):
                continue
        # date d'un saint (rouge, centrée) : « 7 janvier », « Le même jour, 10 janvier », « Un jour au choix en mai »
        md = RX_DATE.search(t)
        if l["rouge"] and l["centre"] and (md and len(t) < 40 or re.match(r"^Un jour au choix", t)):
            if md: cle = f"{MOIS.index(md.group(2).lower()) + 1:02d}-{int(md.group(1)):02d}"
            else: cle = "votive"
            nouvelle({"titre": "", "rang": "", "notice": "", "commun": "", "rubriques": [], "source": "op"}, cle)
            if cle == "votive": cur["date"] = t
            continue
        if cur is None or cur is preface and etat != "corps": continue
        k = section_de(l)
        if k:
            fermer_sec(); etat = "corps"
            if messe is None: messe = {}; cur["messes"] = [messe]
            sec = (k, Section(l["droite"] or ""))
            reste = l["t"][len(l["tete"]):].strip() if l.get("tete") and l["t"].startswith(l["tete"]) else ""
            if k == "preface" and reste: sec[1].sous = reste
            continue
        if etat == "tete":
            r = rang_de(t) if l["rouge"] else None
            if r: cur["rang"] = r; continue
            if (l["centre"] or l["gras"] or l["t"].upper() == l["t"]) and not l["ital"] and not l["rouge"] and not cur["notice"]:
                cur["titre"] = (cur["titre"] + (", " if cur["titre"] and t.upper() == t and cur["titre"].upper() == cur["titre"] else " ") + t).strip()
                continue
            etat = "notice"
        if etat == "notice":
            if l["ital"] and not l["rouge"]:
                cur["notice"] = (cur["notice"] + ("\n" if cur["notice"] and l["left"] - 20 > L_marge(l) else " ") + t).strip(); continue
            if l["rouge"] or (not l["gras"] and not l["ital"] and re.match(r"^\d", t) is None):
                txt = t
                if cur["commun"] or cur["rubriques"] or True:
                    # « Commun des … » et autres consignes ; les numéros de page en noir sont recollés
                    if re.match(r"^Commun|^ou des|^Messe|^ou du", txt) or (cur["commun"] and not re.search(r"[.)]\s*$", cur["commun"])):
                        cur["commun"] = (cur["commun"] + " " + txt).strip()
                    else: cur["rubriques"].append(txt)
                continue
            if l["gras"]:
                # texte dit avant toute section (ex. avertissements) : rubrique
                cur["rubriques"].append(t); continue
            continue
        if etat == "corps" and sec:
            sec[1].ajouter(l)
    fermer_sec()
    # finitions
    def finir(e):
        if e.get("titre"):
            e["titre"] = titre_saint(e["titre"])
        e["notice"] = re.sub(r"-\s+(?=[a-zé])", "", re.sub(r"[ \t]+", " ", e.get("notice", ""))).strip()
        e["commun"] = re.sub(r"-\s+(?=[a-zé])", "", re.sub(r"\s+", " ", e.get("commun", ""))).replace(" )", ")").replace("( ", "(").replace(" ,", ",").strip()
        e["rubriques"] = [re.sub(r"\s+", " ", r) for r in recoller(e.get("rubriques", []))]
        for m in e.get("messes", []):
            for k, v in list(m.items()):
                if not v.get("texte"): m.pop(k)
                else: v["texte"] = nettoyer(v["texte"])
        e["messes"] = [m for m in e.get("messes", []) if m]
    for d in saints.values():
        for e in d: finir(e)
    for e in votives + communs: finir(e)
    if preface and preface.get("texte"): preface["texte"] = nettoyer(preface["texte"])
    return preface, saints, votives, communs


L_commun = [None]
def L_marge(l): return 85 if l["page"] % 2 else 60


def recoller(rs):
    out = []
    for r in rs:
        if out and not re.search(r"[.:;!?»)]$", out[-1]): out[-1] = re.sub(r"-$", "", out[-1]) + ("" if out[-1].endswith("-") else " ") + r
        else: out.append(r)
    return out


def nettoyer(paras):
    out = []
    eclates = []
    for p in paras:
        # dialogue de la préface (V/ … R/ …) à part ; « Ou bien : Préface du 24 mai » = consigne
        cur = []
        for x in p:
            if re.match(r"^Ou bien\s*:\s*\S", x) and not x.startswith("§"):
                if cur: eclates.append(cur); cur = []
                eclates.append(["§" + x]); continue
            if cur and cur[-1].startswith("V/") and not x.startswith("V/"): eclates.append(cur); cur = []
            cur.append(x)
        if cur: eclates.append(cur)
    for p in eclates:
        p = [re.sub(r"\s+([,.;:!?])(?=\s|$)", r"\1", x).replace(" ’", "’") for x in p]
        # rubrique coupée sur plusieurs lignes
        if out and p[0].startswith("§") and out[-1][0].startswith("§") and len(out[-1]) == 1 and not re.search(r"[.:;)]$", out[-1][0]):
            out[-1] = [re.sub(r"-$", "", out[-1][0]) + ("" if out[-1][0].endswith("-") else " ") + p[0][1:]]; continue
        out.append(p)
    return out


def titre_saint(t):
    t = re.sub(r"\s+", " ", t).strip()
    # « SAINT RAYMOND DE PENYAFORT PRÊTRE » (deux lignes en capitales) → « Saint Raymond de Penyafort, prêtre »
    if t.upper() == t:
        parts = t.split(", ") if ", " in t else [t]
        tete = parts[0]
        QUAL = r"\s(PRÊTRES?|VIERGES?|ÉVÊQUE|PAPE|RELIGIEUX|RELIGIEUSE|DIACRE|MÈRE DE FAMILLE|PÈRE DE FAMILLE|MARTYRS?|ET LEURS COMPAGNONS|ET SES COMPAGNONS|ET DOCTEUR|DOCTEUR)\b"
        m = re.search(QUAL, tete)
        if m and len(parts) == 1:
            parts = [tete[:m.start()], tete[m.start() + 1:]]
        return casse(parts[0]) + "".join(", " + p.lower().replace("l’église", "l’Église").replace("n.p.s.", "N.P.S.") for p in parts[1:])
    return t


# ── Lectionnaire
LECT_SEC = [("lecture_1", r"^PREMIÈRE LECTURE"), ("lecture_2", r"^DEUXIÈME LECTURE"), ("psaume", r"^PSAUME"), ("cantique", r"^CANTIQUE"),
            ("alleluia", r"^ALLÉLUIA|^ACCLAMATION"), ("evangile", r"^ÉVANGILE"), ("sequence", r"^SÉQUENCE")]
TITRES_LECT = {"lecture_1": "Première lecture", "lecture_2": "Deuxième lecture", "psaume": "Psaume", "cantique": "Cantique",
               "alleluia": "Acclamation de l’Évangile", "evangile": "Évangile", "sequence": "Séquence"}


def lectionnaire(L):
    jours, cur, sec, etat = {}, None, None, "tete"
    def fermer():
        nonlocal sec
        if sec and cur is not None:
            s = sec
            s["texte"] = nettoyer([p for p in s.pop("_paras") + ([s.pop("_cur")] if s.get("_cur") else []) if p])
            s.pop("_cur", None); s.pop("_last", None)
            if s["texte"] or s.get("refrain"): cur["lectures"].append(s)
        sec = None
    def nouvelle_sec(typ, ref, ou=False):
        nonlocal sec
        fermer()
        sec = {"type": typ, "titre": TITRES_LECT[typ], "sous": "", "intro": "", "ref": ref, "refrain": "", "ou": ou,
               "_paras": [], "_cur": [], "_last": None}
    for l in L:
        t = ligne_texte(l["t"])
        if not t: continue
        if t.upper() in [m.upper() for m in MOIS] and l["rouge"] and l["centre"]: continue
        md = RX_DATE.search(t)
        if l["rouge"] and l["centre"] and md and len(t) < 40:
            fermer()
            cle = f"{MOIS.index(md.group(2).lower()) + 1:02d}-{int(md.group(1)):02d}"
            cur = {"titre": "", "rang": "", "lectures": []}; jours.setdefault(cle, []).append(cur); etat = "tete"; continue
        if cur is None: continue
        tt = t.replace("P REMIÈRE", "PREMIÈRE")
        typ = next((k for k, rx in LECT_SEC if l["rouge"] and re.match(rx, re.sub(r"^(\w) (?=[A-ZÉ])", r"\1", t))), None)
        if typ:
            ref = re.sub(r"\(\s*R\.?\s*⌉?\s*/?\s*\.?\s*:", "(R/ :", l["droite"]).strip() if l["droite"] else ""
            if ref in ("R.", "R/", "R"): ref = ""
            nouvelle_sec(typ, ref); etat = "corps"; continue
        if etat == "tete":
            r = rang_de(t) if l["rouge"] else None
            if r: cur["rang"] = r; continue
            if l["centre"] or t.upper() == t:
                cur["titre"] = (cur["titre"] + (", " if cur["titre"] and not re.search(r"\b(DE|DES|DU|ET)$", cur["titre"]) else " ") + t).strip(); continue
            continue
        if not sec: continue
        # « Ou bien: » : un autre texte au choix pour la même lecture
        if re.match(r"^ou bien\s*:?$", t, re.I) and l["rouge"]:
            typ0, ref0 = sec["type"], l["droite"] or ""
            nouvelle_sec(typ0, ref0, ou=True); continue
        if l["rouge"] and re.match(r"^en Carême", t, re.I):
            sec["_paras"].append(["§" + t]); continue
        if l["ital"] and re.match(r"^«", t) and not sec["_paras"] and not sec["_cur"]:
            sec["sous"] = (sec["sous"] + " " + t).strip(); continue
        if l["ital"] and sec["sous"] and not sec["sous"].endswith("»") and not sec["_paras"] and not sec["_cur"]:
            sec["sous"] += " " + t; continue
        if (re.match(r"^(✠\s*)?(Lecture d|Évangile de|Lecture de|Lecture du|Commencement)", t) or (sec["intro"] and not sec["intro"].endswith((":",)) and not sec["_cur"] and not sec["_paras"] and l["droite"])) and not sec["_cur"] and not sec["_paras"]:
            sec["intro"] = (sec["intro"] + " " + t.replace("✠", "").strip()).strip()
            if l["droite"] and not sec["ref"]: sec["ref"] = l["droite"]
            continue
        if sec["intro"] and not sec["_cur"] and not sec["_paras"] and l["droite"] and not sec["ref"]:
            sec["ref"] = l["droite"]
        if t.startswith("R/") and not sec["refrain"] and sec["type"] == "psaume":
            sec["refrain"] = t[2:].strip(" :"); continue
        if sec["type"] == "psaume" and sec["refrain"] and not sec["_cur"] and not sec["_paras"]:
            if l["gras"]: sec["refrain"] += (" " if re.match(r"^ou\s*:", sec["refrain"].split()[-1] if sec["refrain"] else "") else " ") + t; continue
            if re.match(r"^ou\s*:$", t) and l["rouge"]: sec["refrain"] += " — ou :"; continue
        if t == "R/" or t == "R": continue
        if re.match(r"^– (Parole du Seigneur|Acclamons la Parole de Dieu)", t):
            if sec["_cur"]: sec["_paras"].append(sec["_cur"]); sec["_cur"] = []
            sec["_paras"].append([t]); continue
        saut = sec["_last"] is not None and sec["_last"][0] == l["page"] and l["top"] - sec["_last"][1] > 28
        if saut and sec["_cur"]: sec["_paras"].append(sec["_cur"]); sec["_cur"] = []
        sec["_cur"].append(t); sec["_last"] = (l["page"], l["top"])
    fermer()
    for d in jours.values():
        for e in d: e["titre"] = titre_saint(e["titre"].replace(", ,", ","))
    return jours


def calendrier_offices(cal, provinces=("Province de Toulouse",)):
    """propre_op.json (offices) : les célébrations du calendrier de l'Ordre qui ont un degré, plus les degrés propres à la
    Province de Toulouse (bienheureux « [Province de Toulouse  Mém. facultative] »). Les solennités et fêtes romaines
    signalées entre [ ] (Annonciation, Immaculée, Nativité) restent au calendrier romain."""
    ancien = json.loads(PROPRE.read_text(encoding="utf-8")) if PROPRE.exists() else {}
    RANG = {"mémoire": "mémoire", "mémoire facultative": "mémoire facultative", "fête": "fête", "solennité": "solennité"}
    out = {}
    for e in cal:
        r = e["rang"]
        prov = next((p for p in e["provinces"] if p["province"] in provinces), None)
        if prov and prov["rang"] in RANG: r = prov["rang"]
        if e["romain"] or not r or r not in RANG:
            if re.match(r"^Anniversaire", e["nom"]) and e["mmjj"] != "12-22": r = "anniversaire"
            else: continue
        nom = abreger(e["nom"]).replace("de l’Église dont on ignore", "de l’église dont on ignore")
        # doublon du calendrier romain (même célébration, même jour) : rien de plus pour l'office
        rom = ROMAIN.get(e["mmjj"])
        a = ancien.get(e["mmjj"])
        if rom and mots(rom["nom"]) & mots(nom) and ORDRE_RANG.get(r, 0) <= ORDRE_RANG.get(rom.get("rang"), 0) and not (a and a["rang"] == r):
            continue                                             # même célébration, degré non relevé par l'Ordre
        if a and a["rang"] == r and e["mmjj"] not in out: nom = a["nom"]   # nom déjà en usage (offices, Heures grégoriennes)
        if e["mmjj"] in out:                                     # deux célébrations le même jour : réunies (comme le 9 juillet)
            if out[e["mmjj"]]["rang"] == r and not mots(nom) <= mots(out[e["mmjj"]]["nom"]): out[e["mmjj"]]["nom"] += " ; " + nom
            continue
        # Dédicace de l'église dont on ignore le jour de la consécration : proposée au choix, pas imposée (demande de l'utilisateur, 20/11/2026)
        if e["mmjj"] in AU_CHOIX: r = "mémoire facultative"
        x = {"nom": nom, "rang": r}
        if prov: x["province"] = prov["province"]
        if a and a.get("couleur"): x["couleur"] = a["couleur"]
        elif re.search(r"martyr", e["nom"], re.I): x["couleur"] = "Rouge"
        out[e["mmjj"]] = x
    return dict(sorted(out.items()))


AU_CHOIX = {"10-22"}
ORDRE_RANG = {"mémoire facultative": 1, "anniversaire": 1, "mémoire": 2, "fête": 3, "solennité": 4}
ROMAIN = json.loads((RACINE / "site" / "donnees" / "sanctoral.json").read_text(encoding="utf-8"))


def abreger(n):
    if n.startswith("Saint Nom"): return n
    return re.sub(r"^Saints? ", lambda m: "Ss. " if m.group(0).startswith("Saints") else "S. ", re.sub(r"^Sainte ", "Ste ", n)).replace("N. P. S. ", "S. ")


def sans_accents(x):
    import unicodedata
    return "".join(c for c in unicodedata.normalize("NFD", x.lower()) if unicodedata.category(c) != "Mn")


def mots(x):
    return {w for w in re.split(r"[^a-z]+", sans_accents(x)) if len(w) > 3 and w not in {"saint", "sainte", "saints", "pretre", "pretres", "vierge", "martyr", "martyrs", "eveque", "leurs", "compagnons"}}


def developper(n):
    """« S. Raymond… » → « Saint Raymond… » (titre d'une messe)"""
    n = re.sub(r"^S\. ", "Saint ", n); n = re.sub(r"^Ste ", "Sainte ", n); n = re.sub(r"^Ss\.? ", "Saints ", n)
    n = re.sub(r"^B\. ", "Bienheureux ", n); n = re.sub(r"^Bse ", "Bienheureuse ", n); n = re.sub(r"^Bb\. ", "Bienheureux ", n); n = re.sub(r"^Bses ", "Bienheureuses ", n)
    return n.replace("N. P. S. ", "Notre Père saint ").replace("N.P.S. ", "notre Père saint ")


def rattacher(saints, cal):
    """Titre et degré de chaque messe d'après le calendrier de l'Ordre (même date, le plus de mots en commun)."""
    for d, liste in saints.items():
        cs = [c for c in cal if c["mmjj"] == d]
        for e in liste:
            e.setdefault("rubriques", []); e.setdefault("notice", "")
            texte = e["titre"] or " ".join(e["rubriques"][:1]) or e["notice"][:200]
            best = max(cs, key=lambda c: len(mots(c["nom"]) & mots(texte)), default=None)
            if best is None or (len(cs) > 1 and not mots(best["nom"]) & mots(texte)):
                if not e["titre"] and e["rubriques"]: e["titre"] = titre_saint(e["rubriques"].pop(0))
                continue
            if e["rubriques"] and mots(best["nom"]) & mots(e["rubriques"][0]) and not e["titre"]: e["rubriques"].pop(0)
            e["titre"] = developper(best["nom"])
            if not e["rang"]: e["rang"] = best["rang"]
            if best["provinces"]: e["provinces"] = best["provinces"]
            e["martyrologe"] = best["martyrologe"]


def main():
    LM = lignes(SRC / "missel_OP.pdf")
    cal = calendrier(LM)
    preface, saints, votives, communs = propre_des_saints(LM)
    rattacher(saints, cal)
    lect = lectionnaire(lignes(SRC / "lectionnaire_OP.pdf"))
    rattacher(lect, cal)
    D = {"source": "Propre de l’Ordre des Prêcheurs — Missel et Lectionnaire, édition partielle et provisoire (juin 2026)",
         "calendrier": cal, "preface": preface, "saints": dict(sorted(saints.items())), "votives": votives, "communs": communs, "lectures": dict(sorted(lect.items()))}
    SORTIE.write_text(json.dumps(D, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    if "--sans-calendrier" not in sys.argv:
        PROPRE.write_text(json.dumps(calendrier_offices(cal), ensure_ascii=False, indent=1), encoding="utf-8")
    n = sum(len(v) for v in saints.values())
    print(f"calendrier : {len(cal)} entrées ; saints : {n} ({len(saints)} dates) ; votives : {len(votives)} ; communs : {len(communs)} ; "
          f"lectures : {sum(len(v) for v in lect.values())} jours ; {SORTIE.stat().st_size // 1024} Ko")


if __name__ == "__main__":
    main()
