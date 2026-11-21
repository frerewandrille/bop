\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 4/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn % \tempo  2 = 96
          \partial 8 e8 a4 a8 g a4 \resp 
          b8 [a] g g e4 \resp c'8 b a4 g a2\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          \partial8 e8 e4 e8 e e4 e8 [e] e e c4 g'8 g e4 e e2
        }    
      }
   >>
   \new Lyrics \lyricsto "soprano"
   {
      Sei -- gneur, prends pi -- tié, Sei -- gneur, prends pi -- tié, 
      Sei -- gneur, prends pi -- tié_!
   }
   \new Lyrics \lyricsto "soprano"
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
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure 
          \partial8 e8 c'4 c8 b c4 d8 [c] b b a4 e'8 d c4 b c2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \partial8 e8 e4 e8 e e4 \resp
          e8 [e] e e a4 \resp c,8 g' a4 e a2\fermata
        } 
      }
   >>
>>