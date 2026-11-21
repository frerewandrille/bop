/* Martyrologe (trois éditions de la Province) et mémoire des frères défunts.

   Martyrologe.pour(j, M, N, edition) : j = Calendrier.jour(date), M = donnees/martyrologe.json,
   N = donnees/necrologe.json. Renvoie { mobile, eloges, remarque, conclusion, defunts, sansJour }.

   - 28 février des années non bissextiles : on lit aussi le 29 février (martyrologe et défunts).
   - Fêtes mobiles : l'éloge propre (Épiphanie avec l'annonce des fêtes de l'année, Cendres, Pâques…)
     vient avant les éloges du jour.
   - Défunts dont le catalogue ne donne que le mois : nommés le 1er du mois.
*/
(function (g) {
  "use strict";
  const MOIS = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"];
  const bissextile = (a) => (a % 4 === 0 && a % 100 !== 0) || a % 400 === 0;

  function cleMobile(j) {
    const c = j.cleTemporal || "", n = j.ferie || "";
    if (c === "epiphanie") return "epiphanie";
    if (c === "bapteme") return "bapteme";
    if (c === "careme-0-3") return "cendres";
    if (c === "careme-6-0") return "rameaux";
    if (c === "paques-1-0") return "paques";
    if (/^Ascension/.test(n)) return "ascension";
    if (n === "Pentecôte") return "pentecote";
    if (["trinite", "saint-sacrement", "sacre-coeur", "christ-roi", "sainte-famille"].includes(c)) return c;
    if (j.cleSanctoral === "coeur-immacule" || (j.facultatives || []).some((f) => /Cœur immaculé/.test(f.nom))) return "coeur-immacule";
    return null;
  }

  // « le… » de l'annonce des fêtes mobiles (Épiphanie) : dates de l'année
  function annonceDates(lignes, annee) {
    const C = g.Calendrier, R = C.reperes(annee);
    const dit = (d) => `le ${d.getUTCDate() === 1 ? "1er" : d.getUTCDate()} ${MOIS[d.getUTCMonth()]}`;
    const noel = C.deIso(`${annee}-12-25`);
    const avent = C.plus(noel, -(noel.getUTCDay() || 7) - 21);
    const dates = [[/Pâques/, R.paques], [/Cendres/, R.cendres], [/Ascension/, R.ascension], [/Pentecôte/, R.pentecote], [/Avent/, avent]];
    // chaque « le… » prend la date de la fête nommée juste avant lui (lignes séparées ou paragraphe d'un bloc)
    return lignes.map((l) => l.replace(/le…/g, (tout, i) => {
      const avant = l.slice(0, i);
      let meilleur = null, pos = -1;
      for (const [re, d] of dates) {
        const m = [...avant.matchAll(new RegExp(re.source, "g"))].pop();
        if (m && m.index > pos) { pos = m.index; meilleur = d; }
      }
      return meilleur ? dit(meilleur) + (/^\s*$/.test(l.slice(i + 3)) ? "." : "") : tout;
    }));
  }

  function pour(j, M, N, edition) {
    const ed = M.jours[edition] ? edition : "romain";
    const [a, mo, jr] = j.date.split("-").map(Number);
    const cle = j.date.slice(5);
    const plus29 = cle === "02-28" && !bissextile(a);
    let eloges = [...(M.jours[ed][cle] || [])];
    if (cle === "02-28") {                           // « Puis, uniquement si l'année n'est pas bissextile : »
      const i = eloges.findIndex((p) => /^Puis, uniquement si/.test(p));
      if (plus29) { eloges = eloges.concat(M.jours[ed]["02-29"] || []); if (i < 0) eloges.splice(eloges.length - (M.jours[ed]["02-29"] || []).length, 0, "Puis, uniquement si l’année n’est pas bissextile :"); }
      else if (i >= 0) eloges = eloges.slice(0, i);
    }
    let mobile = null;
    const km = cleMobile(j);
    if (km && M.mobiles[ed][km]) {
      const m = M.mobiles[ed][km];
      mobile = { cle: km, titre: m.titre.replace(/\s*\(.*\)\s*$/, ""), texte: km === "epiphanie" ? annonceDates(m.texte, a) : m.texte };
    }
    let defunts = [...(N.jours[cle] || [])];
    if (plus29) defunts = defunts.concat((N.jours["02-29"] || []).map((d) => ({ ...d, du29: true })));
    const sansJour = jr === 1 ? (N.sansJour[String(mo).padStart(2, "0")] || []) : [];
    return {
      edition: ed, mobile, eloges, plus29,
      remarque: (M.remarques[ed] || {})[cle] || null,
      conclusion: j.temps === "paques" ? M.intro.conclusionPascale : M.intro.conclusion,
      defunts, sansJour,
    };
  }

  const esc = (s) => String(s).replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));
  // les éloges sont du html réduit (<b>, <sup>) produit par outils/construire_martyrologe.py : on n'en garde que ces balises
  const sur = (h) => String(h).replace(/<(?!\/?(b|sup)>)[^>]*>/g, "");

  // consignes et anniversaires du diocèse ou de l'Ordre, à lire autrement qu'un éloge
  const RUBRIQUE = /^(Puis, uniquement si|Proclamation solennelle|Tous les frères répondent|Poursuivre en disant|Avant de commencer|(1er|\d{1,2}) \S+, jour anniversaire|jour anniversaire)/;

  function frere(d, notes) {
    let nom = esc(d.nom).replace(/^\(Bx\)\s*/, "");
    const bx = /^\(Bx\)/.test(d.nom) || d.note === "bienheureux";
    return `<li><span class="nom">${bx ? "bienheureux " : "fr. "}${nom}</span>`
      + `<span class="detail"> — ${d.annee}${d.lieu ? ", " + esc(d.lieu) : ""}${d.du29 ? " (29 février)" : ""}</span>`
      + (bx ? `<span class="note">${esc(notes.bienheureux)}</span>` : "") + `</li>`;
  }

  function rendu(j, M, N, edition) {
    const b = pour(j, M, N, edition);
    const [, mo, jr] = j.date.split("-").map(Number);
    const dateDite = `${jr === 1 ? "1er" : jr} ${MOIS[mo - 1]}`;
    let h = "";
    if (b.mobile) h += `<section class="mobile"><h2>${esc(b.mobile.titre)}</h2>`
      + b.mobile.texte.map((p) => `<p${RUBRIQUE.test(p) ? ' class="rubrique"' : ""}>${sur(p)}</p>`).join("") + `</section>`;
    h += `<section class="eloges"><p class="annonce">Anniversaires inscrits au martyrologe du ${esc(dateDite)}.</p>`;
    h += b.eloges.map((p) => `<p${RUBRIQUE.test(p) ? ' class="rubrique"' : ""}>${sur(p)}</p>`).join("");
    h += `<p class="conclusion">${esc(b.conclusion)}</p>`;
    if (b.remarque) h += `<p class="rubrique">${esc(b.remarque)}</p>`;
    h += `</section>`;
    h += `<section class="defunts"><h2>Mémoire de nos frères défunts</h2>`;
    if (b.defunts.length || b.sansJour.length) {
      h += `<ul>${b.defunts.map((d) => frere(d, N.notes)).join("")}</ul>`;
      if (b.sansJour.length) h += `<p class="rubrique">Morts ce mois-ci, sans date précise :</p><ul>${b.sansJour.map((d) => frere(d, N.notes)).join("")}</ul>`;
    } else h += `<p class="rubrique">Aucun frère inscrit ce jour au nécrologe de la Province.</p>`;
    h += `<p class="legende">${esc(N.notes.lettres)} ${esc(N.notes.lieux)}</p></section>`;
    return h;
  }

  g.Martyrologe = { pour, rendu, cleMobile };
  if (typeof module !== "undefined") module.exports = g.Martyrologe;
})(typeof window !== "undefined" ? window : globalThis);
