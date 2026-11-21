"""Lecture d'un .docx (sans dépendance) : paragraphes et lignes de tableaux, sauts de ligne gardés."""
from __future__ import annotations
import re
import zipfile
from pathlib import Path
from xml.etree import ElementTree as ET

W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"


def _texte_paragraphe(p) -> str:
    out = []
    for el in p.iter():
        if el.tag == W + "t":
            out.append(el.text or "")
        elif el.tag in (W + "br", W + "cr"):
            out.append("\n")
        elif el.tag == W + "tab":
            out.append("\t")
    return "".join(out)


def _cellule(tc) -> str:
    return "\n".join(t for t in (_texte_paragraphe(p) for p in tc.iter(W + "p")) if t.strip())


def blocs(chemin: Path):
    """Suite de ("p", texte) et ("t", [cellules]) dans l'ordre du document."""
    racine = ET.fromstring(zipfile.ZipFile(chemin).read("word/document.xml"))
    for el in racine.find(W + "body"):
        if el.tag == W + "tbl":
            for tr in el.iter(W + "tr"):
                yield "t", [_cellule(tc).replace("\xa0", " ").strip() for tc in tr.findall(W + "tc")]
        elif el.tag == W + "p":
            t = _texte_paragraphe(el).replace("\xa0", " ")
            if t.strip():
                yield "p", t


def texte_doc(chemin: Path) -> str:
    """Texte d'un ancien .doc (Word 97) ou .docx."""
    chemin = Path(chemin)
    if chemin.suffix.lower() == ".docx":
        return "\n".join(t if k == "p" else " | ".join(t) for k, t in blocs(chemin))
    from lire_word import texte_doc as td  # .doc
    t = td(chemin)
    return re.sub(r"\x13[^\x14\x15]*\x14?|\x15", "", t)
