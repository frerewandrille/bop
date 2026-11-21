\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif" 4 = 112
          g4 fis8 [fis] g4 a a8 [a] c2 c4\resp c b2-> b4 a2 \bar"|"
          a4 a8 [a] a2 a4 a a2-> a\fermata
          \bar"|."
        } \tonXaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 d8 [d] d4 f f8 [f] g2 g4 g g2 g4 e!2 e!4 e8 [e] f!2 f4 f e!2 fis
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      C’est toi, Sei -- gneur, ma ci -- ta -- del -- le_! 
      Ré -- veil -- le_- toi_!
      Sois de -- vant moi, et re -- gar -- de_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 a8 [a] bes4 c c8 [c] ees2 ees4 ees d2 d4 cis2
          cis!4 cis8 [cis] d2 d4 d d (cis!) d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 d8 [d] g4 f f8 [f] c2 c4\resp c g'2-> g4 a2
          a4 a8 [a] d,2 d4 d a'2-> d,\fermata
        } \tonXah
      }
   >>
>>