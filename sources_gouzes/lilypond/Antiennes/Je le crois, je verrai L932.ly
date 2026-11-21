\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose bes a {
  \new ChoirStaff
  << \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "soprano"
        { \voiceOne \relative c'
          { \clef "treble" \armure \cadenzaOn \tempo "Allant" 4 = 92
            f4 f g g8 [g] bes4 bes8 [bes] g2 c4 c d2.\resp
            d8 [d] bes4. bes8 g4 g bes2\fermata
            \bar"|."
          } \tonVIIIbf
          %\transpose a bes \tonVIIdf
        }
        \new Voice = "alto"
        { \voiceTwo \relative c'
          { 
            c4 c ees ees8 [ees] f4 f8 [f] ees2 ees4 f f2. 
            f8 [f] g4. g8 ees4 ees f2
          }    
        }
     >>
     \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
     \lyricsto "soprano"
     {
       Je le crois_: Je ver -- rai la bon -- té du Sei -- gneur 
       sur la ter -- re des vi -- vants.
     }
     \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { \voiceOne \relative c'
          { \clef "bass" \armure \cadenzaOn
            a4 a bes bes8 [bes] bes4 bes8 [bes] bes2 bes4 a bes2.
            bes8 [bes] bes4. bes8 c4 c d2
          } 
        }
        \new Voice = "basse"
        { \voiceTwo \relative c
          { 
            f4 f ees ees8 [ees] d4 d8 [d] ees2 g4 f bes,2.\resp
            bes8 [bes] ees4. ees8 c4 c bes2\fermata
          } \tonVIIIbh
          %\transpose a bes \tonVIIdh
        }
     >>
  >>
}