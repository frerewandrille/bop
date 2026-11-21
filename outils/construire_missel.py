#!/usr/bin/env python3
"""Propres du Missel romain (temporal) → site/donnees/missel.json

Sources : sources_missel/MR Temporal 0x … .docx (Drive LITURGIE/01-Missel-et-Eucharistie/Missel-romain/01-temporal),
lues par textutil (html) : ce qui se dit est en gras, les consignes et les intitulés en rouge, les lettrines en très
grande taille. On garde, pour chaque messe : antienne d'ouverture, prière (collecte), prière sur les offrandes,
antienne de la communion, prière après la communion, prière sur le peuple. Les signes de chant (* + /) sont gardés.

missel.json = { cles: { "<clé>": [ {titre, ouverture:{ref, texte}, priere, offrandes, communion:{ref, texte},
                apres, peuple} ...une par messe ] } }  ; texte = [paragraphes [lignes]].
Clés : avent-S-J, avent-12-17…24, noel, sainte-famille, noel-12-29…31, marie-mere-de-dieu, noel-dimanche-2,
epiphanie, bapteme, careme-S-J (0 = après les Cendres, 6 = Semaine sainte), paques-S-J (8-0 = Pentecôte),
ascension, ordinaire-N (messe de la semaine N), trinite, saint-sacrement, sacre-coeur, christ-roi.
"""
import html, json, re, shutil, subprocess, tempfile
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
SRC = RACINE / "sources_missel"
SORTIE = RACINE / "site" / "donnees" / "missel.json"
FICHIERS = [("ordinaire", "MR Temporal 00 Temps Ordinaire.docx"), ("avent", "MR Temporal 01 Avent.docx"),
            ("noel", "MR Temporal 02 Noel.docx"), ("careme", "MR Temporal 03 Careme.docx"),
            ("triduum", "MR Temporal 04 Triduum Pascal.docx"), ("paques", "MR Temporal 05 Temps Pascal.docx")]

SECTIONS = [("ouverture", r"antienne d.?ouverture"), ("offrandes", r"p?ri[èe]re sur les offrandes"),
            ("communion", r"antienne de (la )?communion"), ("apres", r"pri[èe]re apr[èe]s la co\s?mmunion"),
            ("peuple", r"pri[èe]re sur le peuple"), ("priere", r"pri[èe]re(\s+d.ouverture)?\s*$"),
            ("_preface", r"pr[ée]face"), ("_autre", r"(liturgie|b[ée]n[ée]diction|rite|procession|entr[ée]e|lectures?|psaume|[ée]vangile|hymne|litanie|onction|lavement|adoration|communion$|annonce)")]
JOURS = {"DIMANCHE": 0, "LUNDI": 1, "MARDI": 2, "MERCREDI": 3, "JEUDI": 4, "VENDREDI": 5, "SAMEDI": 6}
ORD = {"PREMIER": 1, "PREMIÈRE": 1, "DEUXIÈME": 2, "TROISIÈME": 3, "QUATRIÈME": 4, "CINQUIÈME": 5, "SIXIÈME": 6, "SEPTIÈME": 7}
ROM = {"I": 1, "V": 5, "X": 10}


def romain(s):
    n = 0
    for i, c in enumerate(s):
        v = ROM[c]; n += -v if i + 1 < len(s) and ROM[s[i + 1]] > v else v
    return n


def lire_html(docx):
    tmp = Path(tempfile.mkdtemp())
    try:
        shutil.copy(docx, tmp / "f.docx")
        subprocess.run(["textutil", "-convert", "html", "-output", str(tmp / "f.html"), str(tmp / "f.docx")], check=True)
        return (tmp / "f.html").read_text(encoding="utf-8")
    finally:
        shutil.rmtree(tmp)


