#!/usr/bin/env python3
"""Correction des fautes d'OCR, mot à mot, en choisissant d'après le contexte.

Référence : le texte français de la Bible de Jérusalem (data/<LIVRE>/NNN.js), qui donne
  - un lexique (27 000 formes, avec leur fréquence),
  - les paires de mots voisins (bigrammes), pour juger d'un mot d'après ceux qui l'entourent,
complété par les mots que tesseract a lus avec une grande confiance dans ce livre même
(noms propres, vocabulaire de la traduction de Mère de Solms).

Pour un mot inconnu, on essaie les confusions typiques de l'OCR (1/l/i, I/l, c/e, rn/m, accents…),
la coupure en deux mots (« Situ » -> « Si tu ») et le trait d'union perdu (« Retiretoi » -> « Retire-toi »).
On garde la proposition connue qui s'accorde le mieux avec ses voisins. Un mot connu mais douteux
(« maïs » entre deux mots où « mais » est attendu) n'est changé que si le contexte le demande nettement.

    from corrige import Correcteur ; C = Correcteur() ; C.texte("Carilest écrit")  -> "Car il est écrit"
"""
import csv, glob, json, math, os, re, subprocess, tempfile, unicodedata
from collections import Counter

ICI = os.path.dirname(os.path.abspath(__file__))
DATA = os.path.join(ICI, '..', '..', 'data')
OCR = os.path.join(ICI, 'travail', 'ocr')

MOT = re.compile(r"[A-Za-zÀ-ÖØ-öø-ÿœŒæÆ0-9]+")
# confusions de l'OCR : (lu, voulu)
CONFUSIONS = [('1', 'l'), ('1', 'i'), ('1', 'I'), ('l', 'i'), ('i', 'l'), ('I', 'l'), ('l', 'I'), ('Î', 'I'), ('î', 'i'),
              ('J', 'l'), ('J', 'I'), ('J', 'f'), ('j', 'f'), ('j', 'i'), ('0', 'o'), ('O', 'o'), ('rn', 'm'), ('m', 'rn'), ('c', 'e'), ('e', 'c'),
              ('é', 'è'), ('è', 'é'), ('ê', 'é'), ('ê', 'è'), ('é', 'ê'), ('é', 'e'), ('e', 'é'), ('a', 'à'), ('à', 'a'), ('ü', 'u'),
              ('ü', 'û'), ('ï', 'i'), ('c', 'ç'), ('ç', 'c'), ('v', 'y'), ('y', 'v'), ('f', 't'), ('t', 'f'),
              ('n', 'u'), ('u', 'n'), ('h', 'b'), ('b', 'h'), ('cl', 'd'), ('li', 'h'), ('ii', 'ü'), ('g', 'q'), ('q', 'g'),
              ('s', 'e'), ('5', 's'), ('S', 's'), ('E', 'É'), ('A', 'À'), ('o', 'ô'), ('u', 'û'), ('i', 'î'), ('a', 'â'),
              ('ö', 'ô'), ('ä', 'â'), ('ë', 'é'), ('r', 't'), ('t', 'r'), ('n', 'r'), ('fi', 'fl'), ('I', 'T'), ('T', 'I'), ('i', 't'), ('u', 'a'), ('al', 'ai'), ('h', 'n'), ('ñ', 'û'), ('ä', 'a'), ('ïi', 'ï'), ('iï', 'ï'), ('äü', 'a'), ('vv', 'yy'), ('vv', 'y'), ('n', 'h'), ('rn', 'n'), ('m', 'n')]
# petits mots qui suivent un trait d'union : « dit-il », « lui-même », « soixante-dix »
APRES_TRAIT = {'toi', 'moi', 'lui', 'elle', 'elles', 'il', 'ils', 'nous', 'vous', 'le', 'la', 'les', 'en', 'y', 'même',
               'mêmes', 'ci', 'là', 'on', 'dix', 'deux', 'trois', 'quatre', 'cinq', 'six', 'sept', 'huit', 'neuf', 'je', 'tu',
               'leur', 'leurs', 'ce', 't'}
VIDES_DOUTEUX = {'dé': 'de', 'maïs': 'mais', 'Maïs': 'Mais', 'ls': 'ils', 'Ls': 'Ils', 'll': 'il', 'Ll': 'Il', 'Îl': 'Il', 'Îls': 'Ils'}
# mots qui ne prennent jamais de trait d'union avant un pronom (« si tu », « car il »)
OUTILS = set('que qui mais car donc comme quand lorsque puis alors dont avec pour sans dans sous vers chez entre parce afin tous '
             'tout cela ceci celui celle plus très bien aussi encore ainsi voici voilà non oui pas point jamais rien ces ses mes '
             'tes nos vos leurs une des les aux par sur où et si ni or'.split())
PRONOMS_INVERSES = {'il', 'elle', 'ils', 'elles', 'on', 'toi', 'moi', 'nous', 'vous', 'le', 'la', 'les', 'lui', 'leur', 'en', 'y', 'je', 'tu'}   # formes rares de la BJ, presque toujours des fautes ici


ACCENTS = {('ñ','û'),('ä','a'),('ïi','ï'),('iï','ï'),('é','è'),('è','é'),('ê','é'),('ê','è'),('é','ê'),('é','e'),('e','é'),('a','à'),('à','a'),('ü','u'),('ü','û'),('ï','i'),('i','ï'),
           ('c','ç'),('ç','c'),('E','É'),('A','À'),('o','ô'),('u','û'),('i','î'),('a','â'),('ö','ô'),('ä','â'),('ë','é'),('Î','I'),('î','i')}
