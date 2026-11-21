"""Carnet « Office du milieu du jour » de la Province → site/donnees/milieu.json

    python3 outils/construire_milieu.py "<carnet .docx exporté de Pages>" "<le même en .pdf>"

Le .docx (texte intact) donne le contenu ; le .pdf sert à séparer les hymnes (lignes vides).
"""
from __future__ import annotations
import html
import json
import re
import subprocess
import sys
import unicodedata
from pathlib import Path

ICI = Path(__file__).resolve().parent
sys.path.insert(0, str(ICI))
from lire_docx import blocs  # noqa: E402

JOURS = {"dimanche": "dim", "lundi": "lun", "mardi": "mar", "mercredi": "mer", "jeudi": "jeu", "vendredi": "ven", "samedi": "sam"}
ROM = {"I": 1, "II": 2, "III": 3, "IV": 4, "V": 5, "VI": 6, "VII": 7, "VIII": 8, "IX": 9, "X": 10, "XI": 11, "XII": 12,
       "XIII": 13, "XIV": 14, "XV": 15, "XVI": 16, "XVII": 17, "XVIII": 18, "XIX": 19, "XX": 20, "XXI": 21, "XXII": 22}
MOIS = {"janvier": 1, "fevrier": 2, "mars": 3, "avril": 4, "mai": 5, "juin": 6, "juillet": 7, "aout": 8, "septembre": 9,
        "octobre": 10, "novembre": 11, "decembre": 12}


def sa(s):
    return "".join(c for c in unicodedata.normalize("NFD", s) if not unicodedata.combining(c)).lower().replace("’", "'").strip()


def psaumes(txt: str) -> list[str]:
    """« 118-XVII, 81 & 119 » → ['118-17', '81', '119'] ; « 18 B, 5 & 10 » → ['18B', '5', '10']."""
    out = []
    for p in re.split(r"\s*(?:,|&|et)\s*", txt.strip().rstrip(".")):
        p = p.strip()
        m = re.fullmatch(r"118\s*-\s*([IVX]+)", p)
        if m:
            out.append(f"118-{ROM[m.group(1)]}"); continue
        m = re.fullmatch(r"(\d+)\s*([AB])?", p)
        if m:
            out.append(m.group(1) + (m.group(2) or ""))
    return out


def lignes_docx(chemin):
    out = []
    for k, t in blocs(Path(chemin)):
        for l in (t if k == "p" else "\n".join(t)).split("\n"):
            l = re.sub(r"\s+", " ", l).strip()
            if l and not re.fullmatch(r"\d{1,3}", l):
                out.append(l)
    return out


def hymnes(lignes, pdf):
    """Lignes des hymnes (avant « Dimanche I »), découpées en hymnes d'après les blocs du PDF."""
    fin = next(i for i, l in enumerate(lignes) if l == "Dimanche I")
    zone = lignes[:fin]
    titres = {"hymnes", "temps ordinaire", "& avent", "temps du careme", "temps pascal", "hymnes gregoriennes"}
    # tailles des blocs dans le PDF (pages 4 à 11)
    t = subprocess.run(["pdftotext", "-f", "4", "-l", "11", str(pdf), "-"], capture_output=True, text=True).stdout
    tailles = []
    for b in re.split(r"\n\s*\n", t):
        ls = [x for x in b.split("\n") if x.strip() and not re.fullmatch(r"\s*(fi|fl|ff|ffi|ffl|\d{1,3})\s*", x) and sa(x) not in titres]
        if len(ls) >= 4:
            tailles.append(len(ls))
    out, temps, courant = {}, None, []
    texte = []
    for l in zone:
        n = sa(l)
        if n in ("temps ordinaire", "temps du careme", "temps pascal", "hymnes gregoriennes"):
            temps = {"temps ordinaire": "to", "temps du careme": "careme", "temps pascal": "paques", "hymnes gregoriennes": "gregoriennes"}[n]
            continue
        if n in titres or temps is None or n.startswith("office du") or n.startswith("province") or n.startswith("ne pas") or n == "milieu du jour":
            continue
        texte.append((temps, l))
    # découpe selon les tailles du PDF quand elles concordent
    i = 0
    for taille in tailles:
        morceau = texte[i:i + taille]
        if not morceau:
            break
        tps = morceau[0][0]
        out.setdefault(tps, []).append([l for _, l in morceau])
        i += taille
    if i != len(texte):  # désaccord : une hymne par temps
        out = {}
        for tps, l in texte:
            out.setdefault(tps, [[]])[0].append(l)
    return out