def paragraphes(s):
    """→ [{t, gras, rouge, taille, centre}] (t avec \\n pour les retours à la ligne)."""
    def rouge(css):
        m = re.search(r"color: #([0-9a-f]{6})", css)
        if not m: return False
        r, g_, b = (int(m.group(1)[i:i + 2], 16) for i in (0, 2, 4))
        return r >= 0xa0 and g_ < 0x50 and b < 0x50
    styles = {}
    for nom, corps in re.findall(r"p\.(p\d+) \{([^}]*)\}", s):
        m = re.search(r"font: ([\d.]+)px", corps)
        styles[nom] = {"rouge": rouge(corps), "taille": float(m.group(1)) if m else 16, "centre": "text-align: center" in corps}
    spans = {nom: corps for nom, corps in re.findall(r"span\.(s\d+) \{([^}]*)\}", s)}
    span_rouge = {nom for nom, corps in spans.items() if rouge(corps)}
    out = []
    for cls, corps in re.findall(r'<p class="(p\d+)">(.*?)</p>', s, re.S):
        st = styles.get(cls, {"rouge": False, "taille": 16, "centre": False})
        gras = bool(re.search(r"<b>[^<\s]", corps)) or bool(re.search(r"<b>\s*\S", re.sub(r"<span[^>]*>", "", corps)))
        taille = st["taille"]
        for sc in re.findall(r'<span class="(s\d+)">', corps):
            m = re.search(r"font: ([\d.]+)px", spans.get(sc, ""))
            if m: taille = max(taille, float(m.group(1)))
        t = re.sub(r'<span class="Apple-(tab|converted)-span">(.*?)</span>', lambda m: " " if m.group(1) == "converted" else "\t", corps)
        t = re.sub(r"<br>", "\n", t)
        t = html.unescape(re.sub(r"<[^>]+>", "", t))
        t = "\n".join(re.sub(r"[  ]+", " ", x).strip() for x in t.split("\n")).strip()
        # rouge aussi quand tout le texte est dans des passages en rouge (fichier du temps ordinaire)
        hors_rouge = re.sub(r'<span class="(%s)">.*?</span>' % "|".join(span_rouge or {"_"}), "", corps, flags=re.S)
        tout_rouge = bool(span_rouge) and not html.unescape(re.sub(r"<[^>]+>", "", hors_rouge)).strip()
        if t: out.append({"t": t, "gras": gras, "rouge": st["rouge"] or tout_rouge, "taille": taille, "centre": st["centre"]})
    return out


def cle_du_titre(t, temps, ctx):
    """Titre de jour (majuscules) → clé, selon le fichier."""
    T = re.sub(r"\s+", " ", t.upper().replace("’", "'")).strip()
    m = re.match(r"^(PREMIER|DEUXIÈME|TROISIÈME|QUATRIÈME|CINQUIÈME|SIXIÈME|SEPTIÈME) DIMANCHE (DE L'AVENT|DU CARÊME|DE PÂQUES)", T)
    if m: return {"DE L'AVENT": "avent", "DU CARÊME": "careme", "DE PÂQUES": "paques"}[m.group(2)] + f"-{ORD[m.group(1)]}-0"
    m = re.match(r"^(LUNDI|MARDI|MERCREDI|JEUDI|VENDREDI|SAMEDI) DE LA (PREMIÈRE|DEUXIÈME|TROISIÈME|QUATRIÈME|CINQUIÈME|SIXIÈME|SEPTIÈME) SEMAINE", T)
    if m and temps in ("avent", "careme", "paques"): return f"{temps}-{ORD[m.group(2)]}-{JOURS[m.group(1)]}"
    m = re.match(r"^(LUNDI|MARDI|MERCREDI|JEUDI|VENDREDI|SAMEDI) DANS L'OCTAVE DE PÂQUE", T)
    if m: return f"paques-1-{JOURS[m.group(1)]}"
    m = re.match(r"^(LUNDI|MARDI|MERCREDI|JEUDI|VENDREDI|SAMEDI) DANS LE TEMPS DE NOËL", T)
    if m: return f"noel-ferie-{JOURS[m.group(1)]}"
    m = re.match(r"^(JEUDI|VENDREDI|SAMEDI) APRÈS LES CENDRES", T)
    if m: return f"careme-0-{JOURS[m.group(1)]}"
    m = re.match(r"^(LUNDI|MARDI|MERCREDI|JEUDI) DE LA SEMAINE SAINTE", T)
    if m: return f"careme-6-{JOURS[m.group(1)]}"
    m = re.match(r"^(\d{1,2}) DÉCEMBRE$", T)
    if m and temps == "avent": return f"avent-12-{int(m.group(1)):02d}"
    m = re.match(r"^([5-7])E JOUR DANS L'OCTAVE", T)
    if m: return f"noel-12-{24 + int(m.group(1)):02d}"
    m = re.match(r"^([IVX]+)(?:RE|E) (DIMANCHE|SEMAINE) DU TEMPS ORDINAIRE", T)
    if m: return f"ordinaire-{romain(m.group(1))}"
    simples = [("MERCREDI DES CENDRES", "careme-0-3"), ("DIMANCHE DES RAMEAUX", "careme-6-0"), ("NATIVITÉ DU SEIGNEUR", "noel"),
               ("LA SAINTE FAMILLE", "sainte-famille"), ("SOLENNITÉ DE SAINTE MARIE MÈRE DE DIEU", "marie-mere-de-dieu"),
               ("DEUXIÈME DIMANCHE APRÈS LA NATIVITÉ", "noel-dimanche-2"), ("ÉPIPHANIE DU SEIGNEUR", "epiphanie"),
               ("BAPTÊME DU SEIGNEUR", "bapteme"), ("JEUDI SAINT", "careme-6-4"), ("VENDREDI SAINT", "careme-6-5"),
               ("DIMANCHE DE PÂQUES", "paques-1-0"), ("ASCENSION DU SEIGNEUR", "ascension"), ("DIMANCHE DE LA PENTECÔTE", "paques-8-0"),
               ("LA SAINTE TRINITÉ", "trinite"), ("LE SAINT-SACREMENT", "saint-sacrement"), ("LE SACRÉ CŒUR", "sacre-coeur"),
               ("LE CHRIST ROI", "christ-roi")]
    for debut, cle in simples:
        if T.startswith(debut): return cle
    return None


