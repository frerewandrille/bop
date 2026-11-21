\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff  
<< \new Dynamics 
   {
     g8 a4. g8 a4 b c (b8 [c]^\> b [a]) g4\!    \allowBreak
     a8^\< [b] c4^\> b a2 \!  \bar "||" %\noBreak
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key e \minor \cadenzaOn 
          g8 a4.^> g8 a4^> b c^> (b8 [c] b [a]) g4 \breathe   \allowBreak
          a8 [b] c4^\markup\italic"rall." b a2\fermata   \bar "||" %\noBreak
        } \tonIIIaf % Pas de ton dans l’original
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          e8 e4. e8 e4 g g~(g4. d8) d4 g8 [g] g4 g e2
        }
      } 
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Puis8 -- sance,4. hon8 -- neur4 et gloi2. -- re,4
     à8 l’A -- gneau4 de Dieu_!2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key e \minor \cadenzaOn 
          b8 c4. b8 c4 d e (d8 [e] d [c]) b4 c8 [d] e4 d c2
        }\tonIIIah
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          e8 a4._> e8 a4_> g c,_> (g'2) g4 \breathe
          e8 [d] c4 g' a2\fermata
        }
      }
   >>
   
>>