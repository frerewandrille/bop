"""Communs des saints d'après « Les Heures grégoriennes » (tome III) : table prête pour le site.

    python3 outils/construire_communs.py
      lit   partitions/hg/offices.json (outils/construire_offices_latins.py) et le texte du tome III
      écrit partitions/hg/communs.json

Pourquoi un fichier à part : dans offices.json, « plusieurs martyrs » et « plusieurs saints » sont rangés
ensemble (clé C/autre), et quelques pièces de la première page d'un commun sont restées sous le commun
précédent. Ici chaque pièce est rattachée à son commun par sa page (titres courants du livre).

Sortie : {
  "communs": [{id, nom, offices: [...], precisions: [...]}],
  "offices": {"<id>|<office>": {                       office : vepres1 | laudes | milieu | vepres2 | vepres
      hymne:  [segment], antiennes: [{n, segments, ps}], psaumes: [ref], lecture: [segment+ref],
      repons: [segment], evangelique: [segment], preces: [segment], oraison: [segment],
      milieu: [{ref, texte, verset}]  (tierce, sexte, none) }},
  "brut": {"<id>|<office>": [éléments tels que dans offices.json]}   (version latin-français)
}
segment = {texte: [lignes], tp: true|false|null, pour: "un évêque"|null, temps: "careme"|…|null}

Usage privé : le livre porte « Tous droits réservés » ; ce fichier reste avec les partitions (site protégé).
"""
from __future__ import annotations
import json
import re
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
HG = RACINE / "partitions" / "hg"
T3 = RACINE / "sources_gouzes" / "heures-gregoriennes" / "t3.txt"

# commun : (mot du titre courant latin, nom français)
COMMUNS = [
    ("dedicace", "DEDICATIONIS", "Dédicace d'une église"),
    ("vierge-marie", "BEATÆ MARIÆ", "Vierge Marie"),
    ("apotres", "APOSTOLORUM", "Apôtres"),
    ("martyrs", "PLURIMORUM MARTYRUM", "Plusieurs martyrs"),
    ("martyr", "UNIUS MARTYRIS", "Un martyr"),
    ("pasteurs", "PASTORUM", "Pasteurs"),
    ("docteurs", "DOCTORUM", "Docteurs de l'Église"),
    ("vierges", "VIRGINUM", "Vierges"),
    ("saints", "SANCTORUM VIRORUM", "Saints"),
    ("saintes", "SANCTARUM MULIERUM", "Saintes"),
    ("plusieurs-saints", "PLURIMORUM SANCTORUM", "Plusieurs saints"),
    ("defunts", "DEFUNCTORUM", "Défunts"),
]


def pages_des_communs():
    """Page (numérotation du PDF) → id du commun, d'après les titres courants latins du tome III."""
    pages = open(T3, encoding="utf-8").read().split("\f")
    debut = {}
    seul = None     # page de titre « COMMUNE » seule (le nom du commun est plus bas) : vaut pour le commun suivant
    for i, p in enumerate(pages):
        lignes = [l.strip() for l in p.split("\n") if l.strip()][1:3]
        tete = " ".join(lignes).upper()
        if any(re.sub(r"^\d+\s*", "", l).upper() == "COMMUNE" for l in lignes):
            seul = i + 1
        if "COMMUNE" not in tete and "OFFICIUM DEFUNCTORUM" not in tete:
            continue
        for cid, mot, _ in COMMUNS:
            if mot in tete:
                global DERNIERE
                DERNIERE = i + 1
                if cid not in debut:
                    debut[cid] = min(i + 1, seul) if seul and i + 1 - seul <= 4 else i + 1
                seul = None
                break
    # première page (latine, paire) où paraît le commun : sa page de titre
    bornes = sorted((p - (p % 2), cid) for cid, p in debut.items())
    return bornes


DERNIERE = 0     # dernière page des communs (office des défunts)


def commun_de(p, bornes):
    if p > DERNIERE + 1:
        return None
    c = None
    for b, cid in bornes:
        if p >= b:
            c = cid
    return c


NU = lambda t: re.sub(r"<[^>]+>", "", t).strip()

# étiquettes de variantes, côté français
TP = re.compile(r"^(Au temps pascal|Temps pascal|Tempore paschali)\s*:$")
HORS_TP = re.compile(r"^(En dehors du temps pascal|Extra tempus paschale)\s*:$")
TEMPS = [(re.compile(r"^(Au )?[Tt]emps du Carême\s*:$|^Tempore Quadragesimæ\s*:$"), "careme"),
         (re.compile(r"^Temps de l’Avent\s*:$"), "avent"), (re.compile(r"^Temps de Noël\s*:$"), "noel")]
