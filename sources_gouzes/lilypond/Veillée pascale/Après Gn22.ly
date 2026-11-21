\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

armure = { \key d \minor \time 3/4 }
agauche = \once \override LyricText.X-offset = #0

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }{ \key g \major \cadenzaOn \transpose g e \tonRIIif }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
"Seigneur, mon partage" et ma coupe_:
"de toi dé" -- pend mon sort.
"Je garde le Seigneur devant moi" sans re -- lâche,
"il est à ma droite : je suis i" -- né -- bran -- lable.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
"Mon cœur exulte, mon âme" est en fête,
"ma chair elle-même repose" en con -- fiance_:
"tu ne peux m’abandonner" à la mort
"ni laisser ton ami voir la" cor -- rup -- tion.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
"Tu m’apprends le chemin" de la vie_:
"devant ta face, déborde" -- ment de joie_!
\agauche "..."\repeat unfold 3 {\skip4}
"À ta droite, éternité" de dé -- lices_! 
  }
  \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \key g \major \cadenzaOn \transpose g e \tonRIIih }
>>
