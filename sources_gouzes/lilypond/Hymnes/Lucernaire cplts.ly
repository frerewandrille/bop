\version "2.24.0"

\include "vowel-set.ly"

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose g f 
\new ChoirStaff 
<< \new Staff \with {\remove Time_signature_engraver }	
   << \new Voice = "soprano" 
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \major \cadenzaOn
          b \breve a2 \breathe \allowBreak a \breve c b2\fermata \bar "|" 
          b \breve c4 d2 d \breve c4 b a2 \breathe \allowBreak a \breve b4 c \breve b a2\fermata \bar "||" 
      } }
      \new Voice = "alto" 
      { \voiceTwo \relative c'' 
        { g \breve g2 g \breve g g2
          g \breve a4 b2 b \breve a4 g fis2 fis \breve g4 a \breve g fis2 } }
   >>
   \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
     \set stanza = #"1. " \set shortVocalName = "1." 
     "Venant au coucher du so" -- leil,
     "contemplant la lu" -- "mière du" soir,
     "nous chantons" le Père, \skip4 et le Fils,
     et le Saint-Es -- "prit de" Dieu.
   }
   \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
     \set stanza = #"2. " \set shortVocalName = "2." 
     "Digne es-tu en tous temps d’être lou" -- é
     "par de" saintes voix,
     Fils de Dieu "qui don" -- na la vie,
     et le "monde te" glori -- fie.
   }
   \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
     \set stanza = #"3. " \set shortVocalName = "3." 
     "Nous te chantons, Ressusci" -- té,
     "toi qui surgis des té" -- "nèbres du tom" -- beau_!
     "Étoile du" ma -- tin "qui devan" -- ces l’au -- rore,
     "dont l’éclat res" -- plen -- "dit ' jusqu’au" "monde nou" -- veau_!
   }
   \addlyrics \with {\override LyricText.X-offset = #centrer }
   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
   { 
     \set stanza = #"4. " \set shortVocalName = "4." 
     "Ô Christ, toi notre" paix,
     "tes plaies ray" -- "onnent de lu" -- mière.
     "Tu viens nous vi" -- si -- ter "et nous rem" -- plis de joie_:
     "Nos yeux sont é" -- blou -- "is ' par la clar" -- "té de ton vi" -- sage.
   }
   \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
     \set stanza = #"5. " \set shortVocalName = "5." 
     "C’est par tes souffrances, Sei" -- gneur,
     "que tu es en" -- "tré dans la" gloire.
     "Tu as ouvert" nos yeux "pour qu’ils te" re -- con -- naissent.
     "Tu as rompu "le "pain ' et nous in" -- "vites au fes" -- tin.
   }
   \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
     \set stanza = #"6. " \set shortVocalName = "6." 
     "Grand prêtre miséricordieux et fi" -- dèle,
     "tu t’es fait sem" -- "blable à tes" frères_:
     "Tu as donné" ta vie "pour que vive" ton trou -- peau
     "dans une fête é" -- ter -- "nelle, ' dans la lu" -- "mière sans dé" -- clin.
   }
   \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
     \set stanza = #"7. " \set shortVocalName = "7." 
     "Tu nous rassembles en ton a" -- mour,
     "tu fais de nous les""membres de ton" corps.
     "La sève de" la croix "coule dans" les sar -- ments_:
     "Tu répands en" nos "cœurs ' le vin de" "ta résurrec" -- tion.
   }
   \addlyrics \with {\override LyricText.X-offset = #centrer }
   \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
     \set stanza = #"8. " \set shortVocalName = "8." 
     "Que ma prière, vers toi Sei" -- gneur,
     s’é -- "lève comme l’en" -- cens,
     et mes mains, \skip4 de -- vant toi,
     comme l’of -- fran -- "de du" soir.
   }   
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \cadenzaOn
          d \breve c2 c \breve e d2
          d \breve d4 g2 g \breve d4 d d2 d \breve d4 d \breve d d2 
      } }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        { g \breve g2 \breathe g \breve g g2\fermata 
          g \breve g4 g2 g \breve fis4 g d2 \breathe d \breve d4 fis \breve g d2\fermata 
      } }
   >>
>>