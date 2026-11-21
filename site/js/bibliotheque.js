/* Bibliothèque : ce qui est commun à ses pages (Bénédicité, Prières, Martyrologe, Frères défunts) :
   la liste des pages, leurs onglets (date gardée d'une page à l'autre) et les préférences d'affichage
   partagées avec les offices (thème, taille du texte). */
(function (g) {
  "use strict";
  const PAGES = [
    { cle: "table", titre: "Bénédicité", fichier: "table.html", resume: "Bénédiction du repas, midi et soir, et action de grâces, selon le jour liturgique." },
    { cle: "prieres", titre: "Prières", fichier: "prieres.html", resume: "Prières communes et formules de la foi, en français et en latin, en six chapitres (Compendium du Catéchisme)." },
    { cle: "martyrologe", titre: "Martyrologe", fichier: "martyrologe.html", resume: "Éloges des saints du jour : édition romaine, de Marseille ou de Toulouse." },
    { cle: "defunts", titre: "Frères défunts", fichier: "defunts.html", resume: "Mémoire des frères de la Province morts ce jour, De profundis, nécrologe complet." },
  ];

  function onglets(courant, date) {
    const nav = document.querySelector(".pages-annexes");
    if (!nav) return;
    nav.innerHTML = PAGES.map((p) => `<a href="${p.fichier}${date && p.cle !== "prieres" ? "#" + date : ""}"${p.cle === courant ? ' aria-current="page"' : ""}>${p.titre}</a>`).join("");
  }

  function preferences() {
    let pref = {};
    try { pref = JSON.parse(localStorage.getItem("breviaire-pref") || "{}"); } catch (e) { /* rien */ }
    if (pref.theme && pref.theme !== "auto") document.documentElement.setAttribute("data-theme", pref.theme);
    document.documentElement.style.setProperty("--taille", (pref.taille || 18) + "px");
    return pref;
  }

  g.Bibliotheque = { PAGES, onglets, preferences };
})(window);
