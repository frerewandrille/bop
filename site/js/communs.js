/* Communs des saints, d'après « Les Heures grégoriennes » (tome III), pour les laudes, le milieu du jour
   et les vêpres ; l'Office des lectures et les complies restent ceux de l'AELF.

   Données : partitions/hg/communs.json (outils/construire_communs.py), présentes seulement avec les
   partitions (usage privé, site protégé).
   Choix d'un jour : options.communs[date] = { id, pour, psaumes: "commun" | "ferie" }   (réglage pref.communs)

   Communs.pour(choix, j, office) → pièces du commun pour ce jour et cet office (variantes déjà choisies) :
     { nom, psaumes: [ref…] | null, antiennes: [texte, texte, texte], hymne: [[lignes]…] | null,
       lecture: {ref, texte}, repons: [lignes], evangelique, preces: [lignes], oraison, milieu: [{ref, verset}] }
   Communs.suggerer(j) → { id, pour } d'après le nom du saint du jour
   Communs.latin(choix, j, office) → éléments bruts du livre, pour la version latin-français
*/
(function (g) {
  "use strict";
  let D = null;
  const NU = (t) => String(t || "").replace(/<[^>]+>/g, "").trim();

  async function charger() {
    try {
      const r = await fetch("partitions/hg/communs.json", { cache: "no-cache" });
      if (!r.ok) return false;
      D = await r.json();
      return true;
    } catch (e) { D = null; return false; }
  }
  const commun = (id) => D?.communs.find((c) => c.id === id) || null;

  // ── Suggestion : d'abord l'indication du Missel pour ce saint (« Commun des pasteurs : pour un évêque »),
  //    comme à la Messe ; sinon d'après le nom de la célébration
  const sansAccent = (t) => String(t || "").normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase();
  const prenom = (t) => (sansAccent(t).replace(/^(s\.|ste|saint|sainte|saints|saintes|bx|bse|bienheureux|bienheureuse)\s+/, "").match(/[a-z]{3,}/) || [""])[0];
  function suggerer(j) {
    const parNom = suggererNom(j);
    const ind = D?.indications?.[String(j?.date || "").slice(5)] || [];
    const x = ind.find((i) => prenom(i.titre) && prenom(i.titre) === prenom(j.nom)) || (ind.length === 1 && j.source !== "temporal" ? ind[0] : null);
    if (!x) return parNom;
    return { id: x.id, pour: x.pour || (parNom.id === x.id ? parNom.pour : null), missel: x.missel };
  }
  function suggererNom(j) {
    const n = String(j?.nom || "").toLowerCase();
    const fem = /^(sainte|bienheureuse|saintes)\b/.test(n) || /\bsainte\b/.test(n) && !/\bsaint\b/.test(n);
    if (/dédicace/.test(n)) return { id: "dedicace" };
    if (/défunts/.test(n)) return { id: "defunts", pour: /fidèles défunts/.test(n) ? "la commémoration de tous les fidèles défunts, le 2 novembre" : null };
    if (/notre-dame|vierge marie|sainte marie|cœur immaculé|bienheureuse vierge/.test(n)) return { id: "vierge-marie" };
    if (/apôtres?\b/.test(n)) return { id: "apotres" };
    if (/martyrs|martyres|et (ses )?compagnons/.test(n)) return { id: "martyrs", pour: /vierges/.test(n) ? "des vierges martyres" : null };
    if (/martyr/.test(n)) return { id: "martyr", pour: /vierge/.test(n) ? "une vierge martyre" : null };
    if (/docteur/.test(n)) return { id: "docteurs" };
    if (/\bpape\b/.test(n)) return { id: "pasteurs", pour: "un pape" };
    if (/évêques?\b/.test(n)) return { id: "pasteurs", pour: /évêques/.test(n) ? "plusieurs pasteurs" : "un évêque" };
    if (/prêtre|curé|missionnaire/.test(n)) return { id: "pasteurs", pour: "un prêtre" };
    if (/vierge/.test(n)) return { id: "vierges", pour: /vierges/.test(n) ? "plusieurs vierges" : null };
    if (/religieuse|abbesse|moniale/.test(n)) return { id: "saintes", pour: "une religieuse" };
    if (/religieux|abbé|moine|ermite|frère|fondateur/.test(n)) return { id: fem ? "saintes" : "saints", pour: fem ? "une religieuse" : "un religieux" };
    if (/saints\b/.test(n) && / et /.test(n)) return { id: "plusieurs-saints" };
    if (fem) return { id: "saintes" };
    return { id: "saints" };
  }

  // ── Choix des variantes
  function contexte(j, choix) {
    const careme = ["careme", "semaine sainte"].includes(j.temps);
    return { tp: j.temps === "paques", temps: careme ? "careme" : j.temps, careme, pour: choix.pour || null, lieu: choix.lieu || "dans",
      rang: j.niveau <= 4 ? "solennités" : j.niveau <= 8 ? "mémoires, fêtes et solennités" : "mémoires" };
  }
  function compatible(s, cx) {
    if (s.tp === true && !cx.tp) return false;
    if (s.tp === false && cx.tp) return false;
    if (s.temps === "hors-careme" ? cx.careme : s.temps && s.temps !== cx.temps) return false;
    if (s.lieu && s.lieu !== cx.lieu) return false;
    return true;
  }
  function score(s, cx) {
    let n = 0;
    if (s.tp === cx.tp) n += 2;
    if (s.temps && s.temps !== "hors-careme") n += 2;
    if (s.pour && s.pour === cx.pour) n += 4;
    else if (s.pour) n -= 3;       // variante pour un autre cas : seulement à défaut
    if (s.rang && (s.rang === cx.rang || cx.rang.includes(s.rang))) n += 1;
    return n;
  }
  function meilleur(segs, cx) {
    let m = null, sm = -Infinity;
    for (const s of segs || []) {
      if (!compatible(s, cx)) continue;
      const v = score(s, cx);
      if (v > sm) { sm = v; m = s; }
    }
    return m;
  }
  // « (T.P. Alléluia.) » : gardé au temps pascal, retiré sinon
  const alleluia = (t, cx) => String(t || "").replace(/\s*\(T\.\s?P\.\s*(Allé\s*-?\s*luia\.?)\s*\)/g, cx.tp ? " Alléluia." : "").replace(/\s{2,}/g, " ").trim();

  // hymne : hymne entière propre au cas (pour une vierge martyre…), sinon l'hymne commune, avec la strophe propre au cas
  function hymne(liste, cx) {
    if (!liste?.length) return null;
    const ok = liste.filter((s) => compatible(s, cx));
    const entiere = ok.find((s) => s.pour && s.pour === cx.pour && !s.strophe);
    if (entiere) return entiere.texte;
    let base = ok.filter((s) => !s.pour && !s.suite);
    // hymne du temps pascal (ou d'un temps) : elle remplace celle du reste de l'année
    const duTemps = base.filter((s) => (s.tp === true && cx.tp) || (s.temps && s.temps === cx.temps));
    if (duTemps.length) base = duTemps;
    const rangs = base.filter((s) => s.rang);
    if (rangs.length) base = [rangs.find((s) => s.rang === cx.rang || cx.rang.includes(s.rang)) || rangs[0]];
    else if (base.length > 1) base = [base[0]];
    if (!base.length) return null;
    const strophes = ok.filter((s) => s.strophe);
    const str = strophes.find((s) => s.pour === cx.pour) || strophes[0];
    const suite = ok.filter((s) => s.suite);
    return [...base[0].texte, ...(str ? str.texte : []), ...(suite[0] ? suite[0].texte : [])];
  }

  const OFF = { laudes: ["laudes"], milieu: ["milieu"], vepres: ["vepres2", "vepres", "vepres1"], vepres1: ["vepres1", "vepres", "vepres2"] };
  function pieces(id, office) {
    const c = commun(id);
    if (!c) return [];
    const ids = [id, c.base].filter(Boolean);
    const out = [];
    for (const x of ids) for (const o of OFF[office] || []) { const p = D.offices[`${x}|${o}`]; if (p) out.push({ id: x, o, p }); }
    return out;
  }
  // premier office (commun choisi, puis celui auquel il renvoie) qui donne ce champ
  const premier = (ps, champ) => ps.find((x) => x.p[champ]?.length)?.p[champ] || null;

  function pour(choix, j, office) {
    if (!D || !choix?.id || !OFF[office]) return null;
    const c = commun(choix.id);
    if (!c) return null;
    const cx = contexte(j, choix);
    const ps = pieces(choix.id, office);
    if (!ps.length) return null;
    const r = { id: c.id, nom: c.nom, pour: choix.pour || null };
    // psalmodie : psaumes et antiennes du même office (pas de mélange entre communs)
    const src = ps.find((x) => x.p.antiennes?.length && (office === "milieu" || x.p.psaumes?.length));
    if (src) {
      const parN = {};
      for (const a of src.p.antiennes) (parN[a.n] ||= []).push(a);
      r.antiennes = Object.keys(parN).sort((a, b) => a - b).map((n) => { const a = meilleur(parN[n], cx); return a ? { texte: alleluia(a.texte, cx), partitions: a.partitions || [] } : null; }).filter(Boolean);
      r.psaumes = src.p.psaumes || null;
    }
    r.hymne = hymne(premier(ps, "hymne"), cx);
    const le = meilleur(premier(ps, "lecture"), cx);
    if (le) r.lecture = { ref: le.ref, texte: le.texte };
    const re = meilleur(premier(ps, "repons"), cx);
    if (re) r.repons = re.texte.map((t) => alleluia(t, cx));
    const ev = meilleur(premier(ps, "evangelique"), cx);
    if (ev) r.evangelique = alleluia(ev.texte, cx);
    const pr = meilleur(premier(ps, "preces"), cx);
    if (pr) r.preces = pr.texte;
    const ors = premier(ps, "oraison") || (office === "milieu" || office === "vepres1" ? premier(pieces(choix.id, "laudes"), "oraison") : null);
    const or = meilleur(ors, cx);
    if (or) r.oraison = or.texte;
    const mil = premier(ps, "milieu");
    if (mil) {
      const tp = mil.filter((m) => m.tp === true), autres = mil.filter((m) => m.tp !== true);
      r.milieu = (cx.tp && tp.length ? tp : autres).slice(0, 3).map((m) => ({ ref: m.ref, verset: m.verset.map((t) => alleluia(t, cx)) }));
    }
    return r;
  }

  // ── Version latin-français : les éléments du livre, à placer avant le psautier
  function latin(choix, j, office) {
    if (!D || !choix?.id) return [];
    const offs = office === "vepres" ? ["vepres2", "vepres", "vepres1"] : office === "laudes" || office === "milieu" ? [office] : [];
    const out = [];
    for (const id of [choix.id, commun(choix.id)?.base].filter(Boolean)) for (const o of offs) {
      let els = D.brut[`${id}|${o}`];
      if (!els) continue;
      if (choix.psaumes === "ferie") els = els.filter((e) => e.t !== "psaume" && !(e.t === "antienne" && e.n));
      out.push({ cle: `3:C/${id}|${o}`, els });
    }
    return out;
  }

  // ── Recueil des communs à consulter et à choisir (bouton « Communs » de la barre, comme le « Missel » de la Messe)
  //    vue(id, j, choisi) → { titre, html, sommaire } ; adresses #communs et #communs/<id>
  const DESC = { dedicace: "Anniversaire de la dédicace d'une église.", "vierge-marie": "Fêtes et mémoires de la Vierge Marie, samedi de Notre-Dame.",
    apotres: "Fêtes des apôtres et des évangélistes.", martyrs: "Plusieurs martyrs ; vierges martyres.", martyr: "Un martyr ; une vierge martyre.",
    pasteurs: "Papes, évêques, prêtres, plusieurs pasteurs, missionnaires.", docteurs: "Docteurs de l'Église.", vierges: "Une vierge, plusieurs vierges.",
    saints: "Saints ; religieux, éducateurs, œuvres de miséricorde.", saintes: "Saintes ; religieuses, éducatrices, œuvres de miséricorde.",
    "plusieurs-saints": "Plusieurs saints ; saintes femmes.", defunts: "Office des défunts." };
  const NOMS_OFF = { vepres1: "Premières vêpres", laudes: "Laudes", milieu: "Milieu du jour", vepres: "Vêpres", vepres2: "Vêpres" };
  function vue(id, j, choisi) {
    const esc = g.Textes.esc;
    const sug = suggerer(j);
    const actif = choisi?.id || null;
    const som = [{ href: "#communs", titre: "Tous les communs", actif: !id }, ...(D?.communs || []).map((c) => ({ href: `#communs/${c.id}`, titre: c.nom, actif: c.id === id }))];
    const ariane = (t) => `<nav class="ariane-missel no-print" aria-label="Fil d’Ariane"><a href="#communs">Communs</a>${t ? ` › <span>${esc(t)}</span>` : ""}</nav>`;
    const jour = `${j.dateLongue} — ${j.nom}`;
    const etat = actif ? `Ce jour : <b>${esc(commun(actif)?.nom || actif)}</b>${choisi.pour ? ` (pour ${esc(choisi.pour)})` : ""}${choisi.auto ? " — appliqué d'office" : ""}.` : "Ce jour : aucun commun (textes du jour).";
    const c = commun(id);
    if (!c) {
      return { titre: "Communs des saints", sommaire: som, html: `<header class="entete-office entete-missel"><p class="date-longue">Les Heures grégoriennes · tome III</p><h2>Communs des saints</h2><p class="celebration">${esc(jour)}</p><p class="ferie">${etat}</p></header>`
        + `<p class="aide-communs">Choisissez un commun pour le consulter et le prendre pour l'office de ce jour (laudes, milieu du jour, vêpres), même sans mémoire au calendrier.</p>`
        + `<div class="cartes-missel">${D.communs.map((x) => `<a class="carte-missel${x.id === actif ? " actif" : ""}" href="#communs/${x.id}"><span class="t">${esc(x.nom)}</span><span class="d">${esc(DESC[x.id] || "")}</span><span class="n">${x.id === actif ? "choisi pour ce jour" : x.id === sug.id ? "suggéré pour ce jour" : x.offices.map((o) => NOMS_OFF[o] || o).join(" · ")}</span></a>`).join("")}</div>`
        + `<p class="notes-messe">Les Heures grégoriennes (Communauté Saint-Martin), tome III : communs des saints. L'Office des lectures et les complies restent ceux du jour (AELF).</p>` };
    }
    const pourActuel = actif === id ? choisi.pour : sug.id === id ? sug.pour : null;
    const psActuel = actif === id ? choisi.psaumes : j.source !== "temporal" && j.niveau > 8 ? "ferie" : "commun";
    let form = `<form class="choisir-commun no-print" data-commun="${esc(id)}">`;
    if (c.precisions.length) form += `<label>Précision <select name="pour"><option value="">—</option>${c.precisions.map((p) => `<option value="${esc(p)}"${p === pourActuel ? " selected" : ""}>pour ${esc(p)}</option>`).join("")}</select></label>`;
    form += `<label>Psaumes <select name="psaumes"><option value="commun"${psActuel !== "ferie" ? " selected" : ""}>du commun (fête)</option><option value="ferie"${psActuel === "ferie" ? " selected" : ""}>de la férie (mémoire)</option></select></label>`;
    if (id === "dedicace") form += `<label>Oraison <select name="lieu"><option value="dans">dans l'église consacrée</option><option value="hors"${choisi?.lieu === "hors" ? " selected" : ""}>hors de l'église consacrée</option></select></label>`;
    form += `<div class="boutons"><button class="bouton principal" type="submit">${actif === id ? "Mettre à jour" : "Prendre ce commun"} le ${esc(j.date.split("-").reverse().join("/"))}</button>${actif ? `<button class="bouton" type="button" data-retirer>Aucun commun ce jour</button>` : ""}</div></form>`;
    // aperçu de chaque office, avec les variantes du jour affiché
    const cx = { ...choisi, id, pour: pourActuel };
    let corps = "";
    for (const o of ["vepres1", "laudes", "milieu", "vepres"]) {
      const r = o === "vepres1" && !D.offices[`${id}|vepres1`] ? null : pour(cx, j, o);
      if (!r) continue;
      const li = [];
      if (r.hymne?.length) li.push(["Hymne", esc(r.hymne[0].replace(/^\d+\.\s*/, "")) + "…"]);
      if (r.psaumes?.length && o !== "milieu") li.push(["Psaumes", r.psaumes.map((p) => esc(p.replace(/^CANTIQUE \((.+)\)$/, "cantique $1"))).join(" · ")]);
      (r.antiennes || []).forEach((a, i) => li.push([o === "milieu" ? "Antienne" : `Antienne ${i + 1}`, esc(a.texte)]));
      if (r.lecture) li.push(["Lecture brève", esc(r.lecture.ref)]);
      if (r.milieu) li.push(["Capitules", r.milieu.map((m) => esc(m.ref)).join(" · ")]);
      if (r.evangelique) li.push([o === "laudes" ? "Ant. du Benedictus" : "Ant. du Magnificat", esc(r.evangelique)]);
      if (r.oraison) li.push(["Oraison", esc(r.oraison)]);
      corps += `<section class="bloc"><h3>${NOMS_OFF[o]}</h3><dl class="apercu-commun">${li.map(([t, d]) => `<dt>${t}</dt><dd>${d}</dd>`).join("")}</dl></section>`;
    }
    return { titre: `${c.nom} — Communs`, sommaire: som, html: ariane(c.nom) + `<header class="entete-office entete-missel"><p class="date-longue">Commun des saints</p><h2>${esc(c.nom)}</h2><p class="celebration">${esc(jour)}</p><p class="ferie">${etat}</p></header>`
      + form + corps + `<p class="notes-messe">Aperçu avec les variantes du ${esc(j.dateLongue)} (temps liturgique, précision). Les Heures grégoriennes, tome III.</p>` };
  }

  g.Communs = { charger, pour, suggerer, latin, vue, get liste() { return D?.communs || []; }, commun, get charge() { return !!D; } };
})(typeof window !== "undefined" ? window : globalThis);
