"""Lit la « Table générale » (OCR avec positions, table/*.tsv) -> table.json :
liste des § avec page du commentaire, titre, références Mt/Mc/Lc/Jn, partie et section."""
import csv, json, re, glob, os
D = os.path.dirname(os.path.abspath(__file__))
EV = ["Mt", "Mc", "Lc", "Jn"]

def lignes(path):
    mots = []
    with open(path, encoding="utf-8") as f:
        for r in csv.DictReader(f, delimiter="\t", quoting=csv.QUOTE_NONE):
            t = (r["text"] or "").strip()
            if r["level"] == "5" and t:
                mots.append((int(r["top"]), int(r["left"]), t))
    mots.sort()
    out, cur, ys = [], [], []
    for y, x, t in mots:  # rangées : mots dont le haut est à moins de 20 px de la moyenne de la rangée
        if ys and abs(y - sum(ys) / len(ys)) > 20:
            out.append(sorted(cur)); cur, ys = [], []
        cur.append((x, t)); ys.append(y)
    if cur: out.append(sorted(cur))
    return out

entrees, partie, section = [], "", ""
for path in sorted(glob.glob(os.path.join(D, "table", "*.tsv")), key=lambda p: (p[-9:-6], p[-5] == "d")):
    ls = lignes(path)
    col = None
    for l in ls:
        tx = [t for _, t in l]
        if "PAGE" in tx and "Mt" in tx and "Mc" in tx:
            h = {t: x for x, t in l}
            pas = h["Mc"] - h["Mt"]
            col = {"Mt": h["Mt"], "Mc": h["Mc"], "Lc": h["Mc"] + pas, "Jn": h["Mc"] + 2 * pas}
            debut = ls.index(l)
    if not col:
        continue
    bornes = sorted(col.values())
    for l in ls[debut + 1:]:
        gauche = [(x, t) for x, t in l if x < bornes[0] - 60]
        refs = {}
        for x, t in l:
            if x >= bornes[0] - 60:
                ev = min(col, key=lambda e: abs(col[e] - x))
                refs.setdefault(ev, []).append(t)
        txt = " ".join(t for _, t in gauche)
        txt = re.sub(r"^[S$](\d)", r"5\1", txt)
        txt = re.sub(r"^(\d+ )\](\d)", r"\g<1>1\2", txt)
        if re.match(r"^(\d+ )?SECTION\b", txt):
            section = re.sub(r"^\d+ ", "", txt); continue
        if re.match(r"^[IVX]+[\.,]\s", txt) and txt.upper() == txt:
            partie = txt; continue
        txt = re.sub(r"\b[S$]([S$\d]*\d)\b", lambda k: "5" + k.group(1).replace("S", "5").replace("$", "5"), txt)
        morceaux = re.split(r" (?=\d{2,3} \d+(?:-\d+)?\. )", txt)
        for i, morceau in enumerate(morceaux):
            m = re.match(r"^(?:(\d+)\s+)?(\d+(?:-\d+|(?: et \d+))?)(?:\s*(bis|ter))?[\.,]?\s+(.*)$", morceau)
            r = {}
            for k, v in refs.items():  # deux rangées fusionnées : une référence chacune
                r[k] = " ".join(v[i::len(morceaux)]) if len(morceaux) > 1 and len(v) == len(morceaux) else (" ".join(v) if i == 0 else "")
            r = {k: v for k, v in r.items() if v}
            if m and (m.group(1) or int(re.match(r"\d+", m.group(2)).group()) < 400):
                entrees.append({"page": int(m.group(1)) if m.group(1) else None,
                                "n": m.group(2) + (" " + m.group(3) if m.group(3) else ""),
                                "titre": m.group(4), "partie": partie, "section": section, **r})
            elif entrees:
                e = entrees[-1]
                if morceau: e["titre"] += " " + morceau
                for k, v in r.items():
                    e[k] = (e.get(k, "") + " " + v).strip()
json.dump(entrees, open(os.path.join(D, "table.json"), "w"), ensure_ascii=False, indent=0)
print(len(entrees), "entrées")
for e in entrees[:8] + entrees[-5:]: print(e)