def analyser(lignes):
    debut = next(i for i, l in enumerate(lignes) if l == "Dimanche I")
    hebdo, blocs_ = {}, []
    cur = None          # dict de l'élément courant
    saison = None
    for l in lignes[debut:]:
        n = sa(l)
        if n in ("fi", "fl", "ff", "ou"):
            continue
        m = re.fullmatch(r"(dimanche|lundi|mardi|mercredi|jeudi|vendredi|samedi) (i{1,3}|iv)", n)
        if m:
            cur = hebdo.setdefault(str(ROM[m.group(2).upper()]), {}).setdefault(JOURS[m.group(1)], {"versets": {}})
            saison = None
            continue
        mv = re.match(r"^([VR])\.\s*(.+)$", l)
        if mv and cur is not None:
            v = cur.setdefault("versets", {}) if "versets" in cur else cur
            cle = saison or "commun"
            liste = cur["versets"].setdefault(cle, [])
            if mv.group(1) == "V" or not liste or len(liste[-1]) == 2:
                liste.append([mv.group(2)])
            else:
                liste[-1].append(mv.group(2))
            continue
        mp = re.match(r"^Psaumes?\s+(.+?)(\s*\(Carême\))?$", l)
        if mp and cur is not None and not re.search(r"du jour|de la semaine", n):
            cur["ps_careme" if mp.group(2) else "ps"] = psaumes(mp.group(1))
            continue
        if n in ("temps ordinaire", "avent", "careme", "careme (semaine i)", "careme (semaine v)", "temps pascal"):
            saison = {"temps ordinaire": "to", "avent": "avent", "careme": "careme", "careme (semaine i)": "careme-1",
                      "careme (semaine v)": "careme-5", "temps pascal": "paques"}[n]
            continue
        # règles « Dimanche : psaume 117 », « Lundi Saint : psaumes … », « Semaines II & VI : psaumes … »
        mr = re.match(r"^(.+?)\s*:\s*psaumes?\s+(.+)$", l, re.I)
        if mr and cur is not None and "regles" in cur:
            cur["regles"].append({"quand": mr.group(1).strip(), "ps": psaumes(mr.group(2))})
            continue
        if cur is not None and "regles" in cur:
            if re.search(r"psaumes du jour|psaumes de la semaine", n):
                cur["ps"] = "semaine" + ("-" + str(ROM[re.search(r"semaine ([ivx]+)", n).group(1).upper()]) if re.search(r"de la semaine ([ivx]+)$", n) else "")
                continue
            if n.startswith("antienne") or n.startswith("tout comme") or n.startswith("lorsqu") or n.startswith("pour les"):
                cur.setdefault("notes", []).append(l)
                continue
            mps = re.match(r"^Psaumes?\s+(.+)$", l)
            if mps:
                cur["ps"] = psaumes(mps.group(1)); continue
            ms = re.match(r"^S[ée]rie (I+)\s*:\s*psaumes\s+(.+)$", l)
            if ms:
                cur.setdefault("series", {})[str(len(ms.group(1)))] = psaumes(ms.group(2)); continue
        # sinon : un titre de bloc (fête, temps, commun)
        if len(l) < 90 and not mv:
            cur = {"titre": l, "regles": [], "versets": {}}
            saison = None
            md = re.match(r"^(\d{1,2})(?:er)?\s+([a-zéû]+)\s*-", l, re.I)
            if md and sa(md.group(2)) in MOIS:
                cur["date"] = f"{MOIS[sa(md.group(2))]:02d}-{int(md.group(1)):02d}"
            else:
                md = re.match(r"^(\d{1,2})(?:er)?\s+(decembre|janvier)$", n)
                if md:
                    cur["date"] = f"{MOIS[md.group(2)]:02d}-{int(md.group(1)):02d}"
            blocs_.append(cur)
    # ménage
    for b in blocs_:
        if not b["regles"]: b.pop("regles")
    blocs_ = [b for b in blocs_ if b.get("versets") or b.get("ps") or b.get("regles") or b.get("notes")]
    return hebdo, blocs_


