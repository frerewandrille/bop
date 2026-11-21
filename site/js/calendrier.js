/* Calendrier liturgique perpétuel — rite romain, calendrier de France,
   avec le propre de l'Ordre des Prêcheurs (facultatif).

   Calendrier.jour(date, {propreOP}) renvoie :
     { date, temps, semaine, jourSemaine, psautier (1-4), cycle (A/B/C), pair,
       nom, rang, niveau, couleur, cleTemporal, cleSanctoral, celebrations[] }

   Les célébrations à date fixe viennent de donnees/sanctoral.json (calendrier
   romain pour la France, relevé sur l'AELF) et donnees/propre_op.json.
   Aucune date n'est codée pour une année particulière : tout est calculé.
*/
(function (g) {
  "use strict";

  const JOURS = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"];
  const MOIS = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août",
    "septembre", "octobre", "novembre", "décembre"];
  const ROMAIN = ["", "I", "II", "III", "IV"];
  const ORD = (n) => n === 1 ? "1re" : n + "e";

  // ── dates (en UTC pour éviter les surprises d'heure d'été)
  const D = (a, m, j) => new Date(Date.UTC(a, m - 1, j));
  const plus = (d, n) => new Date(d.getTime() + n * 86400000);
  const ecart = (a, b) => Math.round((b - a) / 86400000);
  const iso = (d) => d.toISOString().slice(0, 10);
  const deIso = (s) => { const [a, m, j] = s.split("-").map(Number); return D(a, m, j); };
  const mmjj = (d) => iso(d).slice(5);
  const dimancheAvant = (d) => plus(d, -d.getUTCDay()); // le dimanche de la semaine (ou d lui-même)

  function paques(a) { // algorithme de Meeus/Jones/Butcher
    const b = a % 19, c = Math.floor(a / 100), e = a % 100, f = Math.floor(c / 4), h = c % 4,
      i = Math.floor((c + 8) / 25), k = Math.floor((c - i + 1) / 3),
      l = (19 * b + c - f - k + 15) % 30, m = Math.floor(e / 4), n = e % 4,
      o = (32 + 2 * h + 2 * m - l - n) % 7, p = Math.floor((b + 11 * l + 22 * o) / 451),
      mois = Math.floor((l + o - 7 * p + 114) / 31), jour = ((l + o - 7 * p + 114) % 31) + 1;
    return D(a, mois, jour);
  }
  const premierAvent = (a) => { const n = D(a, 12, 25); return plus(n, -(n.getUTCDay() || 7) - 21); };
  function epiphanie(a) { // France : dimanche entre le 2 et le 8 janvier
    const d = D(a, 1, 2); return plus(d, (7 - d.getUTCDay()) % 7);
  }
  function bapteme(a) {
    const e = epiphanie(a);
    return e.getUTCDate() >= 7 ? plus(e, 1) : plus(e, 7);
  }

  // Repères d'une année civile
  const cacheReperes = {};
  function reperes(a) {
    if (cacheReperes[a]) return cacheReperes[a];
    const P = paques(a);
    const noel = D(a, 12, 25);
    let famille = plus(noel, 7 - noel.getUTCDay()); // dimanche dans l'octave
    if (noel.getUTCDay() === 0) famille = D(a, 12, 30);
    const r = {
      paques: P, cendres: plus(P, -46), rameaux: plus(P, -7), jeudiSaint: plus(P, -3),
      ascension: plus(P, 39), pentecote: plus(P, 49), trinite: plus(P, 56),
      saintSacrement: plus(P, 63), sacreCoeur: plus(P, 68), coeurMarie: plus(P, 69),
      marieEglise: plus(P, 50), avent: premierAvent(a), christRoi: plus(premierAvent(a), -7),
      noel, famille, epiphanie: epiphanie(a), bapteme: bapteme(a),
    };
    return (cacheReperes[a] = r);
  }

  // Cycle dominical (A, B, C) et année paire/impaire : l'année liturgique commence à l'Avent
  function anneeLiturgique(d) {
    const a = d.getUTCFullYear();
    return d >= reperes(a).avent ? a + 1 : a;
  }
  const cycle = (d) => "ABC"[(anneeLiturgique(d) - 2020 + 300) % 3]; // 2020 (Avent 2019) = A
  const pair = (d) => anneeLiturgique(d) % 2 === 0;

  // ── Temporal
  function temporal(d) {
    const a = d.getUTCFullYear(), R = reperes(a), Rp = reperes(a - 1);
    const js = d.getUTCDay();
    const t = { temps: null, semaine: null, nom: null, niveau: 13, couleur: "vert", cle: null, psautier: null };

    if (d >= R.avent && d < R.noel) {                       // Avent
      const s = Math.floor(ecart(R.avent, d) / 7) + 1;
      Object.assign(t, { temps: "avent", semaine: s, couleur: "violet", psautier: ((s - 1) % 4) + 1 });
      // féries du 17 au 24 décembre (et non les jours de l'Avent tombant à la fin de novembre)
      const fin = d.getUTCMonth() === 11 && d.getUTCDate() >= 17;
      if (js === 0) Object.assign(t, { nom: `${ORD(s)} dimanche de l'Avent`, niveau: 2 });
      else if (fin) Object.assign(t, { nom: `${d.getUTCDate()} décembre (férie de l'Avent)`, niveau: 9 });
      else t.nom = `${JOURS[js]} de la ${ORD(s)} semaine de l'Avent`;
      t.cle = js === 0 || !fin ? `avent-${s}-${js}` : `avent-${mmjj(d)}`;
      if (fin && js !== 0) t.cleSemaine = `avent-${s}-${js}`;
      return t;
    }
    // Temps de Noël (25 déc. → Baptême)
    const anneeBapt = d.getUTCMonth() === 11 ? a + 1 : a;
    const bapt = reperes(anneeBapt).bapteme;
    if ((d >= R.noel && d.getUTCMonth() === 11) || (d.getUTCMonth() === 0 && d <= bapt)) {
      const Rn = d.getUTCMonth() === 11 ? R : Rp;
      Object.assign(t, { temps: "noel", couleur: "blanc" });
      const fam = Rn.famille, epi = reperes(anneeBapt).epiphanie;
      t.psautier = d < fam ? 4 : (Math.floor(ecart(fam, d) / 7) % 4) + 1;
      if (iso(d) === iso(Rn.noel)) Object.assign(t, { nom: "Nativité du Seigneur", niveau: 2, cle: "noel" });
      else if (iso(d) === iso(fam)) Object.assign(t, { nom: "La Sainte Famille de Jésus, Marie et Joseph", niveau: 5, cle: "sainte-famille" });
      else if (mmjj(d) === "01-01") Object.assign(t, { nom: "Sainte Marie, Mère de Dieu", niveau: 3, cle: "marie-mere-de-dieu" });
      else if (iso(d) === iso(epi)) Object.assign(t, { nom: "Épiphanie du Seigneur", niveau: 2, cle: "epiphanie" });
      else if (iso(d) === iso(bapt)) Object.assign(t, { nom: "Baptême du Seigneur", niveau: 5, cle: "bapteme" });
      else if (d.getUTCMonth() === 11) Object.assign(t, { nom: `${d.getUTCDate() - 24}e jour dans l'octave de Noël`, niveau: 9, cle: `noel-${mmjj(d)}` });
      else if (js === 0) Object.assign(t, { nom: "2e dimanche après Noël", niveau: 6, cle: "noel-dimanche-2" });
      else if (d > epi) Object.assign(t, { nom: `${JOURS[js]} après l'Épiphanie`, cle: `epiphanie-${js}` });
      else Object.assign(t, { nom: `${d.getUTCDate()} janvier (férie du temps de Noël)`, cle: `noel-${mmjj(d)}` });
      t.cleSemaine = `noel-${mmjj(d)}-${js}`;
      return t;
    }
    // Carême, Semaine sainte, Triduum
    if (d >= R.cendres && d < R.paques) {
      Object.assign(t, { temps: "careme", couleur: "violet", niveau: 9 });
      const s = d < plus(R.cendres, 4) ? 0 : Math.floor(ecart(plus(R.cendres, 4), d) / 7) + 1;
      t.semaine = s; t.psautier = s === 0 ? 4 : ((s - 1) % 4) + 1;
      if (s === 0) t.nom = js === 3 ? "Mercredi des Cendres" : `${JOURS[js]} après les Cendres`;
      else if (s === 6) {
        t.temps = "semaine sainte";
        t.nom = js === 0 ? "Dimanche des Rameaux et de la Passion" : `${JOURS[js]} saint`;
      } else t.nom = js === 0 ? `${ORD(s)} dimanche de Carême` : `${JOURS[js]} de la ${ORD(s)} semaine de Carême`;
      if (s === 0 && js === 3) t.niveau = 2;
      if (js === 0 || (s === 6 && js <= 4)) t.niveau = 2;
      if (s === 6 && js >= 4) { t.niveau = 1; t.temps = "triduum"; t.nom = ["", "", "", "", "Jeudi saint", "Vendredi saint", "Samedi saint"][js]; t.couleur = js === 5 ? "rouge" : js === 6 ? "violet" : "blanc"; }
      if (s === 6 && js === 0) t.couleur = "rouge";
      if (s === 4 && js === 0) t.couleur = "rose";
      t.cle = `careme-${s}-${js}`;
      return t;
    }
    // Temps pascal
    if (d >= R.paques && d <= R.pentecote) {
      const s = Math.floor(ecart(R.paques, d) / 7) + 1;
      Object.assign(t, { temps: "paques", semaine: s, couleur: "blanc", psautier: ((s - 1) % 4) + 1 });
      if (s === 1) { t.niveau = js === 0 ? 1 : 2; t.nom = js === 0 ? "Dimanche de Pâques, Résurrection du Seigneur" : `${JOURS[js]} dans l'octave de Pâques`; }
      else if (js === 0) { t.niveau = 2; t.nom = `${ORD(s)} dimanche de Pâques`; }
      else t.nom = `${JOURS[js]} de la ${ORD(s)} semaine de Pâques`;
      if (iso(d) === iso(R.ascension)) Object.assign(t, { nom: "Ascension du Seigneur", niveau: 2 });
      if (iso(d) === iso(R.pentecote)) Object.assign(t, { nom: "Pentecôte", niveau: 2, couleur: "rouge" });
      t.cle = `paques-${s}-${js}`;
      return t;
    }
    // Temps ordinaire
    t.temps = "ordinaire";
    let s;
    if (d > R.pentecote) s = 34 - Math.floor(ecart(dimancheAvant(d), R.christRoi) / 7);
    else s = Math.floor(ecart(dimancheAvant(bapt), d) / 7) + 1; // la semaine qui suit le Baptême est la 1re
    t.semaine = s; t.psautier = ((s - 1) % 4) + 1;
    t.nom = js === 0 ? `${ORD(s)} dimanche du temps ordinaire` : `${JOURS[js]} de la ${ORD(s)} semaine du temps ordinaire`;
    if (js === 0) t.niveau = 6;
    t.cle = `ordinaire-${s}-${js}`;
    // Solennités et fêtes mobiles du Seigneur après la Pentecôte
    const fixes = [
      [R.trinite, "La Sainte Trinité", 3, "blanc", "trinite"],
      [R.saintSacrement, "Le Saint-Sacrement du Corps et du Sang du Christ", 3, "blanc", "saint-sacrement"],
      [R.sacreCoeur, "Le Sacré-Cœur de Jésus", 3, "blanc", "sacre-coeur"],
      [R.christRoi, "Le Christ, Roi de l'univers", 3, "blanc", "christ-roi"],
      // France : dédicace des églises dont on ignore la date, le dernier dimanche d'octobre
      [plus(D(a, 10, 31), -D(a, 10, 31).getUTCDay()), "Dédicace des églises dont on ignore la date de consécration", 3, "blanc", "dedicace"],
    ];
    for (const [jour, nom, niveau, couleur, cle] of fixes)
      if (iso(d) === iso(jour)) Object.assign(t, { nom, niveau, couleur, cle, mobile: true });
    return t;
  }

  // Mémoires mobiles (rang de mémoire, cédant devant tout ce qui est plus fort)
  function memoiresMobiles(d) {
    const R = reperes(d.getUTCFullYear()), out = [];
    if (iso(d) === iso(R.marieEglise)) out.push({ nom: "La Bienheureuse Vierge Marie, Mère de l'Église", niveau: 9.9, rang: "mémoire", couleur: "blanc", cle: "marie-mere-eglise" });
    if (iso(d) === iso(R.coeurMarie)) out.push({ nom: "Le Cœur immaculé de Marie", niveau: 9.9, rang: "mémoire", couleur: "blanc", cle: "coeur-immacule" });
    return out;
  }

  const NIVEAU_RANG = { "solennité": 3, "fête": 7, "mémoire": 10, "mémoire facultative": 12, "anniversaire": 12 };
  const NOM_RANG = { 9.9: "mémoire", 1: "solennité", 2: "solennité", 3: "solennité", 4: "solennité", 5: "fête", 6: "dimanche", 7: "fête", 8: "fête", 9: "férie", 10: "mémoire", 11: "mémoire", 12: "mémoire facultative", 13: "férie" };

  let SANCTORAL = {}, PROPRE_OP = {};
  function charger(sanctoral, propreOP) { SANCTORAL = sanctoral || {}; PROPRE_OP = propreOP || {}; }

  // Célébrations à date fixe, avec les transferts de solennités empêchées
  function fixesDu(d) {
    const out = [];
    const s = SANCTORAL[mmjj(d)];
    if (s) out.push({ ...s, source: "romain", niveau: s.niveau || NIVEAU_RANG[s.rang], cle: "sanctoral-" + mmjj(d) });
    return out;
  }

  // Une solennité à date fixe empêchée par un jour plus fort (dimanche de l'Avent, du Carême
  // ou de Pâques, Semaine sainte, octave de Pâques) est transférée au premier jour libre suivant.
  // S. Joseph en Semaine sainte est anticipé au samedi avant les Rameaux.
  function empechee(orig, sol) {
    const t = temporal(orig);
    return t.niveau < sol.niveau || (t.mobile && t.niveau <= sol.niveau);
  }
  function libre(d) {
    const t = temporal(d);
    return t.niveau >= 9 && !t.mobile && !fixesDu(d).some((c) => c.niveau <= 8);
  }
  function cibleTransfert(orig) {
    const R = reperes(orig.getUTCFullYear());
    if (mmjj(orig) === "03-19" && orig >= R.rameaux && orig < R.paques) return plus(R.rameaux, -1);
    const t = temporal(orig);
    if (t.mobile && t.niveau === 3) {
      // collision avec une solennité mobile du Seigneur (ex. Sacré-Cœur et S. Jean-Baptiste) : la veille
      return plus(orig, -1);
    }
    let c = plus(orig, 1);
    while (!libre(c) && ecart(orig, c) < 40) c = plus(c, 1);
    return c;
  }
  function solenniteTransferee(d) {
    for (let k = -1; k <= 30; k++) {
      if (k === 0) continue;
      const orig = plus(d, -k);
      const sol = fixesDu(orig).find((c) => c.niveau <= 4);
      if (sol && empechee(orig, sol) && iso(cibleTransfert(orig)) === iso(d)) return { ...sol, transfert: true };
    }
    return null;
  }

  const NIVEAU_OP = { "solennité": 4, "fête": 8, "mémoire": 11, "mémoire facultative": 12, "anniversaire": 12 };

  function jour(date, options = {}) {
    const d = typeof date === "string" ? deIso(date) : date;
    const t = temporal(d);
    const js = d.getUTCDay();
    let cands = [...fixesDu(d), ...memoiresMobiles(d)];
    // solennité empêchée ce jour : elle est transférée ailleurs
    cands = cands.filter((c) => !(c.niveau <= 4 && empechee(d, c)));
    const tr = solenniteTransferee(d);
    if (tr) cands.push(tr);
    if (options.propreOP) {
      const p = PROPRE_OP[mmjj(d)];
      if (p) cands.push({ ...p, source: "op", niveau: NIVEAU_OP[p.rang], cle: "op-" + mmjj(d) });
    }
    // En Carême, du 17 au 24 décembre et dans l'octave de Noël, les mémoires deviennent facultatives
    const privilegie = t.niveau === 9;
    cands = cands.map((c) => (privilegie && c.niveau >= 10 && c.niveau <= 11 ? { ...c, niveau: 12, rang: "mémoire facultative" } : c));
    // à rang égal, le propre de l'Ordre l'emporte
    cands.sort((x, y) => x.niveau - y.niveau || (x.source === "op" ? -1 : y.source === "op" ? 1 : 0));
    let fort = cands[0];
    // célébrations entre lesquelles on peut choisir (ni solennité, ni jour privilégié du temporal)
    const choixPossibles = [];
    if (t.niveau >= 6 && !t.mobile) {
      const opt = cands.filter((c) => c.niveau >= 5 && c.niveau <= 12);
      if (opt.length) {
        choixPossibles.push({ cle: "temporal", nom: t.nom });
        for (const c of opt) choixPossibles.push({ cle: c.cle, nom: c.nom, rang: c.rang || NOM_RANG[c.niveau] });
      }
    }
    const choix = options.choix && choixPossibles.some((c) => c.cle === options.choix) ? options.choix : null;
    if (choix === "temporal") fort = null;
    else if (choix) fort = { ...cands.find((c) => c.cle === choix), niveau: Math.min(cands.find((c) => c.cle === choix).niveau, 11) };
    let res;
    if (fort && (fort.niveau < t.niveau || choix) && fort.niveau <= 11) {
      res = { nom: fort.nom, niveau: fort.niveau, rang: fort.rang || NOM_RANG[fort.niveau], couleur: fort.couleur || "blanc",
        source: fort.source || "romain", celebration: true, cleSanctoral: fort.cle };
    } else {
      res = { nom: t.nom, niveau: t.niveau, rang: NOM_RANG[t.niveau] || "férie", couleur: t.couleur, source: "temporal", celebration: t.niveau <= 5 && js !== 0 || !!t.mobile };
      if (js === 0 && (t.niveau === 2 || t.niveau === 6) && /dimanche/i.test(t.nom)) res.rang = "dimanche";
    }
    const autres = cands.filter((c) => c.cle !== fort?.cle || !res.cleSanctoral).filter((c) => c.nom !== res.nom && c.niveau >= 10);
    return {
      date: iso(d), jourSemaine: js, nomJour: JOURS[js],
      dateLongue: `${JOURS[js]} ${d.getUTCDate() === 1 ? "1er" : d.getUTCDate()} ${MOIS[d.getUTCMonth()]} ${d.getUTCFullYear()}`,
      temps: t.temps, semaine: t.semaine, psautier: t.psautier, psautierRomain: ROMAIN[t.psautier] || "",
      cycle: cycle(d), pair: pair(d),
      ferie: t.nom, cleTemporal: t.cle, cleSemaine: t.cleSemaine || t.cle,
      ...res,
      facultatives: autres.map((c) => ({ nom: c.nom, rang: c.rang, source: c.source })),
      choixPossibles, choix: choix || (res.cleSanctoral && choixPossibles.length ? res.cleSanctoral : choixPossibles.length ? "temporal" : null), choixManuel: !!choix,
    };
  }

  g.Calendrier = { jour, temporal, romainDu: (mmjj) => SANCTORAL[mmjj] || null, paques, reperes, charger, iso, deIso, plus, ecart, JOURS, MOIS, anneeLiturgique };
})(typeof window !== "undefined" ? window : globalThis);
