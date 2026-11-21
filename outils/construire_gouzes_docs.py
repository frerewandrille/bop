"""Documents Word de la Liturgie chorale (dossier « sources_gouzes ») → compléments de gouzes.json.

Appelé par construire_gouzes.py. Apporte :
- Avent (« Antiennes écrites AVENT (V2).docx ») : psalmodie des dimanches et des semaines I-III,
  semaine préparatoire (17-23 déc.), antiennes du Magnificat, hymnes, répons à versets, chorals ;
- Carême (« Antiennes écrites CAREME.docx ») : psalmodie (semaines I/II), hymnes, invitatoires,
  chorals et répons des dimanches, Grand Canon de saint André réparti par jour ;
- Répons des laudes et vêpres (8 semaines), des dimanches (vigiles, 8 semaines), des mémoires de saints ;
- Litanies (preces) des laudes et vêpres (fr. D. Cerbelaud) pour toute l'année ;
- Offices des Ténèbres (feuille « SEMAINE SAINTE » du tableau) et leurs preces conclusives.
« TRID GOUZES.docx » est une présentation historique du Triduum, sans texte d'office : non repris.
"""
from __future__ import annotations
import re
import subprocess
import tempfile
from pathlib import Path

from lire_docx import blocs

ORDINAUX = {"premier": 1, "deuxieme": 2, "troisieme": 3, "quatrieme": 4, "cinquieme": 5}
ROMAINS = {"I": 1, "II": 2, "III": 3, "IV": 4, "V": 5, "VI": 6, "VII": 7, "VIII": 8}


def texte_doc(chemin: Path) -> str:
    """.doc → texte (textutil, macOS)."""
    with tempfile.TemporaryDirectory() as t:
        s = Path(t) / "x.txt"
        subprocess.run(["textutil", "-convert", "txt", "-output", str(s), str(chemin)], check=True)
        return s.read_text(encoding="utf-8")


def lignes_propres(texte: str) -> list[str]:
    out = []
    texte = texte.replace("\r", "\n").replace("\u2028", "\n").replace("\u2029", "\n")
    for l in texte.split("\n"):
        l = re.sub(r"[\x00-\x08\x0b-\x1f\x7f\xa0\u200b\ufeff]", " ", l).strip()
        if l and "HYPERLINK" not in l and "PAGEREF" not in l and not l.startswith("TOC "):
            out.append(re.sub(r"[ \t]+", " ", l))
    return out


def strophes(texte: str) -> list[list[str]]:
    """Texte d'hymne → strophes (numérotées « 1. », ou séparées par une ligne vide)."""
    t = re.sub(r"\s+(\d{1,2})\.\s", lambda m: "\n\n" + m.group(1) + ". ", " " + texte).strip()
    out = []
    for bloc in re.split(r"\n\s*\n", t):
        ls = [re.sub(r"[ \t]+", " ", x).strip() for x in bloc.split("\n") if x.strip()]
        if ls:
            out.append(ls)
    return out


