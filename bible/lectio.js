/* Bible BJ, vue téléphone (bible/index.html) — lecture, original au toucher, Pères de l'Église, dictionnaires,
   Psautier du bréviaire, synopse, onglet Recherche (recherche.js), lecture hors connexion (sw.js, data/horsligne.js).

   Place dans l'ensemble : partie « Bible » du site, servie sous /bible/ ; même barre des menus que le bréviaire
   (../js/menu.js). Lit les fichiers bible/data/*.js, fabriqués sur le Mac par les programmes Python de bible/
   (extract.py d'abord ; voir LISEZMOI.md), en ligne depuis l'entrepôt Azure privé (clé de cle-fichiers.js). */
(() => {
  "use strict";
  const BOOKS = window.__BOOKS || [];
  const byCode = Object.fromEntries(BOOKS.map(b => [b.c, b]));
  const GOSPELS = new Set(["MAT", "MRK", "LUK", "JHN"]);
  const $ = s => document.querySelector(s);
  const esc = s => String(s ?? "").replace(/[&<>"]/g, c => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));
  const num = v => parseInt(v, 10);
  const strip = h => String(h || "").replace(/<sup[^>]*>.*?<\/sup>/g, "").replace(/<br>/g, " ").replace(/<[^>]+>/g, "").replace(/\s+/g, " ").trim();
  const pad = n => String(n).padStart(3, "0");

  // ------------------------------------------------------------------ mémoire locale (ce téléphone seulement)
  const ls = {
    get(k, d) { try { const v = localStorage.getItem(k); return v === null ? d : JSON.parse(v); } catch (e) { return d; } },
    set(k, v) { try { localStorage.setItem(k, JSON.stringify(v)); } catch (e) { } },
  };
  const DEF = { modeNT: "orig", modeAT: "orig", vulg: "NVU", gloss: "lit", tr: false, st: false, mo: false, always: false, notes: true, bc: true, fs: 20, theme: "", test: "NT", psEd: "pt", synCols: true, synRegard: true, com: "bc" };
  let O = { ...DEF, ...ls.get("bible.opts", {}) };
  const saveO = () => { ls.set("bible.opts", O); applyOpts(); };
  function applyOpts() {
    const B = document.body.classList;
    B.toggle("tr", O.tr); B.toggle("st", O.st); B.toggle("mo", O.mo); B.toggle("no-notes", !O.notes);
    ["lit", "lsg", "both"].forEach(g => B.toggle("gloss-" + g, O.gloss === g));
    document.documentElement.style.setProperty("--fs", O.fs + "px");
    if (O.theme) document.documentElement.dataset.theme = O.theme; else delete document.documentElement.dataset.theme;
  }

  // ------------------------------------------------------------------ chargement des données
  const cache = new Map();
  // en ligne, les données sont dans l'entrepôt Azure (<meta name="fichiers">, posé à la publication) ; en local, ici
  const FICHIERS = document.querySelector('meta[name="fichiers"]')?.content || "";
  // l'entrepôt est privé : chaque adresse porte la clé d'accès (<meta name="fichiers-cle">, posée à la publication)
  // clé courte délivrée après la connexion (js/cle-fichiers.js → window.CLE_FICHIERS) ; sinon celle écrite dans la page
  const CLE_PAGE = (typeof document !== "undefined" && document.querySelector('meta[name="fichiers-cle"]')?.content) || "";
  const cleEnt = () => (typeof window !== "undefined" && window.CLE_FICHIERS) || CLE_PAGE;
  const entrepot = (chemin) => { const k = cleEnt(); return FICHIERS + chemin + (FICHIERS && k ? (chemin.includes("?") ? "&" : "?") + k : ""); };
  function load(src, varName) {
    if (cache.has(src)) return cache.get(src);
    const p = new Promise((res, rej) => {
      const s = document.createElement("script");
      s.src = entrepot(src);
      s.onload = () => { const d = window[varName]; window[varName] = undefined; s.remove(); res(d); };
      s.onerror = () => { s.remove(); cache.delete(src); rej(new Error(src)); };
      document.head.appendChild(s);
    });
    cache.set(src, p);
    return p;
  }
  // chargements séquentiels : deux scripts qui écrivent la même variable ne doivent pas se croiser
  let queue = Promise.resolve();
  const loadQ = (src, v) => { const p = queue.then(() => load(src, v)); queue = p.catch(() => { }); return p; };
  // les mots de l'interlinéaire arrivent allégés (voir compacter() dans extract.py)
  const remplir = (ch, M) => {
    for (const ws of Object.values(ch.il || {})) for (const w of ws) {
      if (w.d === undefined) w.d = (w.s && M.d[w.s]) || "";
      if (w.ml === undefined) w.ml = (w.m && M.ml[w.m]) || "";
      for (const k of ["w", "l", "s", "g", "m", "sg", "tr", "seg"]) if (w[k] === undefined) w[k] = "";
      if (!w.nt) w.nt = [];
    }
    return ch;
  };
  const chapter = async (b, c) => remplir(await loadQ(`data/${b}/${pad(c)}.js`, "__CH"), await loadQ("data/mots.js", "__MOTS"));
  const tae = (b, c) => GOSPELS.has(b) ? loadQ(`data/tae/${b}/${pad(c)}.js`, "__TAE").catch(() => []) : Promise.resolve([]);
  const plan = () => loadQ("data/plan.js", "__PLAN").catch(() => null);
  const dicoIndex = () => loadQ("data/dico/index.js", "__DICO").catch(() => ({ d: [], t: {} }));
  const dref = b => loadQ(`data/dref/${b}.js`, "__DREF").catch(() => ({}));
  // Bible chrétienne (commentaire des évangiles par §) : voir bible-chretienne/LISEZMOI.md
  const BC_VIDE = { s: [], v: [] };
  const bcIndex = () => loadQ("data/bc/index.js", "__BC_INDEX").catch(() => null);
  const bcChap = (b, c) => GOSPELS.has(b) ? loadQ(`data/bc/${b}/${pad(c)}.js`, "__BCC").catch(() => BC_VIDE) : Promise.resolve(BC_VIDE);
  const bcSec = i => loadQ(`data/bc/s/${i}.js`, "__BC");
  // Bible chrétienne II (texte des Évangiles en synopse, avec les parallèles) : voir bible-chretienne/textes/LISEZMOI.md
  let TXI = null;
  const bctIndex = () => loadQ("data/bct/index.js", "__BCT_INDEX").then(x => (TXI = x)).catch(() => null);
  const bctSec = k => loadQ(`data/bct/s/${k}.js`, "__BCT");

  // ------------------------------------------------------------------ alignement BJ / original (comme la vue ordinateur)
  function rowsOf(ch) {
    if (ch.__rows) return ch.__rows;
    const src = ch.il || ch.gr || {};
    const used = new Set(), rows = [], ids = new Set(ch.bj.map(v => v.v));
    for (const v of ch.bj) {
      let k = null;
      if (v.g || v.x) { rows.push({ bj: v, k: null }); continue; }
      if (src[v.v] !== undefined && !used.has(v.v)) k = v.v;
      else { const base = String(num(v.v)); if (!ids.has(base) && src[base] !== undefined && !used.has(base)) k = base; }
      if (k !== null) used.add(k);
      rows.push({ bj: v, k });
    }
    for (const k of Object.keys(src)) {
      if (used.has(k)) continue;
      let at = 0;
      for (let i = rows.length - 1; i >= 0; i--) { const r = rows[i]; if (num(r.bj ? r.bj.v : r.k) <= num(k)) { at = i + 1; break; } }
      rows.splice(at, 0, { bj: null, k });
    }
    return (ch.__rows = rows);
  }
  const rowNum = r => num(r.bj ? r.bj.v : r.k);

  // péricopes = découpage par les titres de la BJ
  function pericopes(ch) {
    const out = [];
    const rows = rowsOf(ch);
    rows.forEach((r, i) => {
      const v = r.bj;
      if (i === 0 || (v && v.h && v.h.length)) {
        const hs = v && v.h ? v.h : [];
        const t = hs.filter(h => h[0] >= 3).pop() || hs[hs.length - 1];
        out.push({ from: rowNum(r), title: t ? strip(t[1]) : "" });
      }
    });
    out.forEach((p, i) => p.to = i + 1 < out.length ? out[i + 1].from - 1 : 999);
    return out.filter(p => !isNaN(p.from));
  }

  // ------------------------------------------------------------------ passages : « MAT:5:1:12 » ou « LUK:1:57:999+2:1:7 »
  function parseSpec(s) {
    const [body, at] = s.split("@");
    let b = null;
    const segs = body.split("+").map(x => {
      const p = x.split(":");
      if (p.length === 4) b = p.shift();
      return { b, c: +p[0], from: +p[1], to: +p[2] };
    }).filter(s => byCode[s.b] && s.c);
    return { segs, at: at || null };
  }
  const specOf = segs => segs.map((s, i) => (i === 0 || s.b !== segs[i - 1].b ? s.b + ":" : "") + `${s.c}:${s.from}:${s.to}`).join("+");
  function labelOf(segs) {
    if (!segs.length) return "";
    const a = byCode[segs[0].b].a, f = segs[0], l = segs[segs.length - 1];
    if (segs.length === 1 && f.from <= 1 && f.to >= 999) return `${a} ${f.c}`;
    const end = x => x.to >= 999 ? "fin" : x.to;
    if (segs.length === 1) return f.from === f.to ? `${a} ${f.c},${f.from}` : `${a} ${f.c},${f.from}-${end(f)}`;
    return `${a} ${f.c},${f.from} – ${l.c},${end(l)}`;
  }
  async function pericopeSpec(b, c, from) {
    const ch = await chapter(b, c);
    const ps = pericopes(ch), p = ps.find(x => x.from <= from && from <= x.to) || ps[0];
    const segs = [{ b, c, from: p.from, to: p.to }];
    // une péricope qui continue au chapitre suivant (pas de titre en tête de ce chapitre)
    const chs = byCode[b].ch, i = chs.indexOf(c);
    if (p.to >= 999 && i + 1 < chs.length) {
      const nx = await chapter(b, chs[i + 1]), r0 = rowsOf(nx)[0];
      if (r0 && r0.bj && !(r0.bj.h && r0.bj.h.length)) {
        const np = pericopes(nx);
        segs.push({ b, c: chs[i + 1], from: 1, to: np.length > 1 ? np[1].from - 1 : 999 });
      }
    }
    return specOf(segs);
  }

  // ------------------------------------------------------------------ carnet (lectio) : une entrée par passage et par jour
  const today = () => { const d = new Date(); return `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`; };
  const carnet = () => ls.get("bible.carnet", []);
  function entry(spec, label, create) {
    const all = carnet(), id = today() + "|" + spec;
    let e = all.find(x => x.id === id);
    if (!e && create) { e = { id, d: today(), spec, label, kept: [], priere: "" }; all.unshift(e); ls.set("bible.carnet", all); }
    return e;
  }
  // versets retenus pour ce passage : ceux d'aujourd'hui, sinon ceux de la dernière lectio sur ce passage
  function keptFor(spec) {
    const all = carnet().filter(x => x.spec === spec && x.kept.length);
    const t = all.find(x => x.d === today());
    return (t || all[0] || { kept: [] }).kept;
  }
  function saveEntry(e) {
    const all = carnet(), i = all.findIndex(x => x.id === e.id);
    if (i >= 0) all[i] = e; else all.unshift(e);
    ls.set("bible.carnet", all.filter(x => x.kept.length || x.priere.trim() || x.id === e.id));
  }

  // ------------------------------------------------------------------ feuille du bas
  function sheet(html) {
    $("#sheet .body").innerHTML = html;
    $("#sheet").hidden = false; $("#veil").hidden = false; $("#sheet").scrollTop = 0;
  }
  function closeSheet() { $("#sheet").hidden = true; $("#veil").hidden = true; document.querySelectorAll(".w.sel, .lw.sel").forEach(w => w.classList.remove("sel")); }

  // ------------------------------------------------------------------ routeur
  let P = null; // passage courant
  function setChrome(title, sub, back, steps) {
    $("#title").innerHTML = esc(title) + (sub ? `<small>${esc(sub)}</small>` : "");
    $("#back").hidden = !back; $("#back").dataset.go = back || "";
    $("#steps").hidden = !steps; $("#tabs").hidden = !!steps; $("#onglets").hidden = true; $("#view").classList.remove("syn-large");
    document.querySelectorAll("#tabs button").forEach(b => b.classList.toggle("on", location.hash === b.dataset.go || (b.dataset.go === "#/" && /^#\/(b\/|bc|s\/|ps\/|$)/.test(location.hash || "#/"))));
  }
  async function route() {
    closeSheet();
    const h = decodeURIComponent(location.hash.slice(1) || "/");
    const m = h.split("/").filter(Boolean);
    try {
      if (m[0] === "b" && byCode[m[1]]) return await viewBook(m[1]);
      if (m[0] === "p" && m[1]) return await viewPassage(m[1], m[2] || "lectio");
      if (m[0] === "ps" && m[1]) return await viewPsaume(m[1]);
      if (m[0] === "r" && window.Recherche) return await window.Recherche.vue(m.slice(1).join("/"));    // recherche.js
      if (m[0] === "carnet") return viewCarnet();
      if (m[0] === "horsligne") return await viewHorsLigne();
      if (m[0] === "dico") return await viewDico();
      if (m[0] === "bc") return m[1] ? await viewBCSec(m[1]) : await viewBC();
      if (m[0] === "s" && m[1]) return await viewSec(m[1], m[2], m[3]);
      if (m[0] === "bct" && m[1]) return location.replace(secHref(m[1], "synopse"));     // anciennes adresses
      return await viewHome();
    } catch (e) {
      $("#view").innerHTML = `<p class="missing">Ce texte n’a pas pu être chargé${navigator.onLine === false ? " : vous êtes hors connexion" : ""}.<br>` +
        `Sans réseau, seuls les textes enregistrés sur cet appareil s’ouvrent : <a class="ref" href="#/horsligne">Lecture hors connexion ›</a></p>` +
        `<p class="missing" style="font-size:12px">(Fichier manquant : ${esc(e.message)}. Sur l’ordinateur, les données se reconstruisent avec <code>python3 extract.py</code>.)</p>`;
    }
  }

  // ------------------------------------------------------------------ psaumes : Bible de Jérusalem ou Psautier du bréviaire
  // Le Psautier (traduction de la Province dominicaine de Toulouse, inflexions en gras) est lu dans les données du
  // bréviaire (../donnees/psautier.json, même site). Il suit la numérotation liturgique (grecque) ; la BJ, l'hébraïque.
  let PSAUTIER = null;
  async function psautier() {
    if (PSAUTIER) return PSAUTIER;
    const r = await fetch("../donnees/psautier.json");
    if (!r.ok) throw new Error("../donnees/psautier.json");
    return (PSAUTIER = await r.json());
  }
  // n° liturgique (grec) → n° hébreu (BJ) : 9A/9B → 9/10, 10-112 → +1, 113A/B → 114/115, 114-115 → 116,
  // 116-145 → +1, 146-147 → 147
  function hebreu(id) {
    const m = /^(\d+)([AB])?/.exec(String(id)); if (!m) return null;
    const n = +m[1], x = m[2];
    if (n < 9 || n > 147) return n;
    if (n === 9) return x === "B" ? 10 : 9;
    if (n <= 112) return n + 1;
    if (n === 113) return x === "B" ? 115 : 114;
    if (n <= 115) return 116;
    if (n <= 145) return n + 1;
    return 147;
  }
  async function psaumesHTML() {
    let h = `<div class="ps-ed"><span>Texte :</span><div class="seg">${[["pt", "Psautier"], ["bj", "Bible de Jérusalem"]].map(([k, l]) =>
      `<button data-psed="${k}" class="${O.psEd === k ? "on" : ""}">${l}</button>`).join("")}</div></div>`;
    if (O.psEd === "bj") {
      const ps = byCode.PSA;
      return h + `<p class="ps-note">Numérotation hébraïque, celle de la Bible de Jérusalem.</p><div class="grid">` +
        ps.ch.map(c => `<a href="#/p/PSA:${c}:1:999">${c}</a>`).join("") + `</div>`;
    }
    let P;
    try { P = await psautier(); } catch (e) { return h + `<p class="missing">Le Psautier se lit avec le bréviaire (même site) ; il n'est pas disponible ici.</p>`; }
    const ps = P.ordre.filter(k => P.pieces[k] && P.pieces[k].genre === "psaume");
    const ct = P.ordre.filter(k => P.pieces[k] && P.pieces[k].genre !== "psaume");
    const nom = k => String(k).replace(/^(\d+)-(\d+)$/, (x, a, b) => `${a} ${["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX", "XXI", "XXII"][+b] || b}`);
    h += `<p class="ps-note">${esc(P.titre)}. Numérotation liturgique (celle du bréviaire) ; inflexions en gras.</p>`;
    h += `<div class="grid ps-grid">` + ps.map(k => `<a href="#/ps/${encodeURIComponent(k)}">${esc(nom(k))}</a>`).join("") + `</div>`;
    if (ct.length) h += `<details class="ps-cant"><summary>Cantiques (${ct.length})</summary><ul class="peri">` +
      ct.map(k => `<li><a href="#/ps/${encodeURIComponent(k)}"><span>${esc(k.replace(/^(AT|NT)/, "$1 "))}</span>${esc(P.pieces[k].titre || "")}${P.pieces[k].ref ? ` <small>${esc(P.pieces[k].ref)}</small>` : ""}</a></li>`).join("") + `</ul></details>`;
    return h;
  }
  async function viewPsaume(id) {
    const P = await psautier(), p = P.pieces[id];
    if (!p) throw new Error("psaume " + id);
    const i = P.ordre.indexOf(id), heb = p.genre === "psaume" ? hebreu(id) : null;
    setChrome(p.titre, "Psautier", "#/", false);
    let h = `<div class="psaume-pt">`;
    for (const st of p.strophes) {
      if (st.lettre) h += `<div class="lettre-hebraique">${esc(st.lettre)}</div>`;
      h += `<div class="strophe">` + st.lignes.map(l => `<p class="stique${l.r ? " r" + l.r : ""}">${l.v ? `<sup class="vs">${esc(l.v)}</sup>` : ""}${l.t}</p>`).join("") + `</div>`;
    }
    if (p.priere && p.priere.length) h += `<details class="priere-psalmique"><summary>Prière psalmique</summary>${p.priere.map(x => `<p>${x}</p>`).join("")}</details>`;
    h += `</div>`;
    if (heb && byCode.PSA && byCode.PSA.ch.includes(heb)) h += `<p class="ps-bj"><a href="#/p/PSA:${heb}:1:999">Ce psaume dans la Bible de Jérusalem (Ps ${heb}) ›</a></p>`;
    const prev = P.ordre[i - 1], next = P.ordre[i + 1];
    h += `<div class="pager">` + (prev ? `<a href="#/ps/${encodeURIComponent(prev)}">‹ ${esc(P.pieces[prev].titre)}</a>` : "") +
      (next ? `<a class="next" href="#/ps/${encodeURIComponent(next)}">${esc(P.pieces[next].titre)} ›</a>` : "") + `</div>`;
    h += `<p class="missing">${esc(P.titre)}.</p>`;
    $("#view").innerHTML = h;
    window.scrollTo(0, 0);
  }

  // ------------------------------------------------------------------ accueil : la Bible
  let planDay = null;
  async function viewHome() {
    setChrome("Bible de Jérusalem", "", null, false);
    const last = ls.get("bible.last", null);
    let h = "";
    if (last) h += `<a class="card" style="display:block;text-decoration:none;color:inherit" href="#/p/${esc(last.spec)}"><h2>Reprendre la lecture</h2><div class="big">${esc(last.label)}</div>${last.title ? `<div class="sub2">${esc(last.title)}</div>` : ""}</a>`;
    // trois catégories : Ancien Testament (sans les Psaumes), Psaumes, Nouveau Testament
    h += `<a class="r-accueil" href="#/r">Chercher dans la Bible…</a>`;
    h += `<div class="seg" id="testament">${[["AT", "Ancien Testament"], ["PS", "Psaumes"], ["NT", "Nouveau Testament"]].map(([k, l]) =>
      `<button data-test="${k}" class="${O.test === k ? "on" : ""}">${l}</button>`).join("")}</div>`;
    if (O.test === "PS") h += await psaumesHTML();
    else h += `<div class="books">` + BOOKS.filter(b => b.t === O.test && b.c !== "PSA").map(b =>
      `<a href="#/b/${b.c}" class="${GOSPELS.has(b.c) ? "peres" : ""}">${esc(b.n)}<small>${b.ch.length} ch.</small></a>`).join("") + `</div>`;
    if (O.test === "NT") h += `<div id="bccard"></div>`;
    h += `<div id="plancard"></div><p class="plan-lien hl-lien"><a href="#/horsligne">Lire sans réseau ›</a></p>`;
    $("#view").innerHTML = h;
    window.scrollTo(0, 0);
    if (O.test === "NT") Promise.all([bctIndex(), bcIndex()]).then(([tx, ix]) => {
      if ((tx || ix) && $("#bccard")) $("#bccard").innerHTML = `<a class="card bc-card" href="#/bc"><h2>Les Évangiles en synopse</h2><div class="big">Bible chrétienne</div><div class="sub2">Le texte, les textes mis en regard et le commentaire, § par §</div></a>`;
    });
    // plan de lecture (projet Lectio), s'il a été exporté : un simple lien en bas, ouvert à la demande
    const pl = await plan();
    if (!pl || !pl.jours || !$("#plancard")) return;
    $("#plancard").innerHTML = `<p class="plan-lien"><button data-plan>Plan de lecture proposé</button></p>`;
  }
  async function ouvrirPlan() {
    const pl = await plan(); if (!pl) return;
    planDay = planDay || today();
    renderPlan(pl);
    $("#plancard").scrollIntoView({ behavior: "smooth", block: "start" });
  }
  function renderPlan(pl) {
    const el = $("#plancard"); if (!el) return;
    const j = pl.jours[planDay];
    const d = new Date(planDay + "T12:00:00");
    const lbl = d.toLocaleDateString("fr-FR", { weekday: "long", day: "numeric", month: "long" });
    let h = `<div class="card plan"><h2>Plan de lecture proposé <button class="plan-x" data-plan-fermer aria-label="Fermer">×</button></h2><div class="date"><button data-day="-1" aria-label="Jour précédent">‹</button><span class="d">${esc(lbl)}</span><button data-day="1" aria-label="Jour suivant">›</button></div>`;
    if (!j) h += `<p class="missing">Pas de plan pour ce jour.</p>`;
    else {
      h += `<div class="periode">${esc(pl.periodes[j.p] || "")}${j.r ? " — " + esc(j.r) : ""}</div>`;
      if (j.e && j.e.m) {
        const segs = j.e.m.map(([b, c, de, a]) => ({ b, c, from: de, to: a }));
        h += `<div><b>Évangile</b> : ${esc(j.e.ref)} <a class="chip" href="#/p/${esc(specOf(segs))}">Lire ›</a></div>`;
      } else if (j.e && j.e.libre) h += `<div><b>Évangile</b> : ${esc(j.e.libre)}</div>`;
      const more = [["Lecture cursive", j.cr], ["Petite dose", j.sr]].filter(x => x[1]);
      for (const [t, r] of more) h += `<div style="margin-top:6px"><b>${t}</b> : ${refChips(r)}</div>`;
      if (j.cn) h += `<div class="missing">${esc(j.cn)}</div>`;
    }
    el.innerHTML = h + `</div>`;
  }
  // « Jos 16–17 », « Ps 1 », « Is 1–3 ; Ps 2 » -> liens vers les chapitres
  function refChips(r) {
    const abbr = Object.fromEntries(BOOKS.map(b => [b.a.replace(/\s/g, ""), b.c]));
    return String(r).split(/\s*[;·]\s*/).map(part => {
      const m = /^(.+?)\s+(\d+)(?:\s*[–-]\s*(\d+))?/.exec(part.trim());
      const b = m && abbr[m[1].replace(/\s/g, "")];
      if (!b) return esc(part);
      const a = +m[2], z = m[3] ? +m[3] : a, out = [];
      for (let c = a; c <= z; c++) out.push(`<a class="chip" href="#/p/${b}:${c}:1:999">${esc(m[1])} ${c}</a>`);
      return out.join(" ");
    }).join(" ");
  }

  // ------------------------------------------------------------------ un livre : chapitres
  async function viewBook(b) {
    const book = byCode[b];
    setChrome(book.n, `${book.ch.length} chapitre${book.ch.length > 1 ? "s" : ""}`, "#/", false);
    let h = `<div class="grid" style="margin-top:14px">` + book.ch.map(c => `<a href="#/p/${b}:${c}:1:999">${c}</a>`).join("") + `</div>`;
    h += `<div id="intro"></div>`;
    $("#view").innerHTML = h;
    window.scrollTo(0, 0);
    const ch = await chapter(b, book.ch[0]);
    if (ch.intro && $("#intro")) $("#intro").innerHTML = `<div class="chips" style="margin-top:18px">` + ch.intro.map(i => `<button class="chip" data-intro="${esc(i)}">Introduction de la BJ : ${esc(i)}</button>`).join("") + `</div>`;
  }

  // ------------------------------------------------------------------ un passage
  async function getPassage(spec) {
    if (P && P.spec === spec.split("@")[0]) return P;
    const { segs, at } = parseSpec(spec);
    if (!segs.length) throw new Error("passage " + spec);
    const parts = [];
    for (const s of segs) {
      const ch = await chapter(s.b, s.c), t = await tae(s.b, s.c), dr = await dref(s.b), bc = await bcChap(s.b, s.c);
      const rows = rowsOf(ch).filter(r => { const n = rowNum(r); return n >= s.from && n <= s.to; });
      parts.push({ ...s, ch, rows, dr, bc, tae: t.filter(x => !(x.c2 < s.c || (x.c2 === s.c && x.v2 < s.from) || x.c1 > s.c || (x.c1 === s.c && x.v1 > s.to))) });
    }
    const label = labelOf(segs);
    let title = "";
    const r0 = parts[0].rows.find(r => r.bj && r.bj.h);
    if (r0) { const t = r0.bj.h.filter(h => h[0] >= 3).pop() || r0.bj.h[r0.bj.h.length - 1]; title = strip(t[1]); }
    const whole = segs.length === 1 && segs[0].from <= 1 && segs[0].to >= 999;
    const bci = parts.some(x => x.bc.s.length) ? await bcIndex() : null;
    const bcti = bci ? await bctIndex() : null;
    P = { spec: spec.split("@")[0], segs, at, parts, label, title, whole, open: new Set(), dico: await dicoIndex(), bci, bcti };
    return P;
  }

  // ------------------------------------------------------------------ Bible chrétienne : repères, versets, liens
  const bcEntry = (ix, i) => ix && ix.sections[+i];
  const bcSpec = ([b, c1, v1, c2, v2]) => c1 === c2 ? `${b}:${c1}:${v1}:${v2}` : `${b}:${c1}:${v1}:999+${c2}:1:${v2}`;
  const bcRefLabel = ([b, c1, v1, c2, v2]) => `${byCode[b].a} ${c1},${v1}` + (c1 === c2 ? (v2 !== v1 ? `-${v2}` : "") : `–${c2},${v2}`);
  // « Mt 8,18 » + « Mt 8,23-27 » -> « Mt 8,18-27 » (même livre, même chapitre, à la suite)
  const bcFusion = refs => refs.reduce((a, r) => {
    const l = a[a.length - 1];
    if (l && l[0] === r[0] && l[3] === r[1] && r[1] === r[3] && r[2] > l[4]) l[4] = r[4]; else a.push([...r]);
    return a;
  }, []);
  const couvre = ([c1, v1, c2, v2], c, n) => (c > c1 || (c === c1 && n >= v1)) && (c < c2 || (c === c2 && n <= v2));
  // les § qui commencent dans ce morceau du passage : verset de départ -> [i…] (le § englobant d'abord)
  function bcMarks(p, part, first) {
    const out = new Map(), seen = new Set(), nums = part.rows.map(rowNum).filter(n => !isNaN(n));
    if (!p.bci || !nums.length) return out;
    const lo = Math.min(...nums), hi = Math.max(...nums);
    for (const [i, c1, v1, c2, v2] of part.bc.s) {
      if (seen.has(i)) continue;
      let at = null;
      if (c1 === part.c && v1 >= lo && v1 <= hi) at = v1;
      else if (first && couvre([c1, v1, c2, v2], part.c, lo)) at = lo;   // § déjà commencé : en tête du passage
      if (at === null) continue;
      seen.add(i);
      if (!out.has(at)) out.set(at, []);
      out.get(at).push(i);
    }
    for (const l of out.values()) l.sort((a, b) => (/-/.test(bcEntry(p.bci, b).n) - /-/.test(bcEntry(p.bci, a).n)) || a.localeCompare(b));
    return out;
  }
  // le même § dans le volume de texte (BC II, synopse) : clé de data/bct, ou null (groupes « 141-143 » : pas de fichier)
  const bctCle = (tx, n) => tx && tx.num[String(n).replace(/\s*bis$/, " bis")] || null;
  // adresse de la page d'un § : #/s/<clé>[/<onglet>|-[/<Évangile>]] ; « - » = le dernier onglet utilisé
  const secHref = (k, onglet, ev) => `#/s/${k}` + (onglet || ev ? `/${onglet || "-"}` : "") + (ev ? `/${ev}` : "");
  // depuis une entrée du commentaire (§ ou groupe « 141-143 ») : sa page de §, sinon l'ancienne page du commentaire
  const bcHref = (tx, e, onglet, ev) => { const ks = bctDe(tx, e.n); return ks.length ? secHref(ks[0], ks.length > 1 ? "commentaire" : onglet, ev) : `#/bc/${e.i}`; };
  const bcMarkHTML = (ix, is, tx, b) => `<div class="bc-marks">` + is.map(i => {
    const e = bcEntry(ix, i);
    return `<a class="bc-mark" href="${bcHref(tx, e, "", b)}"><b>§ ${esc(e.n)}</b> ${esc(e.t)}<span>Bible chrétienne : synopse, mis en regard, commentaire ›</span></a>`;
  }).join("") + `</div>`;
  // paragraphes du commentaire qui visent ce verset : [[i, j], …]
  const bcVerse = (part, n) => part.bc.v.filter(x => couvre(x, part.c, n)).map(x => [x[4], x[5]]).filter((x, k, a) => a.findIndex(y => y[0] === x[0] && y[1] === x[1]) === k);

  // références bibliques et renvois « § 88 » cliquables dans le texte (OCR, donc échappé d'abord)
  let BC_RE = null;
  function bcLiens(t, ix) {
    if (!BC_RE) {
      const ab = BOOKS.map(b => b.a).sort((a, b) => b.length - a.length).map(a => a.replace(/ /g, "\\s?"));
      BC_RE = new RegExp(`(?<![\\wÀ-ÿ])(${ab.join("|")}) (\\d+,\\s?\\d+[abc]?(?:[-–.]\\d+[abc]?)*\\*?(?:\\s?;\\s?\\d+,\\d+[abc]?(?:[-–.]\\d+[abc]?)*\\*?)*)`, "g");
    }
    const abbr = Object.fromEntries(BOOKS.map(b => [b.a.replace(/\s/g, ""), b.c]));
    let h = esc(t).replace(BC_RE, (all, a, chain) => {
      const b = abbr[a.replace(/\s/g, "")];
      if (!b) return all;
      return esc(a) + " " + chain.replace(/(\d+),\s?(\d+)([^;]*)/g, (s, c, v) => byCode[b].ch.includes(+c) ? `<a class="bc-l" href="#/p/${b}:${c}:1:999@${b}.${c}.${v}">${s}</a>` : s);
    });
    if (ix || TXI) h = h.replace(/§ (\d+)/g, (s, n) => { const k = bctCle(TXI, n); return k ? `<a class="bc-l" href="${secHref(k)}">${s}</a>` : ix && ix.num[n] ? `<a class="bc-l" href="#/bc/${ix.num[n]}">${s}</a>` : s; });
    return h;
  }
  function bcPara(q, ix) {
    const t = bcLiens(q.t, ix);
    if (q.k === "verset") return `<p class="bc bc-v"><b class="bc-r">${bcLiens(q.ref || "", ix)}</b> — ${t}</p>`;
    if (q.k === "pere") return `<div class="ex bc-pere"><div class="who">${esc(q.auteur)}</div><div class="t">${t}</div></div>`;
    if (q.k === "at") return `<p class="bc bc-at"><span class="bc-sig" title="Texte de l'Ancien Testament">▸</span> ${t}</p>`;
    if (q.k === "note") return `<p class="note"><b class="k">(${esc(q.n)})</b>${t}</p>`;
    return `<p class="bc">${t}</p>`;
  }
  const isNT = b => byCode[b].t === "NT";
  const vkey = (p, r) => `${p.b}.${p.c}.${r.bj ? (r.bj.id || r.bj.v) : r.k}`;

  async function viewPassage(spec, step) {
    const p = await getPassage(spec);
    const at = spec.includes("@") ? spec.split("@")[1] : null;
    if (step !== "meditatio") step = "lectio";      // anciennes adresses (oratio, contemplatio) : le texte
    setChrome(p.label, step === "lectio" ? (p.title || byCode[p.segs[0].b].n) : "Éclairages", p.whole ? `#/b/${p.segs[0].b}` : `#/p/${p.segs[0].b}:${p.segs[0].c}:1:999@${p.segs[0].b}.${p.segs[0].c}.${p.segs[0].from}`, !p.whole);
    document.querySelectorAll("#steps button").forEach(b => b.classList.toggle("on", b.dataset.step === step));
    ls.set("bible.last", { spec: p.spec, label: p.label, title: p.title });
    if (step === "meditatio") renderMeditatio(p);
    else renderLectio(p);
    if (at && step === "lectio") {
      const el = document.getElementById("v-" + at.replace(/\./g, "-"));
      if (el) { toggleVerse(el, true); el.scrollIntoView({ block: "center" }); }
    } else window.scrollTo(0, 0);
  }

  function renderLectio(p) {
    WORDS = [];
    const e = entry(p.spec, p.label, false), kept = new Set(e ? e.kept.map(k => k.id) : []);
    let h = "";
    p.parts.forEach((part, pi) => {
      if (p.parts.length > 1) h += `<div class="ref-h">${esc(byCode[part.b].n)} ${part.c}</div>`;
      const marks = O.bc ? bcMarks(p, part, pi === 0) : new Map();
      for (const r of part.rows) {
        const v = r.bj;
        // dans un chapitre entier, le titre de la péricope (le dernier titre, niveau 3 et plus) est lui-même le lien vers le passage seul
        if (v && v.h) h += `<div class="heads">${v.h.map(([l, t], i) => p.whole && l >= 3 && i === v.h.length - 1
          ? `<div class="h${l}"><a class="peri-l" data-lectio="${part.b}:${part.c}:${rowNum(r)}">${t}</a></div>` : `<div class="h${l}">${t}</div>`).join("")}</div>`;
        const key = vkey(part, r), n = rowNum(r);
        if (marks.has(n)) { h += bcMarkHTML(p.bci, marks.get(n), p.bcti, part.b); marks.delete(n); }
        const hasP = part.tae.some(s => s.c1 === part.c && s.v1 === n);
        const id = "v-" + key.replace(/\./g, "-");
        const txt = v ? `<span class="vn">${esc(v.v)}</span>${v.t}` : `<span class="vn">${esc(r.k)}</span><span class="missing">(pas dans la BJ)</span>`;
        h += `<p class="v${kept.has(key) ? " kept" : ""}" id="${id}" data-k="${esc(key)}"><span class="txt">${txt}${hasP ? `<span class="pere-mark" title="Commentaire des Pères">✠</span>` : ""}</span>` +
          (O.always ? `<span class="under">${under(part, r)}</span>` : "") + `</p>`;
      }
    });
    h += `<div class="pager" id="pager"></div>`;
    $("#view").innerHTML = h;
    pager(p);
  }

  // ce qui s'affiche sous un verset : l'original (mot à mot) et/ou le latin
  function under(part, r) {
    const ch = part.ch, v = r.bj, mode = isNT(part.b) ? O.modeNT : O.modeAT;
    const id = v ? v.v : r.k;
    let h = "";
    if (mode !== "lat") {
      if (v && v.x) h += `<div class="missing">${esc(v.x)} — pas de texte original.</div>`;
      else if (ch.il && r.k !== null && ch.il[r.k]) h += words(ch.il[r.k], ch.src, part, r);
      else {
        const g = ch.gr && (ch.gr[id] ?? (r.k !== null ? ch.gr[r.k] : undefined));
        h += g ? `<div class="lxx"><span class="lbl">Septante</span>${esc(g)}</div>` : `<div class="missing">Pas de texte original pour ce verset.</div>`;
      }
    }
    if (mode !== "orig") {
      const L = ch.lat[O.vulg] || {};
      const t = L[id] ?? (r.k !== null ? L[r.k] : undefined) ?? L[String(num(id))];
      h += t ? `<div class="lat"><span class="lbl">${O.vulg === "NVU" ? "Nova Vulgata" : "Vulgate"}</span>${latMots(t)}</div>` : `<div class="missing">Pas de texte latin pour ce verset.</div>`;
    }
    return h;
  }
  // latin : chaque mot devient touchable (fiche faite à partir de Collatinus, voir latin.py)
  const latMots = t => String(t).split(/([A-Za-zÀ-ÿæœÆŒ]+)/).map((x, i) => i % 2 ? `<span class="lw">${esc(x)}</span>` : esc(x)).join("");
  const cleLat = w => w.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/æ/g, "ae").replace(/œ/g, "oe");
  async function latSheet(el) {
    document.querySelectorAll(".lw.sel, .w.sel").forEach(x => x.classList.remove("sel")); el.classList.add("sel");
    const mot = el.textContent, k = cleLat(mot);
    const [L, F] = await Promise.all([loadQ("data/latin/lemmes.js", "__LEM").catch(() => []), loadQ(`data/latin/${k[0]}.js`, "__LAT").catch(() => ({}))]);
    const an = F[k] || [];
    let h = `<div class="bigw lat-w">${esc(mot)}</div>`;
    if (!an.length) h += `<p class="missing" style="text-align:center">Mot non reconnu (souvent un nom propre).</p>`;
    else h += `<dl class="lat-dl">` + an.map(([n, m]) => { const [, gr, sens] = L[n] || ["", "?", ""];
      return `<dt>${esc(gr)}</dt><dd>${sens ? esc(sens) : `<span class="missing">sens non donné</span>`}${m ? `<div class="lat-an">${esc(m)}</div>` : ""}</dd>`; }).join("") + `</dl>`;
    const lem = an.length ? (L[an[0][0]] || [])[1] || mot : mot;
    h += `<p class="aide-lat">Analyses proposées par Collatinus : quand plusieurs sont possibles, le contexte décide.</p>` +
      `<a class="btn" href="https://gaffiot.fr/#${encodeURIComponent(lem.replace(/\d+$/, ""))}" target="_blank" rel="noopener">Gaffiot (en ligne) ›</a>`;
    sheet(h);
  }
  let WORDS = [];
  function words(ws, src, part, r) {
    const heb = src === "ATI";
    return `<div class="words ${heb ? "rtl" : ""}">` + ws.map(w => {
      const i = WORDS.push(w) - 1;
      return `<span class="w" data-w="${i}" data-src="${src}"><span class="st">${esc(w.s ? w.s.slice(1) : "")}</span><span class="tr">${esc(heb ? w.tr : w.l)}</span>` +
        `<span class="orig ${heb ? "heb" : "grk"}">${esc(w.w)}</span><span class="gl">${esc(w.g)}</span><span class="sg">${esc(w.sg)}</span><span class="mo">${esc(w.m)}</span></span>`;
    }).join("") + `</div>`;
  }
  function toggleVerse(el, force) {
    const open = force ?? !el.classList.contains("open");
    el.querySelectorAll(".under, .acts").forEach(x => { if (!O.always || x.classList.contains("acts")) x.remove(); });
    el.classList.toggle("open", open);
    if (!open) return;
    const [b, c] = el.dataset.k.split("."), part = P.parts.find(x => x.b === b && x.c === +c);
    const r = part.rows.find(r => vkey(part, r) === el.dataset.k);
    if (!O.always) el.insertAdjacentHTML("beforeend", `<span class="under" style="display:block">${under(part, r)}</span>`);
    const e = entry(P.spec, P.label, false), kept = e && e.kept.some(k => k.id === el.dataset.k);
    const n = rowNum(r), secs = part.tae.filter(s => s.c1 <= part.c && s.c2 >= part.c && s.v1 <= n && n <= s.v2);
    const nNotes = r.bj ? r.bj.n.length : 0;
    const cites = (part.dr[`${part.c}.${n}`] || []);
    const bcv = P.bci ? bcVerse(part, n) : [];
    el.insertAdjacentHTML("beforeend", `<span class="acts">` +
      `<button class="chip${kept ? " kept" : ""}" data-keep="${esc(el.dataset.k)}">${kept ? "★ Retenu" : "☆ Retenir"}</button>` +
      (secs.length ? `<button class="chip" data-peres="${esc(el.dataset.k)}">✠ Les Pères <small>(${secs.reduce((a, s) => a + s.x.length, 0)})</small></button>` : "") +
      (bcv.length ? `<button class="chip bc-chip" data-bcv="${esc(el.dataset.k)}">✦ Commentaire <small>(${bcv.length})</small></button>` : "") +
      (nNotes ? `<button class="chip" data-vnotes="${esc(el.dataset.k)}">Notes BJ <small>(${nNotes})</small></button>` : "") +
      (cites.length ? `<button class="chip" data-themes="${esc(el.dataset.k)}">Thèmes <small>(${cites.length})</small></button>` : "") + `</span>`);
  }

  async function pager(p) {
    const f = p.segs[0], l = p.segs[p.segs.length - 1], book = byCode[f.b], chs = book.ch;
    let prev = null, next = null;
    if (p.whole) {
      const i = chs.indexOf(f.c);
      if (i > 0) prev = { href: `#/p/${f.b}:${chs[i - 1]}:1:999`, t: `${book.a} ${chs[i - 1]}` };
      if (i + 1 < chs.length) next = { href: `#/p/${f.b}:${chs[i + 1]}:1:999`, t: `${book.a} ${chs[i + 1]}` };
    } else {
      const lc = await chapter(l.b, l.c), lp = pericopes(lc).find(x => x.from > l.to);
      if (lp) next = { spec: [l.b, l.c, lp.from], t: lp.title };
      else { const i = chs.indexOf(l.c); if (i + 1 < chs.length) { const np = pericopes(await chapter(l.b, chs[i + 1])); const q = np.find(x => x.from > 1 || np.length === 1) || np[0]; if (q) next = { spec: [l.b, chs[i + 1], q.from], t: q.title }; } }
      const fc = await chapter(f.b, f.c), fp = pericopes(fc).filter(x => x.from < f.from).pop();
      if (fp) prev = { spec: [f.b, f.c, fp.from], t: fp.title };
      else { const i = chs.indexOf(f.c); if (i > 0) { const pp = pericopes(await chapter(f.b, chs[i - 1])).pop(); if (pp) prev = { spec: [f.b, chs[i - 1], pp.from], t: pp.title }; } }
      for (const x of [prev, next]) if (x && x.spec) x.href = "#/p/" + await pericopeSpec(...x.spec);
    }
    const el = $("#pager"); if (!el) return;
    el.innerHTML = (prev ? `<a href="${prev.href}">‹ Précédent<small>${esc(prev.t)}</small></a>` : "") +
      (next ? `<a class="next" href="${next.href}">Suivant ›<small>${esc(next.t)}</small></a>` : "");
  }

  // ------------------------------------------------------------------ meditatio : retenus, Pères, notes BJ
  let authorFilter = "";
  // Éclairages : les § de la Bible chrétienne qui portent sur le passage, leur premier paragraphe
  async function bcMeditatio(p) {
    const ids = [];
    for (const part of p.parts) {
      const nums = part.rows.map(rowNum).filter(n => !isNaN(n));
      if (!nums.length) continue;
      const lo = Math.min(...nums), hi = Math.max(...nums);
      for (const [i, c1, v1, c2, v2] of part.bc.s)
        if (!ids.includes(i) && !((c2 < part.c || (c2 === part.c && v2 < lo)) || (c1 > part.c || (c1 === part.c && v1 > hi)))) ids.push(i);
    }
    if (!ids.length) return;
    const groupe = i => /-/.test(bcEntry(p.bci, i).n);
    ids.sort((a, b) => (groupe(a) - groupe(b)) || a.localeCompare(b));
    const princ = ids.filter(i => !groupe(i)).slice(0, 3), autres = ids.filter(i => !princ.includes(i));
    let h = `<p class="missing com-src">Bible chrétienne II* : le commentaire de Dom Claude Jean-Nesmy, § par §.</p>`;
    for (const i of princ.length ? princ : ids.slice(0, 1)) {
      const s = await bcSec(i).catch(() => null);
      if (!s) continue;
      const q = s.paras.find(x => x.k === "texte" && x.t.length > 120) || s.paras[0];
      h += `<div class="ex bc-ex"><div class="who">§ ${esc(s.n)} — ${esc(s.titre)}</div><div class="src">${bcFusion(s.refs).map(bcRefLabel).map(esc).join(" · ")}</div>` +
        (q ? `<div class="t bc-extrait">${bcLiens(q.t.length > 600 ? q.t.slice(0, 600).replace(/\s\S*$/, "") + "…" : q.t, p.bci)}</div>` : "") +
        `<a class="more" href="${bcHref(p.bcti, s, "commentaire")}">Lire le commentaire ›</a>` +
        (bctDe(p.bcti, s.n).length ? ` <a class="more bc-syn" href="${bcHref(p.bcti, s, "synopse", p.segs[0].b)}">Synopse et textes mis en regard ›</a>` : "") + `</div>`;
    }
    const reste = autres.filter(i => princ.length || i !== ids[0]);
    if (reste.length) h += `<p class="missing">Voir aussi :</p><div class="chips">` + reste.map(i => { const x = bcEntry(p.bci, i); return `<a class="chip" href="${bcHref(p.bcti, x)}">§ ${esc(x.n)} ${esc(x.t)}</a>`; }).join("") + `</div>`;
    const el = $("#bcmed"); if (el && P === p) el.innerHTML = h;
  }

  function renderMeditatio(p) {
    const e = { kept: keptFor(p.spec) };
    let h = "";
    if (e && e.kept.length) h += `<h1 class="sect">Versets retenus</h1><div class="kept-list">${e.kept.map(k => `<blockquote>${esc(k.t)}<cite>${esc(k.ref)}</cite></blockquote>`).join("")}</div>`;
    const secs = p.parts.flatMap(x => x.tae);
    h += comChoixHTML(!!p.bci, secs.length > 0, GOSPELS.has(p.segs[0].b));
    if (comActif(!!p.bci, secs.length > 0) === "bc") h += `<div id="bcmed"><p class="missing">Chargement…</p></div>`;
    else if (secs.length) h += peresBlocHTML(secs, p.segs[0].b, true);
    h += themesHTML(p);
    const notes = p.parts.flatMap(x => x.rows.flatMap(r => r.bj ? r.bj.n.map(n => [x, r, n]) : []));
    if (notes.length) h += `<h1 class="sect">Notes de la Bible de Jérusalem</h1>` + notes.map(([x, r, [k, t]]) => `<p class="note"><b class="k">${esc(r.bj.v)} ${esc(k)}</b>${t}</p>`).join("");
    if (p.bci && comActif(true, secs.length > 0) === "bc") bcMeditatio(p);
    $("#view").innerHTML = h;
  }
  // commentaire : Bible chrétienne (BC II*) ou Chaîne d'or (Pères), au choix ; le choix est gardé (O.com)
  const comActif = (aBC, aPeres) => (O.com === "peres" && aPeres) || !aBC ? "peres" : "bc";
  function comChoixHTML(aBC, aPeres, evangile) {
    let h = `<h1 class="sect">Commentaires</h1>`;
    if (aBC && aPeres) h += `<div class="seg com-seg">${[["bc", "Bible chrétienne"], ["peres", "Chaîne d’or · les Pères"]].map(([k, l]) =>
      `<button data-com="${k}" class="${comActif(aBC, aPeres) === k ? "on" : ""}">${l}</button>`).join("")}</div>`;
    else if (!aBC && !aPeres) h += `<p class="missing">${evangile ? "Pas de commentaire pour ce passage." : "La Bible chrétienne et la Chaîne d’or de saint Thomas d’Aquin ne commentent que les quatre évangiles."}</p>`;
    return h;
  }
  function peresBlocHTML(secs, b, filtre) {
    const cnt = {};
    secs.forEach(s => s.x.forEach(([a]) => cnt[a] = (cnt[a] || 0) + 1));
    const authors = Object.keys(cnt).sort((a, b) => cnt[b] - cnt[a]);
    if (authorFilter && !cnt[authorFilter]) authorFilter = "";
    let h = `<p class="missing com-src">La Chaîne d’or de saint Thomas d’Aquin : les Pères de l’Église, verset par verset.</p>`;
    if (filtre) h += `<div class="authors"><button class="chip${authorFilter ? "" : " on"}" data-author="">Tous</button>` +
      authors.map(a => `<button class="chip${a === authorFilter ? " on" : ""}" data-author="${esc(a)}">${esc(a.replace(/^Saint /, "S. "))} <small>${cnt[a]}</small></button>`).join("") + `</div>`;
    return h + peresHTML(secs, b);
  }
  function peresHTML(secs, b) {
    let h = "";
    for (const s of secs) {
      const xs = s.x.filter(([a]) => !authorFilter || a === authorFilter);
      if (!xs.length) continue;
      h += `<div class="sec-h">${esc(byCode[b].a)} ${esc(s.r.replace(".", ","))}</div>` + (s.q && !authorFilter ? `<div class="sec-q">${s.q}</div>` : "");
      h += xs.map(([a, src, t]) => `<div class="ex${t.length > 700 ? " short" : ""}"><div class="who">${esc(a)}</div>${src ? `<div class="src">${esc(src)}</div>` : ""}<div class="t">${t}</div>${t.length > 700 ? `<button class="more">Lire la suite</button>` : ""}</div>`).join("");
    }
    return h;
  }

  // ------------------------------------------------------------------ dictionnaires
  // les articles qui citent des versets du passage, du plus cité au moins cité
  function citesOf(p, rowsFilter) {
    const cnt = new Map();
    for (const part of p.parts) for (const r of part.rows) {
      if (rowsFilter && !rowsFilter(part, r)) continue;
      for (const [d, e] of part.dr[`${part.c}.${rowNum(r)}`] || []) { const k = d + "|" + e; cnt.set(k, (cnt.get(k) || 0) + 1); }
    }
    const byDico = new Map();
    for (const [k, n] of cnt) { const [d, e] = k.split("|").map(Number); if (!byDico.has(d)) byDico.set(d, []); byDico.get(d).push([e, n]); }
    for (const l of byDico.values()) l.sort((a, b) => b[1] - a[1]);
    return byDico;
  }
  function themeChips(p, byDico, d, max) {
    const D = p.dico.d.find(x => x.i === d); if (!D) return "";
    const T = p.dico.t[D.c], l = byDico.get(d) || [];
    return l.slice(0, max || 999).map(([e, n]) => `<button class="chip" data-art="${esc(D.c)}|${esc(T[e][0])}">${esc(T[e][0].charAt(0) + T[e][0].slice(1).toLowerCase())}${n > 1 ? ` <small>${n}</small>` : ""}</button>`).join("");
  }
  function themesHTML(p, rowsFilter, title) {
    const byDico = citesOf(p, rowsFilter);
    if (!byDico.size) return "";
    let h = `<h1 class="sect">${title || "Thèmes bibliques"}</h1>`;
    const vtb = p.dico.d.find(x => x.c === "VTB");
    if (vtb && byDico.has(vtb.i)) h += `<p class="missing">Vocabulaire de théologie biblique : les articles qui citent ${rowsFilter ? "ce verset" : "ce passage"}.</p><div class="chips">${themeChips(p, byDico, vtb.i, rowsFilter ? 0 : 24)}</div>`;
    for (const D of p.dico.d) {
      if (D.c === "VTB" || !byDico.has(D.i)) continue;
      h += `<details class="dico"><summary>${esc(D.n)} <small>(${byDico.get(D.i).length})</small></summary><div class="chips">${themeChips(p, byDico, D.i, 40)}</div></details>`;
    }
    return h;
  }
  async function openArticle(code, title) {
    const ix = await dicoIndex(), T = ix.t[code] || [], D = ix.d.find(x => x.c === code);
    const hit = T.find(t => t[0] === title) || T.find(t => t[0].toLowerCase() === title.toLowerCase());
    if (!hit) return sheet(`<p class="missing">Article « ${esc(title)} » introuvable.</p>`);
    const pack = await loadQ(`data/dico/${code}/${pad(hit[1])}.js`, "__ART").catch(() => ({}));
    sheet(`<h3>${esc(D ? D.n : code)}</h3><h2 class="art-t">${esc(hit[0])}</h2><div class="lex art">${pack[hit[0]] || "Article introuvable."}</div>`);
  }
  const norm = s => String(s).normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/œ/gi, "oe").replace(/æ/gi, "ae").toLowerCase();
  let dicoQ = "", dicoF = "VTB";
  async function viewDico() {
    setChrome("Dictionnaires", "", null, false);
    const ix = await dicoIndex();
    $("#view").innerHTML = `<input id="dq" type="search" placeholder="Chercher un mot : grâce, alliance, Abraham…" value="${esc(dicoQ)}" autocomplete="off">
      <div class="authors" id="df">${[["", "Tous"], ...ix.d.map(d => [d.c, d.n])].map(([c, n]) => `<button class="chip${dicoF === c ? " on" : ""}" data-df="${c}">${esc(n)}</button>`).join("")}</div>
      <p class="missing" style="margin:2px 0 8px">Astuce : en lisant, touchez un verset puis « Thèmes » pour voir les articles qui le citent.</p><div id="dr"></div>`;
    const run = () => {
      const q = norm(dicoQ.trim()), out = [];
      for (const d of ix.d) {
        if (dicoF && d.c !== dicoF) continue;
        for (const [t] of ix.t[d.c]) {
          const n = norm(t);
          if (!q || n.includes(q)) out.push([n.startsWith(q) ? 0 : 1, d, t]);
        }
      }
      out.sort((a, b) => a[0] - b[0] || norm(a[2]).localeCompare(norm(b[2])));
      const lim = out.slice(0, q ? 300 : 1000);
      $("#dr").innerHTML = lim.map(([, d, t]) => `<a class="entry" data-art="${esc(d.c)}|${esc(t)}"><span class="l">${esc(t)}</span>${dicoF ? "" : ` <span class="d">${esc(d.n)}</span>`}</a>`).join("") +
        (out.length > lim.length ? `<p class="missing">${out.length - lim.length} autres résultats : précisez la recherche.</p>` : "") + (!out.length ? `<p class="missing">Aucun article.</p>` : "");
    };
    $("#dq").addEventListener("input", e => { dicoQ = e.target.value; run(); });
    run();
    window.scrollTo(0, 0);
  }

  // ------------------------------------------------------------------ carnet
  function viewCarnet() {
    setChrome("Carnet", "sur ce téléphone", null, false);
    const all = carnet().filter(e => e.kept.length || e.priere.trim());
    let h = all.length ? "" : `<p class="prompt">Le carnet garde, jour après jour, les versets retenus (toucher un verset, puis « Retenir »).</p>`;
    h += all.map(e => `<a class="entry" href="#/p/${esc(e.spec)}"><div class="d">${esc(new Date(e.d + "T12:00:00").toLocaleDateString("fr-FR", { weekday: "long", day: "numeric", month: "long", year: "numeric" }))}</div>` +
      `<div class="l">${esc(e.label)}</div>${e.kept.map(k => `<div class="k">« ${esc(k.t)} »</div>`).join("")}${e.priere ? `<div class="p">${esc(e.priere)}</div>` : ""}</a>`).join("");
    if (all.length) h += `<button class="btn ghost" id="export">Exporter le carnet (texte)</button>`;
    $("#view").innerHTML = h;
    window.scrollTo(0, 0);
  }
  function exportCarnet() {
    const txt = carnet().filter(e => e.kept.length || e.priere.trim()).map(e =>
      `${e.d} — ${e.label}\n${e.kept.map(k => `« ${k.t} » (${k.ref})`).join("\n")}\n${e.priere}\n`).join("\n");
    const a = document.createElement("a");
    a.href = URL.createObjectURL(new Blob([txt], { type: "text/plain;charset=utf-8" }));
    a.download = `carnet-bible-${today()}.txt`; a.click();
  }

  // ------------------------------------------------------------------ fiches : mot, lexique, notes, Pères, réglages
  function wordSheet(el) {
    const w = WORDS[+el.dataset.w], heb = el.dataset.src === "ATI";
    document.querySelectorAll(".w.sel").forEach(x => x.classList.remove("sel")); el.classList.add("sel");
    const rows = [
      heb && w.seg && w.seg !== w.w ? ["Segmenté", `<span style="font-family:var(--heb);font-size:1.3em" dir="rtl">${esc(w.seg)}</span>`] : null,
      heb ? ["Translit.", `<i>${esc(w.tr)}</i>`] : ["Lemme", `<span style="font-family:var(--grk);font-size:1.15em">${esc(w.l)}</span>`],
      ["Mot à mot", `<span style="color:var(--gloss)">${esc(w.g)}</span>`],
      w.sg ? ["Segond", `<span style="color:var(--lsg)">${esc(w.sg)}</span>`] : null,
      ["Analyse", `<b>${esc(w.m)}</b>${w.ml ? " — " + esc(w.ml) : ""}`],
      w.s ? ["Strong", `<b>${esc(w.s)}</b> — ${esc(w.d)}`] : null,
    ].filter(Boolean);
    sheet(`<div class="bigw ${heb ? "heb" : "grk"}">${esc(w.w)}</div><dl>${rows.map(([a, b]) => `<dt>${a}</dt><dd>${b}</dd>`).join("")}</dl>` +
      (w.s ? `<button class="btn" data-lex="${esc(w.s)}">Dictionnaire et concordance</button>` : ""));
  }
  async function lexSheet(s) {
    const n = parseInt(s.slice(1), 10), bucket = s[0] + Math.floor(n / 100);
    const lex = await loadQ(`data/lex/${bucket}.js`, "__LEX").catch(() => ({}));
    const conc = await loadQ(`data/conc/${bucket}.js`, "__CONC").catch(() => ({}));
    let h = `<div class="lex">${lex[s] || `<p class="missing">Pas d’article pour ${esc(s)}.</p>`}</div>`;
    const occ = conc[s] || [];
    if (occ.length) {
      const g = new Map();
      for (const [ref, gl] of occ) {
        const m = /^([1-3]?[A-Z]{2,3})(\d+)\.(.+)$/.exec(ref); if (!m) continue;
        if (!g.has(m[1])) g.set(m[1], []);
        g.get(m[1]).push(`<a class="ref" data-r="${esc(ref)}" title="${esc(gl)}">${m[2]},${esc(m[3])}</a>`);
      }
      h += `<h3>Concordance — ${occ.length} verset${occ.length > 1 ? "s" : ""}</h3><div class="conc">` + [...g].map(([b, refs]) => `<p><b>${esc(byCode[b] ? byCode[b].a : b)}</b> ${refs.join(" · ")}</p>`).join("") + `</div>`;
    }
    sheet(h);
  }
  function findRow(k) {
    const [b, c] = k.split("."), part = P.parts.find(x => x.b === b && x.c === +c);
    return [part, part.rows.find(r => vkey(part, r) === k)];
  }
  function settingsSheet() {
    const seg = (k, opts) => `<div class="seg">${opts.map(([v, l]) => `<button data-opt="${k}" data-val="${v}" class="${String(O[k]) === String(v) ? "on" : ""}">${l}</button>`).join("")}</div>`;
    sheet(`<p class="hl-reglage"><a class="chip" href="#/horsligne">⤓ Lecture hors connexion ›</a></p>
      <h3>Sous le texte de la BJ</h3>
      <div class="row"><span>Nouveau Testament</span>${seg("modeNT", [["orig", "Grec"], ["lat", "Latin"], ["both", "Les deux"]])}</div>
      <div class="row"><span>Ancien Testament</span>${seg("modeAT", [["orig", "Hébreu"], ["lat", "Latin"], ["both", "Les deux"]])}</div>
      <div class="row"><span>Affichage</span>${seg("always", [[false, "Au toucher"], [true, "Toujours"]])}</div>
      <div class="row"><span>Latin</span>${seg("vulg", [["NVU", "Nova Vulgata"], ["VUC", "Clémentine"]])}</div>
      <h3>Mot à mot</h3>
      <div class="row"><span>Traduction</span>${seg("gloss", [["lit", "Littérale"], ["lsg", "Segond"], ["both", "Les deux"]])}</div>
      <div class="row"><span>Détails</span><div class="chips"><button class="chip${O.tr ? " on" : ""}" data-flag="tr">Translit.</button><button class="chip${O.st ? " on" : ""}" data-flag="st">Strong</button><button class="chip${O.mo ? " on" : ""}" data-flag="mo">Analyse</button></div></div>
      <h3>Lecture</h3>
      <div class="row"><span>Appels de notes BJ</span>${seg("notes", [[true, "Visibles"], [false, "Masqués"]])}</div>
      <div class="row"><span>§ de la Bible chrétienne</span>${seg("bc", [[true, "Visibles"], [false, "Masqués"]])}</div>
      <div class="row"><span>Taille du texte</span><div class="chips"><button class="chip" data-fs="-1">A−</button><button class="chip" data-fs="1">A+</button></div></div>
      <div class="row"><span>Thème</span>${seg("theme", [["", "Auto"], ["light", "Clair"], ["dark", "Sombre"]])}</div>
      <p style="margin-top:18px"><a class="ref" href="interlineaire.html">Vue interlinéaire complète (ordinateur, tablette)</a></p>`);
  }

  // ------------------------------------------------------------------ Bible chrétienne : sommaire et lecture d'un §
  // les § du volume de texte pour un § (ou un groupe « 141-143 ») du commentaire
  function bctDe(tx, n) {
    const out = [];
    for (const m of String(n).matchAll(/(\d+)(?:-(\d+))?( ?bis)?/g)) {
      const a = +m[1], b = m[2] && +m[2] > a ? +m[2] : a;
      for (let k = a; k <= b; k++) { const c = bctCle(tx, k + (m[3] && k === a ? " bis" : "")); if (c && !out.includes(c)) out.push(c); }
    }
    return out;
  }
  async function viewBCSec(i) {
    const [ix, s, tx] = await Promise.all([bcIndex(), bcSec(i), bctIndex()]);
    if (bctDe(tx, s.n).length) return location.replace(bcHref(tx, s, "commentaire"));   // anciennes adresses #/bc/<i>
    setChrome(`§ ${s.n}`, "Bible chrétienne — commentaire", "retour", false);
    const syn = bctDe(tx, s.n);
    let h = `<div class="bc-head"><h1 class="bc-t">${esc(s.titre)}</h1>` +
      (s.refs.length ? `<div class="chips">${bcFusion(s.refs).map(r => `<a class="chip" href="#/p/${bcSpec(r)}">${esc(bcRefLabel(r))}</a>`).join("")}</div>` : "") +
      (syn.length ? `<div class="chips bc-vers">${syn.map(k => `<a class="chip on" href="#/bct/${esc(k)}">${syn.length > 1 ? `§ ${esc(tx.sections.find(x => x.k === k).n)} — ` : ""}Texte en synopse ›</a>`).join("")}</div>` : "") + `</div>`;
    let page = null;
    for (const q of s.paras) {
      if (q.page !== page) { h += `<div class="bc-page">p. ${esc(q.page)}</div>`; page = q.page; }
      h += bcPara(q, ix);
    }
    const k = +i, prev = ix.sections[k - 1], next = ix.sections[k + 1];
    h += `<div class="pager">` + (prev ? `<a href="#/bc/${prev.i}">‹ § ${esc(prev.n)}<small>${esc(prev.t)}</small></a>` : "") +
      (next ? `<a class="next" href="#/bc/${next.i}">§ ${esc(next.n)} ›<small>${esc(next.t)}</small></a>` : "") + `</div>`;
    h += `<p class="missing bc-src"><i>Bible chrétienne II*</i>, Commentaires, ${esc(ix.livre.edition)}. Texte numérisé (OCR), non relu : il peut rester des fautes de lecture. <a href="#/bc">Sommaire</a></p>`;
    $("#view").innerHTML = h;
    window.scrollTo(0, 0);
  }
  // ------------------------------------------------------------------ Bible chrétienne : la page d'un §
  // Trois onglets en bas : Synopse (BC II, traduction de Mère de Solms), Mis en regard (BC II, textes parallèles),
  // Commentaire (BC II*). Adresse : #/s/<clé>/<onglet>/<Évangile>.
  const EVS = [["MAT", "Matthieu", "Mt"], ["MRK", "Marc", "Mc"], ["LUK", "Luc", "Lc"], ["JHN", "Jean", "Jn"]];
  const ONGLETS = ["synopse", "regard", "commentaire"];
  let bctEv = "", regardFiltre = "", SEC = null, COM = null;
  const large = () => window.matchMedia("(min-width: 900px)").matches;
  // clé de § du texte -> entrées du commentaire qui le couvrent (le § seul d'abord, puis les groupes)
  function comDe(ix, tx, k) {
    if (!ix || !tx) return [];
    if (!COM) {
      COM = new Map();
      for (const e of ix.sections) for (const c of bctDe(tx, e.n)) { if (!COM.has(c)) COM.set(c, []); COM.get(c).push(e); }
      for (const l of COM.values()) l.sort((a, b) => /-/.test(a.n) - /-/.test(b.n));
    }
    return COM.get(k) || [];
  }
  // Évangiles du § : d'abord ceux que la Table donne pour ce § (dans l'ordre Mt Mc Lc Jn), puis les textes renvoyés « (§ 87) »
  function evsDe(s) {
    const propres = new Set(s.refs.map(r => r[0]));
    const l = EVS.filter(([b]) => s.ev[b] && s.ev[b].length).map(([b, nm, a]) => ({ b, nm, a, renvoi: !propres.has(b) }));
    return l.sort((x, y) => x.renvoi - y.renvoi);
  }
  const sectionLisible = t => {
    const m = /^SECTION\s+(\S+?),?\s+(.*?)\s*(\(§[^)]*\))?\s*$/.exec(t || "");
    if (!m) return t || "";
    const nom = m[2].toLowerCase().replace(/^./, c => c.toUpperCase()).replace(/\bjésus\b/g, "Jésus").replace(/\bjérusalem\b/g, "Jérusalem").replace(/\bjudée\b/g, "Judée");
    return `${m[1].replace(/^I$/, "1")}. ${nom}${m[3] ? " " + m[3] : ""}`;
  };

  async function viewSec(k, onglet, ev) {
    const [tx, ix] = await Promise.all([bctIndex(), bcIndex()]);
    if (!tx) throw new Error("data/bct/index.js");
    const i = tx.sections.findIndex(x => x.k === k);
    if (i < 0) return viewBC();
    const s = await bctSec(k);
    if (!ONGLETS.includes(onglet)) onglet = ls.get("bc.onglet", "synopse");
    ls.set("bc.onglet", onglet);
    const evs = evsDe(s);
    if (ev && evs.some(x => x.b === ev)) bctEv = ev;
    else if (SEC?.k !== k || !evs.some(x => x.b === bctEv)) bctEv = (evs[0] || {}).b || "";
    SEC = { k, s, onglet, evs, coms: comDe(ix, tx, k), ix, tx };
    setChrome(`§ ${s.n}`, "Bible chrétienne", "retour", false);
    $("#tabs").hidden = true;
    const nav = $("#onglets"); nav.hidden = false;
    nav.innerHTML = [
      ["synopse", "Synopse", evs.filter(x => !x.renvoi).map(x => x.a).join(" · ") || "le texte"],
      ["regard", "Mis en regard", s.par.length ? `${s.par.length} texte${s.par.length > 1 ? "s" : ""}` : "aucun"],
      ["commentaire", "Commentaire", "Bible chrét., Pères"],
    ].map(([o, b, sp]) => `<button data-onglet="${o}" class="${o === onglet ? "on" : ""}"><b>${b}</b><span>${esc(sp)}</span></button>`).join("");
    // renvois de la Table : « Mc : § 147 »
    const renvois = Object.entries(s.table).filter(([, v]) => /§/.test(v)).flatMap(([a, v]) =>
      [...v.matchAll(/(\d+)/g)].slice(0, 1).map(m => { const c = bctCle(tx, m[1]); return c ? `<a class="chip bc-renvoi" href="${secHref(c, onglet)}">${esc(a)} : voir § ${esc(m[1])} ›</a>` : ""; }));
    let h = `<div class="bc-head"><h1 class="bc-t">${esc(s.titre)}</h1><div class="sub2 bc-ou">${esc(s.partie)} — ${esc(sectionLisible(s.section))}</div><div class="chips">` +
      bcFusion(s.refs).map(r => `<a class="chip" href="#/p/${bcSpec(r)}" title="Lire dans la Bible de Jérusalem">${esc(bcRefLabel(r))}</a>`).join("") + renvois.join("") + `</div></div>`;
    h += `<div id="onglet"></div>`;
    const prev = tx.sections[i - 1], next = tx.sections[i + 1];
    h += `<div class="pager">` + (prev ? `<a href="${secHref(prev.k, onglet)}">‹ § ${esc(prev.n)}<small>${esc(prev.t)}</small></a>` : "") +
      (next ? `<a class="next" href="${secHref(next.k, onglet)}">§ ${esc(next.n)} ›<small>${esc(next.t)}</small></a>` : "") + `</div>`;
    h += `<p class="missing bc-src" id="bc-source"></p>`;
    $("#view").innerHTML = h;
    await renderOnglet();
    window.scrollTo(0, 0);
  }

  async function renderOnglet() {
    const el = $("#onglet"); if (!el || !SEC) return;
    const { s, onglet, evs, coms, ix, tx } = SEC;
    $("#view").classList.toggle("syn-large", onglet === "synopse" && large() && O.synCols);
    const src = $("#bc-source");
    const ocr = "Texte numérisé (OCR), non relu : il peut rester des fautes de lecture.";
    if (onglet === "synopse") {
      if (src) src.innerHTML = `<i>Bible chrétienne II</i>, Les quatre Évangiles, traduction de Mère Élisabeth de Solms, ${esc(tx.livre.edition)}. ${ocr} Le n° de verset ouvre la Bible de Jérusalem. <a href="#/bc">Sommaire</a>`;
      if (!evs.length) { el.innerHTML = `<p class="missing">Pas de texte d'Évangile pour ce §.</p>`; return; }
      const colonne = e => {
        let h = `<div class="ref-h">${esc(e.nm)}${e.renvoi ? ` <small class="bc-renv">texte mis en regard, propre à un autre §</small>` : ""}</div>`, ch = null;
        for (const [c, v, t] of s.ev[e.b]) {
          const vn = c !== ch ? `${c},${v}` : v; ch = c;
          h += `<p class="v bct-v"><a class="vn" href="#/p/${e.b}:${c}:1:999@${e.b}.${c}.${v}" title="Ouvrir dans la Bible de Jérusalem">${esc(vn)}</a> ${esc(t)}</p>`;
        }
        return h;
      };
      // Côte à côte : une colonne par Évangile, plus (au choix) une colonne des textes mis en regard, comme les marges
      // de la Bible chrétienne. Sur téléphone, les colonnes défilent de gauche à droite (doigt glissé).
      const outils = `<div class="syn-outils"><div class="seg">${[[true, "Côte à côte"], [false, "Un Évangile"]].map(([v, l]) =>
        `<button data-syncols="${v ? 1 : 0}" class="${O.synCols === v ? "on" : ""}">${l}</button>`).join("")}</div>` +
        (s.par.length ? `<button class="chip${O.synRegard ? " on" : ""}" data-synregard>En regard <small>${s.par.length}</small></button>` : "") + `</div>`;
      const regardCol = () => {
        let h = `<div class="ref-h">En regard</div>`, theme = null;
        for (const q of s.par) {
          if (q.theme && q.theme !== theme) { h += `<div class="syn-th">« ${esc(q.theme)} »</div>`; theme = q.theme; }
          const lien = byCode[q.livre] && byCode[q.livre].ch.includes(q.ch) ? `#/p/${q.livre}:${q.ch}:1:999` + (q.v ? `@${q.livre}.${q.ch}.${q.v}` : "") : null;
          h += `<div class="syn-par"><b>${lien ? `<a class="bc-l" href="${lien}">${esc(q.ref)}</a>` : esc(q.ref)}</b> <span class="t">${esc(q.texte)}</span></div>`;
        }
        return h;
      };
      if (O.synCols) {
        const cols = evs.map(e => colonne(e)).concat(O.synRegard && s.par.length ? [regardCol()] : []);
        el.innerHTML = outils + `<div class="syn-cols${cols.length > 2 ? " syn-defile" : ""}" style="--n:${cols.length}">` +
          cols.map((c, i) => `<div class="syn-col${i >= evs.length ? " syn-col-regard" : ""}">${c}</div>`).join("") + `</div>`;
        return;
      }
      const cur = evs.find(e => e.b === bctEv) || evs[0];
      el.innerHTML = outils + (evs.length > 1 ? `<div class="seg bct-seg">${evs.map(e => `<button data-bctev="${e.b}" class="${e.b === cur.b ? "on" : ""}${e.renvoi ? " renv" : ""}">${e.nm}</button>`).join("")}</div>` : "") + colonne(cur) +
        (O.synRegard && s.par.length ? `<div class="syn-regard-bas">${regardCol()}</div>` : "");
      return;
    }
    if (onglet === "regard") {
      if (src) src.innerHTML = `<i>Bible chrétienne II</i> : textes de l'Écriture mis en regard par Dom Claude Jean-Nesmy, ${esc(tx.livre.edition)}. ${ocr} La référence ouvre la Bible de Jérusalem. <a href="#/bc">Sommaire</a>`;
      if (!s.par.length) { el.innerHTML = `<p class="missing">Pas de texte mis en regard pour ce §.</p>`; return; }
      const testament = q => (byCode[q.livre] || {}).t || "";
      const nAT = s.par.filter(q => testament(q) === "AT").length, nNT = s.par.filter(q => testament(q) === "NT").length;
      if (!(regardFiltre === "AT" && nAT) && !(regardFiltre === "NT" && nNT)) regardFiltre = "";
      let h = nAT && nNT ? `<div class="seg bct-seg">${[["", `Tous (${s.par.length})`], ["AT", `Ancien T. (${nAT})`], ["NT", `Nouveau T. (${nNT})`]].map(([f, l]) => `<button data-regard="${f}" class="${f === regardFiltre ? "on" : ""}">${l}</button>`).join("")}</div>` : "";
      let theme = null;
      for (const q of s.par) {
        if (regardFiltre && testament(q) !== regardFiltre) continue;
        if (q.theme && q.theme !== theme) { h += `<div class="sec-h bc-theme">« ${esc(q.theme)} »</div>`; theme = q.theme; }
        const lien = byCode[q.livre] && byCode[q.livre].ch.includes(q.ch) ? `#/p/${q.livre}:${q.ch}:1:999` + (q.v ? `@${q.livre}.${q.ch}.${q.v}` : "") : null;
        h += `<div class="ex bct-par"><div class="who">${lien ? `<a class="bc-l" href="${lien}">${esc(q.ref)}</a>` : esc(q.ref)}</div>` +
          `<div class="t">${esc(q.texte)}</div>` + (q.marge ? `<div class="src">Voir aussi : ${esc([].concat(q.marge).join(" ; "))}</div>` : "") + `</div>`;
      }
      el.innerHTML = h;
      return;
    }
    // commentaire : Bible chrétienne (II*) ou Chaîne d'or (Pères), au choix
    const peres = await peresDuSec(s);
    const choix = comChoixHTML(coms.length > 0, peres.length > 0, true).replace(/<h1 class="sect">Commentaires<\/h1>/, "");
    if (comActif(coms.length > 0, peres.length > 0) === "peres") {
      if (src) src.innerHTML = `Chaîne d’or de saint Thomas d’Aquin (Catena aurea), trad. française. <a href="#/bc">Sommaire</a>`;
      const sauve = authorFilter; authorFilter = "";
      el.innerHTML = choix + peres.map(([b, secs], i) => `<div class="ref-h">${esc(byCode[b].n)}</div>` +
        (i ? peresBlocHTML(secs, b, false).replace(/<p class="missing com-src">.*?<\/p>/, "") : peresBlocHTML(secs, b, false))).join("");
      authorFilter = sauve;
      return;
    }
    if (src) src.innerHTML = ix ? `<i>Bible chrétienne II*</i>, Commentaires, ${esc(ix.livre.edition)}. ${ocr} <a href="#/bc">Sommaire</a>` : "";
    if (!coms.length) { el.innerHTML = choix + `<p class="missing">Pas de commentaire propre à ce § dans le volume des Commentaires.</p>`; return; }
    el.innerHTML = `<p class="missing">Chargement…</p>`;
    let h = choix;
    for (const e of coms) {
      const c = await bcSec(e.i).catch(() => null);
      if (!c) continue;
      if (coms.length > 1 || /-/.test(c.n)) h += `<div class="sec-h">§ ${esc(c.n)} — ${esc(c.titre)}${/-/.test(c.n) ? ` <small class="bc-renv">commentaire commun à ces §</small>` : ""}</div>`;
      let page = null;
      for (const q of c.paras) {
        if (q.page !== page) { h += `<div class="bc-page">p. ${esc(q.page)}</div>`; page = q.page; }
        h += bcPara(q, ix);
      }
    }
    if (SEC && $("#onglet") === el) el.innerHTML = h;
  }
  // Chaîne d'or pour les versets d'un § : [[livre, sections]] (chapitres chargés à la demande)
  async function peresDuSec(s) {
    const out = [];
    for (const [b, c1, v1, c2, v2] of bcFusion(s.refs)) {
      const secs = [];
      for (let c = c1; c <= c2; c++)
        for (const x of await tae(b, c))
          if ((x.c1 < c2 || (x.c1 === c2 && x.v1 <= v2)) && (x.c2 > c1 || (x.c2 === c1 && x.v2 >= v1)) && !secs.includes(x)) secs.push(x);
      if (secs.length) out.push([b, secs]);
    }
    return out;
  }
  // téléphone tourné, fenêtre élargie : colonnes ou Évangile par Évangile
  window.matchMedia("(min-width: 900px)").addEventListener("change", () => { if (SEC && /^#\/s\//.test(location.hash) && SEC.onglet === "synopse") renderOnglet(); });

  // sommaire : tous les § du livre, par parties et sections
  async function viewBC() {
    const [tx, ix] = await Promise.all([bctIndex(), bcIndex()]);
    if (!tx && !ix) throw new Error("data/bct/index.js");
    setChrome("Bible chrétienne", "Les Évangiles en synopse", "#/", false);
    const ed = (tx || ix).livre.edition;
    let h = `<p class="missing bc-src">Mère Élisabeth de Solms, Dom Claude Jean-Nesmy, Mère Cécile Miville-Dechêne. ${esc(ed)}.<br>Pour chaque § : le texte des Évangiles en synopse, les textes de l'Écriture mis en regard, le commentaire.</p>`;
    const intro = ix && ix.sections.find(e => e.n === "intro");
    if (intro) h += `<ul class="peri"><li><a href="#/bc/${intro.i}"><span>p. ${esc(intro.p)}</span>${esc(intro.t)}</a></li></ul>`;
    if (!tx) { h += `<p class="missing">Le texte en synopse n'est pas installé (data/bct).</p>`; $("#view").innerHTML = h; return; }
    let partie = null, section = null;
    const abr = { MAT: "Mt", MRK: "Mc", LUK: "Lc", JHN: "Jn" };
    for (const e of tx.sections) {
      if (e.partie !== partie) { if (section !== null) h += `</ul></details>`; h += `<h1 class="sect">${esc(e.partie)}</h1>`; partie = e.partie; section = null; }
      if (e.section !== section) { if (section !== null) h += `</ul></details>`; h += `<details class="bc-sec"><summary>${esc(sectionLisible(e.section))}</summary><ul class="peri">`; section = e.section; }
      const evs = [...new Set(e.r.map(r => abr[r[0]]))].join(" ");
      h += `<li><a href="${secHref(e.k)}"><span>§ ${esc(e.n)}</span>${esc(e.t)}${evs ? ` <em class="bc-evs">${esc(evs)}</em>` : ""}</a></li>`;
    }
    h += `</ul></details>`;
    $("#view").innerHTML = h;
    window.scrollTo(0, 0);
  }

  // fiche : ce que la Bible chrétienne dit de ce verset
  async function bcVerseSheet(k) {
    const [part, r] = findRow(k), list = bcVerse(part, rowNum(r));
    const par = new Map();
    for (const [i, j] of list) { if (!par.has(i)) par.set(i, []); par.get(i).push(j); }
    let h = `<h3>Bible chrétienne — ${esc(byCode[part.b].a)} ${part.c},${esc(r.bj ? r.bj.v : r.k)}</h3>`;
    for (const [i, js] of par) {
      const s = await bcSec(i).catch(() => null);
      if (!s) continue;
      h += `<div class="sec-h">§ ${esc(s.n)} — ${esc(s.titre)}</div>` + js.map(j => bcPara(s.paras[j], P.bci)).join("") +
        `<p><a class="chip" href="${bcHref(P.bcti, s, "commentaire")}">Ouvrir le § ${esc(s.n)} ›</a></p>`;
    }
    sheet(h);
  }

  function goRef(r) {
    const m = /^([1-3]?[A-Z]{2,3})(\d+)(?:\.(\d+)(?:-(\d+))?)?/.exec(r);
    if (!m || !byCode[m[1]]) return;
    closeSheet();
    location.hash = `#/p/${m[1]}:${m[2]}:1:999` + (m[3] ? `@${m[1]}.${m[2]}.${m[3]}` : "");
  }

  // ------------------------------------------------------------------ interactions
  document.addEventListener("click", async ev => {
    const t = ev.target;
    const q = s => t.closest(s);
    let x;
    if ((x = q("[data-go]")) && x.dataset.go === "retour") { if (history.length > 1) history.back(); else location.hash = "#/bc"; return; }
    if ((x = q("[data-go]")) && x.dataset.go) { location.hash = x.dataset.go; return; }
    if ((x = q("a.bc-l, a.bc-mark, #sheet a[href^='#/bc'], #sheet a[href^='#/s/'], #sheet a[href^='#/horsligne']"))) { closeSheet(); return; }
    if ((x = q("[data-bctev]"))) { bctEv = x.dataset.bctev; return renderOnglet(); }
    if ((x = q("[data-onglet]")) && SEC) { history.replaceState(null, "", secHref(SEC.k, x.dataset.onglet)); return viewSec(SEC.k, x.dataset.onglet); }
    if ((x = q("[data-regard]"))) { regardFiltre = x.dataset.regard; return renderOnglet(); }
    if ((x = q("[data-bcv]"))) return bcVerseSheet(x.dataset.bcv);
    if (q("#veil")) return closeSheet();
    if (q("#gear")) return settingsSheet();
    if ((x = q("a.ref[data-r]"))) { ev.preventDefault(); return goRef(x.dataset.r); }
    if ((x = q("[data-test]"))) { O.test = x.dataset.test; saveO(); return viewHome(); }
    if ((x = q("[data-syncols]"))) { O.synCols = x.dataset.syncols === "1"; saveO(); return renderOnglet(); }
    if (q("[data-synregard]")) { O.synRegard = !O.synRegard; saveO(); return renderOnglet(); }
    if ((x = q("[data-psed]"))) { O.psEd = x.dataset.psed; saveO(); return viewHome(); }
    if (q("[data-plan]")) return ouvrirPlan();
    if (q("[data-plan-fermer]")) { $("#plancard").innerHTML = `<p class="plan-lien"><button data-plan>Plan de lecture proposé</button></p>`; return; }
    if ((x = q("[data-day]"))) { const d = new Date(planDay + "T12:00:00"); d.setDate(d.getDate() + +x.dataset.day); planDay = d.toISOString().slice(0, 10); return renderPlan(await plan()); }
    if ((x = q("[data-step]"))) { location.hash = `#/p/${P.spec}/${x.dataset.step}`; return; }
    if ((x = q("[data-lectio]"))) { const [b, c, v] = x.dataset.lectio.split(":"); location.hash = `#/p/${await pericopeSpec(b, +c, +v)}`; return; }
    if ((x = q("[data-intro]"))) { const g = await loadQ("data/gloss_JER.js", "__GLOSS").catch(() => ({})); return sheet(`<div class="lex">${g[x.dataset.intro] || "Introduction introuvable."}</div>`); }
    if ((x = q(".lw"))) return latSheet(x);
    if ((x = q(".w"))) return wordSheet(x);
    if ((x = q("[data-lex]"))) return lexSheet(x.dataset.lex);
    if ((x = q("sup.nn"))) {
      const k = x.dataset.n, part = P && P.parts.find(p => p.rows.some(r => r.bj && r.bj.n.some(n => n[0] === k)));
      const n = part && part.rows.flatMap(r => r.bj ? r.bj.n : []).find(n => n[0] === k);
      return sheet(`<p class="note"><b class="k">${esc(k)}</b>${n ? n[1] : "Note introuvable."}</p>`);
    }
    if ((x = q("[data-keep]"))) {
      const [part, r] = findRow(x.dataset.keep), e = entry(P.spec, P.label, true);
      const i = e.kept.findIndex(k => k.id === x.dataset.keep);
      if (i >= 0) e.kept.splice(i, 1);
      else e.kept.push({ id: x.dataset.keep, t: strip(r.bj ? r.bj.t : ""), ref: `${byCode[part.b].a} ${part.c},${r.bj ? r.bj.v : r.k}` });
      saveEntry(e);
      const vEl = x.closest(".v"); vEl.classList.toggle("kept", i < 0);
      x.classList.toggle("kept", i < 0); x.textContent = i < 0 ? "★ Retenu" : "☆ Retenir";
      return;
    }
    if ((x = q("[data-peres]"))) {
      const [part, r] = findRow(x.dataset.peres), n = rowNum(r);
      const secs = part.tae.filter(s => s.c1 <= part.c && s.c2 >= part.c && s.v1 <= n && n <= s.v2);
      const save = authorFilter; authorFilter = "";
      const h = peresHTML(secs, part.b); authorFilter = save;
      return sheet(`<h3>Les Pères — Chaîne d’or</h3>${h}`);
    }
    if ((x = q("[data-vnotes]"))) { const [, r] = findRow(x.dataset.vnotes); return sheet(r.bj.n.map(([k, t]) => `<p class="note"><b class="k">${esc(k)}</b>${t}</p>`).join("")); }
    if ((x = q("[data-art]"))) { const [c, ...t] = x.dataset.art.split("|"); return openArticle(c, t.join("|")); }
    if ((x = q("[data-dico]"))) { const [c, ...t] = x.dataset.dico.split("|"); return openArticle(c, t.join("|")); }
    if ((x = q("[data-df]"))) { dicoF = x.dataset.df; return viewDico(); }
    if ((x = q("[data-themes]"))) { const k = x.dataset.themes; return sheet(themesHTML(P, (part, r) => vkey(part, r) === k, "Ce verset dans les dictionnaires")); }
    if ((x = q("[data-author]"))) { authorFilter = x.dataset.author; renderMeditatio(P); return; }
    if ((x = q("[data-com]"))) { O.com = x.dataset.com; saveO(); if (/^#\/s\//.test(location.hash)) return renderOnglet(); return renderMeditatio(P); }
    if ((x = q("[data-hl]"))) { const c = $("#hl-" + x.dataset.hl); if (c && !HL_EN_COURS) { c.checked = !c.checked; hlResume(); } return; }
    if ((x = q("[data-hlpreset]"))) { if (HL_EN_COURS) return; const ids = x.dataset.hlpreset.split(","); document.querySelectorAll(".hl-case").forEach(c => c.checked = ids.includes(c.dataset.id)); return hlResume(); }
    if (q("#hl-lancer")) return hlAppliquer(false);
    if (q("#hl-maj")) return hlAppliquer(true);
    if ((x = q(".ex .more"))) { x.closest(".ex").classList.remove("short"); x.remove(); return; }
    if (q("#export")) return exportCarnet();
    if ((x = q("[data-opt]"))) {
      const k = x.dataset.opt, v = x.dataset.val;
      O[k] = v === "true" ? true : v === "false" ? false : v; saveO(); settingsSheet(); return rerender();
    }
    if ((x = q("[data-flag]"))) { O[x.dataset.flag] = !O[x.dataset.flag]; saveO(); return settingsSheet(); }
    if ((x = q("[data-fs]"))) { O.fs = Math.max(15, Math.min(30, O.fs + +x.dataset.fs)); saveO(); return; }
    if ((x = q(".v .txt"))) return toggleVerse(x.closest(".v"));
  });
  // ------------------------------------------------------------------ lecture hors connexion
  // Chacun choisit ses « paquets » (data/horsligne.js, construit par horsligne.py) : ils sont téléchargés dans le
  // cache du navigateur ; sw.js les ressert sans réseau et les rafraîchit quand le réseau revient.
  const HL_PAGES = "bible-pages-1", HL_DONNEES = "bible-donnees-1";
  const HL_OK = typeof caches !== "undefined" && "serviceWorker" in navigator && /^https?:$/.test(location.protocol);
  let HL = null, HL_EN_COURS = false;
  const hlEtat = () => ls.get("bible.horsligne", {});
  const mo = n => n >= 1048576 ? `${(n / 1048576).toFixed(n < 10485760 ? 1 : 0).replace(".", ",")} Mo` : `${Math.max(1, Math.round(n / 1024))} Ko`;
  const hlCle = chemin => { const u = new URL(chemin, location.href); return u.origin + u.pathname.replace(/\/index\.html$/, "/"); };
  const hlBoite = chemin => /^(data\/|\.\.\/donnees\/)/.test(chemin) ? HL_DONNEES : HL_PAGES;
  async function hlGarder(chemin, forcer) {
    const boite = await caches.open(hlBoite(chemin)), cle = hlCle(chemin);
    if (!forcer && await boite.match(cle)) return;
    const src = chemin.startsWith("data/") ? entrepot(chemin) : chemin;
    const r = await fetch(src, { mode: "cors", cache: forcer ? "no-cache" : "default" });
    if (!r.ok || r.redirected) throw new Error("HTTP " + r.status);
    await boite.put(cle, r);
  }
  async function hlParLots(liste, n, fn) {
    let i = 0, echecs = 0;
    await Promise.all(Array.from({ length: n }, async () => { while (i < liste.length) { const x = liste[i++]; try { await fn(x); } catch (e) { echecs++; } } }));
    return echecs;
  }
  async function hlOccupation() {
    try { const e = await navigator.storage.estimate(); return e && e.usage != null ? e.usage : null; } catch (e) { return null; }
  }

  async function viewHorsLigne() {
    setChrome("Hors connexion", "Bible, commentaires, Pères", "#/", false);
    if (!HL) HL = await loadQ("data/horsligne.js", "__HL").catch(() => null);
    if (!HL_OK || !HL) {
      $("#view").innerHTML = `<p class="missing">${!HL ? "La liste des textes à enregistrer est introuvable (lancez <code>python3 horsligne.py</code>)." : "Ce navigateur ne permet pas d’enregistrer les textes sur l’appareil. Ouvrez la Bible depuis son adresse internet (https://…), dans Safari ou Chrome."}</p>`;
      return;
    }
    const et = hlEtat();
    const quand = s => new Date(s).toLocaleDateString("fr-FR", { day: "numeric", month: "long" });
    let h = `<p class="hl-intro">Choisissez ce que vous voulez pouvoir lire <b>sans réseau</b>. Chaque paquet s’enregistre sur cet appareil ; il se met ensuite à jour tout seul, quand vous l’ouvrez avec du réseau.</p>`;
    h += `<div class="hl-presets"><span>Choix rapides :</span>` + [
      ["evangiles,bc,peres", "Lectio des Évangiles"],
      ["evangiles,nt,psaumes,at", "Toute la Bible"],
      ["evangiles,psaumes,bc,peres", "Évangiles et Psaumes, avec commentaires"],
      [HL.paquets.map(p => p.id).join(","), "Tout"],
    ].map(([ids, l]) => `<button class="chip" data-hlpreset="${ids}">${l} <small>${mo(HL.paquets.filter(p => ids.split(",").includes(p.id)).reduce((n, p) => n + p.taille, 0))}</small></button>`).join("") + `</div>`;
    h += `<div class="hl-liste">` + HL.paquets.map(p => {
      const e = et[p.id];
      const statut = e ? `<span class="hl-ok">✓ Enregistré le ${quand(e.quand)}${e.echecs ? ` (${e.echecs} fichier${e.echecs > 1 ? "s" : ""} manquant${e.echecs > 1 ? "s" : ""})` : ""}</span>` : `<span class="hl-non">Non enregistré</span>`;
      return `<label class="hl-paquet${e ? " garde" : ""}"><input type="checkbox" class="hl-case" id="hl-${p.id}" data-id="${p.id}"${e ? " checked" : ""}>
        <span class="hl-txt"><b>${esc(p.titre)}</b> <small class="hl-taille">${mo(p.taille)}</small><br><span class="hl-desc">${esc(p.desc)}</span><br>${statut}</span></label>`;
    }).join("") + `</div>`;
    h += `<p id="hl-resume" class="hl-resume"></p>
      <progress id="hl-progres" value="0" max="1" hidden></progress>
      <p id="hl-etat" class="missing" role="status"></p>
      <div class="hl-boutons"><button class="bouton-hl principal" id="hl-lancer">Enregistrer</button>` +
      (Object.keys(et).length ? `<button class="bouton-hl" id="hl-maj">Mettre à jour ce qui est enregistré</button>` : "") + `</div>
      <div class="hl-notes">
        <p><b>Sur iPhone ou iPad</b> : ajoutez d’abord la Bible à l’écran d’accueil (Partager › « Sur l’écran d’accueil ») et ouvrez-la de là. Sinon Safari efface ce qui est enregistré après quelques jours sans visite.</p>
        <p><b>Le bréviaire</b> s’enregistre à part : dans le bréviaire, Réglages › « Hors connexion » (les offices d’une semaine, d’un mois…). Les deux se complètent : le bréviaire pour prier l’office, la Bible pour la lectio.</p>
        <p>Décocher un paquet puis « Enregistrer » le retire de l’appareil et libère la place.</p>
      </div>`;
    $("#view").innerHTML = h;
    window.scrollTo(0, 0);
    document.querySelectorAll(".hl-case").forEach(c => c.addEventListener("change", hlResume));
    hlResume();
    const occ = await hlOccupation();
    if (occ != null && $("#hl-etat")) $("#hl-etat").textContent = `Place occupée sur cet appareil par la Bible et le bréviaire : ${mo(occ)}.`;
  }
  // ce que le bouton va faire, en clair
  function hlResume() {
    const et = hlEtat(), el = $("#hl-resume"); if (!el || !HL) return;
    let plus = 0, moins = 0;
    document.querySelectorAll(".hl-case").forEach(c => {
      const p = HL.paquets.find(x => x.id === c.dataset.id);
      if (c.checked && !et[p.id]) plus += p.taille;
      if (!c.checked && et[p.id]) moins += p.taille;
      c.closest(".hl-paquet").classList.toggle("choisi", c.checked);
    });
    el.textContent = !plus && !moins ? "Rien à changer pour l’instant : cochez ou décochez des paquets." :
      [plus ? `${mo(plus)} à télécharger` : "", moins ? `${mo(moins)} à retirer de l’appareil` : ""].filter(Boolean).join(" ; ") + ".";
    $("#hl-lancer").disabled = !plus && !moins;
  }
  async function hlAppliquer(maj) {
    if (HL_EN_COURS || !HL) return;
    HL_EN_COURS = true;
    const et = hlEtat(), voulus = new Set([...document.querySelectorAll(".hl-case")].filter(c => c.checked).map(c => c.dataset.id));
    const prog = $("#hl-progres"), txt = $("#hl-etat");
    document.querySelectorAll(".hl-boutons button").forEach(b => b.disabled = true);
    try { if (navigator.storage?.persist) await navigator.storage.persist(); } catch (e) { /* rien */ }
    try {
      // retirer ce qui est décoché
      for (const p of HL.paquets) if (!voulus.has(p.id) && et[p.id]) {
        txt.textContent = `Retrait : ${p.titre}…`;
        const boite = await caches.open(HL_DONNEES);
        await Promise.all(p.fichiers.map(f => boite.delete(hlCle(f))));
        delete et[p.id]; ls.set("bible.horsligne", et);
      }
      // télécharger ce qui est coché (tout, pour une mise à jour)
      const a_faire = HL.paquets.filter(p => voulus.has(p.id) && (maj || !et[p.id]));
      if (a_faire.length) {
        txt.textContent = "Préparation…";
        await hlParLots(HL.socle, 4, f => hlGarder(f, maj));
        const total = a_faire.reduce((n, p) => n + p.n, 0);
        let fait = 0;
        prog.hidden = false; prog.max = total; prog.value = 0;
        for (const p of a_faire) {
          const echecs = await hlParLots(p.fichiers, 8, async f => {
            try { await hlGarder(f, maj); } finally { prog.value = ++fait; txt.textContent = `${p.titre} : ${fait} / ${total} fichiers…`; }
          });
          et[p.id] = { quand: new Date().toISOString(), echecs };
          ls.set("bible.horsligne", et);
        }
      }
      const manques = Object.values(et).reduce((n, e) => n + (e.echecs || 0), 0);
      HL_EN_COURS = false;
      await viewHorsLigne();
      const occ = await hlOccupation();
      $("#hl-etat").textContent = (manques ? `Terminé, mais ${manques} fichier(s) n’ont pas pu être enregistrés : relancez avec une bonne connexion. ` : "C’est enregistré. ") +
        (occ != null ? `Place occupée sur cet appareil : ${mo(occ)}.` : "");
    } catch (e) {
      HL_EN_COURS = false;
      txt.textContent = `Interrompu : ${e.message}. Relancez avec une bonne connexion ; ce qui est déjà enregistré est gardé.`;
      document.querySelectorAll(".hl-boutons button").forEach(b => b.disabled = false);
    }
  }

  function rerender() {
    const m = decodeURIComponent(location.hash.slice(1)).split("/").filter(Boolean);
    if (m[0] === "p" && P) { const step = m[2] || "lectio"; if (step === "lectio") { const y = window.scrollY; renderLectio(P); window.scrollTo(0, y); } }
  }
  // glisser la feuille vers le bas pour la fermer
  let y0 = null;
  $("#sheet").addEventListener("touchstart", e => { y0 = $("#sheet").scrollTop <= 0 ? e.touches[0].clientY : null; }, { passive: true });
  $("#sheet").addEventListener("touchend", e => { if (y0 !== null && e.changedTouches[0].clientY - y0 > 80) closeSheet(); y0 = null; });
  document.addEventListener("keydown", e => { if (e.key === "Escape") closeSheet(); });

  // ce dont la page Recherche (recherche.js) a besoin
  window.BibleApp = { $, esc, loadQ, setChrome, byCode, BOOKS, ls, openArticle, lexSheet };
  window.addEventListener("hashchange", route);
  // passage vers le bréviaire (adresse dans liens.js)
  const brev = (window.LIENS || {}).breviaire;
  if (brev) { const a = $("#vers-breviaire"); a.href = brev; a.hidden = false; }
  applyOpts();
  // service worker de la Bible (sw.js) : lecture hors connexion des paquets enregistrés
  if ("serviceWorker" in navigator && /^https?:$/.test(location.protocol)) navigator.serviceWorker.register("sw.js").catch(() => { });
  if (!BOOKS.length) { $("#view").innerHTML = `<p class="missing">Données absentes : lancez <code>python3 extract.py</code> sur l’ordinateur.</p>`; return; }
  route();
})();
