/* Messe du jour : lectures et psaume de l'AELF (api.aelf.org, « messes »), propres du Missel romain
   (donnees/missel.json, temporal) : antienne d'ouverture, prière, prière sur les offrandes, antienne de la
   communion, prière après la communion, prière sur le peuple. Même mise en forme que les offices.

   Messe.cle(j) → clé du Missel pour le jour (voir outils/construire_missel.py).
   Messe.construire(j, aelf, missel, choix) → { html, messes: [noms], sections: [{id, titre}] }.
*/
(function (g) {
  "use strict";
  const esc = (s) => String(s ?? "").replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));
  const PERMIS = new Set(["p", "br", "em", "i", "strong", "b", "u", "sup", "span"]);
  // HTML de l'AELF : seulement quelques balises sans attributs (comme js/offices.js)
  function propre(h) {
    if (h == null) return "";
    h = String(h).replace(/<(script|style)[\s\S]*?<\/\1>/gi, "");
    h = h.replace(/<(\/?)([a-z0-9]+)([^>]*)>/gi, (m, f, t, attrs) => {
      t = t.toLowerCase();
      if (!PERMIS.has(t)) return t === "div" || t === "li" ? (f ? "" : "<br>") : "";
      if (t === "span" && !f) return /verse_number/.test(attrs) ? '<span class="v">' : "<span>";
      return `<${f}${t}>`;
    });
    h = h.replace(/&nbsp;/g, " ").replace(/<p>(\s|<br>)*<\/p>/gi, "").replace(/(<br>\s*){2,}/gi, '<br><span class="espace"></span>')
      .replace(/<p>(\s|<br>)+/gi, "<p>").replace(/(\s|<br>)+<\/p>/gi, "</p>").replace(/^(\s|<br>)+|(\s|<br>)+$/g, "");
    return h.replace(/\b([RV])\/\s?/g, '<span class="rv">$1/</span> ').trim();
  }
  // nom d'une messe de l'AELF, sans ses capitales (« VEILLEE PASCALE » → « Veillée pascale »)
  function joli(nom) {
    let t = String(nom || "");
    if (/[A-ZÉÈ]{4}/.test(t)) t = t.toLowerCase().replace(/\b(seigneur|pâques|cène)\b/g, (m) => m.charAt(0).toUpperCase() + m.slice(1)).replace("veillee", "veillée");
    return t.charAt(0).toUpperCase() + t.slice(1);
  }
  const vide = (h) => !h || !String(h).replace(/<[^>]+>|&nbsp;|\s/g, "");

  function cle(j) {
    const c = j.cleTemporal || "", n = j.ferie || "";
    if (j.temps === "avent") {
      const [, m, d] = j.date.split("-").map(Number);
      return j.jourSemaine !== 0 && m === 12 && d >= 17 ? `avent-12-${String(d).padStart(2, "0")}` : `avent-${j.semaine}-${j.jourSemaine}`;
    }
    if (j.temps === "noel") {
      if (["noel", "sainte-famille", "marie-mere-de-dieu", "epiphanie", "bapteme", "noel-dimanche-2", "noel-12-29", "noel-12-30", "noel-12-31"].includes(c)) return c;
      return `noel-ferie-${j.jourSemaine}`;                                // féries de janvier
    }
    if (/^Ascension/.test(n)) return "ascension";
    if (j.temps === "careme" || j.temps === "semaine sainte" || j.temps === "triduum" || j.temps === "paques") return c;
    if (["trinite", "saint-sacrement", "sacre-coeur", "christ-roi"].includes(c)) return c;
    return `ordinaire-${j.semaine}`;                                         // la messe de la semaine, dimanche et féries
  }

  // signes de chant du Missel (* + /) en rouge, sans les confondre avec le texte
  const signes = (l) => esc(l).replace(/(^|\s)([RV])\/(?=\s)/g, "$1\u0000$2").replace(/\s*([*+/])(?=\s|$)/g, ' <span class="signe">$1</span>')
    .replace(/\u0000([RV])/g, '<span class="rv">$1/</span>');
  function texteMissel(sec) {
    return sec.texte.map((p) => {
      if (p.length === 1 && p[0].startsWith("§")) return rubrique(p[0].slice(1));
      if (p.length === 1 && /^Ou bien/.test(p[0])) return `<p class="ou-bien">ou bien${p[0].includes("—") ? ` <span class="ref">${esc(p[0].split("—")[1].trim())}</span>` : ""}</p>`;
      return `<p>${p.map((l) => /^R\/\.?\s/.test(l) ? `<span class="rv">R/</span> ${esc(l.replace(/^R\/\.?\s*/, ""))}` : signes(l)).join("<br>")}</p>`;
    }).join("");
  }

  const TITRES = { ouverture: "Antienne d’ouverture", priere: "Prière", offrandes: "Prière sur les offrandes", preface: "Préface",
    communion: "Antienne de la communion", apres: "Prière après la communion", peuple: "Prière sur le peuple", benediction: "Bénédiction solennelle" };
  function titreLecture(l, n) {
    const t = l.type || "";
    const ml = /^lecture_(\d+)/.exec(t);
    if (ml) { const k = +ml[1]; return ["", "Première lecture", "Deuxième lecture", "Troisième lecture", "Quatrième lecture", "Cinquième lecture", "Sixième lecture", "Septième lecture"][k] || `Lecture ${k}`; }
    if (/^psaume/.test(t)) return "Psaume";
    if (/^cantique/.test(t)) return "Cantique";
    if (t === "sequence") return "Séquence";
    if (t === "epitre") return "Épître";
    if (t === "evangile") return "Évangile";
    return t ? t.charAt(0).toUpperCase() + t.slice(1).replace(/_/g, " ") : `Lecture ${n}`;
  }

  // messe du Missel qui correspond à une messe de l'AELF (même nom : nuit, aurore, jour, veille…)
  const norm = (s) => String(s || "").normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase().replace(/[’']/g, " ");
  function apparier(nomAELF, messesMissel) {
    if (!messesMissel || !messesMissel.length) return null;
    if (messesMissel.length === 1) return messesMissel[0];
    const n = norm(nomAELF).replace(/veillee/g, "vigile");
    const mots = ["veille", "nuit", "aurore", "chrismale", "cene", "vigile", "matin"];
    const m = messesMissel.find((x) => mots.some((w) => n.includes(w) && norm(x.titre).includes(w)));
    if (m) return m;
    return messesMissel.find((x) => /du jour/.test(norm(x.titre))) || messesMissel[messesMissel.length - 1];
  }

  // Messes possibles ce jour (comme le choix d'office) : saints du Missel à cette date, et la messe de la férie
  // quand le jour l'admet (mémoire, mémoire facultative, férie). Par défaut : la célébration du calendrier.
  const mots = (s) => new Set(norm(s).replace(/\b(saint|sainte|saints|bienheureuse|vierge|marie|s|ste|ss)\b/g, " ").split(/[^a-z0-9]+/).filter((w) => w.length > 3));
  function proches(a, b) { const A = mots(a), B = mots(b); let n = 0; for (const w of A) if (B.has(w)) n++; return n; }
  function options(j, missel) {
    // un dimanche, une solennité ou une fête du temporal, un jour privilégié : pas de messe de saint
    const saintsAdmis = j.source !== "temporal" || j.niveau >= 9;
    // Missel de l'Ordre : ses messes de saints, en plus de celles du Missel romain ; un saint de l'Ordre sans aucun texte
    // propre (seulement une notice) ne fait pas une messe de plus : sa notice va à la messe romaine du même saint
    const op = (missel.op && missel.op.saints && missel.op.saints[j.date.slice(5)]) || [];
    let saints = saintsAdmis ? ((missel.saints && missel.saints[j.date.slice(5)]) || []).map((e) => ({ ...e })) : [];
    const deOP = [];
    for (const e of saintsAdmis ? op : []) {
      const rom = saints.find((x) => proches(x.titre, e.titre) > 0);
      const textes = e.messes && e.messes.some((m) => Object.keys(m).length);
      if (!textes) { if (rom && !rom.notice && e.notice) rom.notice = e.notice; else if (!rom) deOP.push({ ...e, source: "op" }); continue; }
      deOP.push({ ...e, source: "op", romain: rom || null });
    }
    const opts = [...deOP.map((e, i) => ({ cle: "op" + i, nom: e.titre, rang: rangOP(e.rang), saint: e })),
      ...saints.map((e, i) => ({ cle: "s" + i, nom: e.titre + (deOP.some((o) => o.romain && o.romain.titre === e.titre) ? " (Missel romain)" : ""), rang: e.rang ? e.rang.toLowerCase() : "", saint: e }))];
    const ferieAdmise = j.source === "temporal" || j.niveau >= 10;
    // le saint du calendrier, s'il est au Missel
    const noms = [j.source !== "temporal" ? j.nom : null, ...(j.facultatives || []).map((f) => f.nom)].filter(Boolean);
    let defaut = "ferie";
    if (j.source !== "temporal") {
      let mieux = null, score = 0;
      // à mots égaux, la messe de l'Ordre (avant celles du Missel romain dans la liste) l'emporte
      for (const o of opts) { const sc = proches(o.nom, j.nom); if (sc > score) { score = sc; mieux = o; } }
      defaut = mieux ? mieux.cle : opts.length === 1 ? opts[0].cle : "ferie";
    }
    const liste = [...opts];
    if (ferieAdmise || !opts.length) liste.push({ cle: "ferie", nom: j.niveau >= 9 || opts.length ? `Messe de la férie — ${j.ferie}` : j.ferie });
    if (!liste.some((o) => o.cle === defaut)) defaut = liste[0] ? liste[0].cle : "ferie";
    return { liste, defaut, noms };
  }

  const rangOP = (r) => (r === "mémoire" ? "mémoire obligatoire" : r || "");
  // Commun indiqué par le Missel pour un saint (« Commun des martyrs : pour une vierge martyre, ou … ») → premier formulaire
  // du cas le plus proche, au temps liturgique voulu (temps pascal ou non ; Avent, Noël, temps pascal pour la Vierge Marie)
  function commun(saint, j, missel) {
    if (!saint || !saint.commun) return null;
    // saint de l'Ordre : communs du Missel de l'Ordre (ils n'ont pas de prière : chaque saint a la sienne), sinon ceux du Missel romain
    const listeOP = saint.source === "op" && missel.op ? (missel.op.communs || []).map((c) => ({ commun: c.commun, partie: c.cas, cas: "", num: c.num, messe: c.messes[0], op: true })) : [];
    const liste = listeOP.length ? listeOP : missel.communs;
    if (!liste) return null;
    let premier = saint.commun.split(/,?\s+ou\s+(?=Commun)/i)[0].replace(/\s*\(?(missionnaires )?p\.[\s\d,]*(ou\s*(p\.)?\s*[\d,\s]+)*\)?/g, " ").replace(/\s+/g, " ").replace(/[\s,.;:]+$/, "");
    if (listeOP.length) premier = premier.replace(/^Commun d’un martyr/, "Commun des martyrs : pour un martyr").replace(/^Commun de plusieurs martyrs/, "Commun des martyrs : pour plusieurs martyrs")
      .replace(/^Commun des saintes? femmes/, "Commun des saints : pour les saintes femmes").replace(/^Commun des saint(e)?s (ayant exercé )?une activité caritative|^Commun des saints ayant exercé une activité caritative/, "Commun des saints : pour les saints ayant une activité caritative")
      .replace(/^Commun des vierges$/, "Commun des vierges : pour une vierge");
    const [tete, qualif = ""] = premier.split(/\s*:\s*/);
    // ici « vierge », « Marie » comptent (Commun de la bienheureuse Vierge Marie, Commun des vierges)
    const motsC = (x) => new Set(norm(x).split(/[^a-z0-9]+/).filter((w) => w.length > 3 && !["commun", "pour", "dans", "avec"].includes(w)));
    const motsT = motsC(tete), motsQ = motsC(qualif);
    const pascal = j.temps === "paques";
    let mieux = null, score = -1;
    for (const f of liste) {
      let sc = 0;
      for (const w of motsC(f.commun)) if (motsT.has(w)) sc += 10;
      if (sc === 0) continue;
      for (const w of motsC(`${f.partie || ""} ${f.cas || ""}`)) if (motsQ.has(w)) sc += 3;
      const part = norm(f.partie || "");
      if (/pascal/.test(part)) sc += pascal ? (/hors/.test(part) ? -2 : 2) : (/hors/.test(part) ? 2 : -2);
      if (/avent/.test(part)) sc += j.temps === "avent" ? 3 : -3;
      if (/noel/.test(part)) sc += j.temps === "noel" ? 3 : -3;
      if (/ordinaire/.test(part)) sc += ["ordinaire", "careme"].includes(j.temps) ? 1 : -1;
      if (f.num && f.num !== "1") sc -= 0.5;                       // le premier formulaire du cas
      if (sc > score) { score = sc; mieux = f; }
    }
    if (!mieux) return null;
    const lib = [mieux.commun + (mieux.op ? " (Missel de l’Ordre)" : ""), mieux.partie && mieux.partie.toLowerCase(), mieux.cas && mieux.cas.toLowerCase(), mieux.num && `formulaire ${mieux.num}`].filter(Boolean).join(" — ");
    return { messe: mieux.messe, libelle: lib };
  }

  // Gloria et Credo : selon le Missel (dimanches hors Avent et Carême, solennités, fêtes ; Credo : dimanches et solennités)
  function gloriaCredo(j, saint, duCalendrier) {
    if (duCalendrier) saint = null;                               // le rang du calendrier (propre OP compris) fait foi
    const k = cle(j), dim = j.jourSemaine === 0;
    const penitent = ["avent", "careme", "semaine sainte", "triduum"].includes(j.temps);
    // solennités du temporal (les dimanches et les jours privilégiés ont un rang élevé sans être des solennités)
    const SOL = ["noel", "marie-mere-de-dieu", "epiphanie", "paques-1-0", "ascension", "paques-8-0", "trinite", "saint-sacrement", "sacre-coeur", "christ-roi"];
    const octave = (j.temps === "paques" && j.semaine === 1) || /^noel-12-(2\d|3[01])$/.test(k);
    let solennite, fete;
    if (saint) { const r = norm(saint.rang || ""); solennite = /solennite/.test(r); fete = /fete/.test(r); }
    else if (j.source !== "temporal") { const r = norm(j.rang || ""); solennite = /solennite/.test(r); fete = /fete/.test(r); }
    else { solennite = SOL.includes(k); fete = ["sainte-famille", "bapteme"].includes(k) || /Présentation du Seigneur|Transfiguration|Croix glorieuse/.test(j.nom); }
    if (/defunts/.test(norm(j.nom)) || (saint && /defunts/.test(norm(saint.titre || "")))) return { gloria: false, credo: false };
    return {
      gloria: (dim && !penitent) || solennite || fete || octave || k === "careme-6-4",
      credo: dim || (solennite && !(octave && !dim)),
    };
  }
  function ordinaire(o, titre) {
    const fr = o.fr.map((b) => `<p>${b.map((l) => l.startsWith("§") ? `<span class="rubrique-ligne">${esc(l.slice(1))}</span>` : esc(l)).join("<br>")}</p>`).join("");
    const la = o.la.map((b) => `<p>${b.map((l) => l.startsWith("§") ? `<span class="rubrique-ligne">${esc(l.slice(1))}</span>` : esc(l)).join("<br>")}</p>`).join("");
    return `${fr}<details class="autres-hymnes"><summary>En latin</summary><div class="latin">${la}</div></details>`;
  }


  // Livrets du Triduum et Passion à plusieurs voix : rendu suivi (sections numérotées, consignes en rouge, rôles)
  const ROLES = { L: "Lecteur", D: "Disciples", F: "Foule", A: "Autres", "✠": "Jésus", X: "Jésus" };
  function lignesLivret(ls) {
    return ls.map((l) => {
      const m = /^([RV])\/\s*\t?\s*(.*)$/.exec(l);
      return m ? `<span class="rv">${m[1]}/</span> ${signes(m[2])}` : signes(l.replace(/\t+/g, " "));
    }).join("<br>");
  }
  // ── Partitions de la Veillée pascale (livret de Sainte-Baume, donnees/sainte_baume.json > vigile), repliées sous la
  // section du Missel qui leur correspond ; les images sont lues dans l'entrepôt comme sur la page des offices
  const ENTREPOT = (typeof document !== "undefined" && document.querySelector('meta[name="fichiers"]')?.content) || "";
  const CLE_PAGE = (typeof document !== "undefined" && document.querySelector('meta[name="fichiers-cle"]')?.content) || "";
  const imagePartition = (f) => { const k = (typeof window !== "undefined" && window.CLE_FICHIERS) || CLE_PAGE; return `${ENTREPOT}partitions/${f}${ENTREPOT && k ? "?" + k : ""}`; };
  const VIGILE_SECTIONS = [[/Allumage du feu/, /^Bénédiction du feu/], [/Allumage et procession|Entrée du Cierge/, /^Procession/], [/Encensement|Exsultet/, /^Annonce de Pâques/],
    [/Gn 1$/, /^Première lecture/], [/Gn 22/, /^Deuxième lecture/], [/Ex 14/, /^Troisième lecture/], [/Is 54/, /^Quatrième lecture/], [/Is 55/, /^Cinquième lecture/],
    [/Ba 3/, /^Sixième lecture/], [/Ez 37/, /^Septième lecture/], [/Rm 6/, /^Alléluia/], [/Aspersion/, /^Aspersion/]];
  function chantsVigile(sb) {
    const par = {}, fin = [];
    for (const s of sb || []) {
      const m = VIGILE_SECTIONS.find(([re]) => re.test(s.section));
      const communion = (e) => /communions-/.test(e.f || "");
      const corps = (els) => els.map((e) => e.f ? `<img loading="lazy" src="${esc(imagePartition(e.f))}" alt="Partition : ${esc(s.section)}">` : `<p class="rubrique">${esc(e.rubrique)}</p>`).join("");
      const plie = (titre, els) => `<details class="partition-pliee"><summary>Partition <span class="legende">— ${esc(titre)} (livret de Sainte-Baume)</span></summary><figure class="partition-piece">${corps(els)}</figure></details>`;
      const els = s.elements.filter((e) => !communion(e)), com = s.elements.filter(communion);
      if (m && els.length) { const k = m[1].source; par[k] = (par[k] || "") + plie(s.section, els); }
      else if (els.length) fin.push(plie(s.section, els));
      if (com.length) fin.push(plie("Communion", com));
    }
    return { pour: (titre) => Object.entries(par).filter(([re]) => new RegExp(re).test(titre)).map(([, h]) => h).join(""), fin: fin.join("") };
  }
  function livret(blocs, bloc, prefixe, chants = null) {
    let h = "", notes = "", ouvert = null;
    const fermer = () => { if (ouvert !== null) { h += bloc(ouvert.id, ouvert.titre, ouvert.html + (chants ? chants.pour(ouvert.titre) : ""), "livret", { ref: ouvert.ref }); ouvert = null; } };
    let avantSection = true;
    let n = 0;
    for (const b of blocs) {
      let x = "";
      if (b.type === "rubrique") x = rubrique(b.texte);
      else if (b.type === "intertitre") x = `<h4>${esc(b.texte)}</h4>`;
      else if (b.type === "trait") x = `<hr class="trait">`;
      else if (b.type === "texte") x = `<p${b.gras ? ' class="fort"' : ""}>${lignesLivret(b.lignes)}</p>`;
      else if (b.type === "role") x = `<p class="role-passion"><span class="sigle" title="${esc(ROLES[b.role] || "")}">${esc(b.role === "X" ? "✠" : b.role)}</span> ${lignesLivret(b.lignes)}</p>`;
      if (b.type === "section") { fermer(); avantSection = false; ouvert = { id: `${prefixe}-${++n}`, titre: b.titre, ref: b.ref, html: "" }; continue; }
      // en tête du livret, les titres (« Jeudi saint », « Messe du soir… ») répètent l'en-tête : seules les parties restent
      if (avantSection && (b.type === "intertitre" || b.type === "texte") && !/^(Rites|Première partie|Deuxième partie|Troisième partie|Quatrième partie|Liturgie|Ouverture|Célébration)/.test(b.texte || (b.lignes || [])[0] || "")) continue;
      if (b.type === "intertitre" && /^(Rites|Première partie|Deuxième partie|Troisième partie|Quatrième partie|Liturgie d|Ouverture|Célébration)/.test(b.texte)) x = `<h4 class="partie">${esc(b.texte)}</h4>`;
      if (ouvert) ouvert.html += x;
      else if (b.notes && b.type === "rubrique") notes += x;                  // notes générales du début : repliées
      else h += x;
    }
    fermer();
    if (chants?.fin) h += bloc(`${prefixe}-chants`, "Autres chants (livret de Sainte-Baume)", chants.fin, "livret");
    return grouper((notes ? `<details class="autres-hymnes notes-livret"><summary>Notes préliminaires du Missel</summary>${notes}</details>` : "") + h);
  }
  // une rubrique : « Ou bien » devient un séparateur ; une longue consigne se replie sur sa première phrase
  function rubrique(t) {
    if (/^ou( bien)?\s*:?$/i.test(t.trim())) return `<p class="ou-bien">ou bien</p>`;
    if (t.length > 260) {
      const m = /^(.{40,180}?[.;:])\s/.exec(t);
      if (m) return `<details class="rubrique longue"><summary>${esc(m[1])}</summary><p>${esc(t.slice(m[1].length).trim())}</p></details>`;
    }
    return `<p class="rubrique">${esc(t)}</p>`;
  }
  // rubriques consécutives : un seul bloc, sous un filet rouge
  const grouper = (h) => h.replace(/(?:(?:<p class="rubrique">[\s\S]*?<\/p>|<details class="rubrique longue">[\s\S]*?<\/details>)\s*)+/g, (m) => `<div class="rubriques">${m}</div>`);
  function finMesse(notes) {
    return notes.length ? `<aside class="notes-messe"><p class="titre-notes">Notes</p>${notes.map((n) => `<p>${esc(n)}</p>`).join("")}</aside>` : "";
  }
  const LIVRETS = [["cene", /c[eè]ne/i], ["passion", /passion du seigneur/i], ["vigile", /veill[ée]e|vigile/i]];

  // ── Lectionnaire de l'Ordre (donnees/missel_op.json > lectures) : la célébration du même jour, même saint
  function lecturesOP(saint, j, missel) {
    const L = (missel.op && missel.op.lectures && missel.op.lectures[j.date.slice(5)]) || [];
    return L.find((e) => proches(e.titre, saint.titre) > 0) || (L.length === 1 && proches(L[0].titre, saint.titre) >= 0 && /Anniversaire/.test(saint.titre) === /Anniversaire/.test(L[0].titre) ? L[0] : null);
  }
  function lectionnaireOP(E, bloc) {
    // une lecture et ses « ou bien » forment un seul bloc ; plusieurs couples acclamation + évangile (Rosaire) : un bloc chacun
    const groupes = [];
    for (const l of E.lectures) {
      const g0 = groupes[groupes.length - 1];
      if (l.ou && g0 && g0.type === l.type) g0.items.push(l);
      else groupes.push({ type: l.type, titre: l.titre, items: [l] });
    }
    let h = "", n = 0;
    for (const gr of groupes) {
      const corps = gr.items.map((l, i) => {
        let x = i ? `<p class="ou-bien">ou bien${l.ref ? ` <span class="ref">${esc(l.ref)}</span>` : ""}</p>` : "";
        if (l.refrain) x += `<div class="antienne"><span class="rubrique">R/</span> ${esc(l.refrain)}</div>`;
        if (l.intro) x += `<p class="intro-lue">${l.type === "evangile" ? "✠ " : ""}${esc(l.intro)}</p>`;
        if (l.sous) x += `<p class="titre-lecture">${esc(l.sous)}</p>`;
        const cl = l.type === "psaume" || l.type === "cantique" || l.type === "alleluia" || l.type === "sequence" ? "psaume-messe" : "lecture";
        x += `<div class="${cl}">${texteMissel({ texte: l.texte })}</div>`;
        return x;
      }).join("");
      const r0 = gr.items[0].ref;
      h += bloc(`lop-${n++}`, gr.titre, corps, "op lecture-messe", { ref: r0, source: "Lectionnaire de l’Ordre" });
    }
    return h;
  }

  function construire(j, aelf, missel, choix, opts = {}) {
    const k = cle(j);
    const propres = missel.cles[k] || null;
    // l'AELF met parfois une simple note à la place d'une messe (Samedi saint) : elle va dans les avertissements
    const toutes = aelf && aelf.messes ? aelf.messes : [];
    const messesAELF = toutes.filter((m) => m.lectures && m.lectures.length);
    const notesAELF = toutes.filter((m) => !(m.lectures && m.lectures.length)).map((m) => m.nom);
    // liste des messes du jour : celles de l'AELF ; à défaut, celles du Missel
    const noms = messesAELF.length ? messesAELF.map((m) => m.nom) : (propres || []).map((m, i) => m.titre || (i ? `Messe ${i + 1}` : "Messe du jour"));
    const O = options(j, missel);
    const choixMesse = O.liste.some((o) => o.cle === opts.messe) ? opts.messe : O.defaut;
    const saint = (O.liste.find((o) => o.cle === choixMesse) || {}).saint || null;
    // plusieurs messes au Missel pour le saint (2 novembre) quand l'AELF n'en donne qu'une : onglets du Missel
    let nomsM = noms;
    if (saint && saint.messes.length > 1 && messesAELF.length <= 1) nomsM = saint.messes.map((m, n) => m.titre || `Messe ${n + 1}`);
    const i = Math.min(Math.max(choix || 0, 0), Math.max(nomsM.length - 1, 0));
    const ma = (nomsM === noms ? messesAELF[i] : messesAELF[0]) || null;
    const mm = ma && nomsM === noms ? apparier(ma.nom, propres) : (propres ? propres[Math.min(i, propres.length - 1)] : null);
    const ms = saint ? (nomsM !== noms ? saint.messes[i] : ma ? apparier(ma.nom, saint.messes) : saint.messes[0]) : null;
    const pris = [];                                                 // pièces prises à la férie faute de propre du saint
    const cm = saint ? commun(saint, j, missel) : null;
    const duCommun = [];
    const sections = [];
    // titre de section ; à droite, en petit : la référence et la provenance (« commun », « férie »)
    const bloc = (id, titre, contenu, extra = "", meta = {}) => {
      if (vide(contenu)) return "";
      sections.push({ id, titre });
      const m = [meta.ref ? `<span class="ref">${esc(meta.ref)}</span>` : "", meta.source ? `<span class="provenance">${esc(meta.source)}</span>` : ""].join("");
      return `<section class="bloc ${extra}" id="${id}"><h3><span class="titre-section">${esc(titre)}</span>${m ? `<span class="meta">${m}</span>` : ""}</h3>${contenu}</section>`;
    };
    const propreSec = (s) => {
      let src = ms && ms[s] ? ms[s] : null, ferie = false, com = false;
      if (!src && cm && cm.messe[s]) { src = cm.messe[s]; com = true; }
      if (!src && mm && mm[s] && !(ms && s === "peuple")) { src = mm[s]; ferie = !!ms; }
      if (s === "benediction" && !src) return "";
      if (!src) return "";
      if (ferie) pris.push(TITRES[s].toLowerCase());
      if (com) duCommun.push(TITRES[s].toLowerCase());
      return bloc(`m-${s}`, TITRES[s], texteMissel(src), "missel", { ref: src.ref, source: ferie ? "de la férie" : com ? "du commun" : "" });
    };
    const menu = O.liste.length > 1 ? `<p class="choix-office no-print"><label>Messe : <select data-choix-messe="${esc(j.date)}">${O.liste.map((o) =>
      `<option value="${o.cle}"${o.cle === choixMesse ? " selected" : ""}>${esc(o.nom)}${o.rang ? " (" + esc(o.rang) + ")" : ""}</option>`).join("")}</select></label></p>` : "";
    const nomJour = saint ? saint.titre : (choixMesse === "ferie" && j.source !== "temporal" ? j.ferie : j.nom);
    const rangJour = saint ? (saint.rang || "").toLowerCase() : j.source !== "temporal" && choixMesse === "ferie" ? "" : j.rang;

    let h = `<header class="entete-office couleur-${esc(j.couleur || "vert")}">
      <p class="date-longue">${esc(j.dateLongue)}</p>
      <h2>Messe</h2>
      <p class="celebration">${esc(nomJour)}${rangJour && !["férie", "dimanche"].includes(rangJour) ? ` <span class="rang">${esc(rangJour)}</span>` : ""}</p>
      ${nomJour !== j.ferie ? `<p class="ferie">${esc(j.ferie)}</p>` : ""}
      ${menu}
      <p class="psautier-semaine">${j.jourSemaine === 0 || j.niveau <= 4 ? `Année ${esc(j.cycle)}` : `Année ${j.pair ? "paire" : "impaire"}`}${nomsM.length > 1 ? ` · ${esc(joli(nomsM[i]))}` : ""}</p>
    </header>`;
    if (saint && saint.notice) h += `<details class="notice-saint"><summary>Notice</summary><p>${esc(saint.notice).replace(/\n/g, "</p><p>")}</p></details>`;
    if (saint && saint.rubriques && saint.rubriques.length) h += grouper(saint.rubriques.map(rubrique).join(""));
    const avert = [];
    if (!propres && !notesAELF.length) avert.push("Pas de textes du Missel pour ce jour dans les fichiers reçus.");
    if (opts.source && opts.source !== j.date) avert.push(`Lectures de l'AELF prises au même jour liturgique en ${opts.source.slice(0, 4)} (l'AELF ne publie pas encore cette date).`);
    avert.push(...notesAELF);
    if (!ma && !notesAELF.length) avert.push("Lectures de l'AELF indisponibles (pas de réseau, ou date non publiée).");
    const notes = [...avert];                                        // affichées en fin de messe (« Notes »)
    if (!ma && !notesAELF.length) h += `<p class="manque">${esc(avert[avert.length - 1])}</p>`;
    if (notesAELF.length) h += notesAELF.map((t) => `<p class="manque">${esc(t)}</p>`).join("");

    const gc = gloriaCredo(j, saint, saint && choixMesse === O.defaut && j.source !== "temporal");
    const ord = missel.ordinaire || null;
    // Cène, Passion du Seigneur, Vigile pascale : le livret « Missel et lectionnaire » entier
    const lv = ma && missel.livrets ? LIVRETS.find(([, re]) => re.test(ma.nom)) : null;
    if (lv && missel.livrets[lv[0]] && !(lv[0] === "passion" && /^Messe de la Passion/i.test(ma.nom))) {
      h += livret(missel.livrets[lv[0]], bloc, lv[0], lv[0] === "vigile" && missel.chantsVigile?.length && !opts.sansPartitions ? chantsVigile(missel.chantsVigile) : null);
      h += finMesse([...notes, "Livret « Missel et lectionnaire » (AELF, 2014) : rites, prières et lectures de la célébration."]);
      return { html: h, messes: nomsM, choix: i, sections, cle: k, choixMesse };
    }
    h += propreSec("ouverture");
    if (gc.gloria && ord) h += bloc("m-gloria", "Gloire à Dieu", ordinaire(ord.gloria), "ordinaire");
    h += propreSec("priere");
    const LOP = saint && saint.source === "op" ? lecturesOP(saint, j, missel) : null;
    if (LOP) h += lectionnaireOP(LOP, bloc);
    if (ma && LOP) {
      // les lectures du jour (AELF), repliées
      let r = "";
      ma.lectures.forEach((l) => { if (!vide(l.contenu)) r += `<h4>${esc(titreLecture(l, 0))}${l.ref ? ` <span class="ref">${esc(l.ref)}</span>` : ""}</h4><div class="lecture">${propre(l.contenu)}</div>`; });
      h += `<details class="autres-hymnes lectures-aelf"><summary>Ou bien : lectures du jour (AELF)</summary>${r}</details>`;
    }
    if (ma && !LOP) ma.lectures.forEach((l, n) => {
      const id = `l-${n}`;
      if (/^psaume/.test(l.type || "")) {
        const refrain = vide(l.refrain_psalmique) ? "" : `<div class="antienne"><span class="rubrique">R/</span> ${propre(l.refrain_psalmique).replace(/^<p>|<\/p>$/g, "")}${l.ref_refrain ? ` <span class="ref">(${esc(l.ref_refrain)})</span>` : ""}</div>`;
        h += bloc(id, titreLecture(l, n), `${refrain}<div class="psaume-messe">${propre(l.contenu)}</div>`, "aelf", { ref: l.ref });
        return;
      }
      if (l.type === "evangile" && !vide(l.verset_evangile))
        h += bloc(`${id}-acc`, "Acclamation", `<div>${propre(l.verset_evangile)}</div>`, "aelf", { ref: l.ref_verset });
      h += bloc(id, titreLecture(l, n),
        `${l.intro_lue ? `<p class="intro-lue">${esc(l.intro_lue)}</p>` : ""}${l.titre ? `<p class="titre-lecture">${esc(String(l.titre).replace(/\s+/g, " "))}</p>` : ""}<div class="lecture">${propre(l.contenu)}</div>`
        , "aelf lecture-messe", { ref: l.ref });
      if (l.type === "evangile" && k === "careme-6-0" && missel.passions && missel.passions[j.cycle] && /passion/i.test(ma.nom) && !h.includes('id="passion-voix"'))
        h += `<details class="autres-hymnes passion-voix" id="passion-voix"><summary>La Passion à plusieurs voix (fascicule des lecteurs, année ${esc(j.cycle)})</summary>`
          + `<p class="rubrique">✠ = Jésus ; L = lecteur ; D = disciples et amis ; F = foule ; A = autres personnages.</p>`
          + livret(missel.passions[j.cycle], (id, titre, html) => html, "pv") + `</details>`;
    });
    if (gc.credo && ord) h += bloc("m-credo", "Profession de foi", ordinaire(ord.credo), "ordinaire");
    h += propreSec("offrandes");
    // préface : celle du saint (Missel de l'Ordre) ; à défaut, pour un saint ou un bienheureux de l'Ordre, la préface de l'Ordre
    if (ms && ms.preface) h += bloc("m-preface", "Préface", (ms.preface.sous ? `<p class="theme-preface">${esc(ms.preface.sous)}</p>` : "") + texteMissel(ms.preface), "missel", { source: "propre" });
    else if (saint && saint.source === "op" && missel.op && missel.op.preface && /^(Saint|Sainte|Saints|Bienheureu|Tous les Saints)/.test(saint.titre))
      h += `<details class="autres-hymnes preface-op" id="m-preface"><summary>Préface des saints de l’Ordre — ${esc(missel.op.preface.sous || "")}</summary>${texteMissel(missel.op.preface)}</details>`;
    // à l'écran seulement : la préface du temps et les prières eucharistiques, dans le Missel
    if (opts.renvois && missel.liturgie) {
      const I = index(missel), pr = I.find((c) => c.id === "prefaces"), pe = I.find((c) => c.id === "prieres-eucharistiques");
      const gr = pr && pr.groupes.find((x) => x.titre === renvois(j, saint).prefaces);
      const li = (cid, p, t) => `<a href="#missel/${cid}/${encodeURIComponent(p.id)}">${esc(t || p.titre.replace(/^Prière eucharistique /, "PE "))}</a>`;
      const peC = pe ? pe.groupes[0].pieces.filter((p) => /^Prière eucharistique/.test(p.titre)) : [];
      const propreP = pr ? prefacePropre(j, saint, pr.groupes.flatMap((x) => x.pieces)) : null;
      const court = (p) => (/^(\d+(?:re|e)) /.exec(p.titre) || [])[1] || p.titre;
      if (gr || peC.length) h += `<section class="bloc renvois-missel no-print" id="m-pe"><h3><span class="titre-section">Préface et prière eucharistique</span><span class="meta"><a href="#missel">Missel</a></span></h3>`
        + (propreP ? `<p><span class="lib">Préface propre :</span> ${li("prefaces", propreP)}${propreP.sous ? ` <span class="lib">(${esc(propreP.sous)})</span>` : ""}</p>` : "")
        + (gr ? `<p><span class="lib">${propreP ? "Autres préfaces" : "Préfaces"} · ${esc(gr.titre)} :</span> ${gr.pieces.map((p) => li("prefaces", p, court(p))).join(" · ")} · <a href="#missel/prefaces">toutes les préfaces</a></p>` : "")
        + (peC.length ? `<p><span class="lib">Prières eucharistiques :</span> ${peC.map((p) => li("prieres-eucharistiques", p)).join(" · ")}</p>` : "") + `</section>`;
    }
    h += propreSec("communion") + propreSec("apres") + propreSec("peuple") + propreSec("benediction");
    if (LOP) notes.push("Lectures : Lectionnaire de l’Ordre des Prêcheurs (édition provisoire, 2026).");
    if (saint && saint.source === "op") notes.push("Antiennes, prières, préface : Missel de l’Ordre des Prêcheurs (édition provisoire, 2026).");
    if (saint && duCommun.length) notes.unshift(`Du commun : ${cm.libelle.charAt(0).toLowerCase() + cm.libelle.slice(1)}.`);
    if (saint && pris.length) notes.push(`De la férie : ${pris.join(", ")} (pas de texte propre ni de commun).`);
    if (!LOP) notes.push(saint && saint.source === "op" ? "Lectures et psaume : AELF." : "Lectures et psaume : AELF. Antiennes et prières : Missel romain (fichiers de la Province).");
    h += finMesse(notes);
    return { html: h, messes: nomsM, choix: i, sections, cle: k, choixMesse };
  }

  // ── Le Missel à consulter (bouton « Missel ») : tous les textes, rangés comme dans le livre.
  //    Livre.index(missel) → [{id, titre, desc, groupes: [{titre, pieces: [{id, titre, sous?, rendu()}]}]}]
  //    Adresses : #missel, #missel/<chapitre>, #missel/<chapitre>/<pièce>.
  const JOURS_N = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"];
  const MOIS_N = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"];
  const ordM = (n) => n === 1 ? "1er" : `${n}e`, ordF = (n) => n === 1 ? "1re" : `${n}e`;
  const romainN = (n) => ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX",
    "XXI", "XXII", "XXIII", "XXIV", "XXV", "XXVI", "XXVII", "XXVIII", "XXIX", "XXX", "XXXI", "XXXII", "XXXIII", "XXXIV"][n] || String(n);
  const NOMS_FIXES = { noel: "Nativité du Seigneur", "sainte-famille": "La Sainte Famille", "marie-mere-de-dieu": "Sainte Marie, Mère de Dieu (1er janvier)",
    "noel-dimanche-2": "2e dimanche après la Nativité", epiphanie: "Épiphanie du Seigneur", bapteme: "Baptême du Seigneur",
    "careme-0-3": "Mercredi des Cendres", "careme-6-0": "Dimanche des Rameaux et de la Passion du Seigneur", "careme-6-4": "Jeudi saint",
    "careme-6-5": "Vendredi saint", "paques-1-0": "Dimanche de Pâques", "paques-2-0": "2e dimanche de Pâques (de la Divine Miséricorde)",
    ascension: "Ascension du Seigneur", "paques-8-0": "Dimanche de la Pentecôte", trinite: "La Sainte Trinité", "saint-sacrement": "Le Saint-Sacrement",
    "sacre-coeur": "Le Sacré-Cœur de Jésus", "christ-roi": "Le Christ, Roi de l’univers" };
  function nomTemporal(k) {
    if (NOMS_FIXES[k]) return NOMS_FIXES[k];
    let m = /^(avent|careme|paques)-(\d+)-(\d)$/.exec(k);
    if (m) {
      const s = +m[2], d = +m[3], T = { avent: "de l’Avent", careme: "du Carême", paques: "de Pâques" }[m[1]];
      if (m[1] === "careme" && s === 0) return `${JOURS_N[d]} après les Cendres`;
      if (m[1] === "careme" && s === 6) return `${JOURS_N[d]} saint`;
      if (m[1] === "paques" && s === 1) return `${JOURS_N[d]} dans l’octave de Pâques`;
      return d === 0 ? `${ordM(s)} dimanche ${T}` : `${JOURS_N[d]} de la ${ordF(s)} semaine ${T}`;
    }
    if ((m = /^avent-12-(\d+)$/.exec(k))) return `${+m[1]} décembre`;
    if ((m = /^noel-12-(\d+)$/.exec(k))) return `${+m[1]} décembre`;
    if ((m = /^noel-ferie-(\d)$/.exec(k))) return `${JOURS_N[+m[1]]} du temps de Noël (après l’Épiphanie)`;
    if ((m = /^ordinaire-(\d+)$/.exec(k))) return `${romainN(+m[1])}e semaine du Temps ordinaire`;
    return k;
  }
  // texte rendu → texte simple (recherche)
  const brut = (h) => String(h).replace(/<[^>]+>/g, " ").replace(/&nbsp;/g, " ").replace(/&amp;/g, "&").replace(/&lt;/g, "<").replace(/&gt;/g, ">").replace(/&quot;/g, '"').replace(/\s+/g, " ").trim();

  // pièce de l'Ordinaire (préface, prière eucharistique…) : paroles, réponses, consignes
  function blocsLiturgie(p) {
    let h = "";                                     // le thème de la préface (p.sous) est dans l'en-tête
    for (const b of p.blocs) {
      if (b.k === "rub") h += `<p class="rubrique">${b.h}</p>`;
      else if (b.k === "h") h += `<h4 class="intertitre-missel">${b.h}</h4>`;
      else if (b.k === "sous") h += `<p class="theme-preface">${b.h}</p>`;
      else if (b.k === "ou") h += `<p class="ou-bien">ou bien</p>`;
      else if (b.k === "peuple") h += `<p class="peuple">${b.h}</p>`;
      else if (b.k === "bas") h += `<p class="voix-basse">${b.h}</p>`;
      else h += `<p class="dit">${b.h}</p>`;
    }
    return `<div class="texte-missel">${grouper(h)}</div>`;
  }
  // formulaire de messe (propre du temps, saint, commun) : antiennes et prières dans l'ordre de la messe
  function formulaire(m) {
    let h = "";
    for (const s of ["ouverture", "priere", "offrandes", "communion", "apres", "peuple"]) {
      if (!m[s]) continue;
      h += `<section class="bloc missel"><h3><span class="titre-section">${esc(TITRES[s])}</span>${m[s].ref ? `<span class="meta"><span class="ref">${esc(m[s].ref)}</span></span>` : ""}</h3>${texteMissel(m[s])}</section>`;
    }
    return h;
  }
  function messes(liste, titreDefaut) {
    return liste.map((m, i) => (liste.length > 1 || m.titre ? `<h4 class="partie">${esc(m.titre || (i ? `Messe ${i + 1}` : titreDefaut))}</h4>` : "") + formulaire(m)).join("");
  }
  const livretSimple = (blocs, prefixe) => livret(blocs, (id, titre, html, extra, meta = {}) =>
    vide(html) ? "" : `<section class="bloc ${extra}" id="${id}"><h3><span class="titre-section">${esc(titre)}</span>${meta.ref ? `<span class="meta"><span class="ref">${esc(meta.ref)}</span></span>` : ""}</h3>${html}</section>`, prefixe);

  const cacheIndex = new WeakMap();
  function index(missel) {
    if (cacheIndex.has(missel)) return cacheIndex.get(missel);
    const L = missel.liturgie || [];
    const chap = (id) => L.find((c) => c.id === id);
    const deLiturgie = (c, desc) => c && {
      id: c.id, titre: c.titre, desc,
      groupes: c.groupes.map((gr) => ({ titre: gr.titre, pieces: gr.pieces.map((p) => ({ id: p.id, titre: p.titre, sous: p.sous, rendu: () => blocsLiturgie(p) })) })),
    };
    // Propre du temps : par temps liturgique, dans l'ordre de l'année
    const C = missel.cles || {};
    const TEMPS = [["Temps de l’Avent", /^avent-/], ["Temps de Noël", /^(noel|sainte-famille|marie-mere|epiphanie|bapteme)/], ["Temps du Carême", /^careme-[0-5]-/],
      ["Semaine sainte", /^careme-6-/], ["Temps pascal", /^(paques-|ascension)/], ["Temps ordinaire", /^ordinaire-/],
      ["Solennités du Seigneur au Temps ordinaire", /^(trinite|saint-sacrement|sacre-coeur|christ-roi)$/]];
    const temporal = TEMPS.map(([titre, re]) => ({ titre, pieces: Object.keys(C).filter((k) => re.test(k)).map((k) => ({
      id: k, titre: nomTemporal(k), rendu: () => messes(C[k], nomTemporal(k)) })) })).filter((gr) => gr.pieces.length);
    // Triduum pascal : livrets « Missel et lectionnaire » ; Passion à plusieurs voix
    const LV = missel.livrets || {}, PV = missel.passions || {};
    const triduum = [
      ...(LV.cene ? [{ id: "cene", titre: "Jeudi saint — Messe en mémoire de la Cène du Seigneur", rendu: () => livretSimple(LV.cene, "cene") }] : []),
      ...(LV.passion ? [{ id: "passion", titre: "Vendredi saint — Célébration de la Passion du Seigneur", rendu: () => livretSimple(LV.passion, "passion") }] : []),
      ...(LV.vigile ? [{ id: "vigile", titre: "Samedi saint — Veillée pascale", rendu: () => livretSimple(LV.vigile, "vigile") }] : []),
      ...[["A", "saint Matthieu"], ["B", "saint Marc"], ["C", "saint Luc"]].filter(([a]) => PV[a]).map(([a, ev]) => ({
        id: `passion-${a}`, titre: `La Passion selon ${ev} (Rameaux, année ${a})`, sous: "à plusieurs voix",
        rendu: () => `<p class="rubrique">✠ = Jésus ; L = lecteur ; D = disciples et amis ; F = foule ; A = autres personnages.</p>` + livretSimple(PV[a], `pv${a}`) })),
    ];
    if (triduum.length) temporal.splice(4, 0, { titre: "Triduum pascal", pieces: triduum });
    // Propre des saints : par mois
    const S = missel.saints || {};
    const parMois = MOIS_N.map((nom, i) => ({ titre: nom.charAt(0).toUpperCase() + nom.slice(1), pieces: [] }));
    for (const d of Object.keys(S).sort()) {
      const [mm, jj] = d.split("-").map(Number);
      S[d].forEach((s, i) => parMois[mm - 1].pieces.push({
        id: `${d}-${i + 1}`, titre: s.titre, date: `${jj === 1 ? "1er" : jj} ${MOIS_N[mm - 1]}`,
        sous: [s.rang, s.source === "France" ? "propre de France" : ""].filter(Boolean).join(" · "),
        rendu: () => (s.notice ? `<p class="notice-missel">${esc(s.notice)}</p>` : "")
          + (s.commun ? `<p class="rubrique renvoi-commun">${esc(s.commun.replace(/,?\s*p\.\s*$/, ""))} — <a href="#missel/communs">voir les communs</a></p>` : "")
          + messes(s.messes, s.titre)
          + (s.messes.every((m) => Object.keys(m).length <= 2) ? `<p class="manque">Seule la prière est propre ; le reste se prend au commun ou à la férie.</p>` : ""),
      }));
    }
    // Communs : par commun, puis temps / cas / formulaire
    const com = [];
    (missel.communs || []).forEach((f, i) => {
      let gr = com.find((x) => x.titre === f.commun);
      if (!gr) com.push(gr = { titre: f.commun, pieces: [] });
      const t = [f.partie, f.cas, f.num && `formulaire ${f.num}`].filter(Boolean).join(" — ") || f.commun;
      gr.pieces.push({ id: `c${i + 1}`, titre: t.charAt(0).toUpperCase() + t.slice(1), rendu: () => formulaire(f.messe) });
    });
    const ord = missel.ordinaire;
    const o = deLiturgie(chap("ordinaire"), "Rites initiaux, liturgie de la Parole, liturgie eucharistique, communion, conclusion.");
    if (o && ord) o.groupes.push({ titre: "En latin", pieces: [
      { id: "gloria-latin", titre: "Gloria in excelsis", sous: "latin et français", rendu: () => ordinaireBilingue(ord.gloria) },
      { id: "credo-latin", titre: "Credo", sous: "latin et français", rendu: () => ordinaireBilingue(ord.credo) }] });
    const r = [
      o,
      deLiturgie(chap("prefaces"), "Toutes les préfaces du Missel, par temps et par fête."),
      deLiturgie(chap("prieres-eucharistiques"), "Canon romain, prières II à IV, pour la réconciliation, pour des circonstances particulières."),
      { id: "temps", titre: "Propre du temps", desc: "Antiennes et prières de chaque jour, de l’Avent au Christ Roi ; livrets du Triduum.", groupes: temporal },
      { id: "saints", titre: "Propre des saints", desc: "Messes des saints, jour par jour (Missel romain et propre de France).", groupes: parMois.filter((gr) => gr.pieces.length) },
      { id: "communs", titre: "Communs", desc: "Vierge Marie, martyrs, pasteurs, docteurs, vierges, saints et saintes, dédicace.", groupes: com },
      deLiturgie(chap("benedictions"), "Bénédictions solennelles de fin de messe et prières sur le peuple."),
    ].filter(Boolean);
    cacheIndex.set(missel, r);
    return r;
  }
  function ordinaireBilingue(o) {
    const col = (b) => b.map((x) => `<p>${x.map((l) => l.startsWith("§") ? `<span class="rubrique-ligne">${esc(l.slice(1))}</span>` : esc(l)).join("<br>")}</p>`).join("");
    return `<div class="bilingue-missel"><div lang="la">${col(o.la)}</div><div>${col(o.fr)}</div></div>`;
  }
  function trouver(missel, cid, pid, I = index(missel)) {
    const c = I.find((x) => x.id === cid) || null;
    if (!c || !pid) return { c, p: null };
    const toutes = c.groupes.flatMap((gr) => gr.pieces.map((p) => ({ ...p, groupe: gr.titre })));
    const n = toutes.findIndex((p) => p.id === pid);
    return { c, p: n >= 0 ? toutes[n] : null, prec: toutes[n - 1] || null, suiv: toutes[n + 1] || null };
  }
  // recherche dans tous les textes (titres d'abord)
  const pleins = new WeakMap();
  function chercher(missel, q, I = index(missel)) {
    const n = (s) => norm(s).replace(/[^a-z0-9 ]+/g, " ").replace(/\s+/g, " ").trim();
    const mots = n(q).split(" ").filter((w) => w.length > 1);
    if (!mots.length) return [];
    let plein = pleins.get(I);
    if (!plein) {
      plein = { liste: [] }; pleins.set(I, plein);
      for (const c of I) for (const gr of c.groupes) for (const p of gr.pieces)
        plein.liste.push({ c, gr, p, titre: n(`${p.titre} ${p.sous || ""} ${p.date || ""} ${gr.titre}`), texte: null });
    }
    const out = [];
    for (const x of plein.liste) {
      if (x.texte === null) x.texte = n(brut(x.p.rendu()));
      const dansTitre = mots.every((w) => x.titre.includes(w));
      if (!dansTitre && !mots.every((w) => x.texte.includes(w) || x.titre.includes(w))) continue;
      let extrait = "";
      if (!dansTitre) {
        const t = brut(x.p.rendu()), tn = norm(t);
        let i = tn.indexOf(norm(q).trim());
        if (i < 0) i = tn.indexOf(norm(q).trim().split(/\s+/)[0]);
        if (i >= 0) extrait = (i > 40 ? "…" : "") + t.slice(Math.max(0, i - 40), i + 110) + "…";
      }
      const phrase = n(q);
      out.push({ ...x, score: dansTitre ? 0 : x.texte.includes(phrase) ? 1 : 2, extrait });
    }
    return out.sort((a, b) => a.score - b.score).slice(0, 80);
  }
  // une vue du Missel → { html, titre, sommaire: [{href, titre, actif}] }
  function vueLivre(missel, chemin, q, livre = null) {
    const B = livre || { base: "missel", nom: "Missel romain", court: "Missel", I: index(missel),
      accueil: "Tous les textes du Missel, rangés comme dans le livre",
      source: "Missel romain (nouvelle traduction, 2021) : fichiers de la Province (temporal, propre des saints, propre de France, communs, liturgie de la messe, livrets du Triduum)." };
    const I = B.I;
    const [cid, pid] = (chemin || "").split("/").filter(Boolean);
    const lien = (c, p) => `#${B.base}${c ? "/" + c : ""}${p ? "/" + encodeURIComponent(p) : ""}`;
    const som = I.map((c) => ({ href: lien(c.id), titre: c.titre, actif: c.id === cid }));
    const ariane = (morceaux) => `<nav class="ariane-missel no-print" aria-label="Fil d’Ariane"><a href="${lien()}">${esc(B.court)}</a>${morceaux.map(([t, h]) => ` › ${h ? `<a href="${h}">${esc(t)}</a>` : `<span>${esc(t)}</span>`}`).join("")}</nav>`;
    const entete = (titre, sous, extra = "") => `<header class="entete-office entete-missel${B.base === "missel-op" ? " entete-missel-op" : ""}"><p class="date-longue">${esc(B.nom)}</p><h2>${esc(titre)}</h2>${sous ? `<p class="celebration">${esc(sous)}</p>` : ""}${extra}</header>`;
    const recherche = `<form class="recherche-missel no-print" role="search" data-recherche-missel><input type="search" name="q" value="${esc(q || "")}" placeholder="Chercher dans le ${esc(B.court)} (titre ou mots du texte)" aria-label="Chercher dans le ${esc(B.court)}"><button class="bouton" type="submit">Chercher</button></form>`;
    if (q) {
      const R = chercher(missel, q, I);
      return { titre: `${B.court} — « ${q} »`, sommaire: som, html: ariane([[`Recherche « ${q} »`]]) + entete("Recherche", `${R.length} résultat${R.length > 1 ? "s" : ""}${R.length === 80 ? " (les 80 premiers)" : ""}`) + recherche
        + `<ol class="liste-missel resultats-missel">${R.map((x) => `<li><a href="${lien(x.c.id, x.p.id)}"><span class="t">${esc(x.p.date ? x.p.date + " — " : "")}${esc(x.p.titre)}</span>`
          + `<span class="ou">${esc(x.c.titre)}${x.gr.titre ? " › " + esc(x.gr.titre) : ""}</span>${x.extrait ? `<span class="extrait">${esc(x.extrait)}</span>` : ""}</a></li>`).join("")}</ol>` };
    }
    const T = trouver(missel, cid, pid, I);
    if (!T.c) {
      return { titre: B.nom, sommaire: som, html: entete(B.nom, B.accueil) + recherche
        + `<div class="cartes-missel">${I.map((c) => { const n = c.groupes.reduce((s, gr) => s + gr.pieces.length, 0);
          return `<a class="carte-missel" href="${lien(c.id)}"><span class="t">${esc(c.titre)}</span><span class="d">${esc(c.desc || "")}</span><span class="n">${n} texte${n > 1 ? "s" : ""}</span></a>`; }).join("")}</div>`
        + `<p class="notes-messe">${esc(B.source)}</p>` };
    }
    if (!T.p) {
      const c = T.c;
      return { titre: `${B.court} — ${c.titre}`, sommaire: som, html: ariane([[c.titre]]) + entete(c.titre, c.desc) + recherche
        + (c.groupes.length > 4 ? `<nav class="groupes-missel no-print">${c.groupes.map((gr, i) => `<a href="#gm-${i}" data-ancre>${esc(gr.titre || c.titre)}</a>`).join("")}</nav>` : "")
        + c.groupes.map((gr, i) => `<section class="groupe-missel" id="gm-${i}">${gr.titre ? `<h3 class="titre-groupe">${esc(gr.titre)}</h3>` : ""}<ol class="liste-missel">${gr.pieces.map((p) =>
          `<li><a href="${lien(c.id, p.id)}">${p.date ? `<span class="date">${esc(p.date)}</span>` : ""}<span class="t">${esc(p.titre)}</span>${p.sous ? `<span class="s">${esc(p.sous)}</span>` : ""}</a></li>`).join("")}</ol></section>`).join("") };
    }
    const { c, p, prec, suiv } = T;
    const pager = `<nav class="pages-missel no-print">${prec ? `<a href="${lien(c.id, prec.id)}" rel="prev">‹ ${esc(prec.titre)}</a>` : "<span></span>"}${suiv ? `<a href="${lien(c.id, suiv.id)}" rel="next">${esc(suiv.titre)} ›</a>` : "<span></span>"}</nav>`;
    return { titre: `${p.titre} — ${B.court}`, sommaire: som, piece: true,
      html: ariane([[c.titre, lien(c.id)], ...(p.groupe && p.groupe !== c.titre ? [[p.groupe, lien(c.id)]] : []), [p.titre]])
        + entete(p.titre, [p.date, p.sous].filter(Boolean).join(" · "), `<p class="psautier-semaine">${esc(c.titre)}${p.groupe ? " · " + esc(p.groupe) : ""}</p>`)
        + `<p class="outils-missel no-print"><button class="bouton" type="button" data-imprimer-missel>Imprimer ce texte</button></p>`
        + `<article class="piece-missel">${p.rendu()}</article>` + pager };
  }
  // ── Le Missel de l'Ordre à consulter (bouton « Missel OP ») : calendrier, préface de l'Ordre, propre des saints (avec les
  //    lectures du Lectionnaire de l'Ordre), messe votive, communs. Adresses : #missel-op, #missel-op/<chapitre>/<pièce>.
  const cacheOP = new WeakMap();
  const RANGS_OP = { "solennité": "Solennité", "fête": "Fête", "mémoire": "Mémoire obligatoire", "mémoire facultative": "Mémoire facultative" };
  function formulaireOP(m) {
    let h = "";
    for (const s of ["ouverture", "priere", "offrandes", "preface", "communion", "apres", "peuple", "benediction"]) {
      if (!m[s]) continue;
      h += `<section class="bloc missel"><h3><span class="titre-section">${esc(TITRES[s])}</span>${m[s].ref ? `<span class="meta"><span class="ref">${esc(m[s].ref)}</span></span>` : ""}</h3>`
        + (m[s].sous ? `<p class="theme-preface">${esc(m[s].sous)}</p>` : "") + `${texteMissel(m[s])}</section>`;
    }
    return h;
  }
  function pieceSaintOP(s, L) {
    let h = s.notice ? `<p class="notice-missel">${esc(s.notice).replace(/\n/g, "</p><p class=\"notice-missel\">")}</p>` : "";
    if (s.rubriques && s.rubriques.length) h += grouper(s.rubriques.map(rubrique).join(""));
    if (s.commun) h += `<p class="rubrique renvoi-commun">${esc(s.commun.replace(/\s*\(p\.[^)]*\)/g, ""))} — <a href="#missel-op/communs">voir les communs</a></p>`;
    h += s.messes.map(formulaireOP).join("");
    if (!s.messes.length) h += `<p class="manque">L’édition provisoire du Missel de l’Ordre ne donne pas encore de textes pour cette célébration.</p>`;
    else if (s.messes.every((m) => Object.keys(m).length <= 1)) h += `<p class="manque">Seule la prière est propre ; le reste se prend au commun.</p>`;
    if (L) h += `<h4 class="partie">Lectures (Lectionnaire de l’Ordre)</h4>` + lectionnaireOP(L, (id, titre, contenu, extra, meta = {}) => vide(contenu) ? "" :
      `<section class="bloc ${extra}"><h3><span class="titre-section">${esc(titre)}</span>${meta.ref ? `<span class="meta"><span class="ref">${esc(meta.ref)}</span></span>` : ""}</h3>${contenu}</section>`);
    return h;
  }
  function indexOP(missel) {
    const D = missel.op;
    if (!D) return [];
    if (cacheOP.has(D)) return cacheOP.get(D);
    const S = D.saints || {}, LE = D.lectures || {};
    const jour = (d) => { const [mm, jj] = d.split("-").map(Number); return `${jj === 1 ? "1er" : jj} ${MOIS_N[mm - 1]}`; };
    const lect = (d, s) => (LE[d] || []).find((e) => proches(e.titre, s.titre) > 0) || null;
    // calendrier : un mois par page
    const cal = MOIS_N.map((nom, i) => ({ titre: nom.charAt(0).toUpperCase() + nom.slice(1), pieces: [] }));
    const parMoisCal = MOIS_N.map(() => []);
    for (const c of D.calendrier || []) parMoisCal[+c.mmjj.slice(0, 2) - 1].push(c);
    const calendrier = { id: "calendrier", titre: "Calendrier de l’Ordre", desc: "Saints et bienheureux de l’Ordre, mois par mois, avec leur degré.",
      groupes: [{ titre: "", pieces: parMoisCal.map((l, i) => ({ id: `mois-${i + 1}`, titre: cal[i].titre, sous: `${l.length} célébration${l.length > 1 ? "s" : ""}`,
        rendu: () => `<ol class="liste-missel liste-cal-missel">${l.map((c) => {
          const saint = (S[c.mmjj] || []).map((x, k) => [x, k]).find(([x]) => proches(x.titre, c.nom) > 0);
          const t = `<span class="date">${esc(jour(c.mmjj))}</span><span class="t${c.martyrologe ? " martyrologe" : ""}">${esc(c.nom)}</span><span class="s">${esc(RANGS_OP[c.rang] || c.rang || "")}${(c.provinces || []).map((p) => ` [${esc(p.province)} : ${esc(RANGS_OP[p.rang] || p.rang)}]`).join("")}</span>`;
          return `<li>${saint ? `<a href="#missel-op/saints/${c.mmjj}-${saint[1] + 1}">${t}</a>` : `<span class="sans-lien">${t}</span>`}</li>`;
        }).join("")}</ol>` })) }] };
    const parMois = MOIS_N.map((nom) => ({ titre: nom.charAt(0).toUpperCase() + nom.slice(1), pieces: [] }));
    for (const d of Object.keys(S).sort()) S[d].forEach((s, i) => parMois[+d.slice(0, 2) - 1].pieces.push({
      id: `${d}-${i + 1}`, titre: s.titre, date: jour(d), sous: [RANGS_OP[s.rang] || "", lect(d, s) ? "lectures propres" : ""].filter(Boolean).join(" · "),
      rendu: () => pieceSaintOP(s, lect(d, s)) }));
    const com = [];
    (D.communs || []).forEach((f, i) => {
      let gr = com.find((x) => x.titre === f.commun);
      if (!gr) com.push(gr = { titre: f.commun, pieces: [] });
      gr.pieces.push({ id: `c${i + 1}`, titre: `${f.num}. ${f.cas}`, rendu: () => `<p class="rubrique">La prière est propre à chaque célébration.</p>` + formulaireOP(f.messes[0] || {}) });
    });
    const lectures = Object.keys(LE).sort().flatMap((d) => LE[d].map((e, i) => ({ id: `${d}-${i + 1}`, titre: e.titre, date: jour(d), sous: RANGS_OP[e.rang] || "",
      rendu: () => lectionnaireOP(e, (id, titre, contenu, extra, meta = {}) => vide(contenu) ? "" :
        `<section class="bloc ${extra}"><h3><span class="titre-section">${esc(titre)}</span>${meta.ref ? `<span class="meta"><span class="ref">${esc(meta.ref)}</span></span>` : ""}</h3>${contenu}</section>`) })));
    const r = [
      calendrier,
      D.preface && { id: "preface", titre: "Préface de l’Ordre", desc: D.preface.sous || "", groupes: [{ titre: "", pieces: [{ id: "esprit", titre: D.preface.titre, sous: D.preface.sous, rendu: () => texteMissel(D.preface) }] }] },
      { id: "saints", titre: "Propre des saints", desc: "Messes des saints et bienheureux de l’Ordre, jour par jour : notice, antiennes, prières, préfaces, bénédictions.", groupes: parMois.filter((gr) => gr.pieces.length) },
      (D.votives || []).length && { id: "votives", titre: "Messe votive", desc: "Notre-Dame, Patronne de l’Ordre des Prêcheurs (un jour au choix en mai).",
        groupes: [{ titre: "", pieces: D.votives.map((s, i) => ({ id: `v${i + 1}`, titre: s.titre, sous: s.date || "", rendu: () => pieceSaintOP(s, null) })) }] },
      { id: "communs", titre: "Communs", desc: "Éléments des communs (martyrs, pasteurs, vierges, saints) pour les bienheureux sans formulaire propre.", groupes: com },
      lectures.length && { id: "lectionnaire", titre: "Lectionnaire", desc: "Lectures propres des fêtes et solennités de l’Ordre.", groupes: [{ titre: "", pieces: lectures }] },
    ].filter(Boolean);
    cacheOP.set(D, r);
    return r;
  }
  function vueLivreOP(missel, chemin, q) {
    return vueLivre(missel, chemin, q, { base: "missel-op", nom: "Missel de l’Ordre des Prêcheurs", court: "Missel OP", I: indexOP(missel),
      accueil: "Propre de l’Ordre : calendrier, saints, communs, lectures",
      source: (missel.op && missel.op.source ? missel.op.source + " " : "") + "Les textes communs à tous se trouvent dans le Missel romain." });
  }

  // dans la messe du jour : renvois vers la préface du temps et les prières eucharistiques
  // préface propre du jour : [clé du temporal ou nom du jour/saint, titre de la préface]
  const PREFACE_PROPRE = [[/^christ-roi$/, /Christ Roi/], [/^trinite$/, /sainte Trinité/], [/^saint-sacrement$/, /1re Préface de la Sainte Eucharistie/],
    [/^sacre-coeur$/, /Sacré Cœur/], [/^bapteme$/, /Baptême du Seigneur/], [/^epiphanie$/, /Épiphanie/], [/^ascension$/, /Ascension/],
    [/^paques-8-0$/, /Pentecôte/], [/^careme-([1-5])-0$/, (m) => new RegExp(`Préface du ${m[1] === "1" ? "1er" : m[1] + "e"} dimanche du Carême`)],
    [/^careme-6-0$/, /Rameaux/], [/^careme-6-4$/, /Cène/], [/^paques-1-/, /1re Préface de Pâques/],
    [/(^|\s)Saint Joseph(,|$)/, /saint Joseph/], [/(Nativité|Martyre) de (saint )?Jean[- ]Baptiste/i, /Jean-Baptiste/], [/Pierre et (saint )?Paul/, /Pierre et Paul/], [/Marie[- ]Madeleine(?! de)/, /Marie Madeleine/],
    [/Assomption/, /Assomption/], [/Immaculée/, /Immaculée/], [/Annonciation/, /Annonciation/], [/Présentation du Seigneur/, /Présentation du Seigneur/],
    [/Transfiguration/, /Transfiguration/], [/Croix glorieuse/, /Croix glorieuse/], [/Tous les saints|Toussaint/i, /tous les saints/],
    [/défunts/i, /1re Préface des défunts/], [/Dédicace (de la Basilique du Latran|des églises|de l’église|de l'église)/, /dédicace d’une église/], [/Archanges|anges/, /saints anges/], [/Marie, Mère de l’Église/, /Mère de l’Église/]];
  function prefacePropre(j, saint, toutes) {
    const k = cle(j), nom = saint ? saint.titre : j.source === "temporal" || j.niveau <= 7 ? j.nom : "";
    for (const [re, pre] of PREFACE_PROPRE) {
      const m = re.exec(k) || (re.source.startsWith("^") ? null : re.exec(nom));
      if (!m) continue;
      const rx = typeof pre === "function" ? pre(m) : pre;
      const p = toutes.find((x) => rx.test(x.titre));
      if (p) return p;
    }
    return null;
  }
  function renvois(j, saint) {
    let g = { avent: "Avent", noel: "Noël et Épiphanie", careme: "Carême", "semaine sainte": "Passion et Semaine sainte", triduum: "Passion et Semaine sainte", paques: "Temps pascal" }[j.temps];
    if (!g) g = j.jourSemaine === 0 ? "Dimanches du Temps ordinaire" : "Préfaces communes";
    if (saint) g = /vierge marie|notre-dame/i.test(saint.titre) ? "Vierge Marie" : "Saints";
    return { prefaces: g };
  }

  g.Messe = { cle, construire, propre, options, commun, gloriaCredo, joli, livre: { index, vue: vueLivre, nomTemporal, chercher, renvois }, livreOP: { index: indexOP, vue: vueLivreOP } };
  if (typeof module !== "undefined") module.exports = g.Messe;
})(typeof window !== "undefined" ? window : globalThis);