# ════════════════════════════════ AVENT ════════════════════════════════
def avent(g, chemin: Path, textes: dict):
    B = list(blocs(chemin))
    S = g.sans_accents
    section = None          # "vepres1", "vepres2", "lectures", "laudes", "magnificat", "repons", "repons-laudes", "choral", "hymne"…
    dim = None              # "dim", "dim1".."dim4", None (semaine préparatoire)
    semaine = None          # 1..3 pour les antiennes de semaine
    jour_prep = None
    psalmo: dict[str, list] = {}
    magn: dict[str, dict] = {}
    texte_courant = None    # (clé, liste de lignes) pour hymnes, chorals, versets de répons
    o_ant: dict[int, str] = {}

    def fermer():
        nonlocal texte_courant
        if texte_courant:
            cle, genre, lignes = texte_courant
            corps = "\n".join(lignes).strip()
            if genre == "hymne" or genre == "choral":
                textes.setdefault("hymnes", {})[cle] = {**textes["hymnes"].get(cle, {}), "strophes": strophes(corps)}
            elif genre == "repons":
                r = textes["repons"][cle]
                r["versets"] = versets_avent(corps)
        texte_courant = None

    for k, t in B:
        if k == "t":
            cel = [c for c in t]
            if not any(cel):
                continue
            fermer()
            # table : [jour?] | cote | antienne | psaume | ton   — ou répons : cote | refrain | ton
            if section in ("repons", "repons-laudes") and len(cel) <= 4 and not any(re.match(r"^\d", c or "") for c in cel[2:3]):
                cote, refrain, ton = (cel + ["", "", ""])[:3]
                cle = f"avent/{dim or 'prep'}/{'laudes' if section == 'repons-laudes' else 'repons'}"
                if dim is None and section == "repons-laudes":
                    cle = "avent/prep/laudes"
                elif section == "repons" and dim == "dim":
                    cle = "avent/semaine/vepres"
                elif section == "repons-laudes" and dim in ("dim", "dim1"):
                    cle = "avent/semaine1/laudes"
                elif section == "repons-laudes" and dim in ("dim2", "dim3"):
                    cle = f"avent/semaine{dim[-1]}/laudes"
                elif section == "repons":
                    cle = f"avent/{dim}/dimanche"
                textes.setdefault("repons", {})[cle] = {"cote": cote, "refrain": refrain, "ton": ton, "versets": []}
                texte_courant = (cle, "repons", [])
                continue
            if len(cel) == 5 and g.jour_de(cel[0]):          # semaines I-III
                jour, cote, ant, ps, ton = cel
                off = section
                psalmo.setdefault(f"semaine{semaine}/{g.jour_de(jour)}/{off}", []).append((cote, ant, ps, ton))
                continue
            if len(cel) == 5 and not cel[0] and semaine and section in ("laudes", "vepres"):  # cantique de vêpres sans jour
                _, cote, ant, ps, ton = cel
                cles = [c for c in psalmo if c.startswith(f"semaine{semaine}/") and c.endswith("/" + section)]
                if cles:
                    psalmo[cles[-1]].append((cote, ant, ps, ton))
                continue
            cote, ant, ps, ton = (cel + ["", "", "", ""])[:4]
            if jour_prep is not None:
                psalmo.setdefault(f"prep/j{jour_prep}", []).append((cote, ant, ps, ton))
                continue
            if g.norm(ps) == "NT I":
                magn[f"{dim}/{section if section != 'magnificat' else 'vepres1'}"] = {"ant": g.norm(ant), "cote": g.norm(cote), "ton": g.norm(ton)}
                continue
            if section in ("vepres1", "vepres2", "lectures", "laudes") and dim:
                psalmo.setdefault(f"{dim}/{section}", []).append((cote, ant, ps, ton))
            continue

        # paragraphes
        brut = t.strip()
        tl = S(brut.split("\n")[0])
        mh = re.match(r"^(g\s?0\d\d)\s+hymne des (vigiles|vepres|laudes)", tl)
        if mh:
            fermer()
            off = {"vigiles": "lectures", "vepres": "vepres", "laudes": "laudes"}[mh.group(2)]
            cle = f"avent/{off}"
            textes.setdefault("hymnes", {})[cle] = {"titre": f"Hymne de l'Avent", "cote": brut.split()[0] if brut[:1] == "G" else ""}
            texte_courant = (cle, "hymne", [])
            continue
        md = re.match(r"^(premier|deuxieme|troisieme|quatrieme) dimanche", tl)
        if md:
            fermer(); dim = f"dim{ORDINAUX[md.group(1)]}"; semaine = None; jour_prep = None; section = None; continue
        if tl.startswith("vepres du dimanche"):
            fermer(); dim = "dim"; section = None; continue
        if tl.startswith("semaine preparatoire"):
            fermer(); dim = None; semaine = None; section = None; continue
        mj = re.match(r"^(\d)e jour", tl)
        if mj:
            fermer(); jour_prep = int(mj.group(1)); continue
        ma = re.match(r"^antiennes des (laudes|vepres) \(semaine ([iv]+)\)", tl)
        if ma:
            fermer(); section = ma.group(1); semaine = ROMAINS[ma.group(2).upper()]; continue
        if tl.startswith("1e vepres"):
            fermer(); section = "vepres1"; continue
        if tl.startswith("2e vepres"):
            fermer(); section = "vepres2"; continue
        if tl.startswith("vigiles"):
            fermer(); section = "lectures"; continue
        if tl.startswith("laudes du dimanche"):
            fermer(); section = "laudes"; dim = "dim"; continue
        if tl.startswith("antienne a magnificat"):
            fermer()
            section = "magnificat" if section in (None, "vepres1") else section
            continue
        if tl.startswith("repons des laudes") or tl.startswith("repons laudes"):
            fermer(); section = "repons-laudes"; continue
        if tl.startswith("repons"):
            fermer(); section = "repons"; continue
        if tl.startswith("choral"):
            fermer()
            cle = f"avent/{dim or 'prep'}/choral"
            textes.setdefault("hymnes", {})[cle] = {"titre": brut.split("\n")[0].strip()}
            texte_courant = (cle, "choral", [])
            continue
        mo = re.match(r"^\s*(\d{2})\s*dec\.?\s+(o .+)$", S(brut), re.S)
        if mo:
            fermer()
            o_ant[int(mo.group(1))] = re.sub(r"^\s*\d{2}\s*d[ée]c\.?\s+", "", brut).strip()
            continue
        if tl.startswith("antiennnes a magnificat") or tl.startswith("antiennes a magnificat"):
            fermer()
            magnificat_semaine(g, brut, textes)
            continue
        if tl.startswith("antiennes de la semaine preparatoire") or tl.startswith("textes avent"):
            continue
        if texte_courant:
            texte_courant[2].append(brut)
    fermer()

    # psalmodie → offices
    for cle, lignes in psalmo.items():
        if cle.startswith("prep/"):
            prep_jour(g, cle.split("/")[1], lignes)
            continue
        el = []
        for cote, ant, ps, ton in lignes:
            for p in [x for x in re.split(r"\s*[/\n]\s*", str(ps or "")) if x.strip()] or [ps]:
                e = g.element(cote if ant else None, ant if ant else None, p, ton)
                if e:
                    el.append(e)
        if cle.startswith("semaine"):
            sem, jour, off = cle.split("/")
            g.poser(f"G/avent/{sem.replace('semaine', 'sem')}/{jour}/{off}", el)
        else:
            g.poser(f"G/avent/{cle}", el, evangelique=magn.get(cle))
    for cle, m in magn.items():
        if cle not in psalmo:
            g.poser(f"G/avent/{cle}", None, evangelique=m)
    for jour, t in o_ant.items():
        g.poser(f"G/avent/o{jour}/vepres", None, evangelique={"ant": t, "ton": "Bb II g", "titre": "Antienne « Ô »"})