MESSES = re.compile(r"^(MESSE (DE LA VEILLE AU SOIR|DE LA NUIT|DE L'AURORE|DU JOUR( DE PÂQUES)?|DU MATIN|CHRISMALE|DU SOIR|EN MÉMOIRE DE LA CÈNE.*)|VIGILE PASCALE|CÉLÉBRATION DE LA PASSION.*)", re.I)


def extraire(temps, fichier):
    P = paragraphes(lire_html(SRC / fichier))
    cles, cle, messe, sec, lettrine = {}, None, None, None, ""
    for p in P:
        t = p["t"]
        if p["taille"] >= 30 and len(t) <= 2:                       # lettrine
            lettrine = t; continue
        premiere = t.split("\n")[0]
        sans_ord = re.sub(r"(?<=[IVX0-9])(re|er|e)\b", "", premiere)
        titre_possible = not p["rouge"] and sans_ord.upper() == sans_ord and len(premiere) < 120 and \
            (p["gras"] and (p["centre"] or p["taille"] >= 17) or cle_du_titre(premiere, temps, cle))
        if titre_possible:
            k = cle_du_titre(premiere, temps, cle)
            if k:
                cle = k; messe = {"titre": None}; cles.setdefault(cle, []).append(messe); sec = None; continue
            if MESSES.match(premiere.replace("’", "'")) and cle:
                if any(v for kk, v in messe.items() if kk != "titre"):
                    messe = {"titre": None}; cles[cle].append(messe)
                tt = premiere[0] + premiere[1:].lower()
                for mot in ("Seigneur", "Pâques", "Cène", "Passion"): tt = re.sub(mot.lower(), mot, tt)
                messe["titre"] = tt; sec = None; continue
        # intitulé de section (rouge)
        if p["rouge"]:
            lib = re.sub(r"^\d+\.\s*", "", premiere)
            found = next((nom for nom, rx in SECTIONS if re.match(rx, lib, re.I)), None)
            if found:
                sec = None if found.startswith("_") else found
                if sec and cle:
                    ref = re.sub(r"^.*?(antienne d.?ouverture|antienne de (la )?communion)\s*", "", lib, flags=re.I).strip() if sec in ("ouverture", "communion") else ""
                    messe[sec] = {"ref": ref, "texte": []}
                continue
            m = re.match(r"^ou bien\s*(.*)$", lib, re.I)
            if m and sec in ("ouverture", "communion") and cle:          # autre antienne au choix
                messe[sec]["texte"].append(["Ou bien" + (" — " + m.group(1).strip() if m.group(1).strip() else "")])
            continue                                                   # autre consigne en rouge
        # intitulé collé au texte, en noir (« ANTIENNE D'OUVERTURE … » suivi de l'antienne dans le même paragraphe)
        mh = re.match(r"^(antienne d.?ouverture|antienne de (la )?communion)\s*(.*)$", premiere, re.I)
        if mh and cle and p["gras"]:
            sec = "ouverture" if mh.group(1).lower().startswith("antienne d") and "communion" not in mh.group(1).lower() else "communion"
            messe[sec] = {"ref": mh.group(3).strip(), "texte": []}
            reste = [l for l in t.split("\n")[1:] if l]
            if reste: messe[sec]["texte"].append(reste)
            continue
        if sec and cle and p["gras"]:
            texte = (lettrine + t) if lettrine else t
            lettrine = ""
            texte = re.sub(r"^R/\.\s*", "R/. ", texte)
            messe[sec]["texte"].append([l for l in texte.split("\n") if l])
        elif not p["gras"]:
            lettrine = lettrine if p["taille"] >= 30 else ""
    # nettoyage : messes vides, sections vides
    out = {}
    for k, ms in cles.items():
        ms2 = []
        for m in ms:
            m = {kk: v for kk, v in m.items() if kk == "titre" or (v and v["texte"])}
            if len(m) > 1: ms2.append(m)
        if ms2: out[k] = ms2
    if "paques-1-0" in out and len(out["paques-1-0"]) > 1 and not out["paques-1-0"][0]["titre"]:
        out["paques-1-0"][0]["titre"] = "Vigile pascale"
    return out


