/* Bénédictions de table (Province de Toulouse).

   Table.pour(j, D) : j = Calendrier.jour(date), D = donnees/table.json.
   Renvoie { midi: { propre, formules, numero, avent, autres }, soir: { dimanche, reste }, apres }.

   Choix (formule de midi = semaine du psautier : confirmé par l'utilisateur le 18/11/2026) :
   - midi : la formule propre de la fête quand le livret en donne une ; sinon, parmi les
     4 formules du jour de la semaine, celle qui porte le numéro de la semaine du psautier
     (I à IV) ; les autres restent proposées ;
   - les formules propres du livret sont « Midi, avant le repas » : le soir, on garde
     les formules de la semaine.
*/
(function (g) {
  "use strict";

  // fêtes du livret reconnues au nom de la célébration du jour (ou d'une mémoire facultative)
  const FETES = [
    ["thomas", /Thomas d.Aquin/], ["joseph", /Joseph, époux/], ["jean-baptiste", /Nativité de saint Jean.?Baptiste/i],
    ["transfiguration", /Transfiguration/], ["dominique", /^(Translation de )?(S\.|Saint) Dominique, prêtre/], ["croix", /Croix glorieuse/],
    ["archanges", /Archanges/], ["francois", /François d.Assise/], ["toussaint", /^Tous les Saints/], ["defunts", /fidèles défunts/],
  ];
  const MARIE = [
    ["mere-de-dieu", /Marie, Mère de Dieu/], ["lourdes", /Lourdes/], ["annonciation", /Annonciation/],
    ["visitation", /Visitation/], ["coeur-immacule", /Cœur immaculé/], ["assomption", /Assomption/],
    ["reine", /Vierge Marie, Reine/], ["nativite-marie", /Nativité de la Vierge/], ["douleurs", /Notre-Dame des Douleurs/],
    ["rosaire", /Rosaire/], ["presentation-marie", /Présentation de la Vierge/], ["immaculee", /Immaculée Conception/],
  ];
  const CLASSES = [["apotres", /\bapôtres?\b/i], ["evangelistes", /évangéliste/i], ["martyrs", /\bmartyr/i]];

  function propreTemporal(j) {
    if (j.source !== "temporal") return null;
    const c = j.cleTemporal || "", n = j.ferie || "";
    if (c === "noel") return "noel";
    if (c === "epiphanie") return "epiphanie";
    if (c === "bapteme") return "bapteme";
    if (c === "careme-0-3") return "cendres";
    if (c === "careme-6-0") return "rameaux";
    if (c === "careme-6-4") return "jeudi-saint";
    if (c === "careme-6-5") return "vendredi-saint";
    if (c === "careme-6-6") return "samedi-saint";
    if (c === "paques-1-0") return "paques";
    if (/^Ascension/.test(n)) return "ascension";
    if (n === "Pentecôte") return "pentecote";
    if (c === "trinite") return "trinite";
    if (c === "sacre-coeur") return "sacre-coeur";
    // Noces de Cana : 2e dimanche du temps ordinaire, année C (même choix que le carnet de Noël)
    if (j.temps === "ordinaire" && j.semaine === 2 && j.jourSemaine === 0 && j.cycle === "C") return "cana";
    return null;
  }

  function propre(j, D) {
    const t = propreTemporal(j);
    if (t) return { ...D.propres[t], cle: t };
    // les mémoires facultatives ne comptent qu'un jour de férie (pas un dimanche ni une fête)
    const noms = [j.nom, ...(j.niveau >= 9 ? (j.facultatives || []).map((f) => f.nom) : [])];
    if (/Présentation du Seigneur/.test(j.nom)) return { ...D.propres.presentation, cle: "presentation" };
    for (const [cle, re] of FETES) if (noms.some((n) => re.test(n))) return { ...D.propres[cle], cle };
    for (const [cle, re] of MARIE)
      if (noms.some((n) => re.test(n))) {
        const texte = D.marie.texte.map((l) => l.replace("(x)", D.marie.x[cle]));
        return { titre: "Bienheureuse Vierge Marie", texte, cle: "marie-" + cle };
      }
    // apôtres, évangélistes, martyrs : seulement la célébration du jour (mémoire obligatoire ou plus)
    if (j.source !== "temporal" && j.niveau <= 11)
      for (const [cle, re] of CLASSES) if (re.test(j.nom)) return { ...D.propres[cle], cle };
    return null;
  }

  function pour(j, D) {
    const js = String(j.jourSemaine);
    const numero = Math.min(Math.max(j.psautier || 1, 1), 4);
    const reste = D.soir.reste;
    return {
      midi: {
        propre: propre(j, D),
        formules: D.semaine.midi[js],
        numero,
        avent: j.temps === "avent" ? D.avent : null,
        autres: D.autres,
      },
      soir: {
        dimanche: j.jourSemaine === 0 ? D.soir.dimanche : null,
        reste: [...reste.intro, reste.jours[js], "R/ Amen."],
      },
      apres: D.apres,
    };
  }

  // ── rendu HTML (texte sûr : tout passe par esc)
  const esc = (s) => String(s).replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));
  const ROMAIN = ["", "I", "II", "III", "IV", "V"];

  function texte(lignes) {
    return `<p class="formule">${lignes.map((l) => /^R\//.test(l)
      ? `<span class="repons"><span class="rouge">R/</span> ${esc(l.replace(/^R\/\s*/, ""))}</span>`
      : esc(l)).join("<br>")}</p>`;
  }

  function rendu(j, D) {
    const b = pour(j, D), m = b.midi;
    const nomJour = j.nomJour.charAt(0).toUpperCase() + j.nomJour.slice(1);
    let h = "";
    // Midi
    h += `<section class="repas"><h2>Midi <span>avant le repas</span></h2>`;
    const autres = [];
    if (m.propre) {
      h += `<p class="intitule">${esc(m.propre.titre.replace(/^[^–-]*\d[^–-]*[–-]\s*/, ""))}</p>` + texte(m.propre.texte);
      m.formules.forEach((f, i) => autres.push([`${nomJour}, formule ${ROMAIN[i + 1]}`, f]));
    } else {
      h += `<p class="intitule">${esc(nomJour)} — formule ${ROMAIN[m.numero]}</p>` + texte(m.formules[m.numero - 1]);
      m.formules.forEach((f, i) => { if (i !== m.numero - 1) autres.push([`${nomJour}, formule ${ROMAIN[i + 1]}`, f]); });
    }
    // en Avent, la prière du temps est proposée en clair les jours sans formule propre
    if (m.avent && !m.propre) h += `<p class="intitule">Ou bien, au temps de l'Avent</p>` + texte(m.avent);
    else if (m.avent) autres.push(["Au temps de l'Avent", m.avent]);
    m.autres.forEach((f, i) => autres.push([`Pendant l'année, ${i + 1}`, f]));
    h += `<details class="autres"><summary>Autres formules (${autres.length})</summary>`
      + autres.map(([t, f]) => `<p class="intitule">${esc(t)}</p>` + texte(f)).join("") + `</details></section>`;
    // Soir
    h += `<section class="repas"><h2>Soir <span>avant le repas</span></h2>`;
    if (b.soir.dimanche) h += texte(b.soir.dimanche) + `<p class="intitule">Ou bien</p>`;
    h += texte(b.soir.reste) + `</section>`;
    // Après
    h += `<section class="repas"><h2>Après le repas <span>midi et soir</span></h2>` + texte(b.apres) + `</section>`;
    return h;
  }

  g.Table = { pour, rendu, propre };
  if (typeof module !== "undefined") module.exports = g.Table;
})(typeof window !== "undefined" ? window : globalThis);
