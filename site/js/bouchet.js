/* Lectionnaire patristique dominicain (Jean-René Bouchet o.p.) : lectures proposées au choix
   pour l'Office des lectures. Données : donnees/bouchet.json (outils/construire_bouchet.py).

   Bouchet.pour(jour, { propreOP }) → [{ titre, note, lectures: [{ lecon, citation, ref, auteur, texte }] }]
     - lectures propres du jour (dimanches, fêtes, jours de Carême, sanctoral, vigiles) ;
     - sinon les « autres lectures » du temps (Avent, féries du 17 au 24 décembre, Noël, Épiphanie,
       temps pascal, semaine de la Pentecôte, temps ordinaire).
   Bouchet.html(jour, options, esc) → sections repliées (<details>), ou "" s'il n'y a rien.
*/
(function (g) {
  "use strict";
  let B = null;
  const charger = (x) => (B = x && x.entrees ? x : null);
  const K = () => g.Calendrier;

  // jours entre deux dates ISO / Date
  const jours = (a, b) => Math.round((b - a) / 86400000);

  function cles(j, opts) {
    const C = K(), d = C.deIso(j.date), R = C.reperes(d.getUTCFullYear());
    const ct = j.cleTemporal || "", mmjj = j.date.slice(5);
    const propres = [];
    // temporal (clé AELF du jour) ; Saint-Sacrement : clé du calendrier ou nom
    const kt = /Saint-Sacrement|Corps et (du )?Sang/.test(j.ferie || "") ? "saint-sacrement" : ct === "marie-mere-de-dieu" ? "01-01" : ct;
    const m = /(\d\d-\d\d)$/.exec(j.cleSanctoral || "");
    // une fête ou une solennité du sanctoral qui remplace le dimanche ou la férie (saint Dominique un dimanche, saint Joseph
    // en Carême…) : sa lecture seule, pas celle du dimanche ou de la férie (qui passait avant, et c'est elle qu'on imprimait)
    const feteSanctoral = j.source !== "temporal" && j.niveau <= 8 && m && B.entrees[m[1]];
    if (kt && B.entrees[kt] && !feteSanctoral) propres.push(kt);
    // Noces de Cana : 2e dimanche du temps ordinaire, année C
    if (ct === "ordinaire-2-0" && j.cycle === "C") propres.push("cana");
    // sanctoral : la date de la célébration (solennité transférée, propre de l'Ordre), puis la date du jour
    const dates = [];
    if (m) dates.push(m[1]);
    // la date du jour seulement en semaine (sinon : Annonciation transférée, Saint nom de Jésus le jour de l'Épiphanie…)
    if (!dates.includes(mmjj) && j.niveau > 6) dates.push(mmjj);
    for (let k of dates) {
      // S. Vincent Ferrier : 5 avril (calendrier romain) ou 5 mai (propre de l'Ordre)
      if (k === "04-05" && opts.propreOP) continue;
      if (k === "05-05" && !opts.propreOP) continue;
      if (B.entrees[k] && !propres.includes(k)) propres.push(k);
    }
    // dédicace : celle de l'église locale (22 octobre) et, au choix, celle de l'église cathédrale (date propre au diocèse)
    if (propres.includes("10-22") && B.entrees["dedicace-cathedrale"]) propres.push("dedicace-cathedrale");
    // saint du jour qui n'est pas célébré (mémoire facultative non choisie : bienheureux Henri Suso, saint Antonin, défunts de
    // l'Ordre le 8 novembre…) : les lectures du temps d'abord (c'est l'une d'elles qu'on imprime), celle du saint au choix ;
    // sauf les vigiles (veilles de fête), qui sont la lecture du jour
    const auChoix = propres.length > 0 && propres.every((k) => /^(\d\d-\d\d|dedicace-cathedrale)$/.test(k) && k !== kt && (!m || k !== m[1]) && !/^Vigile/.test(B.entrees[k].titre || ""));
    if (propres.length && !auChoix) return propres;
    const t = autresDuTemps(j, d, R);
    return auChoix ? t.concat(propres) : t;
  }
  // « autres lectures » du temps
  function autresDuTemps(j, d, R) {
    if (j.temps === "avent") return [+j.date.slice(8) >= 17 && j.date.slice(5, 7) === "12" ? "feries-17-24" : "autres-avent"];
    if (j.temps === "noel") return [j.date.slice(5, 7) === "12" || d < R.epiphanie ? "autres-noel" : "autres-epiphanie"];
    if (j.temps === "paques") return ["autres-paques"];
    if (j.temps === "ordinaire") {
      const apres = jours(R.pentecote, d);
      return [apres >= 1 && apres <= 6 ? "autres-pentecote" : "autres-to"];
    }
    return [];
  }

  function pour(j, opts = {}) {
    if (!B) return [];
    const res = [];
    for (const k of cles(j, opts)) {
      const e = B.entrees[k];
      if (!e) continue;
      // identifiant stable de chaque variante : « clé:n° de variante » (pour retenir un choix)
      let vs = [e, ...(e.variantes || [])].map((v, n) => ({ ...v, id: `${k}:${n}` }));
      // S. Vincent Ferrier au 5 avril : texte de Carême ou du temps pascal
      if (k === "04-05") { const f = vs.filter((v) => (j.temps === "paques" ? /pascal/ : /Carême/).test(v.note || "")); if (f.length) vs = f; }
      vs = vs.filter((v) => { const a = /Année ([ABC])/i.exec(v.note || ""); return !a || a[1].toUpperCase() === j.cycle; });
      for (const v of vs) res.push({ cle: k, autres: /^(autres-|feries-)/.test(k), ...v, lectures: v.lectures.map((l, n) => ({ ...l, id: `${v.id}:${n}` })) });
    }
    return res;
  }

  /* Rendu.
     → { section : les lectures proposées pour l'écran (une seule : en clair ; plusieurs : chacune repliée),
         imprime : les lectures à imprimer quand on choisit le lectionnaire à l'export :
           jour propre → toutes les lectures de l'entrée (les trois leçons de Noël, les nocturnes du Triduum…) ;
           « autres lectures » du temps → une seule, prise à tour de rôle selon la date. } */
  function rendu(j, opts, esc) {
    const gr = pour(j, opts);
    if (!gr.length) return { section: "", imprime: "" };
    const texte = (t) => t.map(([l, r]) => `<p${r ? ` class="vers${r === 2 ? " retrait" : ""}"` : ""}>${esc(l)}</p>`).join("");
    const corps = (l) => `${l.citation || l.ref ? `<p class="bouchet-citation">${l.citation ? `« ${esc(l.citation)} »` : ""}${l.ref ? ` <span class="ref">${esc(l.ref)}</span>` : ""}</p>` : ""}<h4>${esc(l.auteur)}</h4><div class="lecture patristique">${texte(l.texte)}</div>`;
    const toutes = gr.flatMap((x) => x.lectures.map((l) => ({ x, l })));
    let section = "";
    if (toutes.length === 1) section = `${toutes[0].l.lecon ? `<p class="note">${esc(toutes[0].l.lecon)}</p>` : ""}${corps(toutes[0].l)}`;
    else {
      section = `<p class="note">${toutes.length} lectures proposées : déplier celle que l'on veut lire.</p>`;
      for (const { x, l } of toutes) {
        const nom = `${x.titre}${x.note ? ` (${x.note})` : ""}`;
        const resume = `${x.autres ? `${esc(x.titre)} — ` : gr.length > 1 ? `${esc(nom)} — ` : ""}${l.lecon ? `${esc(l.lecon)} : ` : ""}${esc(l.auteur)}`;
        section += `<details class="lecture-bouchet"><summary>${resume}</summary>${corps(l)}</details>`;
      }
    }
    // à imprimer
    const premier = gr[0];
    let choisies;
    if (premier.autres) {
      const n = Math.round(Date.UTC(+j.date.slice(0, 4), +j.date.slice(5, 7) - 1, +j.date.slice(8)) / 86400000);
      choisies = [premier.lectures[n % premier.lectures.length]];
    } else choisies = premier.lectures;
    const imprime = choisies.map((l) => `<div class="lecture-bouchet-retenue">${l.lecon ? `<p class="note">${esc(l.lecon)}</p>` : ""}${corps(l)}</div>`).join("");
    return { section, imprime };
  }
  const html = (j, opts, esc) => rendu(j, opts, esc).section;

  g.Bouchet = { charger, pour, html, rendu, cles: (j, o = {}) => (B ? cles(j, o) : []) };
})(typeof window !== "undefined" ? window : globalThis);