# ── Sanctoral (Missel romain, propre des saints ; propre de France)
MOIS = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"]
DATE = re.compile(r"^(?:Le même jour\s*\()?(1er|\d{1,2})\s+(" + "|".join(MOIS) + r")\)?\s*$", re.I)
SANCTORAL = [(f"MR Sanctoral {i:02d} {m}.docx", "romain") for i, m in enumerate(
    ["janvier", "F‚vrier", "Mars", "Avril", "Mai", "Juin", "juillet", "Ao–t", "Septembre", "Octobre", "Novembre", "D‚cembre"], 1)] \
    + [("Propre de France.docx", "France")]


def extraire_sanctoral(chemin, source):
    P = paragraphes(lire_html(chemin))
    out, ent, messe, sec, lettrine, attente = {}, None, None, None, "", None
    for p in P:
        t = p["t"]; prem = t.split("\n")[0].strip()
        if len(prem) > 10 and set(prem) <= set("-–— "):            # séparateur entre deux saints
            sec = None; continue
        m = DATE.match(prem)
        if m and len(t) < 40:
            j = 1 if m.group(1) == "1er" else int(m.group(1)); mo = MOIS.index(m.group(2).lower()) + 1
            ent = {"titre": None, "rang": None, "notice": None, "commun": None, "source": source, "messes": []}
            out.setdefault(f"{mo:02d}-{j:02d}", []).append(ent)
            messe = {"titre": None}; ent["messes"].append(messe); sec = None; attente = "titre"; lettrine = ""
            continue
        if ent is None: continue
        if attente == "titre" and not p["rouge"]:
            ent["titre"] = " ".join(t.split()); attente = "rang"; continue
        if attente == "rang":
            if re.match(r"^(Solennité|Fête|Mémoire)", prem):
                ent["rang"] = prem; attente = "notice"; continue
            if re.match(r"^Patron", prem):
                ent["titre"] += " — " + prem; continue
            if p["gras"] and not p["rouge"] and prem.upper() == prem and len(prem) < 80:   # titre sur deux lignes
                ent["titre"] += " " + " ".join(t.split()); continue
            attente = "notice"
        if p["taille"] >= 30 and len(t) <= 2:
            lettrine = t; continue
        sup = re.sub(r"^\d+\.\s*", "", prem)
        if re.match(r"^(PREMIÈRE|DEUXIÈME|TROISIÈME|AUTRE) MESSE|^MESSE (DE LA VEILLE|DU JOUR|DE LA NUIT|DU MATIN)", sup, re.I):
            if any(k != "titre" for k in messe):
                messe = {"titre": None}; ent["messes"].append(messe)
            messe["titre"] = sup[0] + sup[1:].lower(); sec = None; continue
        if p["rouge"]:
            if re.match(r"^Commun", sup):
                ent["commun"] = " ".join(t.split()); continue
            found = next((nom for nom, rx in SECTIONS if re.match(rx, sup, re.I)), None)
            if found:
                sec = None if found.startswith("_") else found
                if sec:
                    ref = re.sub(r"^.*?(antienne d.?ouverture|antienne de (la )?communion)\s*", "", sup, flags=re.I).strip() if sec in ("ouverture", "communion") else ""
                    messe[sec] = {"ref": ref, "texte": []}
                continue
            mo2 = re.match(r"^ou bien\s*(.*)$", sup, re.I)
            if mo2 and sec in ("ouverture", "communion"):
                messe[sec]["texte"].append(["Ou bien" + (" — " + mo2.group(1).strip() if mo2.group(1).strip() else "")])
            continue
        mh = re.match(r"^(antienne d.?ouverture|antienne de (la )?communion)\s*(.*)$", prem, re.I)
        if mh and p["gras"]:
            sec = "communion" if "communion" in mh.group(1).lower() else "ouverture"
            messe[sec] = {"ref": mh.group(3).strip(), "texte": []}
            reste = [l for l in t.split("\n")[1:] if l]
            if reste: messe[sec]["texte"].append(reste)
            continue
        if attente == "notice" and not p["gras"]:
            ent["notice"] = " ".join(t.split()); attente = None; continue
        if sec and p["gras"]:
            texte = (lettrine + t) if lettrine else t
            lettrine = ""
            texte = re.sub(r"^R/\.\s*", "R/. ", texte)
            messe[sec]["texte"].append([l for l in texte.split("\n") if l])
    # ménage : messes et entrées sans texte (« Voir au Propre des saints »)
    for k in list(out):
        garde = []
        for e in out[k]:
            e["messes"] = [{kk: v for kk, v in m.items() if kk == "titre" or (v and v["texte"])} for m in e["messes"]]
            e["messes"] = [m for m in e["messes"] if len(m) > 1]
            if e.get("titre"): e["titre"] = casse(e["titre"])
            if e["messes"]: garde.append({kk: v for kk, v in e.items() if v})
        if garde: out[k] = garde
        else: del out[k]
    return out


