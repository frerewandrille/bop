#!/usr/bin/env python3
"""Bible chrétienne II — Les quatre Évangiles : structuration de l'OCR.

Entrée : travail/ocr/pPPP-K.tsv (ocr.sh ; PPP = planche du PDF, K = 1 gauche / 2 droite) et travail/table/
Sorties :
  table.json            la Table générale (§, titre, page, partie, section, réf. Mt/Mc/Lc/Jn)
  livre.json            le livre structuré par § : texte des Évangiles par colonne et par verset,
                        textes parallèles (référence, thème, texte), pages
  livre.md              le même, lisible, pour relire
  ../../data/bct/       pour la web app : index.js (window.__BCT_INDEX) et s/NNN.js (window.__BCT)

Relancer après toute correction : l'OCR ne se refait pas.
"""
import csv, json, os, re, shutil, sys
from collections import defaultdict

ICI = os.path.dirname(os.path.abspath(__file__))
OCR = os.path.join(ICI, 'travail', 'ocr')
DATA = os.path.join(ICI, '..', '..', 'data', 'bct')

PREMIERE = 14          # planche du PDF qui porte les pages 2-3
TABLE = range(336, 340)  # planches de la Table générale (pp. 646-653) ; la p. 645 (§ 1-27), mal lue, est saisie ci-dessous
DERNIERE_TEXTE = 333   # dernière planche de texte (avant les compléments)

def pages_imprimees(planche):
    g = 2 * (planche - PREMIERE + 1)
    return g, g + 1

# --------------------------------------------------------------------------- livres
LIVRES = {
 'Ab':'OBA','Ac':'ACT','Ag':'HAG','Am':'AMO','Ap':'REV','Ba':'BAR','1 Ch':'1CH','2 Ch':'2CH','1 Co':'1CO',
 '2 Co':'2CO','Col':'COL','Ct':'SNG','Dn':'DAN','Dt':'DEU','Ép':'EPH','Éph':'EPH','Ep':'EPH','Eph':'EPH','Esd':'EZR','Est':'EST','Ex':'EXO',
 'Éz':'EZK','Ez':'EZK','Ga':'GAL','Gn':'GEN','Ha':'HAB','Hé':'HEB','He':'HEB','Is':'ISA','Jb':'JOB','Jc':'JAS','Jdt':'JDT',
 'Jg':'JDG','Jl':'JOL','Jn':'JHN','1 Jn':'1JN','2 Jn':'2JN','3 Jn':'3JN','Jon':'JON','Jos':'JOS','Jr':'JER','Jude':'JUD',
 'Lc':'LUK','Lm':'LAM','Lv':'LEV','1 M':'1MA','2 M':'2MA','Mc':'MRK','Mi':'MIC','Ml':'MAL','Mt':'MAT','Na':'NAM',
 'Nb':'NUM','Né':'NEH','Os':'HOS','1 P':'1PE','2 P':'2PE','Ph':'PHP','Phm':'PHM','Pr':'PRO','Ps':'PSA','Qo':'ECC',
 '1 R':'1KI','2 R':'2KI','Rm':'ROM','Rt':'RUT','1 S':'1SA','2 S':'2SA','Sg':'WIS','Si':'SIR','So':'ZEP','Tb':'TOB',
 '1 Th':'1TH','2 Th':'2TH','1 Tm':'1TI','2 Tm':'2TI','Tt':'TIT','Za':'ZEC',
}
EV = {'Mt': 'MAT', 'Mc': 'MRK', 'Lc': 'LUK', 'Jn': 'JHN'}
EV_ORDRE = ['MAT', 'MRK', 'LUK', 'JHN']
EV_ABR = {v: k for k, v in EV.items()}
# lectures fautives fréquentes de l'OCR
OCR_LIVRE = {'Le': 'Lc', 'Lé': 'Lc', 'Ie': 'Lc', 'In': 'Jn', 'Jo': 'Jn', 'Mi': 'Mi', 'Di': 'Dt', 'Gm': 'Gn',
             'Sz': 'Sg', 'Ls': 'Is', 'ls': 'Is', 'Hb': 'Ha', 'Pe': 'Ps', 'Ys': 'Ps', 'Lv': 'Lv', 'Si': 'Si'}

ABR = sorted(LIVRES, key=len, reverse=True)
RX_REF = re.compile(r'^(?P<livre>' + '|'.join(re.escape(a) for a in ABR + list(OCR_LIVRE)) +
                    r')\s?(?P<ch>\d{1,3})\b(?!\s*[,.]\s*\d)')

def livre(abr):
    abr = OCR_LIVRE.get(abr, abr)
    return abr, LIVRES.get(abr)

_C = None
def correcteur():
    global _C
    if _C is None:
        from corrige import Correcteur
        _C = Correcteur()
    return _C

def nettoie(t):
    t = re.sub(r'\s+', ' ', t).strip()
    t = re.sub(r'(\w)- [:‘|] (\w)', r'\1- \2', t)                      # filets de colonne dans une coupure
    t = re.sub(r'(?<=[a-zéèàùç,\-]) [:‘|] (?=[a-zéèàùç])', ' ', t)       # filets de colonne
    t = re.sub(r'^[:‘|.] ', '', t)
    # coupures de fin de ligne : « jeû- naient » -> « jeûnaient », mais « Retire- toi » -> « Retire-toi »
    # (avec, entre les deux morceaux, un débris de filet ou de signe : « pro- ductions », « endu- - rera », « ins- ; tamment »)
    t = re.sub(r'([A-Za-zÀ-ÿœ]+)- (?:[^\w\s«»—]{1,3}\s|\(\w\)\s|[\-‘’_”:;|]\s?)*([a-zà-ÿœ]+)', lambda m: correcteur().joint(m.group(1), m.group(2)), t)
    t = t.replace(' ;', ' ;').replace("'", '’')
    return t