def prep_jour(g, j: str, lignes):
    """Semaine préparatoire : antiennes 1-3 vigiles, 4 laudes (psaume / cantique / psaume), 5 vêpres."""
    n = int(j[1:])
    offices = {"lectures": [], "laudes": [], "vepres": []}
    for i, (cote, ant, ps, ton) in enumerate(lignes):
        off = "lectures" if i < 3 else "laudes" if i == 3 else "vepres"
        cote = g.norm(cote).replace("Cf. /", "").replace("Cf.", "").strip()
        morceaux = [g.norm(x) for x in re.split(r"\s*[/\n]\s*", str(ps or "")) if x.strip()]
        if off == "laudes" and len(morceaux) == 3:
            offices[off].append(g.element(cote, ant, morceaux[0], ton))
            offices[off].append(g.element(None, None, morceaux[1], None))
            offices[off].append(g.element(None, ant, morceaux[2], ton))
        elif off == "vepres":
            e = g.element(cote, ant, " ".join(morceaux), ton)
            offices[off].append(e)
        else:
            offices[off].append(g.element(cote, ant, ps, ton))
    for off, el in offices.items():
        if el:
            g.poser(f"G/avent/j{n}/{off}", el)


def magnificat_semaine(g, texte: str, textes: dict):
    """Encadré « Antiennes à Magnificat » (texte collé) : semaine I, une antienne par jour ; semaines II et III."""
    t = re.sub(r"\s+", " ", texte.split("Antiennnes à Magnificat")[1] if "Antiennnes à Magnificat" in texte else texte)
    def phrase(x):
        x = x.strip().rstrip(",")
        x = re.sub(r"(?i)^réjouis toi marie\s*:?\s*", "", x)
        x = (x[:1].lower() + x[1:]).replace("eve nouvelle", "Ève nouvelle").replace("fille de sion", "Fille de Sion").replace("réjouis toi", "réjouis-toi")
        return "Réjouis-toi, Marie" + (", " + x if x else "") + " !"
    m = re.search(r"Lun (.+?)Mar (.+?)Mer (.+?)Jeu (.+?)Ven (.+?)Semaine II", t)
    if m:
        for i, jour in enumerate(["lundi", "mardi", "mercredi", "jeudi", "vendredi"]):
            g.poser(f"G/avent/sem1/{jour}/vepres", None, evangelique={"ant": phrase(m.group(i + 1)), "cote": f"G 17{i + 1}", "ton": "F"})
    for n, code, suite in ((2, "271-275", "Semaine III"), (3, "371-375", "Antiennnes|$")):
        mm = re.search(rf"Semaine {'I' * n} \(G\s?{code}\)\s*F(.+?)(?:{suite})", t)
        if mm:
            for i, jour in enumerate(["lundi", "mardi", "mercredi", "jeudi", "vendredi"]):
                g.poser(f"G/avent/sem{n}/{jour}/vepres", None, evangelique={"ant": phrase(mm.group(1)), "cote": f"G {n}7{i + 1}", "ton": "F"})


