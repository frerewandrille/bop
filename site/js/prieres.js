/* Prières et formules (Compendium du Catéchisme de l'Église catholique, appendice), rangées comme un livre :
   une table des matières (six chapitres), puis la lecture d'une prière ou d'un chapitre entier, avec
   « précédent / suivant ». Rien ne dépend du jour.

   Prieres.sommaire(D)                 → table des matières
   Prieres.chapitre(D, id, langue)     → toutes les pièces d'un chapitre
   Prieres.piece(D, id, langue)        → une pièce, avec son chapitre et les pièces voisines
   Prieres.resultats(D, ids)           → liste des pièces trouvées par la recherche
   langue : "fr" | "la" | "deux". En « deux », les lignes sont mises en regard quand le français et le
   latin ont le même nombre de lignes ; sinon les deux textes sont côte à côte (l'un sous l'autre sur téléphone).
*/
(function (g) {
  "use strict";
  const esc = (s) => String(s).replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));
  const RENVOIS = [[/^(Je vous salue, Marie|Ave, María)\s*(…|\.\.\.)$/, "je-vous-salue"], [/^(Gloire au Père|Glória Patri)\s*(…|\.\.\.)$/, "gloire-au-pere"]];

  function ligne(l) {
    const r = RENVOIS.find(([re]) => re.test(l));
    if (r) return `<a class="renvoi" href="#${r[1]}">${esc(l)}</a>`;
    const m = /^([DC])\.\s+(.*)$/.exec(l);
    if (m) return `<span class="role">${m[1]}.</span> ${esc(m[2])}`;
    if (/^\(.*\)$/.test(l)) return `<span class="rubrique">${esc(l)}</span>`;
    return esc(l);
  }
  const bloc = (lignes, cls = "") => `<p class="${cls}">${lignes.map(ligne).join("<br>")}</p>`;

  function corps(p, langue) {
    const fr = p.fr, la = p.la;
    if (langue === "la" && la) return la.map((b) => bloc(b, "la")).join("");
    if (langue !== "deux" || !la) return fr.map((b) => bloc(b, "fr")).join("")
      + (langue === "la" && !la ? `<p class="sans-latin">Pas de texte latin dans la source.</p>` : "");
    const memes = fr.length === la.length && fr.every((b, i) => b.length === la[i].length) && !p.prose;
    if (memes)
      return fr.map((b, i) => `<div class="regard lignes">` + b.map((l, k) => `<div class="fr">${ligne(l)}</div><div class="la">${ligne(la[i][k])}</div>`).join("") + `</div>`).join("");
    if (fr.length === la.length)
      return fr.map((b, i) => `<div class="regard blocs">${bloc(b, "fr")}${bloc(la[i], "la")}</div>`).join("");
    return `<div class="regard blocs"><div class="fr">${fr.map((b) => bloc(b)).join("")}</div>`
      + `<div class="la">${p.laSource ? `<span class="source-latin">${esc(p.laSource)}</span>` : ""}${la.map((b) => bloc(b)).join("")}</div></div>`;
  }

  function carte(p, langue, niveau = "h3") {
    const infos = [p.ref, p.note].filter(Boolean);
    return `<article class="priere" id="${p.id}"><${niveau}>${esc(p.titre)}${p.titreLatin && langue !== "fr" ? ` <span class="titre-latin">${esc(p.titreLatin)}</span>` : ""}</${niveau}>`
      + (infos.length ? `<p class="infos">${infos.map(esc).join(" · ")}</p>` : "") + corps(p, langue) + `</article>`;
  }

  const tout = (D) => D.groupes.flatMap((gr) => gr.pieces.map((p) => ({ p, gr })));
  const ROMAINS = ["I", "II", "III", "IV", "V", "VI", "VII", "VIII"];

  function sommaire(D) {
    return `<nav class="table-matieres" aria-label="Table des matières">` + D.groupes.map((gr, i) =>
      `<section class="chapitre-sommaire"><h2><a href="#chapitre/${gr.id}"><span class="numero">${ROMAINS[i]}.</span> ${esc(gr.titre)}</a></h2>`
      + (gr.intro ? `<p class="intro">${esc(gr.intro)}</p>` : "")
      + `<ol>${gr.pieces.map((p) => `<li><a href="#${p.id}">${esc(p.titre)}${p.titreLatin ? ` <span class="titre-latin">${esc(p.titreLatin)}</span>` : ""}</a></li>`).join("")}</ol></section>`).join("") + `</nav>`;
  }

  // fil d'Ariane et pages voisines
  const fil = (D, gr, p) => `<nav class="fil" aria-label="Chemin"><a href="#">Prières</a> › `
    + (p ? `<a href="#chapitre/${gr.id}">${esc(gr.titre)}</a> › <span>${esc(p.titre)}</span>` : `<span>${esc(gr.titre)}</span>`) + `</nav>`;
  function voisins(prec, suiv) {
    const lien = (x, sens) => x ? `<a class="${sens}" href="#${x.href}"><span class="sens">${sens === "precedent" ? "‹ Précédent" : "Suivant ›"}</span><span class="titre">${esc(x.titre)}</span></a>` : `<span class="${sens} vide"></span>`;
    return `<nav class="voisins" aria-label="Pages voisines">${lien(prec, "precedent")}<a class="retour" href="#">Table des matières</a>${lien(suiv, "suivant")}</nav>`;
  }

  function chapitre(D, id, langue) {
    const i = D.groupes.findIndex((gr) => gr.id === id);
    if (i < 0) return null;
    const gr = D.groupes[i], prec = D.groupes[i - 1], suiv = D.groupes[i + 1];
    return fil(D, gr) + `<header class="titre-chapitre"><p class="numero">Chapitre ${ROMAINS[i]}</p><h1>${esc(gr.titre)}</h1>`
      + (gr.intro ? `<p class="intro">${esc(gr.intro)}</p>` : "") + `</header>`
      + `<div class="${gr.formules ? "formules" : ""}">${gr.pieces.map((p) => carte(p, langue)).join("")}</div>`
      + voisins(prec && { href: `chapitre/${prec.id}`, titre: prec.titre }, suiv && { href: `chapitre/${suiv.id}`, titre: suiv.titre });
  }

  function piece(D, id, langue) {
    const L = tout(D), i = L.findIndex((x) => x.p.id === id);
    if (i < 0) return null;
    const { p, gr } = L[i], prec = L[i - 1], suiv = L[i + 1];
    return fil(D, gr, p) + `<div class="lecture-priere${gr.formules ? " formules" : ""}">${carte(p, langue, "h1")}</div>`
      + voisins(prec && { href: prec.p.id, titre: prec.p.titre }, suiv && { href: suiv.p.id, titre: suiv.p.titre });
  }

  // recherche : sans accents ni casse, sur titre, titre latin et texte
  const plat = (s) => s.normalize("NFD").replace(/[̀-ͯ]/g, "").replace(/[æǽ]/g, "ae").replace(/œ/g, "oe").toLowerCase();
  function index(D) {
    return tout(D).map(({ p }) => ({ id: p.id, texte: plat([p.titre, p.titreLatin || "", ...p.fr.flat(), ...(p.la || []).flat()].join(" ")) }));
  }
  function chercher(idx, q) {
    const mots = plat(q).split(/\s+/).filter(Boolean);
    return new Set(idx.filter((e) => mots.every((m) => e.texte.includes(m))).map((e) => e.id));
  }
  function resultats(D, ids, q) {
    const L = tout(D).filter(({ p }) => ids.has(p.id));
    if (!L.length) return `<p class="resultat">Aucune prière ne contient « ${esc(q)} ».</p>`;
    return `<p class="resultat">${L.length} résultat${L.length > 1 ? "s" : ""} pour « ${esc(q)} »</p><ol class="resultats">`
      + L.map(({ p, gr }) => `<li><a href="#${p.id}"><b>${esc(p.titre)}</b>${p.titreLatin ? ` <span class="titre-latin">${esc(p.titreLatin)}</span>` : ""}<span class="chap">${esc(gr.titre)}</span></a></li>`).join("") + `</ol>`;
  }

  g.Prieres = { sommaire, chapitre, piece, carte, index, chercher, resultats };
  if (typeof module !== "undefined") module.exports = g.Prieres;
})(typeof window !== "undefined" ? window : globalThis);
