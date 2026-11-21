"""Livrets de Sainte-Baume (psalmodie des 4 semaines, Matines-Laudes et Vêpres) : une antienne en
partition avant chaque psaume. Les partitions sont des images insérées dans le PDF (InDesign) ;
on les recadre à leur position et on les rattache au psaume dont le titre les précède.

    python3 outils/indexer_sainte_baume.py
      → partitions/sb/<office>-<sem>-p-NNN.jpg (pages), sb/a-….jpg (antiennes)
      → partitions/sb/pieces.json : [{office, semaine, jour, k, titre, ids, partition: [...]}]
"""
from __future__ import annotations
import json
import re
import subprocess
import sys
import tempfile
from pathlib import Path

ICI = Path(__file__).resolve().parent
RACINE = ICI.parent
sys.path.insert(0, str(ICI))
from construire_milieu import lignes_xml, images_xml, sa  # noqa: E402

SRC = RACINE / "sources_gouzes" / "sainte-baume"
OUT = RACINE / "partitions" / "sb"
JOURS = ("dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi")
ROM = {"i": 1, "ii": 2, "iii": 3, "iv": 4, "v": 5, "vi": 6, "vii": 7, "viii": 8, "ix": 9, "x": 10, "xi": 11, "xii": 12,
       "xiii": 13, "xiv": 14, "xv": 15, "xvi": 16, "xvii": 17, "xviii": 18, "xix": 19, "xx": 20, "xxi": 21, "xxii": 22}


def ids(titre: str) -> list[str]:
    """« Psaume 118 - xix » → ['118-19'] ; « Psaume 9 a » → ['9A'] ; « Psaume 17 - i » → ['17'] (avec partie)."""
    m = re.match(r"psaumes?\s+(\d+)\s*([ab])?\s*(?:-\s*([ivx]+))?", sa(titre))
    if not m:
        return []
    n = m.group(1) + (m.group(2) or "").upper()
    if n == "118" and m.group(3):
        return [f"118-{ROM[m.group(3)]}"]
    return [n]


def traiter(office: str, sem: int, pdf: Path, res: list):
    code = f"{office}-{sem}"
    with tempfile.TemporaryDirectory() as tmp:
        subprocess.run(["pdftohtml", "-xml", "-q", str(pdf), f"{tmp}/m"], capture_output=True)
        x = Path(f"{tmp}/m.xml").read_text(encoding="utf-8", errors="replace")
        pages = [(int(m.group(1)), int(m.group(2)), int(m.group(3)), m.group(4)) for m in
                 re.finditer(r'<page number="(\d+)"[^>]*height="(\d+)" width="(\d+)">(.*?)</page>', x, re.S)]
        subprocess.run(["pdftoppm", "-r", "110", "-gray", "-jpeg", "-jpegopt", "quality=80", str(pdf), f"{tmp}/p"], check=True)
        rendus = sorted(Path(tmp).glob("p-*.jpg"))
        jour, off, cur, k = None, office, None, 0
        for (p, H, W, contenu), rendu in zip(pages, rendus):
            evts = []
            for top, left, t in lignes_xml(contenu):
                n = sa(t)
                premier = n.split(" ")[0] if n else ""
                if top < 90:                      # titre courant de la page : « laudes semaine i », « dimanche psaume 2 »
                    if premier in ("laudes", "lectures") and office == "laudes":
                        evts.append((top, "office-courant", premier))
                    elif premier in JOURS:
                        evts.append((top, "jour-courant", premier))
                    continue
                if premier in JOURS and len(n) < 40:
                    evts.append((top, "jour", premier))
                elif n.startswith("office des lectures"):
                    evts.append((top, "office", "lectures"))
                elif n == "laudes":
                    evts.append((top, "office", "laudes"))
                elif re.match(r"^(psaumes?\s+\d|cantique\b)", n):
                    evts.append((top, "piece", t.split("Partition")[0].strip()))
            ims = images_xml(contenu) if H > 0 else []
            # les images de cette page, dans l'ordre, rattachées au dernier titre au-dessus
            tous = sorted(evts + [(im[0], "image", im) for im in ims], key=lambda e: e[0])
            for top, typ, val in tous:
                if typ == "jour":
                    jour, k = val, 0
                    if office == "vepres": off = "vepres"
                elif typ == "office":
                    off, k = val, 0
                elif typ == "office-courant":
                    off = val
                elif typ == "jour-courant":
                    jour = val
                elif typ == "piece":
                    k += 1
                    cur = {"office": off, "semaine": sem, "jour": jour, "k": k, "titre": val, "ids": ids(val), "partition": []}
                    res.append(cur)
                elif typ == "image" and cur is not None:
                    t0, l0, t1, l1 = val
                    e = 0
                    from subprocess import run
                    wpx = int(run(["sips", "-g", "pixelWidth", str(rendu)], capture_output=True, text=True).stdout.split()[-1])
                    e = wpx / W
                    f = f"{code}-{p:03d}-{len(cur['partition']) + 1}-{cur['k']}.jpg"
                    run(["sips", "-c", str(int((t1 - t0) * e)), str(int((l1 - l0) * e)), "--cropOffset", str(int(t0 * e)), str(int(l0 * e)),
                         str(rendu), "--out", str(OUT / f)], capture_output=True, check=True)
                    cur["partition"].append(f"sb/{f}")


def main():
    OUT.mkdir(parents=True, exist_ok=True)
    for f in OUT.glob("*.jpg"): f.unlink()
    res = []
    for office, dossier in (("laudes", "laudes"), ("vepres", "vepres")):
        for sem, rom in enumerate(("I", "II", "III", "IV"), 1):
            traiter(office, sem, SRC / dossier / f"Psalmodie Semaine {rom}.pdf", res)
    res = [r for r in res if r["partition"]]
    # rang de la pièce dans l'office du jour
    from collections import defaultdict
    rang = defaultdict(int)
    for r in res:
        cle = (r["office"], r["semaine"], r["jour"])
        rang[cle] += 1
        r["k"] = rang[cle]
    # texte et cote de chaque antienne : tableau de la Province (R/to/…), même ordre que le livret
    G = json.loads((RACINE / "site" / "donnees" / "gouzes.json").read_text(encoding="utf-8"))["offices"]
    groupes = defaultdict(list)
    for r in res: groupes[(r["office"], r["semaine"], r["jour"])].append(r)
    for (off, sem, jour), rs in groupes.items():
        ents = (G.get(f"R/to/{sem}/{jour}/{off}") or {}).get("psalmodie") or []
        libres = list(ents)
        for r in rs:
            base = r["ids"][0].split("-")[0] if r["ids"] else None
            e = next((e for e in libres if base and any(pc["id"].split("-")[0] == base for pc in e["pieces"])), None)
            if e is None and r["titre"].lower().startswith("cantique"):
                e = next((e for e in libres if any(pc["id"][:2] in ("AT", "NT") for pc in e["pieces"])), None)
            if e is None:
                continue
            libres.remove(e)
            r["ant"], r["cote"] = e.get("ant"), e.get("cote")
            r["ids"] = sorted({pc["id"] for pc in e["pieces"]} | set(r["ids"]))
    (OUT / "pieces.json").write_text(json.dumps(res, ensure_ascii=False, indent=0), encoding="utf-8")
    print(f"Sainte-Baume : {len(res)} antiennes en partition")
    from collections import Counter
    print(Counter((r["office"], r["semaine"]) for r in res))


if __name__ == "__main__":
    main()
