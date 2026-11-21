"""
Relie l'interlinéaire au plan de lecture du projet « Lectio » (dossier voisin lectio-biblique).
Le moteur de Lectio est appelé tel quel (lecture seule) ; on écrit data/plan.js :

  window.__PLAN = {"periodes": {...}, "jours": {"2026-11-29": {"p": "avent", "r": repère,
                    "e": {"ref": "Lc 1,1-25", "m": [["LUK", 1, 1, 25], …]} ou {"libre": "…"},
                    "cr": "Is 1-3", "sr": "Ps 1"}}}
"""
import json
import os
import sys
from datetime import date


def exporter(lectio_dir, out_dir, books):
    if not os.path.isdir(os.path.join(lectio_dir, "lectio")):
        print("  (projet Lectio introuvable : pas de péricope du jour)")
        return False
    sys.path.insert(0, lectio_dir)
    try:
        from lectio import plan as P
        from lectio.livres import LIVRES
        from lectio.calendrier import premier_dimanche_avent
    except Exception as e:  # le projet a changé : on n'empêche pas le reste de l'extraction
        print("  ! plan Lectio illisible :", e)
        return False
    # codes Lectio (abréviations BJ : « Mt », « 1 S »…) -> codes de l'interlinéaire (« MAT »…)
    par_nom = {b["n"]: b["c"] for b in books}
    par_abbr = {b["a"].replace(" ", ""): b["c"] for b in books}
    conv = {}
    for l in LIVRES:
        conv[l.code] = par_abbr.get(l.code.replace(" ", "")) or par_nom.get(l.nom)
    cfg = P.charger_config(os.path.join(lectio_dir, "plan.toml"))
    bpath = os.path.join(lectio_dir, "data", "bible.json")
    bible = json.load(open(bpath, encoding="utf-8")) if os.path.exists(bpath) else None
    today = date.today()
    cur = today.year if today >= premier_dimanche_avent(today.year) else today.year - 1
    jours, periodes = {}, {}
    for an in (cur - 1, cur, cur + 1):
        js, ps, _alertes = P.construire(an, cfg, bible)
        for p in ps:
            periodes[p["id"]] = p["nom"]
        for j in js:
            e = j.evangile or {}
            if e.get("livre"):
                ev = {"ref": e["ref"], "m": [[conv.get(e["livre"], e["livre"]), c, de, a] for c, de, a in e["m"]]}
            else:
                ev = {"libre": e.get("libre", "")}
            jours[j.date.isoformat()] = {"p": j.periode, "r": j.repere, "e": ev,
                                         "cr": P.ref_chapitres(j.cursive), "cn": j.cursive_note,
                                         "sr": P.ref_chapitres(j.petite)}
    with open(os.path.join(out_dir, "plan.js"), "w", encoding="utf8") as f:
        f.write("window.__PLAN=")
        json.dump({"periodes": periodes, "jours": jours}, f, ensure_ascii=False, separators=(",", ":"))
        f.write(";\n")
    print(f"  plan Lectio : {len(jours)} jours ({cur - 1}-{cur + 2})")
    return True
