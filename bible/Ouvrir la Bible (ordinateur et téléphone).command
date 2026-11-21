#!/bin/bash
# Double-cliquer : ouvre la Bible sur cet ordinateur et donne l’adresse pour le téléphone.
cd "$(dirname "$0")"
exec python3 serveur.py 8790
