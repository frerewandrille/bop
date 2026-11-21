\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") }

armure = { \key e \minor }
retrait = \once \override LyricText.X-offset = #retrait

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose c bes,
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIIIbf
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
"Crée en moi un cœur pur," ô mon Dieu,
"renouvelle et raffermis au fond de moi" mon es -- prit.
"Ne me chasse pas loin" de ta face,
"ne me reprends pas ton" es -- prit saint.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
"Rends-moi la joie d’ê" -- tre sau -- vé_;
"que l’esprit généreux" me sou -- tienne.
"Aux pécheurs, j’enseignerai" tes che -- mins,
"vers toi, reviendront les" é -- ga -- rés.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
"Si j’offre un sacrifice, tu" n’en veux pas,
"tu n’acceptes pas" d’ho -- lo -- causte.
"Le sacrifice qui plaît à Dieu, c’est un es" -- prit bri -- sé,
"tu ne repousses pas, ô mon Dieu, un cœur brisé" et broy -- é. 
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIIIbh
  }
>>