PETITS = {"de", "du", "des", "la", "le", "les", "et", "en", "à", "au", "aux", "sur", "dans", "ou"}


def casse(titre):
    """« SAINT THOMAS D’AQUIN, prêtre » → « Saint Thomas d’Aquin, prêtre » (seule la partie avant la virgule est en capitales)."""
    tete, _, queue = titre.partition(",")
    if tete.upper() != tete: return titre
    mots = []
    for i, w in enumerate(tete.lower().split()):
        m = re.match(r"^([dl]’|[dl]')(.+)$", w)
        if m: mots.append(m.group(1) + m.group(2)[:1].upper() + m.group(2)[1:]); continue
        mots.append(w if (i and w in PETITS) else "-".join(x[:1].upper() + x[1:] for x in w.split("-")))
    queue = queue.lower() if queue.upper() == queue else queue
    return " ".join(mots) + ("," + queue if _ else "")


def sanctoral():
    tout = {}
    for f, source in SANCTORAL:
        c = extraire_sanctoral(SRC / "sanctoral" / f, source)
        n = sum(len(v) for v in c.values())
        print(f"{f:48} {n:3} saints")
        for k, v in c.items(): tout.setdefault(k, []).extend(v)
    return dict(sorted(tout.items()))


# ── Communs (Missel romain) : commun › partie (I., II.) › cas (A., B.) › formulaire (1, 2, 3)
def extraire_communs():
    P = paragraphes(lire_html(SRC / "communs" / "MR Communs.docx"))
    forms, cur, ctx, sec, lettrine = [], None, {"commun": None, "partie": None, "cas": None, "num": None}, None, ""
    def nouveau():
        nonlocal cur
        cur = {**ctx, "messe": {}}; forms.append(cur)
    for p in P:
        t = p["t"]; prem = t.split("\n")[0].strip()
        if p["taille"] >= 30 and len(t) <= 2:
            lettrine = t; continue
        if not p["rouge"] and not p["gras"] and re.match(r"^Commun (de|des|du) ", prem) and len(prem) < 80:
            ctx = {"commun": prem, "partie": None, "cas": None, "num": None}; cur = None; sec = None; continue
        if not p["rouge"] and re.match(r"^(I|II|III|IV|V|VI)\.\s+[A-ZÉÈ]", prem) and prem.upper() == prem:
            ctx = {**ctx, "partie": casse(prem.split(". ", 1)[1]), "cas": None, "num": None}; cur = None; sec = None; continue
        if p["rouge"] and p["centre"] and re.match(r"^[A-E]\.\s", prem):
            ctx = {**ctx, "cas": prem.split(". ", 1)[1].rstrip(". "), "num": None}; cur = None; sec = None; continue
        if p["gras"] and p["centre"] and re.fullmatch(r"\d{1,2}", prem):
            ctx = {**ctx, "num": prem}; nouveau(); sec = None; continue
        if p["rouge"]:
            lib = re.sub(r"^\d+\.\s*", "", prem)
            found = next((nom for nom, rx in SECTIONS if re.match(rx, lib, re.I)), None)
            if found:
                sec = None if found.startswith("_") else found
                if sec:
                    if cur is None or sec in cur["messe"]: nouveau()
                    ref = re.sub(r"^.*?(antienne d.?ouverture|antienne de (la )?communion)\s*", "", lib, flags=re.I).strip() if sec in ("ouverture", "communion") else ""
                    cur["messe"][sec] = {"ref": ref, "texte": []}
                continue
            mo = re.match(r"^ou bien\s*(.*)$", lib, re.I)
            if mo and sec in ("ouverture", "communion") and cur:
                cur["messe"][sec]["texte"].append(["Ou bien" + (" — " + mo.group(1).strip() if mo.group(1).strip() else "")])
            continue
        if sec and cur and p["gras"]:
            texte = (lettrine + t) if lettrine else t
            lettrine = ""
            cur["messe"][sec]["texte"].append([l for l in re.sub(r"^R/\.\s*", "R/. ", texte).split("\n") if l])
    out = []
    for f in forms:
        m = {k: v for k, v in f["messe"].items() if v["texte"]}
        if m: out.append({k: v for k, v in f.items() if k != "messe" and v} | {"messe": m})
    return out


