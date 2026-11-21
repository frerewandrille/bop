#!/usr/bin/env python3
"""Lecture hors connexion de la Bible : liste des « paquets » que chacun peut enregistrer sur son appareil.

    python3 bible/horsligne.py        (relancé par preparer_site.sh à chaque publication)

Écrit data/horsligne.js (window.__HL) : pour chaque paquet, son titre, une phrase d'explication, sa taille
et la liste de ses fichiers (chemins relatifs au dossier bible/). La page « Hors connexion » (lectio.js)
télécharge ces fichiers dans le cache du navigateur ; sw.js les ressert quand le réseau manque.
"""
import json, os

ICI = os.path.dirname(os.path.abspath(__file__))
DATA = os.path.join(ICI, 'data')


def fichiers(*chemins):
    """Fichiers .js sous ces chemins (dossiers ou fichiers), relatifs à bible/."""
    out = []
    for c in chemins:
        p = os.path.join(DATA, c)
        if os.path.isfile(p):
            out.append('data/' + c)
        elif os.path.isdir(p):
            for racine, _, fs in os.walk(p):
                for f in sorted(fs):
                    if f.endswith('.js'):
                        out.append(os.path.relpath(os.path.join(racine, f), ICI).replace(os.sep, '/'))
    return sorted(out)


def taille(fs):
    return sum(os.path.getsize(os.path.join(ICI, f)) for f in fs if not f.startswith('../'))


def main():
    livres = json.loads(open(os.path.join(DATA, 'books.js'), encoding='utf-8').read().split('=', 1)[1].rstrip().rstrip(';'))
    EV = ['MAT', 'MRK', 'LUK', 'JHN']
    nt = [b['c'] for b in livres if b['t'] == 'NT' and b['c'] not in EV]
    at = [b['c'] for b in livres if b['t'] == 'AT' and b['c'] != 'PSA']
    bible = lambda codes: fichiers(*codes, *[f'dref/{c}.js' for c in codes])
    paquets = [
        dict(id='evangiles', titre='Les quatre Évangiles',
             desc='Le texte de la Bible de Jérusalem, avec ses notes, le grec mot à mot et le latin.',
             fichiers=bible(EV)),
        dict(id='nt', titre='Le reste du Nouveau Testament', desc='Des Actes des Apôtres à l’Apocalypse.',
             fichiers=bible(nt)),
        dict(id='psaumes', titre='Les Psaumes', desc='La Bible de Jérusalem et le Psautier du bréviaire.',
             fichiers=bible(['PSA']) + ['../donnees/psautier.json']),
        dict(id='at', titre='L’Ancien Testament', desc='Tous les livres, sauf les Psaumes (paquet à part).',
             fichiers=bible(at)),
        dict(id='bc', titre='Bible chrétienne', desc='Les Évangiles en synopse, les textes mis en regard et le commentaire, § par §.',
             fichiers=fichiers('bc', 'bct')),
        dict(id='peres', titre='Les Pères — la Chaîne d’or', desc='Le commentaire des Évangiles par les Pères, rassemblé par saint Thomas d’Aquin.',
             fichiers=fichiers('tae')),
        dict(id='dicos', titre='Les dictionnaires', desc='Vocabulaire de théologie biblique et sept autres dictionnaires, avec les thèmes de chaque verset.',
             fichiers=fichiers('dico')),
        dict(id='mots', titre='Les fiches des mots', desc='Grec, hébreu et latin : analyse, dictionnaires (Bailly…) et concordance, au toucher d’un mot.',
             fichiers=fichiers('lex', 'conc', 'latin')),
    ]
    # le socle (pages, polices, petits index) part avec n'importe quel paquet
    socle = ['./', 'index.html', 'lectio.js', 'lectio.css', 'polices.css', 'liens.js', 'lectio.webmanifest', 'icone-180.png', 'icone-512.png',
             *[f'polices/{f}' for f in sorted(os.listdir(os.path.join(ICI, 'polices'))) if f.endswith('.woff2')],
             *fichiers('books.js', 'mots.js', 'plan.js', 'gloss_JER.js', 'gloss_ATI.js', 'horsligne.js', 'bc/index.js', 'bct/index.js', 'dico/index.js')]
    for p in paquets:
        p['taille'] = taille(p['fichiers'])
        p['n'] = len(p['fichiers'])
    hl = dict(version=1, socle=socle, paquets=paquets)
    with open(os.path.join(DATA, 'horsligne.js'), 'w', encoding='utf-8') as f:
        f.write('window.__HL=' + json.dumps(hl, ensure_ascii=False, separators=(',', ':')) + ';\n')
    for p in paquets:
        print(f"{p['titre']:40} {p['n']:5} fichiers  {p['taille'] / 2**20:6.1f} Mo")


if __name__ == '__main__':
    main()