def cle_titre(s):
    """Clé de comparaison insensible aux ligatures perdues par le PDF (fi, fl, ff)."""
    s = re.sub(r"ff|fi|fl", "", sa(s))
    return re.sub(r"[^a-z0-9]", "", s)


def pages_partitions(pdf, hebdo, bl):
    """Attribue à chaque jour de semaine et à chaque bloc les pages du carnet où figure sa partition."""
    n = int(re.search(r"Pages:\s+(\d+)", subprocess.run(["pdfinfo", str(pdf)], capture_output=True, text=True).stdout).group(1))
    titres = [(cle_titre(b["titre"]), b) for b in bl]
    courant = None
    for i in range(1, n + 1):
        t = subprocess.run(["pdftotext", "-f", str(i), "-l", str(i), str(pdf), "-"], capture_output=True, text=True).stdout
        ls = [l.strip() for l in t.split("\n") if l.strip() and not re.fullmatch(r"\d{1,3}", l.strip())]
        if not ls:
            if courant is not None:
                courant.setdefault("pages", []).append(i)          # page de partition seule
            continue
        m = re.fullmatch(r"(dimanche|lundi|mardi|mercredi|jeudi|vendredi|samedi) (i{1,3}|iv)", sa(ls[0]))
        if m:
            x = hebdo.get(str(ROM[m.group(2).upper()]), {}).get(JOURS[m.group(1)])
            if x is not None:
                x["pages"] = [i]
            courant = None
            continue
        if i < 12:
            continue
        trouves = []
        for l in ls:
            k = cle_titre(l)
            for kt, b in titres:
                if k and k == kt and b not in trouves:
                    trouves.append(b)
        if courant is not None and (not trouves or cle_titre(ls[0]) != cle_titre(trouves[0]["titre"])):
            courant.setdefault("pages", []).append(i)          # suite du bloc précédent
        for b in trouves:
            if i not in b.setdefault("pages", []):
                b["pages"].append(i)
        if trouves:
            courant = trouves[-1]


