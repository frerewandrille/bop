/* Passage vers le bréviaire. En ligne, la Bible est servie sous /bible/ du site du bréviaire : « ../ ».
   Servie seule (python3 serveur.py, Wi-Fi de la maison), on renvoie au bréviaire en ligne. */
window.LIENS = {
  breviaire: /\/bible\//.test(location.pathname) ? "../" : "https://calm-flower-052e85c10.4.azurestaticapps.net/",
};
