\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "soprano"
  { \voiceOne \relative c'
    { \clef "treble" \armure \cadenzaOn % \tempo  2 = 96
      f\breve*1/8 bes4\resp c\breve*1/8 \allowBreak d8 bes2 \resp
      g8 g c bes bes2\fermata
      \bar"||"
    } 
  }
  \new Lyrics \lyricsto "soprano"
  {
    "Seigneur Jé" -- sus,
    "envoyé pour guérir les cœurs qui reviennent" 
    vers toi_:
    Sei -- gneur prends pi -- tié_!
  }
  \new Lyrics \lyricsto "soprano"
  {
    Ô Christ, "venu appeler les" pé -- cheurs_:
    Ô Christ, prends pi -- tié_!
  }
  \new Lyrics \lyricsto "soprano"
  {
    "Seigneur Jé" -- sus,
    "qui sièges à la droite du Père, où tu intercèdes"
    pour nous_:
    Sei -- gneur prends pi -- tié_!
  }
>>

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo  "Calme"
         bes4 bes bes bes bes2-> bes4 bes2\resp
         bes4 bes a bes c2-> c4 c2\resp
         c4 c c a bes2-> bes4 bes2\fermata\break\allowBreak
         bes4 bes bes bes2-> bes4 bes2\resp
         bes4 a bes c2-> c4 c2\resp
         c4 c a bes2-> bes4 bes2\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f4 f f f f2 f4 f2 f4 f f f g2 g4 g2 g4 g g f f2 f4 f2
         f4 f f f2 f4 f2 f4 f f g2 g4 g2 g4 g f f2 f4 f2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     \set stanza = "1.&3."
     Ky -- ri -- e e -- le -- i -- son,
     Ky -- ri -- e e -- le -- i -- son,
     Ky -- ri -- e e -- le -- i -- son_!
     \set stanza = " 2."
     Chris -- te e -- le -- i -- son,
     Chris -- te e -- le -- i -- son,
     Chris -- te e -- le -- i -- son_!
    }
  \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d d d d2 d4 d2 d4 d c d ees2 ees4 ees2 ees4 ees ees c d2 d4 d2
          d4 d d d2 d4 d2 d4 c d ees2 ees4 ees2 ees4 ees c d2 d4 d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          bes4 bes bes bes bes2-> bes4 bes2 \resp
          bes4 bes f' d c2-> c4 c2\resp
          c4 c c f bes,2-> bes4 bes2\fermata
          bes4 bes bes bes2-> bes4 bes2 \resp
          bes4 f' d c2-> c4 c2\resp
          c4 c f bes,2-> bes4 bes2\fermata
        } 
      }
   >>
>>