# ── Ordinaire de la messe : Gloria et Credo (français, latin)
def extraire_ordinaire():
    P = paragraphes(lire_html(SRC / "ordinaire" / "missel-romain-nouvelle-traduction-liturgiedelamesse--v4-pourmalvoyant.docx"))
    T = [p["t"] for p in P]
    def depuis(debut, fin):
        i = next(n for n, t in enumerate(T) if t.startswith(debut))
        j = next(n for n in range(i + 1, len(T)) if T[n].startswith(fin))
        return [[l for l in t.split("\n") if l] for t in T[i:j]]
    def rub(blocs):        # consigne glissée dans le texte (« Aux mots qui suivent, tous s'inclinent… »)
        return [[("§" + l if l.startswith("Aux mots qui suivent") else l) for l in b] for b in blocs]
    return {
        "gloria": {"fr": depuis("Gloire à Dieu, au plus haut", "Ou bien"), "la": depuis("Glória in excélsis", "Prière d’ouverture")},
        "credo": {"fr": rub(depuis("Je crois en un seul Dieu", "Ou bien")), "la": rub(depuis("Credo in unum Deum", "19."))},
    }


# ── Livrets du Triduum (« Missel et lectionnaire », AELF 2014) et fascicules de la Passion à plusieurs voix
# Les couleurs n'y sont pas toujours gardées : consignes et paroles se reconnaissent à leur forme.
CONSIGNE = re.compile(r"^(Le prêtre|Le diacre|Les diacres|Le ou les|Les fidèles|Les ministres|La |Le peuple|L’évêque|L'évêque|On |Tous |Puis|Ensuite|Après|Pendant|Lorsque|Quand|Là où|S’il|S'il|Si |Au |Avant|Il |Elle |Dès|Le chant|Pour |À |Cette|Selon|Toutefois|Que les|Celui|Chacun|Le célébrant|Les autres|Le chantre|Le lecteur|Un |Une |Les |Dans |Ou bien :|Ou :|Là |Aux mots|Inclinés|Debout|Comme|Ici|En |Par )")
ROLE = re.compile(r"^(L|D|F|A|X|✠)\.\s*\t?(.*)$", re.S)