def versets_avent(corps: str) -> list[dict]:
    """« 1 – Sam. texte » / « 4 – Ld. texte » / « 5 – Dox. texte » → [{n, quand, texte}]."""
    out = []
    t = re.sub(r"\n+(?=\d{1,2}\s*[–-])", "\n\n", corps.strip())
    morceaux = re.split(r"(?:^|\n\n)\s*(\d{1,2})\s*[–-]\s*", "\n\n" + t)
    if len(morceaux) < 3:  # versets numérotés « 1. », « 2. »…
        m2 = re.split(r"(?:^|\n)\s*(\d{1,2})\.\s+", "\n" + corps.strip())
        if len(m2) >= 3:
            for i in range(1, len(m2) - 1, 2):
                out.append({"n": int(m2[i]), "texte": re.sub(r"\s*\n\s*", " / ", m2[i + 1].strip())})
            return out
    if len(morceaux) < 3:  # versets non numérotés : un paragraphe par verset
        for i, p in enumerate(x for x in corps.split("\n") if x.strip()):
            out.append({"n": i + 1, "texte": p.strip()})
        return out
    for i in range(1, len(morceaux) - 1, 2):
        n, corps_v = int(morceaux[i]), morceaux[i + 1].strip()
        q = None
        mq = re.match(r"^(Sam|Dim|Lun|Mar|Mer|Jeu|Ven|Vig|Ld|Dox)\.?\s*[-–]?\s*", corps_v)
        if mq:
            q = mq.group(1).lower()
            corps_v = corps_v[mq.end():]
        out.append({"n": n, "quand": q, "texte": re.sub(r"\s*\n\s*", " / ", corps_v).strip()})
    return out


# ════════════════════════════════ CARÊME ════════════════════════════════
def careme(g, chemin: Path, textes: dict, F):
    B = list(blocs(chemin))
    S = g.sans_accents
    ctx = None
    psalmo: dict[str, list] = {}
    texte_courant = None
    canon = []          # [(code, titre, [lignes])]
    dernier_vepres = None
    dernier_office = None
    jour_sem = None

    def fermer():
        nonlocal texte_courant
        if texte_courant:
            cle, lignes = texte_courant
            textes.setdefault("hymnes", {})[cle]["strophes"] = strophes("\n".join(lignes))
        texte_courant = None

    en_canon = False
    for k, t in B:
        if en_canon:
            if k == "p":
                tete = t.split("\n")[0]
                code = re.search(r"[KΚ]\s?(9\d\d)", tete)
                titre_sec = (len(tete) < 90 and not re.match(r"^\s*\d", tete)
                             and (re.search(r"\bSection\b|\bOde\b", tete) or code or jour_du_titre(tete)))
                if titre_sec:
                    canon.append([int(code.group(1)) if code else None, tete.strip(), []])
                elif canon:
                    canon[-1][2].append(t.strip())
            continue
        if k == "p":
            brut = t.strip()
            tl = S(brut.split("\n")[0])
            mh = re.match(r"^k\s?0\d\d hymnes? de (vepres|vigiles)", tl)
            if mh:
                fermer()
                cle = f"careme/{'vepres' if mh.group(1) == 'vepres' else 'lectures'}"
                textes.setdefault("hymnes", {})[cle] = {"titre": "Hymne du Carême", "cote": brut.split("Hymne")[0].strip()}
                texte_courant = (cle, [])
                continue
            mc = re.match(r"^choral\s*k\s?(\d)00", tl)
            if mc:
                fermer()
                cle = f"careme/dim{mc.group(1)}/choral"
                textes.setdefault("hymnes", {})[cle] = {"titre": "Choral", "cote": f"K {mc.group(1)}00"}
                texte_courant = (cle, [])
                continue
            if tl.startswith("canon de saint andre"):
                fermer(); en_canon = True; continue
            if tl.startswith("mercredi des cendres"):
                fermer(); ctx = "cendres"; continue
            if tl == "dimanches":
                fermer(); ctx = "dim"; continue
            if tl.startswith("invitatoires"):
                fermer(); ctx = "invit"; continue
            md = re.match(r"^(\d)e dimanche", tl)
            if md:
                fermer(); ctx = f"dim{md.group(1)}"; continue
            ms = re.match(r"^semaine (i+)$", tl.strip())
            if ms:
                fermer(); ctx = f"sem{len(ms.group(1))}"; dernier_office = None; continue
            if tl.strip() == "repons":
                fermer(); ctx = "repons-semaine"; continue
            if tl.startswith("vigiles dimanches") or tl.startswith("textes careme"):
                continue
            if texte_courant:
                texte_courant[1].append(brut)
            elif ctx and ctx.startswith("dim") and textes.get("repons", {}).get(f"careme/{ctx}/lectures"):
                textes["repons"][f"careme/{ctx}/lectures"].setdefault("versets", []).append({"n": 0, "texte": brut})
            continue
        # tableaux
        cel = list(t)
        if not any(cel):
            continue
        fermer()
        if ctx == "invit":
            cote, ant = (cel + ["", ""])[:2]
            if re.match(r"^K\s?04\d", cote):
                textes.setdefault("invitatoires_careme", []).append({"cote": cote, "ant": ant})
            continue
        if ctx == "repons-semaine":
            off, cote, refrain, ton = (cel + ["", "", "", ""])[:4]
            o = {"vigiles": "lectures", "laudes": "laudes", "vepres": "vepres"}.get(S(off).strip())
            if o:
                textes.setdefault("repons_careme_semaine", {}).setdefault(o, []).append({"cote": cote, "refrain": refrain, "ton": ton})
            continue
        if S(cel[0]).strip() == "repons" and ctx and ctx.startswith("dim"):
            cote, refrain, ton = (cel[1:] + ["", "", ""])[:3]
            textes.setdefault("repons", {})[f"careme/{ctx}/lectures"] = {"cote": cote, "refrain": refrain, "ton": ton, "versets": []}
            continue
        # psalmodie
        if len(cel) == 6:          # semaines : jour | office | cote | antienne | psaume | ton
            jour, off, cote, ant, ps, ton = cel
            if g.jour_de(jour):
                jour_sem = g.jour_de(jour)
        else:
            off, cote, ant, ps, ton = (cel + [""] * 5)[:5]
        o = S(off).strip()
        office = {"vigiles": "lectures", "laudes": "laudes", "vepres": "vepres", "dimanche 1e v": "vepres1",
                  "dimanche 2e v": "vepres2", "dimanche": "laudes"}.get(o)
        if office is None and not (ctx == "dim" and g.norm(ps).startswith("NT")):
            office = dernier_office
        dernier_office = office or dernier_office
        if not ps:
            continue
        if ctx and ctx.startswith("sem"):
            cle = f"{ctx}/{jour_sem}/{office}"
        elif ctx == "cendres":
            cle = f"cendres/{office or 'laudes'}"
        elif ctx == "dim":
            office = office or ("vepres2" if g.norm(ps).startswith("NT") else "laudes")
            cle = f"dim/{office}"
        elif ctx and ctx.startswith("dim"):
            cle = f"{ctx}/{office or 'lectures'}"
        else:
            continue
        if not office and dernier_vepres and g.norm(ps).startswith("NT"):
            cle = dernier_vepres
        psalmo.setdefault(cle, []).append((cote, ant, ps, ton))
        if "vepres" in cle:
            dernier_vepres = cle
    fermer()

    # Les lignes « continuation » (AT42 / 31 après le psaume 50 des Cendres) sont dans des cellules vides
    # du tableau : on les relit dans le tableau Excel, plus complet sur ce point.
    for cle, lignes in psalmo.items():
        el = []
        for cote, ant, ps, ton in lignes:
            e = g.element(cote, ant, ps, ton)
            if e:
                el.append(e)
        g.poser(f"G/careme/{cle}", el)
    # Cendres, laudes : 50, AT 42, 31 (une antienne)
    if "G/careme/cendres/laudes" in g.OFF:
        g.OFF["G/careme/cendres/laudes"]["psalmodie"] = g.finir([
            g.element("K 095", "Seigneur, relève tes enfants affermis les devant ta Face !", "50", "F VI"),
            g.element(None, None, "AT 42", None), g.element(None, None, "31", None)])

    # Grand Canon : code K9SJ → jour (S = semaine 0 [Cendres] à 6 [Semaine sainte], J = jour)
    textes["canon"] = canon_par_jour(canon)


