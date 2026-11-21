/* Recherche dans la Bible (onglet « Recherche », adresse #/r/<requête>/<portée>).

   Index préparés sur l'ordinateur par recherche.py (data/rech/), lus à la demande : rien n'est envoyé à un serveur.
   Ce qu'on peut taper :
     amour fidélité        les versets qui contiennent les deux mots (et leurs formes : amours, fidélités…)
     "royaume des cieux"   l'expression exacte
     pardon -offense       « pardon » mais pas « offense »
     berger*               tout mot commençant par « berger »
     Jn 3,16  ·  1 Co 13   une référence : on y va directement
     ἀγάπη  ·  חֶסֶד  ·  G26   un mot grec ou hébreu, un numéro Strong : concordance
   Portées : Bible (texte et titres de la BJ), Notes de la BJ, Vulgate (avec toutes les formes d'un mot latin),
   Pères (Chaîne d'or), Dictionnaires, Bible chrétienne (commentaire).
   La découpe des mots (mots()) doit rester la même que dans recherche.py. */
(() => {
  "use strict";
  const A = () => window.BibleApp;
  const PORTEES = [
    ["bj", "Bible", "Texte et titres de la Bible de Jérusalem"],
    ["notes", "Notes BJ", "Notes de la Bible de Jérusalem"],
    ["lat", "Vulgate", "Nova Vulgata (toutes les formes d'un mot latin)"],
    ["peres", "Pères", "Chaîne d'or de saint Thomas (évangiles)"],
    ["dico", "Dictionnaires", "Les huit dictionnaires, titres et articles"],
    ["bc", "Bible chrétienne", "Commentaire de la Bible chrétienne (évangiles)"],
  ];
  const PAGE = 40;

  // ------------------------------------------------------------------ mots (comme recherche.py)
  const norm = s => String(s).toLowerCase().normalize("NFD").replace(/[̀-ͯ]/g, "").replace(/æ/g, "ae").replace(/œ/g, "oe");
  const mots = s => norm(s).match(/[a-z0-9]+/g) || [];
  const uv = s => s.replace(/v/g, "u").replace(/j/g, "i");

  // ------------------------------------------------------------------ chargement des index
  const charge = (src, v) => A().loadQ(src, v);
  const docsCache = {};
  async function docs(p) {
    if (docsCache[p]) return docsCache[p];
    const d = await charge(`data/rech/${p}/docs.js`, "__RD");
    let out = d;
    if (d && d.chapitres) { out = []; for (const [b, c, vs] of d.chapitres) for (const v of vs) out.push([b, c, v]); }
    else if (p === "peres") out = d.d.map(x => [x[0], x[1], x[2], x[3], x[4], d.auteurs[x[5]], d.sources[x[6]]]);
    else if (p === "bc") out = d.d.map(x => [...d.sections[x[0]], x[1]]);
    return (docsCache[p] = out);
  }
  const fichier = m => (m.length > 1 ? m.slice(0, 2) : m + "_").replace("@", "_").replace("#", "~");
  const part = (p, m) => charge(`data/rech/${p}/i/${fichier(m)}.js`, "__RI").catch(() => ({}));
  const decode = l => { const out = new Array(l.length); let x = 0; for (let i = 0; i < l.length; i++) out[i] = (x += l[i]); return out; };
  const textes = (p, g) => charge(`data/rech/${p}/t/${g}.js`, "__RT").catch(() => ({}));

  // ------------------------------------------------------------------ la requête
  function analyser(q) {
    const termes = [], exclus = [], phrases = [];
    String(q).replace(/"([^"]+)"|(\S+)/g, (x, ph, w) => {
      if (ph) { const ms = mots(ph); if (ms.length) { phrases.push(ms); ms.forEach(m => termes.push({ m, exact: true })); } return ""; }
      const neg = w.startsWith("-") && w.length > 1, etoile = /\*$/.test(w);
      for (const m of mots(w)) (neg ? exclus : termes).push({ m, prefixe: etoile || (!neg && m.length >= 4), exact: false });
      return "";
    });
    return { termes, exclus, phrases };
  }
  // un mot du texte correspond-il au terme ? (même règle partout : index, surlignage)
  const correspond = (t, mot) => t.prefixe ? mot.startsWith(t.m) : (mot === t.m || (!t.exact && (mot === t.m + "s" || mot === t.m + "x")));

  async function documentsDe(p, t) {
    const res = new Set();
    const idx = await part(p, t.m);
    for (const [mot, l] of Object.entries(idx)) if (correspond(t, mot)) for (const x of decode(l)) res.add(x);
    if (p === "lat" && !t.exact) {          // toutes les formes du lemme latin (Collatinus)
      const k = "@" + uv(t.m), lm = await part(p, k);
      if (lm[k]) for (const x of decode(lm[k])) res.add(x);
    }
    return res;
  }
  async function chercher(p, a) {
    if (!a.termes.length) return [];
    const sets = await Promise.all(a.termes.map(t => documentsDe(p, t)));
    sets.sort((x, y) => x.size - y.size);
    let r = [...sets[0]].filter(x => sets.every(s => s.has(x)));
    if (a.exclus.length) {
      const ex = await Promise.all(a.exclus.map(t => documentsDe(p, { ...t, prefixe: false })));
      r = r.filter(x => !ex.some(s => s.has(x)));
    }
    r.sort((x, y) => x - y);
    if (p === "dico" && r.length) {        // les articles dont le titre contient les mots d'abord
      const titres = await Promise.all(a.termes.map(async t => { const k = "#" + t.m, i = await part(p, k); return new Set(Object.entries(i).filter(([m]) => m.startsWith("#") && correspond(t, m.slice(1))).flatMap(([, l]) => decode(l))); }));
      const enTitre = x => titres.every(s => s.has(x));
      r.sort((x, y) => enTitre(y) - enTitre(x) || x - y);
    }
    return r;
  }
  // vérifier les expressions entre guillemets sur le texte (quand on l'a)
  async function verifierPhrases(p, a, ids, D) {
    if (!a.phrases.length || p === "dico") return ids;
    const groupes = new Set(ids.map(i => groupe(p, D[i], i)));
    if (groupes.size > 30) return ids;
    const T = {};
    await Promise.all([...groupes].map(async g => Object.assign(T, await textes(p, g))));
    return ids.filter(i => { const ms = mots(T[i] || "").join(" "); return a.phrases.every(ph => (" " + ms + " ").includes(" " + ph.join(" ") + " ")); });
  }
  const B = i => A().BOOKS[i] || {};
  function groupe(p, d) {
    if (p === "peres") return `${B(d[0]).c}${d[1]}`;
    if (p === "bc") return d[0];
    return B(d[0]).c;
  }

  // ------------------------------------------------------------------ références : « Jn 3,16 », « 1 Co 13 », « Psaume 23 »
  let NOMS = null;
  function livreDe(s) {
    if (!NOMS) {
      NOMS = [];
      for (const b of A().BOOKS) {
        NOMS.push([norm(b.a).replace(/[\s.]/g, ""), b.c]);
        NOMS.push([norm(b.n).replace(/[\s'’.-]/g, ""), b.c]);
      }
      NOMS.push(["psaume", "PSA"], ["ps", "PSA"]);
    }
    const k = norm(s).replace(/[\s'’.-]/g, "");
    if (!k) return null;
    const exact = NOMS.find(([n]) => n === k);
    if (exact) return exact[1];
    const debut = NOMS.filter(([n]) => k.length >= 3 && n.startsWith(k));
    return debut.length ? debut[0][1] : null;
  }
  function reference(q) {
    const m = /^\s*([1-3]?\s*[^\d\s,:.]+(?:\s+[^\d\s,:.]+)?)\.?\s*(\d+)(?:\s*[,:.]\s*(\d+)(?:\s*[-–]\s*(\d+))?)?\s*$/.exec(q);
    if (!m) return null;
    const b = livreDe(m[1]);
    if (!b) return null;
    const bk = A().byCode[b], c = +m[2];
    if (!bk.ch.includes(c)) return null;
    const v1 = m[3] ? +m[3] : null, v2 = m[4] ? +m[4] : v1;
    return { b, c, v1, v2, label: `${bk.a} ${c}${v1 ? "," + v1 + (v2 && v2 !== v1 ? "-" + v2 : "") : ""}`,
      href: v1 ? `#/p/${b}:${c}:${v1}:${v2}` : `#/p/${b}:${c}:1:999` };
  }

  // ------------------------------------------------------------------ grec, hébreu, Strong
  const origNorm = w => w.toLowerCase().normalize("NFD").replace(/[̀-֑ͯ-ׇ]/g, "").replace(/ς/g, "σ").replace(/[^\p{L}]/gu, "");
  async function original(q) {
    const strong = /^\s*([GH])\s*0*(\d{1,4})\s*$/i.exec(q);
    let liste = [];
    if (strong) liste = [strong[1].toUpperCase() + strong[2]];
    else {
      const k = origNorm(q), heb = /[֐-׿]/.test(q);
      if (!k) return null;
      const O = await charge("data/rech/orig.js", "__RO"), D = heb ? O.h : O.g;
      const s = new Set(D[k] || []);
      if (!s.size) for (const [f, l] of Object.entries(D)) { if (f.startsWith(k)) l.forEach(x => s.add(x)); if (s.size > 12) break; }
      liste = [...s];
    }
    if (!liste.length) return `<p class="missing">Aucun mot ${/[֐-׿]/.test(q) ? "hébreu" : "grec"} trouvé sous cette forme.</p>`;
    const M = await charge("data/mots.js", "__MOTS").catch(() => ({ d: {} }));
    return `<div class="r-groupe">Mots ${/^H/.test(liste[0]) ? "hébreux" : "grecs"} — concordance</div>` + liste.slice(0, 12).map(s =>
      `<button class="r-item r-strong" data-strong="${A().esc(s)}"><b>${A().esc(s)}</b> ${A().esc(M.d[s] || "")}<span class="r-aller">Dictionnaire et concordance ›</span></button>`).join("");
  }

  // ------------------------------------------------------------------ extraits et surlignage
  function extrait(txt, a, long) {
    const esc = A().esc;
    if (!txt) return "";
    const re = /[\p{L}\p{N}]+/gu;
    let premier = -1, m;
    const marques = [];
    while ((m = re.exec(txt))) {
      const k = norm(m[0]).replace(/[^a-z0-9]/g, "");
      if (a.termes.some(t => correspond(t, k))) { marques.push([m.index, m.index + m[0].length]); if (premier < 0) premier = m.index; }
    }
    let debut = 0, fin = txt.length;
    if (long && txt.length > 320) { debut = Math.max(0, (premier < 0 ? 0 : premier) - 110); fin = Math.min(txt.length, debut + 320); }
    let h = debut > 0 ? "… " : "", i = debut;
    for (const [x, y] of marques) {
      if (y <= debut || x >= fin) continue;
      h += esc(txt.slice(i, x)) + `<mark>${esc(txt.slice(x, y))}</mark>`; i = y;
    }
    return h + esc(txt.slice(i, fin)) + (fin < txt.length ? " …" : "");
  }

  // ------------------------------------------------------------------ la page
  let ETAT = { q: "", p: "bj", filtre: "", ids: {}, vus: PAGE, a: null };
  const recentes = () => A().ls.get("bible.recherches", []);
  function retenir(q) { const l = recentes().filter(x => x !== q); l.unshift(q); A().ls.set("bible.recherches", l.slice(0, 8)); }

  async function vue(chemin) {
    const app = A(), $ = app.$;
    const [qe, pe] = String(chemin || "").split("/");
    const q = decodeURIComponent(qe || ""), p = PORTEES.some(x => x[0] === pe) ? pe : (ETAT.p || "bj");
    app.setChrome("Recherche", "", null, false);
    document.querySelectorAll("#tabs button").forEach(b => b.classList.toggle("on", b.dataset.go === "#/r"));
    if (!$("#rq")) {
      $("#view").innerHTML = `<form class="r-form" id="rform" autocomplete="off"><input id="rq" type="search" enterkeyhint="search"
        placeholder="Un mot, une expression, Jn 3,16, ἀγάπη…" aria-label="Rechercher"></form><div id="rres"></div>`;
      let t;
      $("#rq").addEventListener("input", e => { clearTimeout(t); t = setTimeout(() => aller(e.target.value, ETAT.p, true), 450); });
      $("#rform").addEventListener("submit", e => { e.preventDefault(); $("#rq").blur(); aller($("#rq").value, ETAT.p, false); });
    }
    if ($("#rq").value !== q) $("#rq").value = q;
    if (q !== ETAT.q || p !== ETAT.p) ETAT.filtre = "";
    ETAT.p = p;
    await lancer(q);
    if (!q) setTimeout(() => $("#rq") && $("#rq").focus(), 50);
  }
  function aller(q, p, remplacer) {
    const h = `#/r/${encodeURIComponent(q.trim())}/${p}`;
    if (remplacer) { history.replaceState(null, "", h); vue(`${encodeURIComponent(q.trim())}/${p}`); }
    else location.hash = h;
  }

  async function lancer(q) {
    const app = A(), $ = app.$, esc = app.esc, el = $("#rres");
    if (!el) return;
    q = q.trim();
    if (!q) {
      const r = recentes();
      el.innerHTML = `<div class="r-aide"><p><b>Taper</b> un ou plusieurs mots : on trouve les versets qui les contiennent tous, quelle que soit leur forme (<i>pardon</i> trouve aussi <i>pardonner</i>, <i>pardonnez</i>).</p>
        <p><b>"entre guillemets"</b> : l'expression exacte · <b>-mot</b> : sans ce mot · <b>berger*</b> : les mots qui commencent ainsi.</p>
        <p><b>Jn 3,16</b>, <b>1 Co 13</b> : aller au passage · <b>ἀγάπη</b>, <b>חסד</b> ou <b>G26</b> : le mot grec ou hébreu, sa concordance.</p>
        <p>On cherche aussi dans les notes de la BJ, la Vulgate (toutes les formes d'un mot latin), les Pères, les dictionnaires et le commentaire de la Bible chrétienne.</p></div>` +
        (r.length ? `<div class="r-groupe">Recherches récentes</div><div class="chips">${r.map(x => `<a class="chip" href="#/r/${encodeURIComponent(x)}/${ETAT.p}">${esc(x)}</a>`).join("")}</div>` : "");
      return;
    }
    // grec, hébreu, Strong
    if (/[Ͱ-Ͽἀ-῿֐-׿]/.test(q) || /^\s*[GH]\s*\d{1,4}\s*$/i.test(q)) {
      el.innerHTML = `<p class="missing">Recherche…</p>`;
      el.innerHTML = (await original(q)) || "";
      retenir(q);
      return;
    }
    const ref = reference(q);
    const a = analyser(q);
    ETAT.q = q; ETAT.a = a; ETAT.vus = PAGE;
    let h = ref ? `<a class="r-ref" href="${ref.href}">Aller à <b>${esc(ref.label)}</b> ›</a>` : "";
    if (ref) {                              // une référence : on y va ; pour un verset, les articles qui le citent
      retenir(q);
      if (ref.v1) {
        const [dr, ix] = await Promise.all([charge(`data/dref/${ref.b}.js`, "__DREF").catch(() => ({})), charge("data/dico/index.js", "__DICO").catch(() => ({ d: [], t: {} }))]);
        const l = [];
        for (let v = ref.v1; v <= ref.v2; v++) for (const [di, ei] of dr[`${ref.c}.${v}`] || []) if (!l.some(x => x[0] === di && x[1] === ei)) l.push([di, ei]);
        if (l.length) {
          h += `<div class="r-groupe">Articles qui citent ${ref.v2 !== ref.v1 ? "ces versets" : "ce verset"} (${l.length})</div>`;
          h += l.sort((x, y) => x[0] - y[0]).map(([di, ei]) => { const D = ix.d.find(x => x.i === di) || {}, t = ((ix.t[D.c] || [])[ei] || [])[0] || "";
            return `<button class="r-item" data-rart="${esc(D.c)}|${esc(t)}"><span class="r-ref2">${esc(t)}</span> <small>${esc(D.n || "")}</small></button>`; }).join("");
        }
      }
      el.innerHTML = h;
      return;
    }
    if (!a.termes.length) { el.innerHTML = h; return; }
    el.innerHTML = h + `<p class="missing">Recherche…</p>`;
    // toutes les portées en même temps : leurs nombres de résultats s'affichent sur les boutons
    const res = await Promise.all(PORTEES.map(async ([p]) => {
      try { const D = await docs(p); let ids = await chercher(p, a); ids = await verifierPhrases(p, a, ids, D); return [p, ids]; }
      catch (e) { return [p, null]; }
    }));
    if (ETAT.q !== q) return;              // une autre recherche a été lancée entre-temps
    ETAT.ids = Object.fromEntries(res);
    if (!(ETAT.ids[ETAT.p] || []).length) { const autre = res.find(([, l]) => l && l.length); if (autre && !ref) ETAT.p = autre[0]; }
    retenir(q);
    await afficher(h);
  }

  async function afficher(entete) {
    const app = A(), $ = app.$, esc = app.esc, el = $("#rres");
    const p = ETAT.p, a = ETAT.a, D = await docs(p);
    let ids = ETAT.ids[p] || [];
    let h = entete ?? (el.querySelector(".r-ref")?.outerHTML || "");
    h += `<div class="r-portees">${PORTEES.map(([k, l, titre]) => { const n = ETAT.ids[k]; if (n === null) return "";
      return `<button class="chip${k === p ? " on" : ""}${n && n.length ? "" : " vide"}" data-rportee="${k}" title="${esc(titre)}">${esc(l)} <small>${n ? n.length : 0}</small></button>`; }).join("")}</div>`;
    // filtres par testament et par livre (portées bibliques)
    if (["bj", "notes", "lat", "peres"].includes(p) && ids.length) {
      const livres = new Map();
      for (const i of ids) { const b = D[i][0]; livres.set(b, (livres.get(b) || 0) + 1); }
      const T = k => [...livres].filter(([b]) => k === "EV" ? ["MAT", "MRK", "LUK", "JHN"].includes(B(b).c) : B(b).t === k).reduce((s, [, n]) => s + n, 0);
      if (p !== "peres") h += `<div class="seg r-test">${[["", "Tout", ids.length], ["AT", "Ancien T.", T("AT")], ["NT", "Nouveau T.", T("NT")], ["EV", "Évangiles", T("EV")]].map(([k, l, n]) =>
        `<button data-rfiltre="${k}" class="${ETAT.filtre === k ? "on" : ""}"${n ? "" : " disabled"}>${l} <small>${n}</small></button>`).join("")}</div>`;
      if (livres.size > 1) h += `<details class="r-livres"${/^[A-Z0-9]{3}$/.test(ETAT.filtre) ? " open" : ""}><summary>Par livre (${livres.size})</summary><div class="chips">${[...livres].map(([b, n]) =>
        `<button class="chip${ETAT.filtre === B(b).c ? " on" : ""}" data-rfiltre="${B(b).c}">${esc(B(b).a)} <small>${n}</small></button>`).join("")}</div></details>`;
      const f = ETAT.filtre;
      if (f) ids = ids.filter(i => { const b = B(D[i][0]); return f === "EV" ? ["MAT", "MRK", "LUK", "JHN"].includes(b.c) : f.length === 2 ? b.t === f : b.c === f; });
    }
    if (!ids.length) { el.innerHTML = h + `<p class="missing">Aucun résultat ici.</p>`; return; }
    const vus = ids.slice(0, ETAT.vus);
    // textes des résultats affichés
    const T = {};
    if (p !== "dico") await Promise.all([...new Set(vus.map(i => groupe(p, D[i])))].map(async g => Object.assign(T, await textes(p, g))));
    let dernier = null;
    for (const i of vus) {
      const d = D[i];
      if (p === "dico") {
        const ix = await charge("data/dico/index.js", "__DICO").catch(() => ({ d: [] }));
        const di = ix.d.find(x => x.i === d[0]) || {};
        h += `<button class="r-item" data-rart="${esc(di.c)}|${esc(d[1])}"><span class="r-ref2">${esc(d[1])}</span> <small>${esc(di.n || "")}</small></button>`;
        continue;
      }
      if (p === "bc") {
        if (d[0] !== dernier) { h += `<div class="r-groupe">§ ${esc(d[1])} — ${esc(d[2])}</div>`; dernier = d[0]; }
        h += `<a class="r-item" href="#/bc/${esc(d[0])}"><span class="t">${extrait(T[i], a, true)}</span> <small>p. ${esc(d[3])}</small></a>`;
        continue;
      }
      const b = B(d[0]);
      if (b.c !== dernier) { h += `<div class="r-groupe">${esc(b.n)}</div>`; dernier = b.c; }
      if (p === "peres") {
        const [, c1, v1, c2, v2, aut, src] = d;
        const spec = c1 === c2 ? `${b.c}:${c1}:${v1}:${v2}` : `${b.c}:${c1}:${v1}:999`;
        h += `<a class="r-item" href="#/p/${spec}/meditatio"><span class="r-ref2">${esc(b.a)} ${c1},${v1}${v2 !== v1 || c2 !== c1 ? "-" + (c2 !== c1 ? c2 + "," : "") + v2 : ""}</span> <b class="r-aut">${esc(aut)}</b> <span class="t">${extrait(T[i], a, true)}</span></a>`;
        continue;
      }
      const [, c, v, k] = d;
      h += `<a class="r-item" href="#/p/${b.c}:${c}:1:999@${b.c}.${c}.${v}"><span class="r-ref2">${esc(b.a)} ${c},${esc(v)}${k ? ` <small>note ${esc(k)}</small>` : ""}</span> <span class="t${p === "lat" ? " r-lat" : ""}">${extrait(T[i], a, p === "notes")}</span></a>`;
    }
    if (ids.length > vus.length) h += `<button class="btn ghost r-plus" data-rplus>Afficher la suite (${ids.length - vus.length})</button>`;
    el.innerHTML = h;
  }

  // ------------------------------------------------------------------ clics
  document.addEventListener("click", async e => {
    if (!/^#\/r(\/|$)/.test(location.hash)) return;
    const t = e.target, q = s => t.closest(s);
    let x;
    if ((x = q("[data-rportee]"))) { ETAT.p = x.dataset.rportee; ETAT.filtre = ""; ETAT.vus = PAGE; history.replaceState(null, "", `#/r/${encodeURIComponent(ETAT.q)}/${ETAT.p}`); return afficher(); }
    if ((x = q("[data-rfiltre]"))) { ETAT.filtre = ETAT.filtre === x.dataset.rfiltre ? "" : x.dataset.rfiltre; ETAT.vus = PAGE; return afficher(); }
    if (q("[data-rplus]")) { ETAT.vus += PAGE * 2; const y = window.scrollY; await afficher(); window.scrollTo(0, y); return; }
    if ((x = q("[data-rart]"))) { const [c, ...ti] = x.dataset.rart.split("|"); return A().openArticle(c, ti.join("|")); }
    if ((x = q("[data-strong]"))) return A().lexSheet(x.dataset.strong);
  });

  window.Recherche = { vue, reference };
})();
