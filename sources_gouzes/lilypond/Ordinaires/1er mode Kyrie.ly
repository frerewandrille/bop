\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 2/2 }
resp = { \breathe\allowBreak }

\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "soprano"
  { \voiceOne \relative c''
    { \clef "treble" \armure \cadenzaOn % \tempo  2 = 96
      a\breve*1/8 g4\resp a\breve*1/8 \allowBreak f8 g2 \resp
      g4 g g f a2\fermata
      \bar"||"
    } 
  }
  \new Lyrics \lyricsto "soprano"
  {
    "Seigneur Jé" -- sus,
    "envoyé pour guérir les cœurs qui reviennent" 
    vers toi_:
    Sei -- gneur, prends pi -- tié_!
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
    Sei -- gneur, prends pi -- tié_!
  }
>>
\markup\vspace #1
\new ChoirStaff
<< \new Dynamics 
   {
     a4 a^\< a a g\! a bes2 bes4^\> a a\!\resp
     f^\< g2\! g4\> a a2\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo  2 = 96
         a4 a a a g a bes2 bes4 a a\resp
         f g2 g4\fermata a\fermata a2\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f4 f f f e f g2 g4 e f d e2 e4 e f2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sei -- gneur, prends pi -- tié, Sei -- gneur, prends pi -- tié, 
     Sei -- gneur, prends pi -- tié_!
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ô Christ, prends pi -- tié, Ô Christ, prends pi -- tié, 
     Ô Christ, prends pi -- tié_!
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sei -- gneur, prends pi -- tié, Sei -- gneur, prends pi -- tié, 
     Sei -- gneur, prends pi -- tié_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d d d d d d2 d4 cis d a c2 c4 cis d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d d d d d g2 g4 a d,\resp
          d c2 c4\fermata a\fermata d2\fermata
        } 
      }
   >>
>>