JOURS_SEM = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"]
SEM_ROM = {"ier": 1, "ieme": 1, "iieme": 2, "iiieme": 3, "iveme": 4, "veme": 5}


def jour_du_titre(titre: str):
    """« IIème Lundi de Carême » → (2, 'lundi') ; « Vendredi des Cendres » → (0, 'vendredi') ; « Lundi Saint » → (6, 'lundi')."""
    import unicodedata
    t = "".join(c for c in unicodedata.normalize("NFD", titre) if not unicodedata.combining(c)).lower().replace("-", " ")
    m = re.search(r"\b(dimanche|lundi|mardi|mercredi|jeudi|vendredi|samedi) des cendres", t)
    if m:
        return 0, m.group(1)
    if "dimanche des rameaux" in t:
        return 6, "dimanche"
    m = re.search(r"\b(lundi|mardi|mercredi) saint", t)
    if m:
        return 6, m.group(1)
    m = re.search(r"\b(ier|i+eme|iveme|veme)\s+(dimanche|lundi|mardi|mercredi|jeudi|vendredi|samedi)", t)
    if m:
        return SEM_ROM.get(m.group(1), None), m.group(2)
    m = re.search(r"\b(i+|iv|v)\s+(dimanche|lundi|mardi|mercredi|jeudi|vendredi|samedi) de careme", t)
    if m:
        return {"i": 1, "ii": 2, "iii": 3, "iv": 4, "v": 5}[m.group(1)], m.group(2)
    return None