POUR = re.compile(r"^(?:Ou bien, au choix, )?[Pp]our (un|une|plusieurs|des|la) ([^:]{3,70}):$")
RANG = re.compile(r"^Aux (mémoires|solennités|mémoires, fêtes et solennités)\s*:$")
LIEU = re.compile(r"^(Dans l’église consacrée|En dehors de l’église consacrée)\s*:$")
# consignes à retirer (avec leurs lignes de suite)
CONSIGNE = re.compile(r"^(On (dit|chante|répond|célèbre|peut)|Si l’on fait mémoire|L’hymne se trouve|l’hymne suivante|"
                      r"Psaume \d+.*(page|ordinaire)|Cantique .*(page|ordinaire)|Notre Père, page|Oraison des Laudes|"
                      r"Pour un abbé, on peut|Si l’Office n’est pas|À la fin des prières|Aux (mémoires|fêtes)[, ]|.*\bpage \d+\.?$|\d{3,4}\.?$)")
CAREME_ANT = re.compile(r"^En dehors du Carême, ant\. (\d)\.$")
# lettrines du livre mal recollées par l'extraction (ligne exacte → correction)
RETOUCHES = {
    "TUAS marché, témoin de Dieu,": "TU AS marché, témoin de Dieu,",
    "TUAS pleuré Lazare, tu t’es affligé": "TU AS pleuré Lazare, tu t’es affligé",
    "ÔMODÈLE des vierges saintes,": "Ô MODÈLE des vierges saintes,",
    "NFANT né de la Vierge, et Auteur de ta Mère": "ENFANT né de la Vierge, et Auteur de ta Mère",
    "E– Vierge elle t’a porté, Vierge elle t’enfanta –": "– Vierge elle t’a porté, Vierge elle t’enfanta –",
    "ALUT, Étoile de la mer,": "SALUT, Étoile de la mer,",
    "SÔ très sainte Mère de Dieu,": "Ô très sainte Mère de Dieu,",
    "BONTÉ adorable de notre Rédempteur!": "Ô BONTÉ adorable de notre Rédempteur!",
}
# ce qui manque à un commun se prend dans un autre (le livre y renvoie)
BASE = {"plusieurs-saints": "saints", "docteurs": "pasteurs", "martyrs": "martyr"}
RETOUCHES_ANT = {("martyr", "vepres1", 2): ("La palme du martyre ", "")}


def segmenter(e, tp_entree):
    """Lignes françaises d'un élément → segments (texte, tp, pour, temps, rang, lieu).
    Renvoie aussi le contexte « temps pascal » laissé pour l'élément suivant (étiquette en fin d'élément)."""
    segs = []
    cur = {"texte": [], "tp": tp_entree, "pour": None, "temps": None, "rang": None, "lieu": None}
    dans_consigne = False
    fr = e.get("fr") or []
    for k, (r, t) in enumerate(fr):
        u = NU(t)
        if not u:
            continue
        lab = None
        if TP.match(u):
            lab = {"tp": True, "temps": None}
        elif HORS_TP.match(u):
            lab = {"tp": False}
        elif POUR.match(u):
            m = POUR.match(u)
            lab = {"pour": f"{m.group(1)} {m.group(2)}".strip(), "tp": None}
        elif CAREME_ANT.match(u):
            lab = {"temps": "hors-careme", "n": int(CAREME_ANT.match(u).group(1))}
        elif RANG.match(u):
            lab = {"rang": RANG.match(u).group(1)}
        elif LIEU.match(u):
            lab = {"lieu": "dans" if u.startswith("Dans") else "hors"}
        else:
            for rx, tps in TEMPS:
                if rx.match(u):
                    lab = {"temps": tps, "tp": None}
        if lab is not None:
            if cur["texte"]:
                segs.append(cur)
            cur = {**cur, "texte": [], **lab}
            dans_consigne = False
            continue
        if CONSIGNE.match(u):
            dans_consigne = not re.search(r"[.:]$", u)
            continue
        if dans_consigne:                       # suite d'une consigne sur plusieurs lignes
            dans_consigne = not re.search(r"[.:]$", u)
            continue
        if re.fullmatch(r"\d{3,4}\.?", u):        # numéro de page égaré
            continue
        cur["texte"].append(RETOUCHES.get(u, re.sub(r"\s+\d{3,4}\.$", "", t)))
    if cur["texte"]:
        segs.append(cur)
    # une pièce qui porte « (T.P. Alléluia) » vaut pour toute l'année
    for sg in segs:
        if sg["tp"] and re.search(r"\(T\.\s?P\.", " ".join(sg["texte"])):
            sg["tp"] = None
    # étiquette « temps pascal » placée en fin d'élément (côté latin ou français) : vaut pour la suite
    sortie = None
    for cote in ("fr", "la"):
        ls = [NU(x[1]) for x in (e.get(cote) or []) if NU(x[1])]
        if ls and (TP.match(ls[-1]) or HORS_TP.match(ls[-1])):
            sortie = bool(TP.match(ls[-1]))
    # l'étiquette finale a pu ouvrir un segment vide : rien à garder
    return segs, sortie