# Antiennes lues sur les partitions du livret de Marseille (fichier → texte), complétées à la main
REVIVRE = "Le Seigneur m’a fait revivre quand j’allais à la mort."
PAROLES = "Tes Paroles, ô mon Seigneur, sont Esprit et Vie !"
ALLELUIA = "Alléluia, alléluia, alléluia."
BENIE = "Bénie sois-tu, ô Vierge Marie, ô Mère du Seigneur, Mère du Roi de gloire, ô Mère du Sauveur !"
AVANT = "Avant tous les siècles, le Seigneur t’a aimée, et tu as fait sa joie parmi les enfants des hommes !"
REVELE = "Tu as révélé ta Parole Seigneur, pour illuminer le cœur des pauvres."
TRANSCRITES = {f: {"ant": a} for f, a in {
    "a-019-1.jpg": REVIVRE, "a-034-1.jpg": REVIVRE,
    "a-020-1.jpg": "Fais-moi connaître tes chemins, guide-moi dans ta vérité !",
    "a-026-1.jpg": PAROLES, "a-042-1.jpg": PAROLES,
    "a-040-1.jpg": "Mon Dieu, mon Dieu ! Pourquoi m’as-tu abandonné ?",
    "a-049-1.jpg": "Il est avec nous le Seigneur de l’Univers, l’Emmanuel, alléluia !",
    "a-050-1.jpg": "Seigneur, tu nous as manifesté ton amour dans le Temple de ta chair, alléluia !",
    "a-050-2.jpg": "En ces jours qui sont les derniers, Dieu nous a parlé par son Fils, resplendissement de sa Gloire.",
    "a-051-1.jpg": "Un fleuve d’eau vive a réjoui l’Église, alléluia ! Dieu a exalté son Enfant Bien-Aimé, l’Emmanuel, alléluia !",
    "a-052-1.jpg": "Il n’y a pas de plus grand amour que de donner sa vie pour ses amis.",
    "a-052-2.jpg": "Par ses souffrances, mon Serviteur rachètera les multitudes.",
    "a-053-1.jpg": "Mon Dieu, mon Dieu ! Pourquoi m’as-tu abandonné ?",
    "a-053-2.jpg": "Je le crois, je verrai la bonté du Seigneur sur la terre des vivants !",
    "a-054-1.jpg": "La pierre que les bâtisseurs avaient rejetée est devenue la tête d’angle : c’est par le Seigneur que cela s’est accompli, merveille que nos yeux ont vue ! Voici le jour que fit le Seigneur, jour d’allégresse et de joie ! Alléluia, alléluia !",
    "a-055-1.jpg": "Le Seigneur s’est levé du tombeau, drapé d’un manteau de lumière, alléluia !",
    "a-056-1.jpg": ALLELUIA, "a-056-2.jpg": ALLELUIA, "a-057-1.jpg": ALLELUIA, "a-057-2.jpg": ALLELUIA,
    "a-058-1.jpg": ALLELUIA, "a-058-2.jpg": ALLELUIA, "a-059-2.jpg": ALLELUIA,
    "a-059-1.jpg": "Ô Dieu, tu t’élèves au-dessus des cieux, alléluia !",
    "a-060-1.jpg": "L’Esprit du Seigneur remplit l’univers. Le souffle de sa bouche a créé les cieux, alléluia !",
    "a-060-2.jpg": "Dieu a envoyé dans nos cœurs l’Esprit de son Fils qui nous fait crier : « Abba, Père », alléluia !",
    "a-061-1.jpg": "Les pauvres mangeront à la table du Seigneur ; il sera leur nourriture, le Seigneur les servira.",
    "a-061-2.jpg": "Mon serviteur a porté le joug de vos péchés. Le grain jeté en terre portera beaucoup de fruit.",
    "a-062-1.jpg": "Je suis Jésus que tu persécutes ! Je t’ai choisi pour porter mon Nom devant toutes les nations.",
    "a-062-3.jpg": "Ce que nos yeux ont contemplé du Verbe de Vie, nous l’annonçons pour votre joie, alléluia, alléluia !",
    "a-063-1.jpg": "Voici le serviteur fidèle que le Seigneur a établi sur sa maison.",
    "a-063-2.jpg": "Le Verbe s’est fait chair : bénie soit la Mère de Dieu, la Vierge qui porte en son sein le Dieu d’avant les siècles !",
    "a-064-1.jpg": "Dans ta lumière, tu es Celui qui est, et moi, celle qui n’est pas !",
    "a-064-2.jpg": AVANT, "a-073-1.jpg": AVANT,
    "a-065-1.jpg": "Le désert a refleuri, lorsque Jean, l’ami de Dieu, est venu préparer les chemins du Seigneur.",
    "a-065-2.jpg": "Parce que tu as beaucoup aimé, tes péchés te sont pardonnés : Madeleine, ta foi t’a sauvée, va en paix.",
    "a-066-1.jpg": "Lumière sur ma route, ta Parole, Seigneur !",
    "a-066-2.jpg": "Sans se lasser, Dominique a contemplé ta face, Seigneur, et son visage a rayonné de ta Lumière.",
    "a-067-1.jpg": "Tu es toute belle, ô Vierge Marie, le Roi du ciel t’a prise avec lui dans la Gloire ! Alléluia !",
    "a-067-2.jpg": "Ma grâce te suffit, ma force se déploie dans ta faiblesse.",
    "a-068-1.jpg": BENIE, "a-070-1.jpg": BENIE,
    "a-068-2.jpg": "Il est ressuscité celui que vous avez transpercé, alléluia !",
    "a-069-1.jpg": "Le Seigneur a pour toi donné ordre à ses anges de te porter dans leurs mains, pour que ton pied ne heurte la pierre.",
    "a-069-3.jpg": REVELE, "a-071-2.jpg": REVELE,
    "a-070-2.jpg": "Vous, les vivants, bénissez Dieu, le Seigneur du ciel et de la terre !",
    "a-071-1.jpg": "Illumine mes yeux, Seigneur, en ton salut ! Que dans un chant de joie je m’éveille des morts !",
    "a-072-1.jpg": "Église du Seigneur, Épouse bien-aimée, le Roi désire ta beauté.",
    "a-072-2.jpg": "Si vous gardez ma Parole, vous connaîtrez la Vérité, et la Vérité vous rendra libres !",
    "a-074-1.jpg": "Allez : enseignez tous les peuples ! Que l’Univers voie le Salut de Dieu !",
    "a-074-2.jpg": "Voici que je vous envoie comme des brebis au milieu des loups.",
    "a-075-1.jpg": "Qui vous accueille, c’est moi qu’il accueille, et le Père qui m’a envoyé.",
    "a-075-2.jpg": "J’entends mon Bien-Aimé : voici qu’il vient, sautant par les montagnes, bondissant sur les collines !",
    "a-076-1.jpg": "Bienheureux ceux qui cherchent la Paix, bienheureux les cœurs purs car ils verront Dieu !",
    "a-077-1.jpg": "Mon cœur et ma chair ont crié de joie devant ta Face !",
}.items()}
# images rattachées à un autre bloc que celui que donne la mise en page (None : à ignorer)
DEPLACER = {"a-058-2.jpg": "Samedis du Temps pascal", "a-069-1.jpg": "29 septembre - Ss. Archanges",
            "a-071-2.jpg": "3 novembre - S. Martin de Porrès", "a-077-2.jpg": None}