def canon_par_jour(sections):
    """Chaque section du Grand Canon est rattachée au jour écrit dans son titre ; à défaut, à sa cote
    (K 901 = mercredi des Cendres… K 9S1 = dimanche de la semaine S… K 9S7 = samedi), sinon au jour suivant."""
    out = {}
    pos = None           # (semaine, index du jour) ; semaine 0 = après les Cendres
    report = None        # titre d'une section vide (sa cote ou son jour vaut pour la suivante)
    for c, titre, lignes in sections:
        if not lignes:
            report = (c, titre)
            continue
        if report:
            c = c or report[0]
            titre = report[1] + " " + titre
            report = None
        j = jour_du_titre(titre)
        if j and j[0] is not None:
            pos = (j[0], JOURS_SEM.index(j[1]))
        elif c:
            s, d = divmod(c - 900, 10)
            pos = (0, [None, 3, 4, 5, 6][d]) if s == 0 and 1 <= d <= 4 else (s, d - 1)
        elif pos:
            s, d = pos
            pos = (s + 1, 0) if d == 6 else (s, d + 1)
        if not pos or pos[1] is None:
            continue
        s, d = pos
        cle = f"cendres/{JOURS_SEM[d]}" if s == 0 else f"sem{s}/{JOURS_SEM[d]}"
        out.setdefault(cle, {"titre": re.sub(r"\s+", " ", titre).strip(), "lignes": []})["lignes"] += lignes
    return out


# ════════════════════════════════ RÉPONS ════════════════════════════════
def repons_semaine(g, chemin: Path, textes: dict, saints=False):
    L = lignes_propres(texte_doc(chemin))
    sem = off = None
    cur = None
    for l in L:
        m = re.match(r"^Semaine ([IVX]+)$", l)
        if m:
            sem = ROMAINS[m.group(1)]; continue
        if l in ("Laudes", "Vêpres"):
            off = "laudes" if l == "Laudes" else "vepres"; continue
        if l == "Répons":
            cur = {"versets": []}; continue
        if cur is not None and "cote" not in cur and re.match(r"^[A-Z]\s?\d{3}$", l):
            cur["cote"] = l; continue
        if cur is not None and "refrain" not in cur and "cote" in cur:
            cur["refrain"] = l
            if saints:
                textes.setdefault("repons", {}).setdefault(f"to/{sem}/{off}", {}).setdefault("saints", [])
                cur = textes["repons"][f"to/{sem}/{off}"]
            else:
                textes.setdefault("repons", {})[f"to/{sem}/{off}"] = cur
            continue
        mv = re.match(r"^(\d)\.\s*(?:\(([^)]+)\))?\s*(.*)$", l)
        if mv and cur is not None:
            quand = (mv.group(2) or "").strip(". ").lower()[:3]
            v = {"n": int(mv.group(1)), "quand": quand or None, "texte": mv.group(3).strip()}
            (cur["saints"] if saints else cur["versets"]).append(v)


def repons_dimanches(g, chemin: Path, textes: dict):
    L = lignes_propres(texte_doc(chemin))
    dim = None
    cur = None
    for l in L:
        m = re.match(r"^Dimanche ([IVX]+)$", l)
        if m:
            dim = ROMAINS[m.group(1)]; cur = None; continue
        if l in ("Vigiles", "Répons"):
            if l == "Répons":
                cur = {"versets": []}
            continue
        if cur is not None and "cote" not in cur and re.match(r"^[A-Z]\s?\d{3}$", l):
            cur["cote"] = l; continue
        if cur is not None and "refrain" not in cur and "cote" in cur:
            cur["refrain"] = l
            textes.setdefault("repons", {})[f"to/dim{dim}"] = cur
            continue
        mv = re.match(r"^(\d)\.\s*(?:\(([^)]+)\))?\s*(.*)$", l)
        if mv and cur is not None:
            q = (mv.group(2) or "").replace(" ", "").replace(".", "").lower()
            q = {"iv": "vepres1", "vig": "lectures", "ld": "laudes", "iiv": "vepres2", "dox": "dox", "mag": "mag"}.get(q, None)
            cur["versets"].append({"n": int(mv.group(1)), "quand": q, "texte": mv.group(3).strip()})