def blocs_livret(P, debut=0, fin=None):
    out, lettrine, notes, dernier = [], "", True, 0   # dernier : n° de la dernière consigne ou section (ils croissent)
    for p in P[debut:fin]:
        t = p["t"].strip(); prem = t.split("\n")[0].strip()
        if not t: continue
        if p["taille"] >= 30 and len(t) <= 2: lettrine = t; continue
        if p["taille"] >= 30: continue                                         # titre du livret
        if lettrine: t = lettrine + t; prem = t.split("\n")[0]; lettrine = ""
        if re.fullmatch(r"_{5,}", prem): out.append({"type": "trait"}); continue
        m = re.match(r"^(\d{1,3})\.\s*\t+\s*(.*)$", t, re.S)
        if m and int(m.group(1)) <= dernier and p["gras"]:       # numérotation interne (acclamations du cierge pascal)
            out.append({"type": "texte", "lignes": [m.group(1) + ". " + m.group(2).replace("\t", " ")], "gras": True}); continue
        if m: dernier = int(m.group(1))
        if m and p["gras"] and len(t) < 300:
            titre, _, ref = m.group(2).partition("\t")
            if "\n" in titre: titre, _, suite = titre.partition("\n"); ref = (suite + " " + ref).strip()
            titre = re.sub(r"[^\w)»!?.’']+$", "", titre.strip())          # filets de mise en page (═══) en fin de titre
            out.append({"type": "section", "titre": titre, "ref": re.sub(r"\s+", " ", ref).strip()}); notes = False; continue
        if m:
            out.append({"type": "rubrique", "texte": re.sub(r"\s+", " ", m.group(2)), "notes": notes}); continue
        if p["rouge"] and not p["gras"]:
            out.append({"type": "rubrique", "texte": re.sub(r"\s+", " ", t), "notes": notes}); continue
        mr = ROLE.match(t)
        if mr:
            out.append({"type": "role", "role": mr.group(1), "lignes": [l for l in mr.group(2).split("\n") if l.strip()]}); continue
        if t.startswith("«") and out and out[-1].get("type") == "role" and out[-1]["role"] == "L" and out[-1]["lignes"][-1].rstrip().endswith(":"):
            out.append({"type": "role", "role": "✠", "lignes": [l for l in t.split("\n") if l.strip()]}); continue
        if p["gras"] and prem.upper() == prem and len(prem) < 60 and "\n" not in t and not re.match(r"^R/", prem):
            out.append({"type": "intertitre", "texte": prem.capitalize()}); continue
        if len(t) < 70 and "\n" not in t and not re.search(r"[.:;,!?»…]$", t) and not re.match(r"^(R/|V/|«|–)", t):
            out.append({"type": "intertitre", "texte": t}); notes = notes and not re.match(r"^(Rites|Première partie|Liturgie|Ouverture)", t); continue
        if "\n" not in t and (t in ("Ou bien :", "Ou :") or (t.endswith(":") and len(t) < 120 and CONSIGNE.match(t[0].upper() + t[1:]) and not t.startswith("«"))):
            out.append({"type": "rubrique", "texte": t, "notes": notes}); continue
        if "\n" not in t and len(t) > 30 and (CONSIGNE.match(t) or re.match(r"^Le prêtre", t, re.I)) and not t.startswith(("Au nom du Père", "Le Seigneur soit", "La grâce", "Que la grâce", "La paix soit", "Par Jésus", "Par le Christ")):
            out.append({"type": "rubrique", "texte": t, "notes": notes}); continue
        lignes = [("✠ " + l if l.startswith("= Jésus") else l) for l in t.split("\n") if l.strip()]
        out.append({"type": "texte", "lignes": lignes, "gras": p["gras"]})
    return out