# images qui prolongent la précédente (ton de la psalmodie imprimé à part)
SUITE = {"a-054-2.jpg", "a-069-2.jpg"}

# ─── Livret de Marseille (2020) : antiennes en partition, une image par jour ou par fête
def lignes_xml(contenu):
    """Lignes de texte d'une page pdftohtml -xml, petites capitales recollées : [(top, left, texte)]."""
    els = []
    for e in re.finditer(r'<text top="(\d+)" left="(\d+)" width="(\d+)" height="(\d+)"[^>]*>(.*?)</text>', contenu):
        t = html.unescape(re.sub(r"<[^>]+>", "", e.group(5)))
        if t.strip():
            els.append([int(e.group(1)), int(e.group(2)), int(e.group(3)), t])
    els.sort(key=lambda x: (x[0], x[1]))
    groupes = []
    for e in els:
        g = next((g for g in groupes if abs(g[0][0] - e[0]) <= 5), None)
        (g.append(e) if g else groupes.append([e]))
    lignes = []
    for g in groupes:
        g.sort(key=lambda e: e[1])
        t, fin = "", None
        for top, left, w, x in g:
            t += ("" if fin is not None and left - fin < 3 else (" " if t else "")) + x
            fin = left + w
        lignes.append([g[0][0], g[0][1], t, fin])
    return [(a, b, re.sub(r"\s+", " ", c).strip()) for a, b, c, _ in lignes]