# ════════════════════════════════ LITANIES ════════════════════════════════
SECTIONS = [  # (début du titre normalisé, clé)
    ("temps de l'eglise", None), ("temps de l'avent", "avent"), ("dimanches de l'avent", "avent/dim"),
    ("temps de noel", None), ("nativite de notre seigneur", "fete/noel"), ("octave de noel", "fete/octave-noel"),
    ("la sainte famille", "fete/sainte-famille"), ("temps de l'epiphanie", None), ("epiphanie du seigneur", "fete/epiphanie"),
    ("bapteme du seigneur", "fete/bapteme"), ("noces de cana", "fete/cana"),
    ("careme et semaine sainte", "careme"), ("mercredi des cendres", "careme/cendres"), ("dimanches du careme", "careme/dim"),
    ("dimanche des rameaux", "careme/rameaux"), ("lundi saint", "careme/lundi-saint"), ("mardi saint", "careme/mardi-saint"),
    ("mercredi saint", "careme/mercredi-saint"), ("temps pascal", "paques"),
    ("la resurrection de notre seigneur", "paques/resurrection"), ("dimanches du temps pascal", "paques/dim"),
    ("ascension du seigneur", "fete/ascension"), ("pentecote", "fete/pentecote"), ("sainte trinite", "fete/trinite"),
    ("saint-sacrement", "fete/saint-sacrement"), ("sacre-coeur", "fete/sacre-coeur"), ("sanctoral", None), ("fetes fixes", None),
    ("sainte marie, mere de dieu", "sanctoral/01-01"), ("saint thomas d'aquin", "sanctoral/thomas-d-aquin"),
    ("presentation du seigneur", "sanctoral/02-02"), ("saint joseph", "sanctoral/03-19"), ("annonciation du seigneur", "sanctoral/03-25"),
    ("visitation de la vierge marie", "sanctoral/05-31"), ("nativite de saint jean-baptiste", "sanctoral/06-24"),
    ("transfiguration du seigneur", "sanctoral/08-06"), ("saint dominique", "sanctoral/dominique"),
    ("assomption", "sanctoral/08-15"), ("nativite de la vierge marie", "sanctoral/09-08"), ("exaltation de la croix", "sanctoral/09-14"),
    ("saints michel, gabriel et raphael", "sanctoral/09-29"), ("saint francois d'assise", "sanctoral/francois"),
    ("fete de tous les saints de l'ordre", "sanctoral/saints-op"), ("fete de tous les saints", "sanctoral/11-01"),
    ("commemoraison de tous les fideles defunts", "sanctoral/11-02"), ("le christ, roi de l'univers", "fete/christ-roi"),
    ("immaculee conception", "sanctoral/12-08"), ("communs", None), ("dedicace", "commun/dedicace"),
    ("vierge marie", "commun/vierge-marie"), ("apotres", "commun/apotres"), ("evangelistes", "commun/evangelistes"),
    ("martyrs", "commun/martyrs"), ("docteurs", "commun/docteurs"),
]
OFFICES_P = {"premieres vepres": "vepres1", "deuxiemes vepres": "vepres2", "deuxieme vepres": "vepres2", "vepres": "vepres", "laudes": "laudes"}


def litanies(g, chemin: Path, textes: dict):
    S = g.sans_accents
    L = lignes_propres(texte_doc(chemin))
    P = textes.setdefault("preces", {})
    base = None   # contexte de section
    jour = None
    office = None
    cur = None
    debut = next((i for i, l in enumerate(L)
                  if S(l).replace("’", "'").strip(" .") == "temps de l'eglise"), None)
    if debut is None:
        print(f"⚠ litanies : « Temps de l’Église » introuvable dans {chemin.name} "
              f"({len(L)} lignes). Début : {L[:3]!r}")
        debut = 0
    for l in L[debut:]:
        n = S(l).replace("’", "'").strip(" .")
        if n.startswith("toc ") or "pageref" in n:
            break
        m = re.match(r"^semaine (i{1,3}|iv)$", n)
        if m:
            base, jour, office, cur = f"to/{ROMAINS[m.group(1).upper()]}", None, None, None; continue
        md = re.match(r"^(premier|deuxieme|troisieme|quatrieme|cinquieme) dimanche (de l'avent|du careme)$", n)
        if md:
            t = "avent" if "avent" in md.group(2) else "careme"
            base, jour, office, cur = f"{t}/dim{ORDINAUX[md.group(1)]}", None, None, None; continue
        mdec = re.match(r"^(\d{2}) decembre$", n)
        if mdec:
            base, jour, office, cur = f"avent/12-{mdec.group(1)}", None, None, None; continue
        sec = next((cle for deb, cle in SECTIONS if n == deb or (n.startswith(deb) and len(n) < len(deb) + 45)), "∅")
        if sec != "∅" and not (office and n in ("vierge marie",) and False):
            if sec is not None or n in ("temps de l'eglise", "temps de noel", "temps de l'epiphanie", "sanctoral", "fetes fixes", "communs"):
                base, jour, office, cur = sec, None, None, None
                continue
        if n in ("lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"):
            jour, office, cur = n, None, None
            if base and base.endswith("/dim") and n != "dimanche":
                base = base[:-4]   # « Dimanches de l'Avent » puis les jours de semaine
            continue
        mo = re.match(r"^(premieres vepres|deuxiemes? vepres|vepres|laudes)\b(.*)$", n)
        if mo and len(n) < 60:
            if "choix 2" in mo.group(2):
                office, cur = None, None
                continue
            office = OFFICES_P[mo.group(1)]
            if base is None:
                cur = None; continue
            cle = "/".join(x for x in [base, jour if jour and jour != "dimanche" or base.startswith("to/") else None, office] if x)
            if base.startswith("to/") and jour == "dimanche":
                cle = f"{base}/dimanche/{office}"
            cur = P.setdefault(cle, [])
            continue
        if cur is not None:
            cur.append(l)


