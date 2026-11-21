"""Serveur local du bréviaire : python3 outils/serveur.py [port]

Sert le dossier « site » sur http://localhost:8765 et ouvre le navigateur.
(Le serveur standard de Python peut rester bloqué au démarrage sur certains Mac,
à cause d'une recherche de nom réseau ; celui-ci l'évite.)
"""
import datetime, functools, http.server, json, socketserver, sys, threading, webbrowser
from pathlib import Path

SITE = Path(__file__).resolve().parent.parent / "site"
SIGNALEMENTS = SITE.parent / "signalements"     # un fichier par mois, une ligne JSON par signalement
VERROU = threading.Lock()

class Serveur(socketserver.ThreadingMixIn, http.server.HTTPServer):
    daemon_threads = True
    allow_reuse_address = True
    def server_bind(self):
        socketserver.TCPServer.server_bind(self)
        self.server_name, self.server_port = "localhost", self.server_address[1]

class Gestion(http.server.SimpleHTTPRequestHandler):
    extensions_map = {**http.server.SimpleHTTPRequestHandler.extensions_map,
                      ".json": "application/json", ".webmanifest": "application/manifest+json", ".js": "text/javascript"}
    def log_message(self, *a):
        pass

    def _repondre(self, code, obj):
        corps = json.dumps(obj, ensure_ascii=False).encode("utf-8")
        self.send_response(code)
        self.send_header("Content-Type", "application/json")
        self.send_header("Cache-Control", "no-store")
        self.send_header("Content-Length", str(len(corps)))
        self.end_headers()
        self.wfile.write(corps)

    def _traites(self):
        f = SIGNALEMENTS / "traites.txt"
        return {l.split()[0] for l in f.read_text("utf-8").splitlines() if l.strip() and not l.startswith("#")} if f.exists() else set()

    def do_GET(self):
        # En local, la page « Signalements » lit les fichiers du dossier signalements/ (sans clé : cet ordinateur seulement)
        if self.path.split("?", 1)[0] == "/api/signalements":
            traites, liste, vus = self._traites(), [], set()
            for f in sorted(SIGNALEMENTS.glob("*.jsonl")) if SIGNALEMENTS.exists() else []:
                for l in f.read_text("utf-8").splitlines():
                    if not l.strip():
                        continue
                    s = json.loads(l)
                    if s.get("id") in vus:
                        continue
                    vus.add(s.get("id"))
                    s["mois"] = f.stem
                    s["traite"] = s.get("id") in traites or bool(s.get("traite"))
                    liste.append(s)
            liste.sort(key=lambda s: str(s.get("cree", "")), reverse=True)
            return self._repondre(200, liste)
        return super().do_GET()

    def do_PUT(self):
        import urllib.parse
        chemin, _, q = self.path.partition("?")
        if chemin != "/api/signalements":
            return self.send_error(404)
        p = urllib.parse.parse_qs(q)
        ident = "".join(c for c in (p.get("id") or [""])[0] if c.isalnum() or c in "-_")
        if not ident:
            return self.send_error(400)
        traite = (p.get("traite") or ["1"])[0] != "0"
        with VERROU:
            SIGNALEMENTS.mkdir(exist_ok=True)
            f = SIGNALEMENTS / "traites.txt"
            lignes = f.read_text("utf-8").splitlines() if f.exists() else []
            lignes = [l for l in lignes if not l.strip() or l.split()[0] != ident]
            if traite:
                lignes.append(ident)
            f.write_text("\n".join(lignes) + "\n", "utf-8")
        return self._repondre(200, {"ok": True, "traite": traite})

    def do_POST(self):
        # Signalements d'erreurs envoyés par le site (js/signaler.js)
        if self.path.split("?", 1)[0] != "/api/signalements":
            return self.send_error(404)
        try:
            n = int(self.headers.get("Content-Length") or 0)
            if not 0 < n <= 64_000:
                raise ValueError("taille")
            s = json.loads(self.rfile.read(n).decode("utf-8"))
            if not isinstance(s, dict) or not s.get("id"):
                raise ValueError("contenu")
        except Exception:
            return self.send_error(400)
        s["recu"] = datetime.datetime.now().isoformat(timespec="seconds")
        SIGNALEMENTS.mkdir(exist_ok=True)
        fichier = SIGNALEMENTS / f"{datetime.date.today():%Y-%m}.jsonl"
        with VERROU:
            deja = fichier.exists() and any(json.loads(l).get("id") == s["id"] for l in fichier.read_text("utf-8").splitlines() if l.strip())
            if not deja:
                with fichier.open("a", encoding="utf-8") as f:
                    f.write(json.dumps(s, ensure_ascii=False) + "\n")
        corps = b'{"ok":true}'
        self.send_response(201)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(corps)))
        self.end_headers()
        self.wfile.write(corps)

    def translate_path(self, path):
        # Les partitions (usage local, non publiées) sont à côté du dossier « site »
        p = path.split("?", 1)[0].split("#", 1)[0]
        if p.startswith("/bible/") or p == "/bible":
            # la Bible (dossier bible/, projet distinct) est servie sous /bible/, comme en ligne
            import urllib.parse
            base = (SITE.parent / "bible").resolve()
            cible = (base / urllib.parse.unquote(p[len("/bible"):].lstrip("/"))).resolve()
            if str(cible).startswith(str(base)) and not cible.suffix in (".py", ".sh", ".md", ".command", ".txt"):
                return str(cible)
            return str(SITE / "introuvable")
        if p.startswith("/partitions/"):
            import urllib.parse
            cible = (SITE.parent / urllib.parse.unquote(p.lstrip("/"))).resolve()
            if str(cible).startswith(str((SITE.parent / "partitions").resolve())):
                return str(cible)
        return super().translate_path(path)

def main():
    port = int(sys.argv[1]) if len(sys.argv) > 1 else 8765
    ouvrir = "--sans-navigateur" not in sys.argv
    srv = Serveur(("127.0.0.1", port), functools.partial(Gestion, directory=str(SITE)))
    adresse = f"http://localhost:{port}/"
    print(f"Bréviaire ouvert sur {adresse} — fermez cette fenêtre pour l'arrêter.", flush=True)
    if ouvrir:
        threading.Timer(0.5, lambda: webbrowser.open(adresse)).start()
    try:
        srv.serve_forever()
    except KeyboardInterrupt:
        pass

if __name__ == "__main__":
    main()
