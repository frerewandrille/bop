/* Assemblage des offices : Lectures, Laudes, Milieu du jour, Vêpres, Complies — le « chef d'orchestre ».

   Place dans l'ensemble : appelé par app.js (écran, PDF, Word) et horsligne.js. Il ne lit aucun fichier
   lui-même : il interroge les autres modules, chacun responsable d'une source, et en fait un seul HTML.
     calendrier.js  quel jour liturgique (temps, semaine, saint, préséance, propre OP)
     aelf.js        textes propres du jour (hymnes, antiennes, répons, oraisons, lectures patristiques)
     textes.js      psaumes et cantiques du psautier BJ (inflexions en gras), lectures de la Bible BJ
     gouzes.js, saintebaume.js, milieu.js, capitules.js, communs.js, propreop.js, bouchet.js
                    répartitions et ajouts propres (Gouzes, Sainte-Baume, carnets de la Province, Ordre…)
     partitions.js  images de partitions à poser sous chaque texte ; latin.js : version latin-français
   Tout HTML venu de l'AELF passe par propre() (liste blanche de balises).

   Offices.construire(date, office, options) → Promise<{ titre, html, avertissements[] }>
   options (préparées par app.js) : { propreOP, repartition: "aelf" | "romaine" | "romaine-gouzes" |
     "sainte-baume" (ramenée à romaine-gouzes + saintebaume) | "gouzantine" | "latin", partitions,
     invitatoire, prieres, capitules, oraison, heure, lecture2, choix, communs, psaumesCarnet, impression }
*/
(function (g) {
  "use strict";
  const { esc } = g.Textes;
  const OFFICES = {
    lectures: "Office des lectures", laudes: "Laudes", milieu: "Office du milieu du jour", vepres: "Vêpres", complies: "Complies",
  };
  let JS = null;   // laudes et complies des jours saints (livret de la communauté)
  const chargerJoursSaints = (x) => (JS = x);
  let CB = null;   // complies du livret de Bordeaux (Propre O.P.)
  const chargerComplies = (x) => (CB = x);
  let PR = null;   // prière du président avant le Notre Père, provinces de l'Ordre, oraisons des Heures grégoriennes
  const chargerPresident = (x) => (PR = x);
  const JSEM = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"];
  // intention du jour (province de l'Ordre…) selon le jour du mois : mois impairs / mois pairs
  function intentionDuJour(j) {
    if (!PR) return null;
    const mois = +j.date.slice(5, 7), jour = +j.date.slice(8);
    return PR.provinces[mois % 2 ? "impairs" : "pairs"][jour] || null;
  }
  const pourIntention = (t) => (/^(Province|Vice-province)/.test(t) ? "pour la " + t : /^(Les|Le|Nos|Ceux) /.test(t) ? "pour " + t[0].toLowerCase() + t.slice(1) : "pour " + t);
  // « de saint Albert le Grand, » : le saint du jour dans la formule « Faisant mémoire… »
  function saintDuJour(j) {
    if (j.source === "temporal" || !j.nom || j.niveau > 12) return "";
    let n = j.nom.split(",")[0].split(" ; ")[0].trim();
    if (/Vierge Marie|Notre-Dame|Seigneur|Croix|Dédicace|Trinité|Sacré|Sacrement|Christ|Toussaint|Tous les saints|défunts|Anniversaire|Conversion|Chaire|Nativité|Martyre|Translation/i.test(n)) return "";
    const un = (x) => x.replace(/\bSs?\. /g, "saint ").replace(/\bSte /g, "sainte ").replace(/\bSaint /g, "saint ").replace(/\bSainte /g, "sainte ");
    if (/^(S\. |Saint )/.test(n)) return (/ et /.test(n) ? "des saints " + un(n).replace(/saint /g, "") : "de " + un(n)) + ", ";
    if (/^(Ste |Sainte )/.test(n)) return "de " + un(n) + ", ";
    if (/^(Ss\.? |Saints )/.test(n)) return "des saints " + n.replace(/^(Ss\.? |Saints )/, "").replace(/\bS\. /g, "") + ", ";
    if (/^Stes /.test(n)) return "des saintes " + n.slice(5) + ", ";
    if (/^Bx /.test(n)) return "du bienheureux " + n.slice(3) + ", ";
    if (/^B(se|ses) /.test(n)) return "de la bienheureuse " + n.replace(/^B(se|ses) /, "") + ", ";
    return "";
  }
  // Avant le Notre Père (laudes, vêpres) : paroles du président, en italique ; dessous, discrètement, l'intention du jour
  function president(j, office) {
    if (!PR || (office !== "laudes" && office !== "vepres")) return "";
    const it = intentionDuJour(j);
    let t = "";
    if (office === "vepres") t += `<p>${esc(PR.formule_vepres.replace("{intention}, ", it ? pourIntention(it) + ", " : ""))}</p>`;
    t += `<p>${esc(PR.memoire.replace("{saint}", saintDuJour(j)))}</p>`;
    if (it && office === "vepres") t += `<p class="province-jour">Aujourd’hui, nous prions pour : ${esc(it)}.</p>`;   // pas aux laudes
    return `<section class="bloc president">${t}</section>`;
  }
  // deux textes presque identiques (ponctuation, « Amen », « Jésus Christ » / « Jésus-Christ »…) ?
  function memeTexte(a, b) {
    const decode = (t) => { if (typeof document === "undefined") return t; const e = document.createElement("textarea"); e.innerHTML = t; return e.value; };
    const mots = (t) => decode(String(t).replace(/<[^>]+>/g, " ")).normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase().replace(/\bamen\b/g, "").split(/[^a-zœæ]+/).filter(Boolean);
    // la conclusion (« Par Jésus Christ… », « Lui qui règne… ») est longue chez l'AELF, abrégée dans le livre : on la retire
    const sansConclusion = (m) => {
      for (let i = Math.floor(m.length * 0.4); i < m.length - 1; i++)
        if ((m[i] === "par" && ["jesus", "le", "notre"].includes(m[i + 1])) || ((m[i] === "lui" || m[i] === "toi") && /^(qui)$/.test(m[i + 1]) && /^(regne|regnes|vit|vis)$/.test(m[i + 2] || ""))) return m.slice(0, i);
      return m;
    };
    const x = sansConclusion(mots(a)), y = sansConclusion(mots(b));
    if (!x.length || !y.length) return false;
    const reste = new Map(); for (const m of y) reste.set(m, (reste.get(m) || 0) + 1);
    let communs = 0; for (const m of x) if (reste.get(m) > 0) { communs++; reste.set(m, reste.get(m) - 1); }
    return (2 * communs) / (x.length + y.length) >= 0.85;
  }
  // Psaume invitatoire selon le jour (demande de l'utilisateur, 17/11/2026) : dimanches et fêtes 94 ;
  // lundi et jeudi 23 ; mardi et samedi 99 ; mercredi et vendredi 66 (numérotation grecque)
  const INVITATOIRE = ["94", "23", "99", "66", "23", "66", "99"];
  function psaumeInvitatoire(j, d) {
    const n = j.jourSemaine === 0 || j.niveau <= 8 ? "94" : INVITATOIRE[j.jourSemaine];
    return g.Psautier.trouver(n, []) ? { reference: n, texte: "" } : d.psaume_invitatoire;
  }
  // Oraison : liturgique (AELF) ou des Heures grégoriennes, l'autre repliée. L'oraison des Heures grégoriennes est
  // cherchée dans les trois tomes (partitions/hg/offices.json, Latin.oraison) pour les laudes, le milieu du jour
  // (selon l'heure : tierce, sexte, none), les vêpres et les complies ; à défaut, celle du psautier
  // (president.json, féries du temps ordinaire).
  function oraisonGregorienne(j, office, options) {
    const r = g.Latin?.oraison ? g.Latin.oraison(j, office, options.heure || "sexte", { propreOP: !!options.propreOP }) : null;
    if (r?.fr) return r.fr.replace(/^<div[^>]*>|<\/div>$/g, "");
    const cle = PR && j.temps === "ordinaire" && j.source === "temporal" && j.jourSemaine !== 0 && j.psautier && office !== "complies" ? `${j.psautier}/${JSEM[j.jourSemaine]}/${office}` : null;
    return cle && PR.oraisons[cle] ? `<p>${esc(PR.oraisons[cle])}</p>` : null;
  }
  function oraisonContenu(j, office, liturgique, options) {
    const hgH = AELF_PUR ? null : oraisonGregorienne(j, office, options);
    if (!hgH) return liturgique;
    if (vide(liturgique)) return hgH + `<p class="source-oraison note">Oraison des Heures grégoriennes</p>`;
    // même prière des deux côtés : une seule version
    if (memeTexte(hgH, liturgique)) return liturgique;
    const [montree, autre, nomAutre] = options.oraison === "gregoriennes" ? [hgH, liturgique, "Oraison liturgique (AELF)"] : [liturgique, hgH, "Oraison des Heures grégoriennes"];
    return `${montree}<details class="autre-oraison"><summary>Ou bien : ${nomAutre}</summary>${autre}</details>`;
  }
  // Célébrations de l'Ordre (et saints du Missel de l'Ordre) : la PRIÈRE du Missel de l'Ordre d'abord (demande de l'utilisateur,
  // 20/11/2026) ; les autres oraisons (AELF, commun, Heures grégoriennes, autres prières du Missel) repliées dessous.
  function avecOraisonOP(j, options, blocHtml) {
    if (AELF_PUR || !options.propreOP || !g.PropreOP || !blocHtml) return blocHtml;
    const p = g.PropreOP.priere(j);
    if (!p || !p.paras.length) return blocHtml;
    const op = g.PropreOP.html(p.paras);
    const m = /^<section class="bloc ([^"]*)">(?:<h3>[\s\S]*?<\/h3>)?([\s\S]*)<\/section>$/.exec(blocHtml.trim());
    let autres = m ? m[2] : "";
    // la même prière que celle de l'AELF (ou du commun) : une seule fois
    const tete = autres.replace(/<details[\s\S]*$/, "");
    if (memeTexte(tete, op)) autres = autres.slice(tete.length);
    const alt = p.alternatives.map((a) => `<details class="autre-oraison"><summary>Ou bien : autre prière du Missel de l’Ordre</summary>${g.PropreOP.html(a)}</details>`).join("");
    const reste = vide(autres) ? "" : `<details class="autre-oraison"><summary>Ou bien : ${/trois-heures/.test(m?.[1] || "") ? "oraisons des trois heures" : "autre oraison (AELF, commun ou Heures grégoriennes)"}</summary>${autres}</details>`;
    return provenance(bloc("Oraison", op + alt + reste, "oraison"), "Missel de l’Ordre");
  }
  const oraisonAuChoix = (j, office, liturgique, options, titre = "Oraison") => bloc(titre, oraisonContenu(j, office, liturgique, options), "oraison");
  // avec un commun : un jour de saint, l'oraison du jour (AELF, propre au saint) d'abord, celle du commun (« saint N. »)
  // repliée dessous ; un jour sans saint au calendrier, celle du commun d'abord
  function oraisonCommun(j, office, liturgique, com, options) {
    if (!com.oraison) return provenance(oraisonAuChoix(j, office, liturgique, options), duJour(j));
    const duCommun = `<p>${esc(com.oraison)}</p>`;
    if (vide(liturgique)) return provenance(bloc("Oraison", duCommun, "oraison"), "du commun");
    // fête de l'Ordre : l'AELF donne l'oraison du jour romain, pas celle du saint
    const saint = j.source !== "temporal" && j.source !== "op" && j.niveau <= 12;
    const [montree, autre, nomAutre] = saint ? [liturgique, duCommun, "oraison du commun (Heures grégoriennes)"] : [duCommun, liturgique, j.source === "op" ? "oraison du jour romain (AELF)" : "oraison du jour (AELF)"];
    return provenance(bloc("Oraison", `${montree}<details class="autre-oraison"><summary>Ou bien : ${nomAutre}</summary>${autre}</details>`, "oraison"), saint ? duJour(j) : "du commun");
  }
  // milieu du jour : l'oraison de tierce, de sexte et de none, chacune sous son titre, quand elles diffèrent
  // (féries du temps ordinaire surtout) ; sinon une seule (demande de l'utilisateur, 18/11/2026)
  async function oraisonsTroisHeures(j, d, options) {
    const H = HEURES[options.heure] ? options.heure : "sexte";
    const parts = [];
    for (const x of Object.keys(HEURES)) {
      const dx = x === H ? d : (await g.AELF.office(x, j.date, j)).donnees;
      parts.push([x, oraisonContenu(j, "milieu", propre(dx?.oraison), { ...options, heure: x })]);
    }
    const pleins = parts.filter(([, c]) => !vide(c));
    const pareil = pleins.every(([, c]) => memeTexte(c.replace(/<details[\s\S]*$/, ""), pleins[0][1].replace(/<details[\s\S]*$/, "")));
    if (pleins.length < 2 || pareil) return oraisonAuChoix(j, "milieu", propre(d.oraison), options);
    return bloc("Oraison", pleins.map(([x, c]) => `<section class="capitule-heure"><h4 class="intitule-heure">${HEURES[x]}</h4>${c}</section>`).join(""), "oraison trois-heures");
  }
  const CONCLUSION = `<p><span class="rv">V/</span> Bénissons le Seigneur.<br><span class="rv">R/</span> Nous rendons grâce à Dieu.</p>`;

  // ── Nettoyage du HTML de l'AELF : on ne garde que la mise en forme simple
  const PERMIS = new Set(["p", "br", "em", "i", "strong", "b", "u", "sup", "span"]);
  function propre(h) {
    if (h == null) return "";
    if (typeof h !== "string") h = String(h);
    h = h.replace(/<(script|style)[\s\S]*?<\/\1>/gi, "");
    h = h.replace(/<(\/?)([a-z0-9]+)([^>]*)>/gi, (m, f, t, attrs) => {
      t = t.toLowerCase();
      if (!PERMIS.has(t)) return t === "div" || t === "li" ? (f ? "" : "<br>") : "";
      if (t === "span" && !f) return /verse_number/.test(attrs) ? '<span class="v">' : "<span>";
      return `<${f}${t}>`;
    });
    // paragraphes vides et sauts de ligne superflus
    h = h.replace(/&nbsp;/g, " ").replace(/<p>(\s|<br>)*<\/p>/gi, "").replace(/(<br>\s*){2,}/gi, '<br><span class="espace"></span>')
      .replace(/<p>(\s|<br>)+/gi, "<p>").replace(/(\s|<br>)+<\/p>/gi, "</p>").replace(/^(\s|<br>)+|(\s|<br>)+$/g, "");
    // l'AELF note les répons « R/ » et « V/ »
    h = h.replace(/\b([RV])\/\s?/g, '<span class="rv">$1/</span> ');
    return h.trim();
  }
  const vide = (h) => !h || !String(h).replace(/<[^>]+>|&nbsp;|\s/g, "");
  const bloc = (titre, contenu, cl = "") => vide(contenu) ? "" : `<section class="bloc ${cl}">${titre ? `<h3>${titre}</h3>` : ""}${contenu}</section>`;
  const antienne = (a) => vide(a) ? "" : `<div class="antienne"><span class="rubrique">Ant.</span> ${propre(a).replace(/^<p>|<\/p>$/g, "")}</div>`;

  const NOTRE_PERE = `<div class="notre-pere"><p>Notre Père, qui es aux cieux,<br>que ton nom soit sanctifié,<br>que ton règne vienne,<br>que ta volonté soit faite sur la terre comme au ciel.<br>Donne-nous aujourd’hui notre pain de ce jour.<br>Pardonne-nous nos offenses,<br>comme nous pardonnons aussi à ceux qui nous ont offensés.<br>Et ne nous laisse pas entrer en tentation<br>mais délivre-nous du Mal.</p></div>`;
  const BENEDICTION = `<p><span class="rv">V/</span> Que le Seigneur nous bénisse, qu’il nous garde de tout mal, et nous conduise à la vie éternelle.<br><span class="rv">R/</span> Amen.</p>`;

  // ── Psaume : texte du psautier BJ, sinon celui de l'AELF (signalé)
  let AELF_PUR = false;
  // version latin-français, Office des lectures : répartition et textes de l'AELF, psaumes latin / français (latin.js)
  let LATIN_LECT = false;
  // Version « 100 % AELF » : texte du psautier liturgique de l'AELF mis en page avec ses inflexions en gras
  // (psautier_aelf.json, tiré du Psautier.doc de la Province), découpé selon les versets donnés par l'AELF ;
  // à défaut, texte de l'AELF, syllabes accentuées passées du souligné au gras.
  function psaumeAELF(ps, options) {
    const ref = String(ps.reference || "").trim();
    const titre = options.sansTitre ? "" : ps.titre ? `${esc(ps.titre)} <span class="ref">${esc(ref)}</span>` : /^\d/.test(ref) ? `Psaume ${esc(ref)}` : esc(ref);
    const h4 = titre ? `<h4 class="titre-psaume">${titre}</h4>` : "";
    const gloire = options.sansGloire || /Dn 3/.test(ref) ? "" : g.Textes.GLOIRE;
    const PA = g.PsautierAELF;
    if (PA && PA.charge) {
      const versets = [];
      g.PsautierAELF.versetsAELF(ps.texte).forEach((v) => versets.push(v));
      let sel = PA.trouver(ref, versets);
      if (sel && sel.cantique && versets.length) {
        // cantique : seulement les versets que donne l'AELF (clés « ch:v » et « v », selon la numérotation du psautier)
        const mc = /\(([^)]+)\)/.exec(ref);
        const r = g.Textes.analyserRef(mc ? mc[1] : ref);
        const ens = new Set();
        for (const k of PA.ensembleAelf(versets, r?.versets[0]?.[0] ?? null)) { ens.add(k); ens.add(k.replace(/^\d+:/, "")); }
        if (ens.size) sel = { ...sel, ensemble: ens };
      }
      if (sel) {
        sel = PA.ajuster(sel, ps.texte);
        const corps = PA.html(sel, { ...options, sansTitre: true, sansGloire: true, sansPriere: true });
        return corps.replace(/^<div class="psaume"/, '<div class="psaume aelf inflexions"').replace(/^(<div[^>]*>)/, `$1${h4}`).replace(/<\/div>$/, `${gloire}</div>`);
      }
    }
    return `<div class="psaume aelf">${h4}${propre(ps.texte).replace(/<(\/?)u>/g, "<$1b>")}${gloire}</div>`;
  }
  function psaume(ps, avert, options = {}) {
    if (!ps || (Array.isArray(ps) && !ps.length)) return "";
    if (LATIN_LECT) return g.Latin.psaumeLectures(ps, propre, options);
    if (AELF_PUR) return psaumeAELF(ps, options);
    const versets = [];
    String(ps.texte || "").replace(/(\[?)<span class="verse_number">([^<]+)<\/span>/g, (m, crochet, v) => { if (!crochet) versets.push(v); return m; });
    const sel = g.Psautier.trouver(ps.reference, versets);
    if (sel) return g.Psautier.html(sel, options);
    avert.push(`« ${ps.reference} » introuvable dans le psautier : texte de l'AELF.`);
    return `<div class="psaume aelf"><h4 class="titre-psaume">${esc(ps.reference)} <span class="ref">(texte AELF)</span></h4>${propre(ps.texte)}${g.Textes.GLOIRE}</div>`;
  }

  async function lecture(obj, avert, titre) {
    if (!obj || !obj.reference) return "";
    if (AELF_PUR) return `${titre ? `<h4>${esc(titre)}</h4>` : ""}<p class="ref-ligne"><span class="ref-lecture">${esc(obj.reference)}</span></p><div class="lecture">${propre(obj.texte)}</div>`;
    const b = await g.Bible.lire(obj.reference);
    const ref = `<span class="ref-lecture">${esc(obj.reference)}</span>`;
    if (b && b.html && !b.manquants.length) return `${titre ? `<h4>${esc(titre)}</h4>` : ""}<p class="ref-ligne">${ref}</p><div class="lecture">${b.html}</div>`;
    avert.push(`Lecture ${obj.reference} : ${b ? "versets " + b.manquants.join(" ; ") + " absents de la Bible" : "référence non reconnue"} — texte de l'AELF.`);
    return `${titre ? `<h4>${esc(titre)}</h4>` : ""}<p class="ref-ligne">${ref} <span class="note">(texte AELF)</span></p><div class="lecture">${propre(obj.texte)}</div>`;
  }

  function hymne(h) {
    if (!h || vide(h.texte)) return "";
    const t = propre(h.texte);
    return bloc(`Hymne${h.titre ? " : " + esc(String(h.titre).trim()) : ""}`, `<div class="hymne">${t}</div>${h.auteur ? `<p class="credit">${esc(h.auteur)}${h.editeur ? ", " + esc(h.editeur) : ""}</p>` : ""}`);
  }

  // ── Psalmodie selon la répartition choisie
  function psalmodieRomaine(src, n, avert, options) {
    let h = "";
    for (let k = 1; k <= n; k++) {
      const ps = src[`psaume_${k}`];
      if (!ps || (Array.isArray(ps) && !ps.length)) continue;
      const a = src[`antienne_${k}`];
      h += `<div class="psalmodie-element">${antienne(a)}${psaume(ps, avert, options)}${antienne(a)}</div>`;
    }
    return h;
  }

  // ── Commun des saints choisi pour ce jour (bouton « Commun » ; Heures grégoriennes, tome III : communs.js)
  // versets d'une référence de cantique (« CANTIQUE (Ap 4, 11 – 5, 9-10.12) ») pour retrouver la pièce du psautier
  function versetsDeRef(ref) {
    const m = /\(([^)]+)\)/.exec(ref);
    if (!m) return [];
    let ch = null;
    const out = [];
    for (let t of m[1].replace(/^(?:Cf\.\s*)?[1-3]?\s?[A-Za-zé]+\s+/, "").split(/[.;–]/)) {
      t = t.trim();
      const mc = /^(\d+),\s*(.+)$/.exec(t);
      if (mc) { ch = mc[1]; t = mc[2].trim(); }
      for (const x of t.split(/[\s,]+/)) if (/^\d+[ab]?(-\d+[ab]?)?$/.test(x)) out.push((ch ? ch + "," : "") + x.replace(/[ab]/g, ""));
    }
    return out;
  }
  const antienneCommun = (a) => (a?.texte ? `<div class="antienne"><span class="rubrique">Ant.</span> ${esc(a.texte)}</div>` : "");
  const gregCommun = (a, legende) => (PARTITIONS_VERSION && a?.partitions?.length && g.Partitions?.figure
    ? `<div class="alternative-gregorienne">${g.Partitions.figure(a.partitions, `${legende} — en grégorien (latin), Les Heures grégoriennes`, { ferme: true })}</div>` : "");
  function psalmodieCommun(com, avert, options) {
    const ants = com.antiennes || [];
    return (com.psaumes || []).map((ref, i) => {
      const a = ants[Math.min(i, ants.length - 1)];
      const versets = versetsDeRef(ref);
      let corps;
      if (g.Psautier.trouver(ref, versets)) corps = psaume({ reference: ref, texte: versets.map((v) => `<span class="verse_number">${v}</span>`).join(" ") }, avert, options);
      else { avert.push(`Commun : « ${ref} » introuvable dans le psautier.`); corps = ""; }
      return `<div class="psalmodie-element">${antienneCommun(a)}${gregCommun(a, `Antienne ${i + 1}`)}${corps}${antienneCommun(a)}</div>`;
    }).join("");
  }

  // ── Propre de l'Ordre selon les carnets du sanctoral de la Province (PropreOP.carnet, donnees/offices_op.json) :
  //    hymnes, psaumes et antiennes (texte transcrit + partition), répons, antienne évangélique ; demande de l'utilisateur, 20/11/2026
  const figOP = (f, legende = "", o = {}) => (PARTITIONS_VERSION && f?.length && g.Partitions?.figure ? g.Partitions.figure(f, legende, { role: "antiennes", ...o }) : "");
  const antienneOP = (a) => (a?.ant ? `<div class="antienne"><span class="rubrique">Ant.</span> ${a.latin ? `<i lang="la">${esc(a.ant)}</i>` : esc(a.ant)}</div>` : "");
  function psaumeOP(p, avert, optPs) {
    const [id, vv] = String(p).split(":");
    if (vv) {
      const [a, b] = vv.split("-").map(Number), v = [];
      for (let x = a; x <= (b || a); x++) v.push(String(x));
      const sel = g.Psautier.trouver(id, v);
      if (sel) return g.Psautier.html(sel, optPs);
    }
    if (g.Psautier.donnees?.pieces?.[id]) return g.Psautier.html({ id }, optPs);
    avert.push(`Carnet du sanctoral : « ${p} » introuvable dans le psautier.`);
    return "";
  }
  // une antienne pour un ou plusieurs psaumes (« Psaume 62 & AT 49 ») ; « ou bien » repliés ; cantique du NT : sa partition gravée
  function psalmodieOP(o, avert, optPs) {
    return (o.psalmodie || []).map((el) => {
      const a = antienneOP(el);
      let corps = (el.ps || []).map((p) => psaumeOP(p, avert, optPs)).join("");
      for (const p of el.ps || []) {
        const fc = /^NT\d+$/.test(p) && PARTITIONS_VERSION ? g.Partitions?.cantiqueGrave?.(p) : null;
        const m = `<div class="psaume" data-piece="${p}"`;
        if (fc) corps = corps.replace(m, g.Partitions.figure(fc, "", { role: "cantique" }) + m);
      }
      const myst = el.mysteres ? `<p class="rubrique-texte mysteres">${esc(el.mysteres)}</p>` : "";
      return `<div class="psalmodie-element">${myst}${a}${figOP(el.f)}${ouBienOP(el.ou)}${corps}${a}</div>`;
    }).join("");
  }
  const ouBienOP = (liste) => (liste || []).map((x) => `<details class="autre-antienne"><summary>Ou bien : ${esc(x.ant)}</summary>${antienneOP(x)}${figOP(x.f, "", { ferme: false })}</details>`).join("");
  // mémoire « psaumes de la férie » (Translation de saint Dominique) : les antiennes du carnet sur la psalmodie du jour ;
  // « Psaume & AT (de la férie) » : une antienne pour deux éléments
  function antiennesOPFerie(psalmo, o) {
    const parts = psalmo.split(/(?=<div class="psalmodie-element">)/);
    const idx = parts.map((x, i) => i).filter((i) => parts[i].startsWith('<div class="psalmodie-element">'));
    let k = 0;
    for (const el of o.psalmodie || []) {
      const n = /cantique/i.test(el.sur || "") ? 2 : 1;
      for (let t = 0; t < n && k < idx.length; t++, k++) {
        const i = idx[k];
        let premiere = t === 0;
        const sans = parts[i].replace(/<div class="antienne">[\s\S]*?<\/div>/g, "");
        parts[i] = sans.replace('<div class="psalmodie-element">', `<div class="psalmodie-element">${antienneOP(el)}${premiere ? figOP(el.f) : ""}`)
          .replace(/<\/div>\s*$/, `${antienneOP(el)}</div>`);
        premiere = false;
      }
    }
    return parts.join("");
  }
  function hymneOP(liste, autre) {
    const texte = (x) => (x.texte ? `<div class="hymne">${x.texte.map((st) => `<p>${st.map(esc).join("<br>")}</p>`).join("")}</div>` : "");
    const autreDans = autre ? autre.replace(/^<section class="bloc[^"]*">/, "<div>").replace(/<\/section>$/, "</div>").replace("<h3>Hymne</h3>", "") : "";
    const [p, ...rest] = liste;
    // sans partitions : le texte d'une hymne (celle du carnet si elle est saisie, sinon celle du commun ou de l'AELF)
    if (!PARTITIONS_VERSION) {
      const t = liste.find((x) => x.texte);
      const note = `<p class="note">Hymnes du carnet (partitions) : ${liste.map((x) => `<i>${esc(x.titre)}</i>`).join(", ")}.</p>`;
      return bloc("Hymne", note + (t ? texte(t) + (autreDans ? `<details class="hymne-aelf"><summary>Autre hymne (texte)</summary>${autreDans}</details>` : "") : autreDans), "hymne-carnet");
    }
    let c = `<p class="note">Hymne du carnet : <i>${esc(p.titre)}</i></p>${figOP(p.f, p.titre, { role: "hymne" })}${texte(p)}`;
    c += rest.map((x) => `<details class="choix-hymne"><summary>Ou bien : ${esc(x.titre)}</summary>${figOP(x.f, x.titre, { role: "hymne", ferme: false })}${texte(x)}</details>`).join("");
    if (autreDans) c += `<details class="hymne-aelf"><summary>Autre hymne (texte)</summary>${autreDans}</details>`;
    return bloc("Hymne", c, "hymne-carnet");
  }
  // répons du carnet (grand répons, en partition) ; le répons bref en texte replié (affiché seul sans partitions)
  function reponsOP(liste, texte) {
    if (!PARTITIONS_VERSION) return `${texte}<p class="note">Répons du carnet (partition) : ${liste.map((x) => `<i>${esc(x.titre)}</i>`).join(", ")}.</p>`;
    const [r, ...rest] = liste;
    return `<p class="note">Répons du carnet : <i>${esc(r.titre)}</i></p>${figOP(r.f, r.titre, { role: "repons" })}`
      + rest.map((x) => `<details class="autre-repons"><summary>Ou bien : ${esc(x.titre)}</summary>${figOP(x.f, x.titre, { role: "repons", ferme: false })}</details>`).join("")
      + (vide(texte) ? "" : `<details class="hymne-aelf"><summary>Ou bien : répons bref (texte)</summary>${texte}</details>`);
  }
  // mémoire « en fête » au carnet : sa psalmodie (psaumes de chaque étiquette, dans l'ordre ; antiennes = partitions du carnet,
  // posées ensuite par le placeur sous leur psaume)
  function psalmodieCarnet(so, avert, optPs) {
    const ants = so.pieces.filter((x) => x.role === "antiennes" && x.ids?.length && !x.alt && !x.libre);
    const ordre = (ids) => ids.filter((x) => !/^(AT|NT)/.test(x)).concat(ids.filter((x) => /^AT/.test(x)), ids.filter((x) => /^NT/.test(x)));
    const ant = `<div class="antienne"><span class="rubrique">Ant.</span> <span class="note">antienne du carnet (partition)</span></div>`;
    return ants.map((a) => `<div class="psalmodie-element">${ant}${ordre(a.ids).map((p) => psaumeOP(p, avert, optPs)).join("")}</div>`).join("");
  }
  const lignePsaumes = (iso, carnet) => `<p class="choix-office choix-psaumes no-print"><label>Psaumes : <select data-psaumes-date="${esc(iso)}">`
    + `<option value=""${carnet ? "" : " selected"}>de la férie (AELF)</option><option value="carnet"${carnet ? " selected" : ""}>du carnet de la Province</option></select></label></p>`;
  const avecLigne = (h, ligne) => (/<p class="psautier-semaine">/.test(h) ? h.replace(/\s*<p class="psautier-semaine">/, (m) => ligne + m) : h.replace(/(<\/header>)/, `$1${ligne}`));
  const noteOP = (c) => `<p class="note propre-op">Propre de l’Ordre des Prêcheurs${c.premieres ? ` — premières vêpres : ${esc(c.fete.nom)}` : ""}. `
    + `Carnet de la Province « ${esc(c.fete.carnet)} »${c.o.renvoi ? ` : ${esc(c.o.renvoi)}` : ""}${c.o.ferie ? ` ; antiennes propres sur les psaumes de la férie` : ""} ; prière du Missel de l’Ordre.</p>`;
  // hymne du livre : strophes numérotées (« 2. … ») ; vers (une majuscule à chaque ligne) ou prose traduite
  function hymneCommun(lignes) {
    const st = [];
    for (const l of lignes || []) { if (!st.length || /^\d+\.\s/.test(l)) st.push([]); st[st.length - 1].push(l.replace(/^\d+\.\s*/, "")); }
    const vers = (lignes || []).filter((l) => /^[«–\s]*[A-ZÀ-ÝŒ]/.test(l)).length > (lignes || []).length * 0.6;
    const joindre = (ls) => ls.reduce((acc, t) => (/[a-zà-ÿœæ]-$/.test(acc) && /^[a-zà-ÿœæ]/.test(t) ? acc.slice(0, -1) + t : acc ? acc + " " + t : t), "");
    return `<div class="hymne">${st.map((s) => `<p>${vers ? s.map(esc).join("<br>") : esc(joindre(s))}</p>`).join("")}</div>`;
  }
  const joindreCommun = (ls) => (ls || []).reduce((acc, t) => (/[a-zà-ÿœæ]-$/.test(acc) && /^[a-zà-ÿœæ]/.test(t) ? acc.slice(0, -1) + t : acc ? acc + " " + t : t), "");
  // répons : une ligne par R/ ou V/
  function reponsCommun(lignes) {
    const out = [];
    for (const l of lignes || []) { if (!out.length || /^[RV]\//.test(l)) out.push(l); else out[out.length - 1] += " " + l; }
    return `<p>${out.map((l) => esc(l.replace(/\s{2,}/g, " ").replace(/R\/\s*$/, "R/").trim()).replace(/\b([RV])\/\s?/g, '<span class="rv">$1/</span> ')).join("<br>")}</p>`;
  }
  // intercessions : un paragraphe par invocation ; le refrain (après l'introduction) en italique
  function precesCommun(lignes) {
    const paras = [];
    let cur = [];
    for (const l of lignes || []) {
      const prec = cur.length ? cur[cur.length - 1] : "";
      if (cur.length && (/^—/.test(l) || (/[.:!?]$/.test(prec) && /^[A-ZÀ-ÝŒ«]/.test(l)))) { paras.push(cur); cur = []; }
      cur.push(l);
    }
    if (cur.length) paras.push(cur);
    // introduction jusqu'à la phrase qui finit par « : », puis le refrain
    const k = paras.findIndex((p) => /:$/.test(p[p.length - 1]));
    if (k > 0) paras.splice(0, k + 1, paras.slice(0, k + 1).flat());
    const r = k >= 0 ? 1 : -1;
    return `<div class="intercession">${paras.map((p, i) => `<p${i === r ? ' class="refrain"' : ""}>${i === r ? "<em>" : ""}${esc(joindreCommun(p))}${i === r ? "</em>" : ""}</p>`).join("")}</div>`;
  }
  // Commun en vigueur pour un jour : celui choisi dans l'en-tête (pref.communs[date] ; "aucun" = textes du jour),
  // sinon, d'office, le commun suggéré pour une célébration de l'Ordre (l'AELF n'en donne pas les textes propres)
  const estSaint = (j) => j.source !== "temporal" && j.niveau <= 12;
  function communDuJour(j, options) {
    if (!g.Communs?.charge) return null;
    const c = options.communs?.[j.date];
    if (c === "aucun") return null;
    if (c?.id) return c;
    if (options.propreOP && j.source === "op" && j.niveau <= 11) return { ...g.Communs.suggerer(j), psaumes: j.niveau <= 8 ? "commun" : "ferie", auto: true };
    return null;
  }
  // « saint N. » des textes du commun → le nom du saint du jour (un seul saint)
  function nommer(com, j) {
    const m = /^(S\.|Ste|Saint|Sainte|Bx|Bse|Bienheureux|Bienheureuse)\s+([^,(]+)/.exec(String(j.nom || ""));
    if (!m || / et /.test(m[2])) return;
    const fem = /^(Ste|Sainte|Bse|Bienheureuse)$/.test(m[1]);
    const nom = `${fem ? "sainte" : "saint"} ${m[2].trim()}`;
    const r = (t) => typeof t === "string" ? t.replace(/\b(saint|sainte|bienheureux|bienheureuse) N\.(?! et N\.)/g, nom) : t;
    com.oraison = r(com.oraison); com.evangelique = r(com.evangelique);
    if (com.preces) com.preces = com.preces.map(r);
    if (com.antiennes) com.antiennes = com.antiennes.map((a) => ({ ...a, texte: r(a.texte) }));
  }
  // ligne « Commun : » de l'en-tête (écran seulement) : jours de saint (ou de mémoire facultative), laudes, milieu, vêpres
  function ligneCommun(j, office, options, CM) {
    if (!g.Communs?.charge || AELF_PUR || !["laudes", "milieu", "vepres"].includes(office)) return "";
    const choisi = options.communs?.[j.date];
    if (!estSaint(j) && !j.facultatives?.length && !choisi?.id) return "";
    const sug = g.Communs.suggerer(j.source === "temporal" && j.facultatives?.length ? { ...j, nom: j.facultatives[0].nom } : j);
    const id = CM?.id || "";
    const D = `data-commun-date="${esc(j.date)}"`;
    let h = `<label>Commun : <select ${D} data-champ="id"><option value="">aucun (textes du jour)</option>${g.Communs.liste.map((c) => `<option value="${c.id}"${c.id === id ? " selected" : ""}>${esc(c.nom)}${c.id === sug.id ? " — suggéré" : ""}</option>`).join("")}</select></label>`;
    if (id) {
      const ps = g.Communs.commun(id)?.precisions || [];
      if (ps.length) h += ` <label><select ${D} data-champ="pour" aria-label="Précision"><option value="">—</option>${ps.map((p) => `<option value="${esc(p)}"${p === CM.pour ? " selected" : ""}>pour ${esc(p)}</option>`).join("")}</select></label>`;
      h += ` <label><select ${D} data-champ="psaumes" aria-label="Psaumes"><option value="commun"${CM.psaumes !== "ferie" ? " selected" : ""}>psaumes du commun</option><option value="ferie"${CM.psaumes === "ferie" ? " selected" : ""}>psaumes de la férie</option></select></label>`;
      if (id === "dedicace") h += ` <label><select ${D} data-champ="lieu" aria-label="Oraison"><option value="dans">dans l'église consacrée</option><option value="hors"${CM.lieu === "hors" ? " selected" : ""}>hors de l'église consacrée</option></select></label>`;
      if (CM.auto) h += `<span class="commun-note">appliqué d'office : l'AELF ne donne pas les textes propres de cette célébration de l'Ordre</span>`;
    }
    return `<p class="choix-office choix-commun no-print" data-suggere="${esc(sug.id)}" data-suggere-pour="${esc(sug.pour || "")}">${h}</p>`;
  }
  // provenance d'une partie, à droite de son titre (comme à la Messe) : « du commun », « du jour »…
  const provenance = (blocHtml, texte) => (!blocHtml || !texte ? blocHtml : blocHtml.replace(/<\/h3>/, `<span class="ref provenance"> · ${esc(texte)}</span></h3>`));
  const duJour = (j) => (j.source === "op" ? "du jour romain (AELF)" : j.source !== "temporal" ? "du propre (AELF)" : "du jour (AELF)");
  const avecCommun = (entete, j, office, options, CM) => entete.replace(/\s*<p class="psautier-semaine">/, (m) => ligneCommun(j, office, options, CM) + m);
  const noteCommun = (com, choix) => `<p class="note commun-choisi">Commun : ${esc(com.nom)}${com.pour ? ` (pour ${esc(com.pour)})` : ""} — Les Heures grégoriennes${choix.psaumes === "ferie" ? " ; psaumes de la férie" : ""}.</p>`;

  // ── Éléments de la Liturgie chorale du peuple de Dieu (A. Gouzes)
  const NOCTURNES = { premier: "Premier nocturne", deuxieme: "Deuxième nocturne", troisieme: "Troisième nocturne" };
  const multi = (t) => esc(t).replace(/\s*\/\s*/g, "<br>").replace(/\n/g, "<br>");
  function marque(e) {
    const x = [e.cote, e.ton ? `ton ${e.ton}` : ""].filter(Boolean).join(" · ");
    return x ? ` <span class="ton">${esc(x)}</span>` : "";
  }
  let PARTITIONS_ACTIVES = false, PARTITIONS_VERSION = false;
  const antienneG = (e) => !e || !e.ant ? "" : `<div class="antienne"><span class="rubrique">Ant.</span> ${esc(e.ant)}${marque(e)}</div>`;
  const partitionTexte = (t, legende = "Antienne") => { const f = PARTITIONS_ACTIVES && g.Partitions?.parTexte ? g.Partitions.parTexte(t) : null; return f ? g.Partitions.figure(f, legende) : ""; };
  // hymnes et répons du tableau Gouzes : seulement une partition gravée depuis la source (pas de découpe de carnet)
  const partitionGravee = (t, legende) => { const f = PARTITIONS_ACTIVES && g.Partitions?.grave ? g.Partitions.grave(t) : null; return f ? g.Partitions.figure(f, legende) : ""; };

  function psalmodieGouzes(liste, avert, options) {
    let h = "", noct = null;
    for (const e of liste || []) {
      if (!e) continue;
      if (e.nocturne && e.nocturne !== noct) { noct = e.nocturne; h += `<h4 class="nocturne">${NOCTURNES[noct] || ""}</h4>`; }
      let corps = "";
      for (const p of e.pieces || []) {
        if (!g.Psautier.donnees.pieces[p.id]) { avert.push(`Liturgie chorale : « ${p.id} » introuvable dans le psautier.`); continue; }
        corps += g.Psautier.html({ id: p.id, partie: p.partie, versets: p.versets }, options);
      }
      // cantique du NT sans antienne gravée (dimanche : « Alléluia » d'Ap 19) : le cantique gravé, refrain compris
      let part = partitionTexte(e.ant);
      const nt = (e.pieces || []).map((p) => p.id).find((id) => /^NT\d+$/.test(id));
      if (!part && nt && PARTITIONS_ACTIVES && g.Partitions?.cantiqueGrave?.(nt)) part = g.Partitions.figure(g.Partitions.cantiqueGrave(nt), "", { role: "cantique" });
      h += `<div class="psalmodie-element">${antienneG(e)}${part}${corps}${antienneG(e)}</div>`;
    }
    return h;
  }

  // Psalmodie romaine (AELF) avec les antiennes de Gouzes du carnet de la Province :
  // une antienne encadre toute la psalmodie ; deux antiennes : la 1re le 1er psaume, la 2e le reste.
  // Laudes : 1re antienne sur le psaume et le cantique, 2e sur le dernier psaume ;
  // vêpres : 1re sur le 1er psaume, 2e sur le reste ; vigiles : une antienne par psaume.
  function psalmodieProvince(src, ants, avert, options, office, extra) {
    const ps = [1, 2, 3].map((k) => src[`psaume_${k}`]).filter((x) => x && !(Array.isArray(x) && !x.length));
    // cantique du NT propre au carnet (« & NT IV ») à la place de celui de l'AELF
    let nt = null;
    const rom = { I: 1, II: 2, III: 3, IV: 4, V: 5, VI: 6, VII: 7, VIII: 8, IX: 9, X: 10, XI: 11, XII: 12, XIII: 13, XIV: 14 };
    if (office === "vepres" && extra?.nt && g.Psautier.donnees.pieces[`NT${rom[extra.nt]}`]) nt = `NT${rom[extra.nt]}`;
    let groupes = [ps];
    if (ants.length >= 3) groupes = ps.map((x) => [x]);
    else if (ants.length === 2) groupes = office === "laudes" ? [ps.slice(0, 2), ps.slice(2)] : [[ps[0]], ps.slice(1)];
    return groupes.map((gr, i) => {
      const a = ants[Math.min(i, ants.length - 1)];
      const ant = a?.ant ? antienneG(a) : "";
      const corps = gr.map((x) => nt && x === ps[ps.length - 1] && /^CANTIQUE|\(/i.test(String(x.reference)) ? g.Psautier.html({ id: nt }, options) : psaume(x, avert, options)).join("");
      return `<div class="psalmodie-element">${ant}${corps}${ant}</div>`;
    }).join("");
  }

  // ── Version « Sainte-Baume » (livrets de fr. Max) : antienne (texte, sinon incipit) puis sa partition gravée
  const figSB = (f, legende = "", opt = {}) => (f && g.Partitions?.figure ? g.Partitions.figure([].concat(f).filter(Boolean), legende, opt) : "");
  const antienneSB = (a) => !a ? "" : `<div class="antienne"><span class="rubrique">Ant.</span> ${a.texte ? esc(a.texte) : `${esc(a.inc || "")}…`}${a.cote ? ` <span class="ton">${esc(a.cote)}</span>` : ""}</div>`;
  // psalmodie de l'AELF (psaumes du jour) avec les antiennes du livret, rattachées par le numéro du psaume, sinon dans l'ordre ;
  // vêpres : le cantique du NT indiqué par le livret, avec sa partition gravée (refrain compris)
  function psalmodieSB(src, sbc, avert, options, office) {
    const ps = [1, 2, 3].map((k) => src[`psaume_${k}`]).filter((x) => x && !(Array.isArray(x) && !x.length));
    const els = sbc.elements, pris = new Set();
    const idDe = (x) => {
      const v = [];
      String(x.texte || "").replace(/(\[?)<span class="verse_number">([^<]+)<\/span>/g, (m, c, n) => { if (!c) v.push(n); return m; });
      return g.Psautier.trouver(x.reference, v)?.id || null;
    };
    return ps.map((x, i) => {
      const id = idDe(x);
      const libre = (n) => !pris.has(n);
      let k = els.findIndex((e, n) => libre(n) && id && e.id === id);
      if (k < 0) k = els.findIndex((e, n) => libre(n) && id && base(e.id) === base(id));
      if (k < 0 && /^NT/.test(id || "")) k = els.findIndex((e, n) => libre(n) && /^NT/.test(e.id));
      if (k < 0 && /^AT/.test(id || "")) k = els.findIndex((e, n) => libre(n) && e.id === "AT");
      if (k < 0 && !sbc.strict && libre(i) && els[i]) k = i;
      const e = k >= 0 ? els[k] : null;
      if (k >= 0) pris.add(k);
      const nt = e && /^NT\d+$/.test(e.id) ? e.id : null;
      const corps = nt && nt !== id && g.Psautier.donnees.pieces[nt] ? g.Psautier.html({ id: nt }, options) : psaume(x, avert, options);
      const ant = antienneSB(e?.ant);
      const part = e?.ant?.f ? figSB(e.ant.f, "", { role: "antiennes" }) : e?.ant?.sb ? figSB(e.ant.sb, "", { role: "antiennes" }) : "";
      const ntj = nt || (/^NT\d+$/.test(id || "") && !["NT1", "NT2", "NT3"].includes(id) ? id : null);
      const cant = ntj && !e?.ant && g.Partitions?.cantiqueGrave?.(ntj) ? figSB(g.Partitions.cantiqueGrave(ntj), "", { role: "cantique" }) : "";
      return `<div class="psalmodie-element">${ant}${part}${cant}${corps}${ant}</div>`;
    }).join("");
  }
  const lignesSB = (l) => esc(l).replace(/&lt;(\/?)(b|u)&gt;/g, "<$1$2>");
  function reponsSB(r) {
    if (!r) return "";
    let h = figSB(r.f, "Répons");
    if (r.refrain) h += `<p><span class="rv">R/</span> ${esc(r.refrain)} <span class="ton">${esc(r.cote || "")}</span></p>`;
    for (const c of r.couplets || []) h += `<p>${/^\d+$/.test(c.titre) ? `<span class="rv">${esc(c.titre)}.</span> ` : `<span class="rubrique">${esc(c.titre)} :</span> `}${c.lignes.map(lignesSB).join("<br>")}</p>`;
    if (!r.refrain && !(r.couplets || []).length) h += `<p class="note">Texte du répons : voir la partition (${esc(r.titre || "")}).</p>`;
    return h;
  }
  function lucernaireSB(L) {
    if (!L) return "";
    const corps = L.couplets.map((c) => `<p><span class="rubrique">${esc(c.titre)}</span> ${c.lignes.map(lignesSB).join("<br>")}</p>`).join("");
    return bloc("Lucernaire", `${figSB(L.f, "Lucernaire")}<div class="hymne">${corps}</div>`, "lucernaire");
  }

  function reponsG(r) {
    if (!r || !r.refrain) return "";
    let h = `<p><span class="rv">R/</span> ${multi(r.refrain)}${marque(r)}</p>`;
    for (const v of r.versets || []) h += `<p><span class="rv">V/</span> ${multi(v)}</p><p><span class="rv">R/</span></p>`;
    if (r.dox) h += `<p><span class="rv">V/</span> ${multi(r.dox)}</p><p><span class="rv">R/</span></p>`;
    if (r.marial) h += `<p class="verset-marial"><span class="rv">V/</span> ${multi(r.marial)}</p><p><span class="rv">R/</span></p>`;
    return h;
  }

  function precesG(p) {
    if (!p || !p.lignes?.length) return "";
    let h = "", attente = false;
    for (const l of p.lignes) {
      if (/^Faisant mémoire/.test(l)) { h += `<p class="faisant-memoire">${esc(l)}</p>`; attente = false; continue; }
      if (attente) h += `<p class="preces-reponse">— ${esc(l)}</p>`;
      else h += `<p class="preces-invocation">${esc(l)}</p>`;
      attente = !attente && /[,:;]$/.test(l.trim());
      if (!/[,:;]$/.test(l.trim())) attente = false;
    }
    return `<div class="preces">${h}</div>`;
  }

  function hymneG(hy, titreDefaut = "Hymne") {
    if (!hy || !hy.strophes?.length) return "";
    const corps = hy.strophes.map((s) => `<p>${s.map(esc).join("<br>")}</p>`).join("");
    const part = partitionGravee(hy.strophes[0].join(" ").replace(/^\s*\d+\.\s*/, ""), titreDefaut);
    return bloc(`${titreDefaut}${hy.titre && hy.titre !== titreDefaut ? " : " + esc(hy.titre) : ""}`, `<div class="hymne gouzes">${corps}</div>${part}${hy.cote ? `<p class="credit">${esc(hy.cote)} — Liturgie chorale du peuple de Dieu</p>` : ""}`);
  }

  function canonG(k) {
    if (!k) return "";
    // un tropaire commence par son numéro (« 3. ») ; les paragraphes suivants le continuent
    const groupes = [];
    for (const l of k.lignes) {
      if (/^\s*\d+[.,]/.test(l) || !groupes.length) groupes.push([l]);
      else groupes[groupes.length - 1].push(l);
    }
    const corps = groupes.map((gr) => `<p>${gr.map((l) => multi(l.replace(/<b>/g, "\u0001").replace(/<\/b>/g, "\u0002").replace(/<u>/g, "\u0003").replace(/<\/u>/g, "\u0004"))
      .replace(/\u0001/g, "<b>").replace(/\u0002/g, "</b>").replace(/\u0003/g, "<u>").replace(/\u0004/g, "</u>")).join("<br>")}</p>`).join("");
    return bloc("Grand Canon de saint André de Crète", `<p class="ref-ligne">${esc(k.titre)}</p><div class="canon">${corps}</div>`, "canon");
  }

  function tenebresG(t, preces) {
    if (!t && !preces) return "";
    let h = "";
    if (t?.lamentation) h += bloc("Lamentation", `<p>${esc(t.lamentation.titre)} <span class="ton">${esc(t.lamentation.cote)}</span></p><p class="note">Le texte de la Lamentation n'est pas fourni par le recueil.</p>`);
    if (t?.repons?.length) {
      let noct = null, l = "";
      for (const r of t.repons) {
        if (r.nocturne !== noct) { noct = r.nocturne; l += `<h4 class="nocturne">${NOCTURNES[noct] || ""}</h4>`; }
        l += `<p><span class="rv">R/</span> ${esc(r.refrain)} <span class="ton">${esc(r.cote)}</span></p>`;
      }
      h += bloc("Répons des nocturnes (incipit)", l);
    }
    if (preces?.length) h += bloc("Preces conclusives", `<div class="preces tenebres">${preces.map((x) => /^(Chantre|Chœur)/.test(x) ? `<p><span class="rubrique">${esc(x.split(":")[0])} :</span> ${esc(x.split(":").slice(1).join(":").trim())}</p>` : /^\(/.test(x) ? `<p class="traduction">${esc(x)}</p>` : `<p>${esc(x)}</p>`).join("")}</div>`);
    return h;
  }

  // ── En-tête du jour
  function entete(j, office, src) {
    const choix = j.choixPossibles?.length > 1 ? `<p class="choix-office no-print"><label>Office : <select data-choix-date="${esc(j.date)}">${j.choixPossibles.map((c) => `<option value="${esc(c.cle)}"${c.cle === j.choix ? " selected" : ""}>${c.cle === "temporal" ? "de la férie — " + esc(c.nom) : esc(c.nom) + (c.rang ? " (" + esc(c.rang) + ")" : "")}</option>`).join("")}</select></label></p>` : "";
    const fac = j.facultatives?.length ? `<p class="facultatives">${j.facultatives.map((f) => `${esc(f.nom)} <span class="rang">(${esc(f.rang)}${f.source === "op" ? ", O.P." : ""})</span>`).join(" · ")}</p>` : "";
    const rang = j.rang && !["férie", "dimanche"].includes(j.rang) ? `<span class="rang">${esc(j.rang)}${j.source === "op" ? " de l'Ordre" : ""}</span>` : "";
    return `<header class="entete-office couleur-${esc(j.couleur || "vert")}">
      <p class="date-longue">${esc(j.dateLongue)}</p>
    <h2>${esc(j.premieres ? "Premières vêpres" : OFFICES[office])}</h2>
      <p class="celebration">${esc(j.nom)} ${rang}</p>
      ${j.nom !== j.ferie ? `<p class="ferie">${esc(j.ferie)}</p>` : ""}
      ${fac}
      ${choix}
      <p class="psautier-semaine">${j.psautier ? `Semaine ${esc(j.psautierRomain)} du psautier` : ""}${j.jourSemaine === 0 ? ` · année ${esc(j.cycle)}` : ""}</p>
    </header>`;
  }

  // ── Partitions des carnets placées sous leur texte
  const base = (id) => String(id).split("-")[0].replace(/[AB]$/i, "").toUpperCase();
  function placeur(liste, office = "", impression = false) {
    const pris = new Set();
    // légende seulement quand elle aide à choisir (hymnes, pièces au choix, premières vêpres) ; les pièces « ou bien » et les
  // intercessions (louanges, preces, prière litanique) restent repliées à l'écran, dépliées dans le PDF et le Word
    const utile = (x) => ["hymne", "lucernaire", "choral", "veille", "invitatoire", "priere"].includes(x.role) || x.alt || x.libre;
    // louanges / intercessions : les pages d'une même pièce dans une seule section repliable
    const grouper = (xs) => xs.reduce((acc, x) => {
      const prec = acc[acc.length - 1];
      // pages successives d'une même pièce (hymne, répons, cantique, intercessions…) : une seule section ;
      // les antiennes, elles, sont posées une à une sous leur psaume
      if (prec && x.role !== "antiennes" && x.role === prec.role && prec.titre === x.titre && !!x.alt === !!prec.alt && !!x.libre === !!prec.libre) { pris.add(x.fichier); acc[acc.length - 1] = { ...prec, fichiers: [...(prec.fichiers || [prec.fichier]), ...(x.fichiers || [x.fichier])] }; }
      else acc.push(x);
      return acc;
    }, []);
    // Partitions gravées (sources LilyPond de Gouzes) : sous l'antienne dont le texte a une gravure, à la place de la
    // découpe du carnet ; cantique (NT…) : la partition au début du cantique (gravée, sinon les pages du carnet)
    const texteAnt = (el) => { const m = /<div class="antienne">([\s\S]*?)<\/div>/.exec(el); return m ? m[1].replace(/<span class="(ton|rubrique)">[\s\S]*?<\/span>/g, "").replace(/<[^>]+>/g, "").replace(/&(amp|lt|gt|quot|nbsp);|&#\d+;/g, " ") : ""; };
    function gravees(elts, idx, sous, idsDe) {
      for (const k of idx) {
        const ids = idsDe(elts[k]), nt = ids.find((x) => /^NT\d+$/.test(x) && !["NT1", "NT2", "NT3"].includes(x));
        const t = texteAnt(elts[k]);
        // antienne gravée : par son texte, sinon par sa cote (« K 731 » affichée avec l'antienne)
        const mc = /<div class="antienne">[\s\S]*?<span class="ton">([A-Z]{1,2}) ?(\d{3}[a-z]?)/.exec(elts[k]);
        const fa = (t ? g.Partitions.grave?.(t) : null) || (mc ? g.Partitions.parCote?.(mc[1] + mc[2])?.slice(0, 1) : null);
        const antCantique = fa && /\/cantiques-nt-/.test(fa[0]);             // la gravure de l'antienne est le cantique entier
        const fc = antCantique ? null : nt ? g.Partitions.cantiqueGrave?.(nt) : null;   // cantique gravé (Carême : antienne propre + 1 P 2)
        // partition du cantique au début du cantique : sous l'antienne s'il ouvre l'élément, sinon juste avant son titre
        // (Carême, dimanche : une antienne pour le Ps 113B et 1 P 2)
        let cant = "";
        if (fa && !antCantique) sous[k] = g.Partitions.figure(fa, "", { role: "antiennes" });
        if (fa && antCantique) cant += g.Partitions.figure(fa, "", { role: "cantique" });
        if (nt && (antCantique || fc)) for (const x of liste) if (x.role === "cantique") pris.add(x.fichier);   // pages du carnet remplacées
        if (fc) cant += g.Partitions.figure(fc, fa ? "Cantique" : "", { role: "cantique" });
        else if (nt && !antCantique) {
          const pages = liste.filter((x) => x.role === "cantique" && !pris.has(x.fichier));
          if (pages.length) cant += fig(pages);
        }
        if (!cant) continue;
        const marque = `<div class="psaume" data-piece="${nt}"`;
        if (nt && ids[0] !== nt && elts[k].includes(marque)) elts[k] = elts[k].replace(marque, cant + marque);
        else sous[k] += cant;
      }
    }
    const fig = (xs) => grouper(xs).map((x) => { pris.add(x.fichier); return g.Partitions.figure(x.fichiers || [x.fichier], utile(x) ? `${x.alt ? "ou bien : " : ""}${x.libre ? "au choix : " : ""}${x.titre}` : "", { ferme: !!x.alt || !!x.libre || (x.role === "priere" && !impression), role: x.role }); }).join("");
    return {
      prendre(pred) { return fig(liste.filter((x) => !pris.has(x.fichier) && pred(x))); },
      // antiennes de la psalmodie : par cote, puis par psaume (étiquette « Psaume 41 & AT 15 »)
      psalmodie(html) {
        const ants = liste.filter((x) => x.role === "antiennes");
        const elts = html.split(/(?=<div class="psalmodie-element">)/);
        const estEl = (el) => el.startsWith('<div class="psalmodie-element">');
        const idsDe = (el) => [...el.matchAll(/data-piece="([^"]+)"/g)].map((m) => m[1]);
        const idx = elts.map((el, i) => i).filter((i) => estEl(elts[i]));       // éléments de la psalmodie
        const sous = elts.map(() => "");
        const place = new Map();                                                // antienne → élément
        const libres = () => idx.filter((i) => !sous[i]);
        const poserSous = (a, k) => { sous[k] += fig([a]); place.set(a, k); };
        // 1. par cote (Carême), puis par psaume de l'étiquette (« Psaume 41 & AT 15 ») : le psaume d'abord, sans le cantique
        let dernier = -1;
        for (const a of ants.filter((x) => !x.libre)) {
          if (a.alt && dernier >= 0) { poserSous(a, dernier); continue; }
          const ids = a.ids || [];
          const ps = ids.filter((x) => !/^(AT|NT)/.test(x)), ordre = ps.concat(ids.filter((x) => /^(AT|NT)/.test(x)));
          let k = libres().find((i) => a.cotes?.some((c) => elts[i].includes(c)));
          for (const id of ordre) { if (k != null) break; k = libres().find((i) => idsDe(elts[i]).includes(id)); }
          for (const id of ordre) { if (k != null) break; k = libres().find((i) => idsDe(elts[i]).map(base).includes(base(id))); }
          if (k != null) { poserSous(a, k); dernier = k; }
        }
        // 2. antiennes du carnet restées sans psaume reconnu : à leur place habituelle dans l'office
        //    (laudes : 1re sous le premier psaume, 2e sous le dernier ; vêpres : 1re et 2e sous les deux psaumes)
        const carnet = ants.filter((x) => !x.libre && !x.alt && !(x.nomCarnet || "").includes("Sainte-Baume"));
        if (idx.length === 3 && carnet.length === 1 && !place.has(carnet[0]) && !(carnet[0].ids || []).length) poserSous(carnet[0], idx[0]);   // une seule image pour les deux antiennes
        if (idx.length === 3 && carnet.length >= 2 && carnet.length <= 3) {
          const attendu = carnet.length === 3 ? [0, 1, 2] : office === "laudes" ? [0, 2] : [0, 1];
          carnet.forEach((a, n) => { const k = idx[attendu[n]]; if (!place.has(a) && !sous[k]) poserSous(a, k); });
          // « ou bien » : sous la même antienne que la précédente
          let prec = null;
          for (const a of ants) { if (a.alt && !place.has(a) && prec != null && place.has(prec)) poserSous(a, place.get(prec)); if (!a.alt) prec = a; }
        }
        gravees(elts, idx, sous, idsDe);
        const poser = (el, f) => (/<div class="antienne">[\s\S]*?<\/div>/.test(el) ? el.replace(/(<div class="antienne">[\s\S]*?<\/div>)/, `$1${f}`) : el.replace('<div class="psalmodie-element">', `<div class="psalmodie-element">${f}`));
        return elts.map((el, i) => (sous[i] ? poser(el, sous[i]) : el)).join("");   // non rattachées : fin de l'office
      },
      reste() { return fig(liste.filter((x) => !pris.has(x.fichier))); },
    };
  }
  // pièces du carnet qui conviennent au jour : aux fêtes, le sanctoral seul ; hymnes « (laudes II) » de la semaine
  const ROMS = { I: 1, II: 2, III: 3, IV: 4, V: 5, VI: 6, VII: 7, VIII: 8 };
  function piecesDuJour(j, office, optsJour, idsAELF = []) {
    let l = g.Partitions.piecesPour(j, office);
    // fête ou mémoire du sanctoral : ce que le carnet indique (hymne, antiennes, répons…) ; aux mémoires à
    // « psaumes de la férie », les antiennes du temps restent celles du carnet du temps
    const so = g.Partitions.ordoPour ? g.Partitions.ordoPour(j, office, optsJour) : null;
    // veille d'une solennité en semaine : si l'AELF donne bien les psaumes de ces premières vêpres (Toussaint 2027, un dimanche
    // soir), ce sont les premières vêpres qu'on chante : les pièces du carnet à leur place, pas en fin d'office
    const antsVeille = so?.veille ? so.pieces.filter((x) => x.role === "antiennes" && x.ids?.length) : [];
    if (so && so.veille && antsVeille.length && antsVeille.every((x) => x.ids.some((id) => idsAELF.includes(id)))) so.veille = false;
    if (so && so.veille) {
      // veille d'une solennité en semaine : l'office affiché reste celui du jour ; les pièces des premières
      // vêpres du carnet sont données à part, en fin d'office
      return graverCarnet(g.Partitions.corriger(j, office, l.concat(so.pieces.map((x) => ({ ...x, role: "veille", titre: `Ires vêpres — ${so.nom} : ${x.titre}` })))));
    }
    if (so) {
      const roles = new Set(so.pieces.map((x) => x.role));
      const duTemps = l.filter((x) => (so.feriale && (x.role === "antiennes" || x.role === "cantique") || x.role === "priere") && !roles.has(x.role));   // intercessions du temps si la fête n'en a pas
      return graverCarnet(g.Partitions.corriger(j, office, so.pieces.concat(duTemps)));
    }
    if (j.niveau <= 8 && j.source !== "temporal") l = [];
    const sem = j.temps === "ordinaire" ? j.psautier : j.semaine;
    const avecSem = l.filter((x) => x.role === "hymne" && /\((?:laudes|vêpres|vepres)[^)]*?\b([IVX]+)\)/i.test(x.titre));
    if (avecSem.length) {
      const bonne = avecSem.filter((x) => ROMS[/\b([IVX]+)\)/.exec(x.titre)[1]] === sem);
      if (bonne.length) l = l.filter((x) => !avecSem.includes(x) || bonne.includes(x));
    }
    // répons « (semaines II & V) » : ceux de la semaine
    const semRep = (x) => { const m = /semaines?\s+([IVX]+)(?:\s*(?:&|et)\s*([IVX]+))?/i.exec(x.titre || ""); return m ? [m[1], m[2]].filter(Boolean).map((r) => ROMS[r.toUpperCase()]) : null; };
    const reps = l.filter((x) => x.role === "repons" && semRep(x));
    if (reps.some((x) => semRep(x).includes(sem))) l = l.filter((x) => !reps.includes(x) || semRep(x).includes(sem));
    return graverCarnet(g.Partitions.corriger ? g.Partitions.corriger(j, office, l) : l);
  }
  // Province : une pièce du carnet qui porte une seule cote (invitatoire, hymne, lucernaire, répons, antienne évangélique…)
  // est remplacée par la même pièce gravée depuis les sources de Gouzes (image nette) ; les antiennes de la psalmodie
  // sont remplacées plus loin, sous leur psaume (placeur → gravees)
  const ROLES_GRAVES = new Set(["invitatoire", "hymne", "lucernaire", "repons", "benedictus", "magnificat", "acclamation", "choral"]);
  function graverCarnet(l) {
    if (!g.Partitions?.parCote) return l;
    const page = (f) => (/^([a-z0-9]+)\/[a-z]-(\d{3})/.exec(f || "") || []).slice(1).join("/");
    const remplacees = new Set();   // « rôle|carnet/page » : la gravure tient lieu de toute la pièce de cette page
    const out = l.map((x) => {
      if (!ROLES_GRAVES.has(x.role) || (x.cotes || []).length !== 1) return x;
      const f = g.Partitions.parCote(x.cotes[0]);
      if (!f) return x;
      remplacees.add(`${x.role}|${page(x.fichier)}`);
      return { ...x, fichier: f[0], fichiers: f, grave: true };
    });
    // la suite de la même pièce découpée sur la même page (sans cote) disparaît avec elle
    return out.filter((x) => x.grave || (x.cotes || []).length > 0 || !remplacees.has(`${x.role}|${page(x.fichier)}`));
  }
  // pièce grégorienne latine (Les Heures grégoriennes) pour compléter ce qui n'a pas de partition
  // proposée au choix, avec SON texte (traduction imprimée en regard dans le livre), puis la partition
  const GREG = (j, office, role, rang, legende) => {
    const x = g.Partitions?.gregorien ? g.Partitions.gregorien(j, office, role, rang) : null;
    if (!x) return "";
    const t = x.texte || "";
    const texte = !t ? "" : role === "repons" ? `<p>${esc(t).replace(/\s*([RV])\/\s*/g, (m, l, i) => `${i ? "<br>" : ""}<span class="rv">${l}/</span> `)}</p>`
      : role === "hymne" ? `<p class="hymne">${esc(t)}</p>` : `<div class="antienne"><span class="rubrique">Ant.</span> ${esc(t)}</div>`;
    return `<div class="alternative-gregorienne"><p class="note">Ou bien, en grégorien (latin) :</p>${texte}${g.Partitions.figure(x.fichiers, `${legende} — Les Heures grégoriennes`)}</div>`;
  };
  const aPartition = (h) => /partition-pliee/.test(h || "");
  const dans = (blocHtml, f) => (!f ? blocHtml : blocHtml ? blocHtml.replace(/<\/section>$/, `${f}</section>`) : f);
  // partition au début de la section, juste sous son titre (intercessions : demande de l'utilisateur, 20/11/2026)
  const enTete = (blocHtml, f) => (!f ? blocHtml : blocHtml ? blocHtml.replace(/^(<section[^>]*>(?:<h3>[\s\S]*?<\/h3>)?)/, `$1${f}`) : f);

  async function construire(iso, office, options = {}) {
    const r = await construireOffice(iso, office, options);
    // complies, versions romaine et latin-français : chants grégoriens du livret de Bordeaux, repliés, en fin d'office
    if (office === "complies" && r && r.html && ["romaine", "latin"].includes(options.repartition || "romaine") && r.jour && r.jour.temps !== "triduum") {
      const ch = chantsBordeaux(r.jour, options);
      if (ch) r.html = r.html.replace(/<\/article>\s*$/, ch + "</article>");
    }
    return r;
  }
  async function construireOffice(iso, office, options = {}) {
    // version « 100 % AELF » : exactement les textes de l'AELF (psaumes, lectures, invitatoire, oraison), calendrier
    // romain sans le propre de l'Ordre, sans capitules, partitions ni ajouts ; seuls l'affichage et les exports sont les nôtres
    // version latin-français : les Heures grégoriennes n'ont pas d'Office des lectures → celui de l'AELF,
    // psaumes en latin (Nova Vulgata) en regard du français, le reste en français
    LATIN_LECT = options.repartition === "latin" && office === "lectures" && !!g.Latin?.psaumeLectures;
    if (LATIN_LECT && !(await g.Latin.chargerPsautier())) LATIN_LECT = false;
    AELF_PUR = options.repartition === "aelf" || LATIN_LECT;
    // version « Sainte-Baume » : la Province avec partitions, plus les livrets de Sainte-Baume (Carême, milieu du jour,
    // antiennes du temps ordinaire) là où ils donnent quelque chose
    if (options.repartition === "sainte-baume") options = { ...options, repartition: "romaine-gouzes", saintebaume: true, partitions: options.partitions !== false };
    if (AELF_PUR) options = { ...options, repartition: "romaine", partitions: false, capitules: false, propreOP: false, oraison: "liturgique", choix: {} };
    if (AELF_PUR && g.PsautierAELF && !g.PsautierAELF.charge) await g.PsautierAELF.charger("donnees/psautier_aelf.json").catch(() => null);
    const j = g.Calendrier.jour(iso, { propreOP: !!options.propreOP, choix: options.choix?.[iso] });
    // version latin-français (Heures grégoriennes) : construction à part, sans toucher aux autres versions
    if (options.repartition === "latin" && g.Latin && !LATIN_LECT) {
      const cm = communDuJour(j, options);   // commun choisi, ou appliqué d'office (fête de l'Ordre)
      const o2 = cm ? { ...options, communs: { ...(options.communs || {}), [iso]: cm } } : options;
      return g.Latin.construire(j, office, o2, { entete: (jj, off, src) => avecCommun(entete(jj, off, src), jj, off, o2, cm), bloc });
    }
    const avert = [];
    const optsJour = { propreOP: !!options.propreOP, choix: options.choix?.[iso] };
    // recherche de la partition par le texte de l'antienne : version gouzantine (la Province a ses carnets)
    PARTITIONS_ACTIVES = options.partitions !== false && !!g.Partitions?.index && options.repartition === "gouzantine";
    PARTITIONS_VERSION = options.partitions !== false && !!g.Partitions?.index && options.repartition !== "romaine";
    // Jours saints, mode Gouzes / Province : laudes (jeudi-samedi) et complies (jeudi, vendredi) propres
    if (JS && options.repartition && options.repartition !== "romaine" && j.temps === "triduum") {
      const jr = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"][j.jourSemaine];
      if (office === "laudes" && JS.laudes.jours[jr]) return joursSaintsLaudes(j, jr, options);
      if (office === "complies" && JS.complies.jours.includes(jr)) return joursSaintsComplies(j, options);
    }
    if (office === "complies" && CB && options.repartition && options.repartition !== "romaine") return await compliesOP(j, options, avert);
    const heure = HEURES[options.heure] ? options.heure : "sexte";
    const r = await g.AELF.office(office === "milieu" ? heure : office, iso, j);
    const d = r.donnees;
    if (!d) {
      const paques = office === "lectures" && j.cleTemporal === "paques-1-0";
      const msg = paques ? "Le jour de Pâques, l'Office des lectures est remplacé par la Vigile pascale : l'AELF ne le propose pas."
        : "L'AELF ne propose pas cet office pour cette date, ou la connexion internet est coupée.";
      // le lectionnaire dominicain reste proposé (lecture de Pâques ; ou si l'AELF ne répond pas)
      let lbx = "";
      if (office === "lectures" && !AELF_PUR && options.repartition !== "latin" && g.Bouchet) {
        const lb = g.Bouchet.rendu(j, { propreOP: !!options.propreOP }, esc);
        if (options.impression) { if (options.lecture2 === "bouchet" && lb.imprime) lbx = bloc("Lecture", `${lb.imprime}<p class="source-bouchet">Lectionnaire patristique dominicain (J.-R. Bouchet)</p>`, "lecture-longue lecture-bouchet-imprimee"); }
        else if (lb.section) lbx = bloc("Lecture au choix", `<details class="choix-lecture2"><summary>Lectionnaire dominicain (J.-R. Bouchet)</summary>${lb.section}</details>`, "lecture-longue lecture2-au-choix");
      }
      return { titre: OFFICES[office], html: `<article class="office">${entete(j, office)}<p class="avertissement">${msg}</p>${lbx}</article>`, avertissements: [msg], jour: j };
    }
    if (r.choix) avert.push(`Office choisi : ${j.nom} — textes propres de l'AELF repris du ${g.Calendrier.deIso(r.source).toLocaleDateString("fr-FR", { timeZone: "UTC" })}.`);
    else if (!r.exact) avert.push(`Date hors de la période publiée par l'AELF : textes propres repris du même jour liturgique (${g.Calendrier.deIso(r.source).toLocaleDateString("fr-FR", { timeZone: "UTC" })}).`);
    if (j.source === "op" && j.niveau <= 11) avert.push(`${j.nom} : célébration de l'Ordre ; l'AELF ne donne pas ses textes propres (textes du jour romain).`);
    const src = r.psalmodie || d;
    const optPs = { priere: !!options.prieres };
    // commun des saints choisi pour ce jour (bouton « Commun ») : laudes, milieu du jour, vêpres
    // aux vêpres de la veille d'un dimanche ou d'une solennité (premières vêpres du lendemain), c'est le commun choisi
    // pour le lendemain qui vaut (ses premières vêpres), pas celui du jour
    const lend = office === "vepres" ? g.Calendrier.jour(g.Calendrier.iso(g.Calendrier.plus(g.Calendrier.deIso(iso), 1)), { propreOP: !!options.propreOP, choix: options.choix?.[g.Calendrier.iso(g.Calendrier.plus(g.Calendrier.deIso(iso), 1))] }) : null;
const veille = !!lend && (lend.jourSemaine === 0 || lend.niveau <= 4) && lend.niveau < j.niveau
  && lend.temps !== "triduum" && (lend.temps !== "semaine sainte" || lend.jourSemaine === 0);
    const jCM = veille ? lend : j;
    const CM = AELF_PUR ? null : communDuJour(jCM, options);
    const com = CM && ["laudes", "milieu", "vepres"].includes(office) ? g.Communs.pour(CM, jCM, veille ? "vepres1" : office) : null;
    if (com) nommer(com, jCM);
    if (office === "milieu") return await milieuDuJour(j, d, src, r, options, avert, optPs, com, CM);
    // Propre de l'Ordre selon le carnet du sanctoral de la Province (versions Province et Sainte-Baume, propre OP) : hymnes,
    // psaumes, antiennes, répons du carnet ; capitule de la Province ; prière du Missel de l'Ordre. Un commun choisi à la main
    // l'emporte ; le commun appliqué d'office ne donne plus que ce que le carnet n'a pas (antienne évangélique, intercession…)
    const OPC = !AELF_PUR && options.propreOP && options.repartition === "romaine-gouzes" && g.PropreOP?.carnet && !(CM && !CM.auto)
      ? g.PropreOP.carnet(j, office, optsJour) : null;
    if (OPC) { const k = avert.findIndex((a) => /célébration de l'Ordre ; l'AELF/.test(a)); if (k >= 0) avert.splice(k, 1); }
    // livret de Sainte-Baume pour cet office (Carême), sauf commun choisi ou propre de l'Ordre
    // mémoire que le carnet du sanctoral traite comme une fête (psaumes propres : Notre-Dame des Douleurs, S. Martin de Tours,
    // Ste Agnès…) : l'AELF donne les psaumes de la férie ; au choix, ceux du carnet (menu « Psaumes : » de l'en-tête,
    // options.psaumesCarnet[date] ; demande de l'utilisateur, 20/11/2026). Pas si un commun est choisi à la main.
    const soM = !AELF_PUR && !OPC && !(CM && !CM.auto) && options.repartition === "romaine-gouzes" && ["laudes", "vepres"].includes(office)
      && j.source !== "temporal" && j.niveau >= 10 && g.Partitions?.ordoPour ? g.Partitions.ordoPour(j, office, optsJour) : null;
    const memCarnet = soM && !soM.veille && !soM.feriale && soM.pieces.some((x) => x.role === "antiennes" && x.ids?.length) ? soM : null;
    const PSC = !!(memCarnet && options.psaumesCarnet?.[iso]);
    const sbc = options.saintebaume && !com && !OPC && !PSC && g.SainteBaume?.donnees ? (g.SainteBaume.careme(j, office, optsJour) || g.SainteBaume.ordinaire(j, office, optsJour)) : null;
    const sbCareme = sbc && !sbc.ordinaire;
    let psalmo = null;
    const gz = options.repartition && options.repartition !== "romaine" && !(veille && options.repartition === "romaine-gouzes") && g.Gouzes ? g.Gouzes.resoudre(j, office, options.repartition) : null;
    if (sbc) psalmo = psalmodieSB(src, sbc, avert, optPs, office);
    else if (gz && gz.psalmodie) psalmo = psalmodieGouzes(gz.psalmodie, avert, optPs);
    else if (gz?.antiennesProvince) psalmo = psalmodieProvince(src, gz.antiennesProvince.antiennes, avert, optPs, office, gz.antiennesProvince);
    else if (gz && office !== "complies" && !OPC) avert.push(options.repartition === "gouzantine"
      ? "Liturgie chorale : pas de psalmodie gouzantine pour cet office ce jour-là (fête, temps de Noël, octave de Pâques…) — psalmodie romaine."
      : "Province : pas d'antiennes de Gouzes connues pour cet office (texte) — antiennes de l'AELF ; voir les partitions du carnet.");
    const psCommun = !OPC && !!(com && CM.psaumes !== "ferie" && com.psaumes?.length && com.antiennes?.length);
    if (psCommun) psalmo = psalmodieCommun(com, avert, optPs);
    if (OPC && !OPC.o.ferie && OPC.o.psalmodie?.length) psalmo = psalmodieOP(OPC.o, avert, optPs);
    const psalmoRomaine = psalmo == null;
    if (psalmo == null) psalmo = psalmodieRomaine(src, 3, avert, optPs);
    if (OPC?.o.ferie) psalmo = antiennesOPFerie(psalmo, OPC.o);
    if (PSC) psalmo = psalmodieCarnet(memCarnet, avert, optPs);

const jEnt = veille
  ? { ...jCM, dateLongue: j.dateLongue, date: j.date, premieres: true,
      psautier: j.psautier, psautierRomain: j.psautierRomain, jourSemaine: j.jourSemaine,
      facultatives: [], choixPossibles: [] }
  : j;
let h = avecCommun(entete(jEnt, office, d), j, office, options, veille ? null : CM);
    if (memCarnet) h = avecLigne(h, lignePsaumes(iso, PSC));
    if (OPC) {
      h += noteOP(OPC);
      h = h.replace("appliqué d'office : l'AELF ne donne pas les textes propres de cette célébration de l'Ordre", "appliqué d'office pour ce que le carnet ne donne pas (antienne évangélique, intercession…)");
    }
    if (com) h += OPC ? noteCommun(com, CM).replace("Commun :", "Complété par le commun :") : noteCommun(com, CM);
    else if (CM && office === "lectures") h += `<p class="note commun-choisi">Commun choisi pour ce jour : les Heures grégoriennes ne donnent pas l'Office des lectures ; textes de l'AELF du jour.</p>`;
    // version Province : partitions des carnets (Perdrix, Sainte-Baume) ; gouzantine : retrouvées par le texte de l'antienne
    // Province : les antiennes du carnet de la Province d'abord ; celles des livrets de Sainte-Baume seulement
    // quand le carnet n'en donne aucune pour cet office (jamais les deux mêlées)
    let pl = null;
    // propre de l'Ordre : du relevé des carnets, seulement les prières litaniques et le Te Deum des annexes (le reste vient d'offices_op.json)
    if (OPC && options.partitions !== false && g.Partitions?.index) {
      const so = g.Partitions.ordoPour?.(j, office, optsJour);
      pl = placeur((so?.pieces || []).filter((x) => x.role === "priere" || x.role === "tedeum"), office, !!options.impression);
    }
    // (avec un commun, les partitions du carnet pour la férie ne conviennent plus)
    else if (!com && !sbCareme && options.partitions !== false && g.Partitions?.index && options.repartition === "romaine-gouzes") {
      let duCarnet = piecesDuJour(j, office, optsJour, [...(psalmo || "").matchAll(/data-piece="([^"]+)"/g)].map((m) => m[1]));
      if (sbc?.ordinaire) duCarnet = duCarnet.filter((x) => x.role !== "antiennes" && x.role !== "cantique");
      // version Sainte-Baume : au temps ordinaire, les antiennes des livrets de Sainte-Baume d'abord
      const sb = !sbc && (options.saintebaume || !duCarnet.some((x) => x.role === "antiennes")) && j.temps === "ordinaire" && !(j.niveau <= 8 && j.source !== "temporal") ? g.Partitions.sbPour(j, office) : [];
      if (options.saintebaume && sb.some((x) => x.role === "antiennes")) duCarnet = duCarnet.filter((x) => x.role !== "antiennes");
      pl = placeur(sb.concat(duCarnet), office, !!options.impression);
    }
    const PL = (pred) => (pl ? pl.prendre(pred) : "");
    h += bloc("Introduction", propre(d.introduction), "introduction");
    if (office === "laudes" && options.invitatoire !== false && d.psaume_invitatoire) {
      // propre de l'Ordre : l'invitatoire des vigiles du carnet (saint Dominique)
      const invOP = OPC?.fete.offices.lectures?.invitatoire;
      const ai = invOP ? antienneOP(invOP) : sbc?.invitatoire ? antienneSB(sbc.invitatoire) : gz?.invitatoire ? antienneG(gz.invitatoire) : antienne(d.antienne_invitatoire);
      h += bloc("Invitatoire", `${ai}${invOP ? figOP(invOP.f, "Antienne de l'invitatoire", { role: "invitatoire" }) : ""}${sbc?.invitatoire ? figSB(sbc.invitatoire.f, "Antienne de l'invitatoire") : ""}${gz?.invitatoire && !invOP ? partitionTexte(gz.invitatoire.ant) : ""}${PL((x) => x.role === "invitatoire")}${psaume(AELF_PUR ? d.psaume_invitatoire : psaumeInvitatoire(j, d), avert, optPs)}${ai}`, "invitatoire");
    }
    const luc = OPC?.o.lucernaire?.length ? OPC.o.lucernaire.map((x) => figOP(x.f, x.titre, { role: "lucernaire" })).join("") : PL((x) => x.role === "lucernaire");
    if (luc) h += bloc("Lucernaire", luc);
    if (sbCareme && office === "vepres") h += lucernaireSB(g.SainteBaume.lucernaire(sbc.jour));
    let hyCarnet = PL((x) => x.role === "hymne");
    if (sbCareme && office !== "vepres") hyCarnet = figSB(g.SainteBaume.canon()?.partitions, "Canon de saint André : introduction et refrain");
    if (sbCareme && office === "vepres") {
      const imp = !!options.impression; let n = 0;
      hyCarnet = `<p class="note">Hymnes du livret de Sainte-Baume, au choix :</p>` + g.SainteBaume.hymnesVepres(sbc.jour).map((x) => `<details class="choix-hymne"${imp && n++ === 0 ? " open" : ""}><summary>${esc(x.titre)}${x.passion ? " (Passion)" : ""}</summary>${figSB(x.f, "", { ferme: false })}</details>`).join("");
    }
    const hyTexte = gz?.hymne ? hymneG(gz.hymne) : hymne(d.hymne);
    const canonJour = options.repartition === "romaine-gouzes" && g.Gouzes?.canonDuJour && (office === "lectures" || (office === "laudes" && j.jourSemaine !== 0)) ? g.Gouzes.canonDuJour(j) : null;
    let hy = canonJour
      ? dans(canonG(canonJour).replace("<h3>Grand Canon", "<h3>Hymne : Grand Canon"), `${hyCarnet}${hyTexte ? `<details class="hymne-aelf"><summary>Autre hymne (texte de l'AELF)</summary>${hyTexte}</details>` : ""}`)
      : hyCarnet && !gz?.hymne
      ? bloc("Hymne", `${sbCareme ? "" : `<p class="note">Hymne indiquée par le carnet de la Province :</p>`}${hyCarnet}${hyTexte ? `<details class="hymne-aelf"><summary>Autre hymne (texte de l'AELF)</summary>${hyTexte.replace(/^<section class="bloc ">/, "<div>").replace(/<\/section>$/, "</div>")}</details>` : ""}`, "hymne-carnet")
      : dans(hyTexte, hyCarnet);
    if (com?.hymne) hy = bloc("Hymne", hymneCommun(com.hymne) + (hyTexte ? `<details class="hymne-aelf"><summary>Autre hymne (texte de l'AELF)</summary>${hyTexte.replace(/^<section class="bloc[^"]*">/, "<div>").replace(/<\/section>$/, "</div>")}</details>` : ""), "hymne-commun");
    else if (PARTITIONS_VERSION && !com && !aPartition(hy)) { const gh = GREG(j, office, "hymne", "", "Hymne au choix"); if (gh) hy = hy ? dans(hy, `<p class="note">Ou bien, en grégorien :</p>${gh}`) : bloc("Hymne", gh); }
    
    // Gouzantine : retrouver les hymnes de l'office romain gouzantin (propre de l'Ordre, puis carnet de la Province),
// repliées sous l'hymne de Gouzes
let OPH = null;
if (options.repartition === "gouzantine" && !AELF_PUR && !com && options.partitions !== false && g.Partitions?.index) {
  OPH = options.propreOP && g.PropreOP?.carnet && !(CM && !CM.auto) ? g.PropreOP.carnet(j, office, optsJour) : null;
  if (!OPH?.o.hymnes?.length) {
    OPH = null;
    const hc = placeur(piecesDuJour(j, office, optsJour).filter((x) => x.role === "hymne"), office, !!options.impression).reste();
  if (hc) {
  const autre = hy ? `<details class="hymne-aelf"><summary>Ou bien : hymne ${gz?.hymne ? "de Gouzes" : "de l'AELF"}</summary>${hy.replace(/^<section class="bloc[^"]*">(?:<h3>[\s\S]*?<\/h3>)?/, "<div>").replace(/<\/section>$/, "</div>")}</details>` : "";
  hy = bloc("Hymne", `<p class="note">Hymne du carnet de la Province :</p>${hc}${autre}`, "hymne-carnet");
}
  }
}

    if (OPC?.o.hymnes?.length) h += provenance(hymneOP(OPC.o.hymnes, com?.hymne ? bloc("Hymne", hymneCommun(com.hymne)) : hyTexte), "carnet de la Province");
  else if (OPH) h += provenance(hymneOP(OPH.o.hymnes, hyTexte), "carnet de la Province");
  else h += com ? provenance(hy, com.hymne ? "du commun" : duJour(j)) : hy;

    if (pl && !sbc && !OPC) psalmo = pl.psalmodie(psalmo);
    // version gouzantine, psalmodie de l'AELF (jours sans propre gouzantin) : le cantique du NT gravé au début du cantique
    else if (PARTITIONS_ACTIVES && g.Partitions?.cantiqueGrave) psalmo = psalmo.replace(/<div class="psaume" data-piece="(NT\d+)"/g, (m, id) => {
      const f = g.Partitions.cantiqueGrave(id);
      return f && !psalmo.includes(f[0]) ? g.Partitions.figure(f, "", { role: "cantique" }) + m : m;
    });
    if (PARTITIONS_VERSION && psalmoRomaine && !com) {
      let k = 0;
      psalmo = psalmo.split(/(?=<div class="psalmodie-element">)/).map((el) => {
        if (!el.startsWith('<div class="psalmodie-element">')) return el;
        k++;
        if (aPartition(el)) return el;
        const f = GREG(j, office, "antienne", k, `Antienne ${k}`);
        return f ? el.replace(/(<div class="antienne">[\s\S]*?<\/div>)/, `$1${f}`) : el;   // au choix, sous l'antienne
      }).join("");
    }
    const blocPs = bloc(gz?.tenebres ? "Office des Ténèbres" : "Psalmodie", psalmo + PL((x) => x.role === "cantique" || x.role === "cantique-at"), "psalmodie");
    h += PSC ? provenance(blocPs, "psaumes du carnet de la Province") : OPC ? provenance(blocPs, OPC.o.ferie ? "antiennes du carnet, psaumes de la férie" : "carnet de la Province")
      : com ? provenance(blocPs, psCommun ? "du commun" : "de la férie") : blocPs;
    // antiennes que le carnet propose en plus, au choix
    if (OPC?.o.autres?.length) h += bloc("Autres antiennes du carnet, au choix", OPC.o.autres.map((a) => PARTITIONS_VERSION
      ? `<details class="autre-antienne"><summary>${esc(a.ant)}</summary>${figOP(a.f, "", { ferme: false })}</details>` : antienneOP(a)).join(""), "antiennes-au-choix");
    if (gz?.choral) h += dans(hymneG(gz.choral, "Choral"), PL((x) => x.role === "choral"));

    if (office === "lectures") {
      h += sbc?.verset ? bloc("", `<p><span class="rv">V/</span> ${esc(sbc.verset[0])}<br><span class="rv">R/</span> ${esc(sbc.verset[1])}</p>`, "verset") : bloc("", propre(d.verset_psaume), "verset");
      h += bloc("Première lecture", await lecture(d.lecture, avert, d.lecture?.titre), "lecture-longue");
      // partition du répons sous le titre « Répons », avant le texte (demande de l'utilisateur, 20/11/2026)
      const partRepL = (gz?.repons ? partitionGravee(gz.repons.refrain, "Répons") : "") + PL((x) => x.role === "repons");
      if (OPC?.o.repons?.length) h += provenance(bloc("Répons", reponsOP(OPC.o.repons, propre(d.repons_lecture)), "repons"), "carnet de la Province");
      else h += bloc("Répons", partRepL + (gz?.repons ? reponsG(gz.repons) : propre(d.repons_lecture)), "repons");
      // deuxième lecture : au choix, lectionnaire patristique dominicain (J.-R. Bouchet) ou AELF, en deux sections repliées ;
      // à l'impression, celle choisie dans la fenêtre d'export (options.lecture2), l'AELF si le lectionnaire ne propose rien
      const lb = !AELF_PUR && g.Bouchet ? g.Bouchet.rendu(j, { propreOP: !!options.propreOP }, esc) : { section: "", imprime: "" };
      const aelf2 = vide(d.texte_patristique) ? "" : `<h4>${propre(d.titre_patristique)}</h4><div class="lecture patristique">${propre(d.texte_patristique)}</div>`;
      const rep2 = aelf2 ? propre(d.repons_patristique) : "";
      if (options.impression && options.lecture2 === "bouchet" && lb.imprime) {
        h += bloc("Deuxième lecture", `${lb.imprime}<p class="source-bouchet">Lectionnaire patristique dominicain (J.-R. Bouchet)</p>`, "lecture-longue lecture-bouchet-imprimee");
      } else if (options.impression || !lb.section) {
        if (aelf2) { h += bloc("Deuxième lecture", aelf2, "lecture-longue"); h += bloc("Répons", rep2, "repons"); }
      } else {
        h += bloc("Deuxième lecture", `<details class="choix-lecture2"><summary>Lectionnaire dominicain (J.-R. Bouchet)</summary>${lb.section}</details>`
          + (aelf2 ? `<details class="choix-lecture2"><summary>Lecture de l'AELF</summary>${aelf2}${vide(rep2) ? "" : `<h4 class="intitule-repons">Répons</h4><div class="repons">${rep2}</div>`}</details>` : ""), "lecture-longue lecture2-au-choix");
      }
      h += canonG(gz?.canon);
      const ten = options.repartition !== "romaine" && g.Capitules ? g.Capitules.tenebres(j) : null;
      if (ten) { let l = ""; for (const r of ten) l += await lecture({ reference: r }, avert); h += bloc("Lectures de l'Office des Ténèbres (Province)", l, "lecture-longue"); }
      h += tenebresG(gz?.tenebres, gz?.tenebresPreces);
      if (d.te_deum && !Array.isArray(d.te_deum) && d.te_deum.texte) h += bloc("Te Deum", LATIN_LECT ? g.Latin.teDeum(`<div class="hymne">${propre(d.te_deum.texte)}</div>`) : `<div class="hymne">${propre(d.te_deum.texte)}</div>${PL((x) => x.role === "tedeum")}`);
      h += avecOraisonOP(j, options, bloc("Oraison", propre(d.oraison), "oraison"));
    } else {
      const cap = options.capitules !== false && g.Capitules ? g.Capitules.pour(j, office) : null;
      // propre de l'Ordre : le capitule de la Province (propre du saint, ou de son commun) avant celui du commun des Heures grégoriennes
      if (OPC && cap?.sanctoral) h += provenance(bloc("Parole de Dieu", (await lecture({ reference: cap.ref }, avert)), "lecture-breve"), "capitule de la Province");
      else if (com?.lecture) h += provenance(bloc("Parole de Dieu", await lecture({ reference: com.lecture.ref, texte: `<p>${esc(joindreCommun(com.lecture.texte))}</p>` }, avert), "lecture-breve"), "du commun");
      else if (cap) h += bloc("Parole de Dieu", (await lecture({ reference: cap.ref }, avert)), "lecture-breve");
      else h += bloc("Parole de Dieu", await lecture(d.pericope, avert), "lecture-breve");
      // partition du répons sous le titre « Répons », avant le texte (demande de l'utilisateur, 20/11/2026)
      let partRep = (gz?.repons ? partitionGravee(gz.repons.refrain, "Répons") : "") + PL((x) => x.role === "repons");
      if (PARTITIONS_VERSION && !gz?.repons && !com && !aPartition(partRep)) partRep += GREG(j, office, "repons", "", "Répons bref");
      let rep = partRep + (gz?.repons ? reponsG(gz.repons) : propre(d.repons));
      if (sbc?.repons) rep = reponsSB(sbc.repons) + (vide(propre(d.repons)) ? "" : `<details class="hymne-aelf"><summary>Ou bien : répons bref de l'AELF</summary>${propre(d.repons)}</details>`);
      if (!sbc?.repons && gz?.reponsProvince && !vide(propre(d.repons))) rep += `<details class="hymne-aelf"><summary>Ou bien : répons bref de l'AELF</summary>${propre(d.repons)}</details>`;
      if (com?.repons) rep = reponsCommun(com.repons);
      if (OPC?.o.repons?.length) h += provenance(bloc("Répons", reponsOP(OPC.o.repons, com?.repons ? reponsCommun(com.repons) : propre(d.repons)), "repons"), "carnet de la Province");
      else h += com ? provenance(bloc("Répons", rep, "repons"), com.repons ? "du commun" : duJour(j)) : bloc("Répons", rep, "repons");
      const [cleAnt, cleCant, nomCant] = office === "laudes" ? ["antienne_zacharie", "cantique_zacharie", "Cantique de Zacharie"]
        : office === "vepres" ? ["antienne_magnificat", "cantique_mariale", "Cantique de Marie"] : ["antienne_symeon", "cantique_symeon", "Cantique de Syméon"];
      const evOP = OPC?.o.evangelique;
      const aev = evOP ? antienneOP(evOP) : sbc?.ev ? antienneSB(sbc.ev) : com?.evangelique ? antienneCommun({ texte: com.evangelique }) : gz?.evangelique && office !== "complies" ? antienneG(gz.evangelique) : antienne(d[cleAnt]);
      let pev = evOP ? figOP(evOP.f, "Antienne") : sbc?.ev ? figSB(sbc.ev.f, "Antienne") : com?.evangelique ? "" : `${gz?.evangelique && office !== "complies" ? partitionTexte(gz.evangelique.ant) : ""}${PL((x) => x.role === "benedictus" || x.role === "magnificat")}`;
      // (antienne latine du carnet : l'antienne du commun ou du jour, en français, repliée dessous)
      if (evOP && com?.evangelique) pev += `<p class="note">Ou bien, en français (antienne du commun) : ${esc(com.evangelique)}</p>`;
      if (PARTITIONS_VERSION && !gz?.evangelique && !com && !sbc?.ev && !aPartition(pev)) pev += GREG(j, office, "evangelique", "", nomCant);
      const blocEv = bloc(nomCant, `${aev}${pev}${psaume(d[cleCant], avert, { sansTitre: true })}${aev}`, "cantique-evangelique");
      h += evOP ? provenance(blocEv, "antienne du carnet") : com ? provenance(blocEv, com.evangelique ? "antienne du commun" : "antienne " + duJour(j)) : blocEv;
      if (office !== "complies") {
        h += com?.preces ? enTete(provenance(bloc("Intercession", precesCommun(com.preces), "intercession"), "du commun"), OPC ? PL((x) => x.role === "priere") : "")
          : enTete(gz?.preces ? bloc("Litanie", precesG(gz.preces), "intercession") : bloc("Intercession", propre(d.intercession), "intercession"), PL((x) => x.role === "priere") + (sbc?.fin?.preces ? figSB(sbc.fin.preces, "Preces, ton du Carême") : ""));
        if (options.repartition && options.repartition !== "romaine") h += president(j, office);
        h += bloc("Notre Père", (sbc?.fin?.notre ? figSB(sbc.fin.notre, "Notre Père") : "") + NOTRE_PERE);
        h += avecOraisonOP(j, options, com ? oraisonCommun(j, office, propre(d.oraison), com, options) : oraisonAuChoix(j, office, propre(d.oraison), options));
        h += bloc("Bénédiction", BENEDICTION + (sbc?.fin?.benissons ? figSB(sbc.fin.benissons, "Bénissons le Seigneur, ton du Carême") : ""));
        if (OPC?.o.fin?.length && PARTITIONS_VERSION) h += OPC.o.fin.map((x) => bloc(esc(x.titre), figOP(x.f, x.titre, { role: "hymne" }))).join("");
      } else {
        h += oraisonAuChoix(j, "complies", propre(d.oraison), options);
        h += bloc("Bénédiction", propre(d.benediction));
        if (d.hymne_mariale && !vide(d.hymne_mariale.texte)) h += bloc(`Antienne mariale${d.hymne_mariale.titre ? " : " + esc(d.hymne_mariale.titre) : ""}`, `<div class="hymne">${propre(d.hymne_mariale.texte)}</div>`);
      }
    }
    if (sbc?.ordinaire) h += `<p class="note source-sb">Répartition de Sainte-Baume (antiennes des offices) : ${esc(sbc.nom)}.</p>`;
    else if (sbc) h += `<p class="note source-sb">Livret de Sainte-Baume (fr. Max) : ${esc(sbc.nom.replace(/^./, (x) => x.toUpperCase()).replace(/ ([iv]+)$/, (m, r) => " " + r.toUpperCase()))}.</p>`;
    if (pl) {
      const r = pl.reste(); if (r) h += bloc("Autres partitions du carnet pour cet office", r, "partitions-autres");
      if (g.Partitions.local) h += `<p class="cle-correction no-print" title="À recopier dans partitions/corrections.json pour corriger les partitions de cet office">Clé de cet office pour une correction : <code>${esc(g.Partitions.cleJour(j))}|${office}</code></p>`;
    }
    if (avert.length) h += `<aside class="avertissements">${avert.map((a) => `<p>${esc(a)}</p>`).join("")}</aside>`;
    if (LATIN_LECT) h = h.replace(/(<\/header>)/, `$1<p class="note no-print">Version latin-français : les Heures grégoriennes ne donnent pas l'Office des lectures. Office de l'AELF ; psaumes en latin (Nova Vulgata) en regard du texte de l'AELF ; le reste en français.</p>`);
    return { titre: OFFICES[office], html: `<article class="office office-${office}${LATIN_LECT ? " office-latin" : ""}">${h}</article>`, avertissements: avert, jour: j };
  }

  // ── Office du milieu du jour : carnet de la Province (psaumes, verset, hymnes) ; AELF (sexte) pour le reste
  function strophes4(lignes) {
    const st = [];
    for (let i = 0; i < lignes.length; i += 4) st.push(lignes.slice(i, i + 4));
    return st;
  }
  // heures du milieu du jour (l'AELF les publie séparément : lecture brève, répons et oraison propres à chacune)
  const HEURES = { tierce: "Tierce", sexte: "Sexte", none: "None" };
  // les trois capitules (lecture brève de tierce, sexte, none), chacun sous son titre, à l'écran comme à l'impression
  // (demande de l'utilisateur, 18/11/2026) ; avecRepons : le répons bref de chaque heure sous sa lecture
  async function troisHeures(j, d, options, avert, avecRepons) {
    const H = HEURES[options.heure] ? options.heure : "sexte";
    const parties = [];
    for (const x of Object.keys(HEURES)) {
      const dx = x === H ? d : (await g.AELF.office(x, j.date, j)).donnees;
      if (!dx?.pericope?.reference) continue;
      const rep = avecRepons ? propre(dx.repons) : "";
      parties.push(`<section class="capitule-heure"><h4 class="intitule-heure">${HEURES[x]}</h4>${await lecture(dx.pericope, x === H ? avert : [])}${vide(rep) ? "" : `<div class="repons">${rep}</div>`}</section>`);
    }
    return parties.length > 1 ? parties.join("") : null;
  }
  async function milieuDuJour(j, d, src, r, options, avert, optPs, com = null, CM = null) {
    let carnet = options.repartition !== "romaine" && g.Milieu?.donnees ? g.Milieu.pour(j) : null;
    // version Sainte-Baume : hymnes, psaumes, antienne et verset du livret du milieu du jour (pas aux fêtes)
    const sbm = options.saintebaume && !com && g.SainteBaume?.donnees ? g.SainteBaume.milieu(j) : null;
    if (sbm) carnet = { hymnes: sbm.hymnes.map((h) => h.flat()), gregoriennes: [], ps: sbm.ps, versets: sbm.verset ? [sbm.verset] : [],
      antiennes: sbm.ant ? [{ ant: sbm.ant.texte || `${sbm.ant.inc || ""}…`, cote: sbm.ant.cote, partition: sbm.ant.f ? [sbm.ant.f] : null }] : [],
      groupes: sbm.groupes, sainteBaume: true };
    const gz = options.repartition === "gouzantine" && g.Gouzes ? g.Gouzes.resoudre(j, "milieu", "gouzantine") : null;
    const P = (f, l) => (options.partitions !== false && g.Partitions ? g.Partitions.figure(f, l) : "");
    let h = avecCommun(entete(j, "milieu", d), j, "milieu", options, CM);
    if (com) h += noteCommun(com, CM);
    h += bloc("Introduction", propre(d.introduction), "introduction");
    // Hymnes : françaises (texte), puis grégoriennes (traduction, puis partition avec les strophes latines)
    if (carnet?.hymnes?.length || carnet?.gregoriennes?.length) {
      // chaque proposition dans sa section repliée : le chantre déplie celle qu'il retient (la première à l'impression)
      const imp = !!options.impression;
      let hh = "", n = 0;
      const choixH = (titre, contenu) => `<details class="choix-hymne"${imp && n++ === 0 ? " open" : ""}><summary>${esc(titre)}</summary>${contenu}</details>`;
      for (const hy of carnet.hymnes || []) hh += choixH(String(hy[0] || "Hymne").replace(/[,;:.]$/, "") + "…", `<div class="hymne">${strophes4(hy).map((st) => `<p>${st.map(esc).join("<br>")}</p>`).join("")}</div>`);
      for (const gr of carnet.gregoriennes || [])
        hh += choixH(`${gr.titre} (grégorien)`, `${P(gr.partition, "")}${gr.traduction?.length ? `<p class="rubrique-texte">Traduction :</p><div class="hymne traduction">${gr.traduction.map((st) => `<p>${st.map(esc).join("<br>")}</p>`).join("")}</div>` : ""}`);
      h += bloc("Hymne (au choix)", hh);
    } else h += hymne(d.hymne);
    // Psalmodie : antienne (texte, puis partition), psaumes, antienne
    let psalmo;
    if (gz?.psalmodie) {
      // répartition hebdomadaire : antienne de la section du Ps 118 au temps ordinaire ; sinon celle du carnet (temps, jour)
      let ps = gz.psalmodie;
      const ca = carnet?.antiennes?.[0];
      if (gz.feuille && ca?.ant && (!ps[0].ant || j.temps !== "ordinaire")) ps = [{ ...ps[0], ant: ca.ant, cote: ca.cote, ton: undefined }, ...ps.slice(1)];
      psalmo = psalmodieGouzes(ps, avert, optPs);
      const pa = (gz.feuille && ps[0].ant === ca?.ant ? ca?.partition : null) || g.Milieu?.partitionDe(ps[0]?.ant);
      if (pa) psalmo = psalmo.replace(/(<div class="antienne">[\s\S]*?<\/div>)/, `$1${P(pa, "Antienne")}`);
    } else if (carnet?.groupes?.length > 1) {
      // Sainte-Baume : plusieurs antiennes, chacune sur ses psaumes (dimanches)
      psalmo = carnet.groupes.map((gr) => {
        const ant = antienneSB(gr.ant);
        const corps = gr.ps.map((id) => g.Psautier.donnees.pieces[id] ? g.Psautier.html({ id }, optPs) : (avert.push(`Milieu du jour : « ${id} » introuvable dans le psautier.`), "")).join("");
        return `<div class="psalmodie-element">${ant}${gr.ant?.f ? P([gr.ant.f], "Antienne") : ""}${corps}${ant}</div>`;
      }).join("");
    } else if (carnet?.ps?.length) {
      const a = carnet.antiennes?.[0];
      const ant = a?.ant ? `<div class="antienne"><span class="rubrique">Ant.</span> ${esc(a.ant)}${a.cote ? ` <span class="ton">${esc(a.cote)}</span>` : ""}</div>` : "";
      psalmo = ant + (a ? P(a.partition, "Antienne et ton de la psalmodie") : "") + carnet.ps.map((id) => {
        if (!g.Psautier.donnees.pieces[id]) { avert.push(`Milieu du jour : « ${id} » introuvable dans le psautier.`); return ""; }
        return `<div class="psalmodie-element">${g.Psautier.html({ id }, optPs)}</div>`;
      }).join("") + ant;
    } else psalmo = psalmodieRomaine(src, 3, avert, optPs);
    // commun : son antienne (fêtes ; aux mémoires, psaumes et antienne de la férie)
    if (com?.antiennes?.[0] && CM.psaumes !== "ferie") psalmo = psalmo.replace(/<div class="antienne">[\s\S]*?<\/div>/g, antienneCommun(com.antiennes[0]));
    h += com ? provenance(bloc("Psalmodie", psalmo, "psalmodie"), com.antiennes?.[0] && CM.psaumes !== "ferie" ? "antienne du commun, psaumes du jour" : "du jour") : bloc("Psalmodie", psalmo, "psalmodie");
    const H = HEURES[options.heure] ? options.heure : "sexte";
    if (com?.milieu?.length) {
      // les trois capitules du commun (tierce, sexte, none), chacun avec son verset
      let t = "";
      const noms = Object.values(HEURES);
      for (const [i, m] of com.milieu.entries()) t += `<section class="capitule-heure"><h4 class="intitule-heure">${noms[i] || ""}</h4>${await lecture({ reference: m.ref }, avert)}${m.verset?.length ? `<div class="repons">${reponsCommun(m.verset)}</div>` : ""}</section>`;
      h += provenance(bloc("Parole de Dieu", t, "lecture-breve trois-heures"), "du commun");
      h += avecOraisonOP(j, options, com.oraison ? oraisonCommun(j, "milieu", propre(d.oraison), com, options) : await oraisonsTroisHeures(j, d, options));
      h += bloc("Conclusion", CONCLUSION);
      if (avert.length) h += `<aside class="avertissements">${avert.map((a) => `<p>${esc(a)}</p>`).join("")}</aside>`;
      return { titre: OFFICES.milieu, html: `<article class="office office-milieu">${h}</article>`, avertissements: avert, jour: j };
    }
    const trois = await troisHeures(j, d, options, avert, !carnet?.versets?.length);
    if (trois) h += bloc("Parole de Dieu", trois, "lecture-breve trois-heures");
    else h += bloc(`Parole de Dieu${H !== "sexte" ? ` (${HEURES[H].toLowerCase()})` : ""}`, await lecture(d.pericope, avert), "lecture-breve");
    if (carnet?.versets?.length) {
      const [v, rr] = carnet.versets[0];
      const autres = carnet.versets.slice(1).map(([a, b]) => `<p class="note">ou : V/ ${esc(a)} R/ ${esc(b || "")}</p>`).join("");
      h += bloc("Verset", `<p><span class="rv">V/</span> ${esc(v)}<br><span class="rv">R/</span> ${esc(rr || "")}</p>${autres}`, "repons");
    } else if (!trois) h += bloc("Répons", propre(d.repons), "repons");
    h += avecOraisonOP(j, options, await oraisonsTroisHeures(j, d, options));
    h += bloc("Conclusion", CONCLUSION);
    if (carnet?.titre) avert.push(`Milieu du jour : livret de la Province (Marseille), « ${carnet.titre} ».`);
    if (carnet?.sainteBaume) h += `<p class="note source-sb">Livret de Sainte-Baume (fr. Max), milieu du jour.</p>`;
    if (avert.length) h += `<aside class="avertissements">${avert.map((a) => `<p>${esc(a)}</p>`).join("")}</aside>`;
    return { titre: OFFICES.milieu, html: `<article class="office office-milieu">${h}</article>`, avertissements: avert, jour: j };
  }

  // ── Jours saints (livret de la communauté)
  function joursSaintsLaudes(j, jr, options) {
    const L = JS.laudes, x = L.jours[jr];
    const optPs = { priere: false, sansPriere: true, sansGloire: true };
    const ant = (t) => `<div class="antienne"><span class="rubrique">Ant.</span> ${esc(t)}</div>`;
    let h = entete(j, "laudes");
    const pl = options.partitions !== false && g.Partitions?.index ? placeur(g.Partitions.piecesPour(j, "laudes").filter((x) => x.role === "antiennes" || x.role === "benedictus")) : null;
    h += bloc("", `<p class="rubrique-texte">${esc(L.rubrique)}</p>`);
    let ps = `<div class="psalmodie-element">${ant(L.antienne1)}${g.Psautier.html({ id: "50" }, optPs)}${ant(L.antienne1)}</div>`
      + `<div class="psalmodie-element">${g.Psautier.html({ id: x.cantique }, optPs)}</div>`
      + `<div class="psalmodie-element">${ant(x.antienne2)}${g.Psautier.html({ id: x.psaume2 }, optPs)}${ant(x.antienne2)}</div>`;
    if (pl) ps = pl.psalmodie(ps);
    h += bloc("Psalmodie", ps, "psalmodie");
    h += bloc("", `<p class="rubrique-texte">Ni lecture, ni répons. Après un temps de silence, on enchaîne directement :</p>`);
    h += bloc("Cantique de Zacharie", `${ant(L.antienne_benedictus)}${pl ? pl.prendre((y) => y.role === "benedictus") : ""}${g.Psautier.html({ id: "NT2" }, { ...optPs, sansTitre: true })}${ant(L.antienne_benedictus)}`, "cantique-evangelique");
    h += bloc("Oraison", `<p class="rubrique-texte">Pas de prière litanique ni de Notre Père. L’office se conclut directement par l’oraison, sans introduction ni doxologie.</p><p>${esc(JS.oraison)}</p>`, "oraison");
    return { titre: OFFICES.laudes, html: `<article class="office office-laudes">${h}</article>`, avertissements: [], jour: j };
  }
  function joursSaintsComplies(j, options) {
    const C = JS.complies;
    let h = entete(j, "complies");
    h += bloc("", `<p class="rubrique-texte">${esc(C.rubrique)}</p>`);
    h += bloc("Psalmodie", g.Psautier.html({ id: C.psaume }, { sansGloire: true }), "psalmodie");
    h += bloc("Antienne", `<p class="rubrique-texte">Il n’y a pas de lecture ; au lieu du répons, on prend l’antienne :</p><p>${esc(C.antienne_latin)}</p><p><i>${esc(C.antienne)}</i></p>`, "repons");
    h += bloc("Cantique de Syméon", `<p class="rubrique-texte">Sans antienne ni doxologie finale.</p>${g.Psautier.html({ id: "NT3" }, { sansTitre: true, sansGloire: true })}`, "cantique-evangelique");
    h += bloc("Oraison", `<p class="rubrique-texte">Sans introduction ni doxologie.</p><p>${esc(JS.oraison)}</p><p class="rubrique-texte">${esc(C.fin)}</p>`, "oraison");
    return { titre: OFFICES.complies, html: `<article class="office office-complies">${h}</article>`, avertissements: [], jour: j };
  }

  // ── Complies selon le livret de l'Ordre (Bordeaux 2009) : texte, puis partition en dessous
  const lignesRV = (ls) => ls.map((l) => `<p>${esc(l).replace(/^([RV])\/\s?/, '<span class="rv">$1/</span> ').replace(/\s?R\/ Amen\.$/, ' <span class="rv">R/</span> Amen.')}</p>`).join("");
  const strophesHtml = (st) => `<div class="hymne">${st.map((x) => `<p>${x.map(esc).join("<br>")}</p>`).join("")}</div>`;
  function cleCompliesTemps(j) {
    const C = g.Calendrier, nom = j.nom || "", mm = j.date.slice(5);
    const marie = /Vierge Marie|Notre-Dame|Immaculée|Assomption|Mère de Dieu/.test(nom) && j.niveau <= 8;
    let t = j.temps;
    if (t === "noel") t = mm.startsWith("01") && C.deIso(j.date) >= C.reperes(+j.date.slice(0, 4)).epiphanie ? "noel-epiphanie" : "noel";
    if (t === "paques") t = /^Pentecôte/.test(nom) ? "pentecote" : (j.semaine === 6 && j.jourSemaine >= 4) || j.semaine === 7 || /Ascension/.test(nom) ? "ascension" : "paques";
    return { t, marie };
  }
  // pièces du livret de Bordeaux pour un jour : mêmes règles pour les complies OP et pour le recueil de partitions
  function choixBordeaux(j, options) {
    const Ca = g.Calendrier, JR = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"];
    const demain = Ca.jour(Ca.iso(Ca.plus(Ca.deIso(j.date), 1)), { propreOP: !!options.propreOP });
    const { t, marie } = cleCompliesTemps(j);
    const careme = t === "careme" || t === "semaine sainte" || t === "triduum";
    let jr = JR[j.jourSemaine];
    if (j.niveau <= 4 && j.jourSemaine !== 0 && j.temps !== "triduum") jr = "dimanche";
    else if (demain.niveau <= 4 && demain.jourSemaine !== 0 && demain.temps !== "triduum" && j.temps !== "triduum") jr = "samedi";
    if (j.temps === "paques" && j.semaine === 1) jr = "dimanche";
    const cleH = careme ? "careme" : ["paques", "ascension", "pentecote", "noel", "noel-epiphanie"].includes(t) ? t
      : marie ? "marie" : t === "avent" ? (j.jourSemaine === 0 ? "avent-dimanche" : "to-ferie")
      : j.jourSemaine === 0 ? "to-dimanche" : j.jourSemaine === 6 ? "to-samedi" : "to-ferie";
    const cleR = t === "triduum" ? "triduum" : careme ? (j.jourSemaine === 0 || j.jourSemaine === 6 || j.niveau <= 8 || t === "semaine sainte" ? "media-vita" : "careme")
      : t === "noel" || t === "noel-epiphanie" ? "noel" : ["paques", "ascension", "pentecote"].includes(t) ? (j.temps === "paques" && j.semaine === 1 ? "octave-paques" : "paques") : "to";
    const nom = j.nom || "";
    const cleA = /Présentation du Seigneur/.test(nom) ? "presentation" : /Annonciation/.test(nom) ? "annonciation"
      : /Saint-Sacrement|Corps et (du )?Sang/.test(nom) ? "saint-sacrement" : /Sacré-Cœur/.test(nom) ? "sacre-coeur"
      : marie ? "marie" : t === "triduum" ? "to" : careme ? (j.semaine >= 3 || t === "semaine sainte" ? "careme-3" : "careme")
      : ["noel", "noel-epiphanie", "paques", "ascension", "pentecote"].includes(t) ? t : "to";
    return { t, marie, careme, jr, cleH, cleR, cleA, JR };
  }

  // Versions romaine et latin-français : les chants grégoriens du livret de Bordeaux pour ce soir, en fin d'office,
  // chaque partition repliée (le chantre déplie ce qu'il veut chanter)
  function chantsBordeaux(j, options) {
    if (!CB || !g.Partitions?.figure) return "";
    const F = (f, titre) => f && f.length ? `<h4>${esc(titre)}</h4>${g.Partitions.figure(f, "", { ferme: true })}` : "";
    const c = choixBordeaux(j, options), H = CB.hymnes[c.cleH], R = CB.repons[c.cleR], A = CB.antiennes[c.cleA], Pr = CB.priere;
    let h = F(CB.introduction.partition, "Introduction (Deus in adjutorium)");
    if (H) h += F(H.gregorien ? H.gregorien.partition : H.partition, `Hymne : ${H.gregorien ? H.gregorien.titre : H.titre}`);
    if (R) h += F(R.partition, c.cleR === "triduum" || c.cleR === "octave-paques" ? "Verset" : "Répons bref");
    if (A) h += F([...(A.partition || []), ...(A.ton || [])], `Cantique de Syméon : antienne ${A.latin ? "« " + A.latin.split(/[,:;.]/)[0] + " »" : ""}`);
    h += F(Pr.partition_oraison, "Prière") + F(Pr.partition_benediction, "Bénédiction");
    if (j.temps !== "triduum") for (const x of CB.procession) h += F(x.partition, `Procession : ${x.titre}`);
    return h ? `<section class="bloc chants-bordeaux"><h3>Chants grégoriens (complies de l’Ordre, Bordeaux 2009)</h3>${h}</section>` : "";
  }

  async function compliesOP(j, options, avert) {
    const P = (f, l) => (options.partitions !== false && g.Partitions ? g.Partitions.figure(f, l) : "");
    // psaumes : samedi et veille des solennités ; dimanche et soir des solennités (voir choixBordeaux)
    const { t, marie, careme, jr, cleH, cleR, cleA, JR } = choixBordeaux(j, options);
    const J = CB.jours[jr];
    let h = entete(j, "complies");
    // Introduction
    const I = CB.introduction;
    let intro = lignesRV(I.texte.map((l) => (careme ? l.replace(/ Alléluia\.$/, "") : l)));
    intro += P(I.partition, "");
    intro += `<h4>Acte pénitentiel</h4><p class="rubrique-texte">${esc(I.penitence.rubrique)}</p><p>${I.penitence.confiteor.map(esc).join("<br>")}</p><p class="rubrique-texte">Le prieur ou l’hebdomadier :</p>${lignesRV([I.penitence.absolution.slice(0, -1).join(" "), "R/ Amen."])}`;
    h += bloc("Introduction", intro, "introduction");
    // Hymne
    const H = CB.hymnes;
    const hy = H[cleH];
    // hymnes au choix : chacune dans sa section repliée (la première est dépliée à l'impression)
    const imp = !!options.impression;
    const choixH = (titre, contenu, premier) => `<details class="choix-hymne"${premier && imp ? " open" : ""}><summary>${esc(titre)}</summary>${contenu}</details>`;
    const mariale = marie && careme ? P(H["marie-careme"].partition, H["marie-careme"].note) : marie && ["paques", "ascension", "pentecote"].includes(t) ? P(H["marie-paques"].partition, H["marie-paques"].note) : "";
    let hh = "";
    if (hy.gregorien) {
      hh += choixH(`${hy.titre} (français)`, strophesHtml(hy.strophes) + P(hy.partition, ""), true);
      hh += choixH(`${hy.gregorien.titre} (grégorien)`, P(hy.gregorien.partition, "") + mariale, false);
    } else {
      hh += choixH(`${hy.titre} (grégorien${hy.note ? " — " + hy.note : ""})`, P(hy.partition, "") + mariale + `<p class="rubrique-texte">Traduction :</p>` + strophesHtml(hy.strophes), true);
    }
    for (const x of H.autres) hh += choixH(`${x.titre} (usage romain)`, strophesHtml(x.strophes), false);
    h += bloc("Hymne (au choix)", hh);
    // Psalmodie (sans antienne, selon le livret)
    const optPs = { priere: !!options.prieres };
    h += bloc("Psalmodie", (J.titre ? `<p class="rubrique-texte">${esc(J.titre)}</p>` : "") + J.psaumes.map((x) => `<div class="psalmodie-element">${g.Psautier.html(x, optPs)}</div>`).join(""), "psalmodie");
    // Lecture brève
    h += bloc("Lecture brève", J.lecture_texte ? `<p class="ref-ligne">${esc(J.lecture)}</p><div class="lecture"><p>${esc(J.lecture_texte)}</p></div>` : await lecture({ reference: J.lecture }, avert), "lecture-breve");
    // Répons
    const R = CB.repons;
    const rp = R[cleR];
    let rh = P(rp.partition, "") + (rp.rubrique ? `<p class="rubrique-texte">${esc(rp.rubrique)}</p>` : "") + lignesRV(rp.texte);
    if (cleR === "media-vita") rh += `<p class="rubrique-texte">Ou bien :</p>${P(R.careme.partition, "")}${lignesRV(R.careme.texte)}`;
    h += bloc(cleR === "triduum" || cleR === "octave-paques" ? "Verset" : "Répons bref", rh, "repons");
    // Cantique de Syméon
    const A = CB.antiennes;
    const a = A[cleA];
    const antH = `<div class="antienne"><span class="rubrique">Ant.</span> <span class="latin">${esc(a.latin)}</span></div><p class="traduction">${esc(a.texte)}</p>`;
    h += bloc("Cantique de Syméon", antH + P(a.partition, "") + P(a.ton, "") + g.Psautier.html({ id: "NT3" }, { sansTitre: true }) + `<div class="antienne"><span class="rubrique">Ant.</span> <span class="latin">${esc(a.latin)}</span></div>`, "cantique-evangelique");
    // Prière et bénédiction
    const Pr = CB.priere;
    const cleJ = j.niveau <= 4 && j.jourSemaine !== 0 ? "soir-solennite" : jr === "samedi" && j.jourSemaine !== 6 ? "veille-solennite" : JR[j.jourSemaine];
    // oraison des Heures grégoriennes (le samedi et le soir des solennités, les mêmes qu'à l'usage romain) : proposée
    // en plus si elle diffère ; réglage « des Heures grégoriennes » : elle passe en premier, le livret replié
    const romain = lignesRV(Pr.jours[cleJ] || []);
    const hgC = oraisonGregorienne(j, "complies", options);
    const hgAutre = hgC && !memeTexte(hgC, romain) && !memeTexte(hgC, Pr.oraison);
    const livret = lignesRV([Pr.oraison]) + P(Pr.partition_oraison, "");
    const romainD = `<details class="autres-hymnes"><summary>Ou bien, selon l’usage romain</summary>${romain}</details>`;
    h += bloc("Prière", options.oraison === "gregoriennes" && hgC
      ? `${hgC}<details class="autres-hymnes"><summary>Ou bien : prière du livret de Bordeaux</summary>${livret}</details>${hgAutre ? romainD : ""}`
      : `${livret}${romainD}${hgAutre ? `<details class="autres-hymnes"><summary>Ou bien : oraison des Heures grégoriennes</summary>${hgC}</details>` : ""}`, "oraison");
    h += bloc("Bénédiction", lignesRV([Pr.benediction]) + P(Pr.partition_benediction, ""));
    // Procession
    let pr = "";
    for (const x of CB.procession) pr += `<h4>${esc(x.titre)}</h4><p class="latin">${esc(x.latin)}</p>${g.Partitions?.figure ? g.Partitions.figure(x.partition, "", { ferme: true }) : ""}${lignesRV(x.suite)}`;
    if (j.temps !== "triduum") h += bloc("Procession", pr);
    if (avert.length) h += `<aside class="avertissements">${avert.map((x) => `<p>${esc(x)}</p>`).join("")}</aside>`;
    return { titre: OFFICES.complies, html: `<article class="office office-complies">${h}</article>`, avertissements: avert, jour: j };
  }

  g.Offices = { construire, OFFICES, propre, chargerJoursSaints, chargerComplies, chargerPresident, communDuJour };
})(typeof window !== "undefined" ? window : globalThis);
