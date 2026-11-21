\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 54
          fis2 fis4 fis e fis g e fis2\fermata\resp
          fis4-> fis d'-> d cis b cis2 fis,2.\resp
          fis4 g-> g a-> b fis1\fermata
          \bar"|."
        } \transpose e fis \tonIVcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 d4 d cis d e cis d2 d4 d d e fis g fis (e) dis2.
          dis!4 e e cis cis dis!1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Ce n’est pas vous qui par -- le -- rez,
      mais l’Es -- prit de vo -- tre Pè -- re 
      qui par -- le -- ra en vous.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b2 b4 b b b b b b2 b4 b b b cis d cis2 b2. b4 b b a a b1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          b4 (cis) d d e d cis cis b2\fermata\resp
          b'4-> a g-> g a b a2 b2.\resp
          b4 e,-> e fis-> fis b,1\fermata
        } \transpose e fis \tonIVch
      }
   >>
>>