def images_xml(contenu):
    ims = [list(map(int, e.groups())) for e in re.finditer(r'<image top="(\d+)" left="(\d+)" width="(\d+)" height="(\d+)"', contenu)]
    ims = [[t, l, t + h, l + w] for t, l, w, h in ims if w > 300 and h > 60 and t + h <= 1263]
    fus = []
    for im in sorted(ims):
        f = next((f for f in fus if min(im[2], f[2]) - max(im[0], f[0]) > 0.5 * min(im[2] - im[0], f[2] - f[0])), None)
        if f:
            f[0], f[1], f[2], f[3] = min(f[0], im[0]), min(f[1], im[1]), max(f[2], im[2]), max(f[3], im[3])
        else:
            fus.append(im)
    return fus


def lettres(s):
    return re.sub(r"[^a-z]", "", sa(s))


def marseille(pdf, hebdo, bl):
    """Rattache aux jours et aux blocs les antiennes du livret de Marseille (partitions/marseille/a-PPP-K.jpg)."""
    import tempfile
    dossier = ICI.parent / "partitions" / "marseille"
    for f in dossier.glob("a-*.jpg"): f.unlink()
    G = json.loads((ICI.parent / "site" / "donnees" / "gouzes.json").read_text(encoding="utf-8"))["offices"]
    par118 = {}
    for cle, o in G.items():
        if cle.endswith("/milieu"):
            for e in o.get("psalmodie", []):
                for pc in e.get("pieces", []):
                    if pc["id"].startswith("118-"):
                        par118[pc["id"]] = {"ant": e.get("ant"), "cote": e.get("cote")}
    titres = [(cle_titre(b["titre"])[:30], b) for b in bl]
    ordre = [(s, j) for s in ("1", "2", "3", "4") for j in ("dim", "lun", "mar", "mer", "jeu", "ven", "sam")]
    k_jour = 0
    courant = None
    k = 892 / 595 * 72                       # unités pdftohtml par pouce
    with tempfile.TemporaryDirectory() as tmp:
        subprocess.run(["pdftohtml", "-xml", "-q", str(pdf), f"{tmp}/m"], capture_output=True)
        x = Path(f"{tmp}/m.xml").read_text(encoding="utf-8", errors="replace")
        for m in re.finditer(r'<page number="(\d+)"[^>]*>(.*?)</page>', x, re.S):
            p = int(m.group(1))
            if p < 19:
                continue
            reperes = []
            for top, left, t in lignes_xml(m.group(2)):
                n = sa(t)
                if p <= 48 and re.fullmatch(r"(dimanche|lundi|mardi|mercredi|jeudi|vendredi|samedi)( [iv]+)?", n):
                    s, j = ordre[k_jour]; k_jour += 1
                    reperes.append((top, hebdo[s][j]))
                elif re.match(r"^(laudes|vepres)\b", n):
                    reperes.append((top, None))
                else:
                    ct = cle_titre(t).replace("lattant", "latran")[:30]
                    b = next((b for kt, b in titres if kt and kt == ct), None)
                    if b is not None:
                        reperes.append((top, b))
            for n_im, (t0, l0, t1, l1) in enumerate(images_xml(m.group(2)), 1):
                cible = courant
                for top, r in reperes:
                    if top <= t0 + 10: cible = r
                f = f"a-{p:03d}-{n_im}.jpg"
                if f in DEPLACER:
                    cible = next((b for b in bl if b["titre"] == DEPLACER[f]), None)
                if cible is None:
                    continue
                e = 910 / 892
                subprocess.run(["sips", "-c", str(int((t1 - t0) * e)), str(int((l1 - l0) * e)), "--cropOffset", str(int(t0 * e)), str(int(l0 * e)),
                                str(dossier / f"p-{p:03d}.jpg"), "--out", str(dossier / f)], capture_output=True, check=True)
                if f in SUITE and cible.get("antiennes"):
                    p0 = cible["antiennes"][-1]["partition"]
                    cible["antiennes"][-1]["partition"] = p0 + [f"marseille/{f}"]
                    continue
                e_ant = {"partition": [f"marseille/{f}"]}
                ps = cible.get("ps") if isinstance(cible.get("ps"), list) else []
                s118 = next((x for x in ps if x.startswith("118-")), None)
                if f in TRANSCRITES:
                    e_ant.update(TRANSCRITES[f])
                elif s118 and s118 in par118 and not cible.get("antiennes"):
                    e_ant.update(par118[s118])
                cible.setdefault("antiennes", []).append(e_ant)
            if reperes:
                courant = reperes[-1][1]


