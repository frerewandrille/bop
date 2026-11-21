/* Office du milieu du jour selon le carnet de la Province (donnees/milieu.json).

   Milieu.pour(jour) → { ps: [ids du psautier], versets: [[V, R], …], hymnes: [[lignes]…], titre, notes }
*/
(function (g) {
  "use strict";
  let M = null;
  const charger = (m) => (M = m);
  const J = ["dim", "lun", "mar", "mer", "jeu", "ven", "sam"];
  const JL = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"];
  const sa = (s) => (s || "").normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase().replace(/’/g, "'");
  const bloc = (motif) => M.blocs.find((b) => motif.test(b.titre));
  const parDate = (mmjj) => M.blocs.find((b) => b.date === mmjj);
  const ROM = { i: 1, ii: 2, iii: 3, iv: 4, v: 5, vi: 6, vii: 7 };

  function versetsDe(b, cles) {
    for (const c of cles) if (b?.versets?.[c]?.length) return b.versets[c];
    const v = b?.versets ? Object.values(b.versets)[0] : null;
    return v || [];
  }

  // commun du carnet d'après le nom de la célébration
  function communDe(nom) {
    const n = (nom || "").toLowerCase();
    if (/apôtre|pierre et saint paul/.test(n)) return "Commun des Apôtres";
    if (/martyrs/.test(n)) return "Commun des martyrs";
    if (/martyr/.test(n)) return "Commun d’un martyr";
    if (/pape|évêque|prêtre|abbé|docteur/.test(n)) return "Commun des Pasteurs & docteurs";
    if (/vierge/.test(n) && !/vierge marie/.test(n)) return "Commun des vierges";
    if (/\b(sainte|ste|bse|bienheureuse)\b/.test(n)) return "Commun des saintes";
    return "Commun des saints";
  }

  function hebdo(j, semaine) {
    const s = String(semaine || j.psautier || 1);
    return M.hebdo?.[s]?.[J[j.jourSemaine]] || null;
  }

  function pour(j) {
    if (!M) return null;
    const jour = J[j.jourSemaine];
    const careme = j.temps === "careme" || j.temps === "semaine sainte" || j.temps === "triduum";
    const h = hebdo(j);
    const psDuJour = (sem) => {
      const x = hebdo(j, sem);
      return x ? (careme && x.ps_careme ? x.ps_careme : x.ps) : null;
    };
    const saison = j.temps === "avent" ? ["avent", "to"] : careme ? [`careme-${j.semaine}`, "careme", "to"] : j.temps === "paques" ? ["paques", "to"] : ["to"];
    let res = { ps: psDuJour(), versets: versetsDe(h, saison), titre: null, notes: [], pages: h?.pages || [] };

    // fêtes et temps propres
    let b = null;
    const nom = j.nom || "";
    if (j.date.slice(5) === "12-25") b = bloc(/^Nativité du Seigneur/);
    else if (/Sainte Famille/.test(nom)) b = bloc(/^La Sainte Famille/);
    else if (j.temps === "noel" && /^12-(2[6-9]|3[01])$/.test(j.date.slice(5))) b = parDate(j.date.slice(5)) || bloc(/^Octave de la Nativité/);
    else if (j.date.slice(5) === "01-01") b = parDate("01-01");
    else if (/^Épiphanie/.test(nom)) b = bloc(/^Epiphanie du Seigneur/);
    else if (/^Baptême du Seigneur/.test(nom)) b = bloc(/^Baptême du Seigneur/);
    else if (j.temps === "noel" && j.date.slice(5, 7) === "01") {
      const epi = g.Calendrier.reperes(+j.date.slice(0, 4)).epiphanie;
      b = g.Calendrier.deIso(j.date) < epi ? bloc(/^Du 2 au 7 janvier/) : bloc(/^Du lundi au samedi après/);
    }
    else if (/Rameaux/.test(nom)) b = bloc(/^Dimanche des Rameaux/);
    else if (j.temps === "semaine sainte" || (j.temps === "triduum" && j.jourSemaine === 4)) b = bloc(/^Du lundi au jeudi Saint/);
    else if (/^Vendredi saint/i.test(nom)) b = bloc(/^Vendredi Saint/);
    else if (/^Samedi saint/i.test(nom)) b = bloc(/^Samedi Saint/);
    else if (/^Ascension/.test(nom)) b = bloc(/^Ascension du Seigneur/);
    else if (/^Pentecôte/.test(nom)) b = bloc(/^Pentecôte/);
    else if (/Trinité/.test(nom)) b = bloc(/^La Sainte Trinité/);
    else if (/Saint-Sacrement/.test(nom)) b = bloc(/^Le Saint-Sacrement/);
    else if (/Sacré-Cœur/.test(nom)) b = bloc(/^Le Sacré C/);
    else if (j.temps === "paques") {
      if (j.semaine === 1) b = j.jourSemaine === 0 ? bloc(/^Dimanche de Pâques/) : bloc(/^Octave de Pâques/);
      else if (j.jourSemaine === 0) b = j.semaine === 7 ? bloc(/^7e dimanche de Pâques/) : bloc(/^Dimanche de Pâques/);
      else b = bloc(new RegExp("^" + JL[j.jourSemaine].replace(/^./, (c) => c.toUpperCase()) + "s du Temps pascal"));
    }
    if (!b && j.cleSanctoral && j.source !== "temporal") b = parDate(j.date.slice(5));
    let solenniteCommune = false;
    if (!b && j.niveau <= 8 && j.source !== "temporal") {        // fête ou solennité sans propre : commun
      b = M.blocs.find((x) => x.titre === communDe(nom)) || M.blocs.find((x) => x.titre === "Communs");
      solenniteCommune = j.niveau <= 4;
    }

    if (b) {
      res.titre = b.titre;
      res.notes = b.notes || [];
      if (b.pages?.length && !/^semaine/.test(b.ps || "")) res.pages = b.pages;
      else if (b.pages?.length) res.pages = b.pages.concat(res.pages);
      if (Object.keys(b.versets || {}).length) res.versets = versetsDe(b, saison.concat(["commun"]));
      // psaumes du bloc
      if (Array.isArray(b.ps)) res.ps = b.ps;
      else if (b.ps === "semaine") res.ps = psDuJour();
      else if (/^semaine-\d$/.test(b.ps || "")) res.ps = psDuJour(+b.ps.slice(8));
      if (b.regles?.length) {
        const r = b.regles.find((x) => {
          const q = sa(x.quand);
          if (q === "dimanche") return j.jourSemaine === 0;
          if (q === "en semaine") return j.jourSemaine !== 0;
          if (q.startsWith(JL[j.jourSemaine])) return true;                                  // « Lundi Saint », « Lundi de l'Octave »
          const md = /^(\d{1,2}) janvier$/.exec(q);
          if (md) return j.date.slice(5) === `01-${md[1].padStart(2, "0")}`;
          const ms = /^semaines? ([ivx]+)(?: & ([ivx]+))?$/.exec(q);
          if (ms) return [ms[1], ms[2]].filter(Boolean).some((x) => ROM[x] === j.semaine);
          return false;
        });
        if (r) res.ps = r.ps;
      }
    }
    // solennité sans propre : psaumes graduels (série II, celle de sexte)
    if (solenniteCommune) {
      const c = M.blocs.find((x) => x.titre === "Communs");
      const r = c?.regles?.find((x) => /^S[ée]rie II$/.test(x.quand));
      if (r) { res.ps = r.ps; res.notes = res.notes.concat(["Solennité sans propre : psaumes graduels (série II)."]); }
    }
    // antienne (livret de Marseille) : celle du bloc, « ci-dessus » = celle du bloc précédent, sinon celle de la férie
    let ants = b?.antiennes;
    if (!ants?.length && b && (b.notes || []).some((n) => /ci-dessus/i.test(n))) {
      const i = M.blocs.indexOf(b);
      for (let k = i - 1; k >= 0 && !ants?.length; k--) ants = M.blocs[k].antiennes;
    }
    if (!ants?.length) ants = (hebdo(j, /^semaine-\d$/.test(b?.ps || "") ? +b.ps.slice(8) : undefined) || h)?.antiennes;
    res.antiennes = ants || [];
    // hymnes du temps
    const H = M.hymnes || {};
    res.hymnes = careme ? H.careme : j.temps === "paques" ? H.paques : H.to;
    res.hymnesGregoriennes = H.gregoriennes;
    // hymnes grégoriennes (partitions) selon le temps
    const C = g.Calendrier, mm = j.date.slice(5), jj = +j.date.slice(8);
    const avantEpi = j.temps === "noel" && (mm.startsWith("12") || C.deIso(j.date) < C.reperes(+j.date.slice(0, 4)).epiphanie);
    const tg = careme ? "careme" : j.temps === "paques" ? "paques" : j.temps === "avent" ? (mm.startsWith("12") && jj >= 17 ? "avent-17" : "avent")
      : avantEpi ? "noel" : j.niveau <= 4 ? "solennite" : "ordinaire";
    res.gregoriennes = (M.gregoriennes_temps?.[tg] || []).map((k) => M.gregoriennes?.[k]).filter(Boolean);
    return res;
  }

  // partition d'une antienne connue par son texte (pour la répartition gouzantine)
  function partitionDe(texte) {
    if (!M || !texte) return null;
    const n = (x) => (x || "").normalize("NFD").replace(/[^a-zA-Z]/g, "").toLowerCase();
    const t = n(texte);
    const tous = Object.values(M.hebdo || {}).flatMap((s) => Object.values(s)).concat(M.blocs || []).flatMap((x) => x.antiennes || []);
    return tous.find((a) => n(a.ant) === t)?.partition || null;
  }

  g.Milieu = { charger, pour, partitionDe, get donnees() { return M; } };
})(typeof window !== "undefined" ? window : globalThis);
