/* Interface de la page des offices (site/index.html) : barre (date, office, export), réglages, affichage.

   Place dans l'ensemble : c'est le dernier maillon. Au démarrage, il charge les données (site/donnees/*.json,
   partitions/…) et les confie aux modules (Calendrier, Gouzes, Milieu, PropreOP, Capitules, Bouchet…) ; puis,
   pour chaque date et office, il demande le HTML à Offices.construire (offices.js) et l'affiche.
   Il produit aussi les exports : PDF (impression du navigateur ; page de titre et @page injectés ici, mise
   en page dans css/impression.css) et Word (docx.js) ; et lance l'enregistrement hors connexion (horsligne.js).
   Réglages : gardés sur l'appareil (localStorage « breviaire-pref ») ; la « version » choisie (VERSIONS)
   est l'une de : aelf | romaine | province (romain gouzantin) | sainte-baume | gouzantine | latin.
   Adresses : #AAAA-MM-JJ/office (lien partageable) ; ?imprimer=AAAA-MM-JJ..AAAA-MM-JJ&offices=…&format=A5
   (export sans passer par l'écran, utilisé par les outils de contrôle). Notice des réglages :
   docs/MODE-D-EMPLOI-REGLAGES.md. */
(function () {
  "use strict";
  const $ = (s) => document.querySelector(s);
  const $$ = (s) => [...document.querySelectorAll(s)];
  const iso = (d) => `${d.getFullYear()}-${String(d.getMonth() + 1).padStart(2, "0")}-${String(d.getDate()).padStart(2, "0")}`;
  const decaler = (s, n) => { const d = new Date(s + "T12:00:00"); d.setDate(d.getDate() + n); return iso(d); };

  // ── Préférences (mémorisées sur cet appareil seulement)
  const DEFAUT = { propreOP: true, repartition: "romaine", invitatoire: true, prieres: false, taille: 18, theme: "auto", partitions: true, partitionsOuvertes: false, capitules: true, oraison: "liturgique", heure: "sexte", choix: {}, lecture2: "aelf", communs: {}, psaumesCarnet: {} };
  let pref = { ...DEFAUT };
  try { pref = { ...DEFAUT, ...JSON.parse(localStorage.getItem("breviaire-pref") || "{}") }; } catch (e) { /* rien */ }
  if (pref.repartition === "romaine-gouzes") pref.partitions = true;   // romain gouzantin : une seule version, partitions repliées (20/11/2026)
  const sauver = () => { try { localStorage.setItem("breviaire-pref", JSON.stringify(pref)); } catch (e) { /* rien */ } };

  function appliquerAffichage() {
    document.documentElement.style.setProperty("--taille", pref.taille + "px");
    if (pref.theme === "auto") document.documentElement.removeAttribute("data-theme");
    else document.documentElement.setAttribute("data-theme", pref.theme);
  }

  // ── Office par défaut selon l'heure
  function officeDuMoment() {
    const h = new Date().getHours();
    return h < 5 ? "lectures" : h < 11 ? "laudes" : h < 15 ? "milieu" : h < 20 ? "vepres" : "complies";
  }

  // ── État depuis l'adresse (#2026-11-10/vepres), pour pouvoir partager un lien
  function lireAdresse() {
    const m = /^#(\d{4}-\d{2}-\d{2})(?:\/(\w+))?/.exec(location.hash);
    return { date: m ? m[1] : iso(new Date()), office: m && m[2] && Offices.OFFICES[m[2]] ? m[2] : officeDuMoment() };
  }
  let etat = lireAdresse();
  // recueil des communs (bouton « Communs », comme le « Missel » de la Messe) : #communs, #communs/<id>
  // calendrier de l'Ordre (bouton « Calendrier OP », à gauche de « Communs ») : #calendrier-op
  const routeCalOP = () => /^#calendrier-op$/.test(location.hash);
  function afficherCalOP() {
    const v = PropreOP.vueCalendrier(etat.date);
    document.body.classList.add("mode-communs", "mode-cal-op");
    $("#ouvrir-cal-op").setAttribute("aria-pressed", "true");
    document.title = v.titre;
    $("#office").innerHTML = v.html;
    $("#sommaire").innerHTML = v.sommaire.map((x) => `<a href="${x.href}" data-ancre>${Textes.esc(x.titre)}</a>`).join("")
      + `<a class="retour-jour" href="#${etat.date}/${etat.office}">‹ Office du jour</a>`;
    document.querySelectorAll("#sommaire a[data-ancre]").forEach((a) => a.onclick = (e) => { e.preventDefault(); document.getElementById(a.getAttribute("href").slice(1))?.scrollIntoView({ behavior: "smooth" }); });
    const auj = document.querySelector("li.cal-op.aujourdhui") || [...document.querySelectorAll("li.cal-op")].find((li) => li.id.slice(3) >= etat.date.slice(5));
    if (auj) auj.scrollIntoView({ block: "center" }); else window.scrollTo(0, 0);
  }
  const routeCommuns = () => { const m = /^#communs(?:\/([\w-]+))?$/.exec(location.hash); return m ? m[1] || "" : null; };
  let communsVue = routeCommuns();
  function afficherCommuns() {
    const j = Calendrier.jour(etat.date, { propreOP: pref.propreOP, choix: (pref.choix || {})[etat.date] });
    const choisi = Offices.communDuJour(j, options());
    const v = Communs.vue(communsVue, j, choisi);
    document.body.classList.add("mode-communs");
    $("#ouvrir-communs").setAttribute("aria-pressed", "true");
    document.title = v.titre;
    $("#office").innerHTML = v.html;
    $("#sommaire").innerHTML = v.sommaire.map((x) => `<a href="${x.href}"${x.actif ? ' aria-current="page"' : ""}>${Textes.esc(x.titre)}</a>`).join("")
      + `<a class="retour-jour" href="#${etat.date}/${etat.office}">‹ Office du jour</a>`;
    const f = document.querySelector("form.choisir-commun");
    if (f) {
      const fini = () => { sauver(); location.hash = `#${etat.date}/${etat.office}`; };
      f.onsubmit = (e) => {
        e.preventDefault();
        pref.communs = { ...(pref.communs || {}), [etat.date]: { id: f.dataset.commun, pour: f.pour?.value || null, psaumes: f.psaumes.value, ...(f.lieu ? { lieu: f.lieu.value } : {}) } };
        fini();
      };
      const r = f.querySelector("[data-retirer]");
      if (r) r.onclick = () => {
        const c = { ...(pref.communs || {}) };
        delete c[etat.date];
        // un commun appliqué d'office (fête de l'Ordre) se refuse par « aucun »
        if (Offices.communDuJour(j, { ...options(), communs: c })) c[etat.date] = "aucun";
        pref.communs = c; fini();
      };
    }
    window.scrollTo(0, 0);
  }

  // version : romaine | province (romain gouzantin, partitions repliées) | gouzantine (avec partitions) ;
  // « province-partitions » (ancien choix, fusionné le 20/11/2026) = province
  const VERSIONS = { aelf: ["aelf", false], romaine: ["romaine", false], province: ["romaine-gouzes", true], "province-partitions": ["romaine-gouzes", true], "sainte-baume": ["sainte-baume", true], gouzantine: ["gouzantine", true], latin: ["latin", true] };
  const versionDe = (p) => (p.repartition === "aelf" ? "aelf" : p.repartition === "latin" ? "latin" : p.repartition === "gouzantine" ? "gouzantine" : p.repartition === "sainte-baume" ? "sainte-baume" : p.repartition === "romaine-gouzes" ? "province" : "romaine");
  function appliquerVersion(v) { const x = VERSIONS[v] || VERSIONS.romaine; pref.repartition = x[0]; pref.partitions = x[1]; }
  function options() {
    if (window.Partitions) Partitions.ouvertes = !!pref.partitionsOuvertes;
    return { propreOP: pref.propreOP, repartition: pref.repartition, invitatoire: pref.invitatoire, prieres: pref.prieres,
      partitions: pref.partitions, partitionsOuvertes: pref.partitionsOuvertes, capitules: pref.capitules, oraison: pref.oraison || "liturgique", heure: pref.heure || "sexte", choix: pref.choix || {}, communs: pref.communs || {}, psaumesCarnet: pref.psaumesCarnet || {} };
  }

  let jeton = 0;
  async function afficher() {
    const t = ++jeton;
    $("#date").value = etat.date;
    if (routeCalOP() && window.PropreOP?.donnees) return afficherCalOP();
    if (communsVue !== null) return afficherCommuns();
    $$("#onglets button").forEach((b) => b.setAttribute("aria-current", b.dataset.office === etat.office ? "page" : "false"));
    const cible = `#${etat.date}/${etat.office}`;
    if (location.hash !== cible) history.replaceState(null, "", cible);
    $("#office").innerHTML = '<p class="chargement">Chargement de l\'office…</p>';
    try {
      const r = await Offices.construire(etat.date, etat.office, options());
      if (t !== jeton) return;
      $("#office").innerHTML = r.html;
      document.title = `${r.titre} — ${r.jour.dateLongue}`;
      sommaire();
      if (window.Signaler) Signaler.decorer($("#office"), { date: etat.date, office: etat.office, version: versionDe(pref), titre: document.title, options: options(),
        cle: window.Partitions && Partitions.cleJour ? (() => { try { return `${Partitions.cleJour(r.jour)}|${etat.office}`; } catch (e) { return ""; } })() : "" });
    } catch (e) {
      if (t !== jeton) return;
      console.error(e);
      $("#office").innerHTML = `<p class="avertissement">Impossible de préparer l'office : ${Textes.esc(e.message)}.<br>${navigator.onLine === false ? "Vous êtes hors connexion et cet office n'a pas été enregistré sur cet appareil (Réglages, « Hors connexion »)." : "Vérifiez la connexion internet (les textes propres viennent de l'AELF)."}</p>`;
    }
  }

  function sommaire() {
    const liens = $$("#office section.bloc > h3").map((h, i) => {
      h.id = "s" + i;
      const t = [...h.childNodes].filter((n) => !(n.classList && n.classList.contains("provenance"))).map((n) => n.textContent).join("");
      return `<a href="#s${i}" data-cible="s${i}">${Textes.esc(t.replace(/ :.*/, ""))}</a>`;
    });
    $("#sommaire").innerHTML = liens.join("");
    $$("#sommaire a").forEach((a) => a.addEventListener("click", (e) => { e.preventDefault(); document.getElementById(a.dataset.cible).scrollIntoView({ behavior: "smooth" }); }));
  }

  // ── Production d'un PDF (via l'impression du navigateur)
  async function produirePdf(debut, fin, offices, format, saut, imprimer = true, sortie = "pdf", avecPartitions = false) {
    const prog = $("#pdf-progres"), etatTxt = $("#pdf-etat");
    const jours = [];
    for (let d = debut; d <= fin; d = decaler(d, 1)) jours.push(d);
    if (jours.length > 400) throw new Error("période trop longue (400 jours au plus par fichier)");
    const total = jours.length * offices.length;
    prog.hidden = false; prog.max = total; prog.value = 0;
    const morceaux = new Array(total);
    let fait = 0;
    await Promise.all(jours.flatMap((d, i) => offices.map(async (o, k) => {
      const opt = options();
      if (window.Partitions) Partitions.ouvertes = !!avecPartitions;     // à l'impression, partitions dépliées
      const r = await Offices.construire(d, o, { ...opt, impression: true, lecture2: pref.lecture2 === "bouchet" ? "bouchet" : "aelf", ...(avecPartitions ? { partitions: true, partitionsOuvertes: true } : { partitions: false }) });
      morceaux[i * offices.length + k] = r.html;
      prog.value = ++fait;
      etatTxt.textContent = `${fait} / ${total} offices préparés`;
    })));
    if (sortie === "docx") {
      const titre = "Liturgie des Heures";
      const sousTitre = debut === fin ? Calendrier.jour(debut).dateLongue : `${Calendrier.jour(debut).dateLongue} — ${Calendrier.jour(fin).dateLongue}`;
      etatTxt.textContent = "Préparation du fichier Word (partitions comprises)…";
      const blob = await Docx.creer(morceaux, { format, titre, sousTitre, saut });
      etatTxt.textContent = `${total} offices prêts : fichier Word créé.`;
      if (!imprimer) {   // contrôle automatique : le fichier est laissé dans la page
        const b = new Uint8Array(await blob.arrayBuffer());
        let bin = ""; for (let i = 0; i < b.length; i += 0x8000) bin += String.fromCharCode.apply(null, b.subarray(i, i + 0x8000));
        window.__docx = btoa(bin);
        document.body.dataset.pret = "1";
        return;
      }
      const a = document.createElement("a");
      a.href = URL.createObjectURL(blob);
      a.download = `Offices du ${debut}${fin !== debut ? " au " + fin : ""}.docx`;
      document.body.appendChild(a); a.click(); a.remove();
      setTimeout(() => URL.revokeObjectURL(a.href), 10000);
      return;
    }
    const zone = $("#impression");
    zone.className = `impression format-${format}${saut ? " saut" : ""}`;
    const periode = debut === fin ? Calendrier.jour(debut).dateLongue : Calendrier.jour(debut).dateLongue + " — " + Calendrier.jour(fin).dateLongue;
    const nomsOffices = offices.map((o) => Offices.OFFICES[o]).join(" · ");
    // page de titre : titre, filet, période, offices contenus
    zone.innerHTML = `<div class="page-titre"><p class="surtitre">Ordre des Prêcheurs</p><h1>Liturgie des Heures</h1><hr><p class="periode">${Textes.esc(periode)}</p><p class="contenu-livret">${Textes.esc(nomsOffices)}</p></div>` + morceaux.join("");
    let st = document.getElementById("style-page");
    if (!st) { st = document.createElement("style"); st.id = "style-page"; document.head.appendChild(st); }
    // marges de livret, titre courant en tête, numéro de page en pied (rien sur la page de titre)
    const css = (t) => t.replace(/\\/g, "\\\\").replace(/"/g, '\\"');
    const marges = format === "A5" ? "size: A5; margin: 15mm 13mm 16mm;" : "size: A4; margin: 22mm 22mm 22mm;";
    st.textContent = `@page { ${marges}
      @top-center { content: "${css("Liturgie des Heures — " + periode)}"; font: 600 7pt/1 "Kepler Legende", Georgia, serif; letter-spacing: .1em; text-transform: uppercase; color: #888; }
      @bottom-center { content: counter(page); font: 8.5pt/1 "Kepler Legende", Georgia, serif; color: #555; } }
      @page :first { @top-center { content: none; } @bottom-center { content: none; } }`;
    document.body.classList.add("mode-impression");
    etatTxt.textContent = `${total} offices prêts.`;
    document.body.dataset.pret = "1";
    if (!imprimer) return;
    await new Promise((r) => setTimeout(r, 300));
    window.print();
  }

  // Lien direct : ?imprimer=2026-12-01..2026-12-31&offices=laudes,vepres&format=A5
  // (ajouter &apercu pour afficher sans ouvrir la fenêtre d'impression)
  async function impressionParAdresse() {
    const q = new URLSearchParams(location.search);
    const m = /^(\d{4}-\d{2}-\d{2})(?:\.\.(\d{4}-\d{2}-\d{2}))?$/.exec(q.get("imprimer") || "");
    if (!m) return false;
    const offices = (q.get("offices") || "laudes,vepres,complies").split(",").filter((o) => Offices.OFFICES[o]);
    if (q.has("repartition")) pref.repartition = q.get("repartition");
    if (q.has("version")) appliquerVersion(q.get("version"));
    if (q.has("op")) pref.propreOP = q.get("op") !== "0";
    if (q.has("heure")) pref.heure = q.get("heure");
    if (q.has("lecture2")) pref.lecture2 = q.get("lecture2") === "bouchet" ? "bouchet" : "aelf";
    // &commun=pasteurs[:un évêque][:ferie] : ce commun pour tous les jours de la période
    if (q.has("commun")) {
      const [id, pour, ps] = q.get("commun").split(":");
      pref.communs = {};
      for (let d = m[1]; d <= (m[2] || m[1]); d = decaler(d, 1)) pref.communs[d] = { id, pour: pour || null, psaumes: ps === "ferie" ? "ferie" : "commun" };
    }
    await produirePdf(m[1], m[2] || m[1], offices, q.get("format") === "A4" ? "A4" : "A5", q.get("saut") !== "0", !q.has("apercu"), q.get("sortie") === "docx" ? "docx" : "pdf", q.has("version") && q.get("version") !== "province" ? pref.partitions : q.has("partitions"));   // version=province : PDF sans partitions sauf &partitions (comme avant la fusion)
    return true;
  }
  window.addEventListener("afterprint", () => document.body.classList.remove("mode-impression"));

  // ── Hors connexion : enregistrer les offices d'une période sur l'appareil (réglages)
  function horsLigne() {
    if (!window.HorsLigne || !HorsLigne.disponible) return;
    HorsLigne.installer();
    $("#bloc-horsligne").hidden = false;
    const txt = $("#hl-etat"), prog = $("#hl-progres");
    const jourCourt = (s) => new Date(s + "T12:00:00").toLocaleDateString("fr-FR", { day: "numeric", month: "long", year: "numeric" });
    const NOMS = { aelf: "100 % AELF", romaine: "romaine", province: "romain gouzantin", "province-partitions": "romain gouzantin", "sainte-baume": "Sainte-Baume", gouzantine: "gouzantine", latin: "latin-français" };
    async function bilan(avant = "") {
      const e = HorsLigne.etat(), mo = await HorsLigne.occupation();
      let t = e ? `Enregistré : du ${jourCourt(e.debut)} au ${jourCourt(e.fin)}, version ${NOMS[e.version] || e.version} (${e.offices} offices${e.images ? `, ${e.images} partitions` : ""}).` : "Rien n'est enregistré pour l'instant.";
      if (e && (e.manques?.length || e.echecsImages || e.echecsFichiers)) t += ` Non enregistrés : ${e.manques?.length || 0} office(s), ${e.echecsImages || 0} partition(s), ${e.echecsFichiers || 0} fichier(s) — relancez l'enregistrement avec une bonne connexion.`;
      if (mo != null) t += ` Place occupée sur l'appareil : ${mo} Mo.`;
      txt.textContent = avant + t;
    }
    const periode = () => {
      const v = $("input[name=hl-duree]:checked").value, auj = HorsLigne.aujourdhui();
      return v === "periode" ? [$("#hl-debut").value, $("#hl-fin").value] : [auj, HorsLigne.decaler(auj, +v - 1)];
    };
    $$("input[name=hl-duree]").forEach((r) => r.addEventListener("change", () => {
      const p = $("input[name=hl-duree]:checked").value === "periode";
      $("#hl-periode").hidden = !p;
      if (p && !$("#hl-debut").value) { $("#hl-debut").value = HorsLigne.aujourdhui(); $("#hl-fin").value = HorsLigne.decaler(HorsLigne.aujourdhui(), 29); }
    }));
    $("#hl-lancer").addEventListener("click", async () => {
      const [debut, fin] = periode();
      if (!debut || !fin || fin < debut) { txt.textContent = "Vérifiez les dates."; return; }
      if (navigator.onLine === false) { txt.textContent = "Il faut être connecté à internet pour enregistrer."; return; }
      $("#hl-lancer").disabled = $("#hl-effacer").disabled = true; prog.hidden = false;
      try {
        await HorsLigne.enregistrer(debut, fin, Object.keys(Offices.OFFICES), options(), versionDe(pref), (fait, total, quoi) => { prog.max = total || 1; prog.value = fait; txt.textContent = quoi; });
        await bilan();
      } catch (err) { txt.textContent = "Erreur : " + err.message; }
      finally { $("#hl-lancer").disabled = $("#hl-effacer").disabled = false; prog.hidden = true; }
    });
    $("#hl-effacer").addEventListener("click", async () => { await HorsLigne.effacer(); await bilan("Effacé. "); });
    $("#ouvrir-reglages").addEventListener("click", () => bilan());
  }

  // ── Commun des saints : menus « Commun : » de l'en-tête de l'office (offices.js, ligneCommun), retenus par date
  //    dans pref.communs[date] = { id, pour, psaumes, lieu } ou "aucun" (refus du commun appliqué d'office)
  function changerCommun(sel) {
    const date = sel.dataset.communDate, ligne = sel.closest(".choix-commun");
    const val = (champ) => ligne.querySelector(`select[data-champ=${champ}]`)?.value;
    const c = { ...(pref.communs || {}) };
    if (sel.dataset.champ === "id") {
      if (!sel.value) c[date] = "aucun";
      else {
        const j = Calendrier.jour(date, { propreOP: pref.propreOP, choix: (pref.choix || {})[date] });
        const sug = { id: ligne.dataset.suggere, pour: ligne.dataset.suggerePour || null };
        c[date] = { id: sel.value, pour: sel.value === sug.id ? sug.pour : null, psaumes: j.niveau <= 8 ? "commun" : "ferie" };
      }
    } else c[date] = { id: val("id"), pour: val("pour") || null, psaumes: val("psaumes") || "commun", ...(val("lieu") ? { lieu: val("lieu") } : {}) };
    pref.communs = c; sauver(); afficher();
  }

  // ── Branchements
  async function demarrer() {
    appliquerAffichage();
    const [psautier, sanctoral, propreOP, gouz] = await Promise.all([
      Psautier.charger("donnees/psautier.json"),
      fetch("donnees/sanctoral.json", { cache: "no-cache" }).then((r) => r.json()),
      fetch("donnees/propre_op.json", { cache: "no-cache" }).then((r) => r.json()),
      fetch("donnees/gouzes.json", { cache: "no-cache" }).then((r) => r.json()).catch(() => null),
    ]);
    Calendrier.charger(sanctoral, propreOP);
    if (gouz) Gouzes.charger(gouz);
    const donnee = (f, fn) => fetch(`donnees/${f}.json`, { cache: "no-cache" }).then((r) => r.json()).then(fn).catch(() => {});
    await Promise.all([
      donnee("milieu", (x) => Milieu.charger(x)),
      donnee("missel_op", (x) => window.PropreOP && PropreOP.charger(x)),
      donnee("offices_op", (x) => window.PropreOP?.chargerOffices && PropreOP.chargerOffices(x)),   // propre de l'Ordre des carnets du sanctoral
      donnee("jours_saints", (x) => Offices.chargerJoursSaints(x)),
      donnee("complies", (x) => Offices.chargerComplies(x)),
      donnee("president", (x) => Offices.chargerPresident(x)),
      donnee("capitules", (x) => Capitules.charger(x)),
      donnee("bouchet", (x) => window.Bouchet && Bouchet.charger(x)),
      donnee("province", (x) => Gouzes.chargerProvince(x)),
      // livrets de Sainte-Baume : version « Sainte-Baume », textes d'antiennes par cote, canon avec le gras des inflexions
      donnee("sainte_baume", (x) => { if (!window.SainteBaume) return; SainteBaume.charger(x); Gouzes.ajouterCotes(x.cotes); Gouzes.remplacerCanon(x.careme?.canon?.jours); }),
    ]);
    // partitions présentes (ordinateur de la communauté, ou site publié avec elles) : version « avec partitions »
    if (await Partitions.charger()) { $("#bloc-partitions").hidden = false; $("#pdf-bloc-partitions").hidden = false; if (window.SainteBaume?.donnees && $("#version-sainte-baume")) $("#version-sainte-baume").hidden = false; }
    if (window.Latin && await Latin.charger()) $("#version-latin").hidden = false;
    else if (pref.repartition === "latin") appliquerVersion("romaine");
    if (window.Communs && await Communs.charger()) {
      $("#ouvrir-communs").hidden = false;
      $("#ouvrir-communs").addEventListener("click", () => { location.hash = communsVue !== null ? `#${etat.date}/${etat.office}` : "#communs"; });
    } else communsVue = null;

    if (window.PropreOP?.donnees) {
      $("#ouvrir-cal-op").hidden = false;
      $("#ouvrir-cal-op").addEventListener("click", () => { location.hash = routeCalOP() ? `#${etat.date}/${etat.office}` : "#calendrier-op"; });
    }
    $("#date").addEventListener("change", (e) => { if (e.target.value) { etat.date = e.target.value; afficher(); } });
    $("#veille").addEventListener("click", () => { etat.date = decaler(etat.date, -1); afficher(); });
    $("#lendemain").addEventListener("click", () => { etat.date = decaler(etat.date, 1); afficher(); });
    $("#aujourdhui").addEventListener("click", () => { etat.date = iso(new Date()); etat.office = officeDuMoment(); afficher(); });
    $$("#onglets button").forEach((b) => b.addEventListener("click", () => { etat.office = b.dataset.office; if (communsVue !== null) location.hash = `#${etat.date}/${etat.office}`; else afficher(); window.scrollTo(0, 0); }));
    window.addEventListener("hashchange", () => {
      if (routeCalOP()) { afficher(); return; }
      if (document.body.classList.contains("mode-cal-op")) { document.body.classList.remove("mode-cal-op", "mode-communs"); $("#ouvrir-cal-op").setAttribute("aria-pressed", "false"); if (/^#\d/.test(location.hash)) etat = lireAdresse(); if (routeCommuns() === null) { afficher(); return; } }
      const rc = routeCommuns();
      if (rc !== null) { communsVue = rc; afficher(); return; }
      if (communsVue !== null) { communsVue = null; document.body.classList.remove("mode-communs"); $("#ouvrir-communs").setAttribute("aria-pressed", "false"); if (/^#\d/.test(location.hash)) etat = lireAdresse(); afficher(); return; }
      const n = lireAdresse(); if (n.date !== etat.date || n.office !== etat.office) { etat = n; afficher(); } });

    // choix de l'office du jour (saint ou férie), retenu pour la date
    document.addEventListener("change", (e) => {
      const sc = e.target.closest && e.target.closest("select[data-commun-date]");
      if (sc) { changerCommun(sc); return; }
      // mémoire « en fête » au carnet : psaumes de la férie ou du carnet, retenu pour la date
      const sp = e.target.closest && e.target.closest("select[data-psaumes-date]");
      if (sp) { const c = { ...(pref.psaumesCarnet || {}) }; if (sp.value) c[sp.dataset.psaumesDate] = true; else delete c[sp.dataset.psaumesDate]; pref.psaumesCarnet = c; sauver(); afficher(); return; }
      const sel = e.target.closest && e.target.closest("select[data-choix-date]");
      if (!sel) return;
      pref.choix = { ...(pref.choix || {}), [sel.dataset.choixDate]: sel.value };
      sauver(); afficher();
    });

    // réglages
    $("#opt-op").checked = pref.propreOP;
    $(`input[name=version][value=${versionDe(pref)}]`).checked = true;
    $("#opt-invitatoire").checked = pref.invitatoire;
    $("#opt-prieres").checked = pref.prieres;
    $("#opt-capitules").checked = pref.capitules;
    $("#opt-oraison").value = pref.oraison || "liturgique";
    $("#opt-heure").value = pref.heure || "sexte";
    $("#opt-partitions-ouvertes").checked = pref.partitionsOuvertes;
    $("#opt-taille").value = pref.taille;
    $("#opt-theme").value = pref.theme;
    $("#ouvrir-reglages").addEventListener("click", () => $("#reglages").showModal());
    $("#reglages").addEventListener("change", (e) => {
      if (e.target.closest && e.target.closest("#bloc-horsligne")) return;   // ces choix ne changent pas l'office affiché
      pref.propreOP = $("#opt-op").checked;
      appliquerVersion($("input[name=version]:checked").value);
      pref.invitatoire = $("#opt-invitatoire").checked;
      pref.prieres = $("#opt-prieres").checked;
      pref.capitules = $("#opt-capitules").checked;
      pref.oraison = $("#opt-oraison").value;
      pref.heure = $("#opt-heure").value;
      pref.partitionsOuvertes = $("#opt-partitions-ouvertes").checked;
      pref.taille = +$("#opt-taille").value;
      pref.theme = $("#opt-theme").value;
      sauver(); appliquerAffichage(); afficher();
    });

    // PDF
    $("#ouvrir-pdf").addEventListener("click", () => {
      $("#pdf-debut").value = etat.date;
      $("#pdf-fin").value = decaler(etat.date, 6);
      $("#pdf-progres").hidden = true; $("#pdf-etat").textContent = "";
      $("#pdf-partitions").checked = !!pref.partitions;
      $(`input[name=pdf-lecture2][value=${pref.lecture2 === "bouchet" ? "bouchet" : "aelf"}]`).checked = true;
      $("#pdf").showModal();
    });
    $("#form-pdf").addEventListener("submit", async (e) => {
      if (e.submitter && e.submitter.value !== "lancer") return;
      e.preventDefault();
      const debut = $("#pdf-debut").value, fin = $("#pdf-fin").value;
      const offices = $$("input[name=pdf-office]:checked").map((x) => x.value);
      pref.lecture2 = $("input[name=pdf-lecture2]:checked")?.value === "bouchet" ? "bouchet" : "aelf"; sauver();
      if (!debut || !fin || fin < debut) { $("#pdf-etat").textContent = "Vérifiez les dates."; return; }
      if (!offices.length) { $("#pdf-etat").textContent = "Choisissez au moins un office."; return; }
      $("#pdf-lancer").disabled = true;
      try {
        const sortie = $("input[name=pdf-sortie]:checked").value;
        await produirePdf(debut, fin, offices, $("input[name=pdf-format]:checked").value, $("#pdf-saut").checked, true, sortie, $("#pdf-partitions").checked);
        $("#pdf").close();
      } catch (err) {
        $("#pdf-etat").textContent = "Erreur : " + err.message;
      } finally { $("#pdf-lancer").disabled = false; }
    });

    horsLigne();
    if (!(await impressionParAdresse())) afficher();
  }
  demarrer().catch((e) => {
    console.error(e);
    $("#office").innerHTML = `<p class="avertissement">Le site n'a pas pu charger ses données (${Textes.esc(e.message)}).<br>Ouvrez-le par « Lancer le bréviaire » ou depuis son adresse internet, pas en double-cliquant sur index.html.</p>`;
  });
})();