# Hymnes grégoriennes du livret de Marseille : (page, haut, bas) de la partition avec les strophes latines,
# et (page, haut, bas) de la traduction française — en unités pdftohtml (page de 892 × 1263)
HYMNES_G = {
    "nunc-d": ("Nunc, Sancte, nobis, Spiritus", (4, 30, 395), (4, 415, 600)),
    "rector-d": ("Rector potens, verax Deus", (6, 25, 410), (6, 425, 600)),
    "rerum-d": ("Rerum, Deus, tenax vigor", (8, 18, 385), (9, 540, 750)),
    "dicamus-d": ("Dicamus laudes Domino", (10, 60, 480), (10, 495, 672)),
    "nunc-viii": ("Nunc, Sancte, nobis, Spiritus (solennités)", (4, 665, 1170), (4, 415, 600)),
    "rector-viii": ("Rector potens, verax Deus (solennités)", (6, 665, 1205), (6, 425, 600)),
    "rerum-viii": ("Rerum, Deus, tenax vigor (solennités)", (8, 655, 1160), (9, 540, 750)),
    "nunc-iv": ("Nunc, Sancte, nobis, Spiritus (Avent)", (5, 82, 482), (5, 515, 700)),
    "rector-iv": ("Rector potens, verax Deus (Avent)", (7, 82, 522), (7, 555, 730)),
    "rerum-iv": ("Rerum, Deus, tenax vigor (Avent)", (9, 78, 482), (9, 540, 750)),
    "dicamus-iv": ("Dicamus laudes Domino (Avent après le 16 décembre)", (10, 750, 1215), (10, 495, 672)),
    "nunc-ii": ("Nunc, Sancte, nobis, Spiritus (Noël)", (5, 792, 1195), (5, 515, 700)),
    "rector-ii": ("Rector potens, verax Deus (Noël)", (7, 808, 1175), (7, 555, 730)),
    "rerum-ii": ("Rerum, Deus, tenax vigor (Noël)", (9, 765, 1200), (9, 540, 750)),
    "venite": ("Venite, servi, supplices", (12, 40, 935), (12, 940, 1205)),
    "qua-christus": ("Qua Christus hora sitiit", (14, 18, 960), (14, 962, 1200)),
    "ternis": ("Ternis ter horis numerus", (13, 45, 922), (13, 925, 1160)),
    "iam-surgit": ("Iam surgit hora tertia", (16, 18, 958), (16, 960, 1222)),
    "dei-fide": ("Dei fide, qua vivimus", (17, 40, 1000), (17, 1002, 1225)),
    "haec-hora": ("Hæc hora, quæ resplenduit", (18, 25, 920), (18, 924, 1135)),
}
TEMPS_G = {"ordinaire": ["nunc-d", "rector-d", "rerum-d", "dicamus-d"], "solennite": ["nunc-viii", "rector-viii", "rerum-viii"],
           "avent": ["nunc-iv", "rector-iv", "rerum-iv"], "avent-17": ["dicamus-iv", "nunc-iv", "rector-iv", "rerum-iv"],
           "noel": ["nunc-ii", "rector-ii", "rerum-ii"], "careme": ["venite", "qua-christus", "ternis"],
           "paques": ["iam-surgit", "dei-fide", "haec-hora"]}