LETTRES_1 = {('1','l'),('1','i'),('1','I'),('l','i'),('i','l'),('I','l'),('l','I'),('J','l'),('J','I'),('J','f'),('j','f'),('j','i'),('0','o'),('O','o')}
# noms propres : on ne retouche que ce que l'impression ou l'OCR ont abîmé (accent sur la majuscule, ä/ü/ï pour â/û/i),
# jamais l'orthographe propre à la traduction (« Onan », « Gabaon », « Nébo » restent tels quels)
PROPRE_OK = {('E', 'É'), ('A', 'À'), ('ä', 'â'), ('ö', 'ô'), ('ü', 'û'), ('ï', 'i'), ('Î', 'I')}
def cout(a, b): return 0.6 if (a, b) in (('v', 'y'), ('al', 'ai')) else 0.5 if (a, b) == ('ü', 'u') else 0.3 if (a, b) in ACCENTS else 0.6 if (a, b) in LETTRES_1 else 1.0
# sigles et abréviations à ne jamais corriger
OUTIL_COURT = set('car il ils est es et je te tu si ne en on la le les qui que un une mais quand ce se de du au à tout tous pas sur par pour dans plus sans avec'.split())
PROTEGES = set('ère ères jeu jeux Dom Ibid ibid Cf cf op cit art col éd trad Lxx Vg TOB BJ'.split())
SIGLES = set('Ab Ac Ag Am Ap Ba Ch Co Col Ct Dn Dt Ép Éph Esd Est Ex Éz Ga Gn Ha Hé Is Jb Jc Jdt Jg Jl Jn Jon Jos Jr Jude Lc Lm Lv '
             'Mc Mi Ml Mt Na Nb Né Os Ph Phm Pr Ps Qo Rm Rt Sg Si So Tb Th Tm Tt Za Vg Lxx LXX cf Cf p ss etc'.split())

def sans_accent(w):
    return ''.join(c for c in unicodedata.normalize('NFD', w) if not unicodedata.combining(c))

PAIRES_OCR = {(a.lower(), b.lower()) for a, b in CONFUSIONS if len(a) == 1 and len(b) == 1}
def cout_ocr(w, c):
    """Coût d'une faute d'OCR plausible qui mène de c (vrai mot) à w (lu), ou None si ce n'est pas une faute d'OCR :
    lettre oubliée (0,5), lettre en trop (0,7), lettre de forme voisine ou accent (0,4), autre lettre (1) ;
    jamais de changement à la fin du mot (accord, conjugaison), sauf r/t (« aimair »)."""
    import difflib
    a, b = w.lower(), c.lower()
    total = 0.0
    for tag, i1, i2, j1, j2 in difflib.SequenceMatcher(None, a, b).get_opcodes():
        if tag == 'equal': continue
        fin = i2 >= len(a) - 1 or j2 >= len(b) - 1
        if i1 == 0 and tag != 'replace': return None              # on ne touche pas à la première lettre
        if tag == 'insert':
            # lettre perdue : seulement une lettre fine, que l'OCR laisse échapper (« affrmation », « fuleurante »)
            if j2 - j1 > 2 or fin or any(x not in 'iltfrg' for x in b[j1:j2]): return None
            total += 0.5 * (j2 - j1)
        elif tag == 'delete':
            # lettre en trop : un trait parasite ou une lettre doublée (« accompplissement », « Testamenits »)
            if i2 - i1 > 1 or fin or not (a[i1] in 'il1|.\'' or (i1 > 0 and a[i1] == a[i1 - 1]) or (i1 + 1 < len(a) and a[i1] == a[i1 + 1])): return None
            total += 0.7
        else:
            if i2 - i1 != j2 - j1 or i2 - i1 > 2: return None
            for x, y in zip(a[i1:i2], b[j1:j2]):
                ocr = (x, y) in PAIRES_OCR or sans_accent(x) == sans_accent(y)
                if fin and not ((x, y) in (('r', 't'), ('t', 'r')) or sans_accent(x) == sans_accent(y)): return None
                total += 0.4 if ocr else 1.0
    return total if total <= 0.9 else None   # une lettre quelconque remplacée (1) ne passe pas : « Segond », « Thèbes »

def une_retouche_interne(a, b):
    """Une seule lettre changée, ajoutée ou ôtée, mais pas à la fin du mot (« Apôtires » -> « Apôtres » oui ;
    « Loisy » -> « Lois » non : un nom propre ne perd pas sa fin)."""
    import difflib
    ops = [o for o in difflib.SequenceMatcher(None, a.lower(), b.lower()).get_opcodes() if o[0] != 'equal']
    if len(ops) != 1: return False
    tag, i1, i2, j1, j2 = ops[0]
    if max(i2 - i1, j2 - j1) > 1: return False
    return i2 < len(a) and j2 < len(b)

def casse(modele, mot):
    if modele.isupper() and len(modele) > 1 and not re.search(r'\d', modele): return mot.upper()
    if modele[:1].isupper() or modele[:1] in '1Î': return mot[:1].upper() + mot[1:]
    return mot