def joindre(lignes):
    """Lignes du livre → un paragraphe, sans les coupures de fin de ligne (« bienheu- / reuse »)."""
    out = ""
    for t in lignes:
        t = t.strip()
        if not t:
            continue
        if re.search(r"[a-zà-ÿœæ]\s?-\s*$", out) and re.match(r"^[a-zà-ÿœæ]", NU(t)) and not re.match(r"^(nous|vous|moi|toi|le|la|les|lui|leur|en|y|il|elle|ils|elles|on|je|tu|même|ci|là)\b", NU(t)):
            out = re.sub(r"\s?-\s*$", "", out) + t
        elif re.search(r"-\s*$", out) and not re.search(r"\s-\s*$", out):
            out += t
        else:
            out = (out + " " + t) if out else t
    return re.sub(r"\s{2,}", " ", out).strip()


def hymne_strophes(segs):
    """Hymnes dont une strophe change selon le saint (« Pour un pape : 2. … ») : la strophe propre devient un
    segment à part, et la suite commune (strophe suivante et au-delà) un segment « suite » valable pour tous."""
    out = []
    for sg in segs:
        m = re.match(r"^(\d+)\.", NU(sg["texte"][0])) if sg["texte"] else None
        if sg["pour"] and m:
            sg["strophe"] = int(m.group(1))
            j = next((j for j, x in enumerate(sg["texte"]) if j and re.match(rf"^{int(m.group(1)) + 1}\.", NU(x))), None)
            if j is not None:
                out.append({**sg, "texte": sg["texte"][:j]})
                out.append({**sg, "texte": sg["texte"][j:], "pour": None, "strophe": None, "suite": True})
                continue
        out.append(sg)
    return out


def ref_lecture(e):
    t = (e.get("tfr") or "").strip()
    m = re.match(r"^Lecture brève\s+(.+)$", t)
    return m.group(1).strip() if m else (e.get("ref") or "")


LIVRES = {"Ap": "Ap", "Eph": "Ep", "Ep": "Ep", "Col": "Col", "Phil": "Ph", "Ph": "Ph", "1 Petr": "1 P", "1 Pe": "1 P", "1 P": "1 P", "Dn": "Dn",
          "Lc": "Lc", "Is": "Is", "Ier": "Jr", "Jr": "Jr", "1 Tim": "1 Tm"}


def ref_psaume(e=None, texte=None):
    """« PSALMUS 14 » → "14" ; « CANTICUM Ap 15, 3-4 » → "CANTIQUE (Ap 15, 3-4)" ; renvoi « Psaume 62, à l'ordinaire »."""
    t = texte if texte is not None else (e.get("tla") or "")
    t = re.sub(r"\s+", " ", t).strip()
    m = re.match(r"^(?:PSALMUS|Psalmus|PSAUME|Psaume)\s+(\d+[AB]?)(?:\s*[-–]\s*([IVX]+))?", t)
    if m:
        return m.group(1) + (f" - {m.group(2)}" if m.group(2) else "")
    m = re.match(r"^(?:CANTICUM|Canticum|CANTIQUE|Cantique)(?: de Daniel,)?\s*(?:Cf\.\s*)?([1-3]?\s?[A-Za-z]+)?,?\s*(\d+),\s*([\d\s.,\-–ab]+)", t)
    if m:
        livre = (m.group(1) or "Dn").strip()
        livre = LIVRES.get(livre, livre)
        return f"CANTIQUE ({livre} {m.group(2)}, {m.group(3).strip().rstrip('.,')})"
    return None


