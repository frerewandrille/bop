#!/usr/bin/env python3
"""Psautier liturgique de l'AELF avec inflexions → site/donnees/psautier_aelf.json

Source : sources_aelf/Psautier-AELF.doc (Word, Couvent de Lille / Province de France, 2004-2011),
même traduction que l'AELF, inflexions soulignées → mises en GRAS ici.

Même forme que psautier.json (construire_donnees.py) pour être lu par site/js/textes.js :
  {titre, ordre, pieces: {id: {id, titre, genre, ref, strophes: [{lignes: [{t, v?, r?}]}], priere: []}}}
Ids : "1"…"150", "9A", "9B", "18A", "18B", "113A", "113B", "118-1"…"118-22" (numérotation grecque),
cantiques "AT1"…"AT44", "NT1"…"NT12" (numérotation de ce fichier, différente du psautier BJ :
le site les retrouve par livre, chapitre et versets, jamais par numéro).

Les passages entre crochets (versets imprécatoires que la liturgie omet) sont écartés.
Usage : python3 outils/construire_psautier_aelf.py [fichier.doc]
"""
import html as H
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

RACINE = Path(__file__).resolve().parent.parent
SOURCE = RACINE / "sources_aelf" / "Psautier-AELF.doc"
SORTIE = RACINE / "site" / "donnees" / "psautier_aelf.json"

ROMAINS = {r: i for i, r in enumerate("I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI XVII XVIII XIX XX XXI XXII".split(), 1)}
LIVRES = {"Sag": "Sg", "Sg": "Sg", "1P": "1 P", "1 Tm": "1 Tm"}


def lire_html(source: Path) -> str:
    with tempfile.TemporaryDirectory() as tmp:
        s = Path(tmp) / "p.html"
        subprocess.run(["textutil", "-convert", "html", "-output", str(s), str(source)], check=True)
        return s.read_text(encoding="utf-8")


def texte(h: str) -> str:
    return H.unescape(re.sub(r"<[^>]+>", "", h)).replace("\xa0", " ")


def ligne_html(brut: str):
    """Paragraphe → (nombre de tabulations en tête, n° de verset, html du stique avec <b>)."""
    h = brut.replace('<span class="Apple-tab-span">\t</span>', "\t")
    h = re.sub(r'<span class="Apple-converted-space">([^<]*)</span>', r"\1", h)
    # n° de verset : <span class="s2"><i> 12 </i></span> (parfois avec la tabulation dedans)
    v = None
    m = re.match(r'^([\s\t]*(?:R/\s*)?[\s\t]*)<span class="s2">(.*?)</span>', h, re.S)
    if m:
        brut_v = texte(m.group(2))
        num = brut_v.replace("\t", " ").strip().replace("l", "1")
        num = re.sub(r"\s*,\s*", ",", num)
        tabs_dans = brut_v.count("\t")
        if re.fullmatch(r"\d+[ab]?(,\d+[ab]?)?", num):
            v = num
            reste = h[m.end():]
            # « 61 » en italique puis « .10 » en romain : chapitre 61, verset 10
            ms = re.match(r"^\s*[.,]\s*(\d+[ab]?)", texte(reste)) if "," not in v else None
            if ms:
                v = f"{v},{ms.group(1)}"
                reste = re.sub(r"^((?:\s|<[^>]+>)*)[.,]\s*" + ms.group(1), r"\1", reste, count=1)
            h = m.group(1) + "\t" * tabs_dans + reste
    h = re.sub(r'<span class="s1">(.*?)</span>', lambda m: "\x01" + m.group(1) + "\x02", h, flags=re.S)  # souligné → gras
    h = re.sub(r"<sup>\s*([*+])\s*</sup>", r" \1", h)
    h = re.sub(r"<[^>]+>", "", h)
    h = H.unescape(h).replace("\xa0", " ")
    refrain = ""
    mr = re.match(r"^[ \t]*R/[ \t]*", h)
    if mr:
        refrain, h = "R/ ", h[mr.end():]
    tete = re.match(r"^[ \t]*", h).group(0)
    tabs = tete.count("\t")
    corps = h[len(tete):]
    corps = corps.replace("&", "&amp;").replace("<", "&lt;").replace(">", "&gt;")
    corps = corps.replace("\x01", "<b>").replace("\x02", "</b>")
    corps = re.sub(r"</b><b>", "", corps)
    corps = re.sub(r"<b>(\s*)</b>", r"\1", corps)
    corps = re.sub(r"[ \t]+", " ", corps).strip()
    corps = re.sub(r"\s+([*+])$", r" \1", corps)
    if corps.startswith("R/ "):
        refrain, corps = "R/ ", corps[3:]
    return tabs, v, (f'<span class="rv">R/</span> ' if refrain else "") + corps


def titre_piece(tc: str):
    """Intitulé souligné → (id provisoire, titre, genre, livre, chapitre) ou None."""
    m = re.match(r"^Ps\.?\s*(\d+)\s*([AB])?\s*(?:-\s*([IVX]+))?\b\.?\s*(.*)$", tc)
    if m:
        num, ab, rom, reste = m.groups()
        pid = num + (ab or "") + (f"-{ROMAINS[rom]}" if rom else "")
        titre = f"Psaume {num}{ab or ''}" + (f"-{rom}" if rom else "")
        return pid, titre, "psaume", None, None, reste.strip(" .")
    m = re.search(r"\(([^)]+)\)\.?$", tc) or re.match(r"^((?:Tb|Sag\.)\s*\d+)$", tc)
    if m and re.match(r"^(Cant|Hymne|Lament|Tb|Sag)", tc):
        r = m.group(1).replace(".", " ").strip()
        mm = re.match(r"^((?:[1-3]\s?)?[A-Za-zé]+)\s*(\d+)", r)
        livre = re.sub(r"\s+", " ", mm.group(1))
        livre = LIVRES.get(livre, livre)
        if re.fullmatch(r"[1-3][A-Z]\w*", livre):
            livre = livre[0] + " " + livre[1:]
        return None, tc.rstrip(". "), "cantique", livre, int(mm.group(2)), ""
    return None


