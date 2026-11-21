/* Interlinéaire BJ (vue ordinateur, interlineaire.html) — lecteur des données extraites de Biblia Universalis 3.

   Place dans l'ensemble : partie « Bible » du site, servie sous /bible/. Ne calcule rien sur un serveur :
   lit les fichiers bible/data/*.js (fabriqués sur le Mac par bible/extract.py, dicos.py, peres.py, latin.py),
   en local depuis le disque, en ligne depuis l'entrepôt Azure privé (<meta name="fichiers"> + clé
   window.CLE_FICHIERS, voir site/js/cle-fichiers.js). La vue téléphone est lectio.js. */
(() => {
  "use strict";
  const BOOKS = window.__BOOKS || [];
  const byCode = Object.fromEntries(BOOKS.map(b => [b.c, b]));
  const $ = s => document.querySelector(s);
  const esc = s => String(s ?? "").replace(/[&<>"]/g, c => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));

  // ------------------------------------------------------------------ options persistantes
  const DEF = { gloss: "lit", tr: true, st: false, mo: true, modeAT: "orig", modeNT: "orig", vulg: "NVU", notes: "popup", bj: true, il: true, fs: 17, theme: "" };
  let O = { ...DEF };
  try { O = { ...DEF, ...JSON.parse(localStorage.getItem("interlin.opts") || "{}") }; } catch (e) { }
  const save = () => { try { localStorage.setItem("interlin.opts", JSON.stringify(O)); } catch (e) { } };

  let cur = { b: "GEN", c: 1, v: null }, CH = null;

  // ------------------------------------------------------------------ chargement des données (balises <script>, compatible file://)
  const cache = new Map();
  // en ligne, les données sont dans l'entrepôt Azure (<meta name="fichiers">, posé à la publication) ; en local, ici
  const FICHIERS = document.querySelector('meta[name="fichiers"]')?.content || "";
  // l'entrepôt est privé : chaque adresse porte la clé d'accès (<meta name="fichiers-cle">, posée à la publication)
  // clé courte délivrée après la connexion (js/cle-fichiers.js → window.CLE_FICHIERS) ; sinon celle écrite dans la page
  const CLE_PAGE = (typeof document !== "undefined" && document.querySelector('meta[name="fichiers-cle"]')?.content) || "";
  const cleEnt = () => (typeof window !== "undefined" && window.CLE_FICHIERS) || CLE_PAGE;
  const entrepot = (chemin) => { const k = cleEnt(); return FICHIERS + chemin + (FICHIERS && k ? (chemin.includes("?") ? "&" : "?") + k : ""); };
  function loadScript(src, varName) {
    if (cache.has(src)) return Promise.resolve(cache.get(src));
    return new Promise((res, rej) => {
      window[varName] = undefined;
      const s = document.createElement("script");
      s.src = entrepot(src);
      s.onload = () => { const d = window[varName]; cache.set(src, d); s.remove(); res(d); };
      s.onerror = () => { s.remove(); rej(new Error("introuvable : " + src)); };
      document.head.appendChild(s);
    });
  }
  const pad = n => String(n).padStart(3, "0");
  let MOTS = null;
  const chapterFile = (b, c) => `data/${b}/${pad(c)}.js`;

  // ------------------------------------------------------------------ barre d'outils
  function fillBooks() {
    const sel = $("#book");
    sel.innerHTML = ["AT", "NT"].map(t =>
      `<optgroup label="${t === "AT" ? "Ancien Testament" : "Nouveau Testament"}">` +
      BOOKS.filter(b => b.t === t).map(b => `<option value="${b.c}">${esc(b.n)}</option>`).join("") +
      "</optgroup>").join("");
  }
  function fillChaps(b) {
    $("#chap").innerHTML = byCode[b].ch.map(c => `<option value="${c}">${c}</option>`).join("");
  }
  function applyOpts() {
    const B = document.body.classList;
    ["lit", "lsg", "both", "none"].forEach(g => B.toggle("gloss-" + g, O.gloss === g));
    B.toggle("hide-tr", !O.tr); B.toggle("hide-st", !O.st); B.toggle("hide-mo", !O.mo);
    ["popup", "inline", "none"].forEach(n => B.toggle("notes-" + n, O.notes === n));
    B.toggle("no-bj", !O.bj); B.toggle("no-il", !O.il);
    document.querySelectorAll("#opt-gloss button").forEach(b => b.classList.toggle("on", b.dataset.v === O.gloss));
    $("#opt-tr").classList.toggle("on", O.tr); $("#opt-st").classList.toggle("on", O.st); $("#opt-mo").classList.toggle("on", O.mo);
    $("#opt-bj").classList.toggle("on", O.bj); $("#opt-il").classList.toggle("on", O.il);
    $("#opt-notes").value = O.notes;
    $("#opt-lat").value = O.vulg;
    $("#opt-mode").value = isNT() ? O.modeNT : O.modeAT;
    $("#opt-mode").options[0].textContent = isNT() ? "Grec" : "Hébreu";
    document.documentElement.style.setProperty("--fs", O.fs + "px");
    if (O.theme) document.documentElement.dataset.theme = O.theme; else delete document.documentElement.dataset.theme;
    const nt = byCode[cur.b] && byCode[cur.b].t === "NT";
    $("#opt-tr").textContent = nt ? "Lemme" : "Translit.";
  }
  const isNT = () => byCode[cur.b].t === "NT";
  const mode = () => (isNT() ? O.modeNT : O.modeAT);
  const latKey = () => (mode() !== "orig" ? O.vulg : "");

  function bindToolbar() {
    $("#book").onchange = e => go(e.target.value, 1);
    $("#chap").onchange = e => go(cur.b, +e.target.value);
    $("#prev").onclick = () => step(-1);
    $("#next").onclick = () => step(1);
    document.querySelectorAll("#opt-gloss button").forEach(b => b.onclick = () => { O.gloss = b.dataset.v; save(); applyOpts(); });
    const tog = (id, k) => $(id).onclick = () => { O[k] = !O[k]; save(); applyOpts(); };
    tog("#opt-tr", "tr"); tog("#opt-st", "st"); tog("#opt-mo", "mo"); tog("#opt-bj", "bj"); tog("#opt-il", "il");
    $("#opt-notes").onchange = e => { O.notes = e.target.value; save(); applyOpts(); };
    $("#opt-lat").onchange = e => { O.vulg = e.target.value; save(); render(); };
    $("#opt-mode").onchange = e => { O[isNT() ? "modeNT" : "modeAT"] = e.target.value; save(); render(); };
    $("#smaller").onclick = () => { O.fs = Math.max(12, O.fs - 1); save(); applyOpts(); };
    $("#bigger").onclick = () => { O.fs = Math.min(28, O.fs + 1); save(); applyOpts(); };
    $("#theme").onclick = () => {
      const dark = O.theme ? O.theme === "dark" : matchMedia("(prefers-color-scheme: dark)").matches;
      O.theme = dark ? "light" : "dark"; save(); applyOpts();
    };
    document.addEventListener("keydown", e => {
      if (e.target.matches("select, input")) return;
      if (e.key === "ArrowLeft") step(-1);
      else if (e.key === "ArrowRight") step(1);
      else if (e.key === "Escape") { hidePop(); hideModal(); }
    });
    window.addEventListener("hashchange", fromHash);
  }
  function step(d) {
    const bi = BOOKS.findIndex(b => b.c === cur.b), chs = BOOKS[bi].ch, i = chs.indexOf(cur.c) + d;
    if (i >= 0 && i < chs.length) return go(cur.b, chs[i]);
    const nb = BOOKS[bi + d];
    if (nb) go(nb.c, d > 0 ? nb.ch[0] : nb.ch[nb.ch.length - 1]);
  }

  // ------------------------------------------------------------------ navigation
  function go(b, c, v) {
    const h = `#${b}/${c}` + (v ? `/${v}` : "");
    if (location.hash !== h) location.hash = h; else fromHash();
  }
  function fromHash() {
    const m = decodeURIComponent(location.hash.slice(1)).split("/");
    let b = (m[0] || "").toUpperCase(), c = parseInt(m[1], 10) || 1, v = m[2] || null;
    if (!byCode[b]) b = "GEN";
    if (!byCode[b].ch.includes(c)) c = byCode[b].ch[0];
    show(b, c, v);
  }
  async function show(b, c, v) {
    hidePop();
    const changed = b !== cur.b || c !== cur.c || !CH;
    cur = { b, c, v };
    $("#book").value = b; fillChaps(b); $("#chap").value = c;
    applyOpts();
    if (changed) {
      try {
        MOTS = MOTS || await loadScript("data/mots.js", "__MOTS");
        CH = await loadScript(chapterFile(b, c), "__CH");
        // les mots de l'interlinéaire arrivent allégés (voir compacter() dans extract.py)
        for (const ws of Object.values(CH.il || {})) for (const w of ws) {
          if (w.d === undefined) w.d = (w.s && MOTS.d[w.s]) || "";
          if (w.ml === undefined) w.ml = (w.m && MOTS.ml[w.m]) || "";
          for (const k of ["w", "l", "s", "g", "m", "sg", "tr", "seg"]) if (w[k] === undefined) w[k] = "";
          if (!w.nt) w.nt = [];
        }
      }
      catch (e) { $("#main").innerHTML = `<p class="missing">${esc(e.message)} — lancez d'abord <code>python3 extract.py</code>.</p>`; return; }
      render();
      // précharge le chapitre suivant
      const chs = byCode[b].ch, i = chs.indexOf(c);
      if (i + 1 < chs.length) loadScript(chapterFile(b, chs[i + 1]), "__CH").catch(() => { });
    }
    if (v) {
      const el = document.getElementById("v" + v);
      document.querySelectorAll(".row.target").forEach(r => r.classList.remove("target"));
      if (el) { el.classList.add("target"); el.scrollIntoView({ block: "center" }); }
    } else if (changed) window.scrollTo(0, 0);
    document.title = `${byCode[b].a} ${c} — Interlinéaire BJ`;
  }

  // ------------------------------------------------------------------ alignement BJ / interlinéaire
  const num = v => parseInt(v, 10);
  function buildRows(ch) {
    const src = ch.il || ch.gr || {};
    const used = new Set(), rows = [], bjIds = new Set(ch.bj.map(v => v.v));
    for (const v of ch.bj) {
      let k = null;
      if (v.g || v.x) { rows.push({ bj: v, k: null }); continue; } // grec seul (Dn 3,24-90) / sans original (prologue de Si)
      if (src[v.v] !== undefined && !used.has(v.v)) k = v.v;
      else {
        // « 5a » BJ -> verset 5 de l'original, sauf si la BJ a aussi un verset « 5 » (ex. Est 1,1a-r = additions grecques)
        const base = String(num(v.v));
        if (!bjIds.has(base) && src[base] !== undefined && !used.has(base)) k = base;
      }
      if (k !== null) used.add(k);
      rows.push({ bj: v, k });
    }
    // versets présents seulement dans l'original : insérés après le verset BJ le plus proche
    for (const k of Object.keys(src)) {
      if (used.has(k)) continue;
      let at = rows.length;
      for (let i = rows.length - 1; i >= 0; i--) { const r = rows[i]; const n = num(r.bj ? r.bj.v : r.k); if (n <= num(k)) { at = i + 1; break; } if (i === 0) at = 0; }
      rows.splice(at, 0, { bj: null, k });
    }
    return rows;
  }

  // ------------------------------------------------------------------ rendu
  let NOTES = {}, WORDS = [];
  function render() {
    const ch = CH, book = byCode[ch.b], nt = book.t === "NT", lat = latKey();
    NOTES = {}; WORDS = [];
    for (const v of ch.bj) for (const [k, t] of v.n) NOTES[k] = t;
    const srcLabel = ch.src === "ATI" ? "Hébreu — AT interlinéaire" : ch.src === "NTI" ? "Grec — NT interlinéaire" : "Grec — Septante (pas d'original hébreu)";
    let h = `<div class="chap-title">${esc(book.n)} ${ch.c}` +
      (ch.intro ? ch.intro.map(i => ` <button class="intro-link" data-intro="${esc(i)}">Introduction BJ : ${esc(i)}</button>`).join("") : "") + `</div>`;
    h += `<div class="colheads ${nt ? "nt" : ""}"><div class="bj">Bible de Jérusalem</div><div class="il">${mode() === "lat" ? "Latin" : srcLabel}${lat ? " · " + (lat === "NVU" ? "Nova Vulgata" : "Vulgate Clémentine") : ""}</div></div>`;
    for (const r of buildRows(ch)) {
      const v = r.bj;
      if (v && v.h) h += `<div class="heads">${v.h.map(([l, t]) => `<div class="h${l}">${t}</div>`).join("")}</div>`;
      const id = v ? v.v : r.k;
      h += `<div class="row" id="v${esc(v && v.id || id)}">`;
      // colonne BJ
      if (v) {
        const notes = v.n.length ? `<div class="inline-notes">${v.n.map(([k, t]) => `<p><b class="k">${esc(k)}</b> ${t}</p>`).join("")}</div>` : "";
        h += `<div class="bj"><span class="vn" data-v="${esc(v.v)}">${esc(v.v)}</span>${v.t}${notes}</div>`;
      } else h += `<div class="bj"><span class="missing">(${esc(r.k)} : pas de verset correspondant dans la BJ)</span></div>`;
      // colonne interlinéaire
      h += `<div class="il">`;
      const k = r.k;
      if (mode() === "lat") { /* latin seul */ }
      else if (v && v.x) h += `<div class="missing">${esc(v.x)} — pas de texte original.</div>`;
      else if (ch.il && k !== null && ch.il[k]) h += words(ch.il[k], ch.src, k);
      else {
        const g = ch.gr && (ch.gr[id] ?? (k !== null ? ch.gr[k] : undefined));
        const base = String(num(id));
        if (g) h += `<div class="lxx"><span class="lbl">LXX ${esc(id)}</span>${esc(g)}</div>`;
        else if (v && base !== id && ch.il && ch.il[base]) h += `<div class="missing">Demi-verset de la BJ : l'original est donné en entier au v. ${esc(base)}.</div>`;
        else h += `<div class="missing">Pas de texte original pour ce verset.</div>`;
      }
      if (lat && !(v && v.x)) {
        const lt = ch.lat[lat] && (ch.lat[lat][id] ?? (k !== null ? ch.lat[lat][k] : undefined) ?? ch.lat[lat][String(num(id))]);
        if (lt) h += `<div class="lat"><span class="lbl">${lat === "NVU" ? "Nova Vulgata" : "Clementina"}</span>${latMots(lt)}</div>`;
      }
      h += `</div></div>`;
    }
    $("#main").innerHTML = h;
  }

  function words(ws, src, v) {
    const heb = src === "ATI";
    let h = `<div class="words ${heb ? "rtl" : ""}"><span class="ilvn">${esc(v)}</span>`;
    for (const w of ws) {
      const i = WORDS.push(w) - 1;
      h += `<span class="w" data-i="${i}" data-s="${esc(w.s)}">` +
        `<span class="st">${esc(w.s ? w.s.slice(1) : "")}</span>` +
        `<span class="tr">${esc(heb ? w.tr : w.l)}</span>` +
        `<span class="orig ${heb ? "heb" : "grk"}">${esc(w.w)}</span>` +
        `<span class="gl">${esc(w.g)}</span>` +
        `<span class="sg">${esc(w.sg)}</span>` +
        `<span class="mo">${esc(w.m)}</span></span>`;
    }
    return h + `</div>`;
  }

  // ------------------------------------------------------------------ fiches (mot, note BJ)
  const pop = $("#pop");
  function showPop(anchor, html) {
    pop.innerHTML = `<button class="x" title="Fermer">×</button>` + html;
    pop.style.display = "block";
    const r = anchor.getBoundingClientRect(), pw = pop.offsetWidth, ph = pop.offsetHeight;
    let x = r.left + window.scrollX + r.width / 2 - pw / 2;
    x = Math.max(window.scrollX + 8, Math.min(x, window.scrollX + document.documentElement.clientWidth - pw - 8));
    let y = r.bottom + window.scrollY + 6;
    if (r.bottom + ph + 12 > window.innerHeight && r.top > ph + 12) y = r.top + window.scrollY - ph - 6;
    pop.style.left = x + "px"; pop.style.top = y + "px";
  }
  function clearSel() { document.querySelectorAll(".w.sel, .lw.sel").forEach(x => x.classList.remove("sel")); }
  function hidePop() { pop.style.display = "none"; highlight(null); clearSel(); }
  let hlStyle = null;
  function highlight(s) {
    if (!hlStyle) { hlStyle = document.createElement("style"); document.head.appendChild(hlStyle); }
    hlStyle.textContent = s ? `.w[data-s="${s}"]{background:var(--hl)}` : "";
  }

  // latin : chaque mot devient cliquable (fiche faite à partir de Collatinus, voir latin.py)
  const latMots = t => String(t).split(/([A-Za-zÀ-ÿæœÆŒ]+)/).map((x, i) => i % 2 ? `<span class="lw">${esc(x)}</span>` : esc(x)).join("");
  const cleLat = w => w.toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/æ/g, "ae").replace(/œ/g, "oe");
  async function latCard(el) {
    const mot = el.textContent, k = cleLat(mot);
    const [L, F] = await Promise.all([loadScript("data/latin/lemmes.js", "__LEM").catch(() => []), loadScript(`data/latin/${k[0]}.js`, "__LAT").catch(() => ({}))]);
    const an = F[k] || [];
    let h = `<div class="big" style="font-style:italic">${esc(mot)}</div>`;
    if (!an.length) h += `<p><i>Mot non reconnu (souvent un nom propre).</i></p>`;
    else h += `<dl>` + an.map(([n, m]) => { const [, gr, sens] = L[n] || ["", "?", ""];
      return `<dt style="text-transform:none;color:var(--gloss);font-weight:600">${esc(gr)}</dt><dd>${sens ? esc(sens) : "<i>sens non donné</i>"}${m ? `<br><small style="color:var(--muted)">${esc(m)}</small>` : ""}</dd>`; }).join("") + `</dl>`;
    const lem = an.length ? (L[an[0][0]] || [])[1] || mot : mot;
    h += `<p><small style="color:var(--muted)">Analyses proposées par Collatinus ; le contexte décide.</small><br><a href="https://gaffiot.fr/#${encodeURIComponent(lem.replace(/\d+$/, ""))}" target="_blank" rel="noopener">Gaffiot (en ligne) ›</a></p>`;
    clearSel(); el.classList.add("sel");
    showPop(el, h);
  }
  function wordCard(el) {
    const w = WORDS[+el.dataset.i], heb = CH.src === "ATI";
    const occ = w.s ? document.querySelectorAll(`.w[data-s="${w.s}"]`).length : 0;
    highlight(w.s);
    clearSel(); el.classList.add("sel");
    const notes = (w.nt || []).map(([mod, name, lbl]) => `<a class="ref" data-gloss="${esc(name)}">${esc(lbl.replace("►", ""))} — ${esc(name)}</a>`).join("<br>");
    const rows = [
      heb && w.seg && w.seg !== w.w ? ["Segmenté", `<span style="font-family:var(--heb);font-size:1.3em" dir="rtl">${esc(w.seg)}</span>`] : null,
      heb ? ["Translit.", `<i>${esc(w.tr)}</i>`] : ["Lemme", `<span style="font-family:var(--grk);font-size:1.15em">${esc(w.l)}</span>`],
      w.s ? ["Strong", `<b>${esc(w.s)}</b> — ${esc(w.d)}<br><button class="lexbtn" data-lex="${esc(w.s)}">Lexique complet et concordance</button>`] : null,
      ["Analyse", `<b>${esc(w.m)}</b>${w.ml ? " — " + esc(w.ml) : ""}`],
      ["Littérale", `<span style="color:var(--gloss)">${esc(w.g)}</span>`],
      ["Segond", `<span style="color:var(--lsg)">${esc(w.sg || "—")}</span>`],
      w.s ? ["Chapitre", `${occ} occurrence${occ > 1 ? "s" : ""} (surlignées)`] : null,
      notes ? ["Notes ATI", notes] : null,
    ].filter(Boolean);
    showPop(el, `<div class="big ${heb ? "heb" : "grk"}">${esc(w.w)}</div><dl>${rows.map(([a, b]) => `<dt>${a}</dt><dd>${b}</dd>`).join("")}</dl>`);
  }

  // références BJ : "GEN2.4-25", "PSA92.11;133.2", "1SA22.23", "MAT1.1-17"
  function followRef(r) {
    const m = /^([1-3]?[A-Z]{2,3})(\d+)(?:\.(\d+))?/.exec(r);
    if (!m || !byCode[m[1]]) return;
    hidePop(); go(m[1], +m[2], m[3]);
  }

  async function openGloss(file, name) {
    const g = await loadScript(file, "__GLOSS").catch(() => ({}));
    $("#modal .content").innerHTML = g[name] || `<p class="missing">Entrée « ${esc(name)} » introuvable.</p>`;
    $("#modal").style.display = "flex"; $("#modal .box").scrollTop = 0;
  }
  function hideModal() { $("#modal").style.display = "none"; }

  // ------------------------------------------------------------------ lexique Strong + concordance
  async function openLex(s) {
    const n = parseInt(s.slice(1), 10), bucket = s[0] + Math.floor(n / 100);
    const [lex, conc] = await Promise.all([
      loadScript(`data/lex/${bucket}.js`, "__LEX").catch(() => ({})),
      loadScript(`data/conc/${bucket}.js`, "__CONC").catch(() => ({})),
    ]);
    const art = lex[s] || Object.entries(lex).find(([k]) => k.startsWith(s) && !/\d/.test(k.slice(s.length)))?.[1];
    let h = `<div class="lex">${art || `<p class="missing">Pas d'article pour ${esc(s)}.</p>`}</div>`;
    const occ = conc[s] || [];
    if (occ.length) {
      // regroupe par livre, dans l'ordre canonique
      const groups = new Map();
      for (const [ref, g] of occ) {
        const m = /^([1-3]?[A-Z]{2,3})(\d+)\.(.+)$/.exec(ref);
        if (!m) continue;
        if (!groups.has(m[1])) groups.set(m[1], []);
        groups.get(m[1]).push(`<a class="ref" data-r="${esc(ref)}" title="${esc(g)}">${m[2]},${esc(m[3])}</a>`);
      }
      h += `<h2 class="conc-h">Concordance — ${occ.length} verset${occ.length > 1 ? "s" : ""}</h2><div class="conc">` +
        [...groups].map(([b, refs]) => `<p><b>${esc(byCode[b] ? byCode[b].a : b)}</b> (${refs.length}) ${refs.join(" · ")}</p>`).join("") + `</div>`;
    }
    hidePop();
    $("#modal .content").innerHTML = h;
    $("#modal").style.display = "flex"; $("#modal .box").scrollTop = 0;
  }

  document.addEventListener("click", e => {
    const t = e.target;
    if (t.closest("#pop .x") || t.closest("#modal .x") || t.id === "modal") { hidePop(); hideModal(); return; }
    const ref = t.closest("a.ref[data-r]"); if (ref) { hideModal(); followRef(ref.dataset.r); return; }
    const lx = t.closest("[data-lex]"); if (lx) { openLex(lx.dataset.lex); return; }
    const gl = t.closest("a.ref[data-gloss]"); if (gl) { openGloss("data/gloss_ATI.js", gl.dataset.gloss); return; }
    const intro = t.closest("[data-intro]"); if (intro) { openGloss("data/gloss_JER.js", intro.dataset.intro); return; }
    const lw = t.closest(".lw"); if (lw) { latCard(lw); return; }
    const w = t.closest(".w"); if (w) { wordCard(w); return; }
    const nn = t.closest("sup.nn"); if (nn && O.notes !== "none") {
      const k = nn.dataset.n;
      highlight(null);
      showPop(nn, `<div><span class="note-k">${esc(k)}</span>${NOTES[k] || "<i>note introuvable</i>"}</div>`);
      return;
    }
    const vn = t.closest(".vn"); if (vn) { history.replaceState(null, "", `#${cur.b}/${cur.c}/${vn.dataset.v}`); return; }
    if (!t.closest("#pop") && !t.closest("header")) hidePop();
  });

  // ------------------------------------------------------------------ démarrage
  if (!BOOKS.length) { $("#main").innerHTML = `<p class="missing">Données absentes : lancez <code>python3 extract.py</code> dans ce dossier.</p>`; return; }
  fillBooks(); bindToolbar();
  if (!location.hash) location.replace("#GEN/1");
  fromHash();
})();
