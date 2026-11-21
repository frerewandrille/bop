/* Partitions : quelle image de partition poser sous quel texte de l'office.

   Place dans l'ensemble : appelé par offices.js (qui place les pièces) et latin.js. Ce module ne construit
   pas l'office ; il répond à « pour ce jour et cet office, quelles partitions, dans quel rôle ? ».
   Images et index sont fabriqués sur le Mac par les programmes de outils/ et rangés dans partitions/ :
     - carnets « Perdrix » de la Province (to, avent, noel, careme, paques, sanctoral1-2, sj, op, milieu,
       complies, marseille) : partitions/index.json, <carnet>/pieces.json, decoupes.json ; fêtes : ordo.json ;
     - Sainte-Baume (sb/), Heures grégoriennes (hg/, hg1-3/), pièces gravées depuis LilyPond (ly/) ;
     - corrections faites à la main : partitions/corrections.json (voir docs/CORRIGER-UNE-PARTITION.md).
   En local, outils/serveur.py sert le dossier partitions/ ; en ligne, les images sont dans l'entrepôt Azure
   privé (adresse dans <meta name="fichiers">, clé window.CLE_FICHIERS posée par cle-fichiers.js).
   Sans index (partitions absentes), rien n'est affiché et les versions « avec partitions » sont masquées.

   Partitions.pour(jour, office) → [{ role, titre, carnet, pages: [n…] }]
*/
(function (g) {
  "use strict";
  let I = null;
  const JOURS = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"];
  const ROLES = { invitatoire: "Invitatoire", hymne: "Hymne", lucernaire: "Lucernaire", antiennes: "Psalmodie (antiennes)",
    cantique: "Cantique du Nouveau Testament", "cantique-at": "Cantique", repons: "Répons", benedictus: "Antienne du Benedictus",
    magnificat: "Antienne du Magnificat", priere: "Louanges, intercessions & Notre Père", choral: "Choral", alleluia: "Alléluia",
    canon: "Grand Canon de saint André", tedeum: "Te Deum", acclamation: "Acclamation de l'Évangile", mariale: "Antienne mariale" };
  const ORDRE = Object.keys(ROLES);

  const PIECES = {};   // carnet → page → [pièces découpées]
  async function charger(url = "partitions/index.json") {
    try { const r = await fetch(url, { cache: "no-cache" }); I = r.ok ? await r.json() : null; } catch (e) { I = null; }
    if (I) await Promise.all(Object.keys(I.carnets || {}).map(async (c) => {
      try {
        const r = await fetch(`partitions/${c}/pieces.json`, { cache: "no-cache" });
        if (!r.ok) return;
        PIECES[c] = {};
        for (const x of await r.json()) (PIECES[c][x.page] ||= []).push(x);
      } catch (e) { /* pas de découpage : pages entières */ }
    }));
    if (I) await Promise.all([chargerSB(), chargerHG(), chargerOrdo(), chargerDecoupes(), chargerLY()]);
    return !!I;
  }
  // Partitions gouzantines gravées depuis leurs sources LilyPond (outils/graver_lilypond.py) :
  // texte (40 premières lettres, comme normal()) → image, seulement si les paroles de la source correspondent
  let LY = {}, LY_NT = {}, LY_COTES = {};
  async function chargerLY() {
    try { const r = await fetch("partitions/ly/index.json", { cache: "no-cache" }); const d = r.ok ? await r.json() : {}; LY = d.textes || {}; LY_NT = d.cantiques || {}; LY_COTES = d.cotes || {}; } catch (e) { LY = {}; LY_NT = {}; LY_COTES = {}; }
  }
  // pièce gravée d'après sa cote (« K 731 » → [image, versets du répons]) : même cote = même pièce
  const parCote = (c) => { const f = LY_COTES[String(c || "").replace(/\s+/g, "").toUpperCase()]; return f && f.length ? f.slice() : null; };
  const grave = (t) => { const f = LY[normal(t).slice(0, 40)]; return f ? [f] : null; };
  // cantique du NT gravé en entier, par son numéro dans le psautier (« NT6 » = Ep 1)
  const cantiqueGrave = (id) => (LY_NT[id] ? [LY_NT[id]] : null);
  // Pages d'antiennes coupées entre les étiquettes des psaumes (outils/antiennes_pages.py) :
  // une pièce par antienne ; les renvois directs aux anciennes pièces sont redirigés
  let DECOUPES = {};
  async function chargerDecoupes() {
    try {
      const r = await fetch("partitions/decoupes.json", { cache: "no-cache" });
      if (!r.ok) return;
      const d = await r.json();
      for (const [c, pages] of Object.entries(d.pages || {})) if (PIECES[c]) for (const [p, xs] of Object.entries(pages)) PIECES[c][p] = xs;
      DECOUPES = d.fichiers || {};
    } catch (e) { /* découpage d'origine */ }
  }

  // Pièces (partitions découpées) des pages retenues pour un office
  function piecesPour(j, office) {
    if (!I) return [];
    const vu = new Set(), out = [];
    for (const e of pour(j, office)) {
      for (const p of e.pages) {
        const ps = PIECES[e.carnet]?.[p];
        const liste = ps?.length ? ps.map((x) => ({ ...x, fichier: `${e.carnet}/${x.fichier}` }))
          : [{ page: p, fichier: `${e.carnet}/p-${String(p).padStart(3, "0")}.jpg`, ids: [], cotes: [], pageEntiere: true }];
        let gardes = liste;
        if (e.filtre === "*") {
          // antienne commune à plusieurs dimanches (le psaume seul change) : placée par son rang dans l'office
          gardes = gardes.map((x) => ({ ...x, ids: [], cotes: [] }));
        } else if (e.filtre) {
          const re = new RegExp(e.filtre.replace(/(\d) ?(er|res|e|es)\b/g, "$1 ?$2"));
          const f = liste.filter((x) => re.test(`${x.dessous || ""} ${x.dessus || ""}`));
          if (f.length) gardes = f;
        }
        // deux pièces au-dessus de la même étiquette : seule la dernière est l'antienne de ce psaume
        gardes = gardes.map((x, i) => (gardes[i + 1] && x.dessous && gardes[i + 1].dessous === x.dessous && (x.ids || []).length ? { ...x, ids: [] } : x));
        for (const x of gardes) {
          if (vu.has(x.fichier)) continue;
          vu.add(x.fichier);
          if (x.nature === "image" || x.nature === "titre") continue;      // gravure, ligne de titre
          out.push({ ...x, role: e.role, titre: e.titre, carnet: e.carnet, nomCarnet: I.carnets?.[e.carnet]?.nom || e.carnet, alt: !!e.alt });
        }
      }
    }
    return out;
  }

  function carnetDu(j) {
    switch (j.temps) {
      case "avent": return "avent";
      case "noel": return "noel";
      case "careme": case "semaine sainte": case "triduum": return "careme";
      case "paques": return "paques";
      default: return "to";
    }
  }

  function pour(j, office) {
    if (!I) return [];
    const C = g.Calendrier;
    let jj = j, oe = office;
    // samedi soir (et veille de fête) : 1res vêpres du lendemain
    if (office === "vepres") {
      const n = C.jour(C.iso(C.plus(C.deIso(j.date), 1)));
      if (n.jourSemaine === 0) { jj = n; oe = "vepres1"; }
      else if (j.jourSemaine === 0) oe = "vepres2";
    }
    const carnet = carnetDu(jj);
    const jour = JOURS[jj.jourSemaine];
    const s4 = jj.psautier || 1;
    const s8 = (((jj.semaine || 1) - 1) % 8) + 1;
    const semaineSaison = carnet === "to" ? s4 : jj.semaine;
    const d = +jj.date.slice(8), prep = jj.temps === "avent" && jj.date.slice(5, 7) === "12" && d >= 17;

    const ok = (p) => {
      if (p.carnet !== carnet) return false;
      // office
      if (p.role === "mariale") return office === "complies";
      if (p.role === "invitatoire") { if (office !== "laudes") return false; }
      else if (p.office) {
        if (p.office === "vepres") { if (!oe.startsWith("vepres")) return false; if (oe !== "vepres" && p.jours && !p.jours.some((x) => x === "dimanche" || x === "samedi")) return false; }
        else if (p.office !== oe) return false;
      } else if (p.role === "cantique") {
        if (!oe.startsWith("vepres")) return false;
      } else return false;
      if (office === "complies") return false;
      if (p.role === "cantique" && !p.jours) return false;
      if (p.jours_prep) return prep && p.jours_prep.includes(d - 16);
      if (p.prep) return prep;
      // jour
      if (p.jours) {
        const voulus = oe === "vepres1" ? ["samedi", "dimanche"] : [jour];
        if (!p.jours.some((x) => voulus.includes(x))) return false;
      }
      // semaine
      if (p.semaines && p.semaines.length) {
        const huit = carnet === "to" && (p.semaines.some((x) => x > 4) || p.role === "repons" || p.role === "priere" || (p.jours?.includes("dimanche") && p.office === "lectures"));
        const s = huit ? s8 : semaineSaison;
        if (!p.semaines.includes(s)) return false;
      }
      if (p.annee && p.annee !== jj.cycle) return false;
      if (p.date && p.date !== jj.date.slice(5)) return false;
      if (prep && p.semaines && carnet === "avent") return false;
      if (p.dimanche && jj.jourSemaine === 0 && p.dimanche !== jj.semaine) return false;
      return true;
    };
    let res = I.pages.filter(ok).map((p) => ({ role: p.role || "antiennes", titre: p.titre, carnet: p.carnet, pages: [p.page, ...(p.suite || [])] }));
    // hymnes, lucernaires et invitatoires : table explicite des carnets (hymnesTemps), qui remplace le choix par titres
    const ht = hymnesTemps(j, office);
    if (ht) {
      const roles = new Set(["hymne", "lucernaire", "invitatoire", ...ht.map((x) => x.role)]);
      ht.forEach((x, i) => { x._h = i; }); res = res.filter((x) => !roles.has(x.role)).concat(ht);
    }
    // louanges et intercessions : table explicite (prieresTemps), qui remplace le choix par titres
    const pt = prieresTemps(j, office);
    if (pt) res = res.filter((x) => x.role !== "priere").concat(pt);
    res = res.map((x, i) => ({ ...x, _i: i }));
    res = res.filter((x) => x.pages.length);
    res.sort((a, b) => ORDRE.indexOf(a.role) - ORDRE.indexOf(b.role) || (a._h != null && b._h != null ? a._h - b._h : a.pages[0] - b.pages[0]));
    return res;
  }

  // ── Hymnes, lucernaires et invitatoires des carnets du temps, d'après leur sommaire (pages du PDF).
  //    null = pas de règle ici (on garde le choix par titres) ; alt = « au choix ».
  // Canon de saint André de Crète (livret de Carême, p. 28-57) : page où commence chaque jour, dans l'ordre
  const CANON = [["0/3", 28], ["0/4", 29], ["0/5", 29], ["0/6", 30], ["1/0", 31], ["1/1", 31], ["1/2", 32], ["1/3", 33], ["1/4", 34], ["1/5", 34], ["1/6", 35],
    ["2/0", 36], ["2/1", 36], ["2/2", 37], ["2/3", 38], ["2/4", 39], ["2/5", 39], ["2/6", 40], ["3/0", 41], ["3/1", 41], ["3/2", 42], ["3/3", 43], ["3/4", 43], ["3/5", 44], ["3/6", 45],
    ["4/0", 45], ["4/1", 46], ["4/2", 47], ["4/3", 47], ["4/4", 48], ["4/5", 49], ["4/6", 49], ["5/0", 50], ["5/1", 51], ["5/2", 52], ["5/3", 52], ["5/4", 53], ["5/5", 54], ["5/6", 54],
    ["6/0", 55], ["6/1", 56], ["6/2", 56], ["6/3", 57]];
  function pagesCanon(j) {
    const i = CANON.findIndex(([k]) => k === `${j.semaine || 0}/${j.jourSemaine}`);
    if (i < 0) return null;
    const a = CANON[i][1], b = i + 1 < CANON.length ? CANON[i + 1][1] : 57;
    return [...new Set([28, ...suite(a, Math.max(a, b))])];       // p. 28 : introduction et ton de la psalmodie
  }
  const suite = (a, b = a) => Array.from({ length: b - a + 1 }, (_, i) => a + i);
  // ── Louanges (laudes), intercessions (vêpres) et Notre Père des carnets du temps (pages du PDF).
  //    Temps ordinaire : 8 semaines (semaine du temps ordinaire ramenée de 1 à 8, comme les répons).
  //    Fêtes du sanctoral et temps de Noël : ordo (ordoPour). null = rien du carnet du temps.
  function prieresTemps(j, office) {
    if (office !== "laudes" && office !== "vepres") return null;
    const C = g.Calendrier, dem = C.jour(C.iso(C.plus(C.deIso(j.date), 1)));
    const jj = office === "vepres" && dem.jourSemaine === 0 ? dem : j;      // samedi soir : dimanche
    if (jj.niveau <= 8 && jj.source !== "temporal") return null;
    const L = office === "laudes", dim = jj.jourSemaine === 0;
    const P = (carnet, titre, a, b) => [{ role: "priere", titre, carnet, pages: suite(a, b) }];
    switch (jj.temps) {
      case "ordinaire": {
        if (jj.celebration && jj.source === "temporal") return null;      // Trinité, Christ-Roi… : ordo
        const s8 = (((jj.semaine || 1) - 1) % 8) + 1;
        const p = (I?.pages || []).find((x) => x.carnet === "to" && x.role === "priere" && x.semaines?.[0] === s8 && (L ? /^Louanges/ : /^Intercessions/).test(x.titre));
        return p ? [{ role: "priere", titre: p.titre, carnet: "to", pages: [p.page, ...(p.suite || [])] }] : null;
      }
      case "avent":
        if (dim) return L ? P("avent", "Louanges & Notre Père (dimanches)", 78, 80) : P("avent", "Intercessions & Notre Père (dimanches)", 28, 29);
        return L ? P("avent", "Louanges & Notre Père (féries)", 190, 191) : P("avent", "Intercessions & Notre Père (féries)", 224, 226);
      case "careme": case "semaine sainte":
        return P("careme", "Preces & Notre Père", 282, 283);
      case "paques": {
        const sem = jj.semaine || 1;
        if (sem === 1 || (dim && sem === 2)) return L ? P("paques", "Prière litanique (octave de Pâques)", 20, 23) : P("paques", "Prière litanique (octave de Pâques)", 38, 40);
        return L ? P("paques", "Laudes - Prière litanique", 350, 351) : P("paques", "Vêpres - Prière litanique", 352, 353);
      }
      case "noel":
        return L ? P("noel", "Prière litanique des laudes", 42, 43) : P("noel", "Prière litanique des vêpres", 48, 49);
    }
    return null;
  }
  function hymnesTemps(j, office) {
    const C = g.Calendrier;
    const dem = C.jour(C.iso(C.plus(C.deIso(j.date), 1)));
    const soirDim = office === "vepres" && dem.jourSemaine === 0;          // samedi soir : dimanche
    const jj = soirDim ? dem : j;
    const dim = jj.jourSemaine === 0;
    const out = [];
    const P_ = (carnet, role, titre, a, b, alt, filtre) => out.push({ role, titre, carnet, pages: suite(a, b ?? a), alt: !!alt, ...(filtre ? { filtre } : {}) });
    const jr = JOURS[jj.jourSemaine], pv = office === "vepres" && soirDim, v2 = office === "vepres" && dim && !soirDim;
    const serie = (carnet, role, nom, plages) => plages.forEach(([a, b], i) => P_(carnet, role, `${nom} (${["I", "II", "III", "IV", "V", "VI", "VII"][i]})`, a, b, i > 0));
    const mm = jj.date.slice(5), d = +jj.date.slice(8);
    if (jj.niveau <= 8 && jj.source !== "temporal") return null;         // sanctoral : ordo
    switch (jj.temps) {
      case "ordinaire": {
        if (!dim || jj.celebration) return null;                           // féries : hymnes par jour (titres) ; Trinité… : sanctoral
        const ps = jj.psautier || 1, s8 = (((jj.semaine || 1) - 1) % 8) + 1;
        if (office === "vepres") { P_("to", "lucernaire", `Lucernaire semaine ${ps}`, 66 + 2 * ps, 67 + 2 * ps); P_("to", "hymne", "Ires & IIes Vêpres du dimanche", 6, 7); }
        if (office === "lectures") {
          P_("to", "invitatoire", "Vigiles - Invitatoires", s8 % 4 === 1 || s8 % 4 === 2 ? 8 : 9); P_("to", "invitatoire", "Psaume 94", 10, 13);
          const a = 14 + 2 * ((s8 - 1) % 4); P_("to", "hymne", `Vigiles - Dimanches ${["I & V", "II & VI", "III & VII", "IV & VIII"][(s8 - 1) % 4]}`, a, a + 1);
        }
        if (office === "laudes") {
          P_("to", "hymne", `Gloria semaine ${ps}`, 40 + 2 * ps, 41 + 2 * ps);
          const L = [[22], [23], [24], [25], [26, 27], [28, 29], [30, 31], [32]][s8 - 1]; P_("to", "hymne", `Laudes - Dimanche ${s8}`, L[0], L[1]);
        }
        return out.length ? out : null;
      }
      case "avent": {
        const prep = mm.startsWith("12") && d >= 17;
        if (dim) {
          if (office === "vepres") { P_("avent", "lucernaire", "Lucernaire des dimanches", 6, 7); P_("avent", "hymne", "Hymne des vêpres (dimanches)", 8, 11); }
          if (office === "lectures") { P_("avent", "invitatoire", "Invitatoires", 31, 35); P_("avent", "hymne", "Hymne des vigiles", 36, 41); }
          if (office === "laudes") P_("avent", "hymne", "Hymne des laudes (dimanches)", 72, 75);
          const n = jj.semaine, F = n === 1 ? "1er dimanche" : `${n}e dimanche`;
          const REP = [[44, 47], [50, 53], [56, 59], [63, 67]][n - 1], CHO = [[48, 49], [54, 55], [60, 62], [68, 70]][n - 1];
          if (pv) { P_("avent", "antiennes", `Ires Vêpres — ${F}`, 12, 13, false, "*"); P_("avent", "cantique", "Cantique NT VII", 14, 17); }
          if (v2) { P_("avent", "antiennes", "IIes Vêpres — Psaume 109", 18); P_("avent", "antiennes", `IIes Vêpres — ${F}`, 19, 19, false, "*"); P_("avent", "cantique", "Cantique NT XIV", 20, 21); }
          if (office === "vepres") {
            P_("avent", "repons", "Répons des vêpres (dimanches)", 22, 23);
            if (n <= 3 && !prep) P_("avent", "magnificat", `Antienne à Magnificat — ${F}`, 23 + n, 23 + n, false, pv ? "1res" : "2es");
          }
          if (office === "lectures") { P_("avent", "antiennes", `Vigiles — ${F}`, 42, 43, false, "*"); P_("avent", "repons", `Répons du ${F}`, REP[0], REP[1]); P_("avent", "choral", `Choral du ${F}`, CHO[0], CHO[1]); }
          if (office === "laudes") { P_("avent", "antiennes", `Laudes — ${F}`, 76, 77, false, "*"); P_("avent", "repons", `Répons du ${F}`, REP[0], REP[1]); }
        } else if (office === "laudes") {
          const sl = prep ? [182, 183] : [[164, 165], [170, 171], [176, 177]][Math.min(jj.semaine, 3) - 1];
          P_("avent", "repons", prep ? "Répons des laudes de la semaine préparatoire à Noël" : `Répons des laudes - Semaine ${Math.min(jj.semaine, 3)}`, sl[0], sl[1]);
          if (prep) { P_("avent", "hymne", "Hymne des laudes (VI) — du 17 au 24 décembre", 88, 89); P_("avent", "hymne", "Hymne des laudes (VII) — du 17 au 24 décembre", 90, 91, true); }
          else serie("avent", "hymne", "Hymne des laudes", [[82, 83], [84], [85], [86], [87]]);
        } else if (office === "vepres") {
          P_("avent", "repons", "Répons des vêpres de l'Avent", 192, 195);
          if (prep) { P_("avent", "hymne", "Hymne des vêpres (VI) — du 17 au 24 décembre", 101); P_("avent", "hymne", "Hymne des vêpres (VII) — du 17 au 24 décembre", 102, 103, true); }
          else serie("avent", "hymne", "Hymne des vêpres", [[92, 93], [94, 95], [96, 97], [98, 99], [100]]);
        }
        return out.length ? out : null;
      }
      case "careme": case "semaine sainte": {
        const sem = jj.semaine || 0;
        if (office === "vepres") {
          if (dim) P_("careme", "lucernaire", "Lucernaire des dimanches", 20, 21); else P_("careme", "lucernaire", "Lucernaire des féries", 22, 23);
          if (jj.temps === "semaine sainte" || sem === 6) { P_("careme", "hymne", "Hymnes de la Passion — Voici que les étendards", 58); P_("careme", "hymne", "Mystère du Calvaire", 59, 59, true); P_("careme", "hymne", "Vexilla Regis", 60, 61, true); }
          else {
            ["Christ, serviteur du Dieu vivant", "Créateur et Père très bon", "Du plus profond de ma misère", "En ta bonté, Seigneur", "En toi, ô Dieu, soit mon refuge", "Prends pitié de moi, Seigneur", "La nuit profonde a disparu"]
              .forEach((t, i) => P_("careme", "hymne", `Hymnes des vêpres — ${t}`, 11 + i, 11 + i, i > 0));
            P_("careme", "hymne", "Hymnes des vêpres — Audi, benigne Conditor", 18, 19, true);
          }
        }
        if (office === "lectures" && dim) {
          P_("careme", "invitatoire", "Invitatoires", sem <= 2 ? 4 : sem <= 4 ? 5 : 6); P_("careme", "invitatoire", "Psaume 94 - Ton du Carême", 7, 10);
          P_("careme", "hymne", "Hymne des Vigiles", 24, 25);
        }
        if (!dim && (office === "laudes" || office === "vepres")) {
          const cendres = sem === 0 && jj.jourSemaine === 3;
          const L = { 0: 212, 1: 204, 2: 208, 3: 210, 4: 212, 5: 214, 6: 216 }, V = { 0: 224, 1: 218, 2: 220, 3: 222, 4: 224, 5: 226, 6: 228 };
          const a = cendres ? 202 : (office === "laudes" ? L : V)[sem];
          if (a) P_("careme", "repons", cendres ? "Répons Mercredi des Cendres" : `Répons ${office === "laudes" ? "Laudes" : "Vêpres"} - ${sem === 0 || sem === 4 ? "Semaine des Cendres et IV" : sem === 6 ? "Semaine Sainte" : "Semaine " + sem}`, a, sem === 1 && office === "laudes" && !cendres ? 207 : a + 1);
        }
        if (v2) P_("careme", "cantique", "Cantique du Nouveau Testament (dimanche)", 180, 185);
        // le canon de saint André de Crète tient lieu d'hymne : aux vigiles, et aux laudes des féries
        const pc = pagesCanon(jj);
        if (pc && (office === "lectures" || (office === "laudes" && !dim)))
          out.push({ role: "hymne", titre: "Canon de saint André de Crète", carnet: "careme", pages: pc, alt: office === "lectures" && dim, canon: true });
        if (office === "laudes" && dim) P_("careme", "hymne", "Hymnes - Laudes du dimanche", 26, 27);
        return out.length ? out : null;
      }
      case "paques": {
        const sem = jj.semaine || 1, js = jj.jourSemaine;
        const asc = /^Ascension/.test(jj.nom || ""), pent = /^Pentecôte/.test(jj.nom || "");
        const veilleAsc = office === "vepres" && /^Ascension/.test(dem.nom || "");
        const apresAsc = !asc && ((sem === 6 && js >= 5) || sem === 7) && !dim;
        const lv = office === "laudes" || office === "vepres";
        const NTV = () => (pv ? P_("paques", "cantique", "Cantique NT VII", 324, 326) : v2 ? P_("paques", "cantique", "Cantique NT XIV", 327, 328) : null);
        if (pent) {
          if (office === "vepres") { P_("paques", "lucernaire", "Lucernaire de la Pentecôte", 294, 296); P_("paques", "hymne", "Hymne - Pentecôte", 297, 299); P_("paques", "hymne", "Veni Creator", 242, 243, true); }
          if (office === "lectures") { P_("paques", "invitatoire", "Invitatoire de la Pentecôte", 301, 305); P_("paques", "hymne", "Hymne - Pentecôte", 297, 299); P_("paques", "hymne", "Veni Creator", 242, 243, true); }
          if (office === "laudes") { P_("paques", "hymne", "Hymne (laudes II, après l'Ascension)", 234, 235); P_("paques", "hymne", "Veni Creator", 242, 243, true); P_("paques", "hymne", "Choral de la Pentecôte", 318, 319, true); }
          if (pv) { P_("paques", "antiennes", "Ires Vêpres de la Pentecôte", 300); P_("paques", "repons", "Répons des vigiles (I)", 310, 311); }
          if (v2) { P_("paques", "antiennes", "IIes Vêpres de la Pentecôte", 322); P_("paques", "cantique", "Cantique NT XIV", 327, 328); P_("paques", "repons", "Répons des vigiles (III)", 314, 315); }
          if (office === "lectures") { P_("paques", "antiennes", "Vigiles de la Pentecôte", 306, 308); P_("paques", "repons", "Répons des vigiles (I)", 310, 311); P_("paques", "repons", "Répons des vigiles (II)", 312, 313, true); P_("paques", "repons", "Répons des vigiles (III)", 314, 315, true); P_("paques", "choral", "Choral de la Pentecôte", 318, 319); }
          if (office === "laudes") { P_("paques", "antiennes", "Laudes de la Pentecôte", 320, 321); P_("paques", "repons", "Répons des vigiles (III)", 314, 315); }
        } else if (asc || veilleAsc) {
          if (office === "vepres") { P_("paques", "lucernaire", "Lucernaire de l'Ascension", 196, 198); P_("paques", "hymne", "Hymne de l'Ascension", 199, 205); }
          if (office === "lectures") { P_("paques", "invitatoire", "Invitatoire de l'Ascension", 209, 213); P_("paques", "hymne", "Hymne de l'Ascension", 199, 205); }
          if (office === "laudes") P_("paques", "hymne", "Hymne de l'Ascension", 199, 205);
          if (veilleAsc) { P_("paques", "antiennes", "Ires Vêpres de l'Ascension", 202, 205); P_("paques", "repons", "Répons des Ires vêpres", 206, 208); }
          else if (office === "vepres") { P_("paques", "antiennes", "IIes Vêpres de l'Ascension", 228, 229, false, "*"); P_("paques", "repons", "Répons des vigiles (I)", 216, 217); }
          if (office === "lectures") { P_("paques", "antiennes", "Vigiles de l'Ascension", 214, 215); P_("paques", "repons", "Répons des vigiles (I)", 216, 217); P_("paques", "repons", "Répons des vigiles (II)", 218, 219, true); P_("paques", "repons", "Répons des vigiles (III)", 220, 221, true); P_("paques", "choral", "Choral de l'Ascension", 224, 225); }
          if (office === "laudes") { P_("paques", "antiennes", "Laudes de l'Ascension", 226, 227, false, "*"); P_("paques", "repons", "Répons des vigiles (I)", 216, 217); }
        } else if (dim && sem === 7) {
          if (pv) P_("paques", "antiennes", "Ires Vêpres - 7e dimanche de Pâques", 255, 256);
          if (v2) P_("paques", "antiennes", "IIes Vêpres - 7e dimanche de Pâques", 228, 229, false, "*");
          if (office === "lectures") P_("paques", "antiennes", "Vigiles - 7e dimanche de Pâques", 260, 261);
          if (office === "laudes") P_("paques", "antiennes", "Laudes - 7e dimanche de Pâques", 226, 227, false, "*");
          NTV(); P_("paques", "repons", "Répons - 7e dimanche de Pâques", 262, 263);
          if (office === "vepres") { P_("paques", "lucernaire", "Lucernaire de l'Ascension", 196, 198); P_("paques", "hymne", "Veni Creator (vêpres II)", 242, 243); P_("paques", "hymne", "Veni Creator (vêpres III)", 244, 245, true); }
          if (office === "lectures") { P_("paques", "invitatoire", "Invitatoire de l'Ascension", 209, 213); P_("paques", "hymne", "Hymne - 7e dimanche de Pâques", 257, 259); }
          if (office === "laudes") P_("paques", "hymne", "Hymne - 7e dimanche de Pâques", 257, 259);
        } else if (apresAsc) {
          if (office === "laudes") serie("paques", "hymne", "Hymne des laudes après l'Ascension", [[232, 233], [234, 235], [236, 239]]);
          if (office === "vepres") serie("paques", "hymne", "Hymne des vêpres après l'Ascension", [[240, 241], [242, 243], [244, 245]]);
          const ra = sem === 6 ? (js === 5 ? 248 : 252) : [270, 274, 278, 284, 288, 292][js - 1];
          if (lv && ra) P_("paques", "repons", `Répons - ${jr} après l'Ascension`, ra, ra + 1);
        } else if (sem === 1 || (dim && sem === 2)) {
          if (office === "laudes") { P_("paques", "hymne", "Hymne - Laudes de Pâques", 6, 7); P_("paques", "hymne", "Hymne - Octave de Pâques (I)", 8, 9, true); P_("paques", "hymne", "Hymne - Octave de Pâques (II)", 10, 12, true); }
          if (office === "vepres") { P_("paques", "lucernaire", "Lucernaire pascal", 24, 26); P_("paques", "hymne", "Hymne - Vêpres de Pâques", 27, 29); }
          if (office === "lectures" && sem === 2) { P_("paques", "invitatoire", "Invitatoires des dimanches de Pâques", 51, 57); P_("paques", "hymne", "Hymne des vigiles", 58, 60); P_("paques", "antiennes", "Vigiles — 2e dimanche", 61, 63, false, "*"); P_("paques", "choral", "Choral du 2e dimanche de Pâques", 84, 85); }
          // octave : antiennes selon le jour (Pâques, mercredi, 2e dimanche / lundi, jeudi, samedi / mardi, vendredi)
          const G = [0, 3].includes(js) ? "mercredi" : [1, 4, 6].includes(js) ? "Lundi" : "Mardi";
          if (office === "laudes") { P_("paques", "antiennes", "Laudes de Pâques et de l'octave", 13, 13, false, "*"); P_("paques", "cantique-at", "Cantique de Moïse (AT 1)", 14, 15, true); P_("paques", "antiennes", "Laudes de Pâques et de l'octave", 16, 17, false, "*"); P_("paques", "repons", "Répons - Laudes de Pâques & octave", 18); P_("paques", "benedictus", "Antienne « Haec dies »", 36, 37); }
          if (office === "vepres") { P_("paques", "antiennes", "Vêpres de Pâques", 30, 32); P_("paques", "cantique", "Cantique NT XIV", 327, 328); P_("paques", "repons", "Répons - Vêpres de Pâques & octave", 34, 35); P_("paques", "magnificat", "Antienne « Haec dies »", 36, 37); }
          if (dim && sem === 2) P_("paques", "repons", "Répons du 2e dimanche de Pâques", 82, 83, true);
        } else if (dim) {
          if (office === "vepres") P_("paques", "lucernaire", "Lucernaire des dimanches de Pâques", 42, 43);
          if (office === "lectures") { P_("paques", "invitatoire", "Invitatoires des dimanches de Pâques", 51, 57); P_("paques", "hymne", "Hymne des vigiles", 58, 60); }
          if (office === "laudes") P_("paques", "hymne", "Hymne des laudes des dimanches de Pâques", 70, 71);
          const F = `\\b${sem}e\\b`, sch = sem === 3 || sem === 5;
          const RD = { 3: [86, 91], 4: [94, 95], 5: [98, 99], 6: [104, 105] }[sem], CD = { 3: [92, 93], 4: [96, 97], 5: [100, 103], 6: [106, 108] }[sem];
          if (pv) P_("paques", "antiennes", `Ires Vêpres — ${sem}e dimanche de Pâques`, sch ? 44 : 46, sch ? 45 : 47, false, "*");
          if (v2) P_("paques", "antiennes", `IIes Vêpres — ${sem}e dimanche de Pâques`, sch ? 74 : 76, sch ? 75 : 77, false, "*");
          if (office === "lectures") { P_("paques", "antiennes", `Vigiles — ${sem}e dimanche de Pâques`, 61, 63, false, "*"); if (CD) P_("paques", "choral", `Choral du ${sem}e dimanche de Pâques`, CD[0], CD[1]); }
          if (office === "laudes") P_("paques", "antiennes", `Laudes — ${sem}e dimanche de Pâques`, 72, 73, false, "*");
          NTV(); if (RD) P_("paques", "repons", `Répons du ${sem}e dimanche de Pâques`, RD[0], RD[1]);
        } else {
          const rl = { 2: 178, 5: 178, 3: 180, 6: 180, 4: 182 }[sem], rv = { 2: 184, 3: 186, 4: 188, 5: 190, 6: 192 }[sem];
          if (office === "laudes" && rl) P_("paques", "repons", `Répons des laudes (semaine ${sem})`, rl, rl + 1);
          if (office === "vepres" && rv) P_("paques", "repons", `Répons des vêpres (semaine ${sem})`, rv, rv + 1);
          if (office === "laudes") serie("paques", "hymne", "Hymne des laudes (féries)", [[110, 111], [112], [113], [114], [115], [116, 117]]);
          if (office === "vepres") serie("paques", "hymne", "Hymne des vêpres (féries)", [[118, 119], [120, 122], [123], [124, 125], [126, 127], [128], [129]]);
        }
        return out.length ? out : null;
      }
      default: return null;
    }
  }

  // images des partitions : en ligne, elles sont dans l'entrepôt Azure (adresse dans <meta name="fichiers">,
  // posée par outils/publier_azure.sh) ; en local, à côté du site
  // l'entrepôt est privé : chaque adresse porte la clé d'accès (<meta name="fichiers-cle">, posée à la publication)
  const FICHIERS = (typeof document !== "undefined" && document.querySelector('meta[name="fichiers"]')?.content) || "";
  // clé courte délivrée après la connexion (js/cle-fichiers.js → window.CLE_FICHIERS) ; sinon celle écrite dans la page
  const CLE_PAGE = (typeof document !== "undefined" && document.querySelector('meta[name="fichiers-cle"]')?.content) || "";
  const cleEnt = () => (typeof window !== "undefined" && window.CLE_FICHIERS) || CLE_PAGE;
  const entrepot = (chemin) => { const k = cleEnt(); return FICHIERS + chemin + (FICHIERS && k ? (chemin.includes("?") ? "&" : "?") + k : ""); };
  const image = (carnet, page) => entrepot(`partitions/${carnet}/p-${String(page).padStart(3, "0")}.jpg`);

  function html(liste, ouvert = false) {
    if (!liste.length) return "";
    const nomCarnet = (c) => I?.carnets?.[c]?.nom || (c === "milieu" ? "Office du milieu du jour" : c);
    const blocs = liste.map((x) => `<details class="partition"${ouvert ? " open" : ""}><summary><span class="role">${g.Textes.esc(ROLES[x.role] || x.role)}</span> — ${g.Textes.esc(x.titre)} <span class="ton">${g.Textes.esc(nomCarnet(x.carnet))}, p. ${x.pages.join(", ")}</span></summary>${x.pages.map((p) => `<img loading="lazy" src="${image(x.carnet, p)}" alt="Partition : ${g.Textes.esc(x.titre)}, page ${p}">`).join("")}</details>`).join("");
    return `<section class="bloc partitions"><h3>Partitions du carnet de la Province</h3>${blocs}</section>`;
  }

  // Partition placée sous son texte, dans une section repliable
  const normal = (t) => (t || "").normalize("NFD").replace(/[^a-zA-Z]/g, "").toLowerCase();
  const LOCAL = typeof location !== "undefined" && /^(localhost|127\.0\.0\.1)$/.test(location.hostname);   // aides à la correction : en local seulement
  // Hymnes : les morceaux d'une même page (s-077-1, s-077-2) remplacés par une seule image avec marges,
  // h-077-1-2.jpg, fabriquée par outils/hymnes_pages.py
  const CARNETS_TENANT = /^(to|avent|careme|paques|noel|sanctoral1|sanctoral2)\/s-(\d{3})-(\d+)\.jpg$/;
  const PAGE_LIVRET = /^(to|avent|careme|paques|noel|sanctoral1|sanctoral2)\/[shp]-(\d{3})(?:-\d+)*\.jpg$/;
  function dUnTenant(fs) {
    const out = [];
    let grp = null;
    const fermer = () => { if (grp) out.push(`${grp.c}/h-${grp.p}-${grp.a}-${grp.b}.jpg`); grp = null; };
    for (const f of fs) {
      const m = CARNETS_TENANT.exec(f);
      if (!m) { fermer(); out.push(f); continue; }
      const n = +m[3];
      if (grp && grp.c === m[1] && grp.p === m[2] && n > grp.b) grp.b = n;
      else { fermer(); grp = { c: m[1], p: m[2], a: n, b: n }; }
    }
    fermer();
    return out;
  }
  function figure(fichiers, legende = "", opt = {}) {
    if (!I || !fichiers || !fichiers.length) return "";
    fichiers = corrigerFichiers(fichiers);
    if (!fichiers.length) return "";
    fichiers = fichiers.flatMap((f) => DECOUPES[f] || [f]).filter((f, i, t) => t.indexOf(f) === i);
    // corrections aussi sur les images d'un seul tenant (h-…), assemblées ici : gravures retirées, pavés coupés
    fichiers = corrigerFichiers(dUnTenant(fichiers));
    if (!fichiers.length) return "";
    const img = (f) => `<img loading="lazy" src="${entrepot(`partitions/${f}`)}" alt="Partition${legende ? " : " + g.Textes.esc(legende) : ""}">`;
    // pages en vis-à-vis dans le livret (page paire à gauche, impaire à droite : 2-3, 4-5…) : côte à côte
    let imgs = "";
    for (let i = 0; i < fichiers.length; i++) {
      const a = PAGE_LIVRET.exec(fichiers[i]), b = PAGE_LIVRET.exec(fichiers[i + 1] || "");
      // cantiques du NT : toujours deux pages par deux (une seule si le cantique tient en une page ou s'il en reste une)
      const cantique = opt.role === "cantique" && fichiers[i + 1];
      if (cantique || (a && b && a[1] === b[1] && +a[2] % 2 === 0 && +b[2] === +a[2] + 1)) { imgs += `<div class="double-page">${img(fichiers[i])}${img(fichiers[i + 1])}</div>`; i++; }
      else imgs += img(fichiers[i]);
    }
    return `<details class="partition-pliee"${g.Partitions.ouvertes && !opt.ferme ? " open" : ""}><summary>Partition${legende ? ` <span class="legende">— ${g.Textes.esc(legende)}</span>` : ""}</summary>${LOCAL ? `<p class="fichier-partition no-print" title="Nom du fichier de cette partition, pour la corriger (voir CORRIGER-UNE-PARTITION.md)">${fichiers.map((f) => g.Textes.esc(f)).join(" · ")}</p>` : ""}<figure class="partition-piece">${imgs}</figure></details>`;
  }

  // ── Ordo du sanctoral (partitions/ordo.json, relevé des carnets par outils/construire_ordo.py)
  //    et corrections faites à la main (partitions/corrections.json)
  let ORDO = null, CORR = { remplacer: {}, retirer: [], offices: {} };
  async function chargerOrdo() {
    try { const r = await fetch("partitions/ordo.json", { cache: "no-cache" }); ORDO = r.ok ? await r.json() : null; } catch (e) { ORDO = null; }
    try {
      const r = await fetch("partitions/corrections.json", { cache: "no-cache" });
      if (r.ok) definirCorrections(await r.json());
    } catch (e) { console.warn("corrections.json illisible : vérifier les virgules et les guillemets", e); }
  }
  function definirOrdo(o) { ORDO = o; }
  function definirCorrections(c) { CORR = { remplacer: c.remplacer || {}, retirer: c.retirer || [], offices: c.offices || {} }; }
  function corrigerFichiers(fs) {
    return fs.filter((f) => !CORR.retirer.includes(f)).flatMap((f) => (CORR.remplacer[f] == null ? [f] : [].concat(CORR.remplacer[f])));
  }
  const NOMS_CARNETS = { noel: "Noël et Épiphanie", sanctoral1: "Sanctoral (septembre-janvier)", sanctoral2: "Sanctoral (février-août)", corrections: "Correction" };
  const MOBILES = [[/Trinité/, "trinite"], [/Saint-Sacrement|Corps et (du )?Sang/, "saint-sacrement"], [/Sacré-Cœur/, "sacre-coeur"], [/Christ,? Roi/, "christ-roi"]];
  // clé de la fête du jour dans l'ordo du sanctoral (« 10-18 », « trinite »…), ou null
  function cleOrdo(j) {
    if (!ORDO) return null;
    const m = MOBILES.find(([re]) => re.test(j.nom || ""));
    if (m && ORDO[m[1]]) return m[1];
    // livret de Noël : Noël et son octave, Sainte Famille, 1er janvier, Épiphanie, féries, Baptême ; Cana et appel des disciples
    const ct = j.cleTemporal || "";
    if (j.source === "temporal" || !j.cleSanctoral) {
      const kt = ct === "noel" ? "12-25" : /^noel-\d\d-\d\d$/.test(ct) ? ct.slice(5) : ct === "marie-mere-de-dieu" ? "01-01"
        : ["sainte-famille", "epiphanie", "bapteme"].includes(ct) ? ct : null;
      if (kt && ORDO[kt]) return kt;
      if (j.temps === "noel" && j.jourSemaine !== 0 && j.date.slice(5, 7) === "01") {
        const epi = /Épiphanie/.test(j.ferie || j.nom || "");               // « lundi après l'Épiphanie » ; sinon 2 au 7 janvier
        const n = epi ? j.jourSemaine : +j.date.slice(8) - 1;
        const kf = n >= 1 && n <= 6 ? `noel-ferie-${JOURS[n]}` : null;
        if (kf && ORDO[kf]) return kf;
      }
      if (j.temps === "ordinaire" && j.jourSemaine === 0 && !j.celebration) {
        if (j.semaine === 2 && j.cycle === "C" && ORDO.cana) return "cana";
        if (j.semaine === 3 && (j.cycle === "A" || j.cycle === "B") && ORDO.appel) return "appel";
      }
    }
    if (j.cleSanctoral && j.source !== "temporal") {
      const k = j.cleSanctoral.slice(-5);
      if (/^\d\d-\d\d$/.test(k) && ORDO[k]) return k;
    }
    // mémoire au temps de Noël : antiennes, hymnes et répons des féries du livret de Noël
    if (j.temps === "noel" && j.jourSemaine !== 0 && j.date.slice(5, 7) === "01" && j.niveau >= 9) {
      const n = /Épiphanie/.test(j.ferie || "") ? j.jourSemaine : +j.date.slice(8) - 1;
      if (n >= 1 && n <= 6 && ORDO[`noel-ferie-${JOURS[n]}`]) return `noel-ferie-${JOURS[n]}`;
    }
    return null;
  }
  // clé liturgique d'un jour, pour le fichier de corrections : « 10-18 », « avent/2/mardi », « ordinaire/14/jeudi »…
  function cleJour(j) {
    return cleOrdo(j) || `${(j.temps || "ordinaire").replace(/ /g, "-")}/${j.semaine ?? 0}/${JOURS[j.jourSemaine]}`;
  }
  const pageDe = (f) => { const m = /\/[ps]-(\d+)/.exec(f || ""); return m ? +m[1] : null; };
  function versPiece(x, e) {
    const carnet = (x.f[0] || "").split("/")[0];
    return { role: x.role, fichier: x.f[0], fichiers: x.f, ids: x.ids || [], cotes: [], alt: !!x.alt, libre: !!x.libre, ordo: true,
      titre: x.titre || x.txt || e.nom, carnet, nomCarnet: NOMS_CARNETS[carnet] || I?.carnets?.[carnet]?.nom || carnet, page: pageDe(x.f[0]) };
  }
  // Pièces indiquées par le carnet du sanctoral pour cet office (ou null si le jour n'y figure pas)
  function ordoPour(j, office, optsJour = {}) {
    if (!ORDO || !["laudes", "vepres", "lectures"].includes(office)) return null;
    const C = g.Calendrier;
    let e = null, o = null, veille = false, niv = j.niveau;
    if (office === "vepres") {
      // la veille d'une solennité (ou d'une fête du Seigneur un dimanche) : ses premières vêpres
      const n = C.jour(C.iso(C.plus(C.deIso(j.date), 1)), optsJour);
      const kn = cleOrdo(n);
      if (kn && ORDO[kn].offices.vepres1 && ((n.niveau <= 4 || (n.jourSemaine === 0 && n.niveau <= 5)) && n.niveau < j.niveau || (n.jourSemaine === 0 && (kn === "cana" || kn === "appel") && j.niveau > 4))) {
        e = ORDO[kn]; o = e.offices.vepres1; niv = n.niveau;
        // l'AELF ne donne les premières vêpres que pour le dimanche et les grandes fêtes du temps de Noël
        veille = n.jourSemaine !== 0 && !["12-25", "01-01", "epiphanie"].includes(kn);
      }
      else if (n.jourSemaine === 0 && j.niveau > 4) return null;          // samedi soir : premières vêpres du dimanche
      else if (n.niveau <= 4 && n.niveau < j.niveau) return null;        // veille d'une solennité sans carnet
    }
    if (!o) { const k = cleOrdo(j); if (!k) return null; e = ORDO[k]; o = e.offices[office]; }
    if (!o) return null;
    const pieces = o.pieces.filter((x) => x.f && x.f.length).map((x) => versPiece(x, e));
    // prières litaniques des fêtes : annexe « VIe mode » du même carnet
    const ann = (ORDO._annexes || {})[e.carnet] || [];
    if (office !== "lectures" && niv <= 8) {
      const pr = ann.find((a) => a.role === "priere" && (office === "laudes" ? /Louanges/.test(a.titre) : /Intercessions/.test(a.titre)));
      if (pr) pieces.push(versPiece(pr, e));
    }
    if (office === "lectures" && j.niveau <= 8 && !pieces.some((x) => x.role === "tedeum")) {
      const td = ann.find((a) => a.role === "tedeum"); if (td) pieces.push(versPiece(td, e));
    }
    return { nom: e.nom, carnet: e.carnet, titre: o.titre, pieces, veille, feriale: o.pieces.some((x) => x.ferie || x.libre) || !pieces.some((x) => x.role === "antiennes" && !x.libre) };
  }
  // Corrections faites à la main pour un office : { "10-18|vepres": { "hymne": ["sanctoral1/s-052-1.jpg"], "antiennes": [["…"], ["…"]] } }
  function corriger(j, office, liste) {
    const cles = [`${j.date}|${office}`, `${cleJour(j)}|${office}`];
    for (const c of cles) {
      const o = CORR.offices[c];
      if (!o) continue;
      for (const [role, v] of Object.entries(o)) {
        liste = liste.filter((x) => x.role !== role);
        const groupes = (Array.isArray(v) && Array.isArray(v[0]) ? v : [v]).filter((gr) => gr && gr.length);
        for (const fs of groupes) liste.push({ role, fichier: fs[0], fichiers: fs, ids: [], cotes: [], ordo: true, titre: "Correction", carnet: "corrections", nomCarnet: (fs[0] || "").split("/")[0], page: pageDe(fs[0]) });
      }
    }
    return liste;
  }

  // Livrets de Sainte-Baume : antienne de chaque psaume du psautier (4 semaines), laudes et vêpres
  let SB = [];
  const TEXTES = new Map();     // texte d'antienne → fichiers
  async function chargerSB() {
    try {
      const r = await fetch("partitions/sb/pieces.json", { cache: "no-cache" });
      if (!r.ok) return;
      SB = await r.json();
      for (const x of SB) if (x.ant && !TEXTES.has(normal(x.ant))) TEXTES.set(normal(x.ant), x.partition);
    } catch (e) { SB = []; }
  }
  function sbPour(j, office) {
    if (!SB.length || !["laudes", "vepres", "lectures"].includes(office)) return [];
    const JR = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"];
    let sem = j.psautier;
    if (office === "vepres" && j.jourSemaine === 6) sem = (j.psautier % 4) + 1;   // 1res vêpres du dimanche
    if (!sem) return [];
    return SB.filter((x) => x.office === office && x.semaine === sem && x.jour === JR[j.jourSemaine])
      .map((x) => ({ role: "antiennes", fichier: x.partition[0], fichiers: x.partition, ids: x.ids || [], cotes: x.cote ? [x.cote] : [],
        titre: x.titre, nomCarnet: "Livret de Sainte-Baume", page: null, ant: x.ant }));
  }
  // antiennes des carnets connues par leur cote (Carême : « K 731 ») → texte du tableau Gouzes
  function textesParCote() {
    if (!g.Gouzes?.antienneDeCote) return;
    for (const [c, pages] of Object.entries(PIECES)) for (const ps of Object.values(pages)) for (const x of ps)
      for (const cote of x.cotes || []) { const a = g.Gouzes.antienneDeCote(cote); if (a?.ant && !TEXTES.has(normal(a.ant))) TEXTES.set(normal(a.ant), [`${c}/${x.fichier}`]); }
  }
  let coteFaite = false;
  // « Les Heures grégoriennes » : pièces latines notées par jour, office et rôle (usage privé, hors site publié)
  let HG = null;
  async function chargerHG() {
    try {
      const r = await fetch("partitions/hg/index.json", { cache: "no-cache" });
      if (!r.ok) return;
      HG = new Map();
      for (const x of await r.json()) {
        if (!x.cle || !x.office || x.cle.startsWith("TO/")) continue;   // dimanches ordinaires : une seule antienne par année, sans équivalent
        const k = `${x.cle}|${x.office}|${x.role}|${x.rang || ""}|${x.variante || ""}`;
        if (!HG.has(k)) HG.set(k, { fichiers: [...x.fichiers], texte: x.texte || "" });
      }
    } catch (e) { HG = null; }
  }
  const JR = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"];
  const FETES_HG = [[/^Nativité du Seigneur/, "nativite"], [/Sainte Famille/, "sainte-famille"], [/Marie, Mère de Dieu/, "marie-mere-de-dieu"],
    [/^Épiphanie/, "epiphanie"], [/^Baptême du Seigneur/, "bapteme"], [/Christ, Roi/, "christ-roi"], [/Trinité/, "trinite"],
    [/Saint-Sacrement|Corps et (du )?Sang/, "saint-sacrement"], [/Sacré-Cœur/, "sacre-coeur"], [/^Ascension/, "ascension"],
    [/^Pentecôte/, "pentecote"], [/^Dimanche de Pâques/, "paques"], [/Rameaux/, "rameaux"], [/Cendres/, "cendres"],
    [/^Jeudi saint/i, "jeudi-saint"], [/^Vendredi saint/i, "vendredi-saint"], [/^Samedi saint/i, "samedi-saint"]];
  // clés possibles d'un jour, de la plus propre à la plus commune
  function clesHG(j) {
    const c = [], mm = j.date.slice(5), jr = JR[j.jourSemaine];
    const f = FETES_HG.find(([re]) => re.test(j.nom || ""));
    if (f) c.push(`F/${f[1]}`);
    if (j.niveau <= 8 && j.source !== "temporal") c.push(`D/${mm}`);
    const t = j.temps;
    if (t === "avent") { const d = +j.date.slice(8); if (mm.startsWith("12") && d >= 17 && j.jourSemaine !== 0) c.push(`D/${mm}`); c.push(`T/avent/${j.semaine}/${jr}`); }
    if (t === "noel") { c.push(`D/${mm}`); c.push(`T/epiphanie/1/${jr}`); }
    if (t === "careme") c.push(`T/careme/${j.semaine}/${jr}`);
    if (t === "semaine sainte") c.push(`T/semaine-sainte/6/${jr}`);
    if (t === "paques") c.push(`T/paques/${j.semaine}/${jr}`);
    if (t === "ordinaire" && j.jourSemaine === 0) c.push(`TO/${j.semaine}`);
    if (j.psautier) c.push(`P/${j.psautier}/${jr}`);
    return c;
  }
  function gregorien(j, office, role, rang = "") {
    if (!HG) return null;
    const C = g.Calendrier;
    let cands = [];
    if (office === "vepres") {
      const n = C.jour(C.iso(C.plus(C.deIso(j.date), 1)));
      const veille = n.jourSemaine === 0 || (n.niveau <= 4 && n.source !== "temporal");
      if (veille) cands = clesHG(n).map((k) => [k, "vepres1"]);
      cands = cands.concat(clesHG(j).flatMap((k) => [[k, "vepres2"], [k, "vepres"]]));
    } else cands = clesHG(j).map((k) => [k, office]);
    // variante du temps (« Tempore paschali », « Tempore Quadragesimæ »…), sinon la pièce ordinaire
    const v = j.temps === "paques" ? ["TP", ""] : (j.temps === "careme" || j.temps === "semaine sainte") ? ["Tempore Quadragesimæ", ""]
      : j.temps === "avent" ? ["Tempore Adventus", ""] : j.temps === "noel" ? ["Tempore Nativitatis", ""] : ["", "hors-TP"];
    for (const [k, o] of cands) for (const va of v) { const x = HG.get(`${k}|${o}|${role}|${rang}|${va}`); if (x?.fichiers.length) return x; }
    return null;
  }

  const parTexte = (t) => { if (!coteFaite) { textesParCote(); coteFaite = true; } return grave(t) || TEXTES.get(normal(t)) || null; };

  g.Partitions = { charger, pour, piecesPour, hymnesTemps, sbPour, ordoPour, cleOrdo, cleJour, corriger, get local() { return LOCAL; }, definirOrdo, definirCorrections, get ordo() { return ORDO; }, parTexte, grave, cantiqueGrave, gregorien, clesHG, parCote, html, image, entrepot, figure, ouvertes: false, get index() { return I; }, ROLES };
})(typeof window !== "undefined" ? window : globalThis);
