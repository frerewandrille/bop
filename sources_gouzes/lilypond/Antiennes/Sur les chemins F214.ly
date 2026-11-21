\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose f ees
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Ferme"2 = 50
          f2^\pp f4-> e d-> d e-> g a2 c4-> e d2\resp
          e4-> e d-> d a2. a4^\markup\italic"rall." c-> (a^\p) a2\fermata
          \bar"|."
        } \tonIVaf
        %\tonIVef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 d4 c b b c d e2 e4 f g2 g4 g g g e2. fis4 g (fis!) e2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Sur les che -- mins de ta Pa -- ro -- le, Sei -- gneur,
      tu as mis mon cœur au lar -- ge.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a4 a a a a b c2 a4 a b2 c4 c b b c2. d4 e (d) c2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 d4 e f-> f e-> e a,2 a4-> d g2\resp
          c,4-> c g'-> g a2. a4 a2 a\fermata
        } \tonIVah
        %\tonIVeh
      }
   >>
>>