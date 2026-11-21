"""Récolte les « informations » AELF (nom du jour, fête, rang) sur la fenêtre couverte.

Ne garde que des noms et des rangs, jamais de textes. Sert à construire le
sanctoral et à vérifier le calendrier perpétuel contre l'AELF.
Usage : python3 outils/recolter_aelf.py 2018 2027
"""
import json, sys, time, ssl, urllib.request
from concurrent.futures import ThreadPoolExecutor
from datetime import date, timedelta
from pathlib import Path

SORTIE = Path(__file__).resolve().parent / "aelf_informations.json"

def contexte():
    try:
        import certifi
        return ssl.create_default_context(cafile=certifi.where())
    except ImportError:
        return ssl.create_default_context()

CTX = contexte()

def lire(d):
    url = f"https://api.aelf.org/v1/informations/{d.isoformat()}/france"
    for essai in range(4):
        try:
            with urllib.request.urlopen(urllib.request.Request(url, headers={"User-Agent": "breviaire-local"}), timeout=30, context=CTX) as r:
                return d.isoformat(), json.load(r)["informations"]
        except Exception as e:
            err = e
            time.sleep(2 + 3 * essai)
    return d.isoformat(), {"erreur": str(err)}

def main(a, b):
    deja = json.loads(SORTIE.read_text()) if SORTIE.exists() else {}
    d, fin, jours = date(a, 1, 1), date(b, 12, 31), []
    while d <= fin:
        if d.isoformat() not in deja or "erreur" in deja[d.isoformat()]:
            jours.append(d)
        d += timedelta(days=1)
    with ThreadPoolExecutor(4) as ex:
        for i, (k, v) in enumerate(ex.map(lire, jours)):
            deja[k] = v
            if i % 200 == 0:
                SORTIE.write_text(json.dumps(deja, ensure_ascii=False, indent=0, sort_keys=True))
                print(k, flush=True)
    SORTIE.write_text(json.dumps(deja, ensure_ascii=False, indent=0, sort_keys=True))
    print("fini", len(deja), sum("erreur" in v for v in deja.values()), "erreurs")

if __name__ == "__main__":
    main(int(sys.argv[1]), int(sys.argv[2]))
