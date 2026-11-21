/* Textes propres : le psautier (avec inflexions, stiques, strophes) et la Bible.

   Psautier.piece(refAelf, versetsAelf) → { piece, lignes filtrées } ou null
   Psautier.html(selection)             → HTML d'un psaume ou d'un cantique
   PsautierAELF                         → même interface, psautier liturgique AELF (version « 100 % AELF »)
   Bible.lire(refAelf)                  → Promise<{ ref, html, manquants[] }>
*/
(function (g) {
  "use strict";
  const esc = (s) => String(s ?? "").replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));

  // ───────────────────────── Références ─────────────────────────
  // Versets d'une référence biblique : "Dn 3, 8-12.19-24.91-97", "Ap 4, 11; 5, 9-10.12",
  // "Is 52, 13 – 53, 12", "1 P 5, 8-9a". Renvoie { livre, versets: [[ch, v], …] }.
  function analyserRef(ref) {
    ref = String(ref || "").replace(/[–—_]/g, "-").replace(/\s+/g, " ").trim()
      .replace(/^cf\.?\s*/i, "").replace(/[.\s]+$/, "")
      .replace(/(\d)\s+([a-c])\b/g, "$1$2")                 // « 1 b-4a » → « 1b-4a »
      .replace(/^((?:[1-3]\s?)?[A-ZÉ][a-zéèëï]*)\s+(\d+)\.?\s+(\d)/, "$1 $2, $3"); // « Is 7 14b », « 2 P 3. 8b »
    const m = /^((?:[1-3]\s?)?[A-ZÉa-zéèëï]+)\.?\s*(.*)$/.exec(ref);
    if (!m) return null;
    const livre = m[1].replace(/\s/g, "");
    let reste = m[2];
    // livres d'un seul chapitre : « Jude 20-25 » = Jude 1, 20-25
    if (/^(Ab|Phm|2Jn|3Jn|Jude|Jud)$/.test(livre) && !/,/.test(reste)) reste = "1, " + reste;
    const out = [];
    let ch = null;
    for (const seg of reste.split(/;/)) {
      const s = seg.trim();
      if (!s) continue;
      let corps = s;
      const mc = /^(\d+)\s*,\s*(.*)$/.exec(s);
      if (mc) { ch = +mc[1]; corps = mc[2]; }
      else if (/^\d+$/.test(s) && !out.length && ch === null) { ch = +s; out.push([ch, "*"]); continue; }
      for (const morceau of corps.split(".")) {
        const r = morceau.trim();
        if (!r) continue;
        // a-b, ou a - c,b (passage d'un chapitre à l'autre)
        const mr = /^(\d+)[a-z]*\s*(?:-\s*(?:(\d+)\s*,\s*)?(\d+)[a-z]*)?$/.exec(r);
        if (!mr) continue;
        const a = +mr[1];
        if (mr[2]) { // jusqu'à un autre chapitre
          out.push([ch, a, "fin"]);
          for (let c = ch + 1; c < +mr[2]; c++) out.push([c, "*"]);
          ch = +mr[2];
          for (let v = 1; v <= +mr[3]; v++) out.push([ch, v]);
        } else {
          const b = mr[3] ? +mr[3] : a;
          for (let v = a; v <= b; v++) out.push([ch, v]);
        }
      }
    }
    return { livre, versets: out };
  }

  // ───────────────────────── Psautier ─────────────────────────
  // Un psautier = un jeu de données (psautier.json : BJ ; psautier_aelf.json : AELF avec inflexions).
  function creerPsautier() {
  let P = null;
  const ROMAINS = { I: 1, II: 2, III: 3, IV: 4, V: 5, VI: 6 };

  // Numéros de verset AELF ("7-9", "4.11", "08") → ensemble de "ch:v" ou de "v"
  function ensembleAelf(versets, chapitreDefaut) {
    const s = new Set();
    let ch = chapitreDefaut;
    for (const brut of versets || []) {
      let x = String(brut).trim().replace(/[a-z]$/i, "");
      const mc = /^(\d+)[.,](\d+)(?:-(\d+))?$/.exec(x);
      if (mc) { ch = +mc[1]; const a = +mc[2], b = mc[3] ? +mc[3] : a; for (let v = a; v <= b; v++) s.add(`${ch}:${v}`); continue; }
      const mr = /^(\d+)(?:-(\d+))?$/.exec(x);
      if (mr) { const a = +mr[1], b = mr[2] ? +mr[2] : a; for (let v = a; v <= b; v++) s.add(ch != null ? `${ch}:${v}` : `${v}`); }
    }
    return s;
  }

  // Versets couverts par chaque ligne d'une pièce : du numéro de la ligne jusqu'au numéro suivant
  // (le psautier ne numérote pas toujours chaque verset), plus les numéros en cours de ligne.
  // Clés : "v" (psaumes) ou "ch:v" (cantiques sur plusieurs chapitres).
  function etiqueterLignes(piece) {
    const lignes = [];
    let ch = null;
    piece.strophes.forEach((st, i) => st.lignes.forEach((l, j) => {
      const nums = [];
      const lire = (x) => { const mc = /^(\d+)[,.](\d+)/.exec(x); if (mc) { ch = +mc[1]; nums.push([ch, +mc[2]]); } else if (/^\d/.test(x)) nums.push([ch, parseInt(x, 10)]); };
      if (l.v) lire(l.v);
      for (const m of l.t.matchAll(/<sup class="v">([^<]+)<\/sup>/g)) lire(m[1]);
      lignes.push({ i, j, nums });
    }));
    const cle = (c, v) => (c != null ? `${c}:${v}` : `${v}`);
    let cur = null;
    const debut = lignes.find((x) => x.nums.length)?.nums[0] || null;
    for (let k = 0; k < lignes.length; k++) {
      const L = lignes[k];
      const s = new Set();
      if (L.nums.length) { for (const [c, v] of L.nums) s.add(cle(c, v)); cur = L.nums[L.nums.length - 1]; }
      const base = cur || debut;
      if (base) {
        let suiv = null, plusProche = Infinity;
        for (let n = k + 1; n < lignes.length; n++) for (const x of lignes[n].nums) {
          if (!suiv) suiv = x;
          if (x[0] === base[0] && x[1] > base[1]) plusProche = Math.min(plusProche, x[1]);
        }
        // Un verset suivant plus petit signale une transposition propre à la BJ :
        // la ligne ne couvre alors que son propre verset.
        let fin;
        if (!suiv) fin = base[1] + 40;
        else if (suiv[0] !== base[0]) fin = base[1] + 40;
        else if (suiv[1] > base[1]) fin = Math.min(suiv[1], plusProche) - 1;
        else { fin = base[1]; if (L.nums.length) L.transpose = true; }
        for (let v = base[1]; v <= Math.max(base[1], fin); v++) s.add(cle(base[0], v));
      }
      L.versets = s;
    }
    return lignes;
  }

  const refCantiques = {}; // id → { livre, versets:Set("ch:v"), chapitre }
  function indexerCantiques() {
    for (const id of P.ordre) {
      const p = P.pieces[id];
      if (p.genre === "psaume" || !p.ref) continue;
      const r = analyserRef(p.ref.replace(/(\d)\s*;\s*(\d)/g, "$1; $2"));
      if (!r) continue;
      refCantiques[id] = { livre: r.livre, versets: new Set(r.versets.map(([c, v]) => `${c}:${v}`)), chapitre: r.versets[0]?.[0] };
    }
  }

  async function chargerPsautier(url) {
    P = await (await fetch(url, { cache: "no-cache" })).json();
    indexerCantiques();
    return P;
  }

  // Trouve la pièce correspondant à une référence AELF
  function trouver(refAelf, versetsAelf) {
    if (!P) throw new Error("psautier non chargé");
    const ref = String(refAelf || "").trim();
    // Cantiques évangéliques
    const evang = { "Lc 1:68": "NT2", "Lc 1:46": "NT1", "Lc 1:47": "NT1", "Lc 2:29": "NT3" };
    // « CANTIQUE (Ap 4-5) », « CANTIQUE d'Azarias (Dn 3) », « Lc 1 »
    let mc = /\(([^)]+)\)[.\s]*$/.exec(ref);
    const refBible = mc ? mc[1] : (/^(?:[1-3]\s?)?[A-Z][a-z]+\s+\d/.test(ref) && !/^\d/.test(ref) ? ref : null);
    if (refBible || /^CANTIQUE/i.test(ref)) {
      const r = analyserRef(refBible || "");
      if (!r) return null;
      const chap = r.versets[0]?.[0];
      const ens = ensembleAelf(versetsAelf, chap);
      const prem = [...ens][0];
      if (prem && evang[`${r.livre} ${prem}`]) return { id: evang[`${r.livre} ${prem}`], ensemble: null, cantique: true };
      let meilleur = null, score = 0;
      for (const [id, c] of Object.entries(refCantiques)) {
        if (c.livre !== r.livre) continue;
        let n = 0; for (const x of ens) if (c.versets.has(x)) n++;
        if (!ens.size && r.versets.some(([ch]) => [...c.versets].some((k) => k.startsWith(ch + ":")))) n = 0.5;
        if (n > score) { score = n; meilleur = id; }
      }
      return meilleur ? { id: meilleur, ensemble: null, cantique: true } : null;
    }
    // Psaumes : "100", "101 - I", "118-18", "9 A", "9A-II", "113 B"
    const m = /^(\d+)\s*([AB])?\s*(?:-\s*([IVX]+|\d+))?/i.exec(ref.replace(/^Ps\.?\s*/i, ""));
    if (!m) return null;
    const num = m[1], ab = (m[2] || "").toUpperCase();
    let id = num + ab;
    if (num === "118" && m[3] && /^\d+$/.test(m[3])) id = `118-${+m[3]}`;
    if (num === "118" && m[3] && ROMAINS[m[3]] && !P.pieces[id]) id = `118-${ROMAINS[m[3]]}`;
    if (!P.pieces[id]) {
      // Ps 9 et 113 : AELF les donne parfois sans A/B ; on cherche la pièce qui contient les versets
      const ens = ensembleAelf(versetsAelf, null);
      for (const cand of [num + "A", num + "B"]) {
        if (!P.pieces[cand]) continue;
        const cles = new Set(etiqueterLignes(P.pieces[cand]).flatMap((x) => [...x.versets]));
        if ([...ens].some((v) => cles.has(v))) { id = cand; break; }
      }
    }
    if (!P.pieces[id]) return null;
    const ens = ensembleAelf(versetsAelf, null);
    return { id, ensemble: ens.size ? ens : null, division: m[3] && !/^\d+$/.test(m[3]) ? m[3].toUpperCase() : null };
  }

  // Partie k sur n d'une pièce (psaume chanté sous plusieurs antiennes) : coupe aux limites
  // de strophes, au plus près d'un partage égal du nombre de lignes.
  function partie(p, k, n) {
    const tailles = p.strophes.map((s) => s.lignes.length);
    const total = tailles.reduce((a, b) => a + b, 0);
    const coupes = [0];
    let cumul = 0, cible = 1;
    tailles.forEach((t, i) => {
      const avant = cumul;
      cumul += t;
      while (cible < n && cumul >= (total * cible) / n) {
        // coupe avant ou après cette strophe, selon ce qui est le plus proche de la cible
        const ideal = (total * cible) / n;
        coupes.push(Math.abs(avant - ideal) < Math.abs(cumul - ideal) && i > coupes[coupes.length - 1] ? i : i + 1);
        cible++;
      }
    });
    while (coupes.length < n) coupes.push(p.strophes.length);
    coupes.push(p.strophes.length);
    return p.strophes.slice(coupes[k - 1], coupes[k]).map((s) => ({ ...s }));
  }

  function lignesChoisies(sel) {
    const p = P.pieces[sel.id];
    if (sel.garde) return p.strophes.map((s, i) => ({ ...s, lignes: s.lignes.filter((_, j) => sel.garde.has(`${i}/${j}`)) })).filter((s) => s.lignes.length);
    if (sel.partie && sel.partie[1] > 1) return partie(p, sel.partie[0], sel.partie[1]);
    if (sel.versets && !sel.ensemble) {
      const [a, b] = String(sel.versets).split("-").map((x) => parseInt(x, 10));
      sel = { ...sel, ensemble: new Set(Array.from({ length: (b || a) - a + 1 }, (_, i) => String(a + i))) };
    }
    if (!sel.ensemble) return p.strophes.map((s) => ({ ...s }));
    const etiq = etiqueterLignes(p);
    const garde = new Set();
    let precedente = false;
    for (const x of etiq) {
      // un verset transposé par la BJ suit le sort de la ligne qui le précède
      const g2 = x.transpose ? precedente : [...x.versets].some((v) => sel.ensemble.has(v));
      if (g2) garde.add(`${x.i}/${x.j}`);
      precedente = g2;
    }
    if (!garde.size) return p.strophes.map((s) => ({ ...s })); // numérotation différente : psaume entier
    const out = [];
    p.strophes.forEach((s, i) => {
      const lignes = s.lignes.filter((_, j) => garde.has(`${i}/${j}`));
      if (lignes.length) out.push({ ...s, lignes, lettre: garde.has(`${i}/0`) ? s.lettre : null });
    });
    return out;
  }

  // versets effectivement imprimés pour une sélection (sert aux contrôles)
  function couverture(sel) {
    const p = P.pieces[sel.id];
    const gardees = new Set(lignesChoisies(sel).flatMap((s) => s.lignes));
    return new Set(etiqueterLignes(p).filter((x) => gardees.has(p.strophes[x.i].lignes[x.j])).flatMap((x) => [...x.versets]));
  }

  const SANS_GLOIRE = new Set(["AT48", "AT49"]); // cantique des trois enfants, des créatures

  function htmlPiece(sel, options = {}) {
    const p = P.pieces[sel.id];
    const strophes = lignesChoisies(sel);
    let titre = esc(p.genre === "psaume" || /cantique|chant|prière|éloge|lamentation/i.test(p.titre) ? p.titre : `Cantique : ${p.titre}`);
    if (sel.division) titre += ` <span class="division">${esc(sel.division)}</span>`;
    if (sel.partie && sel.partie[1] > 1) titre += ` <span class="division">${"abcdef"[sel.partie[0] - 1]}</span>`;
    else if (sel.versets) titre += ` <span class="division">${esc(sel.versets)}</span>`;
    let h = `<div class="psaume" data-piece="${esc(sel.id)}">`;
    if (!options.sansTitre) h += `<h4 class="titre-psaume">${titre}${p.ref ? ` <span class="ref">(${esc(p.ref)})</span>` : ""}</h4>`;
    for (const s of strophes) {
      h += `<div class="strophe">`;
      if (s.lettre) h += `<div class="lettre-hebraique">${esc(s.lettre)}</div>`;
      for (const l of s.lignes) {
        const cl = ["stique"]; if (l.r) cl.push("r" + l.r);
        h += `<p class="${cl.join(" ")}">`;
        if (l.l) h += `<span class="lettre-marge">${esc(l.l)}</span>`;
        if (l.v) h += `<sup class="v">${esc(l.v)}</sup> `;
        h += `${l.t}</p>`; // texte déjà nettoyé à la construction (seuls <b> et <i>)
      }
      h += `</div>`;
    }
    if (!options.sansGloire && !SANS_GLOIRE.has(sel.id)) h += g.Textes.GLOIRE;
    // prière psalmique : repliée par défaut (dépliée si le réglage le demande)
    if (!options.sansPriere && p.priere && p.priere.length) h += `<details class="priere-psalmique"${options.priere ? " open" : ""}><summary class="rubrique">Prions</summary>${p.priere.map((x) => `<p>${x}</p>`).join("")}</details>`;
    return h + `</div>`;
  }

  // Ajuste les bords d'une sélection au texte de référence (HTML de l'AELF) : quand l'AELF coupe un psaume
  // au milieu d'un verset, retire en tête / en fin les lignes absentes de ce texte et ajoute les lignes voisines présentes.
  const norm = (h) => String(h || "").replace(/<span class="verse_number">[^<]*<\/span>/g, " ").replace(/<\/?(?:b|u|i)>/g, "")
    .replace(/<[^>]+>/g, " ").replace(/&[a-z#0-9]+;/gi, " ").normalize("NFD").replace(/[\u0300-\u036f]/g, "").replace(/œ/g, "oe")
    .toLowerCase().replace(/[^a-z]+/g, " ").trim();
  // Numéros de verset d'un texte AELF. Refrains : « R/ 6 » = verset 6 ; « R/ 2 8 » = refrain 2, verset 8 ;
  // « R/ 1 » suivi d'un autre numéro = refrain 1 seulement. « [12] » (verset omis) ignoré.
  function versetsAELF(html) {
    const out = [];
    String(html || "").replace(/(\[?)<span class="verse_number">([^<]+)<\/span>(?=(\s*<span class="verse_number">)?)/g, (m, crochet, v, suite) => {
      v = v.trim();
      if (crochet) return m;
      if (/R\//.test(v)) { // « R/ 6 », « (R/) 15 », « R/ 2 8 »
        const nums = v.match(/\d+[a-z]?/g) || [];
        if (suite && nums.length < 2) return m;
        v = nums[nums.length - 1] || "";
      }
      if (v) out.push(v);
      return m;
    });
    return out;
  }

  function ajuster(sel, texteRef) {
    const W = ` ${norm(texteRef)} `;
    if (W.length < 3) return sel;
    const p = P.pieces[sel.id];
    const plat = [];
    p.strophes.forEach((s, i) => s.lignes.forEach((l, j) => plat.push({ i, j, l, n: norm(l.t) })));
    const choisies = new Set(lignesChoisies(sel).flatMap((s) => s.lignes));
    const idx = plat.map((x, k) => (choisies.has(x.l) ? k : -1)).filter((k) => k >= 0);
    if (!idx.length) return sel;
    const present = (k) => !plat[k].n || W.includes(` ${plat[k].n} `);
    const garde = new Set(idx);
    // passage du psautier absent du texte de l'AELF (au moins 3 lignes de suite dont presque aucun mot n'y figure) : retiré
    const mots = new Set(W.split(" "));
    const absente = (k) => { const m = plat[k].n.split(" ").filter((x) => x.length > 2); return m.length >= 2 && m.filter((x) => mots.has(x)).length / m.length < 0.5; };
    for (let k = 0; k < idx.length;) {
      let f = k;
      while (f < idx.length && absente(idx[f])) f++;
      if (f - k >= 3) for (let q = k; q < f; q++) garde.delete(idx[q]);
      k = Math.max(f, k + 1);
    }
    if (!garde.size) return sel;
    idx.splice(0, idx.length, ...[...garde].sort((x, y) => x - y));
    let a = idx[0], b = idx[idx.length - 1], n;
    for (n = 0; n < 3 && a < b && !present(a); n++) garde.delete(a++);
    for (n = 0; n < 3 && b > a && !present(b); n++) garde.delete(b--);
    for (n = 0; n < 4 && a > 0 && plat[a - 1].n && present(a - 1); n++) garde.add(--a);
    for (n = 0; n < 4 && b < plat.length - 1 && plat[b + 1].n && present(b + 1); n++) garde.add(++b);
    return { ...sel, garde: new Set([...garde].map((k) => `${plat[k].i}/${plat[k].j}`)) };
  }

  return { charger: chargerPsautier, ajuster, versetsAELF, trouver, html: htmlPiece, lignes: lignesChoisies, couverture, ensembleAelf,
    transpositions: (id) => new Set(etiqueterLignes(P.pieces[id]).filter((x) => x.transpose).flatMap((x) => x.nums.map((n) => n[1]))),
    get donnees() { return P; }, get charge() { return !!P; } };
  }

  // ───────────────────────── Bible ─────────────────────────
  const livres = {};
  let omis = null;
  let baseBible = "donnees/bible/";
  async function livre(code) {
    if (!livres[code]) livres[code] = fetch(baseBible + code + ".json").then((r) => (r.ok ? r.json() : null)).catch(() => null);
    return livres[code];
  }
  // Codes AELF → codes du fichier (identiques sans les espaces, sauf exceptions)
  const ALIAS = { "Qo": "Qo", "Eccl": "Qo", "Si": "Si", "Sir": "Si", "Ct": "Ct", "Jdt": "Jdt", "Est": "Est", "Ba": "Ba", "Bar": "Ba",
    "1M": "1M", "2M": "2M", "Tb": "Tb", "Sg": "Sg", "Ap": "Ap", "Jc": "Jc", "Phm": "Phm", "Ha": "Ha", "Ab": "Ab", "Jon": "Jon",
    "Jude": "Jude", "Jud": "Jude", "Ps": "Ps", "1Tm": "1Tm", "2Tm": "2Tm", "1Th": "1Th", "2Th": "2Th", "1Jn": "1Jn", "2Jn": "2Jn", "3Jn": "3Jn" };

  async function lireBible(refAelf) {
    const r = analyserRef(refAelf);
    if (!r || !r.versets.length) return null;
    const code = ALIAS[r.livre] || r.livre;
    const L = await livre(code);
    if (!L) return null;
    if (!omis) omis = new Set(((await (await fetch(baseBible + "index.json")).json()) || {}).versets_omis || []);
    const morceaux = [], manquants = [];
    const plusieurs = new Set(r.versets.map((x) => x[0])).size > 1;
    let chPrec = plusieurs ? null : r.versets[0][0];
    for (const [ch, v, fin] of r.versets) {
      const C = L[String(ch)];
      if (!C) { manquants.push(`${ch}`); continue; }
      let liste = [];
      if (v === "*") liste = Object.keys(C).map(Number).sort((a, b) => a - b);
      else if (fin === "fin") liste = Object.keys(C).map(Number).filter((x) => x >= v).sort((a, b) => a - b);
      else liste = [v];
      const dernier = Math.max(...Object.keys(C).map(Number));
      for (const x of liste) {
        const t = C[String(x)];
        if (t == null) {
          if (x > dernier || omis.has(`${code} ${ch},${x}`)) continue; // verset absent de cette traduction
          manquants.push(`${ch},${x}`); continue;
        }
        const marque = ch !== chPrec ? `${ch},${x}` : `${x}`;
        morceaux.push(`<sup class="v">${esc(marque)}</sup>&#8239;${esc(t)}`);
        chPrec = ch;
      }
    }
    return { ref: refAelf, code, html: morceaux.join(" "), manquants };
  }

  g.Textes = {
    GLOIRE: `<div class="gloire"><p>Gloire au Père, et au Fils, et au Saint-Esprit,</p><p>pour les siècles des siècles. Amen.</p></div>`,
    esc, analyserRef,
  };
  g.Psautier = creerPsautier();
  g.Textes.ensembleAelf = g.Psautier.ensembleAelf;
  // psautier liturgique de l'AELF (inflexions en gras), pour la version « 100 % AELF » : chargé à la demande
  g.PsautierAELF = creerPsautier();
  g.Bible = { lire: lireBible, base: (b) => (baseBible = b), livre };
})(typeof window !== "undefined" ? window : globalThis);
