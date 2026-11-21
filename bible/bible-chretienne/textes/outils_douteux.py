#!/usr/bin/env python3
"""Relevé des mots encore douteux (ni la BJ, ni macOS, ni les lexiques ne les connaissent), avec leur contexte :
   python3 bible/bible-chretienne/textes/outils_douteux.py  -> textes/travail/douteux_II.txt et douteux_II_etoile.txt"""
import json, os, re, sys, collections
ICI = os.path.dirname(os.path.abspath(__file__)); sys.path.insert(0, ICI)
import corrige
C = corrige.Correcteur()
def releve(textes, sortie):
    ctx, cnt = {}, collections.Counter()
    for t in textes:
        for m in re.finditer(r"[A-Za-zÀ-ÿœŒæ0-9]+", t):
            w = m.group()
            if w.isdigit() or w in corrige.SIGLES or len(w) < 2 or C.connu(w) or w.lower() in C.latin or w in corrige.PROTEGES: continue
            if re.fullmatch(r'[A-Z][a-z]{0,2}\d*', w) or re.fullmatch(r'\d+[a-z]{0,2}', w) or w.isupper(): continue
            cnt[w] += 1; ctx.setdefault(w, t[max(0, m.start() - 45):m.end() + 45].replace('\n', ' '))
    with open(sortie, 'w', encoding='utf-8') as f:
        for w, n in sorted(cnt.items(), key=lambda x: x[0].lower()): f.write(f"{w}\t{ctx[w]}\n")
    return len(cnt), sum(cnt.values())
S = json.load(open(os.path.join(ICI, 'livre.json')))['sections']
print('II :', releve([s['titre'] for s in S] + [v[2] for s in S for l in s['evangiles'].values() for v in l] + [p['texte'] for s in S for p in s['paralleles']],
                     os.path.join(ICI, 'travail', 'douteux_II.txt')))
L = json.load(open(os.path.join(ICI, '..', 'livre.json')))
print('II* :', releve([s['titre'] for s in L['sections']] + [p['t'] for s in L['sections'] for p in s['paras']], os.path.join(ICI, 'travail', 'douteux_II_etoile.txt')))
