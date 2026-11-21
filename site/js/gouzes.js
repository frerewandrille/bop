/* Liturgie chorale du peuple de Dieu (A. Gouzes) : choix des éléments propres d'un office.

   Gouzes.resoudre(jour, office, mode) → {
     psalmodie: [{pieces, ant, cote, ton, nocturne?}] | null,   (null : psalmodie de l'AELF)
     evangelique, invitatoire, hymne, choral, repons, preces, canon, tenebres, notes[]
   }
   mode : "gouzantine" (répartition gouzantine) ou "romaine-gouzes" (répartition romaine, antiennes de Gouzes).
   Données : donnees/gouzes.json (construit par outils/construire_gouzes.py).
*/
(function (g) {
  "use strict";
  let D = null, PROV = [], COTES = null;
  const charger = (d) => { D = d; COTES = null; };
  const chargerProvince = (p) => (PROV = p || []);
  const norme = (c) => String(c || "").replace(/\s+/g, "").toUpperCase();
  // texte d'une antienne d'après sa cote (« K 731 »), relevé dans tout le recueil
  function antienneDeCote(c) {
    if (!COTES) {
      COTES = {};
      for (const o of Object.values(D?.offices || {})) for (const e of o.psalmodie || []) if (e?.cote && e.ant) COTES[norme(e.cote)] ||= { ant: e.ant, ton: e.ton, cote: e.cote };
    }
    return COTES[norme(c)] || (EXTRA[norme(c)] ? { ant: EXTRA[norme(c)], cote: c } : null);
  }
  // textes d'antiennes d'après leur cote, d'une autre source (Index gouzantinus du Carême, livrets de Sainte-Baume)
  let EXTRA = {};
  const ajouterCotes = (m) => { for (const [k, v] of Object.entries(m || {})) EXTRA[norme(k)] ||= v; };
  // Grand Canon : texte des livrets de Sainte-Baume, avec le gras des inflexions, à la place du texte sans gras
  // (seulement les jours où les deux textes concordent : construire_sainte_baume.py le vérifie)
  function remplacerCanon(jours) {
    const K = D?.textes?.canon;
    if (!K || !jours) return;
    for (const [cle, strophes] of Object.entries(jours)) {
      K[cle] = { titre: `${cle.replace("sem6/", "Semaine sainte, ").replace("/", " ")} (livret de Sainte-Baume)`, ...(K[cle] || {}), lignes: strophes.flatMap((st, i) => [`${i + 1}. ${st[0]}`, ...st.slice(1)]), gras: true };
    }
  }
  const C = () => g.Calendrier;
  const JOURS = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"];
  const ABR = ["dim", "lun", "mar", "mer", "jeu", "ven", "sam"];
  const OP_PRECES = { "01-28": "thomas-d-aquin", "08-08": "dominique", "10-04": "francois", "11-07": "saints-op" };

  const off = (cle) => D?.offices?.[cle];
  const premier = (cles, champ = "psalmodie") => {
    for (const c of cles) { const o = off(c); if (o && o[champ]) return { cle: c, val: o[champ] }; }
    return null;
  };
  const semaineTO = (j) => ((j.semaine - 1) % 4) + 1;
  const semaine8 = (j) => (((j.semaine || 1) - 1) % 8) + 1;
  const mmjj = (j) => j.date.slice(5);

  // Le samedi soir et la veille des grandes fêtes, les vêpres sont les 1res vêpres du lendemain
  function lendemain(j) { return C().jour(C().iso(C().plus(C().deIso(j.date), 1))); }

  function clesPsalmodie(j, office, mode) {
    const S = mode === "romaine-gouzes" ? "R" : "G";
    const jour = JOURS[j.jourSemaine];
    if (office === "complies") return [];
    // 1res vêpres
    if (office === "vepres") {
      const n = lendemain(j);
      if (n.jourSemaine === 0 || (n.temps === "paques" && /ascension/i.test(n.nom))) {
        if (S === "R") return n.temps === "ordinaire" || n.temps === "avent" ? [`R/to/${semaineTO(n)}/samedi/vepres`] : [];
        if (n.temps === "avent") return [`G/avent/dim${n.semaine}/vepres1`, `G/avent/dim/vepres1`];
        if (n.temps === "careme" || n.temps === "semaine sainte") return [`G/careme/dim/vepres1`];
        if (n.temps === "paques") {
          if (/ascension/i.test(n.nom)) return ["G/paques/ascension/vepres1"];
          if (/pentecôte/i.test(n.nom)) return ["G/paques/pentecote/vepres1"];
          if (n.semaine === 7) return ["G/paques/dim7/vepres1"];
          if (n.semaine >= 2) return ["G/paques/dim/vepres1"];
          return [];
        }
        if (n.temps === "ordinaire" && n.source === "temporal" && !n.celebration) return [`G/to/${semaineTO(n)}/samedi/vepres`];
        return [];
      }
    }
    if (S === "R") {
      if (j.niveau <= 8 && !(j.source === "temporal" && !j.celebration)) return []; // fête, solennité : psalmodie propre
      if (j.temps === "ordinaire" || (j.temps === "avent" && !(+j.date.slice(8) >= 17 && j.date.slice(5, 7) === "12")))
        return [`R/to/${semaineTO(j)}/${jour}/${office}`];
      return [];
    }
    const o = office === "vepres" && j.jourSemaine === 0 ? "vepres2" : office;
    switch (j.temps) {
      case "avent": {
        const d = +j.date.slice(8);
        if (j.jourSemaine === 0) {
          if (office === "laudes") return ["G/avent/dim/laudes"];
          return [`G/avent/dim${j.semaine}/${o}`, `G/avent/dim/${o}`];
        }
        if (j.date.slice(5, 7) === "12" && d >= 17 && d <= 23) return [`G/avent/j${d - 16}/${office}`];
        return [`G/avent/sem${Math.min(j.semaine, 3)}/${jour}/${office}`];
      }
      case "careme":
      case "semaine sainte": {
        if (j.jourSemaine === 0) {
          if (office === "lectures") return j.semaine <= 5 ? [`G/careme/dim${j.semaine}/lectures`] : [];
          return [`G/careme/dim/${o}`];
        }
        if (j.semaine === 0) return j.jourSemaine === 3 ? [`G/careme/cendres/${office}`] : [`G/careme/sem2/${jour}/${office}`];
        if (j.semaine === 6 && j.jourSemaine === 3 && office === "lectures") return ["G/careme/mercredi-saint/lectures"];
        return [`G/careme/sem${((j.semaine - 1) % 2) + 1}/${jour}/${office}`];
      }
      case "triduum":
        return office === "lectures" ? [`G/triduum/${jour}/lectures`] : [];
      case "paques": {
        if (/ascension/i.test(j.nom)) return [`G/paques/ascension/${o === "vepres" ? "vepres2" : o}`];
        if (/pentecôte/i.test(j.nom)) return [`G/paques/pentecote/${o}`];
        if (j.semaine === 1) return [];
        if (j.jourSemaine === 0) return j.semaine === 7 ? [`G/paques/dim7/${o}`] : [`G/paques/dim/${o}`];
        const apres = (j.semaine === 6 && j.jourSemaine >= 5) || j.semaine === 7;
        if (apres) return [`G/paques/apres-ascension/${jour}/${office}`];
        return [`G/paques/sem${((j.semaine - 2) % 2) + 1}/${jour}/${office}`];
      }
      case "ordinaire":
        if (j.source !== "temporal" && j.niveau <= 8) return []; // fête ou solennité : psalmodie propre (AELF)
        if (j.celebration && j.source === "temporal") return [];  // Trinité, Christ-Roi… : AELF
        if (j.jourSemaine === 0) return [`G/to/${semaineTO(j)}/dimanche/${office === "vepres" ? "vepres" : office}`, `R/to/${semaineTO(j)}/dimanche/${office}`];
        return [`G/to/${semaineTO(j)}/${jour}/${office}`];
      default:
        return [];
    }
  }

  // ── Hymnes et chorals
  function hymne(j, office) {
    const H = D?.textes?.hymnes || {};
    if (j.temps === "avent") return H[`avent/${office}`] ? { ...H[`avent/${office}`], cle: `avent/${office}` } : null;
    if ((j.temps === "careme" || j.temps === "semaine sainte") && H[`careme/${office}`]) return { ...H[`careme/${office}`] };
    return null;
  }
  function choral(j, office) {
    if (office !== "lectures" || j.jourSemaine !== 0) return null;
    const H = D?.textes?.hymnes || {};
    if (j.temps === "avent") return H[`avent/dim${j.semaine}/choral`] || null;
    if (j.temps === "careme") return H[`careme/dim${j.semaine}/choral`] || null;
    return null;
  }

  // ── Répons : { cote, refrain, ton, versets: [texte…], dox, marial }
  function repons(j, office) {
    const R = D?.textes?.repons || {};
    const jour = ABR[j.jourSemaine];
    const verset = (r, pred) => (r.versets || []).filter(pred).map((v) => v.texte);
    const fin = (r, extra = {}) => ({ cote: r.cote, refrain: r.refrain, ton: r.ton, ...extra });
    const dox = (r) => (r.versets || []).find((v) => v.quand === "dox" || v.quand === "dox.")?.texte;
    if (office === "complies") return null;
    // samedi soir : répons des 1res vêpres
    const premieresVepres = office === "vepres" && j.jourSemaine === 6;
    if (j.temps === "ordinaire" || (premieresVepres && lendemain(j).temps === "ordinaire")) {
      const jj = premieresVepres ? lendemain(j) : j;
      if (jj.jourSemaine === 0 || premieresVepres) {
        const r = R[`to/dim${semaine8(jj)}`];
        if (!r) return null;
        const q = premieresVepres ? "vepres1" : office === "vepres" ? "vepres2" : office;
        return fin(r, { versets: verset(r, (v) => q === "lectures" ? (v.quand === "lectures" || (!v.quand && v.n >= 2 && v.n <= 4)) : v.quand === q),
          dox: dox(r), marial: office === "vepres" ? verset(r, (v) => v.quand === "mag")[0] : null });
      }
      if (office === "lectures") return null;
      const r = R[`to/${semaine8(j)}/${office}`];
      if (!r) return null;
      const memoire = j.cleSanctoral && j.niveau >= 10 && j.niveau <= 11 && office === "laudes" && r.saints?.length;
      return fin(r, { versets: memoire ? r.saints.map((v) => v.texte) : verset(r, (v) => v.quand === jour),
        dox: dox(r), marial: office === "vepres" ? verset(r, (v) => v.quand === "mag")[0] : null });
    }
    if (j.temps === "avent") {
      const d = +j.date.slice(8);
      if (j.jourSemaine === 0) {
        const r = R[`avent/dim${j.semaine}/dimanche`];
        if (!r) return null;
        const vs = r.versets || [];
        const pris = office === "lectures" ? vs.filter((v) => v.quand === "vig" || (!v.quand && v.n <= 3)) : office === "laudes" ? vs.filter((v) => v.quand === "ld" || v.n === 4) : [];
        return fin(r, { versets: pris.map((v) => v.texte), dox: vs.find((v) => v.quand === "dox")?.texte || vs[vs.length - 1]?.texte });
      }
      if (office === "laudes") {
        const r = d >= 17 && d <= 23 && j.date.slice(5, 7) === "12" ? R["avent/prep/laudes"] : R[`avent/semaine${Math.min(j.semaine, 3)}/laudes`];
        if (!r) return null;
        const vs = r.versets || [];
        const i = d >= 17 && d <= 23 ? d - 17 : j.jourSemaine - 1;
        return fin(r, { versets: vs[i] ? [vs[i].texte] : [], dox: vs[vs.length - 1]?.texte });
      }
      if (office === "vepres") {
        const r = R["avent/semaine/vepres"];
        if (!r) return null;
        const vs = r.versets || [];
        return fin(r, { versets: vs.filter((v) => v.quand === jour).map((v) => v.texte), dox: vs[vs.length - 1]?.texte });
      }
    }
    if ((j.temps === "careme" || j.temps === "semaine sainte") && office === "lectures") {
      const r = j.jourSemaine === 0 ? R[`careme/dim${j.semaine}/lectures`] : j.semaine === 6 && j.jourSemaine === 3 ? R["careme/mercredi-saint/lectures"] : null;
      if (r) return fin(r, { versets: (r.versets || []).map((v) => v.texte) });
    }
    return null;
  }

  // ── Litanies (preces) du fr. D. Cerbelaud
  function preces(j, office) {
    const P = D?.textes?.preces || {};
    if (office !== "laudes" && office !== "vepres") return null;
    const jour = JOURS[j.jourSemaine];
    const pv = office === "vepres" && j.jourSemaine === 6;      // 1res vêpres du dimanche
    const n = pv ? lendemain(j) : j;
    const ov = pv ? "vepres1" : office === "vepres" ? (j.jourSemaine === 0 || j.niveau <= 5 ? "vepres2" : "vepres") : "laudes";
    const essayer = (...cles) => { for (const c of cles) if (P[c]?.length) return { cle: c, lignes: P[c] }; return null; };
    const vers = (base) => essayer(`${base}/${ov}`, `${base}/${ov === "vepres1" || ov === "vepres2" ? "vepres" : "vepres2"}`);
    // sanctoral (fêtes et solennités à date fixe, y compris celles de l'Ordre)
    if (n.niveau <= 8 && (n.source === "romain" || n.source === "op")) {
      const m = mmjj(n);
      const r = (n.source === "op" && OP_PRECES[m] ? vers(`sanctoral/${OP_PRECES[m]}`) : null) || vers(`sanctoral/${m}`);
      if (r) return r;
      const nom = n.nom.toLowerCase();
      const commun = /apôtre/.test(nom) ? "apotres" : /évangéliste/.test(nom) ? "evangelistes" : /martyr/.test(nom) ? "martyrs"
        : /docteur/.test(nom) ? "docteurs" : /vierge marie|notre-dame/.test(nom) ? "vierge-marie" : /dédicace/.test(nom) ? "dedicace" : null;
      if (commun) { const c = vers(`commun/${commun}`); if (c) return c; }
    }
    const cleT = n.cleTemporal || "";
    const fetes = { "noel": "noel", "sainte-famille": "sainte-famille", "epiphanie": "epiphanie", "bapteme": "bapteme",
      "trinite": "trinite", "saint-sacrement": "saint-sacrement", "sacre-coeur": "sacre-coeur", "christ-roi": "christ-roi" };
    for (const [k, v] of Object.entries(fetes)) if (cleT === k || (n.nom && n.celebration && cleT.endsWith(k))) { const r = vers(`fete/${v}`); if (r) return r; }
    if (/^Ascension/.test(n.nom)) return vers("fete/ascension");
    if (/^Pentecôte/.test(n.nom)) return vers("fete/pentecote");
    if (/^La Sainte Trinité/.test(n.nom)) return vers("fete/trinite");
    if (/Saint-Sacrement/.test(n.nom)) return vers("fete/saint-sacrement");
    if (/Sacré-Cœur/.test(n.nom)) return vers("fete/sacre-coeur");
    if (/Christ, Roi/.test(n.nom)) return vers("fete/christ-roi");
    if (/Sainte Famille/.test(n.nom)) return vers("fete/sainte-famille");
    switch (n.temps) {
      case "ordinaire":
        return n.jourSemaine === 0 ? vers(`to/${semaineTO(n)}/dimanche`) : essayer(`to/${semaineTO(n)}/${jour}/${office}`);
      case "avent": {
        const d = +n.date.slice(8);
        if (n.jourSemaine === 0) return ov === "laudes" ? essayer(`avent/dim${n.semaine}/laudes`) : vers("avent/dim");
        if (d >= 17 && n.date.slice(5, 7) === "12") return essayer(`avent/12-${String(d).padStart(2, "0")}/${office}`);
        return essayer(`avent/${jour}/${office}`);
      }
      case "noel":
        if (mmjj(n) === "12-25") return vers("fete/noel");
        if (/^12-(2[6-9]|3[01])$/.test(mmjj(n))) return essayer(`fete/octave-noel/${office}`);
        return null;
      case "careme":
      case "semaine sainte":
        if (n.semaine === 0 && n.jourSemaine === 3) return essayer(`careme/cendres/${office}`);
        if (n.jourSemaine === 0) {
          if (n.semaine === 6) return vers("careme/rameaux");
          return ov === "vepres1" ? essayer(`careme/dim${n.semaine}/vepres1`) : ov === "laudes" ? essayer("careme/dim/laudes") : essayer("careme/dim/vepres2");
        }
        if (n.semaine === 6) return essayer(`careme/${jour}-saint/${office}`);
        return essayer(`careme/${jour}/${office}`);
      case "paques":
        if (n.semaine === 1) return essayer(`paques/resurrection/${office}`);
        if (n.jourSemaine === 0) return vers("paques/dim");
        return essayer(`paques/${jour}/${office}`);
      default:
        return null;
    }
  }

  function invitatoire(j) {
    if (j.temps === "careme" || j.temps === "semaine sainte") {
      const L = D?.textes?.invitatoires_careme || [];
      const i = Math.min(j.semaine || 0, L.length - 1);
      return L[i] ? { ant: L[i].ant, cote: L[i].cote } : null;
    }
    if (j.temps === "paques" && j.jourSemaine === 0) {
      const o = off(`G/paques/dim${j.semaine}${j.cycle}/laudes`) || off(`G/paques/dim${j.semaine}A/laudes`);
      if (o?.invitatoire) return o.invitatoire;
    }
    return null;
  }

  function canon(j, office) {
    if ((office !== "lectures" && office !== "tout") || !(j.temps === "careme" || j.temps === "semaine sainte")) return null;
    const K = D?.textes?.canon || {};
    const cle = j.semaine === 0 ? `cendres/${JOURS[j.jourSemaine]}` : `sem${j.semaine}/${JOURS[j.jourSemaine]}`;
    return K[cle] || null;
  }

  // Carnet du Carême de la Province : une ou deux antiennes de Gouzes (par cote) sur la psalmodie romaine
  function antiennesProvince(j, office) {
    if (!(j.temps === "careme" || j.temps === "semaine sainte")) return null;
    let jj = j, oe = office;
    if (office === "vepres") {
      const n = lendemain(j);
      if (n.jourSemaine === 0) { jj = n; oe = "vepres1"; } else if (j.jourSemaine === 0) oe = "vepres2";
    }
    const jour = JOURS[jj.jourSemaine];
    const p = PROV.find((x) => x.carnet === "careme" && x.office === oe && (!x.jours || x.jours.includes(jour))
      && (!x.semaines || x.semaines.includes(jj.semaine)) && (!x.annee || x.annee === jj.cycle));
    if (!p) return null;
    const ants = p.cotes.map((c) => antienneDeCote(c) || { cote: c, ant: null });
    return ants.some((a) => a.ant) ? { titre: p.titre, antiennes: ants, nt: p.nt || null } : null;
  }

  // ── Répartition hebdomadaire du milieu du jour et des vigiles (feuille de l'utilisateur, 17/11/2026),
  // version gouzantine. [semaine du psautier 1-4][dimanche … samedi] ; « + » : psaumes sous une même
  // antienne (milieu du jour), espace : psaumes successifs, « 9A&9B » : un seul psaume (Ps 9 grec),
  // « 77:1-39 » : versets. null : pas de répartition (on garde le reste du système).
  const FEUILLE = {
    milieu: {
      1: ["117", "18B+33", "118-1+41", "118-2+42", "118-3+62", "118-4+80", "118-5+102"],
      2: ["22+75", "118-6+33", "118-7+41", "118-8+42", "118-9+62", "118-10+80", "118-11+102"],
      3: ["117", "118-12+33", "118-13+41", "118-14+42", "118-15+62", "21", "118-16+102"],
      4: ["22+75", "118-17+33", "118-18+41", "118-19+42", "118-20+62", "118-21+80", "118-22+102"],
    },
    lectures: {
      1: [null, "6 7 10", "9A&9B", "11 13 14", "25 30", "27 34", "36"],
      2: [null, "37 38", "39 43", "48 51 52", "53 54", "55 57 60", "104"],
      3: [null, "58 59 63", "61 70 74", "72 81", "73 82", "108", "105"],
      4: [null, "87 93 100", "78 101", "77:1-39", "77:40-72", "68", "106"],
    },
  };
  // La feuille vaut pour les féries, mémoires et dimanches ; pas pour les fêtes, solennités, octaves, Triduum.
  function feuilleAdmise(j) {
    if (j.temps === "triduum" || (j.temps === "paques" && j.semaine === 1) || /pentecôte/i.test(j.nom || "")) return false;
    if (j.temps === "noel" && !(j.niveau >= 10)) return false;
    if (j.source !== "temporal" && j.niveau <= 8) return false;
    if (j.source === "temporal" && j.celebration) return false;
    return true;
  }
  let ANT118 = null;   // antienne de Gouzes de chaque section du Ps 118 (tableau du temps ordinaire)
  function antienne118(id) {
    if (!ANT118) {
      ANT118 = {};
      for (const [k, o] of Object.entries(D?.offices || {})) if (k.startsWith("G/"))
        for (const e of o.psalmodie || []) if (e?.ant && e.pieces?.length === 1 && /^118-\d+$/.test(e.pieces[0].id)) ANT118[e.pieces[0].id] ||= { ant: e.ant, cote: e.cote, ton: e.ton };
    }
    return ANT118[id] || null;
  }
  function feuille(j, office) {
    const s = j.psautier || semaineTO(j);
    const v = FEUILLE[office]?.[s]?.[j.jourSemaine];
    if (!v || !feuilleAdmise(j)) return null;
    const piece = (x) => { const [id, versets] = x.split(":"); return versets ? { id, versets } : { id }; };
    if (office === "milieu") {
      const pieces = v.split("+").map(piece);
      const a = pieces.map((p) => antienne118(p.id)).find(Boolean);
      return [{ pieces, ...(a || {}) }];
    }
    return v.split(" ").map((x) => ({ pieces: x.split("&").map(piece) }));
  }

  function resoudre(j, office, mode) {
    const res = { notes: [] };
    if (!D || (mode !== "gouzantine" && mode !== "romaine-gouzes")) return null;
    let cles = clesPsalmodie(j, office, mode);
    // gouzantine, milieu du jour et vigiles : propres du temps d'abord, puis la feuille hebdomadaire
    // (qui remplace l'ancien milieu du jour du temps ordinaire et la psalmodie de l'AELF)
    const parFeuille = mode === "gouzantine" && (office === "milieu" || office === "lectures");
    if (parFeuille) cles = cles.filter((c) => !/^[GR]\/to\//.test(c));
    const p = premier(cles);
    res.psalmodie = p ? p.val : null;
    res.cle = p?.cle || null;
    if (parFeuille && !res.psalmodie) {
      res.psalmodie = feuille(j, office);
      if (res.psalmodie) { res.feuille = true; res.cle = `feuille/${office}/${j.psautier}/${JOURS[j.jourSemaine]}`; }
    }
    if (mode === "romaine-gouzes" && !res.psalmodie) res.antiennesProvince = antiennesProvince(j, office);
    // Province : répons de Gouzes écrits aux laudes et vêpres du temps (pas aux fêtes, qui ont leur propre)
    if (mode === "romaine-gouzes" && (office === "laudes" || office === "vepres")) {
      const jj = office === "vepres" && j.jourSemaine === 6 ? lendemain(j) : j;
      if (!(jj.niveau <= 8 && jj.source !== "temporal") && !(j.niveau <= 8 && j.source !== "temporal")) {
        res.repons = repons(j, office);
        if (res.repons) res.reponsProvince = true;
      }
    }
    const ev = premier(cles, "evangelique");
    res.evangelique = ev?.val || null;
    if (j.temps === "avent" && office === "vepres") {
      const d = +j.date.slice(8);
      if (j.date.slice(5, 7) === "12" && d >= 17 && d <= 23) res.evangelique = off(`G/avent/o${d}/vepres`)?.evangelique || res.evangelique;
    }
    if (mode === "gouzantine") {
      res.hymne = hymne(j, office);
      res.choral = choral(j, office);
      res.repons = repons(j, office);
      res.preces = preces(j, office);
      res.canon = canon(j, office);
      if (office === "laudes") res.invitatoire = premier(cles, "invitatoire")?.val || invitatoire(j);
      if (j.temps === "triduum" && office === "lectures") {
        res.tenebres = D.textes?.tenebres?.[JOURS[j.jourSemaine]] || null;
        res.tenebresPreces = D.textes?.tenebres_preces || null;
      }
    }
    return res;
  }

  g.Gouzes = { charger, chargerProvince, resoudre, antienneDeCote, ajouterCotes, remplacerCanon, canonDuJour: (j) => canon(j, "tout"), get donnees() { return D; } };
})(typeof window !== "undefined" ? window : globalThis);
