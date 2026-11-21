// Vérification orthographique par le correcteur français de macOS (NSSpellChecker), pour corrige.py.
//   osascript -l JavaScript orthographe_mac.js mots.txt guess   -> « mot<TAB>ok|faux<TAB>proposition|proposition… »
ObjC.import('AppKit');
ObjC.import('Foundation');
function run(argv) {
  const sc = $.NSSpellChecker.sharedSpellChecker;
  sc.setLanguage('fr');
  const txt = $.NSString.stringWithContentsOfFileEncodingError(argv[0], $.NSUTF8StringEncoding, null);
  const lignes = ObjC.unwrap(txt).split('\n').filter(x => x);
  const out = [];
  for (const w of lignes) {
    const s = $(w);
    const r = sc.checkSpellingOfStringStartingAt(s, 0);
    const faux = r.location !== $.NSNotFound && r.length > 0;
    let sug = [];
    if (faux && argv[1] === 'guess') {
      const g = sc.guessesForWordRangeInStringLanguageInSpellDocumentWithTag($.NSMakeRange(0, w.length), s, 'fr', 0);
      sug = ObjC.deepUnwrap(g) || [];
    }
    out.push(w + '\t' + (faux ? 'faux' : 'ok') + '\t' + sug.slice(0, 6).join('|'));
  }
  return out.join('\n');
}
