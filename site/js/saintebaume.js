/* Version « Sainte-Baume » : livrets de fr. Max (Carême : vigiles, laudes, vêpres ; milieu du jour toute l'année)
   Données : donnees/sainte_baume.json (outils/construire_sainte_baume.py) ; partitions gravées partitions/ly/.
   SainteBaume.careme(j, office) → ce que le livret donne pour cet office ce jour-là, ou null
   SainteBaume.milieu(j)         → hymnes, psaumes, antienne et verset du milieu du jour, ou null (fêtes, Triduum)
*/
(function (g) {
  "use strict";
  let D = null;
  const JOURS = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"];
  const ROM = ["", "I", "II", "III", "IV", "V"];
  const C = () => g.Calendrier;
  const lendemain = (j, opts) => C().jour(C().iso(C().plus(C().deIso(j.date), 1)), opts || {});

  function texteCote(c) {
    if (!c) return null;
    const a = g.Gouzes?.antienneDeCote?.(c);
    return a?.ant || D?.cotes?.[c] || texteRefrain(c) || null;
  }
  // nom du jour tel que l'écrivent les rubriques (« dimanche i », « mercredi des cendres », « lundi saint »)
  function nomJour(j) {
    const w = j.semaine, jr = JOURS[j.jourSemaine];
    if (j.jourSemaine === 0) return w === 6 ? "dimanche des rameaux et de la passion" : `dimanche ${ROM[w].toLowerCase()}`;
    if (w === 0) return `${jr} des cendres`;
    if (w === 6) return `${jr} saint`;
    return `${jr} ${ROM[w].toLowerCase()}`;
  }
  // nom de la semaine dans les renvois aux répons (\Repons{I}{I}{V}{II})
  const nomSemaine = (j) => (j.semaine === 0 ? "des Cendres" : j.semaine === 6 ? (j.jourSemaine === 0 ? "des Rameaux et de la Passion" : "Sainte") : ROM[j.semaine]);
  const careme = (j) => j.temps === "careme" || j.temps === "semaine sainte" || (j.temps === "triduum" && j.jourSemaine === 4);
  const deSanctoral = (j) => j.niveau <= 8 && j.source !== "temporal";

  // Éléments du livret pour un office : le jour même, ou l'office où la rubrique renvoie
  // (« Le mercredi des Cendres, on prend la suite de l'office p. … » : laudes du vendredi III)
  function choisir(office, jj, jourCase) {
    const O = D?.careme?.offices?.[office];
    if (!O) return null;
    const L = nomJour(jj);
    let cle = `${jj.psautier}/${jourCase}`;
    const nomme = (k) => (O[k] || []).some((e) => e.si === L && (e.t === "ant" || e.t === "verset" || e.t === "repons-si"));
    if (!nomme(cle)) { const autre = Object.keys(O).find(nomme); if (autre) cle = autre; }
    const items = O[cle];
    if (!items) return null;
    const elements = [];
    let ants = [], verset = null, versetDefaut = null, label = null, args = null;
    for (const e of items) {
      if (e.t === "ant") ants.push(e);
      else if (e.t === "ps") {
        const a = ants.find((x) => x.si === L) || ants.find((x) => !x.si) || null;
        elements.push({ id: e.id, ant: a ? { cote: a.cote, f: a.f, texte: texteCote(a.cote), inc: a.inc } : null });
        ants = [];
      } else if (e.t === "verset") { if (e.si === L) verset = [e.v, e.r]; else if (!e.si) versetDefaut = [e.v, e.r]; }
      else if (e.t === "repons-si" && e.si === L) label = e.label;
      else if (e.t === "repons") args = e.a;
    }
    // répons : renvoi nommé pour ce jour, sinon selon la semaine (\Repons{semaine}{renvoi}{semaine}{renvoi})
    if (!label && args) {
      const S = nomSemaine(jj);
      if (!args[0] || args[0] === S) label = args[1];
      else if (args[2] === S) label = args[3];
      else if (jj.jourSemaine === 0 && D.careme.repons[office]?.[`Di${S}`]) label = `Di${S}`;
      else label = args[1];
    }
    return { cle, elements, verset: verset || versetDefaut, label };
  }

  function carem(j, office, opts) {
    if (!D || !["lectures", "laudes", "vepres"].includes(office)) return null;
    let jj = j, jourCase = JOURS[j.jourSemaine];
    if (office === "vepres") {
      const n = lendemain(j, opts);
      if (n.jourSemaine === 0) { jj = n; jourCase = "samedi"; }          // premières vêpres du dimanche
      else if (n.niveau <= 4 && n.source !== "temporal") return null;    // veille d'une solennité
    }
    if (!careme(jj) || deSanctoral(jj) || deSanctoral(j)) return null;
    if (j.temps === "triduum" && office !== "lectures") return null;    // jeudi saint : seulement l'office des lectures
    const r = choisir(office, jj, jourCase);
    if (!r) return null;
    const R = r.label ? D.careme.repons[office === "lectures" ? "laudes" : office]?.[r.label] : null;
    let repons = null, ev = null;
    if (R && office !== "lectures") {
      // couplets : celui du jour (répons de semaine) et la doxologie, ou tous (répons du dimanche)
      const parJour = R.couplets.some((c) => /^(Lundi|Mardi|Mercredi|Jeudi|Vendredi|Samedi)$/.test(c.titre));
      const jour = JOURS[j.jourSemaine].replace(/^./, (x) => x.toUpperCase());
      const couplets = parJour ? R.couplets.filter((c) => c.titre === jour || /^Doxologie/.test(c.titre)) : R.couplets;
      repons = { titre: R.titre, f: R.f, cote: R.cote, refrain: texteRefrain(R.cote), couplets };
      if (R.ev) ev = { cote: R.ev.cote, f: R.ev.f, texte: texteCote(R.ev.cote), inc: R.ev.inc };
    }
    const inv = office === "laudes" ? (D.careme.invitatoire || []).find((x) => x.semaine === Math.min(jj.semaine, 6)) : null;
    const nt = office === "vepres" ? r.elements.map((e) => e.id).find((id) => /^NT\d+$/.test(id)) : null;
    return {
      jour: jj, nom: nomJour(jj), cle: r.cle, elements: r.elements, verset: office === "lectures" ? r.verset : null, repons, ev, nt,
      invitatoire: inv ? { cote: inv.cote, f: inv.f, texte: texteCote(inv.cote), inc: inv.inc } : null,
      fin: office === "lectures" ? null : D.careme.fin?.[office] || null,
    };
  }
  // ── Temps ordinaire : répartition « Antiennes des offices Ste Baume » (matines, laudes, vêpres), semaine du psautier
  function ordinaire(j, office, opts) {
    const O = D?.ordinaire?.[office];
    if (!O || !["lectures", "laudes", "vepres"].includes(office)) return null;
    let jj = j, jourCase = JOURS[j.jourSemaine];
    if (office === "vepres") {
      const n = lendemain(j, opts);
      if (n.jourSemaine === 0) { jj = n; jourCase = "samedi"; }           // premières vêpres du dimanche
      else if (n.niveau <= 4 && n.source !== "temporal") return null;     // veille d'une solennité
    }
    if (jj.temps !== "ordinaire" || j.temps !== "ordinaire" || deSanctoral(jj) || deSanctoral(j) || (jj.source === "temporal" && jj.celebration)) return null;
    const cle = `${jj.psautier || 1}/${jourCase}`;
    const items = O[cle];
    if (!items?.length) return null;
    const elements = items.map((e) => ({ id: e.id, partie: e.partie || null,
      ant: e.ant ? { cote: e.ant.cote, f: e.ant.f || null, sb: e.ant.sb || null, texte: e.ant.texte || texteCote(e.ant.cote), inc: e.ant.inc } : null }));
    return { ordinaire: true, jour: jj, nom: `${JOURS[jj.jourSemaine]} — semaine ${ROM[jj.psautier || 1]} du psautier`, cle, elements, strict: true,
      verset: null, repons: null, ev: null, nt: null, invitatoire: null, fin: null };
  }

  function texteRefrain(c) {
    if (!c || !g.Gouzes?.donnees) return null;
    const n = (x) => String(x || "").replace(/\s+/g, "").toUpperCase();
    let t = null;
    const voir = (o) => { if (t || !o || typeof o !== "object") return; if (o.cote && n(o.cote) === c && o.refrain) { t = o.refrain; return; } for (const v of Object.values(o)) voir(v); };
    voir(g.Gouzes.donnees.textes);
    return t;
  }

  // Lucernaire des vêpres de Carême : couplets 1 et 2, couplet du jour, couplets 3 à 5
  function lucernaire(j) {
    const L = D?.careme?.lucernaire;
    if (!L) return null;
    const w = j.semaine, js = j.jourSemaine;
    const jour = js === 0 ? (w === 6 ? "Rameaux" : w === 1 ? "1er dimanche" : `${w}e dimanche`)
      : w === 6 ? `${JOURS[js].replace(/^./, (x) => x.toUpperCase())} Saint` : JOURS[js].replace(/^./, (x) => x.toUpperCase());
    const c = L.couplets;
    const fixes = (re) => c.filter((x) => re.test(x.titre));
    const duJour = c.find((x) => x.titre === jour);
    return { f: L.f, cote: L.cote, couplets: [...fixes(/^[12]\.$/), ...(duJour ? [duJour] : []), ...fixes(/^[345]\.$/)] };
  }
  // hymnes des vêpres : au choix ; celles de la Passion en Semaine sainte (au choix les vendredis et la 5e semaine)
  function hymnesVepres(j) {
    const H = D?.careme?.hymnes || [];
    const passion = j.semaine === 6, libre = j.semaine === 5 || j.jourSemaine === 5;
    return H.filter((h) => !h.passion || passion || libre).sort((a, b) => (passion ? b.passion - a.passion : a.passion - b.passion));
  }

  // ── Milieu du jour
  const TEMPS = { avent: "avent", noel: "noel", careme: "careme", "semaine sainte": "careme", paques: "paques" };
  function milieu(j) {
    const M = D?.milieu;
    // fêtes et solennités (sanctoral, Trinité, Christ-Roi…), Triduum : le livret n'a rien, on garde le carnet de la Province
    if (!M || j.temps === "triduum" || deSanctoral(j) || (j.source === "temporal" && j.celebration)) return null;
    const jour = M.semaines[`${j.psautier || 1}/${JOURS[j.jourSemaine]}`];
    if (!jour) return null;
    const t = TEMPS[j.temps] ? M.temps[TEMPS[j.temps]] : null;
    const quand = (x) => {
      const q = (x.quand || "").toLowerCase();
      if (!q) return true;
      if (/avant l'épiphanie/.test(q)) return !apresEpiphanie(j);
      if (/à partir de l'épiphanie/.test(q)) return apresEpiphanie(j);
      if (/avant les rameaux/.test(q)) return j.semaine < 5;
      if (/5e dimanche|semaine sainte/.test(q)) return j.semaine >= 5;
      if (/pendant l'octave/.test(q)) return j.semaine === 1;
      if (/après l'octave/.test(q)) return j.semaine > 1;
      return true;
    };
    // répartition « Antiennes des offices Ste Baume » (sexte) : psaumes et antiennes du jour, groupés
    const R = D?.ordinaire?.milieu?.[`${j.psautier || 1}/${JOURS[j.jourSemaine]}`];
    const groupes = R?.length ? R.map((g) => ({ ps: g.ps, ant: { f: g.ant.f, cote: g.ant.cote, texte: g.ant.texte || texteCote(g.ant.cote), inc: g.ant.inc } })) : null;
    let ant = jour.ant, verset = jour.verset, hymnes = M.hymnes, source = "jour";
    if (t) {
      const a = (t.antiennes || []).find(quand);
      const v = (t.versets || []).find((x) => x.v && quand(x));
      if (a) ant = a;
      if (v) verset = [v.v, v.r];
      if (t.hymne?.length) hymnes = [t.hymne.flat()];
      source = TEMPS[j.temps];
    }
    const a = ant ? { f: ant.f, cote: ant.cote, texte: texteCote(ant.cote), inc: ant.inc } : null;
    // au temps ordinaire, les antiennes de la répartition ; aux temps forts, l'antienne du temps sur les mêmes psaumes
    if (groupes) return { ps: groupes.flatMap((g) => g.ps), groupes: t ? [{ ps: groupes.flatMap((g) => g.ps), ant: a }] : groupes, ant: t ? a : groupes[0].ant, verset, hymnes, source };
    return { ps: jour.ps, groupes: [{ ps: jour.ps, ant: a }], ant: a, verset, hymnes, source };
  }
  // Épiphanie (France) : le dimanche entre le 2 et le 8 janvier
  function apresEpiphanie(j) {
    if (j.date.slice(5, 7) !== "01") return false;
    const an = +j.date.slice(0, 4);
    for (let d = 2; d <= 8; d++) if (new Date(Date.UTC(an, 0, d)).getUTCDay() === 0) return +j.date.slice(8) >= d;
    return false;
  }

  g.SainteBaume = {
    charger: (d) => { D = d; },
    get donnees() { return D; },
    careme: carem, ordinaire, lucernaire, hymnesVepres, milieu, texteCote, nomJour,
    vigile: () => D?.vigile || [],
    canon: () => D?.careme?.canon || null,
  };
})(typeof window !== "undefined" ? window : globalThis);