def construire():
    O = json.loads((HG / "offices.json").read_text(encoding="utf-8"))
    bornes = pages_des_communs()
    brut = {}
    for k, els in O.items():
        t, reste = k.split(":", 1)
        cle, office = reste.split("|")
        if t != "3":
            continue
        for e in els:
            cid = commun_de(e["p"], bornes)
            if not cid or office not in ("vepres1", "laudes", "milieu", "vepres2", "vepres"):
                continue
            # page de titre d'un commun restée sous le commun précédent : premier office du nouveau commun
            off = office
            if cle != "C/autre" and cle[2:] != cid:
                off = "laudes" if cid == "defunts" else "vepres1"
            brut.setdefault(f"{cid}|{off}", []).append(e)
    for k in brut:
        brut[k].sort(key=lambda e: e["p"])

    offices = {}
    precisions = {}
    for k, els in brut.items():
        cid, office = k.split("|")
        o = {"hymne": [], "antiennes": [], "psaumes": [], "lecture": [], "repons": [], "evangelique": [], "preces": [], "oraison": [], "milieu": []}
        tp = None
        n_ant = 0
        for e in els:
            typ = e["t"]
            if typ in ("hymne", "antienne", "psaume", "preces", "oraison", "texte"):
                tp = None                   # le contexte « temps pascal » ne passe pas ces pièces
            segs, sortie = segmenter(e, tp)
            for sg in segs:
                for x in ("rang", "lieu"):
                    if sg.get(x) is None:
                        sg.pop(x, None)
                if sg["pour"]:
                    precisions.setdefault(cid, [])
                    if sg["pour"] not in precisions[cid]:
                        precisions[cid].append(sg["pour"])
            if typ == "hymne":
                # « Hymnus in Proprio. Tempore vero paschali… » : cette hymne n'est que pour le temps pascal
                if re.search(r"Tempore vero paschali", " ".join(x[1] for x in e.get("la") or [])):
                    for sg in segs:
                        sg["tp"] = True
                o["hymne"] += hymne_strophes(segs)
                if e.get("partitions"):
                    o.setdefault("hymne_partitions", []).extend(e["partitions"])
            elif typ == "antienne":
                # le livre a parfois rangé la partie II du psaume sous l'antienne suivante (ligne « II ») : coupée
                for sg in segs:
                    i = next((i for i, x in enumerate(sg["texte"]) if re.match(r"^(I|II|III)$", NU(x))), None)
                    if i is not None:
                        sg["texte"] = sg["texte"][:i]
                        if o["psaumes"] and " - " not in o["psaumes"][-1] and re.match(r"^\d", o["psaumes"][-1]):
                            p = o["psaumes"].pop()
                            o["psaumes"] += [f"{p} - I", f"{p} - II"]
                n = e.get("n") or (n_ant + 1 if office != "milieu" else 1)
                n_ant = n
                ps = None
                for cote in ("la", "fr"):
                    for _, x in e.get(cote) or []:
                        ps = ps or ref_psaume(texte=re.sub(r",? (ut in|à l’ordinaire).*$", "", NU(x)))
                if re.search(r"Quadrag|Carême", e.get("v") or ""):
                    for sg in segs:
                        sg["temps"] = "careme"
                for sg in segs:
                    m = sg.pop("n", None) or n
                    ret = RETOUCHES_ANT.get((cid, office, m))
                    texte = joindre(sg["texte"])
                    if ret:
                        texte = texte.replace(*ret)
                    if not texte:
                        continue
                    o["antiennes"].append({"n": m, "texte": texte, "tp": sg["tp"], "temps": sg["temps"], "ps": ps if m == n else None,
                                           "partitions": e.get("partitions") or [] if m == n else []})
            elif typ == "psaume":
                r = ref_psaume(e)
                if r and not re.search(r"Lc 1|Lc 2", r):
                    o["psaumes"].append(r)
            elif typ == "lecture":
                for sg in segs:
                    if office == "milieu":
                        # « V/ … R/ … » à la fin : verset de l'heure
                        o["milieu"].append({"ref": ref_lecture(e), "tp": sg["tp"], "texte": [x for x in sg["texte"] if not re.match(r"^[VR]/", NU(x))],
                                            "verset": [x for x in sg["texte"] if re.match(r"^[VR]/", NU(x))]})
                    else:
                        sg["ref"] = ref_lecture(e)
                        o["lecture"].append(sg)
            elif typ in ("repons", "evangelique", "preces", "oraison"):
                # oraison : un segment trop court n'en est pas une (morceau d'une autre page)
                segs = [sg for sg in segs if typ != "oraison" or len(joindre(sg["texte"])) > 80]
                for sg in segs:
                    if typ in ("evangelique", "oraison"):
                        sg["texte"] = joindre(sg["texte"])
                    if typ == "oraison":       # l'invitatoire de la page suivante reste parfois collé
                        sg["texte"] = re.sub(r"\s+(Invitatoire|INVITATOIRE)\b.*$", "", sg["texte"])
                    if e.get("partitions") and typ != "preces":
                        sg["partitions"] = e["partitions"]
                o[typ] += segs
            # au milieu du jour, l'étiquette ne vaut que pour la lecture suivante (même heure)
            tp = sortie if sortie is not None else (tp if typ in ("lecture", "repons", "evangelique") and office != "milieu" else None)
        # laudes : psaumes du dimanche de la Ire semaine (« Psaume 62, à l'ordinaire »), donnés par les antiennes
        if not o["psaumes"]:
            o["psaumes"] = [a["ps"] for a in sorted(o["antiennes"], key=lambda a: a["n"]) if a["ps"]]
        offices[k] = {x: y for x, y in o.items() if y}
    communs = []
    for cid, _, nom in COMMUNS:
        offs = sorted({k.split("|")[1] for k in offices if k.startswith(cid + "|")}, key=["vepres1", "laudes", "milieu", "vepres2", "vepres"].index)
        if offs:
            communs.append({"id": cid, "nom": nom, "offices": offs, "precisions": precisions.get(cid, []), **({"base": BASE[cid]} if cid in BASE else {})})
    return {"communs": communs, "offices": offices, "brut": brut}


