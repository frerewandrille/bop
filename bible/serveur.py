"""Rend la Bible accessible au téléphone, sur le Wi-Fi de la maison.

    python3 serveur.py [port]        (par défaut 8790)

Affiche l'adresse à taper sur le téléphone (même réseau Wi-Fi que l'ordinateur).
Rien n'est publié sur Internet : seul le réseau local y a accès, tant que la fenêtre reste ouverte.
"""
import functools
import http.server
import os
import socket
import socketserver
import sys
import webbrowser

DOSSIER = os.path.dirname(os.path.abspath(__file__))


class Serveur(socketserver.ThreadingMixIn, http.server.HTTPServer):
    daemon_threads = True
    allow_reuse_address = True

    def server_bind(self):  # évite la recherche de nom réseau qui bloque parfois le démarrage sur Mac
        socketserver.TCPServer.server_bind(self)
        self.server_name, self.server_port = "localhost", self.server_address[1]


class Gestion(http.server.SimpleHTTPRequestHandler):
    extensions_map = {**http.server.SimpleHTTPRequestHandler.extensions_map,
                      ".js": "text/javascript", ".webmanifest": "application/manifest+json"}

    def log_message(self, *a):
        pass

    def end_headers(self):
        # les données changent rarement : le téléphone peut les garder une journée
        if self.path.startswith("/data/"):
            self.send_header("Cache-Control", "max-age=86400")
        super().end_headers()


def ip_locale():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    try:
        s.connect(("10.255.255.255", 1))  # aucun paquet envoyé : sert seulement à connaître l'interface
        return s.getsockname()[0]
    except OSError:
        return "127.0.0.1"
    finally:
        s.close()


def main():
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8790
    if not os.path.exists(os.path.join(DOSSIER, "data", "books.js")):
        print("Les données n'existent pas encore : lancez d'abord  python3 extract.py")
        return
    srv = Serveur(("0.0.0.0", port), functools.partial(Gestion, directory=DOSSIER))
    ip = ip_locale()
    print("\n  Bible de Jérusalem — lecture et lectio\n")
    print(f"  Sur cet ordinateur :  http://localhost:{port}/")
    print(f"  Sur le téléphone   :  http://{ip}:{port}/")
    print("     (même Wi-Fi ; puis, dans Safari : Partager → « Sur l'écran d'accueil »)")
    print(f"  Vue interlinéaire  :  http://localhost:{port}/interlineaire.html\n")
    print("  Laisser cette fenêtre ouverte pendant la lecture. Ctrl+C pour arrêter.\n")
    try:
        webbrowser.open(f"http://localhost:{port}/")
    except Exception:
        pass
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        pass


if __name__ == "__main__":
    main()