def extraire_livrets():
    L = {}
    for cle, f in [("cene", "missel-et-lectionnaire-messe-en-memoire-de-la-cene-du-seigneur.docx"),
                   ("passion", "missel-et-lectionnaire-office-de-la-passion.docx"),
                   ("vigile", "missel-et-lectionnaire-vigile-pascale.docx")]:
        L[cle] = blocs_livret(paragraphes(lire_html(SRC / "triduum" / f)))
    # Passion à plusieurs voix (Rameaux, années A, B, C) : de « La Passion … selon saint X » jusqu'au récit suivant
    P = {}
    for f, ordre in [("livret-evangiles-de-la-passion-matthieu-et-jean.docx", ["A", None]),
                     ("livret-evangiles-de-la-passion-marc-et-luc.docx", ["B", "C"])]:
        par = paragraphes(lire_html(SRC / "triduum" / f))
        debuts = [n for n, p in enumerate(par) if p["gras"] and p["t"].startswith("La Passion de notre Seigneur")]
        for k, d in enumerate(debuts):
            if k < len(ordre) and ordre[k]:
                fin = debuts[k + 1] if k + 1 < len(debuts) else None
                # le titre de la suivante commence quelques paragraphes avant (« LA PASSION », acclamation…)
                if fin is not None:
                    while fin > d + 1 and not par[fin - 1]["t"].startswith(("LA PASSION", "LA PASSION\n")): fin -= 1
                    fin -= 1
                b = blocs_livret(par, d + 1, fin)
                fin_b = next((n for n, x in enumerate(b) if x["type"] == "texte" and "Acclamons la Parole de Dieu" in " ".join(x["lignes"])), None)
                P[ordre[k]] = b[:fin_b + 1] if fin_b is not None else b
    return L, P


def main():
    tout = {}
    for temps, f in FICHIERS:
        c = extraire(temps, f)
        for k, v in c.items():
            if k in tout: tout[k].extend(v)
            else: tout[k] = v
        print(f"{f:48} {len(c):3} jours")
    # contrôle : ce qui manque à chaque messe
    manque = {k: [s for s in ("ouverture", "priere", "offrandes", "communion", "apres") if not any(s in m for m in v)] for k, v in tout.items()}
    manque = {k: v for k, v in manque.items() if v}
    saints = sanctoral()
    communs = extraire_communs()
    print(f"communs : {len(communs)} formulaires")
    ordinaire = extraire_ordinaire()
    livrets, passions = extraire_livrets()
    from missel_liturgie import extraire as extraire_liturgie
    liturgie = extraire_liturgie()
    print("liturgie de la messe :", {c["id"]: sum(len(g["pieces"]) for g in c["groupes"]) for c in liturgie})
    print("livrets :", {k: len(v) for k, v in livrets.items()}, "passions :", {k: len(v) for k, v in passions.items()})
    SORTIE.write_text(json.dumps({"source": "Missel romain (temporal, propre des saints, propre de France), fichiers du Drive LITURGIE",
                                  "cles": tout, "saints": saints, "communs": communs, "ordinaire": ordinaire,
                                  "livrets": livrets, "passions": passions, "liturgie": liturgie}, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    print(f"sanctoral : {len(saints)} dates, {sum(len(v) for v in saints.values())} saints")
    print(f"{SORTIE.relative_to(RACINE)} : {len(tout)} jours ; incomplets : {len(manque)}")
    for k, v in sorted(manque.items()): print("  ", k, v)


if __name__ == "__main__":
    main()