def traduction(contenu, y0, y1):
    """Strophes françaises d'une zone en deux colonnes."""
    els = []
    for e in re.finditer(r'<text top="(\d+)" left="(\d+)" width="(\d+)" height="(\d+)"[^>]*>(.*?)</text>', contenu):
        t = html.unescape(re.sub(r"<[^>]+>", "", e.group(5)))
        top, left, w = int(e.group(1)), int(e.group(2)), int(e.group(3))
        if t.strip() and y0 <= top <= y1:
            els.append((left >= 446, top, left, w, t))
    strophes = []
    for col in (False, True):
        lignes = {}
        for c, top, left, w, t in sorted(x for x in els if x[0] == col):
            k = next((k for k in lignes if abs(k - top) <= 5), top)
            lignes.setdefault(k, []).append((left, w, t))
        prec = None
        for top in sorted(lignes):
            morceaux = sorted(lignes[top]); txt, fin = "", None
            for left, w, t in morceaux:
                txt += ("" if fin is not None and left - fin < 3 else (" " if txt else "")) + t
                fin = left + w
            txt = re.sub(r"\s+", " ", txt).strip()
            if txt in ("Amen.", "Amen") and strophes:
                strophes[-1][-1] += " Amen."; prec = top; continue
            if prec is None or top - prec > 35 or not strophes:
                strophes.append([])
            strophes[-1].append(txt)
            prec = top
    return strophes


def hymnes_marseille(pdf):
    import tempfile
    dossier = ICI.parent / "partitions" / "marseille"
    out = {}
    with tempfile.TemporaryDirectory() as tmp:
        subprocess.run(["pdftohtml", "-xml", "-q", str(pdf), f"{tmp}/m"], capture_output=True)
        x = Path(f"{tmp}/m.xml").read_text(encoding="utf-8", errors="replace")
    pages = {int(m.group(1)): m.group(2) for m in re.finditer(r'<page number="(\d+)"[^>]*>(.*?)</page>', x, re.S)}
    e = 910 / 892
    for cle, (titre, (p, y0, y1), (pt, t0, t1)) in HYMNES_G.items():
        f = f"h-{cle}.jpg"
        subprocess.run(["sips", "-c", str(int((y1 - y0) * e)), "880", "--cropOffset", str(int(y0 * e)), "15",
                        str(dossier / f"p-{p:03d}.jpg"), "--out", str(dossier / f)], capture_output=True, check=True)
        out[cle] = {"titre": titre, "partition": [f"marseille/{f}"], "traduction": traduction(pages[pt], t0, t1)}
    return out


def main(docx, pdf, pdf_marseille=None):
    L = lignes_docx(docx)
    hebdo, bl = analyser(L)
    pages_partitions(pdf, hebdo, bl)
    gregoriennes = {}
    if pdf_marseille:
        marseille(Path(pdf_marseille), hebdo, bl)
        gregoriennes = hymnes_marseille(Path(pdf_marseille))
    sortie = {"source": "Office du milieu du jour — Province dominicaine de Toulouse", "hymnes": hymnes(L, pdf), "hebdo": hebdo, "blocs": bl,
              "gregoriennes": gregoriennes, "gregoriennes_temps": TEMPS_G}
    out = ICI.parent / "site" / "donnees" / "milieu.json"
    out.write_text(json.dumps(sortie, ensure_ascii=False, indent=0), encoding="utf-8")
    print(f"milieu du jour : {sum(len(v) for v in hebdo.values())} jours de semaine, {len(bl)} blocs, hymnes {[(k, len(v)) for k, v in sortie['hymnes'].items()]}")


if __name__ == "__main__":
    main(*sys.argv[1:4])