# ════════════════════════════════ TÉNÈBRES ════════════════════════════════
def tenebres(g, F, chemin_preces: Path, textes: dict):
    ws = F.get("semaine sainte")
    if ws is None:
        return
    jour = None
    noct = None
    offices: dict[str, dict] = {}
    for r in ws.iter_rows(values_only=True):
        c = g.norm(r[0])
        if not c:
            continue
        n = g.sans_accents(c)
        if "tenebres du jeudi" in n:
            jour = "jeudi"; continue
        if "tenebres du vendredi" in n:
            jour = "vendredi"; continue
        if "tenebres du samedi" in n:
            jour = "samedi"; continue
        mn = re.match(r"^(premier|deuxieme|troisieme) nocturne", n)
        if mn:
            noct = mn.group(1); continue
        if not jour:
            continue
        o = offices.setdefault(jour, {"psalmodie": [], "repons": [], "lamentation": None})
        ml = re.match(r"^(L\s?\d00)\s+(Lamentation.*)$", c)
        if ml:
            o["lamentation"] = {"cote": ml.group(1), "titre": ml.group(2).strip()}
            continue
        for ma in re.finditer(r"(L\s?\d{3})\s+Ant\.?\s+[\"“«]\s*(.+?)\s*[\"”»]\s+et\s+(?:le\s+)?ps\.?\s*(\d+)", c):
            e = g.element(ma.group(1), ma.group(2) + "…", ma.group(3), None)
            if e:
                e["nocturne"] = noct
                o["psalmodie"].append(e)
        for mr in re.finditer(r"(L\s?\d{3})\s+Rép\.?\s+[\"“«]\s*(.+?)\s*[\"”»]", c):
            o["repons"].append({"cote": mr.group(1), "refrain": mr.group(2) + "…", "nocturne": noct})
    for jour, o in offices.items():
        g.poser(f"G/triduum/{jour}/lectures", o["psalmodie"])
        textes.setdefault("tenebres", {})[jour] = {"lamentation": o["lamentation"], "repons": o["repons"]}
    # Mercredi saint, vigiles : mêmes antiennes que le vendredi de la semaine II (Ps 21 en trois parties)
    g.poser("G/careme/mercredi-saint/lectures", [
        g.element("L 411", "Mon Dieu ! Mon Dieu ! Pourquoi m’as-Tu abandonné ?", "21", "g II"),
        g.element("L 412", "Ils ont percé mes mains et mes pieds : je peux compter tous mes os !", "21", "g II"),
        g.element("L 413", "Devant Toi, Seigneur, s'inclineront ceux qui sont descendus dans la poussière de la mort.", "21", "g II")])
    textes.setdefault("repons", {})["careme/mercredi-saint/lectures"] = {"cote": "L 420", "refrain": "Nous annonçons un Messie crucifié, Puissance de Dieu et Sagesse de Dieu !", "versets": []}
    if chemin_preces.exists():
        L = lignes_propres(texte_doc(chemin_preces))
        debut = next((i for i, l in enumerate(L) if l.startswith("Chantre")), 0)
        textes["tenebres_preces"] = L[debut:]


def ajouter(g, dossier: Path, F) -> dict:
    textes: dict = {}
    trouve = lambda motif: next(iter(sorted(dossier.glob(motif))), None)
    if (f := trouve("*AVENT*.docx")):
        avent(g, f, textes)
    if (f := trouve("*CAREME*.docx")):
        careme(g, f, textes, F)
    if (f := trouve("Répons laudes*.doc")) or (f := trouve("R*pons laudes*.doc")):
        repons_semaine(g, f, textes)
    if (f := trouve("R*pons m*moire*.doc")):
        repons_semaine(g, f, textes, saints=True)
    if (f := trouve("R*pons vigiles*.doc")):
        repons_dimanches(g, f, textes)
    if (f := trouve("Preces*Litanies*.doc")):
        litanies(g, f, textes)
    tenebres(g, F, trouve("T*n*bres Preces*.doc") or Path("/inexistant"), textes)
    return textes