def analyser(source_html: str):
    paras = re.findall(r'<p class="(p\d+)">(.*?)</p>', source_html, re.S)
    pieces, ordre, ignores = {}, [], []
    cur = None
    strophe = []
    entete = True      # avant le premier stique : sentence, n° AT/NT
    crochet = False    # dans un passage entre crochets

    def fermer():
        nonlocal strophe
        if cur is not None and strophe:
            cur["strophes"].append({"lignes": strophe})
        strophe = []

    def finir():
        fermer()
        if cur is None:
            return
        if cur.get("_ignorer"):
            return
        if cur["genre"] == "cantique":
            if not cur["id"]:
                ignores.append(cur["titre"]); return
            cur["ref"] = reference(cur)
        cur.pop("_livre", None); cur.pop("_chap", None)
        pieces[cur["id"]] = cur
        ordre.append(cur["id"])

    for _classe, brut in paras:
        tc = re.sub(r"\s+", " ", texte(brut)).strip()
        mt = re.match(r'^\s*<span class="s1">(.*?)</span>', brut, re.S)
        info = titre_piece(tc) if mt and len(texte(mt.group(1)).strip()) > 4 else None
        if info:
            finir()
            pid, titre, genre, livre, chap, sous = info
            cur = {"id": pid, "titre": titre, "genre": genre, "ref": None, "strophes": [], "priere": [],
                   "_livre": livre, "_chap": chap}
            if sous:
                cur["sous_titre"] = sous
            strophe, entete, crochet = [], True, False
            continue
        if cur is None:
            continue
        if entete:
            # n° du cantique : « … AT 12. », « NT 4 »
            mn = re.search(r"\b(AT|NT)\s?(\d+[ab]?)\b", tc)
            if mn and cur["genre"] == "cantique" and not cur["id"]:
                cid = f"{mn.group(1)}{mn.group(2)}"
                if cid in pieces:          # 2e version (chantée) de Ap 19 : écartée
                    cur["_ignorer"] = True
                cur["id"] = cid
                avant = tc[:mn.start()].strip(" .")
                if avant:
                    cur["sous_titre"] = avant
                continue
            tabs, v, h = ligne_html(brut)
            if not (v or (tabs and re.match(r"^[ \t]*(<[^>]+>[ \t]*)*\t", brut.replace('<span class="Apple-tab-span">\t</span>', "\t")))):
                continue  # sentence en italique, auteur, ligne vide
            entete = False
        if not tc:
            fermer(); continue
        tabs, v, h = ligne_html(brut)
        t = texte(h)
        dedans = crochet or "[" in t
        for c in t:
            if c == "[":
                crochet = True
            elif c == "]":
                crochet = False
        if dedans:
            continue
        if re.fullmatch(r"\s*[IVX]+\s*\.?\s*", t) and not v:  # « I », « II » : parties du psaume (l'AELF les découpe elle-même)
            fermer(); continue
        if not t.strip() and not v:
            continue
        ligne = {"t": h}
        if v:
            ligne["v"] = v
        r = max(0, tabs - 1)
        if r:
            ligne["r"] = min(r, 3)
        strophe.append(ligne)
    finir()
    return pieces, ordre, ignores


def reference(p):
    """« Ex 15, 1-4.8-13.17-18 » d'après les n° de versets imprimés (changement de chapitre « 17,1 »)."""
    ch = p["_chap"]
    par_ch = {}
    for s in p["strophes"]:
        for l in s["lignes"]:
            if "v" not in l:
                continue
            m = re.match(r"^(\d+),(\d+)", l["v"])
            if m:
                ch, v = int(m.group(1)), int(m.group(2))
            else:
                v = int(re.match(r"\d+", l["v"]).group(0))
            par_ch.setdefault(ch, set()).add(v)
    morceaux = []
    for c, vs in par_ch.items():
        vs = sorted(vs)
        plages, a = [], vs[0]
        for x, y in zip(vs, vs[1:] + [None]):
            if y != x + 1:
                plages.append(f"{a}-{x}" if a != x else f"{a}"); a = y
        morceaux.append(f"{c}, " + ".".join(plages))
    return f"{p['_livre']} " + "; ".join(morceaux) if morceaux else f"{p['_livre']} {p['_chap']}"


def main():
    src = Path(sys.argv[1]) if len(sys.argv) > 1 else SOURCE
    pieces, ordre, ignores = analyser(lire_html(src))
    SORTIE.write_text(json.dumps({"titre": "Psautier liturgique (AELF), inflexions en gras", "ordre": ordre, "pieces": pieces},
                                 ensure_ascii=False, separators=(",", ":")), encoding="utf-8")
    nps = sum(p["genre"] == "psaume" for p in pieces.values())
    print(f"{SORTIE.relative_to(RACINE)} : {nps} psaumes (ou parties), {len(pieces) - nps} cantiques")
    vides = [k for k, p in pieces.items() if not p["strophes"]]
    if vides:
        print("  pièces vides :", vides)
    if ignores:
        print("  cantiques sans numéro (ignorés) :", ignores)
    for k in ordre:
        if pieces[k]["genre"] != "psaume":
            print(f"  {k:5} {pieces[k]['ref']}")


if __name__ == "__main__":
    main()