# --------------------------------------------------------------------------- lecture TSV
class Ligne:
    def __init__(self, mots):
        self.mots = mots
        self.x0 = min(m['x'] for m in mots); self.y0 = min(m['y'] for m in mots)
        self.x1 = max(m['x'] + m['w'] for m in mots); self.y1 = max(m['y'] + m['h'] for m in mots)
        self.texte = ' '.join(m['t'] for m in mots)
        hs = sorted(m['h'] for m in mots); self.h = hs[len(hs) // 2]

def lit_tsv(chemin):
    """-> liste de paragraphes, chacun liste de Ligne (ordre de lecture tesseract)."""
    paras = defaultdict(lambda: defaultdict(list)); ordre = []
    with open(chemin, encoding='utf-8') as f:
        for r in csv.DictReader(f, delimiter='\t', quoting=csv.QUOTE_NONE):
            if r['level'] != '5' or not (r['text'] or '').strip():
                continue
            kp = (int(r['block_num']), int(r['par_num']))
            if kp not in paras: ordre.append(kp)
            paras[kp][int(r['line_num'])].append(dict(t=r['text'].strip(), x=int(r['left']), y=int(r['top']),
                                                      w=int(r['width']), h=int(r['height']), c=float(r['conf'])))
    return [[Ligne(paras[k][l]) for l in sorted(paras[k])] for k in ordre]

def mots_page(chemin):
    out = []
    for p in lit_tsv(chemin):
        for l in p: out += l.mots
    return out

# --------------------------------------------------------------------------- Table générale
def rangs(mots, tol=14):
    mots = sorted(mots, key=lambda m: m['y'] + m['h'] / 2)
    rs = []
    for m in mots:
        yc = m['y'] + m['h'] / 2
        if rs and abs(rs[-1][0] - yc) <= tol:
            rs[-1][1].append(m); rs[-1][0] = (rs[-1][0] * (len(rs[-1][1]) - 1) + yc) / len(rs[-1][1])
        else:
            rs.append([yc, [m]])
    return [sorted(r[1], key=lambda m: m['x']) for r in rs]

L1 = 'LIVRE I: PRÉLUDES'
S1, S2, S3 = ('SECTION 1, LES DEUX PROLOGUES (§ 1-2)', 'SECTION 2, NAISSANCE ET ENFANCE (§ 3-18)',
              'SECTION 3, BAPTÊME ET TENTATION (§ 19-27)')
def _t(n, page, titre, section, **refs):
    return dict(n=str(n), titre=titre, page=page, partie=L1, section=section, **refs)
TABLE_645 = [   # saisie à la main d'après l'image de la p. 645
 _t(1, 2, 'Prologue de Saint-Jean', S1, Jn='1,1-18'), _t(2, 18, 'Prologue de Saint-Luc', S1, Lc='1,1-4'),
 _t(3, 20, 'L’Annonce à Zacharie', S2, Lc='1,5-25'), _t(4, 26, 'L’Annonce à Marie', S2, Lc='1,26-38'),
 _t(5, 32, 'La Visitation', S2, Lc='1,39-45'), _t(6, 34, 'Le Magnificat', S2, Lc='1,46-56'),
 _t(7, 40, 'Naissance et Circoncision de Jean-Baptiste', S2, Lc='1,57-66'), _t(8, 40, 'Le Benedictus', S2, Lc='1,67-80'),
 _t(9, 46, 'Naissance de Jésus', S2, Lc='2,1-7'), _t(10, 48, 'L’Annonce aux Bergers', S2, Lc='2,8-20'),
 _t(11, 50, 'Circoncision et Présentation de Jésus au Temple', S2, Lc='2,21-40'),
 _t(12, 56, 'Généalogie de Jésus', S2, Mt='1,1-17'), _t(13, 60, 'L’Annonce à Joseph', S2, Mt='1,18-25'),
 _t(14, 62, 'L’Adoration des Mages', S2, Mt='2,1-12'), _t(15, 66, 'La Fuite en Égypte', S2, Mt='2,13-15'),
 _t(16, 66, 'Le Massacre des Saints Innocents', S2, Mt='2,16-18'), _t(17, 68, 'Le Retour à Nazareth', S2, Mt='2,19-23'),
 _t(18, 68, 'Jésus retrouvé au Temple', S2, Lc='2,41-52'),
 _t(19, 72, 'Le Précurseur', S3, Mt='3,1-6', Mc='1,1-6', Lc='3,1-6', Jn='1,19-23'),
 _t(20, 76, 'La Prédication de Jean-Baptiste', S3, Mt='3,7-10', Lc='3,7-9'),
 _t(21, 78, 'Réponses de Jean-Baptiste', S3, Lc='3,10-14'),
 _t(22, 80, 'Jean-Baptiste annonce le Messie', S3, Mt='3,11-12', Mc='1,7-8', Lc='3,15-18', Jn='1,24-28'),
 _t(23, 82, 'L’Emprisonnement de Jean-Baptiste', S3, Mt='(§147)', Mc='(§147)', Lc='3,19-20'),
 _t(24, 82, 'Le Baptême de Jésus', S3, Mt='3,13-17', Mc='1,9-11', Lc='3,21-22', Jn='1,29-34'),
 _t(25, 86, 'Premières Vocations des Apôtres', S3, Jn='1,35-51'),
 _t(26, 90, 'Généalogie de Jésus selon Saint-Luc', S3, Lc='3,23-38'),
 _t(27, 92, 'Les Tentations au Désert', S3, Mt='4,1-11', Mc='1,12-13', Lc='4,1-13'),
]

CORRECTIONS_TABLE = {   # vérifiées sur l'image de la Table
    '183': {'Lc': '9,51-56'}, '215': {'Lc': '13,1-5'}, '349': {'Jn': '18,39-19,16a'}, '351': {'Jn': '19,16b-17a'},
}

def lit_table():
    """Table générale. Les § se suivent : on les numérote dans l'ordre (seul « 28 bis » s'intercale),
    le numéro lu par l'OCR ne sert qu'au contrôle."""
    entrees = []; partie = section = ''
    colx = None; fini = False
    for planche in TABLE:
        for k in (1, 2):
            ch = os.path.join(ICI, 'travail', 'table', f"{'ab'[k - 1]}{planche}-{planche}.tsv")   # OCR à 500 dpi (outils/ocr.sh)
            if not os.path.exists(ch) or fini: continue
            rs = rangs(mots_page(ch), tol=24)
            pagex = next((m['x'] for r in rs for m in r if m['t'] == 'PAGE'), None)
            if pagex is None: continue
            for r in rs:
                ts = [m['t'] for m in r]; texte = ' '.join(ts)
                evs = [m for m in r if m['t'] in ('Mt', 'Mc', 'Lc', 'Le', 'Jn')]
                if len(evs) >= 2 and len(evs) >= len(r) - 1:
                    colx = {('Lc' if m['t'] == 'Le' else m['t']): m['x'] for m in evs}
                    if len(colx) < 4:   # colonnes manquantes : espacement régulier
                        xs = sorted(colx.values()); pas = 292
                        base = colx.get('Mt', xs[0] - pas * (['Mt', 'Mc', 'Lc', 'Jn'].index(min(colx, key=colx.get))))
                        colx = {e: base + i * pas for i, e in enumerate(['Mt', 'Mc', 'Lc', 'Jn'])}
                    continue
                if texte.startswith('COMPLÉMENTS'): fini = True; break
                if re.match(r'^LIVRE\b', texte): partie = texte; continue
                if re.match(r'^SECTION\b', texte): section = re.sub(r'\(\$', '(§', texte); continue
                if r[0]['t'] in ('PAGE',) or re.fullmatch(r'\d{3}', texte): continue
                limite = (min(colx.values()) - 80) if colx else 1450
                gauche = [m for m in r if m['x'] < limite]
                droite = [m for m in r if m['x'] >= limite]
                g = [m for m in gauche if m['x'] > pagex + 80]          # sans la colonne PAGE
                pagem = [m for m in gauche if m['x'] <= pagex + 80]
                nx = pagex + 185
                entree = g and g[0]['x'] < nx + 90
                if entree and not partie: continue
                if entree:
                    toks = [m['t'] for m in g]
                    nlu = re.match(r'^(\d{1,3})', toks[0]); bis = 'bis.' in toks[:3]
                    j = 1
                    while j < len(g) and g[j]['x'] < nx + 90: j += 1
                    if bis: j = max(j, toks.index('bis.') + 1)
                    titre = ' '.join(toks[j:]).lstrip('. ')
                    p = pagem[0]['t'] if pagem else ''
                    e = dict(n=None, n_ocr=nlu.group(1) if nlu else None, bis=bis, titre=titre,
                             page=int(p) if p.isdigit() else None, partie=partie, section=section)
                    entrees.append(e)
                elif g and entrees:
                    entrees[-1]['titre'] += ' ' + ' '.join(m['t'] for m in g)
                if droite and entrees and colx:
                    e = entrees[-1]
                    for ev, x in colx.items():
                        val = ''.join(m['t'] for m in droite if abs(m['x'] - x) < 150)
                        if val: e[ev] = (e.get(ev, '') + val).replace('$', '§').replace('(8', '(§').replace('.', ',')
    # numérotation
    n = 27
    for e in entrees:
        if e.pop('bis'): e['n'] = f'{n} bis'
        else: n += 1; e['n'] = str(n)
        if e['n_ocr'] != e['n'].split()[0]: e['controle'] = f"OCR lit {e['n_ocr']}"
        e.pop('n_ocr'); e['titre'] = nettoie(e['titre']).strip(' ;:')
    entrees = [e for e in entrees if int(e['n'].split()[0]) <= 376]   # après : les Compléments
    # pages lues de travers (« 382 » pour « 362 ») : plus grandes que les suivantes
    ps = [e['page'] for e in entrees]
    for i, p in enumerate(ps):
        suiv = [q for q in ps[i + 1:i + 4] if q]
        if p and suiv and p > min(suiv): entrees[i]['page'] = None; entrees[i]['controle'] = f'page lue {p}'
    entrees = TABLE_645 + entrees
    PARTIES = {'I': 'I. Préludes', 'II': 'II. Les premiers temps', 'III': 'III. Jésus prépare l’avenir', 'IV': 'IV. Le sacrifice pascal'}
    for e in entrees:
        m = re.match(r'LIVRE\s+([IV{l1]+)', e['partie'])
        if m: e['partie'] = PARTIES.get(m.group(1).replace('{', 'I').replace('l', 'I').replace('1', 'I'), e['partie'])
        e.update(CORRECTIONS_TABLE.get(e['n'], {}))
    for a, b in zip(entrees, entrees[1:]):
        if b['page'] is None or (a['page'] and b['page'] < a['page']): b['page'] = a['page']
    return entrees

def refs_table(e):
    """« 4,12-17 » -> [code, ch1, v1, ch2, v2] ; ignore les renvois « (§ 139) »."""
    out = []
    for ev in ('Mt', 'Mc', 'Lc', 'Jn'):
        v = e.get(ev, '')
        if not v or v.startswith('(') or '§' in v: continue
        for morceau in re.split(r'\+', v):
            m = re.match(r'(\d+),(\d+)[ab]?(?:-(?:(\d+),)?(\d+)[ab]?)?', morceau)
            if m:
                c1, v1 = int(m[1]), int(m[2]); c2 = int(m[3] or c1); v2 = int(m[4] or v1)
                out.append([EV[ev], c1, v1, c2, v2])
    return out

# --------------------------------------------------------------------------- en-têtes de page
RX_HREF = re.compile(r'(?P<ev>Mt|Mc|Lc|Le|Jn|In)\s*_?(?P<c1>\d{1,2})\s*[,.]\s*(?P<v1>\d{1,3})[ab]?'
                     r'(?:\s*(?:-|à)\s*(?:(?P<c2>\d{1,2})\s*[,.]\s*)?(?P<v2>\d{1,3})[ab]?)?'
                     r'(?P<fl>\s*[—\-→>]+\s*\d{2,3})?')
RX_HPARA = re.compile(r'[$§S]\s?(\d{1,3}(?:\s?bis)?(?:-\d{1,3})?)')

def lit_entete(paras, cote):
    """Renvoie (§ de l'en-tête, [(code, c1, v1, c2, v2)] présents sur la page, paras sans l'en-tête)."""
    haut = [p for p in paras if p[0].y0 < 170]
    reste = [p for p in paras if p[0].y0 >= 170]
    texte = ' '.join(l.texte for p in haut for l in p)
    para = None
    m = RX_HPARA.search(texte)
    if m and cote == 1: para = m.group(1).replace(' ', '')
    presents = []
    for m in RX_HREF.finditer(texte):
        avant = texte[max(0, m.start() - 4):m.start()]
        if m['fl'] or re.search(r'[<←]\s*$', avant):
            continue   # « 84 ← Mt 4,1 → 92 » : Évangile absent de cette page
        ev = EV[{'Le': 'Lc', 'In': 'Jn'}.get(m['ev'], m['ev'])]
        c1, v1 = int(m['c1']), int(m['v1'])
        c2 = int(m['c2']) if m['c2'] else c1; v2 = int(m['v2']) if m['v2'] else v1
        presents.append((ev, c1, v1, c2, v2))
    return para, presents, reste, texte

# --------------------------------------------------------------------------- versets
CHIFFRES_OCR = str.maketrans({'I': '1', 'l': '1', 'i': '1', '!': '1', '|': '1', 'S': '5', 's': '5', '$': '5',
                              'O': '0', 'o': '0', 'B': '8', 'g': '9', 'Z': '2', '?': '7', '°': '6'})

def marque_verset(mot, hligne, debut):
    """Le mot est-il un numéro de verset (petit, en exposant) ? -> entier ou -1 (illisible) ou None."""
    t = mot['t'].strip('‘’\'"“”«»,.:;')
    if not t or len(t) > 3: return None
    petit = mot['h'] < 0.8 * hligne
    if re.fullmatch(r'\d{1,3}', t):
        return int(t) if (petit or debut) else None
    if petit and re.fullmatch(r'[\dIlS$?°!|*%#@\\]{1,3}', t):
        v = t.translate(CHIFFRES_OCR)
        return int(v) if v.isdigit() else -1
    return None

def decoupe_versets(lignes, c, v, cfin, vfin):
    """Texte d'une colonne d'Évangile -> [[ch, v, texte]] ; v = premier verset attendu."""
    out = []; cour = None
    hs = sorted(l.h for l in lignes) or [30]; href = hs[len(hs) // 2]
    attendu = (c, v)
    for li, l in enumerate(lignes):
        for mi, m in enumerate(l.mots):
            n = marque_verset(m, max(href, l.h), debut=(mi == 0))
            if n is not None and cour is not None or (n is not None and cour is None):
                ch, vv = attendu
                if n is not None and n > 0:
                    if n == 1 and vv > 2 and (cfin is None or ch + 1 <= cfin): ch, vv = ch + 1, 1
                    elif abs(n - vv) <= 3: vv = n
                if cour is not None or n is not None:
                    cour = [ch, vv, '']; out.append(cour); attendu = (ch, vv + 1)
                    continue
            if cour is None:
                cour = ['?', '?', '']; out.append(cour)   # suite d'un verset commencé avant
            cour[2] += ' ' + m['t']
    for o in out: o[2] = nettoie(o[2])
    return [o for o in out if o[2]]

# --------------------------------------------------------------------------- alignement sur la BJ
import unicodedata
BJ_DIR = os.path.join(ICI, '..', '..', 'data')
_bj = {}
VIDES = set("le la les un une des de du d l et a à au aux en dans sur pour par que qui ne pas se sa son ses il ils elle elles lui leur leurs "
            "je tu nous vous me te on ce cet cette ces y est était sont mais ou donc or car ni si plus tout tous comme avec dit".split())

def mots_cles(t):
    t = unicodedata.normalize('NFD', re.sub(r'<[^>]+>', ' ', t.lower()))
    t = ''.join(c for c in t if not unicodedata.combining(c))
    return {w[:5] for w in re.findall(r'[a-z]{3,}', t) if w not in VIDES}

def bj(code, c):
    k = (code, c)
    if k not in _bj:
        ch = os.path.join(BJ_DIR, code, f'{c:03d}.js'); _bj[k] = {}
        if os.path.exists(ch):
            d = json.loads(open(ch, encoding='utf-8').read().split('=', 1)[1].rstrip().rstrip(';'))
            for v in d.get('bj', []):
                m = re.match(r'\d+', str(v['v']))
                if m: _bj[k][int(m.group())] = mots_cles(v['t'])
    return _bj[k]

def candidats(plages):
    """[(code, c1, v1, c2, v2)] -> {code: [(c, v, mots)]} dans l'ordre."""
    out = {}
    for code, c1, v1, c2, v2 in plages:
        for c in range(c1, c2 + 1):
            vs = bj(code, c)
            for v in sorted(vs):
                if (c > c1 or v >= v1) and (c < c2 or v <= v2):
                    if (c, v) not in [(x[0], x[1]) for x in out.get(code, [])]:
                        out.setdefault(code, []).append((c, v, vs[v]))
    for code in out: out[code].sort(key=lambda x: (x[0], x[1]))
    return out

def score(seg, mots):
    if not seg or not mots: return 0.0
    return len(seg & mots) / (min(len(seg), len(mots)) ** 0.5 * max(len(seg), len(mots)) ** 0.5)

def segments(lignes):
    """Coupe un bloc aux numéros de verset probables -> [(n ou None, texte)]."""
    hs = sorted(l.h for l in lignes) or [30]; href = hs[len(hs) // 2]
    segs = [[None, '']]
    for l in lignes:
        for mi, m in enumerate(l.mots):
            n = marque_verset(m, max(href, l.h), debut=(mi == 0))
            if n is not None:
                segs.append([n, '']); continue
            segs[-1][1] += ' ' + m['t']
    return [(n, nettoie(t)) for n, t in segs if t.strip()]

RX_MARGE = re.compile(r'\s*\b(?:[1-3] ?)?[A-Z][a-zé]{0,2}\s?\d{1,3}\s?,\s?\d{1,3}(?:\s?,\s?\d{1,3})*(?:,? etc\.)?')
RX_PHRASE = re.compile(r'(?<=[.!?»;])\s+(?=[«A-ZÉÈÀ])')

def elague(t, mots):
    """Retire d'un verset les références de marge (« Mt 8,17 », « Ap 4, 10, etc. ») et, au début ou à la fin,
    les phrases sans aucun mot commun avec le verset de la BJ : bribes de parallèles prises dans la colonne."""
    t = RX_MARGE.sub(' ', t)
    ph = [x for x in RX_PHRASE.split(t) if x.strip()]
    vide = lambda x: len(mots_cles(x)) >= 3 and not (mots_cles(x) & mots)
    while len(ph) > 1 and vide(ph[0]): ph.pop(0)
    while len(ph) > 1 and vide(ph[-1]): ph.pop()
    return nettoie(' '.join(ph))

def aligne(blocs, plages):
    """blocs : [(lignes, page)] d'un § -> {code: [[c, v, texte, page]]}"""
    cands = candidats(plages)
    if not cands: return {}
    res = {}
    for lignes, page in blocs:
        segs = segments(lignes)
        if not segs: continue
        # Évangile du bloc : celui dont les versets ressemblent le plus à l'ensemble du bloc
        tout = set().union(*[mots_cles(t) for _, t in segs])
        best = max(cands, key=lambda code: max((score(tout, set().union(*[x[2] for x in cands[code][i:i + max(1, len(segs))]]))
                                                for i in range(len(cands[code]))), default=0))
        liste = cands[best]
        lst = res.setdefault(best, [])
        prec = None
        for n, t in segs:
            mk = mots_cles(t)
            notes = []
            for i, (c, v, mots) in enumerate(liste):
                sc = score(mk, mots)
                if n is not None and n > 0 and n == v: sc += 0.25
                if prec is not None and i == prec + 1: sc += 0.15
                if prec is not None and i <= prec: sc -= 0.3
                notes.append((sc, i))
            sc, i = max(notes)
            if (n is None and lst and prec is not None and sc < 0.45) or sc < 0.12:
                if lst: lst[-1][2] += ' ' + t      # suite du verset précédent
                continue
            c, v, mots = liste[i]
            t = elague(t, mots)
            if lst and lst[-1][0] == c and lst[-1][1] == v:
                lst[-1][2] += ' ' + t
            else:
                lst.append([c, v, t, page])
            prec = i
    for code in res:
        res[code].sort(key=lambda x: (x[0], x[1]))
        fus = []
        for x in res[code]:
            if fus and fus[-1][:2] == x[:2]: fus[-1][2] += ' ' + x[2]
            else: fus.append(x)
        res[code] = fus
    return res

# --------------------------------------------------------------------------- page
RX_TITRE_PARA = re.compile(r'^(\d{1,3})(?:\s?bis)?\s?[.,]\s+([A-ZÉÈÀÂÎÔÛÇ’\'« ][A-ZÉÈÀÂÎÔÛÇ’\'«»\-,: ]{3,}.*)$')

def analyse_page(planche, cote):
    ch = os.path.join(OCR, f'p{planche:03d}-{cote}.tsv')
    if not os.path.exists(ch): return None
    paras = lit_tsv(ch)
    page = pages_imprimees(planche)[cote - 1]
    para_entete, presents, paras, entete = lit_entete(paras, cote)
    blocs = []
    for p in paras:
        texte = nettoie(' '.join(l.texte for l in p))
        if not texte or len(re.sub(r'\W', '', texte)) < 2: continue
        x0 = min(l.x0 for l in p); x1 = max(l.x1 for l in p); y0 = p[0].y0
        blocs.append(dict(lignes=p, texte=texte, x0=x0, x1=x1, y0=y0, y1=max(l.y1 for l in p), w=x1 - x0))
    # « 1542 » pour « Is 42 », « 1s 53 » : le sigle d'Isaïe mal lu
    for b in blocs:
        b['texte'] = re.sub(r'^1[5s](\d{2})\b', r'Is \1', b['texte'])
        b['texte'] = re.sub(r'^1s (\d{1,2})\b', r'Is \1', b['texte'])
    # référence seule (« Is 11 ») lue comme un bloc à part, à gauche du texte qu'elle introduit : on les réunit
    for r in [b for b in blocs if len(b['lignes']) == 1 and RX_REF.fullmatch(b['texte'].strip()) is not None]:
        cible = next((b for b in blocs if b is not r and abs(b['y0'] - r['y0']) < 45 and b['x0'] > r['x1'] - 10
                      and not RX_REF.match(b['texte'])), None)
        if cible:
            cible['texte'] = r['texte'].strip() + ' ' + cible['texte']
            cible['x0'] = min(cible['x0'], r['x0']); cible['w'] = cible['x1'] - cible['x0']
            blocs.remove(r)
    return dict(planche=planche, cote=cote, page=page, para=para_entete, presents=presents,
                entete=entete, blocs=blocs)

def classe_blocs(pg, evangiles_planche):
    """Donne un type à chaque bloc : titre, theme, evangile (avec colonne), parallele, suite, marge."""
    largeur = 2150
    evs_page = pg['evs_page']
    nb = max(1, len(evs_page))
    dernier = None
    for b in pg['blocs']:
        t = b['texte']
        mt = RX_TITRE_PARA.match(t)
        mref = RX_REF.match(t)
        if mt and b['w'] < 1900:
            b['k'] = 'titre'; b['n'] = mt.group(1)
        elif re.match(r'^[«"].{2,60}[»"]$', t) or (b['x0'] > 900 and len(t) < 60 and not re.search(r'\d', t)
                                                   and b['w'] < 900 and len(b['lignes']) <= 2):
            b['k'] = 'theme'
        elif (pg['cote'] == 1 and b['x1'] < 260) or (pg['cote'] == 2 and b['x0'] > 1880):
            b['k'] = 'marge'
        elif mref and livre(mref['livre'])[1]:
            abr, code = livre(mref['livre']); c = int(mref['ch'])
            dedans = [e for e in evangiles_planche if e[0] == code and e[1] <= c <= e[3]]
            if dedans and code in evs_page and b['w'] < 0.7 * largeur * (2 if nb == 1 else 1):
                b['k'] = 'evangile'; b['ev'] = code
            else:
                b['k'] = 'parallele'; b['livre'] = code; b['abr'] = abr; b['ch'] = c
        elif dernier and dernier['k'] in ('parallele', 'suite') and not re.match(r'^\d', t) and (
                b['w'] > 0.62 * largeur or (0 <= b['y0'] - dernier['y1'] < 75 and b['x0'] >= dernier['x0'] - 40)):
            # suite d'un parallèle : pleine largeur, ou vers de poésie juste en dessous
            b['k'] = 'suite'
        else:
            b['k'] = 'evangile'     # candidat : l'alignement sur la BJ dira s'il l'est, et de quel Évangile
        if b['k'] == 'evangile' and 'ev' not in b:
            col = min(nb - 1, max(0, int((b['x0'] - 40) / (largeur / nb))))
            b['ev'] = evs_page[col] if evs_page else None
        if b['k'] not in ('marge', 'theme'):
            dernier = b

# --------------------------------------------------------------------------- assemblage
def principal():
    table = lit_table()
    print(f'Table générale : {len(table)} §', file=sys.stderr)
    with open(os.path.join(ICI, 'table.json'), 'w', encoding='utf-8') as f:
        json.dump(table, f, ensure_ascii=False, indent=0)
    debut = {}
    for e in table:
        debut.setdefault(e['n'], e['page'])

    pages = []
    for planche in range(PREMIERE, DERNIERE_TEXTE + 1):
        g = analyse_page(planche, 1); d = analyse_page(planche, 2)
        if not g or not d: continue
        evs = []
        for e in g['presents'] + d['presents']:
            if e[0] not in [x[0] for x in evs]: evs.append(e)
        evs.sort(key=lambda e: EV_ORDRE.index(e[0]))
        codes = [e[0] for e in evs]
        # combien de colonnes d'Évangile sur la page gauche ? (largeur des blocs étroits)
        etroits = [b for b in g['blocs'] if b['w'] < 1300 and b['x1'] > 260 and b['y0'] > 170]
        xs = sorted({round(b['x0'] / 300) for b in etroits if len(b['lignes']) >= 2})
        ncol_g = len(codes) if len(codes) <= 1 else min(len(codes), max(1, len(xs)))
        g['evs_page'] = codes[:ncol_g] if g['blocs'] else []
        d['evs_page'] = codes[ncol_g:]
        if not d['evs_page'] and len(codes) == 1 and not d['presents'] == []:
            d['evs_page'] = codes
        for pg in (g, d):
            classe_blocs(pg, evs)
            pg['evs_planche'] = evs
            pages.append(pg)

    # découpage en § : tous les § de la table existent ; un titre « 27. LES TENTATIONS… » ou,
    # à défaut, la page de départ donnée par la table fait passer au § suivant
    sections = []
    for e in table:
        sections.append(dict(n=e['n'], titre=e['titre'], page=e['page'], partie=e['partie'], section=e['section'],
                             refs=refs_table(e), table={k: e[k] for k in ('Mt', 'Mc', 'Lc', 'Jn') if k in e},
                             pages=[], evangiles={}, paralleles=[], textes=[]))
    idx = -1; blocs_ev = []
    def num(n): return n.split()[0]
    for pg in pages:
        titres = {num(b['n']) for b in pg['blocs'] if b['k'] == 'titre'}
        partants = [j for j in range(idx + 1, len(sections)) if sections[j]['page'] == pg['page']]
        hp = re.match(r'(\d{1,3})', pg['para'] or '')
        jh = None
        if hp:   # l'en-tête de la page gauche (« § 49-50 ») dit par quel § elle commence
            jh = next((j for j in range(max(idx, 0), min(idx + 8, len(sections))) if num(sections[j]['n']) == hp.group(1)), None)
        if jh is not None and jh > idx and hp.group(1) not in titres:
            idx = jh
        elif jh is None and partants and num(sections[partants[0]]['n']) not in titres:
            idx = partants[0]
        if idx < 0 and pg['page'] < 2: continue
        theme = None; premier = True
        for b in pg['blocs']:
            k = b['k']
            if k == 'titre':
                j = next((j for j in range(idx + 1, min(idx + 6, len(sections))) if num(sections[j]['n']) == num(b['n'])), None)
                if j is not None: idx = j; sections[idx]['titre_livre'] = b['texte']; theme = None
                continue
            if idx < 0: continue
            cour = sections[idx]
            if pg['page'] not in cour['pages']: cour['pages'].append(pg['page'])
            if k == 'theme':
                theme = b['texte'].strip('«»" ')
            elif k == 'evangile':
                blocs_ev.append((idx, b['lignes'], pg['page']))
            elif k == 'parallele':
                txt = re.sub(r'^\S+(?:\s\S+)?\s?\d{1,3}\s*', '', b['texte'], count=1) if b['abr'][0].isdigit() else \
                      re.sub(r'^\S+\s?\d{1,3}\s*', '', b['texte'], count=1)
                cour['paralleles'].append(dict(ref=f"{b['abr']} {b['ch']}", livre=b['livre'], ch=b['ch'],
                                               theme=theme, texte=txt, page=pg['page']))
            elif k == 'suite' and cour['paralleles']:
                cour['paralleles'][-1]['texte'] += ' ' + b['texte']
            elif k == 'marge':
                if cour['paralleles'] and cour['paralleles'][-1]['page'] == pg['page']:
                    cour['paralleles'][-1].setdefault('marge', []).append(b['texte'])
            elif k == 'texte' and premier and cour['paralleles']:
                cour['paralleles'][-1]['texte'] += ' ' + b['texte']    # suite d'un parallèle de la page précédente
            elif not re.fullmatch(r'[A-ZÉÈÀ’\' ]{4,60}', b['texte']):     # titres courants de partie : ignorés
                cour['textes'].append(dict(texte=b['texte'], page=pg['page']))
            if k not in ('marge', 'theme'): premier = False
    # textes d'Évangile : chaque bloc est aligné sur les versets des § voisins, puis chaque verset
    # va au § qui le contient (une page porte souvent la fin d'un § et le début du suivant)
    num_sec = {num(x['n']): x for x in sections}
    def plages_de(s):
        pl = [tuple(r) for r in s['refs']]
        for ev, val in s['table'].items():          # textes déplacés « (§ 98) » : leurs versets aussi
            for m in re.findall(r'§(\d+)', val):
                if m in num_sec: pl += [tuple(r) for r in num_sec[m]['refs'] if r[0] == EV[ev]]
        return pl
    def contient(s, code, c, v):
        return any(r[0] == code and (r[1], r[2]) <= (c, v) <= (r[3], r[4]) for r in plages_de(s))
    for s in sections: s['evangiles'] = {}
    for i, lignes, page in blocs_ev:
        voisins = [j for j in (i, i + 1, i - 1, i + 2, i + 3) if 0 <= j < len(sections)]
        plages = [p for j in voisins for p in plages_de(sections[j])]
        al = aligne([(lignes, page)], plages)
        if not al:
            t = nettoie(' '.join(l.texte for l in lignes))
            if not re.fullmatch(r'[A-ZÉÈÀ’\' .,0-9]{3,80}', t) and not re.match(r'^(Suite|Voir)\b', t):
                sections[i]['textes'].append(dict(texte=t, page=page))
        for code, lst in al.items():
            for c, v, t, p in lst:
                j = next((j for j in voisins if contient(sections[j], code, c, v)), i)
                dest = sections[j]['evangiles'].setdefault(code, [])
                old = next((x for x in dest if x[0] == c and x[1] == v), None)
                if old: old[2] += ' ' + t
                else: dest.append([c, v, t, p])
    for s in sections:
        for code in s['evangiles']: s['evangiles'][code].sort(key=lambda x: (x[0], x[1]))
        for ev, lst in s['evangiles'].items():
            for v in lst: v[2] = re.sub(r'^\(?(?:Mt|Mc|Mec|Lc|Le|Jn|In)\s?\d{1,2}\s?,\s?[\d\-ab ]+(?:=\s?[$§]\s?\d+\))?\s*:?\s*', '', nettoie(v[2]))
        for p in s['paralleles']:
            p['texte'] = re.sub(r'^(?:[\d#?!*%$°\'’‘"\\|@®©]{1,4}\s+)+', '', nettoie(p['texte']))   # n° de verset mal lu en tête
            # premier verset du parallèle, retrouvé dans la BJ (le petit chiffre est souvent mal lu)
            debut = mots_cles(' '.join(p['texte'].split()[:22]))
            vs = bj(p['livre'], p['ch']) if p['livre'] else {}
            if vs and debut:
                sc, v = max((score(debut, m) + (0.05 if i == 0 else 0), v) for i, (v, m) in enumerate(sorted(vs.items())))
                if sc >= 0.2: p['v'] = v; p['ref'] = f"{p['ref']},{v}"

    # fautes d'OCR, mot à mot, d'après le contexte (corrige.py) ; relevé dans corrections.tsv
    C = correcteur(); C.manuelles(os.path.join(ICI, 'corrections_manuelles.tsv'))
    C.prepare([s['titre'] for s in sections] + [v[2] for s in sections for l in s['evangiles'].values() for v in l]
              + [p['texte'] for s in sections for p in s['paralleles']])
    for s in sections:
        s['titre'] = C.applique_manuelles(C.texte(s['titre']))
        for lst in s['evangiles'].values():
            for v in lst: v[2] = C.applique_manuelles(C.texte(v[2], evangile=True))
        for p in s['paralleles']: p['texte'] = C.applique_manuelles(C.texte(p['texte']))
    C.releve(os.path.join(ICI, 'corrections.tsv'))
    print(f"corrections : {sum(C.faites.values())} ({len(C.faites)} formes) — voir corrections.tsv", file=sys.stderr)

    livre = dict(titre='Bible chrétienne II — Les quatre Évangiles',
                 auteurs='Mère Élisabeth de Solms (traduction) ; Dom Claude Jean-Nesmy (parallèles) ; Mère Cécile Miville-Dechêne',
                 edition='Éditions Anne Sigier / Desclée, 1988',
                 source='Scan Internet Archive (biblechretienne0000unse), OCR tesseract corrigé automatiquement (corrige.py), non relu',
                 sections=sections)
    with open(os.path.join(ICI, 'livre.json'), 'w', encoding='utf-8') as f:
        json.dump(livre, f, ensure_ascii=False, indent=1)
    ecrit_md(livre)
    if os.environ.get('BCT_SANS_DATA'): print('data/bct non écrit (BCT_SANS_DATA)', file=sys.stderr)
    else: ecrit_data(livre, table)
    vides = [s['n'] for s in sections if not s['evangiles']]
    print(f"{len(sections)} § ; {sum(len(s['paralleles']) for s in sections)} parallèles ; "
          f"{sum(len(l) for s in sections for l in s['evangiles'].values())} versets ; § sans texte d'Évangile : {len(vides)}",
          file=sys.stderr)

def ecrit_md(livre):
    L = [f"# {livre['titre']}", '', livre['auteurs'] + ' — ' + livre['edition'], '',
         '> ' + livre['source'] + '. Chaque bloc indique sa page (p. N).', '']
    for s in livre['sections']:
        L += ['', f"## § {s['n']}. {s['titre']}  (p. {s['page']})", '']
        if s['table']: L += ['*' + ' · '.join(f'{k} {v}' for k, v in s['table'].items()) + '*', '']
        for ev in EV_ORDRE:
            if ev not in s['evangiles']: continue
            L += [f"### {EV_ABR[ev]}", '']
            L += [' '.join(f"<sup>{v[0]},{v[1]}</sup> {v[2]}" for v in s['evangiles'][ev]), '']
        theme = None
        if s['paralleles']: L += ['### Parallèles', '']
        for p in s['paralleles']:
            if p['theme'] != theme and p['theme']:
                L += [f"**« {p['theme']} »**", '']; theme = p['theme']
            marge = f"  ⟨marge : {' ; '.join(p['marge'])}⟩" if p.get('marge') else ''
            L += [f"- *{p['ref']}* — {p['texte']}  ⟨p. {p['page']}⟩{marge}"]
        for t in s['textes']:
            L += ['', f"{t['texte']}  ⟨p. {t['page']}⟩"]
    with open(os.path.join(ICI, 'livre.md'), 'w', encoding='utf-8') as f:
        f.write('\n'.join(L) + '\n')

def cle(n):
    return n.replace(' ', '')   # « 28 bis » -> « 28bis »

def ecrit_data(livre, table):
    if os.path.isdir(DATA): shutil.rmtree(DATA)
    os.makedirs(os.path.join(DATA, 's'))
    index = dict(livre={k: livre[k] for k in ('titre', 'auteurs', 'edition', 'source')}, sections=[], num={}, chap={})
    for s in livre['sections']:
        k = cle(s['n'])
        index['sections'].append(dict(k=k, n=s['n'], t=s['titre'], p=s['page'], r=s['refs'],
                                      partie=s['partie'], section=s['section']))
        index['num'][s['n']] = k
        for code, c1, v1, c2, v2 in s['refs']:
            for c in range(c1, c2 + 1):
                index['chap'].setdefault(code, {}).setdefault(str(c), []).append(k)
        sec = dict(n=s['n'], titre=s['titre'], page=s['page'], pages=s['pages'], partie=s['partie'], section=s['section'],
                   refs=s['refs'], table=s['table'],
                   ev={ev: [[v[0], v[1], v[2]] for v in lst] for ev, lst in s['evangiles'].items()},
                   par=[{x: p[x] for x in ('ref', 'livre', 'ch', 'v', 'theme', 'texte', 'page', 'marge') if p.get(x) is not None}
                        for p in s['paralleles']])
        with open(os.path.join(DATA, 's', f'{k}.js'), 'w', encoding='utf-8') as f:
            f.write('window.__BCT=' + json.dumps(sec, ensure_ascii=False, separators=(',', ':')) + ';\n')
    with open(os.path.join(DATA, 'index.js'), 'w', encoding='utf-8') as f:
        f.write('window.__BCT_INDEX=' + json.dumps(index, ensure_ascii=False, separators=(',', ':')) + ';\n')

if __name__ == '__main__':
    principal()
