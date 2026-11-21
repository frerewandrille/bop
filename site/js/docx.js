/* Export Word (.docx) des offices préparés — sans bibliothèque externe.

   Docx.creer(fragmentsHTML[], { format: "A5" | "A4", titre, sousTitre, saut }) → Blob
   Convertit le HTML des offices (classes de offices.js / textes.js) en WordprocessingML :
   gras des inflexions, versets en exposant rouge, un stique par ligne, strophes espacées,
   rubriques en rouge, chaque office sur une nouvelle page.
*/
(function (g) {
  "use strict";
  const ROUGE = "A3201C", GRIS = "6B6157";
  const xml = (s) => String(s).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");

  // ── ZIP (méthode « stockée », sans compression) ──
  const TABLE = (() => { const t = new Uint32Array(256); for (let n = 0; n < 256; n++) { let c = n; for (let k = 0; k < 8; k++) c = c & 1 ? 0xEDB88320 ^ (c >>> 1) : c >>> 1; t[n] = c >>> 0; } return t; })();
  const crc32 = (b) => { let c = 0xFFFFFFFF; for (let i = 0; i < b.length; i++) c = TABLE[(c ^ b[i]) & 0xFF] ^ (c >>> 8); return (c ^ 0xFFFFFFFF) >>> 0; };
  function zip(fichiers) {
    const enc = new TextEncoder(), parties = [], centrale = [];
    let decalage = 0;
    const u16 = (v) => [v & 255, (v >>> 8) & 255], u32 = (v) => [v & 255, (v >>> 8) & 255, (v >>> 16) & 255, (v >>> 24) & 255];
    for (const [nom, contenu] of fichiers) {
      const n = enc.encode(nom), d = contenu instanceof Uint8Array ? contenu : enc.encode(contenu), c = crc32(d);
      const tete = new Uint8Array([...u32(0x04034b50), ...u16(20), ...u16(0x0800), ...u16(0), ...u16(0), ...u16(0x21), ...u32(c), ...u32(d.length), ...u32(d.length), ...u16(n.length), ...u16(0)]);
      parties.push(tete, n, d);
      centrale.push(new Uint8Array([...u32(0x02014b50), ...u16(20), ...u16(20), ...u16(0x0800), ...u16(0), ...u16(0), ...u16(0x21), ...u32(c), ...u32(d.length), ...u32(d.length), ...u16(n.length), ...u16(0), ...u16(0), ...u16(0), ...u16(0), ...u32(0), ...u32(decalage)]), n);
      decalage += tete.length + n.length + d.length;
    }
    const tailleC = centrale.reduce((a, b) => a + b.length, 0);
    const fin = new Uint8Array([...u32(0x06054b50), ...u16(0), ...u16(0), ...u16(fichiers.length), ...u16(fichiers.length), ...u32(tailleC), ...u32(decalage), ...u16(0)]);
    return new Blob([...parties, ...centrale, fin], { type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document" });
  }

  // ── Runs et paragraphes ──
  // polices Kepler Std (tailles optiques) : texte « Kepler Std » par défaut, titres Display/Subhead, petits intitulés Caption
  const TITRE = "Kepler Std Disp", SOUSTITRE = "Kepler Std Subh", LEGENDE = "Kepler Std Medium Capt";
  function run(texte, st) {
    if (!texte || st.cache) return "";
    let rpr = "";
    if (st.police) rpr += `<w:rFonts w:ascii="${st.police}" w:hAnsi="${st.police}" w:cs="${st.police}"/>`;
    if (st.b) rpr += "<w:b/>";
    if (st.i) rpr += "<w:i/>";
    if (st.caps) rpr += "<w:caps/>";
    if (st.smallCaps) rpr += "<w:smallCaps/>";
    if (st.couleur) rpr += `<w:color w:val="${st.couleur}"/>`;
    if (st.espacement) rpr += `<w:spacing w:val="${st.espacement}"/>`;
    if (st.taille) rpr += `<w:sz w:val="${st.taille}"/><w:szCs w:val="${st.taille}"/>`;
    if (st.u) rpr += '<w:u w:val="single"/>';   // syllabe accentuée des psaumes de l'AELF
    if (st.exposant) rpr += `<w:vertAlign w:val="superscript"/>`;
    return `<w:r>${rpr ? `<w:rPr>${rpr}</w:rPr>` : ""}<w:t xml:space="preserve">${xml(texte)}</w:t></w:r>`;
  }
  const saut = () => "<w:r><w:br/></w:r>";

  function para(runs, p = {}) {
    let ppr = "";
    if (p.sautPage) ppr += "<w:pageBreakBefore/>";
    if (p.garderSuivant) ppr += "<w:keepNext/>";
    if (p.garderLignes) ppr += "<w:keepLines/>";
    if (p.filet) ppr += `<w:pBdr><w:bottom w:val="single" w:sz="4" w:space="8" w:color="${ROUGE}"/></w:pBdr>`;
    ppr += `<w:spacing w:before="${p.avant || 0}" w:after="${p.apres ?? 0}"/>`;
    if (p.gauche || p.suspendu || p.premiere) ppr += `<w:ind w:left="${p.gauche || 0}"${p.suspendu ? ` w:hanging="${p.suspendu}"` : ""}${p.premiere ? ` w:firstLine="${p.premiere}"` : ""}/>`;
    if (p.align) ppr += `<w:jc w:val="${p.align}"/>`;
    return `<w:p><w:pPr>${ppr}</w:pPr>${runs}</w:p>`;
  }

  // Style d'un élément inline, hérité du parent
  function styleInline(el, st) {
    const t = el.tagName.toLowerCase(), c = el.classList;
    const n = { ...st };
    if (t === "b" || t === "strong") n.b = true;
    if (t === "i" || t === "em") n.i = true;
    if (t === "u") n.u = true;
    if (t === "sup" || c.contains("v")) { n.exposant = true; n.couleur = ROUGE; n.b = false; }
    if (c.contains("rubrique") || c.contains("rv")) { n.couleur = ROUGE; n.b = true; n.i = false; }
    if (c.contains("ton") || c.contains("ref") || c.contains("division")) { n.couleur = GRIS; n.taille = Math.max(12, (st.taille || 21) - 6); n.b = false; }
    if (c.contains("lettre-marge") || c.contains("lettre-hebraique")) n.couleur = ROUGE;
    return n;
  }

  // Contenu inline → runs ; « .espace » (saut de strophe dans une hymne) coupe le paragraphe
  function inlines(noeud, st, sortie) {
    for (const x of noeud.childNodes) {
      if (x.nodeType === 3) { const t = x.textContent.replace(/\s+/g, " "); sortie.cur += run(t, st); continue; }
      if (x.nodeType !== 1) continue;
      const tag = x.tagName.toLowerCase();
      if (tag === "br") { sortie.cur += saut(); continue; }
      if (x.classList.contains("espace")) { sortie.coupe(); continue; }
      if (["p", "div", "h3", "h4"].includes(tag)) { sortie.coupe(); bloc(x, st, sortie.paras, sortie.ctx); continue; }
      inlines(x, styleInline(x, st), sortie);
    }
  }

  const BLOCS = new Set(["p", "div", "section", "header", "article", "h1", "h2", "h3", "h4", "aside", "details", "figure"]);
  const aBlocs = (el) => [...el.children].some((c) => BLOCS.has(c.tagName.toLowerCase()) && !c.classList.contains("espace"));

  // Propriétés de paragraphe et style de base selon la classe
  function proprietes(el, ctx) {
    const t = el.tagName.toLowerCase(), c = el.classList;
    const st = { taille: ctx.taille }, p = { apres: 80 };
    if (t === "h1") Object.assign(st, { police: TITRE, taille: ctx.taille + 22, couleur: ROUGE }), Object.assign(p, { align: "center", avant: 2400, apres: 200 });
    const entete = !!(el.closest && el.closest(".entete-office"));
    if (t === "h2") Object.assign(st, { police: SOUSTITRE, taille: ctx.taille + 18, couleur: ROUGE }), Object.assign(p, { align: "center", avant: 40, apres: 60, garderSuivant: true });
    if (t === "h3") Object.assign(st, { police: LEGENDE, taille: Math.round(ctx.taille * 0.74), couleur: ROUGE, b: false, caps: true, espacement: 24 }), Object.assign(p, { avant: 260, apres: 80, garderSuivant: true });
    if (t === "h4" || c.contains("titre-psaume")) Object.assign(st, { couleur: ROUGE, b: true }), Object.assign(p, { avant: 120, apres: 60, garderSuivant: true });
    if (c.contains("nocturne")) Object.assign(st, { police: LEGENDE, caps: true, taille: Math.round(ctx.taille * 0.72) });
    if (c.contains("date-longue")) Object.assign(st, { police: LEGENDE, caps: true, couleur: GRIS, taille: Math.round(ctx.taille * 0.72) }), Object.assign(p, { apres: 0, garderSuivant: true });
    if (c.contains("celebration")) Object.assign(st, { i: true }), Object.assign(p, { apres: 0, garderSuivant: true });
    if (c.contains("choix-office")) Object.assign(st, { cache: true });
    if (c.contains("ferie") || c.contains("facultatives") || c.contains("psautier-semaine") || c.contains("credit") || c.contains("note")) Object.assign(st, { couleur: GRIS, taille: Math.round(ctx.taille * 0.85) }), Object.assign(p, { apres: 0 });
    if (c.contains("ref-ligne")) Object.assign(st, { police: LEGENDE, couleur: ROUGE, taille: Math.round(ctx.taille * 0.8) }), Object.assign(p, { apres: 40, garderSuivant: true });
    if (c.contains("antienne")) Object.assign(st, { i: true }), Object.assign(p, { avant: 60, apres: 60 });
    if (c.contains("stique")) {
      const r = +(([...c].find((x) => /^r\d$/.test(x)) || "r0").slice(1));
      Object.assign(p, { gauche: 400 + r * 340, suspendu: 400, apres: 0, garderSuivant: !ctx.derniereLigne, garderLignes: true });
      if (ctx.derniereLigne) p.apres = 140;
    }
    if (el.closest && el.closest(".gloire")) Object.assign(st, { i: true }), Object.assign(p, { apres: 0, gauche: 400, suspendu: 400 });
    if (c.contains("lecture")) Object.assign(p, { align: "both", apres: 100 });
    if (c.contains("preces-reponse")) Object.assign(st, { i: true }), Object.assign(p, { gauche: 360, apres: 40 });
    if (c.contains("preces-invocation")) Object.assign(p, { avant: 60, apres: 0, garderSuivant: true });
    if (c.contains("faisant-memoire") || c.contains("traduction")) Object.assign(st, { i: true, couleur: GRIS });
    if (entete && t === "p") Object.assign(p, { align: "center" });
    if (c.contains("psautier-semaine")) Object.assign(p, { apres: 200, filet: true });
    if (c.contains("province-jour")) Object.assign(st, { police: LEGENDE, i: false, couleur: GRIS, taille: Math.round(ctx.taille * 0.72) });
    else if (el.closest && el.closest(".president")) Object.assign(st, { i: true });
    if (c.contains("titre-ps")) Object.assign(st, { smallCaps: true, taille: Math.round(ctx.taille * 0.85) }), Object.assign(p, { align: "center", apres: 20 });
    if (c.contains("chapeau") || c.contains("gloria")) Object.assign(st, { i: true, taille: Math.round(ctx.taille * 0.85) }), Object.assign(p, { apres: 60 });
    return { st, p };
  }

  // Image de partition (insérée dans le document Word, redimensionnable)
  function image(src, ctx) {
    const im = ctx.images?.get(src);
    if (!im) return "";
    const largeurMax = ctx.largeurTexte;                       // EMU
    const dpi = im.dpi || 110;                                  // pages scannées à 110 dpi, gravures LilyPond à 200
    let cx = Math.round(im.w / dpi * 914400), cy = Math.round(im.h / dpi * 914400);
    if (cx > largeurMax) { cy = Math.round(cy * largeurMax / cx); cx = largeurMax; }
    // une image plus haute que la page (cantique entier gravé) : réduite pour tenir sur une page
    if (ctx.hauteurTexte && cy > ctx.hauteurTexte) { cx = Math.round(cx * ctx.hauteurTexte / cy); cy = ctx.hauteurTexte; }
    const id = im.n;
    return `<w:p><w:pPr><w:spacing w:before="40" w:after="80"/><w:jc w:val="center"/><w:keepLines/></w:pPr><w:r><w:drawing><wp:inline distT="0" distB="0" distL="0" distR="0"><wp:extent cx="${cx}" cy="${cy}"/><wp:docPr id="${id}" name="Partition ${id}"/><a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main"><a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture"><pic:nvPicPr><pic:cNvPr id="${id}" name="partition${id}.${im.ext}"/><pic:cNvPicPr/></pic:nvPicPr><pic:blipFill><a:blip r:embed="rIdImg${id}"/><a:stretch><a:fillRect/></a:stretch></pic:blipFill><pic:spPr><a:xfrm><a:off x="0" y="0"/><a:ext cx="${cx}" cy="${cy}"/></a:xfrm><a:prstGeom prst="rect"><a:avLst/></a:prstGeom></pic:spPr></pic:pic></a:graphicData></a:graphic></wp:inline></w:drawing></w:r></w:p>`;
  }

  function bloc(el, stParent, paras, ctx) {
    const tag = el.tagName.toLowerCase(), c = el.classList;
    if (tag === "aside" || c.contains("avertissements") || c.contains("avertissement")) return;
    // partitions : les images ; prières psalmiques repliées : omises
    if (tag === "details") {
      if (c.contains("partition-pliee")) { for (const i of el.querySelectorAll("img")) { const x = image(i.getAttribute("src"), ctx); if (x) paras.push(x); } return; }
      if (!el.hasAttribute("open")) return;
      for (const x of el.children) if (x.tagName.toLowerCase() !== "summary") bloc(x, stParent, paras, ctx);
      return;
    }
    if (tag === "figure" || tag === "img") { for (const i of tag === "img" ? [el] : el.querySelectorAll("img")) { const x = image(i.getAttribute("src"), ctx); if (x) paras.push(x); } return; }
    // version latin-français : tableau à deux colonnes (latin | français)
    if (c.contains("bilingue")) {
      const demi = Math.round(ctx.largeurTexte / 635 / 2);           // twips
      const cellule = (col) => {
        const ps = [];
        if (col) for (const x of col.children) bloc(x, stParent, ps, { ...ctx, largeurTexte: Math.round(ctx.largeurTexte / 2) - 60000 });
        return `<w:tc><w:tcPr><w:tcW w:w="${demi}" w:type="dxa"/></w:tcPr>${ps.join("") || "<w:p/>"}</w:tc>`;
      };
      paras.push(`<w:tbl><w:tblPr><w:tblW w:w="${demi * 2}" w:type="dxa"/><w:tblLayout w:type="fixed"/><w:tblCellMar><w:left w:w="60" w:type="dxa"/><w:right w:w="120" w:type="dxa"/></w:tblCellMar></w:tblPr><w:tblGrid><w:gridCol w:w="${demi}"/><w:gridCol w:w="${demi}"/></w:tblGrid><w:tr><w:trPr><w:cantSplit w:val="0"/></w:trPr>${cellule(el.querySelector(":scope > .la"))}${cellule(el.querySelector(":scope > .fr"))}</w:tr></w:tbl>`);
      paras.push(para("", { apres: 40 }));
      return;
    }
    if (c.contains("texte-bilingue")) {
      for (const x of el.children) {
        if (!x.classList.contains("l")) { bloc(x, stParent, paras, ctx); continue; }
        const r = +(([...x.classList].find((k) => /^r\d$/.test(k)) || "r0").slice(1));
        const st = { taille: Math.round(ctx.taille * 0.9) };
        if (x.classList.contains("rubrique-l")) Object.assign(st, { couleur: ROUGE, i: true });
        const so = { cur: "", paras, ctx, coupe() {} };
        inlines(x, st, so);
        paras.push(para(so.cur, { gauche: 240 + r * 240, suspendu: 240, apres: 0 }));
      }
      return;
    }
    if (c.contains("strophe")) {
      const lignes = [...el.children];
      lignes.forEach((l, i) => bloc(l, stParent, paras, { ...ctx, derniereLigne: i === lignes.length - 1 }));
      return;
    }
    if (aBlocs(el)) {
      // texte nu mêlé à des blocs : chaque morceau devient un paragraphe
      for (const x of el.childNodes) {
        if (x.nodeType === 1 && BLOCS.has(x.tagName.toLowerCase())) bloc(x, stParent, paras, ctx);
        else if (x.nodeType === 1 || (x.nodeType === 3 && x.textContent.trim())) {
          const s = { cur: "", paras, ctx, coupe() {} };
          inlines({ childNodes: [x] }, { taille: ctx.taille }, s);
          if (s.cur) paras.push(para(s.cur, { apres: 80 }));
        }
      }
      return;
    }
    const { st, p } = proprietes(el, ctx);
    if (ctx.sautPage) { paras.push('<w:p><w:r><w:br w:type="page"/></w:r></w:p>'); ctx.sautPage = false; }
    const sortie = {
      cur: "", paras, ctx,
      coupe() { if (this.cur) { paras.push(para(this.cur, p)); this.cur = ""; } },
    };
    if (c.contains("antienne")) {
      // « Ant. » en rouge, non italique
      inlines(el, st, sortie);
    } else inlines(el, st, sortie);
    if (sortie.cur) paras.push(para(sortie.cur, p));
  }

  function documentXml(fragments, o) {
    const taille = o.format === "A4" ? 23 : 21;
    const paras = [];
    if (o.titre) {
      paras.push(para(run("ORDRE DES PRÊCHEURS", { police: LEGENDE, taille: Math.round(taille * 0.72), couleur: GRIS, espacement: 40 }), { align: "center", avant: o.format === "A4" ? 4200 : 3000, apres: 160 }));
      paras.push(para(run(o.titre, { police: TITRE, taille: taille + 28, couleur: ROUGE }), { align: "center", apres: 120, filet: true }));
      if (o.sousTitre) paras.push(para(run(o.sousTitre, { taille: taille + 2, i: true }), { align: "center", avant: 160 }));
    }
    const parseur = new DOMParser();
    fragments.forEach((h, i) => {
      const doc = parseur.parseFromString(`<body>${h}</body>`, "text/html");
      const page = o.format === "A4" ? { w: 11906, h: 16838, m: 1134 } : { w: 8391, h: 11906, m: 737 };
      const ctx = { taille, sautPage: !!o.titre || (o.saut !== false && i > 0), images: o.images, largeurTexte: (page.w - 2 * page.m) * 635, hauteurTexte: (page.h - 2 * page.m - 340 - 600) * 635 };
      if (o.saut === false && i > 0) paras.push(para("", { avant: 240 }));
      for (const el of doc.body.children) bloc(el, { taille }, paras, ctx);
    });
    const page = o.format === "A4" ? { w: 11906, h: 16838, m: 1134 } : { w: 8391, h: 11906, m: 737 };
    return `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:document xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"><w:body>${paras.join("")}<w:sectPr><w:footerReference w:type="default" r:id="rIdPied"/><w:pgSz w:w="${page.w}" w:h="${page.h}"/><w:pgMar w:top="${page.m + 110}" w:right="${page.m}" w:bottom="${page.m + 230}" w:left="${page.m}" w:header="400" w:footer="${Math.round(page.m * 0.55)}" w:gutter="0"/>${o.titre ? "<w:titlePg/>" : ""}</w:sectPr></w:body></w:document>`;
  }

  const STYLES = (taille) => `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<w:styles xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:docDefaults><w:rPrDefault><w:rPr><w:rFonts w:ascii="Kepler Std" w:hAnsi="Kepler Std" w:cs="Kepler Std" w:eastAsia="Times New Roman"/><w:sz w:val="${taille}"/><w:szCs w:val="${taille}"/><w:lang w:val="fr-FR"/></w:rPr></w:rPrDefault><w:pPrDefault><w:pPr><w:spacing w:after="0" w:line="252" w:lineRule="auto"/></w:pPr></w:pPrDefault></w:docDefaults><w:style w:type="paragraph" w:default="1" w:styleId="Normal"><w:name w:val="Normal"/><w:qFormat/></w:style></w:styles>`;

  // dimensions d'une image JPEG (marqueur SOF)
  function tailleJpeg(b) {
    for (let i = 2; i < b.length - 9;) {
      if (b[i] !== 0xFF) { i++; continue; }
      const m = b[i + 1], l = (b[i + 2] << 8) | b[i + 3];
      if (m >= 0xC0 && m <= 0xC3) return { h: (b[i + 5] << 8) | b[i + 6], w: (b[i + 7] << 8) | b[i + 8] };
      i += 2 + l;
    }
    return null;
  }

  // dimensions d'une image PNG (en-tête IHDR)
  function taillePng(b) {
    if (b.length < 24 || b[0] !== 0x89 || b[1] !== 0x50 || b[2] !== 0x4E || b[3] !== 0x47) return null;
    const u = (i) => ((b[i] << 24) | (b[i + 1] << 16) | (b[i + 2] << 8) | b[i + 3]) >>> 0;
    return { w: u(16), h: u(20) };
  }

  // Docx.creer est asynchrone : il va chercher les images des partitions citées
  async function creer(fragments, o = {}) {
    const taille = o.format === "A4" ? 23 : 21;
    const images = new Map();
    const srcs = new Set(fragments.flatMap((h) => [...h.matchAll(/<img[^>]+src="([^"]+)"/g)].map((m) => m[1])));
    let n = 0;
    for (const src of srcs) {
      try {
        const r = await fetch(src);
        if (!r.ok) continue;
        const b = new Uint8Array(await r.arrayBuffer());
        const png = taillePng(b), t = png || tailleJpeg(b);
        if (t) images.set(src, { ...t, n: ++n, octets: b, ext: png ? "png" : "jpg", dpi: /\/partitions\/ly\//.test(src) ? 200 : 110 });
      } catch (e) { /* image absente : ignorée */ }
    }
    o = { ...o, images };
    const rels = [...images.values()].map((im) => `<Relationship Id="rIdImg${im.n}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/image" Target="media/partition${im.n}.${im.ext}"/>`).join("");
    return zip([
      ["[Content_Types].xml", `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Default Extension="jpg" ContentType="image/jpeg"/><Default Extension="png" ContentType="image/png"/><Override PartName="/word/document.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.document.main+xml"/><Override PartName="/word/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.styles+xml"/><Override PartName="/word/footer1.xml" ContentType="application/vnd.openxmlformats-officedocument.wordprocessingml.footer+xml"/></Types>`],
      ["_rels/.rels", `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="word/document.xml"/></Relationships>`],
      ["word/_rels/document.xml.rels", `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/><Relationship Id="rIdPied" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/footer" Target="footer1.xml"/>${rels}</Relationships>`],
      ["word/styles.xml", STYLES(taille)],
      // pied de page : numéro de page centré (absent de la page de titre)
      ["word/footer1.xml", `<?xml version="1.0" encoding="UTF-8" standalone="yes"?><w:ftr xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"><w:p><w:pPr><w:jc w:val="center"/></w:pPr><w:r><w:rPr><w:color w:val="555555"/><w:sz w:val="17"/></w:rPr><w:fldChar w:fldCharType="begin"/></w:r><w:r><w:rPr><w:color w:val="555555"/><w:sz w:val="17"/></w:rPr><w:instrText xml:space="preserve"> PAGE </w:instrText></w:r><w:r><w:rPr><w:color w:val="555555"/><w:sz w:val="17"/></w:rPr><w:fldChar w:fldCharType="end"/></w:r></w:p></w:ftr>`],
      ["word/document.xml", documentXml(fragments, o)],
      ...[...images.values()].map((im) => [`word/media/partition${im.n}.${im.ext}`, im.octets]),
    ]);
  }

  g.Docx = { creer };
})(typeof window !== "undefined" ? window : globalThis);
