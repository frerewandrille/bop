/* Signaler une erreur : trois gestes (toucher le passage, écrire une phrase si l'on veut, « Envoyer »).

   - Bulle « Signaler » quand on sélectionne un passage de l'office ; lien en bas de chaque office ;
     petit lien sous chaque partition dépliée (une image ne se sélectionne pas).
   - Tout le contexte est joint sans rien demander : date, office, version, réglages, section,
     psaume ou référence, provenance probable du texte, fichiers de partition, clé de correction.
   - Envoi : POST api/signalements (serveur local : outils/serveur.py ; en ligne : service Azure).
     Sans réseau ou sans réponse, le signalement est gardé sur l'appareil (localStorage) et
     renvoyé au retour de la connexion, au prochain chargement ou au prochain signalement.
   Rien de tout cela n'est imprimé ni repris dans les fichiers Word (tout est ajouté à la page affichée,
   jamais au HTML produit par Offices.construire). */
(function (g) {
  "use strict";
  const ADRESSE = "api/signalements";
  const RESERVE = "breviaire-signalements";
  const esc = (s) => String(s ?? "").replace(/[&<>"]/g, (c) => ({ "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;" }[c]));
  const net = (s) => String(s ?? "").replace(/\s+/g, " ").trim();
  const VERSION_SITE = (/[?&]v=(\d+)/.exec([...document.scripts].map((s) => s.src).find((s) => /signaler\.js/.test(s)) || "") || [])[1] || "";

  let page = null;            // contexte de l'office affiché (donné par app.js)
  let enCours = null;         // signalement en préparation

  // ── Réserve sur l'appareil
  const lire = () => { try { return JSON.parse(localStorage.getItem(RESERVE) || "[]"); } catch (e) { return []; } };
  const ecrire = (l) => { try { localStorage.setItem(RESERVE, JSON.stringify(l)); return true; } catch (e) { return false; } };

  let envoiEnCours = null;
  function envoyerReserve() {
    if (envoiEnCours) return envoiEnCours;
    envoiEnCours = (async () => {
      let restants = lire(), envoyes = 0;
      for (const s of [...restants]) {
        try {
          const ctl = new AbortController(), t = setTimeout(() => ctl.abort(), 10000);
          const r = await fetch(ADRESSE, { method: "POST", headers: { "Content-Type": "application/json" }, body: JSON.stringify(s), signal: ctl.signal, cache: "no-store" });
          clearTimeout(t);
          if (!r.ok) break;                       // service absent ou en panne : on réessaiera plus tard
          restants = lire().filter((x) => x.id !== s.id);
          ecrire(restants); envoyes++;
        } catch (e) { break; }                    // hors connexion
      }
      return { envoyes, restants: lire().length };
    })().finally(() => { envoiEnCours = null; });
    return envoiEnCours;
  }

  // ── Ce que l'on sait de l'endroit signalé
  function provenance(el, bloc) {
    if (!el) return "";
    if (el.closest(".partition-pliee, .partition-piece")) return "partition";
    if (el.closest(".lectionnaire-bouchet, .lecture-bouchet, .lecture-bouchet-imprimee")) return "lectionnaire Bouchet";
    if (page && page.version === "latin") return "Heures grégoriennes (latin-français)";
    if (page && page.version === "aelf") return "AELF";
    if (el.closest(".psaume.aelf")) return "AELF";
    const ps = el.closest(".psaume");
    if (ps) return "psautier BJ";
    const lec = el.closest(".lecture");
    if (lec) {
      const note = lec.previousElementSibling && lec.previousElementSibling.textContent || "";
      return /texte AELF/.test(note) ? "AELF" : "Bible BJ";
    }
    const h = bloc ? net(bloc.querySelector("h3")?.textContent).toLowerCase() : "";
    if (/capitule|parole de dieu/.test(h)) return "capitule ou lecture brève";
    return "texte de l'office (AELF ou carnets)";
  }

  function endroit(el) {
    const bloc = el && el.closest("section.bloc");
    const ps = el && el.closest(".psaume");
    const ref = (ps && ps.querySelector(".titre-psaume, h4")) || (bloc && bloc.querySelector(".ref-lecture"));
    const fig = el && el.closest("details.partition-pliee");
    const images = [...((fig || null)?.querySelectorAll("img") || [])].map((i) => decodeURI(i.getAttribute("src") || "").replace(/\?.*$/, ""));
    return {
      section: bloc ? net(bloc.querySelector("h3")?.textContent) : "",
      piece: ref ? net(ref.textContent) : "",
      provenance: provenance(el, bloc),
      classes: bloc ? bloc.className : "",
      partitions: images,
    };
  }

  // ── Fenêtre
  function fenetre() {
    let d = document.getElementById("signaler");
    if (d) return d;
    d = document.createElement("dialog");
    d.id = "signaler"; d.className = "fenetre fenetre-signaler no-print";
    d.innerHTML = `<form method="dialog">
      <h2>Signaler une erreur</h2>
      <p class="sig-contexte aide"></p>
      <blockquote class="sig-passage" hidden></blockquote>
      <p class="sig-note aide" hidden></p>
      <label class="sig-ou" hidden><span>À quel endroit ?</span><select></select></label>
      <label class="sig-texte"><span>Qu'est-ce qui ne va pas ? <span class="aide">(facultatif)</span></span>
        <textarea rows="3" placeholder="Par exemple : il manque un verset, ce n'est pas l'antienne du jour…"></textarea></label>
      <p class="sig-etat aide" role="status"></p>
      <menu>
        <button class="bouton" value="annuler" formnovalidate>Annuler</button>
        <button class="bouton principal" value="envoyer">Envoyer</button>
      </menu>
    </form>`;
    document.body.appendChild(d);
    d.querySelector("form").addEventListener("submit", (e) => {
      if (!e.submitter || e.submitter.value !== "envoyer") { enCours = null; return; }
      e.preventDefault();
      envoyer(d);
    });
    d.addEventListener("close", () => { enCours = null; });
    return d;
  }

  const legende = (el) => net(el && el.closest("details.partition-pliee")?.querySelector(":scope > summary .legende")?.textContent).replace(/^—\s*/, "");

  function ouvrir(passage, el, avecChoix) {
    const d = fenetre();
    const lieu = el ? endroit(el) : { section: "", piece: "", provenance: "", classes: "", partitions: [] };
    enCours = { passage: net(passage).slice(0, 2000), lieu };
    d.querySelector(".sig-contexte").textContent = [page ? page.titre : document.title, lieu.piece || lieu.section].filter(Boolean).join(" — ");
    const q = d.querySelector(".sig-passage");
    q.hidden = !enCours.passage && !lieu.partitions.length;
    q.textContent = enCours.passage ? (enCours.passage.length > 280 ? enCours.passage.slice(0, 280) + "…" : enCours.passage)
      : lieu.partitions.length ? `Partition${legende(el) ? " — " + legende(el) : ""}` : "";
    const n = d.querySelector(".sig-note");
    n.hidden = lieu.provenance !== "AELF";
    n.textContent = "Ce texte vient de l'AELF : nous ne pouvons pas le corriger, mais nous pouvons le remplacer ou le signaler à l'AELF.";
    const ou = d.querySelector(".sig-ou");
    ou.hidden = !avecChoix;
    if (avecChoix) {
      const titres = [...document.querySelectorAll("#office section.bloc > h3")].map((h) => net(h.textContent));
      ou.querySelector("select").innerHTML = `<option value="">Dans tout l'office</option>` + [...new Set(titres)].map((t) => `<option>${esc(t)}</option>`).join("");
    }
    d.querySelector("textarea").value = "";
    d.querySelector(".sig-etat").textContent = "";
    d.querySelector("button[value=envoyer]").disabled = false;
    cacherBulle();
    d.showModal();
    setTimeout(() => d.querySelector(avecChoix ? "select" : "textarea").focus(), 50);
  }

  async function envoyer(d) {
    if (!enCours) return;
    const choix = d.querySelector(".sig-ou").hidden ? "" : d.querySelector(".sig-ou select").value;
    const lieu = { ...enCours.lieu };
    if (choix) lieu.section = choix;
    const opts = { ...(page?.options || {}) };
    delete opts.choix; delete opts.bouchet;
    const s = {
      id: `${Date.now().toString(36)}-${Math.random().toString(36).slice(2, 8)}`,
      cree: new Date().toISOString(),
      date: page?.date || "", office: page?.office || "", version: page?.version || "", titre: page?.titre || document.title,
      adresse: location.hash, cle: page?.cle || "", reglages: opts,
      ...lieu, passage: enCours.passage, commentaire: net(d.querySelector("textarea").value).slice(0, 4000),
      site: VERSION_SITE, appareil: navigator.userAgent.slice(0, 200),
    };
    const etat = d.querySelector(".sig-etat");
    d.querySelector("button[value=envoyer]").disabled = true;
    if (!ecrire([...lire(), s])) { etat.textContent = "Impossible de garder le signalement sur cet appareil. Réessayez."; d.querySelector("button[value=envoyer]").disabled = false; return; }
    etat.textContent = "Envoi…";
    const r = await envoyerReserve();
    const parti = !lire().some((x) => x.id === s.id);
    etat.textContent = parti ? "Merci, c'est transmis." : "Merci. Pas de connexion pour l'instant : le signalement est gardé sur cet appareil et partira tout seul.";
    enCours = null;
    setTimeout(() => { if (d.open) d.close(); }, parti ? 1400 : 3200);
    return r;
  }

  // ── Bulle sur un passage sélectionné
  // Ordinateur : bulle sous la sélection. Téléphone/tablette (doigt) : barre fixe en bas de l'écran, car le menu
  // du système (Copier, Rechercher…) s'affiche à côté de la sélection et recouvrirait la bulle.
  const TACTILE = typeof matchMedia === "function" && (matchMedia("(pointer: coarse)").matches || matchMedia("(hover: none)").matches);
  let bulle = null, selection = null, derniere = null, derniereT = 0;
  function cacherBulle() { if (bulle) bulle.hidden = true; selection = null; }
  function creerBulle() {
    bulle = document.createElement("button");
    bulle.type = "button";
    bulle.className = "bulle-signaler no-print" + (TACTILE ? " bulle-bas" : "");
    bulle.textContent = TACTILE ? "Signaler ce passage" : "Signaler";
    bulle.setAttribute("aria-label", "Signaler une erreur dans le passage sélectionné");
    bulle.hidden = true;
    // garder la sélection quand on touche la bulle
    bulle.addEventListener("pointerdown", (e) => e.preventDefault());
    bulle.addEventListener("mousedown", (e) => e.preventDefault());
    bulle.addEventListener("click", () => {
      // sur téléphone, toucher la barre peut défaire la sélection juste avant le clic : on garde la dernière
      const s = selection || (Date.now() - derniereT < 1500 ? derniere : null);
      if (s) ouvrir(s.texte, s.el);
    });
    document.body.appendChild(bulle);
  }
  function montrerBulle() {
    if (document.body.classList.contains("mode-impression")) return cacherBulle();
    const sel = document.getSelection();
    if (!sel || sel.isCollapsed || !sel.rangeCount) return cacherBulle();
    const r = sel.getRangeAt(0), office = document.getElementById("office");
    const noeud = r.commonAncestorContainer.nodeType === 1 ? r.commonAncestorContainer : r.commonAncestorContainer.parentElement;
    if (!office || !noeud || !office.contains(noeud) || noeud.closest("button, select, summary, .no-print")) return cacherBulle();
    const texte = net(sel.toString());
    if (texte.length < 2) return cacherBulle();
    if (!bulle) creerBulle();
    const debut = r.startContainer.nodeType === 1 ? r.startContainer : r.startContainer.parentElement;
    selection = derniere = { texte, el: debut };
    derniereT = Date.now();
    bulle.hidden = false;
    if (TACTILE) return;                                   // barre fixe : rien à placer
    const rects = [...r.getClientRects()].filter((x) => x.width || x.height);
    const fin = rects[rects.length - 1] || r.getBoundingClientRect();
    const larg = bulle.offsetWidth || 90;
    const x = Math.min(Math.max(8, fin.right - larg / 2), document.documentElement.clientWidth - larg - 8);
    bulle.style.left = `${x + window.scrollX}px`;
    bulle.style.top = `${fin.bottom + window.scrollY + 10}px`;
  }
  let minuterie = 0;
  const plusTard = () => { clearTimeout(minuterie); minuterie = setTimeout(montrerBulle, 250); };
  document.addEventListener("selectionchange", plusTard);
  document.addEventListener("touchend", plusTard, { passive: true });
  document.addEventListener("mouseup", plusTard);

  // ── Liens ajoutés à l'office affiché
  document.addEventListener("click", (e) => {
    const b = e.target.closest && e.target.closest("button[data-signaler]");
    if (!b) return;
    e.preventDefault();
    if (b.dataset.signaler === "office") ouvrir("", null, true);
    else ouvrir("", b, false);
  });

  function decorer(conteneur, contexte) {
    page = contexte || null;
    cacherBulle();
    if (!conteneur || !conteneur.querySelector("section.bloc")) return;
    conteneur.querySelectorAll("details.partition-pliee").forEach((det) => {
      if (det.querySelector(":scope > .signaler-partition")) return;
      det.insertAdjacentHTML("beforeend", `<p class="signaler-partition no-print"><button type="button" class="lien-signaler" data-signaler="partition">Signaler une erreur sur cette partition</button></p>`);
    });
    conteneur.insertAdjacentHTML("beforeend", `<p class="signaler-pied no-print"><button type="button" class="lien-signaler" data-signaler="office">Signaler une erreur dans cet office</button><span class="aide"> — ou sélectionnez le passage fautif.</span></p>`);
  }

  window.addEventListener("online", () => envoyerReserve());
  setTimeout(() => { if (lire().length) envoyerReserve(); }, 3000);

  g.Signaler = { decorer, envoyerReserve, get enAttente() { return lire().length; }, ouvrir };
})(typeof window !== "undefined" ? window : globalThis);