def indications_missel():
    """Le Missel (site/donnees/missel.json) indique pour chaque saint sans messe propre son commun
    (« Commun des pasteurs : pour un évêque ») : même rattachement pour l'office, comme à la Messe."""
    f = RACINE / "site" / "donnees" / "missel.json"
    if not f.exists():
        return {}
    out = {}
    for mmjj, saints in json.loads(f.read_text(encoding="utf-8")).get("saints", {}).items():
        for x in saints:
            t = re.sub(r"\s*[,(]\s*p(age|\.).*$", "", (x.get("commun") or "").split(", ou")[0].split(" ou ")[0]).lower()
            if not t:
                continue
            titre = x.get("titre") or ""
            fem = bool(re.match(r"^(sainte|saintes|bienheureuse)\b", titre.lower()))
            pour = (re.search(r"pour (.+)$", t) or [None, ""])[1]
            cid, p = None, None
            if "docteur" in t: cid = "docteurs"
            elif "vierge marie" in t: cid = "vierge-marie"
            elif "dédicace" in t: cid = "dedicace"
            elif "martyr" in t:
                cid = "martyrs" if "plusieurs" in pour or "missionnaires" in pour else "martyr"
                p = "une vierge martyre" if "vierge" in pour else None
            elif "pasteur" in t:
                cid = "pasteurs"
                p = {"un pape": "un pape", "un évêque": "un évêque", "des missionnaires": "plusieurs pasteurs" if " et " in titre else "un prêtre",
                     "un pasteur": "un prêtre" if "prêtre" in titre.lower() else "un évêque" if "évêque" in titre.lower() else None}.get(pour)
            elif "vierge" in t:
                cid, p = "vierges", ("plusieurs vierges" if "plusieurs" in pour else None)
            elif "saint" in t:
                if "saintes femmes" in pour or "des femmes" in pour: cid, p = "plusieurs-saints", "des saintes femmes"
                elif re.search(r"religieu|moine|abbé", pour): cid, p = ("saintes", "une religieuse") if fem or "religieuses" in pour else ("saints", "un religieux")
                elif "caritative" in pour: cid, p = ("saintes", "une sainte qui a exercé des œuvres de miséricorde") if fem else ("saints", "un saint qui a exercé des œuvres de miséricorde")
                elif "éducat" in pour: cid, p = ("saintes", "une éducatrice") if fem else ("saints", "un éducateur")
                else: cid = "saintes" if fem else "saints"
            if cid:
                out.setdefault(mmjj, []).append({"titre": titre, "id": cid, "pour": p, "missel": x.get("commun")})
    return out


def main():
    r = construire()
    r["indications"] = indications_missel()
    (HG / "communs.json").write_text(json.dumps(r, ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    for c in r["communs"]:
        print(f"{c['id']:16} {', '.join(c['offices']):35} {' | '.join(c['precisions'])}")
    print(f"indications du Missel : {sum(len(v) for v in r['indications'].values())}")
    print(f"→ {HG / 'communs.json'} ({(HG / 'communs.json').stat().st_size // 1024} Ko)")


if __name__ == "__main__":
    main()
