/* Propre de l'Ordre des Prêcheurs (donnees/missel_op.json, construit par outils/construire_missel_op.py depuis le Missel
   et le Lectionnaire de l'Ordre, édition provisoire de juin 2026).

   PropreOP.charger(d)            données du Missel de l'Ordre
   PropreOP.saint(j)              messe du Missel de l'Ordre qui correspond à la célébration du jour (ou null)
   PropreOP.priere(j)             { paras: [[lignes]], alternatives: [[[lignes]]], titre } : la PRIÈRE (collecte) du saint
   PropreOP.html(paras)           texte du Missel → HTML (rubriques « § » en rouge, V/ R/)
   PropreOP.vueCalendrier(iso)    le calendrier de l'Ordre (bouton « Calendrier OP » des offices) → { titre, html, sommaire }
   PropreOP.chargerOffices(d)     propre de l'Ordre des carnets du sanctoral (donnees/offices_op.json, outils/offices_op.py)
   PropreOP.carnet(j, office)     { cle, fete, o, jour, premieres } : l'office du carnet pour ce jour (laudes, vêpres, lectures)
*/
(function (g) {
  "use strict";
  let D = null;
  const esc = (s) => String(s ?? "").replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));
  const norm = (s) => String(s || "").normalize("NFD").replace(/[̀-ͯ]/g, "").toLowerCase();
  const VIDES = new Set(["saint", "sainte", "saints", "bienheureux", "bienheureuse", "pretre", "pretres", "vierge", "vierges", "martyr", "martyrs",
    "eveque", "leurs", "compagnons", "religieux", "religieuse", "docteur", "eglise", "notre", "pere", "pape", "diacre", "famille"]);
  const mots = (s) => new Set(norm(s).split(/[^a-z]+/).filter((w) => w.length > 3 && !VIDES.has(w)));
  const communs = (a, b) => { const B = mots(b); let n = 0; for (const w of mots(a)) if (B.has(w)) n++; return n; };
  const MOIS = ["janvier", "février", "mars", "avril", "mai", "juin", "juillet", "août", "septembre", "octobre", "novembre", "décembre"];
  const RANG_COURT = { "solennité": "Solennité", "fête": "Fête", "mémoire": "Mémoire obligatoire", "mémoire facultative": "Mémoire facultative" };

  function charger(d) { D = d; return d; }

  // la messe de l'Ordre de la célébration du jour : même date, le plus de mots en commun avec le nom du jour
  function saint(j) {
    if (!D || !j || j.source === "temporal") return null;
    const liste = (D.saints || {})[j.date.slice(5)] || [];
    let mieux = null, score = 0;
    for (const e of liste) { const s = communs(e.titre, j.nom); if (s > score) { score = s; mieux = e; } }
    if (!mieux && j.source === "op" && liste.length === 1) mieux = liste[0];
    return mieux;
  }
  // la prière (collecte) : la première, puis les autres proposées par le Missel (« Ou bien »)
  function priere(j) {
    const e = saint(j);
    const p = e && e.messes && e.messes[0] && e.messes[0].priere;
    if (!p) return null;
    return { ...couper(p.texte), titre: e.titre };
  }
  function couper(texte) {
    const groupes = [[]];
    for (const para of texte) {
      if (para.length === 1 && /^Ou bien/.test(para[0])) { groupes.push([]); continue; }
      groupes[groupes.length - 1].push(para);
    }
    const g2 = groupes.filter((x) => x.length);
    return { paras: g2[0] || [], alternatives: g2.slice(1) };
  }
  const RV = (l) => esc(l).replace(/(^|\s)([RV])\/(\s|$)/g, '$1<span class="rv">$2/</span>$3');
  function html(paras) {
    return (paras || []).map((p) => {
      if (p.length === 1 && p[0].startsWith("§")) return `<p class="rubrique">${esc(p[0].slice(1))}</p>`;
      if (p.length === 1 && /^Ou bien/.test(p[0])) return `<p class="ou-bien">ou bien${p[0].includes("—") ? ` <span class="ref">${esc(p[0].split("—")[1].trim())}</span>` : ""}</p>`;
      return `<p>${p.map(RV).join("<br>")}</p>`;
    }).join("");
  }

  // ── Calendrier de l'Ordre : tous les saints, par mois ; le degré ; la prière (repliée) quand le Missel en donne une
  function vueCalendrier(iso) {
    if (!D) return { titre: "Calendrier de l’Ordre", html: `<p class="manque">Le Missel de l’Ordre n’a pas pu être chargé.</p>`, sommaire: [] };
    const auj = (iso || "").slice(5);
    const parMois = MOIS.map(() => []);
    for (const c of D.calendrier || []) parMois[+c.mmjj.slice(0, 2) - 1].push(c);
    const deMissel = (c) => {
      const liste = (D.saints || {})[c.mmjj] || [];
      let m = null, s = 0;
      for (const e of liste) { const x = communs(e.titre, c.nom); if (x > s) { s = x; m = e; } }
      return m;
    };
    const ligne = (c) => {
      const [mm, jj] = c.mmjj.split("-").map(Number);
      const e = deMissel(c);
      const pr = e && e.messes && e.messes[0] && e.messes[0].priere ? couper(e.messes[0].priere.texte) : null;
      const rang = RANG_COURT[c.rang] || (c.rang ? c.rang.charAt(0).toUpperCase() + c.rang.slice(1) : "");
      const prov = (c.provinces || []).map((p) => `<span class="province">${esc(p.province)} : ${esc(RANG_COURT[p.rang] || p.rang)}</span>`).join("");
      const corps = pr ? `<details class="priere-op"><summary>Prière</summary>${html(pr.paras)}${pr.alternatives.map((a) => `<p class="ou-bien">ou bien</p>${html(a)}`).join("")}`
        + (e.notice ? `<details class="notice-op"><summary>Notice</summary><p>${esc(e.notice).replace(/\n/g, "</p><p>")}</p></details>` : "") + `</details>` : "";
      return `<li class="cal-op${c.martyrologe ? " martyrologe" : ""}${c.mmjj === auj ? " aujourdhui" : ""}${c.romain ? " romain" : ""}" id="op-${c.mmjj}">`
        + `<span class="date">${jj === 1 ? "1er" : jj}</span><span class="nom">${esc(c.nom)}${c.romain ? ` <span class="note-romain">(calendrier romain ; éléments propres à l’Ordre)</span>` : ""}</span>`
        + `<span class="rang">${esc(rang)}</span>${prov ? `<span class="provinces">${prov}</span>` : ""}${corps}</li>`;
    };
    const h = `<header class="entete-office entete-missel"><p class="date-longue">Ordre des Prêcheurs</p><h2>Calendrier de l’Ordre</h2>`
      + `<p class="celebration">Saints, saintes, bienheureux et bienheureuses de l’Ordre</p></header>`
      + `<p class="note intro-cal-op">Calendrier particulier de l’Ordre des Prêcheurs (2019), avec le degré de chaque célébration. En italique : les autres inscrits au martyrologe de l’Ordre, dont la mémoire peut être choisie pour une raison particulière (PGLH 234-235, 244-248). Entre parenthèses, les degrés propres à une province. « Prière » : l’oraison du Missel de l’Ordre.</p>`
      + parMois.map((l, i) => l.length ? `<section class="mois-op" id="mois-op-${i + 1}"><h3 class="titre-groupe">${MOIS[i].charAt(0).toUpperCase() + MOIS[i].slice(1)}</h3><ol class="liste-cal-op">${l.map(ligne).join("")}</ol></section>` : "").join("")
      + `<p class="notes-messe">${esc(D.source || "")}.</p>`;
    const sommaire = parMois.map((l, i) => l.length ? { href: `#mois-op-${i + 1}`, titre: MOIS[i].charAt(0).toUpperCase() + MOIS[i].slice(1), ancre: true } : null).filter(Boolean);
    return { titre: "Calendrier de l’Ordre des Prêcheurs", html: h, sommaire };
  }

  // ── Propre de l'Ordre dans les carnets du sanctoral de la Province (donnees/offices_op.json, outils/offices_op.py) :
  //    hymnes, psaumes, antiennes (texte et partition), répons de chaque fête de l'Ordre que les carnets donnent
  let O = null;
  function chargerOffices(d) { O = d; return d; }
  // clé du carnet si le jour célèbre une fête de l'Ordre que le carnet donne (fête de l'Ordre, ou saint du calendrier
  // romain que l'Ordre célèbre avec son propre : sainte Catherine de Sienne)
  function celebre(j) {
    if (!O || !j || j.source === "temporal") return null;
    const k = String(j.cleSanctoral || "").replace(/^(op|sanctoral)-/, "");
    const e = k && O[k];
    return e && (j.source === "op" || communs(e.nom, j.nom) > 0) ? k : null;
  }
  // office du carnet : { cle, fete, o, jour (la célébration), premieres } ou null ; aux vêpres, celles du jour,
  // ou les premières vêpres d'une solennité du lendemain (saint Dominique)
  function carnet(j, office, optsJour = {}) {
    if (!O || !g.Calendrier || !["laudes", "vepres", "lectures"].includes(office)) return null;
    const C = g.Calendrier;
    if (office === "vepres") {
      const n = C.jour(C.iso(C.plus(C.deIso(j.date), 1)), optsJour);
      const kn = celebre(n);
      if (kn && O[kn].offices.vepres1 && n.niveau <= 4 && n.niveau < j.niveau) return { cle: kn, fete: O[kn], o: O[kn].offices.vepres1, jour: n, premieres: true };
      if (n.jourSemaine === 0 && j.niveau > 4) return null;          // samedi soir : premières vêpres du dimanche
      if (n.niveau <= 4 && n.niveau < j.niveau) return null;          // veille d'une solennité
    }
    const k = celebre(j);
    const o = k && O[k].offices[office];
    return o ? { cle: k, fete: O[k], o, jour: j, premieres: false } : null;
  }

  g.PropreOP = { charger, saint, priere, couper, html, vueCalendrier, chargerOffices, carnet, get donnees() { return D; }, get offices() { return O; } };
  if (typeof module !== "undefined") module.exports = g.PropreOP;
})(typeof window !== "undefined" ? window : globalThis);
