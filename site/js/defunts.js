/* Frères défunts : mémoire du jour (nécrologe du Catalogus de la Province), De profundis, Repos éternel,
   et le nécrologe entier, mois par mois, avec une recherche.

   Defunts.du(date, N) → { freres, sansJour, plus29 } ; règles communes avec le martyrologe :
   le 28 février des années non bissextiles, on nomme aussi les frères du 29 février ;
   les frères dont le catalogue ne donne que le mois sont nommés le 1er du mois.
*/
(function (g) {
  "use strict";
  const MOIS = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"];
  const bissextile = (a) => (a % 4 === 0 && a % 100 !== 0) || a % 400 === 0;
  const esc = (s) => String(s).replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));

  function du(date, N) {
    const [a, mo, j] = date.split("-").map(Number);
    const cle = date.slice(5);
    const plus29 = cle === "02-28" && !bissextile(a);
    let freres = [...(N.jours[cle] || [])];
    if (plus29) freres = freres.concat((N.jours["02-29"] || []).map((d) => ({ ...d, du29: true })));
    return { freres, plus29, sansJour: j === 1 ? (N.sansJour[String(mo).padStart(2, "0")] || []) : [] };
  }

  function frere(d, notes, avecDate) {
    const bx = /^\(Bx\)/.test(d.nom) || d.note === "bienheureux";
    const nom = esc(d.nom.replace(/^\(Bx\)\s*/, ""));
    return `<li><span class="nom">${bx ? "bienheureux " : "fr. "}${nom}</span>`
      + `<span class="detail"> — ${avecDate ? esc(avecDate) + " " : ""}${d.annee}${d.lieu ? ", " + esc(d.lieu) : ""}${d.du29 ? " (29 février)" : ""}</span>`
      + (bx && notes ? `<span class="note">${esc(notes.bienheureux)}</span>` : "") + `</li>`;
  }

  // De profundis : psautier de la Bible de Jérusalem (Ps 129 grec) et Nova Vulgata (Ps 130 hébreu)
  function deProfundis(psautier, latin) {
    const p = psautier && psautier.pieces && psautier.pieces["129"];
    if (!p) return "";
    const fr = p.strophes.map((s) => `<p>${s.lignes.map((l) => l.t.replace(/<[^>]*>/g, "")).join("<br>")}</p>`).join("");
    const la = latin && latin["130"] ? `<p>${Object.values(latin["130"]).map(esc).join("<br>")}</p>` : "";
    return `<section class="de-profundis"><h2>De profundis <span class="ref">Ps 129 (130)</span></h2>`
      + `<div class="regard blocs"><div class="fr">${fr}<p class="gloria">Gloire au Père…</p></div>`
      + (la ? `<div class="la"><span class="source-latin">Nova Vulgata</span>${la}</div>` : "") + `</div></section>`;
  }

  function repos(prieres) {
    const p = prieres && prieres.groupes.flatMap((gr) => gr.pieces).find((x) => x.id === "repos-eternel");
    if (!p) return "";
    return `<section class="repos"><h2>Le repos éternel</h2><div class="regard lignes">`
      + p.fr[0].map((l, i) => `<div class="fr">${esc(l)}</div><div class="la">${esc((p.la && p.la[0][i]) || "")}</div>`).join("")
      + `</div></section>`;
  }

  function rendu(date, N, psautier, latin, prieres) {
    const b = du(date, N);
    const [, mo, j] = date.split("-").map(Number);
    let h = `<section class="defunts"><h2>Mémoire de nos frères défunts <span class="ref">${j === 1 ? "1er" : j} ${MOIS[mo - 1]}</span></h2>`;
    if (b.freres.length || b.sansJour.length) {
      h += `<ul>${b.freres.map((d) => frere(d, N.notes)).join("")}</ul>`;
      if (b.sansJour.length) h += `<p class="rubrique">Morts ce mois-ci, sans date précise :</p><ul>${b.sansJour.map((d) => frere(d, N.notes)).join("")}</ul>`;
    } else h += `<p class="rubrique">Aucun frère inscrit ce jour au nécrologe de la Province.</p>`;
    h += `</section>`;
    h += deProfundis(psautier, latin) + repos(prieres);
    return h;
  }

  // nécrologe entier, mois par mois
  function tout(N) {
    const parMois = Array.from({ length: 12 }, () => []);
    for (const [cle, l] of Object.entries(N.jours)) {
      const [m, j] = cle.split("-").map(Number);
      for (const d of l) parMois[m - 1].push({ d, j });
    }
    for (const [m, l] of Object.entries(N.sansJour)) for (const d of l) parMois[Number(m) - 1].push({ d, j: 0 });
    return parMois.map((l, i) => `<details class="mois" data-mois="${i + 1}"><summary>${MOIS[i].charAt(0).toUpperCase() + MOIS[i].slice(1)} <span>${l.length}</span></summary><ul>`
      + l.sort((x, y) => x.j - y.j).map(({ d, j }) => frere(d, null, j ? `${j === 1 ? "1er" : j} ${MOIS[i]},` : "(jour inconnu),")).join("")
      + `</ul></details>`).join("");
  }

  g.Defunts = { du, rendu, tout };
  if (typeof module !== "undefined") module.exports = g.Defunts;
})(typeof window !== "undefined" ? window : globalThis);
