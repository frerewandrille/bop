/* Barre des menus commune : Office · Messe · Bible · Bibliothèque. (Les réglages sont dans la barre de chaque page.)
   Incluse par toutes les pages (offices, Bible sous /bible/, pages de la bibliothèque). Elle s'insère en tête
   de la page, sans toucher au reste : chaque page garde sa propre barre d'outils (date, onglets…).
   L'adresse « ./?reglages » ouvre les réglages des offices (lien possible depuis une autre page). */
(function () {
  "use strict";
  const enBible = /\/bible\//.test(location.pathname);
  const racine = enBible ? "../" : "";
  const accueil = racine || "./";                  // la page des offices (un lien vide resterait sur la page courante)
  const page = location.pathname.split("/").pop() || "index.html";
  const BIBLIO = ["bibliotheque.html", "table.html", "prieres.html", "martyrologe.html", "defunts.html"];
  const actif = enBible ? "bible" : BIBLIO.includes(page) ? "bibliotheque" : page === "messe.html" ? "messe" : page === "index.html" ? "office" : "";
  const dateCourante = () => (/^#(\d{4}-\d{2}-\d{2})/.exec(location.hash) || [])[1] || "";

  const ICONES = {
    office: '<path d="M12 21V8"/><path d="M12 8C10 6 7 5.5 3.5 6v12c3.5-.5 6.5 0 8.5 2 2-2 5-2.5 8.5-2V6C17 5.5 14 6 12 8z"/><path d="M12 3v3M10.5 4.5h3"/>',
    bible: '<path d="M5.5 5A2 2 0 0 1 7.5 3h11v15h-11a2 2 0 0 0-2 2z"/><path d="M5.5 20a2 2 0 0 0 2 1.5h11V18"/><path d="M12 6.5v8M9 9.5h6"/>',
    bibliotheque: '<path d="M4 4.5h4v15H4zM9 4.5h4v15H9z"/><path d="M14.2 5.6l3.7-1.4 4.6 12.3-3.7 1.4z"/>',
    messe: '<path d="M8 3h8l-1 6a3 3 0 0 1-6 0z"/><path d="M12 12v6M8.5 21h7M12 18c-1.5 0-3 1-3.5 3h7c-.5-2-2-3-3.5-3z"/>',
  };
  const ico = (k) => `<svg class="menu-ico" viewBox="0 0 24 24" aria-hidden="true">${ICONES[k]}</svg>`;

  const nav = document.createElement("nav");
  nav.className = "menu-principal";
  nav.setAttribute("aria-label", "Menu principal");
  nav.innerHTML =
    `<a class="menu-marque" href="${accueil}">Bréviaire dominicain</a>`
    + `<a class="menu-item" data-cle="office" href="${accueil}">${ico("office")}<span>Office</span></a>`
    + `<a class="menu-item" data-cle="messe" href="${racine}messe.html">${ico("messe")}<span>Messe</span></a>`
    + `<a class="menu-item" data-cle="bible" href="${racine}bible/">${ico("bible")}<span>Bible</span></a>`
    + `<a class="menu-item" data-cle="bibliotheque" href="${racine}bibliotheque.html">${ico("bibliotheque")}<span>Bibliothèque</span></a>`
    ;
  nav.querySelectorAll(".menu-item").forEach((a) => { if (a.dataset.cle === actif) a.setAttribute("aria-current", "page"); });

  // garder la date d'une page à l'autre (Office ↔ bibliothèque)
  nav.addEventListener("click", (e) => {
    const a = e.target.closest("a.menu-item, a.menu-marque");
    if (!a || enBible) return;
    const d = dateCourante();
    if (d && (a.dataset.cle === "office" || a.classList.contains("menu-marque"))) a.href = accueil + "#" + d;
    if (d && a.dataset.cle === "bibliotheque") a.href = racine + "bibliotheque.html#" + d;
    if (d && a.dataset.cle === "messe") a.href = racine + "messe.html#" + d;
  });

  // Pied de page commun : sources et droits (même texte sur toutes les pages, Bible comprise)
  const SOURCES = [
    ["Écriture et psautier", [
      "<i>Bible de Jérusalem</i> et <i>Psautier de la Bible de Jérusalem</i> (édition de la province dominicaine de Toulouse, hors commerce) — © Éditions du Cerf.",
      "<i>Nova Vulgata</i> — © Libreria Editrice Vaticana.",
      "Textes originaux, interlinéaires, Vulgate, Septante, lexiques et dictionnaires bibliques (dont le <i>Vocabulaire de théologie biblique</i>) : modules de Biblia Universalis 3 — droits de leurs éditeurs respectifs.",
      "<i>La Bible chrétienne</i> (Cl. Jean-Nesmy, M. de Solms, Miville-Dechêne, 1988).",
      "<i>Chaîne d'or</i> de saint Thomas d'Aquin.",
      "Fiches des mots latins : Collatinus (Y. Ouvrard, Ph. Verkerk), licence GPL.",
    ]],
    ["Liturgie", [
      "Textes de l'office et de la messe (lectures, hymnes, antiennes, oraisons) : <a href=\"https://www.aelf.org\" rel=\"noopener\">AELF</a> — © AELF.",
      "<i>Missel romain</i>, nouvelle traduction — © AELF.",
      "<i>Liturgie chorale du peuple de Dieu</i> (fr. André Gouzes o.p.).",
      "<i>Les Heures grégoriennes</i> — © Communauté Saint-Martin.",
      "<i>Lectionnaire pour les dimanches et pour les fêtes</i> (fr. J.-R. Bouchet o.p.).",
      "Carnets et bénédictions de la table de la province de Toulouse ; partitions de la Sainte-Baume, du <i>Completorium</i> de Bordeaux (2009) et de l'office du milieu du jour de Marseille (2020).",
      "Propre de l'Ordre des Prêcheurs ; <i>Martyrologe romain</i> (éditions de Toulouse et de Marseille) ; mémoire des frères défunts d'après le <i>Catalogus</i> de l'Ordre.",
      "<i>Compendium du Catéchisme de l'Église catholique</i> — © Libreria Editrice Vaticana.",
    ]],
    ["Typographie", ["Kepler Std — © Adobe."]],
  ];
  const pied = document.createElement("footer");
  pied.className = "pied-commun";
  pied.innerHTML =
    `<p>Site privé, à l'usage des frères et de leurs proches. Textes et partitions restent la propriété de leurs ayants droit ; ne pas les diffuser.</p>`
    + `<details><summary>Sources et droits</summary>`
    + SOURCES.map(([titre, l]) => `<h2>${titre}</h2><ul>${l.map((x) => `<li>${x}</li>`).join("")}</ul>`).join("")
    + `</details>`;

  const poser = () => {
    document.body.insertBefore(nav, document.body.firstChild);
    // le menu est inclus juste après <body> : le pied attend que la page soit entière pour aller en bas
    if (document.readyState === "loading") document.addEventListener("DOMContentLoaded", () => document.body.append(pied));
    else document.body.append(pied);
    document.body.classList.add("avec-menu");
    const roue = document.getElementById("gear");                  // Bible : même caractère que le ⚙ des offices
    if (enBible && roue) roue.textContent = "⚙";
    // ⚙ des pages autres que les offices : ouvre les réglages (thème, taille du texte, propre de l'Ordre…) des offices
    document.addEventListener("click", (e) => {
      if (!e.target.closest("#reglages-lien")) return;
      location.href = accueil + "?reglages=1" + (dateCourante() ? "#" + dateCourante() : "");
    });
    // arrivée par « ?reglages=1 » : ouvrir les réglages dès que la page des offices est prête
    if (actif === "office" && new URLSearchParams(location.search).has("reglages")) {
      let n = 0;
      const t = setInterval(() => {
        const b = document.getElementById("ouvrir-reglages");
        if ((b && document.querySelector("#office :not(.chargement)")) || ++n > 40) {
          clearInterval(t);
          if (b) b.click();
          history.replaceState(null, "", location.pathname + location.hash);
        }
      }, 150);
    }
  };
  if (document.body) poser(); else document.addEventListener("DOMContentLoaded", poser);
})();
