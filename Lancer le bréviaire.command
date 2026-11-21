#!/bin/bash
# Double-cliquer pour ouvrir le bréviaire dans le navigateur (sur cet ordinateur).
cd "$(dirname "$0")"
exec python3 outils/serveur.py 8765
