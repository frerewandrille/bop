/* Version « latin-français » : l'office tel que le donnent « Les Heures grégoriennes »
   (Communauté Saint-Martin, 3 tomes) — latin à gauche, français à droite, partitions grégoriennes.

   Données : partitions/hg/offices.json (outils/construire_offices_latins.py), présentes seulement
   avec les partitions (usage privé, site protégé par mot de passe).
   Latin.construire(j, office, options, { entete, bloc }) → { titre, html, avertissements, jour }
   Ce module ne touche à aucune autre version : offices.js ne l'appelle que pour repartition === "latin".
*/
(function (g) {
  "use strict";
  let O = null;
  let CANT = {};        // cantiques évangéliques : benedictus, magnificat, nunc
  let MARIALES_FR = {}; // antiennes mariales des complies (traduction du livre), par temps
  let CYCLE = null;     // année A, B ou C du jour en cours de construction
  let IMPRESSION = false; // PDF / Word : images chargées tout de suite (pas « à la demande »)
  const esc = (s) => g.Textes.esc(s);

  async function charger() {
    try {
      const r = await fetch("partitions/hg/offices.json", { cache: "no-cache" });
      if (!r.ok) return false;
      O = await r.json();
      for (const els of Object.values(O)) for (const e of els) {
        if (e.t !== "psaume" || !e.tla) continue;
        const k = /Lc 1, 68/.test(e.tla) ? "benedictus" : /Lc 1, 46/.test(e.tla) ? "magnificat" : /Lc 2, 29/.test(e.tla) ? "nunc" : null;
        // le livre enchaîne parfois le cantique avec la suite de l'ordinaire (Notre Père, oraison, bénédiction) :
        // on garde la version la plus courte, qui s'arrête à la fin du cantique
        if (k && (!CANT[k] || e.la.length < CANT[k].la.length)) CANT[k] = e;
      }
      // traductions des antiennes mariales, collées par le livre à la fin de l'oraison des complies
      for (const [cle, els] of Object.entries(O)) {
        if (!/\|complies$/.test(cle)) continue;
        for (const e of els) {
          if (e.t !== "oraison") continue;
          let cur = null;
          for (const x of e.fr || []) {
            const t = x[1];
            const nu = t.replace(/<[^>]+>/g, "");
            const r = /^Du 1|Avent/.test(nu) ? "alma" : /2 février/.test(nu) ? "ave" : /[Tt]emps pascal/.test(nu) && nu.length < 60 ? "regina"
              : /^Au temps ordinaire|après la Pentecôte/.test(nu) ? "salve" : null;
            if (r) { cur = MARIALES_FR[r] ? null : r; if (cur) MARIALES_FR[cur] = []; continue; }
            if (/^(COMPLIES|DU [A-Z]+ SOIR|Le début de l’office)/.test(nu) || /^[a-z]{1,3}$/.test(nu)) { cur = null; continue; }
            if (cur) MARIALES_FR[cur].push(x);
          }
        }
      }
      return true;
    } catch (e) { O = null; return false; }
  }

  // ── Variantes : « Tempore paschali », « Anno A »…
  function nv(v) {
    if (!v) return null;
    const s = v.toLowerCase();
    for (const [k, n] of [["hors", "hors-TP"], ["extra", "hors-TP"], ["pascal", "TP"], ["pasch", "TP"], ["tp", "TP"], ["carême", "Q"], ["quadrag", "Q"],
      ["avent", "A*"], ["advent", "A*"], ["noël", "N"], ["nativ", "N"], ["per annum", null], ["ordinaire", null], ["vel", "ou"], ["ou bien", "ou"]])
      if (s.includes(k)) return n;
    const m = s.match(/(anno|année) ([abc])/);
    return m ? m[2].toUpperCase() : s;
  }
  function preferences(j) {
    const t = j.temps;
    const base = t === "paques" ? ["TP", null] : t === "careme" || t === "semaine sainte" || t === "triduum" ? ["Q", null, "hors-TP"]
      : t === "avent" ? ["A*", null, "hors-TP"] : t === "noel" ? ["N", null, "hors-TP"] : [null, "hors-TP"];
    return j.jourSemaine === 0 || j.niveau <= 4 ? [j.cycle, ...base] : base;
  }
  // éléments consécutifs de même type, dont l'un au moins porte une variante : un seul est retenu
  function choisir(els, prefs) {
    const out = [];
    for (let i = 0; i < els.length;) {
      let k = i + 1;
      const memeGroupe = (a, b) => a.t === b.t && ["antienne", "hymne", "repons", "evangelique", "oraison", "lecture"].includes(a.t)
        && (a.v || b.v) && (a.t !== "antienne" || a.n === b.n || a.n == null || b.n == null);
      while (k < els.length && memeGroupe(els[k - 1], els[k])) k++;
      const grp = els.slice(i, k);
      if (grp.length === 1 && !grp[0].v) out.push(grp[0]);
      else {
        let pris = null;
        for (const p of prefs) { pris = grp.find((e) => nv(e.v) === p); if (pris) break; }
        if (!pris && grp.every((e) => e.v)) pris = grp.find((e) => !["TP", "Q"].includes(nv(e.v))) || null;
        if (pris) out.push(pris);
      }
      i = k;
    }
    return out;
  }

  // commun auquel renvoie le propre d'un saint (« De Communi pastorum », « De Communi Apostolorum »…)
  const COMMUNS = [[/pastorum/, "C/pasteurs"], [/martyr/, "C/martyr"], [/sanctarum mulierum/, "C/saintes"], [/doctorum/, "C/docteurs"],
    [/sanctorum virorum|plurimorum sanctorum/, "C/saints"], [/virginum/, "C/vierges"], [/Mariæ Virginis/, "C/vierge-marie"],
    [/Apostolorum/, "C/apotres"], [/Dedicationis/, "C/dedicace"]];
  const communCache = {};
  // pages (numérotation du PDF) de chaque commun ; la page imprimée = page du PDF − décalage du tome
  const DECALAGE = { 1: 8, 2: 8, 3: 22 };
  let PAGES_COMMUNS = null;
  function communDePage(tome, imprimee) {
    if (!PAGES_COMMUNS) {
      PAGES_COMMUNS = [];
      for (const [k, els] of Object.entries(O)) {
        const [t, reste] = k.split(":"); const c = reste.split("|")[0];
        if (!c.startsWith("C/")) continue;
        for (const e of els) if (e.p) PAGES_COMMUNS.push([+t, e.p, c]);
      }
    }
    const pdf = imprimee + (DECALAGE[tome] || 0);
    const bornes = {};
    for (const [t, p, c] of PAGES_COMMUNS) if (t === tome) { const b = (bornes[c] ||= [p, p]); b[0] = Math.min(b[0], p); b[1] = Math.max(b[1], p); }
    return Object.entries(bornes).find(([, [a, b]]) => pdf >= a - 2 && pdf <= b + 2)?.[0] || null;
  }
  function communDe(cleD) {
    if (cleD in communCache) return communCache[cleD];
    // le livre enchaîne parfois le saint suivant (« DECEMBER Die 3 decembris … De Communi pastorum ») :
    // on s'arrête au titre d'un autre jour, et on garde le commun le plus souvent cité
    const vus = {};
    for (const [k, els] of Object.entries(O)) {
      if (k.split(":")[1]?.split("|")[0] !== cleD) continue;
      fin: for (const e of els) for (const x of e.la || []) {
        const t = x[1].replace(/<[^>]+>/g, "");
        if (/^(Die ?\d+ [a-z]+|IANUARIUS|FEBRUARIUS|MARTIUS|APRILIS|MAIUS|IUNIUS|IULIUS|AUGUSTUS|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER)\b/.test(t)) break fin;
        const m = t.match(/De Communi ([^,.;]+)/);
        let c = m && (COMMUNS.find(([re]) => re.test(m[1])) || [])[1];
        // « Psalmus 115, ut in Communi, p. 1042 » : le commun dont les pages contiennent la page citée
        const mp = !c && t.match(/(?:in|de) Communi[^.]*?\bp\.\s*(\d+)/);
        if (mp) c = communDePage(+k.split(":")[0], +mp[1]);
        if (c) vus[c] = (vus[c] || 0) + 1;
      }
    }
    const r = Object.entries(vus).sort((a, b) => b[1] - a[1])[0]?.[0] || null;
    return (communCache[cleD] = r);
  }
  // ── Clés candidates (de la plus propre à la plus commune), avec le tome selon le temps
  function candidats(j, office, laudes = false) {
    if (laudes) office = "laudes";
    const C = g.Calendrier;
    const tomes = ["careme", "semaine sainte", "triduum", "paques"].includes(j.temps) ? [2, 3, 1] : [1, 3, 2];
    const cles = (jj) => {
      const c = g.Partitions.clesHG(jj);
      // fête d'un saint : « De Communi Apostolorum, p. … » → le commun correspondant, juste après le propre
      const d = c.findIndex((k) => k.startsWith("D/"));
      if (d >= 0) {
        const com = communDe(c[d]);
        if (com && !c.includes(com)) c.splice(d + 1, 0, com);
      }
      if (jj.temps === "ordinaire" && !c.includes(`TO/${jj.semaine}`)) c.push(`TO/${jj.semaine}`);
      return c;
    };
    let paires = [];
    if (office === "complies") {
      const jr = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"][j.jourSemaine];
      const n = C.jour(C.iso(C.plus(C.deIso(j.date), 1)));
      const veille = n.jourSemaine === 0 || (n.niveau <= 4 && n.source !== "temporal");
      const sol = j.jourSemaine === 0 || (j.niveau <= 4 && j.source !== "temporal");
      paires = [[`K/${veille ? "samedi" : sol ? "dimanche" : jr}`, "complies"], ["K/dimanche", "complies"], [`P/4/samedi`, "complies"]];
    } else if (office === "vepres") {
      const n = C.jour(C.iso(C.plus(C.deIso(j.date), 1)));
      const veille = (n.jourSemaine === 0 || (n.niveau <= 4 && n.source !== "temporal")) && !/^Dimanche de Pâques/.test(n.nom || "");
      if (veille) paires = cles(n).map((k) => [k, "vepres1"]);
      paires = paires.concat(cles(j).flatMap((k) => [[k, "vepres2"], [k, "vepres"], [k, "vepres1"]]));   // « hymnus ut in I Vesperis »
    } else paires = cles(j).map((k) => [k, office]);
    // 2e dimanche de Pâques (octave) : la psalmodie et ses antiennes sont celles du jour de Pâques
    const octave = (x) => x.temps === "paques" && x.semaine === 2 && x.jourSemaine === 0;
    if ((octave(j) || (office === "vepres" && octave(C.jour(C.iso(C.plus(C.deIso(j.date), 1)))))) && office !== "complies")
      paires.splice(paires.findIndex(([k]) => k.startsWith("P/")), 0, ...(office === "vepres" ? ["vepres2", "vepres"] : [office]).map((o) => ["F/paques", o]));
    const out = [];
    for (const [k, o] of paires) for (const t of tomes) { const x = O[`${t}:${k}|${o}`]; if (x) out.push({ cle: `${t}:${k}|${o}`, els: x }); }
    return out;
  }

  // ── Rendu
  // consignes du livre qui ne font pas partie du texte : on coupe à partir d'elles
  const FIN_TEXTE = /^(Ad alias Horas|Aux autres Heures|Tempore Adventus et Nativitatis, lectio|Durant l’Avent et le temps de Noël|Le début de l’office|COMPLIES$|DU (LUNDI|MARDI|MERCREDI|JEUDI|VENDREDI|SAMEDI|DIMANCHE) SOIR|Noctem quiétam|Que le Seigneur tout-puissant ✠|A Dominica I Adventus|LA Dominica I Adventus|Du 1 ?(er)? dimanche de l’Avent|er$|(IANUARIUS|FEBRUARIUS|MARTIUS|APRILIS|MAIUS|IUNIUS|IULIUS|AUGUSTUS|SEPTEMBER|OCTOBER|NOVEMBER|DECEMBER)$|Die ?\d+ [a-z]+(ii|ris|bris|li|ii)\b|(JANVIER|FÉVRIER|MARS|AVRIL|MAI|JUIN|JUILLET|AOÛT|SEPTEMBRE|OCTOBRE|NOVEMBRE|DÉCEMBRE)$|LE [^a-z]{1,4} (JANVIER|FÉVRIER|MARS|AVRIL|MAI|JUIN|JUILLET|AOÛT|SEPTEMBRE|OCTOBRE|NOVEMBRE|DÉCEMBRE)|Le 24 décembre)/;
  const coupe = (ls) => { const i = (ls || []).findIndex((x) => FIN_TEXTE.test(x[1].replace(/<[^>]+>/g, "").trim())); return i < 0 ? ls || [] : ls.slice(0, i); };
  // consignes du livre qui renvoient à une autre page (« antiphona ut in Proprio de Tempore, pp. 772-858. »,
  // « Canticum Benedíctus, p. 1410; postea deinceps Preces… ») : toute la phrase est retirée
  const REF_PAGE = /\b(pp?\.|pages?)\s*\d{2,}/;
  function sansConsignes(ls) {
    ls = ls || [];
    const nu = ls.map((x) => x[1].replace(/<[^>]+>/g, "").trim());
    const ote = new Set();
    nu.forEach((t, i) => {
      if (!REF_PAGE.test(t)) return;
      let a = i; while (a > 0 && !/[.:!?»]$/.test(nu[a - 1]) && !ote.has(a - 1) && /^[a-zà-ÿ(,;]/.test(nu[a])) a--;
      let b = i; while (b < nu.length - 1 && !/[.:]$/.test(nu[b].replace(/\s*\(.*\)$/, "")) && /^[a-zà-ÿ(]|^p\.|^\d/.test(nu[b + 1])) b++;
      for (let k = a; k <= b; k++) ote.add(k);
    });
    return ls.filter((_, i) => !ote.has(i));
  }
  // renvois seuls sur leur ligne (« Canticum Benedíctus, p. 1052. ») : retirés
  const renvoiSeul = (t) => /^(Canticum|Cantique|Psalmus|Psaume|Hymnus|Hymne)?[^.]{0,40}\b(p\.|page)\s*\d+\.?$/.test(t.replace(/<[^>]+>/g, "").trim());
  // antiennes du dimanche données pour les trois années : on garde celle de l'année du jour
  function selonAnnee(ls, latin) {
    if (!(ls || []).some((x) => /^(Anno|Année) [ABC]:/.test(x[1]))) return ls || [];
    if (latin) return [];
    const out = []; let garder = true, vu = false;
    for (const x of ls) {
      const m = x[1].match(/^Année ([ABC]):\s*(.*)$/);
      if (m) { vu = true; garder = !CYCLE || m[1] === CYCLE; if (garder && m[2]) out.push([x[0], m[2]]); continue; }
      if (garder || !vu) out.push(x);
    }
    return out;
  }
  const RUB = /(\bp\.\s*\d+|\bpage \d+|^Tempore\b|^Temps\b|^Signum\b|^On se signe|^Hymnus,|^Ant\.|^Psalmi|^Les psaumes|ut in |comme (au|le|à) )/;
  // mot coupé en fin de ligne du livre (« admi- » / « rable ») : la suite est recollée à la ligne ;
  // les vrais traits d'union restent (« Très-/Haut », « guide-/nous »)
  const UNION = /^(nous|vous|moi|toi|le|la|les|lui|leur|en|y|il|elle|ils|elles|on|je|tu|même|ci|là|t’)\b/;
  function recoupe(ls) {
    const out = [];
    for (const x of ls) {
      const p = out[out.length - 1];
      const fin = p && p[1].replace(/<[^>]+>/g, "").match(/([A-Za-zÀ-ÿœæ]+)-$/);
      const deb = x[1].replace(/<[^>]+>/g, "").match(/^[a-zà-ÿœæ]+[^\s]*/);
      if (fin && deb) {
        const garde = UNION.test(deb[0]) || /^(très|Très|arc|grand|Grand|demi|porte|garde)$/.test(fin[1]);
        const [mot, ...reste] = x[1].split(/(?<=^\S+)\s/);
        p[1] = (garde ? p[1] : p[1].replace(/-(\s*(?:<\/[^>]+>)*)$/, "$1")) + mot;
        if (reste.length && reste.join(" ").trim()) out.push([x[0], reste.join(" ")]);
        continue;
      }
      out.push([x[0], x[1]]);
    }
    return out;
  }
  function lignes(ls, psaume = false) {
    ls = recoupe(sansConsignes(coupe(ls)).filter((x) => !renvoiSeul(x[1])));
    if (!ls?.length) return "";
    let h = "", i = 0;
    if (psaume) {
      while (i < ls.length && ls[i][1] === ls[i][1].toUpperCase() && /[A-Z]{3}/.test(ls[i][1])) h += `<p class="titre-ps">${ls[i++][1]}</p>`;
      const v1 = ls.findIndex((x, k) => k >= i && /^[A-ZÆŒÉÈÀÂÎÔÛÇÁÍÓÚÝ]{2,}/.test(x[1]) && /[a-zà-ÿ]/.test(x[1]));
      if (v1 > i && v1 - i <= 2) { h += `<p class="chapeau">${ls.slice(i, v1).map((x) => x[1]).join(" ")}</p>`; i = v1; }
    }
    for (; i < ls.length; i++) {
      const [r, t] = ls[i];
      if (/^(I|II|III|IV|V)$/.test(t)) { h += `<p class="titre-ps">${t}</p>`; continue; }   // partie du psaume
      const cl = RUB.test(t.replace(/<[^>]+>/g, "")) ? "rubrique-l" : /^—/.test(t) ? "r1" : `r${Math.min(r, 2)}`;
      h += `<span class="l ${cl}">${t.replace(/\b([RV])\/\s?/g, '<span class="rv">$1/</span> ')}</span>`;
    }
    return `<div class="texte-bilingue">${h}</div>`;
  }
  // Prose (lecture, oraison, intercessions) : les lignes du livre sont recollées en paragraphes, sans les
  // coupures de fin de ligne (« nomi-/némur » → « nominémur ») ; aux intercessions, un paragraphe par invocation.
  function prose(ls, parInvocation = false) {
    ls = sansConsignes(coupe(ls)).filter((x) => !renvoiSeul(x[1]));
    if (!ls?.length) return "";
    const paras = [];
    let cur = "";
    for (const [, brut] of ls) {
      const t = brut.trim();
      if (!t) continue;
      const nu = t.replace(/<[^>]+>/g, "");
      const nouveau = !cur || (parInvocation && (/^—/.test(nu) || (/[.:!?]$/.test(cur.replace(/<[^>]+>/g, "").trim()) && /^[A-ZÀ-ÝŒÆ]/.test(nu))));
      if (nouveau) { if (cur) paras.push(cur); cur = t; continue; }
      if (/[a-zà-ÿœæ]-$/.test(cur.replace(/<[^>]+>/g, "")) && /^[a-zà-ÿœæ]/.test(nu)) cur = UNION.test(nu) && /[a-zéè]{3,}-$/.test(cur) ? cur + t : cur.replace(/-(\s*(?:<\/[^>]+>)*)$/, "$1") + t;   // « accorde-/nous » garde son trait d'union
      else cur += (/-$/.test(cur) ? "" : " ") + t;
    }
    if (cur) paras.push(cur);
    return `<div class="texte-bilingue prose">${paras.map((x) => `<p>${x.replace(/\b([RV])\/\s?/g, '<span class="rv">$1/</span> ').replace(/^—\s*/, "— ")}</p>`).join("")}</div>`;
  }
  // renvois au livre dans le texte d'une antienne (« Cantique Magníficat, page 1081. »)
  const sansPage1 = (t) => sansPage(t.replace(/\s*Le 24 décembre,[\s\S]*$/, ""));
  const sansPage = (t) => t.replace(/\s*(Cantique|Canticum|Psaume|Psalmus|Hymne|Hymnus)?[^.;]*\b(page|p\.)\s*\d+\.?/gi, "").trim();
  const partition = (e, leg) => e?.partitions?.length
    ? `<figure class="partition-piece partition-latine">${e.partitions.map((f) => `<img${IMPRESSION ? "" : ' loading="lazy"'} src="${g.Partitions?.entrepot ? g.Partitions.entrepot(`partitions/${f}`) : `partitions/${f}`}" alt="Partition : ${esc(leg)}">`).join("")}</figure>` : "";
  const rangee = (la, fr) => (la || fr) ? `<div class="bilingue"><div class="la" lang="la">${la || ""}</div><div class="fr">${fr || ""}</div></div>` : "";
  const titre2 = (la, fr) => `<h4 class="titre-bilingue"><span lang="la">${esc(la || "")}</span>${fr && fr !== la ? ` <span class="trad">${esc(fr)}</span>` : ""}</h4>`;
  // « … Le 24 décembre, ant. 1. Et toi, Bethléem… » : antienne propre à une autre date, collée à la suite
  // lignes d'une antienne recollées, sans les coupures de fin de ligne (« redou- / table »)
  const recolle = (ls) => ls.map((x) => x[1]).reduce((acc, t) => (/[a-zà-ÿœæ]-$/.test(acc) && /^[a-zà-ÿœæ]/.test(t) ? acc.slice(0, -1) + t : acc ? acc + " " + t : t), "");
  const texteAnt = (e) => sansPage1(recolle(sansConsignes(selonAnnee(e.fr)).filter((x) => !renvoiSeul(x[1]))));
  const ant = (e, n) => e ? rangee(partition(e.partitionsAnnee ? { partitions: e.partitionsAnnee[CYCLE] } : e, `antienne ${n || ""}`) + lignes(selonAnnee(e.la, true)), `<p class="antienne-fr"><span class="rubrique">Ant.${n ? " " + n : ""}</span> ${texteAnt(e)}</p>`) : "";
  const antReprise = (e, n) => e ? rangee(`<p class="rubrique">Ant.${n ? " " + n : ""} (reprise)</p>`, `<p class="antienne-fr"><span class="rubrique">Ant.</span> ${texteAnt(e)}</p>`) : "";
  const GLORIA = rangee(`<p class="gloria">Glória Patri, et Fílio, * et Spirítui Sancto.<br>Sicut erat in princípio, et nunc et semper, * et in sǽcula sæculórum. Amen.</p>`,
    `<p class="gloria">Gloire au Père, et au Fils, et au Saint-Esprit,<br>pour les siècles des siècles. Amen.</p>`);
  const titrePs = (e) => titre2((e.tla || "").replace(/^PSALMUS/, "Psalmus").replace(/^CANTICUM/, "Canticum"), (e.tfr || "").replace(/^PSAUME/, "Psaume").replace(/^CANTIQUE/, "Cantique"));
  const psaume = (e) => titrePs(e) + rangee(lignes(e.la, true), lignes(e.fr, true)) + GLORIA;

  // hymne de Sexte de l'Ordinaire selon le temps
  function hymneSexte(j) {
    const md = j.date.slice(5);
    if (["careme", "semaine sainte", "triduum"].includes(j.temps)) return "careme/careme";
    if (j.temps === "paques") return "paques/paques";
    if (j.temps === "avent") return md >= "12-17" ? "avent-17/avent" : "per-annum/avent";
    if (j.temps === "noel") return md >= "12-01" || md <= "01-06" ? "per-annum/noel" : "avent-17/noel";
    return j.niveau <= 4 ? "per-annum/solennite" : "per-annum/TO";
  }
  // antienne mariale des complies selon le temps (texte latin traditionnel)
  const MARIALES = {
    alma: ["Alma Redemptoris Mater", ["Alma Redemptóris Mater, quæ pérvia cæli", "porta manes, et stella maris, succúrre cadénti,", "súrgere qui curat, pópulo: tu quæ genuísti,", "natúra miránte, tuum sanctum Genitórem,", "Virgo prius ac postérius,", "Gabriélis ab ore sumens illud Ave,", "peccatórum miserére."]],
    ave: ["Ave Regina cælorum", ["Ave, Regína cælórum,", "ave, Dómina angelórum:", "salve, radix, salve, porta,", "ex qua mundo lux est orta.", "Gaude, Virgo gloriósa,", "super omnes speciósa,", "vale, o valde decóra,", "et pro nobis Christum exóra."]],
    regina: ["Regina cæli", ["Regína cæli, lætáre, allelúia.", "Quia quem meruísti portáre, allelúia.", "Resurréxit, sicut dixit, allelúia.", "Ora pro nobis Deum, allelúia."]],
    salve: ["Salve Regina", ["Salve, Regína, mater misericórdiæ;", "vita, dulcédo et spes nostra, salve.", "Ad te clamámus, éxsules fílii Evæ.", "Ad te suspirámus, geméntes et flentes", "in hac lacrimárum valle.", "Eia ergo, advocáta nostra,", "illos tuos misericórdes óculos ad nos convérte.", "Et Iesum, benedíctum fructum ventris tui,", "nobis post hoc exsílium osténde.", "O clemens, o pia, o dulcis Virgo María."]],
  };
  function mariale(j) {
    const md = j.date.slice(5);
    const cle = j.temps === "paques" ? "regina" : j.temps === "avent" || j.temps === "noel" || (md >= "01-01" && md < "02-02" && j.temps !== "careme") ? "alma"
      : ["careme", "semaine sainte", "triduum"].includes(j.temps) || (md >= "02-02" && md < "03-15" && j.temps === "ordinaire" && !j.apresPentecote && j.semaine < 10) ? "ave" : "salve";
    return { cle, titre: MARIALES[cle][0], la: MARIALES[cle][1] };
  }

  function construire(j, office, options, aide) {
    const { entete, bloc } = aide;
    const avert = [];
    const TITRES = { laudes: "Laudes", milieu: `Office du milieu du jour (${{ tierce: "Tierce", sexte: "Sexte", none: "None" }[options.heure] || "Sexte"})`, vepres: "Vêpres", complies: "Complies", lectures: "Office des lectures" };
    const vide = (msg) => ({ titre: TITRES[office], html: `<article class="office office-latin">${entete(j, office)}<p class="avertissement">${msg}</p></article>`, avertissements: [msg], jour: j });
    if (!O) return vide("Version latin-français : les données des Heures grégoriennes ne sont pas disponibles sur cet ordinateur.");
    if (office === "lectures") return vide("Les Heures grégoriennes ne donnent pas l'Office des lectures. Choisissez une autre version pour cet office.");
    const cands = candidats(j, office);
    // commun des saints choisi pour ce jour (bouton « Commun ») : après le propre du saint, avant le temps et le psautier
    const lendL = g.Calendrier.jour(g.Calendrier.iso(g.Calendrier.plus(g.Calendrier.deIso(j.date), 1)));
    const veilleL = office === "vepres" && (lendL.jourSemaine === 0 || lendL.niveau <= 4) && !(j.niveau <= 4 && j.niveau <= lendL.niveau);
    const choixCommun = veilleL ? null : options.communs?.[j.date];
    const duCommun = choixCommun && g.Communs?.latin ? g.Communs.latin(choixCommun, j, office) : [];
    if (duCommun.length) {
      for (let i = cands.length - 1; i >= 0; i--) if (/^\d:C\//.test(cands[i].cle)) cands.splice(i, 1);   // l'autre commun, deviné par le livre
      const i = cands.findIndex((c) => !/^\d:(D|CSM|F)\//.test(c.cle));
      cands.splice(i < 0 ? cands.length : i, 0, ...duCommun);
    }
    if (!cands.length) return vide("Les Heures grégoriennes ne donnent pas cet office pour ce jour.");
    const prefs = preferences(j);
    CYCLE = j.cycle || null;
    IMPRESSION = !!options.impression;
    const heure = ["tierce", "sexte", "none"].includes(options.heure) ? options.heure : "sexte";
    // antiennes propres de certains dimanches de Carême et de Pâques (psautier du tome II) : celles du jour seulement
    const C = g.Calendrier, demain = C.jour(C.iso(C.plus(C.deIso(j.date), 1)));
    const dimDe = (x) => (x.jourSemaine === 0 && x.temps === "careme" ? "Q" + x.semaine : x.jourSemaine === 0 && x.temps === "paques" ? "P" + x.semaine : null);
    const dims = new Set([dimDe(j), office === "vepres" ? dimDe(demain) : null].filter(Boolean));
    const L = cands.map((c) => ({ cle: c.cle, els: choisir(c.els.filter((e) => !e.dim || [].concat(e.dim).some((d) => dims.has(d))).filter((e) => !e.h || e.h === heure || !["lecture", "oraison", "versus", "repons"].includes(e.t)), prefs) }));
    const premier = (t, pred = () => true) => { for (const c of L) { const e = c.els.find((x) => x.t === t && pred(x)); if (e) return { e, cle: c.cle }; } return null; };
    const sources = new Set();
    const note = (x) => { if (x) sources.add(x.cle.split("|")[0].replace(/^\d:/, "")); return x?.e; };

    let h = entete(j, office);
    h += `<p class="note no-print">Version latin-français — Les Heures grégoriennes (Communauté Saint-Martin). Le texte latin des antiennes est celui de leur partition.</p>`;
    const careme = ["careme", "semaine sainte", "triduum"].includes(j.temps);
    h += bloc("Introduction", rangee(`<p><span class="rv">V/</span> Deus, ✠ in adiutórium meum inténde.<br><span class="rv">R/</span> Dómine, ad adiuvándum me festína.<br>Glória Patri… ${careme ? "" : "Allelúia."}</p>`,
      `<p><span class="rv">V/</span> Dieu, ✠ viens à mon aide.<br><span class="rv">R/</span> Seigneur, à notre secours.<br>Gloire au Père… ${careme ? "" : "Alléluia."}</p>`), "introduction");
    // hymne
    let hy = note(premier("hymne", (e) => e.la?.length || e.fr?.length || e.partitions?.length));
    // renvois du livre (« Tempore Adventus, p. 1042 ») : le temps est déjà choisi ici
    const sansRenvoi = (ls) => { const out = [...(ls || [])]; while (out.length && /(p\.\s*\d|page \d|^Tempore|^Temps|^annum:?$|ordinaire\s*:?$)/i.test(out[0][1].replace(/<[^>]+>/g, ""))) out.shift(); return out; };
    // milieu du jour : le livre renvoie à l'Ordinaire (hymne de Sexte selon le temps)
    // (une hymne trouvée au psautier pour le milieu du jour est celle de Tierce : on prend Sexte, sur la mélodie
    //  du dimanche si le livre la donne)
    const duPsautier = hy && office === "milieu" && /\bP\/\d\//.test([...sources].pop() || "");
    const hyS = (!hy || duPsautier) && office === "milieu" ? O[`0:S/sexte/${hymneSexte(j)}|milieu`]?.[0] : null;
    if (duPsautier && hyS) { if (hy.sexte) hyS.__partitions = hy.sexte; hy = null; }
    let hyV = null;
    if (!hy && office === "vepres") {
      for (const c of L) {
        if (!/\|vepres1$/.test(c.cle)) continue;
        hyV = (O[c.cle.replace(/\|vepres1$/, "|vepres2")] || []).find((e) => e.t === "hymne" && e.la?.length + e.fr?.length);
        if (hyV) break;
      }
    }
    if (!hy && hyV) hy = hyV;
    // une même hymne peut porter sa variante du temps pascal à la suite (« Tempore paschali: » / « Au temps pascal: »)
    const tpHymne = (ls) => {
      const i = (ls || []).findIndex((x) => /^(Tempore paschali|Au temps pascal|Temps pascal)\s*:?\s*$/.test(x[1].replace(/<[^>]+>/g, "").trim()));
      return i < 0 ? ls : j.temps === "paques" ? ls.slice(i + 1) : ls.slice(0, i);
    };
    if (hy) h += bloc("Hymnus — Hymne", rangee(partition(hy, "hymne") + lignes(tpHymne(sansRenvoi(hy.la))), lignes(tpHymne(sansRenvoi(hy.fr)))), "hymne");
    else if (hyS) h += bloc("Hymnus — Hymne", rangee(partition(hyS.__partitions ? { partitions: hyS.__partitions } : hyS, "hymne") + lignes(hyS.la), lignes(hyS.fr)), "hymne");
    if (hyS) delete hyS.__partitions;
    // psalmodie : antiennes et psaumes de la première source qui a des psaumes (avant la lecture)
    const aPsaumes = (c) => c.els.some((e) => e.t === "psaume" && !/EVANGELIC/.test(e.tla || ""));
    let src = L.find(aPsaumes);
    const propreSansPsaumes = src && L.slice(0, L.indexOf(src)).find((c) => c.els.some((e) => e.t === "antienne" && e.n));
    if (propreSansPsaumes && office === "laudes" && propreSansPsaumes.els.some((e) => e.t === "antienne" && /Ordinario|dominica/i.test(e.la.map((x) => x[1]).join(" ")))) {
      // fête : « Psalmus 62, ut in Ordinario » = psaumes du dimanche de la Ire semaine
      for (const t of [1, 3, 2]) { const x = O[`${t}:P/1/dimanche|laudes`]; if (x) { src = { cle: `${t}:P/1/dimanche|laudes`, els: choisir(x, prefs) }; break; } }
    } else if (propreSansPsaumes && office === "vepres") avert.push("Fête : psaumes propres (commun) non repris des Heures grégoriennes ; psaumes du jour.");
    let ps = "";
    if (src) {
      sources.add(src.cle.split("|")[0].replace(/^\d:/, ""));
      const fin = src.els.findIndex((e) => ["lecture", "repons"].includes(e.t));
      const suite = fin < 0 ? src.els : src.els.slice(0, fin);
      // antiennes propres d'une source plus haute (fête) : elles remplacent celles du psautier, rang par rang
      const propre = L.slice(0, L.indexOf(src)).find((c) => c.els.some((e) => e.t === "antienne" && e.n));
      let n = 0, a = null;
      // vêpres du dimanche : cantique de 1 P 2 en Carême, d'Ap 19 le reste de l'année (le livre donne les deux)
      const careme = ["careme", "semaine sainte"].includes(j.temps) || ["careme", "semaine sainte"].includes(demain.temps) && office === "vepres";
      const deux = suite.some((e) => /1 Pe 2, 21/.test(e.tla || "")) && suite.some((e) => /Ap 19/.test(e.tla || ""));
      let prec = null;
      for (const e of suite) {
        if (deux && e.t === "psaume" && (careme ? /Ap 19/ : /1 Pe 2, 21/).test(e.tla || "")) continue;
        // antienne sans numéro ni partition juste après un psaume : sa reprise imprimée (déjà ajoutée) ; ignorée
        const reprise = e.t === "antienne" && !e.n && prec?.t === "psaume" && !e.partitions?.length;
        prec = e;
        if (reprise) continue;
        if (e.t === "antienne") { n = e.n || n + 1; a = propre?.els.find((x) => x.t === "antienne" && x.n === n) || e; ps += ant(a, n); }
        else if (e.t === "psaume") { ps += psaume(e); ps += antReprise(a, n); a = null; }
      }
    }
    if (ps) h += bloc("Psalmodia — Psalmodie", ps, "psalmodie");
    else avert.push("Pas de psalmodie trouvée dans les Heures grégoriennes pour ce jour.");
    // lecture brève, répons
    let le = note(premier("lecture"));
    if (office === "milieu") { for (const c of L) { const ls = c.els.filter((e) => e.t === "lecture"); if (ls.length) { le = ls.length === 3 && !ls.some((e) => e.h) ? ls[1] : ls[0]; break; } } }
    // milieu du jour : les trois capitules (tierce, sexte, none) quand le livre les donne, chacun sous son titre
    // (de même pour l'oraison, plus bas) : première source qui donne ce type d'élément
    const NOMS_H = { tierce: "Ad Tertiam — Tierce", sexte: "Ad Sextam — Sexte", none: "Ad Nonam — None" };
    const parHeure = (t) => {
      for (const c of cands) {
        const ls = choisir(c.els.filter((e) => !e.dim || [].concat(e.dim).some((d) => dims.has(d))), prefs).filter((e) => e.t === t && (e.la?.length || e.fr?.length));
        if (!ls.length) continue;
        const parH = ["tierce", "sexte", "none"].map((x, i) => [x, ls.some((e) => e.h) ? ls.find((e) => e.h === x) : ls.length === 3 ? ls[i] : null]).filter(([, e]) => e);
        return parH.length > 1 ? parH.map(([x, e]) => `<section class="capitule-heure"><h4 class="intitule-heure">${NOMS_H[x]}${e.ref ? ` <span class="ref">${esc(e.ref)}</span>` : ""}</h4>${rangee(prose(e.la), prose(e.fr))}</section>`).join("") : null;
      }
      return null;
    };
    const trois = office === "milieu" ? parHeure("lecture") : null;
    if (trois) h += bloc("Lectio brevis — Lecture brève", trois, "lecture trois-heures");
    else if (le) h += bloc(`Lectio brevis — Lecture brève${le.ref ? ` <span class="ref">${esc(le.ref)}</span>` : ""}`, rangee(prose(le.la), prose(le.fr)), "lecture");
    const re = note(premier("repons"));
    if (re) h += bloc("Responsorium breve — Répons bref", rangee(partition(re, "répons") + lignes(re.la), lignes(re.fr)), "repons");
    // cantique évangélique
    if (office === "laudes" || office === "vepres" || office === "complies") {
      const ev = office === "complies" ? (() => { for (const c of L) { const i = c.els.findIndex((e) => e.t === "psaume" && /EVANGELIC|Lc 2, 29/.test(e.tla || "")); if (i > 0) return { e: c.els[i - 1].t === "antienne" ? c.els[i - 1] : null, c: c.els[i] }; } return null; })()
        : { e: note(premier("evangelique")), c: CANT[office === "laudes" ? "benedictus" : "magnificat"] };
      if (ev && (ev.e || ev.c)) {
        const nom = office === "laudes" ? "Benedictus" : office === "vepres" ? "Magnificat" : "Nunc dimittis";
        let x = ev.e ? ant(ev.e) : "";
        if (ev.c) x += psaume(ev.c);
        if (ev.e) x += antReprise(ev.e);
        h += bloc(`Canticum evangelicum — ${nom}`, x, "evangelique");
      }
    }
    // prières d'intercession, Notre Père, oraison
    if (office !== "milieu" && office !== "complies") {
      const pr = note(premier("preces"));
      if (pr) h += bloc("Preces — Prières d'intercession", rangee(prose(pr.la, true), prose(pr.fr, true)), "preces");
      h += bloc("", rangee(`<p>Pater noster…</p>`, `<p>Notre Père…</p>`), "pater");
    }
    let or = note(premier("oraison"));
    if (!or && office !== "complies") {
      for (const c of candidats(j, office, true)) { const e = choisir(c.els, prefs).find((x) => x.t === "oraison"); if (e) { or = e; sources.add(c.cle.split("|")[0].replace(/^\d:/, "")); break; } }
    }
    const troisOr = office === "milieu" ? parHeure("oraison") : null;
    if (troisOr) h += bloc("Oratio — Oraison", troisOr, "oraison trois-heures");
    else if (or) h += bloc("Oratio — Oraison", rangee(prose(or.la), prose(or.fr)), "oraison");
    else avert.push("Oraison non trouvée dans les Heures grégoriennes pour ce jour.");
    h += bloc("Conclusio — Conclusion", office === "complies"
      ? rangee(`<p>Noctem quiétam et finem perféctum concédat nobis Dóminus omnípotens. Amen.</p>`, `<p>Que le Seigneur tout-puissant nous accorde une nuit tranquille et une fin parfaite. Amen.</p>`)
      : rangee(`<p><span class="rv">V/</span> Benedicámus Dómino.<br><span class="rv">R/</span> Deo grátias.</p>`, `<p><span class="rv">V/</span> Bénissons le Seigneur.<br><span class="rv">R/</span> Nous rendons grâce à Dieu.</p>`), "conclusion");
    if (office === "complies") {
      const m = mariale(j);
      if (m) h += bloc(`Antiphona B. M. V. — Antienne mariale : ${m.titre}`, rangee(`<div class="texte-bilingue"><p>${m.la.join("<br>")}</p></div>`, MARIALES_FR[m.cle]?.length ? lignes(MARIALES_FR[m.cle]) : ""), "mariale");
    }
    h += `<p class="note source-latine">Sources dans Les Heures grégoriennes : ${[...sources].map(esc).join(", ")}.</p>`;
    return { titre: TITRES[office], html: `<article class="office office-latin">${h}</article>`, avertissements: avert, jour: j };
  }

  // ── Oraison du jour pour les autres versions (réglage « Oraison » : liturgique ou des Heures grégoriennes).
  // On ne propose que l'oraison de la célébration du jour : saint → son propre (ou son commun) seulement ;
  // fête de l'Ordre absente du calendrier romain → rien ; mémoire → au milieu du jour et aux complies, la férie.
  // heure : tierce | sexte | none (milieu du jour). Rend { la, fr, cle } (HTML) ou null.
  const JRS = ["dimanche", "lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi"];
  const premierSegment = (n) => String(n || "").split(",")[0].split(" ; ")[0].trim().toLowerCase();
  // Complies : les oraisons du tome I (dimanche I = samedi soir, dimanche II, lundi… vendredi, soir des solennités
  // en semaine, que le livre range sous le samedi et le dimanche, après « Vel, in sollemnitatibus… »)
  let COMPLIES_OR = null;
  function oraisonsComplies() {
    if (COMPLIES_OR) return COMPLIES_OR;
    COMPLIES_OR = {};
    const decoupe = (ls) => {
      const segs = []; let cur = [];
      for (const x of coupe(ls || [])) {
        const t = x[1].replace(/<[^>]+>/g, "").trim();
        if (/^(Orémus\.|Prions le Seigneur\.)$/.test(t)) continue;
        if (/^R\/\s*Amen\.?$/.test(t)) { segs.push(cur); cur = []; continue; }
        cur.push(x);
      }
      if (cur.length) segs.push(cur);
      return segs.filter((sg) => sg.length);
    };
    for (const jr of JRS) {
      const e = (O[`1:K/${jr}|complies`] || []).find((x) => x.t === "oraison");
      if (!e) continue;
      const la = decoupe(e.la), fr = decoupe(e.fr);
      const rub = (sg) => /^(Vel, in sollemnitatibus|Le soir des solennités|Durant le Triduum)/.test(sg?.[0]?.[1].replace(/<[^>]+>/g, "").trim() || "");
      COMPLIES_OR[jr] = { la: la[0], fr: fr[0] };
      const isol = fr.findIndex(rub), lsol = la.findIndex(rub);
      if (isol > 0 && !COMPLIES_OR.solennite) COMPLIES_OR.solennite = { la: lsol > 0 ? la[lsol].slice(1) : [], fr: fr[isol].slice(1) };
    }
    return COMPLIES_OR;
  }
  function oraisonComplies(j, optsJour = {}) {
    const C = g.Calendrier, T = oraisonsComplies();
    const n = C.jour(C.iso(C.plus(C.deIso(j.date), 1)), { propreOP: !!optsJour.propreOP });
    const solennel = (x) => x.niveau <= 4 && x.jourSemaine !== 0 && !(x.temps === "paques" && x.semaine === 1);
    let cle;
    if (j.temps === "triduum" && j.jourSemaine !== 6) cle = "solennite";
    else if (j.jourSemaine === 0 || (j.temps === "paques" && j.semaine === 1)) cle = solennel(n) ? "solennite" : "dimanche";
    else if (n.jourSemaine === 0) cle = "samedi";
    else if (solennel(j) || solennel(n)) cle = "solennite";
    else cle = JRS[j.jourSemaine];
    const e = T[cle];
    return e ? { la: prose(e.la || []), fr: prose(e.fr), cle: `K/${cle}|complies` } : null;
  }
  // Oraisons du sanctoral : le livre enchaîne les saints (« …Par Jésus-Christ. / Le 14 décembre / SAINT JEAN DE LA
  // CROIX… »), si bien qu'une page rangée sous une date commence souvent par l'oraison du saint précédent.
  // On suit donc les intertitres « Le 14 décembre » : l'oraison qui suit appartient à cette date.
  const MOIS_FR = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"];
  const dateIntertitre = (t) => {
    const m = /^Le (?:même jour \()?(\d{1,2})\s*(?:er)?\s+([a-zéû]+)\)?$/.exec(t.replace(/<[^>]+>/g, "").trim());
    const mo = m ? MOIS_FR.indexOf(m[2]) : -1;
    return mo >= 0 ? `${String(mo + 1).padStart(2, "0")}-${m[1].padStart(2, "0")}` : null;
  };
  let PAR_DATE = null, DATE_DE = null;
  function oraisonsParDate() {
    if (PAR_DATE) return;
    PAR_DATE = {}; DATE_DE = new Map();
    let attendue = null;
    for (const els of Object.values(O)) for (const e of els) {
      if (e.t !== "oraison") continue;
      if (attendue && !PAR_DATE[attendue]) { PAR_DATE[attendue] = e; DATE_DE.set(e, attendue); }
      attendue = null;
      for (const x of e.fr || []) { const d = dateIntertitre(x[1]); if (d) attendue = d; }   // le dernier intertitre de la page
    }
  }
  // texte de l'oraison seul : sans l'intertitre du saint suivant ni ses consignes
  const finSaint = (ls, latin) => {
    const i = (ls || []).findIndex((x, k) => {
      const t = x[1].replace(/<[^>]+>/g, "").trim();
      return k > 0 && (latin ? /^(Die ?\d+|Eodem die|[A-Z]{4,}(\s|$))/.test(t) : (!!dateIntertitre(t) || /^ANNEXE\b/.test(t)));
    });
    return i < 0 ? ls || [] : ls.slice(0, i);
  };
  function oraison(j, office, heure = "sexte", optsJour = {}) {
    if (!O || !["laudes", "vepres", "milieu", "complies"].includes(office)) return null;
    const C = g.Calendrier;
    const tomes = ["careme", "semaine sainte", "triduum", "paques"].includes(j.temps) ? [2, 3, 1] : [1, 3, 2];
    let paires = [];
    if (office === "complies") return oraisonComplies(j, optsJour);
    {
      let own = j, offs = office === "vepres" ? ["vepres2", "vepres", "vepres1"] : [office];
      if (office === "vepres") {
        const n = C.jour(C.iso(C.plus(C.deIso(j.date), 1)), { propreOP: !!optsJour.propreOP });
        const veille = (n.jourSemaine === 0 || (n.niveau <= 4 && n.source !== "temporal")) && !/^Dimanche de Pâques/.test(n.nom || "");
        if (veille) { own = n; offs = ["vepres1", "vepres2", "vepres"]; }
      }
      const saint = own.source !== "temporal" && (office === "milieu" ? own.niveau <= 8 : own.niveau <= 12);
      var nomme = () => true;
      let cles;
      if (saint) {
        // fête propre de l'Ordre : le livre (calendrier romain) n'en a l'oraison que si le saint est aussi au calendrier romain
        if (own.source === "op" && premierSegment(C.romainDu?.(own.date.slice(5))?.nom) !== premierSegment(own.nom)) return null;
        cles = g.Partitions.clesHG(own).filter((k) => k.startsWith("F/") || k.startsWith("D/"));
        // fête déplacée (Annonciation après Pâques…) : la date d'origine
        const d = `D/${(/(\d\d-\d\d)$/.exec(own.cleSanctoral || "") || [, own.date.slice(5)])[1]}`;
        if (!cles.includes(d)) cles.push(d);
        const com = communDe(d);
        if (com) cles.push(com);
        oraisonsParDate();
        // le livre suit le calendrier de la Communauté Saint-Martin (saint Hubert le 3 novembre…) : l'oraison d'un
        // saint n'est retenue que si elle le nomme (« saint Thomas d'Aquin », « sainte Catherine »…)
        if (/^(S\.|Ste|Ss|Stes|Saint|Sainte|Bx|Bse)/.test(own.nom || "")) {
          const sans = (t) => t.normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase();
          const noms = sans(own.nom.split(",")[0]).replace(/\(.*?\)/g, "").split(/[\s'’.-]+/)
            .filter((m) => m.length >= 3 && !/^(saints?|saintes?|ste|stes|ss|bse|pape|eveque|pretre|martyrs?|et|ses|compagnons|les|des|grand|vierge|leurs)$/.test(m));
          nomme = (e) => { const t = sans((e.fr || []).map((x) => x[1]).join(" ")); return noms.some((m) => t.includes(m.slice(0, 6))); };
        }
        const propreSaint = PAR_DATE[d.slice(2)];
        if (propreSaint && nomme(propreSaint)) return { la: prose(finSaint(propreSaint.la, true)), fr: prose(finSaint(propreSaint.fr)), cle: d };
      } else {
        // (féries du temps ordinaire : l'oraison du psautier, jamais la collecte du dimanche)
        cles = g.Partitions.clesHG(own).filter((k) => !(k.startsWith("D/") && own.temps !== "avent" && own.temps !== "noel"));
      }
      // octave de Pâques : les textes du jour de Pâques
      if (own.temps === "paques" && own.semaine <= 2 && (own.semaine === 1 || own.jourSemaine === 0)) cles.splice(cles.findIndex((k) => k.startsWith("P/")) >>> 0, 0, "F/paques");
      // à défaut, l'oraison des laudes ; pour un saint, celle d'un autre office (le livre ne la donne souvent qu'une fois)
      const autres = saint ? ["laudes", "vepres2", "vepres", "vepres1", "milieu"] : ["laudes"];
      // dimanches, fêtes, temps de l'Avent, de Noël, du Carême et de Pâques : l'oraison propre (celle des laudes au milieu
      // du jour, comme l'AELF) passe avant celle du psautier ; féries du temps ordinaire : le psautier, par heure
      const propreAvant = own.temps !== "ordinaire" || own.niveau <= 8 || own.jourSemaine === 0;
      const groupes = propreAvant ? [cles.filter((k) => !k.startsWith("P/")), cles.filter((k) => k.startsWith("P/"))] : [cles];
      for (const gr of groupes) for (const o of [...new Set([...offs, ...autres])]) for (const k of gr) for (const t of tomes) paires.push(`${t}:${k}|${o}`);
      j = own;
    }
    const prefs = preferences(j);
    for (const cle of paires) {
      const els = O[cle];
      if (!els) continue;
      // une oraison rangée sous cette page mais qui appartient à un autre saint (intertitre « Le … ») est écartée
      const mm = /D\/(\d\d-\d\d)\|/.exec(cle)?.[1];
      const autreSaint = (x) => mm && DATE_DE?.has(x) && DATE_DE.get(x) !== mm;
      const e = choisir(els.filter((x) => !x.h || x.h === heure || x.t !== "oraison"), prefs).find((x) => x.t === "oraison" && x.fr?.length && !autreSaint(x) && (!/[DC]\//.test(cle) || nomme(x)));
      if (e) return { la: prose(finSaint(e.la, true)), fr: prose(finSaint(e.fr)), cle: cle.replace(/^\d:/, "") };
    }
    return null;
  }

  // ── Office des lectures (les Heures grégoriennes ne le donnent pas) : répartition et textes de l'AELF,
  // psaumes en latin (Nova Vulgata, site/donnees/psautier_latin.json, numérotation hébraïque) en regard
  // du français de l'AELF, strophe par strophe. offices.js construit le reste de l'office (en français).
  let PL = null;
  async function chargerPsautier() {
    if (PL) return true;
    try { const r = await fetch("donnees/psautier_latin.json", { cache: "no-cache" }); if (!r.ok) return false; PL = await r.json(); return true; }
    catch (e) { return false; }
  }
  // numéro grec (liturgique, « 9 B », « 113 A ») → numéro hébreu (celui de la Nova Vulgata)
  function hebreu(n, lettre) {
    if (n <= 8 || n >= 148) return n;
    if (n === 9) return lettre === "B" ? 10 : 9;
    if (n <= 112) return n + 1;
    if (n === 113) return lettre === "B" ? 115 : 114;
    if (n === 114 || n === 115) return 116;
    if (n <= 145) return n + 1;
    return 147;
  }
  const ROMAIN = { I: 1, II: 2, III: 3, IV: 4, V: 5, VI: 6, VII: 7, VIII: 8 };
  // verset latin coupé en stiques à la ponctuation forte (« : », « ; », « ? », « ! »)
  const stiques = (t) => esc(t).split(/(?<=[:;?!])\s+(?=\S)/).join("<br>");
  function psaumeLectures(ps, propre, options = {}) {
    const ref = String(ps.reference || "").trim().replace(/\.$/, "");
    const m = ref.match(/^(\d+)\s*([AaBb])?/);
    const n = m ? +m[1] : null;
    const heb = n ? hebreu(n, (m[2] || "").toUpperCase()) : null;
    const versets = heb && PL ? PL[String(heb)] : null;
    const fr = (h) => propre(h).replace(/<(\/?)u>/g, "<$1b>");
    const partie = ref.match(/-\s*([IVX]+)\s*$/);
    const titreLa = heb ? `Psalmus ${n}${m[2] ? " " + m[2].toUpperCase() : ""}${heb !== n ? ` (${heb})` : ""}${partie ? " " + partie[1] : ""}` : "";
    const titreFr = ps.titre ? `${ps.titre} — ${ref}` : /^\d/.test(ref) ? `Psaume ${ref}` : ref;
    const h4 = `<h4 class="titre-bilingue"><span lang="la">${esc(titreLa)}</span>${titreLa ? ` <span class="trad">${esc(titreFr)}</span>` : esc(titreFr)}</h4>`;
    const gloire = options.sansGloire || /Dn 3/.test(ref) ? "" : GLORIA;
    if (!versets) return `${h4}<div class="psaume aelf">${fr(ps.texte)}</div>${gloire}<p class="note">Texte latin non trouvé pour ce psaume.</p>`;
    // strophes de l'AELF (ligne blanche ou paragraphe) ; à chacune, les versets latins qu'elle commence
    const brut = String(ps.texte || "").replace(/\r?\n/g, " ");
    const strophes = brut.split(/(?:<br\s*\/?>\s*){2,}|<\/p>\s*<p[^>]*>/i).map((s) => s.replace(/^\s*<p[^>]*>|<\/p>\s*$/gi, "")).filter((s) => s.replace(/<[^>]+>|\s|&nbsp;/g, ""));
    const donnes = new Set();
    let rows = "";
    for (const s of strophes) {
      const nums = [...s.matchAll(/<span class="verse_number">\s*([^<]+?)\s*<\/span>/g)].map((x) => x[1]);
      const la = [];
      let refrain = false;
      for (const t of nums) {
        if (/^R\/?$/i.test(t)) { refrain = true; continue; }
        const r = t.replace(/[[\]]/g, "").match(/^(\d+)[a-z]?(?:\s*[-–]\s*(\d+))?/);
        if (!r) continue;
        for (let v = +r[1]; v <= +(r[2] || r[1]); v++) {
          if (!versets[v] || (donnes.has(v) && !refrain)) continue;
          if (!refrain) donnes.add(v);
          la.push(`<span class="v-la"><sup class="num">${v}</sup>${stiques(versets[v])}</span>`);
        }
        refrain = false;
      }
      rows += `<div class="bilingue"><div class="la" lang="la">${la.join("")}</div><div class="fr">${fr(s)}</div></div>`;
    }
    return `${h4}<div class="psaume psaume-bilingue">${rows}</div>${gloire}`;
  }
  const TE_DEUM = ["Te Deum laudámus: * te Dóminum confitémur.", "Te ætérnum Patrem, * omnis terra venerátur.", "Tibi omnes ángeli, * tibi cæli et univérsæ potestátes:",
    "tibi chérubim et séraphim * incessábili voce proclámant:", "Sanctus, * Sanctus, * Sanctus * Dóminus Deus Sábaoth.", "Pleni sunt cæli et terra * maiestátis glóriæ tuæ.",
    "Te gloriósus * Apostolórum chorus,", "te prophetárum * laudábilis númerus,", "te mártyrum candidátus * laudat exércitus.",
    "Te per orbem terrárum * sancta confitétur Ecclésia,", "Patrem * imménsæ maiestátis;", "venerándum tuum verum * et únicum Fílium;", "Sanctum quoque * Paráclitum Spíritum.",
    "Tu rex glóriæ, * Christe.", "Tu Patris * sempitérnus es Fílius.", "Tu, ad liberándum susceptúrus hóminem, * non horruísti Vírginis úterum.",
    "Tu, devícto mortis acúleo, * aperuísti credéntibus regna cælórum.", "Tu ad déxteram Dei sedes, * in glória Patris.", "Iudex créderis * esse ventúrus.",
    "Te ergo quǽsumus, tuis fámulis súbveni, * quos pretióso sánguine redemísti.", "Ætérna fac cum sanctis tuis * in glória numerári.",
    "Salvum fac pópulum tuum, Dómine, * et bénedic hereditáti tuæ.", "Et rege eos, * et extólle illos usque in ætérnum.", "Per síngulos dies * benedícimus te;",
    "et laudámus nomen tuum in sǽculum, * et in sǽculum sǽculi.", "Dignáre, Dómine, die isto * sine peccáto nos custodíre.", "Miserére nostri, Dómine, * miserére nostri.",
    "Fiat misericórdia tua, Dómine, super nos, * quemádmodum sperávimus in te.", "In te, Dómine, sperávi: * non confúndar in ætérnum."];
  const teDeum = (frHtml) => rangee(`<div class="texte-bilingue">${TE_DEUM.map((x) => `<span class="l">${esc(x)}</span>`).join("")}</div>`, frHtml);

  g.Latin = { charger, construire, oraison, chargerPsautier, psaumeLectures, teDeum, get disponible() { return !!O; } };
})(typeof window !== "undefined" ? window : globalThis);
