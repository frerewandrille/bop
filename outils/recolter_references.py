"""Relève, pour une période, les RÉFÉRENCES utilisées par l'AELF dans les offices
(psaumes avec leurs versets, cantiques, lectures) — jamais les textes.
Sert aux tests : chaque référence doit trouver son texte dans le psautier et la Bible.
Usage : python3 outils/recolter_references.py 2026-11-01 2027-12-31
"""
import json, re, sys, time, urllib.request, ssl
from concurrent.futures import ThreadPoolExecutor
from datetime import date, timedelta
from pathlib import Path

SORTIE = Path(__file__).resolve().parent / "aelf_references.json"
OFFICES = ["lectures", "laudes", "vepres", "complies"]
try:
    import certifi; CTX = ssl.create_default_context(cafile=certifi.where())
except ImportError:
    CTX = ssl.create_default_context()

def versets(html):
    out = []
    for m in re.finditer(r'(\[?)<span class="verse_number">([^<]+)</span>(\]?)', html or ""):
        if m.group(1) == "[":
            continue
        out.append(m.group(2).strip())
    return out

def lire(cle):
    d, office = cle
    url = f"https://api.aelf.org/v1/{office}/{d}/france"
    for essai in range(4):
        try:
            with urllib.request.urlopen(urllib.request.Request(url, headers={"User-Agent": "breviaire-local"}), timeout=30, context=CTX) as r:
                o = json.load(r)[office]
            break
        except Exception as e:
            o = None; time.sleep(2 + 3 * essai)
    if o is None:
        return cle, {"erreur": True}
    refs = {}
    for k, v in o.items():
        if isinstance(v, dict) and "reference" in v:
            refs[k] = {"ref": v.get("reference"), "v": versets(v.get("texte"))}
    return cle, refs

def main(a, b):
    deja = json.loads(SORTIE.read_text()) if SORTIE.exists() else {}
    d0, d1 = date.fromisoformat(a), date.fromisoformat(b)
    cles = []
    while d0 <= d1:
        for o in OFFICES:
            if f"{d0}/{o}" not in deja:
                cles.append((d0.isoformat(), o))
        d0 += timedelta(days=1)
    with ThreadPoolExecutor(4) as ex:
        for i, ((d, o), refs) in enumerate(ex.map(lire, cles)):
            deja[f"{d}/{o}"] = refs
            if i % 200 == 0:
                SORTIE.write_text(json.dumps(deja, ensure_ascii=False))
    SORTIE.write_text(json.dumps(deja, ensure_ascii=False))
    print("fini", len(deja))

if __name__ == "__main__":
    main(sys.argv[1], sys.argv[2])
