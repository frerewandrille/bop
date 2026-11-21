/* Capitules (lectures brèves) des laudes et vêpres de la Province dominicaine de Toulouse.
   Données : donnees/capitules.json (outils/capitules_province.py).

   Capitules.pour(jour, office) → { ref, origine } | null
*/
(function (g) {
  "use strict";
  let C = null;
  const charger = (c) => (C = c);
  const J = ["dim", "lun", "mar", "mer", "jeu", "ven", "sam"];
  const K = () => g.Calendrier;
  const lendemain = (j) => K().jour(K().iso(K().plus(K().deIso(j.date), 1)), { propreOP: true });
  const mmjj = (j) => j.date.slice(5);

  function commun(nom) {
    const n = (nom || "").toLowerCase();
    if (/dédicace/.test(n)) return "dedicace";
    if (/vierge marie|notre-dame|immaculé/.test(n)) return "vierge-marie";
    if (/apôtre/.test(n)) return "apotres";
    if (/martyr/.test(n)) return "martyrs";
    if (/docteur/.test(n)) return "docteurs";
    if (/pape|évêque|prêtre|abbé/.test(n)) return "pasteurs";
    if (/vierge/.test(n)) return "vierges";
    if (/défunts/.test(n)) return "defunts";
    return "saints";
  }

  function pour(j, office) {
    if (!C || (office !== "laudes" && office !== "vepres")) return null;
    // Samedi saint : vêpres propres
    if (j.temps === "triduum" && j.jourSemaine === 6 && office === "vepres") return { ref: C.triduum["vepres-samedi"], origine: "Samedi saint" };
    if (j.temps === "triduum") return null;

    let jj = j, ov = "laudes";
    if (office === "vepres") {
      const n = lendemain(j);
      const s1 = C.sanctoral?.[mmjj(n)];
      const premieres = n.jourSemaine === 0 || (n.niveau <= 4 && n.temps !== "triduum") || (s1?.vepres1 && n.cleSanctoral && n.niveau <= 8);
      if (premieres && !(n.temps === "paques" && n.semaine === 1 && n.jourSemaine === 0)) { jj = n; ov = "vepres1"; }
      else ov = j.jourSemaine === 0 || j.niveau <= 5 ? "vepres2" : "vepres";
    }
    const jour = J[jj.jourSemaine];
    const cle = ov === "vepres" ? "vepres2" : ov;
    const ret = (ref, origine) => (ref ? { ref, origine } : null);

    // 1. Sanctoral (propre de la Province, puis communs pour les fêtes)
    if (jj.cleSanctoral && jj.source !== "temporal") {
      const e = C.sanctoral?.[mmjj(jj)];
      // (sanctoral : capitule propre du saint ou du commun de la Province — préféré au commun des Heures grégoriennes)
      if (e && e[cle]) return { ...ret(e[cle], e.nom), sanctoral: true };
      if (e && ov === "vepres1") { /* pas de 1res vêpres propres : capitule du jour */ }
      else if (jj.niveau <= 8 && ov !== "vepres1") {
        const c = C.communs[commun(jj.nom)];
        if (c?.[cle]) return { ...ret(c[cle], "commun"), sanctoral: true };
      }
    }
    // 2. Fêtes du Seigneur après la Pentecôte
    const fete = /Trinité/.test(jj.nom) ? "trinite" : /Saint-Sacrement/.test(jj.nom) ? "saint-sacrement"
      : /Sacré-Cœur/.test(jj.nom) ? "sacre-coeur" : /Christ, Roi/.test(jj.nom) ? "christ-roi" : null;
    if (fete) return ret(C.fetes[fete][cle], jj.nom);

    // 3. Temps liturgique
    const T = jj.temps;
    if (T === "ordinaire") {
      const s8 = String((((jj.semaine || 1) - 1) % 8) + 1);
      if (ov === "laudes") return ret(C.to.laudes[s8]?.[jour], `semaine ${s8}`);
      return ret(C.to.vepres[s8]?.[ov === "vepres1" ? "sam" : jour], `semaine ${s8}`);
    }
    if (T === "avent") {
      const d = +j.date.slice(8), dec = j.date.slice(5, 7) === "12";
      if (ov === "laudes") {
        if (dec && d >= 17 && jj.jourSemaine !== 0) return ret(C.avent.laudes.dates[mmjj(j)], "féries de décembre");
        return ret(C.avent.laudes[String(Math.min(jj.semaine, 4))]?.[jour], `semaine ${jj.semaine}`);
      }
      if (dec && d >= 17 && C.avent.vepres.dates[mmjj(j)]) return ret(C.avent.vepres.dates[mmjj(j)], "féries de décembre");
      return ret(C.avent.vepres[String(jj.semaine)]?.[ov === "vepres1" ? "sam" : jour], `semaine ${jj.semaine}`);
    }
    if (T === "noel" || (ov === "vepres1" && T === "noel")) {
      const N = C.noel[ov === "laudes" ? "laudes" : "vepres"];
      const fetes = { "La Sainte Famille": "sainte-famille", "Épiphanie": "epiphanie", "Baptême": "bapteme" };
      for (const [m, k] of Object.entries(fetes)) if (jj.nom.startsWith(m) || jj.nom.includes(m)) {
        const v = N[k]; return ret(typeof v === "string" ? v : v?.[cle], jj.nom);
      }
      const epi = K().reperes(jj.date.slice(0, 4) * 1).epiphanie;
      if (jj.date.slice(5, 7) === "01" && K().deIso(jj.date) > epi) return ret(N["apres-epiphanie"]?.[jour], "après l'Épiphanie");
      return ret(N.dates[mmjj(ov === "vepres1" ? j : jj)], "temps de Noël");
    }
    if (T === "careme" || T === "semaine sainte") {
      const s = jj.semaine;
      const tab = s === 5 ? "5" : s === 6 ? "6" : s === 1 || s === 3 ? "impair" : "pair";
      const L = C.careme[ov === "laudes" ? "laudes" : "vepres"][tab];
      if (jj.jourSemaine === 0) {
        const e = L?.[`dim${s}`] ?? L?.dim;
        return ret(typeof e === "string" ? e : e?.[cle], `Carême, dimanche ${s}`);
      }
      return ret(L?.[jour], `Carême, semaine ${s}`);
    }
    if (T === "paques") {
      const s = jj.semaine, apres = (s === 6 && jj.jourSemaine >= 5) || s === 7 || (s === 6 && ov === "vepres1" && false);
      if (/^Ascension/.test(jj.nom)) { const v = C.paques[ov === "laudes" ? "laudes" : "vepres"].ascension; return ret(typeof v === "string" ? v : v[cle], "Ascension"); }
      if (/^Pentecôte/.test(jj.nom)) { const v = C.paques[ov === "laudes" ? "laudes" : "vepres"].pentecote; return ret(typeof v === "string" ? v : v[cle], "Pentecôte"); }
      if (ov === "laudes") {
        if (s === 1) return ret(C.paques.laudes["1"][jour], "octave de Pâques");
        if (apres || (s === 7)) return ret(C.paques.laudes["apres-ascension"][jour], "après l'Ascension");
        return ret(C.paques.laudes[s % 2 ? "impair" : "pair"][jour], `semaine ${s}`);
      }
      if (s === 1 && jj.jourSemaine === 0 && ov !== "vepres1") return ret(C.paques.vepres.paques, "Pâques");
      const apresV = s === 7 || (s === 6 && j.jourSemaine >= 4 && !/^Ascension/.test(j.nom)) || (ov === "vepres1" && s === 7);
      if (apresV) return ret(C.paques.vepres["apres-ascension"][ov === "vepres1" ? "sam" : jour], "après l'Ascension");
      return ret(C.paques.vepres[s % 2 ? "impair" : "pair"][ov === "vepres1" ? "sam" : jour], `semaine ${s}`);
    }
    return null;
  }

  const tenebres = (j) => (C && j.temps === "triduum" ? C.triduum.tenebres[J[j.jourSemaine]] || null : null);

  g.Capitules = { charger, pour, tenebres, get donnees() { return C; } };
})(typeof window !== "undefined" ? window : globalThis);