class Correcteur:
    def __init__(self):
        self.lex = Counter(); self.bi = Counter(); self.traits = set(); self.maj = Counter()
        for f in glob.glob(os.path.join(DATA, '*', '[0-9][0-9][0-9].js')):
            try: d = json.loads(open(f, encoding='utf-8').read().split('=', 1)[1].rstrip().rstrip(';'))
            except Exception: continue
            for v in d.get('bj', []) if isinstance(d, dict) else []:
                t = re.sub(r'<sup.*?</sup>', '', v.get('t', '')); t = re.sub(r'<[^>]+>', ' ', t)
                self.traits.update(x.lower() for x in re.findall(r"[A-Za-zÀ-ÿœ]+-[A-Za-zÀ-ÿœ]+", t))
                brut = [w for w in MOT.findall(t) if not w.isdigit()]
                for a, b in zip(brut, brut[1:]):
                    if b[:1].isupper(): self.maj[b.lower()] += 1
                ws = [w.lower() for w in brut]
                self.lex.update(ws); self.bi.update(zip(ws, ws[1:]))
        # mots lus avec certitude par tesseract dans ce livre (au moins 2 fois, confiance >= 93)
        sur = Counter()
        for f in glob.glob(os.path.join(OCR, '*.tsv')):
            with open(f, encoding='utf-8') as fh:
                for r in csv.DictReader(fh, delimiter='\t', quoting=csv.QUOTE_NONE):
                    t = (r.get('text') or '').strip()
                    if r.get('level') == '5' and t and float(r.get('conf') or 0) >= 93:
                        for w in MOT.findall(t):
                            if not re.search(r'\d', w) and len(w) > 2: sur[w.lower()] += 1
        bj = set(self.lex)
        colle = lambda w: any(w[:i] in bj and w[i:] in bj for i in range(2, len(w) - 1))   # « luimême » : deux mots collés
        for w, n in sur.items():
            if n >= 2 and w not in self.lex and not colle(w): self.lex[w] = 1   # soumis au contrôle de connu()
        # latin (Vulgate : champ « lat » des chapitres) : citations latines du commentaire (« Veni », « esse », « Ecce »)
        self.latin = set()
        for f in glob.glob(os.path.join(DATA, '*', '[0-9][0-9][0-9].js')):
            try: d = json.loads(open(f, encoding='utf-8').read().split('=', 1)[1].rstrip().rstrip(';'))
            except Exception: continue
            for vs in (d.get('lat') or {}).values() if isinstance(d, dict) else []:
                for t in (vs.values() if isinstance(vs, dict) else []):
                    self.latin.update(w.lower() for w in MOT.findall(str(t)) if not w.isdigit())
        self.latin -= set(self.lex)
        # vocabulaire plus large, sans fréquence : dictionnaires bibliques de l'application, lexique de tesseract
        self.ext = self.vocabulaire()
        # forme accentuée attestée pour chaque forme sans accent (« episode » -> « épisode », « affirmee » -> « affirmée »)
        self.accent = {}
        for w in list(self.lex) + list(self.ext):
            if w != sans_accent(w):
                k = sans_accent(w); old = self.accent.get(k)
                if old is None or self.lex.get(w, 0) > self.lex.get(old, 0): self.accent[k] = w
        self.faites = Counter()   # (avant, après) -> nombre, pour le relevé
        # correcteur orthographique de macOS : mot -> (juste ?, propositions) ; cache dans travail/orthographe_mac.tsv
        self.mac = {}; self._mac_fichier = os.path.join(ICI, 'travail', 'orthographe_mac.tsv')
        if os.path.exists(self._mac_fichier):
            for l in open(self._mac_fichier, encoding='utf-8'):
                p = l.rstrip('\n').split('\t')
                if len(p) >= 2: self.mac[p[0]] = (p[1] == 'ok', [x for x in (p[2] if len(p) > 2 else '').split('|') if x])
        self._hapax = {}; self._ext_ok = {}

    # ------------------------------------------------------------------ jugement
    def vocabulaire(self):
        cache = os.path.join(ICI, 'travail', 'vocabulaire.txt')
        if os.path.exists(cache) and os.path.exists(cache + '.dico'):
            self.dico = set(open(cache + '.dico', encoding='utf-8').read().split())
            return set(open(cache, encoding='utf-8').read().split())
        v = set()
        for f in glob.glob(os.path.join(DATA, 'dico', '*', '*.js')):
            t = re.sub(r'<[^>]+>', ' ', open(f, encoding='utf-8').read())
            v.update(w.lower() for w in re.findall(r"[a-zà-ÿœæ]{3,}", t))      # mots en minuscules seulement : pas les sigles
        self.dico = set(v)
        with open(cache + '.dico', 'w', encoding='utf-8') as fh: fh.write('\n'.join(sorted(self.dico)))
        tess = os.path.join(ICI, 'travail', 'mots_tesseract_fra.txt')   # combine_tessdata -u fra.traineddata ; dawg2wordlist
        if os.path.exists(tess): v.update(w.strip().lower() for w in open(tess, encoding='utf-8') if len(w.strip()) >= 4)
        with open(cache, 'w', encoding='utf-8') as fh: fh.write('\n'.join(sorted(v)))
        return v

    def prepare(self, textes):
        """Fait vérifier par macOS, en une fois, tous les mots que la BJ ne connaît pas (et les garde en cache)."""
        a_voir = set()
        for t in textes:
            for w in MOT.findall(t or ''):
                if len(w) >= 2 and not w.isdigit() and self.lex.get(w.lower(), 0) < 2 and w not in self.mac: a_voir.add(w)
        if not a_voir: return
        js = os.path.join(ICI, 'orthographe_mac.js')
        with tempfile.NamedTemporaryFile('w', suffix='.txt', delete=False, encoding='utf-8') as f:
            f.write('\n'.join(sorted(a_voir))); nom = f.name
        try:
            r = subprocess.run(['osascript', '-l', 'JavaScript', js, nom, 'guess'], capture_output=True, text=True, timeout=1800)
            with open(self._mac_fichier, 'a', encoding='utf-8') as out:
                for l in r.stdout.splitlines():
                    p = l.split('\t')
                    if len(p) >= 2:
                        self.mac[p[0]] = (p[1] == 'ok', [x for x in (p[2] if len(p) > 2 else '').split('|') if x])
                        out.write(l + '\n')
        except Exception as e:
            print('correcteur de macOS indisponible :', e)
        finally:
            os.unlink(nom)
        self._hapax.clear(); self._ext_ok.clear()

    def mac_ok(self, w):
        if len(w) <= 3 or re.search(r'\d', w) or w in VIDES_DOUTEUX: return False   # macOS accepte « ls », « 1l », « maïs »…
        r = self.mac.get(w) or self.mac.get(w.lower())
        return bool(r and r[0])

    def propre(self, w):
        """Nom propre selon la BJ (écrit avec une majuscule dans plus de 80 % des cas)."""
        w = w.lower(); n = self.lex.get(w, 0)
        return n > 0 and self.maj[w] >= 0.8 * n

    def connu(self, w):
        """Connu : vu au moins deux fois. Un mot vu une seule fois dans la BJ (coquille possible : « luimême »)
        n'est connu que s'il n'est ni deux mots collés, ni à une confusion d'un mot fréquent."""
        if self.mac_ok(w): return True
        if w in self.mac or w.lower() in self.mac:          # macOS l'a refusé : seule la BJ (deux fois au moins) le sauve
            return self.lex.get(w.lower(), 0) > 1
        w = w.lower(); n = self.lex.get(w, 0)
        if n > 1: return True
        if n == 0:
            if w not in self.ext: return False
            if w not in self._ext_ok:
                debris = (any(self.lex.get(w[:i], 0) > 50 and self.lex.get(w[i:], 0) > 50 for i in range(2, len(w) - 1))
                          or any(self.lex.get(l + w, 0) >= 50 for l in 'abcdefghijlmnopqrstuvy')
                          or any(self.lex.get(w.replace(a.lower(), b.lower(), 1), 0) >= 200 for a, b in CONFUSIONS if a.lower() in w))
                self._ext_ok[w] = len(w) >= 4 and not debris
            return self._ext_ok[w]
        if w not in self._hapax:
            colle = any(self.lex.get(w[:i], 0) > 1 and self.lex.get(w[i:], 0) > 1 for i in range(2, len(w) - 1))
            proche = any(self.lex.get(c.lower(), 0) >= 50 for a, b in CONFUSIONS for c in [w.replace(a.lower(), b.lower(), 1)] if c != w)
            self._hapax[w] = not (colle or proche) or w in self.ext
        return self._hapax[w]
    def freq(self, w):
        n = self.lex.get(w.lower(), 0)
        if n: return n
        lo = w.lower()
        return 3 if (lo in self.dico or self.mac_ok(w)) else 0
    def note(self, mots, avant, apres):
        """mots : liste de 1 à 3 mots qui remplacent le mot fautif ; note = fréquence + accord avec les voisins."""
        s = sum(math.log1p(self.freq(m)) for m in mots) / len(mots)
        if avant: s += 2.0 * math.log1p(self.bi[(avant.lower(), mots[0].lower())])
        if apres: s += 2.0 * math.log1p(self.bi[(mots[-1].lower(), apres.lower())])
        for a, b in zip(mots, mots[1:]): s += 1.0 * math.log1p(self.bi[(a.lower(), b.lower())])
        return s

    LETTRES = 'abcdefghijklmnopqrstuvwxyzàâçéèêëîïôûùœ'
    def proches(self, w):
        """Mots du vocabulaire à une lettre près (ajout, oubli, remplacement, inversion) : « affrmation » -> « affirmation »."""
        lo = w.lower(); out = set()
        for i in range(len(lo) + 1):
            for l in self.LETTRES:
                out.add(lo[:i] + l + lo[i:])
                if i < len(lo): out.add(lo[:i] + l + lo[i + 1:])
            if i < len(lo): out.add(lo[:i] + lo[i + 1:])
            if i < len(lo) - 1: out.add(lo[:i] + lo[i + 1] + lo[i] + lo[i + 2:])
        out.discard(lo)
        def ok(c):
            if len(c) < 4 or not (self.lex.get(c, 0) >= 3 or c in self.dico): return False
            if c[:1] != lo[:1] and c[1:2] != lo[1:2]: return False          # première lettre : remplacée seulement, jamais ôtée ni ajoutée
            if c[:-2] == lo[:-2] and not (lo.endswith('r') and c == lo[:-1] + 't'):
                return False                                                # fin du mot (accord, conjugaison) : on n'y touche pas, sauf r/t
            if c.endswith('s') != lo.endswith('s'): return False
            return True
        return [c for c in out if ok(c)]

    def candidats(self, w):
        """Propositions pour un mot inconnu : [(texte, nombre de retouches)]."""
        out = {}
        def ajoute(c, k):
            if c and (c not in out or out[c] > k): out[c] = k
        # une ou deux confusions
        un = {}
        for a, b in CONFUSIONS:
            i = w.find(a)
            while i >= 0:
                c = w[:i] + b + w[i + len(a):]; un[c] = cout(a, b)
                if self.connu(c): ajoute(c, cout(a, b))
                i = w.find(a, i + 1)
        for c, k in self.initiale(w): ajoute(c, k)
        r = self.mac.get(w)
        if r and not r[0]:
            for rang, c in enumerate(r[1]):
                if ' ' in c or '-' in c:
                    if all(x.lower() in OUTIL_COURT for x in re.split(r'[ -]', c)): ajoute(c, 0.6)
                    continue
                k = cout_ocr(w, c)
                if k is not None: ajoute(c, 0.3 + k + 0.05 * rang)
        if len(w) <= 12:
            for c1 in list(un):
                for a, b in CONFUSIONS[:12]:   # deuxième retouche : seulement 1/l/i/I/J/0
                    i = c1.find(a)
                    while i >= 0:
                        c = c1[:i] + b + c1[i + len(a):]
                        if self.connu(c): ajoute(c, un[c1] + cout(a, b))
                        i = c1.find(a, i + 1)
        # mots collés : deux ou trois mots connus (« Situ », « Carilest »), y compris après une confusion
        for base, k0 in [(w, 0)] + [(c, k) for c, k in un.items() if len(c) == len(w)][:40]:
            for i in range(1, len(base)):
                g, d = base[:i], base[i:]
                if self.connu(g) and (len(g) > 1 or g.lower() in 'ày') :
                    if self.connu(d) and (len(d) > 1 or d.lower() in 'ày'):
                        if self.trait(g, d): ajoute(f'{g}-{d}', k0 + (0.5 if f'{g}-{d}'.lower() in self.traits else 1))
                        else: ajoute(f'{g} {d}', k0 + (0.4 if g.lower() in OUTIL_COURT and d.lower() in OUTIL_COURT else 1))
                    for j in range(i + 1, len(base)):
                        m, e = base[i:j], base[j:]
                        if len(m) > 1 and len(e) > 1 and self.connu(m) and self.connu(e):
                            ajoute(f'{g} {m} {e}', k0 + (0.6 if all(x.lower() in OUTIL_COURT for x in (g, m, e)) else 2.5))
        return out

    def trait(self, g, d):
        """« Retire » + « toi » s'écrit-il avec un trait d'union ? Oui si la BJ l'écrit ainsi, ou pour « -même », « -ci », « -là »."""
        g2, d2 = g.lower(), d.lower()
        if f'{g2}-{d2}' in self.traits: return True
        if d2 in ('même', 'mêmes', 'ci', 'là') and self.connu(g) and len(g) > 1: return True
        # verbe + pronom inversé : « vient-elle », « dit-il », « Retire-toi »
        return d2 in PRONOMS_INVERSES and len(g2) >= 3 and g2 not in OUTILS and self.connu(g)

    def proche_sur(self, w, avant, apres):
        """Un seul mot du vocabulaire à une lettre près (ou un nettement meilleur que les autres) : on le prend.
        Mot à majuscule en milieu de phrase : seulement vers un mot que la BJ écrit aussi avec majuscule."""
        if len(w) < 5 or re.search(r'\d', w): return None
        if w[:1].isupper() and avant: return None                        # nom propre ou terme technique : on n'y touche pas
        ps = self.proches(w)
        if not ps: return None
        notes = sorted(((self.note([c], avant, apres), c) for c in ps), reverse=True)
        if len(notes) == 1 or notes[0][0] - notes[1][0] > 3:
            c = notes[0][1]
            return c[:1].upper() + c[1:] if w[:1].isupper() else c
        return None

    def choisit(self, w, avant, apres):
        r = self._choisit(w, avant, apres)
        if r == w and not self.mac:
            r = self.proche_sur(w, avant, apres) or w
        return r

    def _choisit(self, w, avant, apres):
        cs = {c: k for c, k in self.candidats(w).items() if c not in SIGLES and not any(p in SIGLES for p in c.split())}
        # coupure en mots : seulement entre mots très courants qui vont ensemble dans la BJ (« Car il est », « Si tu »)
        def coupure_sure(c):
            ps = [x for x in re.split(r'[ ]', c)]
            if len(ps) == 1: return True
            if '-' in c and ' ' not in c: return True
            return all(self.lex.get(x.lower(), 0) >= 100 for x in ps) and all(self.bi[(a.lower(), b.lower())] >= 20 for a, b in zip(ps, ps[1:]))
        cs = {c: k for c, k in cs.items() if coupure_sure(c)}
        if re.fullmatch(r'[a-zà-ÿœæ]{5,}', w.lower()):
            cs = {c: k for c, k in cs.items() if len(c.split()) == 1 or all(x.lower() in OUTIL_COURT for x in c.split())}
        # un mot écrit avec majuscule en milieu de phrase est un nom propre : on cherche un nom propre (« Elie » -> « Élie »)
        if avant and w[:1].isupper() and w[:1] not in '1|IÎJ':
            pr = {c: k for c, k in cs.items() if ' ' not in c and self.propre(c)}
            if pr: cs = pr
            else: cs = {c: k for c, k in cs.items() if c[:1].lower() == w[:1].lower() or c[:1] in 'ÉÈÊÀ'}
        if not cs: return w
        # nom propre dont seul l'accent manque (« Elie » -> « Élie », « Egypte » -> « Égypte »)
        if w[:1] in 'JÎ' and avant:
            cs = {c: k for c, k in cs.items() if c[:1].lower() == w[:1].lower() or self.freq(c.split()[0]) >= 100}
        if w[:1].isupper() and w[:1] not in '1|IÎJ':
            ok = {c for c, _ in self.candidats_simples(w, propre=True)}
            pr = [c for c, k in cs.items() if c in ok and self.propre(c)]
            if pr: return max(pr, key=self.freq)
        # retouche lourde (une lettre pour une autre) : il faut qu'un voisin la confirme
        bi = lambda a, b: self.bi[(a.lower(), b.lower())]
        def appui(c):
            ps = re.split(r'[ -]', c)
            return (avant and bi(avant, ps[0]) >= 5) or (apres and bi(ps[-1], apres) >= 5) or (len(ps) == 1 and self.freq(c) >= 2000 and cs[c] <= 1)
        mac_props = {c for c in (self.mac.get(w) or (True, []))[1] if cout_ocr(w, c) is not None}
        cs = {c: k for c, k in cs.items() if k <= 0.6 or appui(c) or (len(re.split(r'[ -]', c)) > 1 and k <= 1.5)
              or (c in mac_props and len(w) >= 5)}
        if len(w) <= 4 and not re.search(r'[0-9ÎÏ|]', w):
            cs = {c: k for c, k in cs.items() if appui(c)}
        if w[:1].isupper() and w[:1] not in '1|IÎJ' and avant:
            cs = {c: k for c, k in cs.items() if ' ' not in c or all(x.lower() in OUTIL_COURT for x in c.split())}
        if w[:1].isupper() and w[:1] not in '1|IÎJ':
            ok = {c for c, _ in self.candidats_simples(w, propre=True)}
            mac1 = ((self.mac.get(w) or (True, []))[1] or [None])[0] if not avant else None   # en milieu de phrase : un nom
            cs = {c: k for c, k in cs.items() if k <= 0.6 or c in ok or (self.propre(c) and k <= 1)
                  or (c == mac1 and c[:1].lower() == w[:1].lower() and une_retouche_interne(w, c) and cout_ocr(w, c) is not None)
                  or (' ' in c and all(x.lower() in OUTIL_COURT for x in c.split()))}
        if not cs: return w
        score = lambda c: self.note(re.split(r'[ -]', c), avant, apres) - 2.5 * cs[c] - (1.5 if ' ' in c and '-' not in c else 0)
        meilleur = max(cs, key=score)
        # mot inconnu mais d'allure française (lettres seules, assez long) : on ne le change que pour mieux
        plausible = re.fullmatch(r'[a-zà-ÿœæ]{5,}', w.lower()) and not re.match(r'[1|ÎJ]', w)
        if plausible:
            # mot d'allure française : seulement accents, 1/l/i, ou coupure attestée (« Retiretoi », « Carilest »)
            mac = {c for c in (self.mac.get(w) or (True, []))[1] if cout_ocr(w, c) is not None}
            sures = {c: k for c, k in cs.items() if k <= 0.6 or ('-' in c and c.lower() in self.traits) or ' ' in c
                     or (k == 0.9 and appui(c)) or c in mac}
            if not sures: return w
            meilleur = max(sures, key=score)
            if score(meilleur) < 2.0 and meilleur not in mac: return w
        if ' ' not in meilleur and self.propre(meilleur): return meilleur[:1].upper() + meilleur[1:]
        if avant is not None and meilleur[:1].lower() != w[:1].lower() and w[:1] in '1|IÎJ' and not self.propre(meilleur):
            return meilleur[:1].lower() + meilleur[1:]
        return casse(w, meilleur) if not meilleur[:1].isupper() else meilleur

    # ------------------------------------------------------------------ texte
    def texte(self, t, evangile=False):
        if not t: return t
        # signes isolés : numéros de verset mal lus (« ? toi », « * Et ») ; dans les Évangiles, chiffres isolés aussi
        # signes isolés : numéros de verset mal lus (« * Et », « # Moïse ») ; jamais « ? » ni « ! » (« dit ? » est du français)
        t = re.sub(r'(?<!\S)[*#%$°‘\'"\\|@®©]{1,3}(?!\S)', ' ', t)
        t = re.sub(r'(?:^|(?<=[,.;:»]))\s*[?!]{1,2}(?=\s)', ' ', t)   # « ? » ou « ! » après une ponctuation : numéro de verset mal lu
        if evangile: t = re.sub(r'(?<![\w,])\s\d{1,3}(?=\s+[«A-ZÉa-zé])', ' ', ' ' + t).strip()
        t = re.sub(r'(?<!\S)p\.(?!\s*\d)', ' ', t)          # « p. » orphelin, reste d'un renvoi « (voir p. 96) »
        t = re.sub(r'(?<![\w,.])\d{1,3}(?=[A-ZÉ]?[a-zà-ÿ]{2,})', ' ', t)
        t = re.sub(r'(?<!\S)(?:IT|TI|JI|Jl|JT|1I|I1|T1)(?= +(?:[a-zà-ÿ]|[A-ZÉ]{3,}))', 'Il', t)
        t = re.sub(r'(?<![\w’\'-])([jJlLdDnNsScCmM]|[Qq]u) (?=(?:a[il]?|ai[st]?|avais|avait|en|est|était|es|on|un|une|il|elle|ils|elles|y|ont|eux|un|autre|ouvre|envoie|enfant|homme|Esprit|esprit|âme|heure|Agneau|eau|Israël|Église|Écriture)\b)',
                   lambda m: m.group(1) + '’', t)
        t = re.sub(r'\b([jJ])’al\b', r'\1’ai', t)
        t = re.sub(r'(?<=[a-zà-ÿ,;] )J’', 'j’', t)
        t = re.sub(r'(?<![\w’\'-]) t (?=[a-zà-ÿ]{2,})', ' et ', t)
        t = re.sub(r'E(?=[ÉÈ])', '', t)                       # « EÉcoutez » : majuscule lue deux fois
        t = re.sub(r"([’'])\1+", r'\1', t)                    # apostrophe doublée
        # « l » italique lu comme une barre oblique : « de /Agneau » -> « de l'Agneau » ; « qu'/{ est » -> « qu'Il est »
        ap = "'" if "'" in t and '’' not in t else '’'
        t = re.sub(r'(?<=[\s(«])/(?=[AEIOUÉÈÂaeiouéèâh][a-zà-ÿœ]+)', 'l' + ap, t)
        t = re.sub(r"(?<=[\s’'(«])/[{\[(I|]\s?(?=[a-zé])", 'Il ', t)
        t = re.sub(r"(?<=[\s(«])/l[’'](?=[a-zé])", 'Il ', t)                       # « /l’est » -> « Il est »
        t = re.sub(r'(?<=[\s(«])/([a-zà-ÿ]{2,})', lambda m: ('I' + m.group(1)) if (self.connu('i' + m.group(1)) or m.group(1) == 'bid') else m.group(0), t)
        # débris typographiques : signes parasites, filets, accolades lues pour des crochets
        t = re.sub(r'\(\s?[©®D@]\s?\)|(?<!\w)[©®Ÿ¬](?!\w)|\s[©®]\)|\|:|:\||_{2,}', ' ', t)
        t = t.replace('{', '[').replace('}', ']')
        t = re.sub(r'(?<![\w\]])\|(?=[A-Za-zÀ-ÿ][^|\]]{0,40}\])', '[', t)       # « |nazer] » -> « [nazer] »
        t = re.sub(r'\s\|(?=\s)', ' ', t)
        # sigle collé à son chapitre : « Col1 » -> « Col 1 », « MI3 » -> « Ml 3 »
        t = re.sub(r'\bMI(?=\d)', 'Ml', t)
        t = re.sub(r'\b((?:[1-3] ?)?(?:Gn|Ex|Lv|Nb|Dt|Jos|Jg|Rt|S|R|Ch|Esd|Né|Tb|Jdt|Est|M|Jb|Ps|Pr|Qo|Ct|Sg|Si|Is|Jr|Lm|Ba|Ez|Éz|Dn|Os|Jl|Am|Ab|Jon|Mi|Na|Ha|So|Ag|Za|Ml|Mt|Mc|Lc|Jn|Ac|Rm|Co|Ga|Ep|Ép|Ph|Col|Th|Tm|Tt|Phm|Hé|Jc|P|Jude|Ap))(?=\d{1,3}\b)', r'\1 ', t)
        # « a-t- il » -> « a-t-il » ; espace avant virgule ou point
        t = re.sub(r'-t- (il|elle|on|ils|elles)\b', r'-t-\1', t)
        t = re.sub(r'(?<=[\wÀ-ÿ»\])]) ([,.])(?![.\d])', r'\1', t)
        t = re.sub(r'\b(Mt|Mc|Lc|Jn) (\d+)\.,(\d)', r'\1 \2,\3', t)   # « Mt 8.,8 »
        t = re.sub(r'\b(Mt|Mc|Jn|Mt-Mc),? et Le\b', r'\1 et Lc', t); t = re.sub(r'\bLe et (Mt|Mc|Jn)\b', r'Lc et \1', t)
        if evangile:   # renvoi de marge collé au verset (« In16.23-24.26au$ », « Mt8,17 »)
            t = re.sub(r'(?<!\w)(?:In|Jn|Mt|Mc|Lc|Le|Ac|Rm|Ap|Is|Ps)\d+[.,][\d.,\-]*[a-z]{0,2}\$?(?!\w)', ' ', t)
        # signes doublés ou impossibles en français : « maïison », « Maïtre », « mangeaït », « nourriraï », « Nüûn », « jeñna »
        for x, y in (('aïi', 'ai'), ('aiï', 'ai'), ('ïi', 'i'), ('iï', 'i'), ('üû', 'û'), ('ûü', 'û'), ('ñ', 'û'), ('ôô', 'ô'), ('ûô', 'û')):
            t = t.replace(x, y)
        t = re.sub(r'(?<=[a-zàâéèêëîôûç])aït\b', 'ait', t); t = re.sub(r'(?<=[rs])aï\b', 'ai', t)
        t = re.sub(r'(?<=[a-z])aïent\b', 'aient', t); t = re.sub(r'\bMaïtre', 'Maître', t); t = re.sub(r'\bmaïtre', 'maître', t)
        t = re.sub(r'\s{2,}', ' ', t).strip()
        toks = re.split(r"(" + MOT.pattern + ")", t)
        mots = [i for i in range(1, len(toks), 2)]
        for n, i in enumerate(mots):
            w = toks[i]
            avant = toks[mots[n - 1]] if n > 0 and not re.search(r'[.!?;:»«]', toks[i - 1]) else None
            apres = toks[mots[n + 1]] if n + 1 < len(mots) and not re.search(r'[.!?;:»«]', toks[i + 1]) else None
            suite = toks[i + 1] if i + 1 < len(toks) else ''
            if (suite[:1] == '-' and suite[1:2] in (' ', '')) or toks[i - 1].endswith('- '):
                continue   # morceau d'un mot coupé en fin de ligne (« accom- ») : on n'invente rien
            if re.search(r'«\s*$', toks[i - 1]) and re.match(r'^\s*»', suite) and not re.search(r'[0-9ÎÏ|]', w):
                continue   # mot cité entre guillemets (grec, latin, hébreu translittéré : « Almah »)
            if w[:1].isupper() and re.fullmatch(r'\.\s?', toks[i - 1]) and i >= 2 and re.fullmatch(r'[A-Z]', toks[i - 2] or ''):
                continue   # nom d'auteur après une initiale (« A. Jaubert », « J. Journet »)
            if re.search(r'(?:[ôêè]$|kh)', w.lower()):
                continue   # grec translittéré (« arkhô », « phônè »)
            m_ap = re.fullmatch(r'([ldnjsmtcLDNJSMTC])([A-ZÉÈÀ][a-zà-ÿ]{2,})', w)
            if m_ap and self.connu(m_ap.group(2)):
                nouveau = m_ap.group(1) + ('’' if '’' in t else "'") + m_ap.group(2)
                self.faites[(w, nouveau)] += 1; toks[i] = nouveau
                continue
            if re.search(r'[a-zà-ÿ][A-Z]', w) and not w.isupper() and len(w) >= 4:
                lo = w[:1] + w[1:].lower()
                if self.connu(lo) and not re.search(r'\d', w):
                    self.faites[(w, lo)] += 1; toks[i] = lo
                    continue
            if (len(w) >= 2 and w.isupper()) or re.search(r'[a-zà-ÿ0-9][A-Z]', w):
                continue   # petites capitales (« JE SUIS ») ou débris mêlés (« jJe », « 1Tm ») : on n'y touche pas
            if len(w) == 1 or w.lower() in self.latin or w in PROTEGES or w.lower() in PROTEGES:
                continue   # lettre seule, mot latin, titre ou nom protégé
            if w.isdigit() or w in SIGLES or re.fullmatch(r'[A-Z][a-z]{0,2}[0-9Il]{1,3}', w) and len(w) <= 5 and re.search(r'\d', w):
                continue   # sigle collé à son chapitre (« Col1 ») : référence, pas un mot
            nouveau = w
            if w[:1].isupper() and w[:1] not in '1|IÎJ' and len(w) >= 3:
                pr = [c for c in self.candidats_simples(w, propre=True) if self.propre(c[0]) and self.freq(c[0]) > self.freq(w)]
                if pr:
                    nouveau = max(pr, key=lambda x: self.freq(x[0]))[0]
                    self.faites[(w, nouveau)] += 1; toks[i] = nouveau
                    continue
            lo = w.lower()
            if re.fullmatch(r'(?:tion|tions|sion|sions|ment|ments|ance|ances|ence|ences|ique|iques|eur|eurs|ant|ants|ent|age|ages|isme|iste|able|ible|geant|tude)', lo):
                continue   # morceau d'un mot coupé en fin de ligne : on n'invente rien
            if self.mac_ok(w):
                # mot juste pour macOS : seul un contexte très net le change (« tes veux » -> « tes yeux »)
                c = self.coupure_outils(w) or (self.contresens(w, avant, apres) if len(w) >= 3 and (avant or apres) else None)
                if c and c != w: self.faites[(w, c)] += 1; toks[i] = c
                continue
            if len(w) >= 4 and lo == sans_accent(lo) and self.lex.get(lo, 0) == 0 and lo in self.accent and lo not in self.latin and lo not in self.dico:
                nouveau = casse(w, self.accent[lo]) if not w.isupper() else w
                if nouveau != w:
                    self.faites[(w, nouveau)] += 1; toks[i] = nouveau
                    continue
            if w in VIDES_DOUTEUX:
                nouveau = VIDES_DOUTEUX[w]
                if avant is None: nouveau = nouveau[:1].upper() + nouveau[1:]
            elif not self.connu(w) and len(w) >= 2:
                nouveau = self.choisit(w, avant, apres)
            elif self.connu(w) and len(w) >= 3 and (avant or apres) and self.contresens(w, avant, apres):
                nouveau = self.contresens(w, avant, apres)
            elif self.connu(w) and self.freq(w) <= 2 and len(w) >= 3:
                # mot connu mais rarissime : on ne le change que si une confusion donne un mot fréquent
                # nettement mieux accordé avec ses voisins
                cs = {c: k for c, k in self.candidats(w).items() if ' ' not in c and '-' not in c and k == 1}
                if cs:
                    c = max(cs, key=lambda c: self.note([c], avant, apres))
                    if self.freq(c) >= 30 and self.note([c], avant, apres) > self.note([w], avant, apres) + 4:
                        nouveau = c
            if nouveau != w:
                self.faites[(w, nouveau)] += 1
                toks[i] = nouveau
        return ''.join(toks)

    def coupure_outils(self, w):
        """Petits mots collés que macOS accepte à tort (« jete », « Situes », « Nete ») : je te, Si tu es, Ne te."""
        lo = w.lower()
        if len(lo) < 4 or len(lo) > 9: return None
        for i in range(1, len(lo)):
            g, d = lo[:i], lo[i:]
            if g in OUTIL_COURT and d in OUTIL_COURT and self.bi[(g, d)] >= 50:
                return casse(w, f'{g} {d}')
            for j in range(i + 1, len(lo)):
                m, e = lo[i:j], lo[j:]
                if g in OUTIL_COURT and m in OUTIL_COURT and e in OUTIL_COURT and self.bi[(g, m)] >= 50 and self.bi[(m, e)] >= 50:
                    return casse(w, f'{g} {m} {e}')
        return None

    def contresens(self, w, avant, apres):
        """Un mot juste en soi, mais qui ne s'accorde avec aucun de ses voisins, alors qu'une seule confusion
        d'OCR donne un mot fréquent qui s'accorde avec tous : on prend celui-ci."""
        bi = lambda a, b: self.bi[(a.lower(), b.lower())]
        if w[:1].isupper() and w[:1] not in 'IJ': return None
        if len(w) < 3 or self.freq(w) >= 1000: return None
        if (avant and bi(avant, w)) or (apres and bi(w, apres)): return None
        meilleur = None
        for c, k in self.candidats_simples(w):
            if self.freq(c) < 50: continue
            if sans_accent(c.lower()) == sans_accent(w.lower()): continue
            seuil = 5 if (avant and apres) else 25
            if (not avant or bi(avant, c) >= seuil) and (not apres or bi(c, apres) >= seuil):
                n = (bi(avant, c) if avant else 0) + (bi(c, apres) if apres else 0)
                if not meilleur or n > meilleur[1]: meilleur = (c, n)
        if not meilleur: return None
        c = casse(w, meilleur[0])
        return c[:1].lower() + c[1:] if avant and c[:1].lower() != w[:1].lower() and w[:1] in '1|IÎJ' else c

    def initiale(self, w):
        """Mots obtenus en rajoutant une première lettre perdue (bord de colonne)."""
        if w[:1].isupper(): return
        for l in 'abcdefghijlmnopqrstuvy':
            c = l + w
            if self.lex.get(c.lower(), 0) >= 20: yield (c[:1].upper() + c[1:] if self.propre(c) else c), 0.9

    def candidats_simples(self, w, propre=False):
        if not propre: yield from self.initiale(w)
        for a, b in CONFUSIONS:
            if propre and (a, b) not in PROPRE_OK: continue
            i = w.find(a)
            while i >= 0:
                c = w[:i] + b + w[i + len(a):]
                if c != w and self.connu(c): yield c, cout(a, b)
                i = w.find(a, i + 1)

    def joint(self, g, d):
        """Coupure de fin de ligne « jeû- naient » : on recolle, en gardant le trait d'union s'il faut."""
        if self.connu(g + d): return g + d
        if self.trait(g, d): return f'{g}-{d}'
        if self.connu(g) and self.connu(d) and not self.connu(g + d) and len(g) > 2 and len(d) > 2: return f'{g}-{d}'
        return g + d

    def manuelles(self, chemin):
        """Charge corrections_manuelles.tsv : [(motif compilé, remplacement)]."""
        self._man = []
        if not os.path.exists(chemin): return
        for l in open(chemin, encoding='utf-8'):
            if not l.strip() or l.startswith('#') or '\t' not in l: continue
            lu, bon = l.rstrip('\n').split('\t', 1)
            if not lu: continue
            if re.fullmatch(r"[\wÀ-ÿœæ’'-]+", lu): rx = re.compile(r'(?<![\wÀ-ÿœæ])' + re.escape(lu) + r'(?![\wÀ-ÿœæ])')
            else: rx = re.compile(re.escape(lu))
            self._man.append((rx, bon, lu))

    def applique_manuelles(self, t):
        for rx, bon, lu in getattr(self, '_man', []):
            t2, n = rx.subn(bon, t)
            if n: self.faites[(lu, bon + ' (choix)')] += n; t = t2
        return re.sub(r'\s{2,}', ' ', t).strip()

    def releve(self, chemin):
        with open(chemin, 'w', encoding='utf-8') as f:
            f.write('nombre\tlu\tcorrigé\n')
            for (a, b), n in self.faites.most_common():
                f.write(f'{n}\t{a}\t{b}\n')


if __name__ == '__main__':
    import sys
    C = Correcteur()
    for t in sys.argv[1:] or ["Alors Jésus lui dit: « Retiretoi, Satan! Carilest écrit", "Situ es Fils de Dieu, jete le donnerai",
                               "et 1l était avec les bêtes", "la Jace de nos ennemis", "Maïs Il répondit", "tu l’as fir voir de tes veux"]:
        print(t, '\n  ->', C.texte(t))
