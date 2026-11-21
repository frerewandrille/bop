\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose d e
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Grave" 2 = 69
          f2 (d) e1\resp e\breve*1/8 f2 f4 f d2\resp e e4 e c2 d d\bar"|"
          f4 f f2. f4 d d e2 e\resp e\breve*1/8 f2 f4 f d2\resp
          e4 e c2 d d\fermata
          \bar"|."
        } \transpose a d \tonIIIgf
        %\tonIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 (bes) c1 c\breve*1/8 c2 c4 c bes2 bes bes4 bes a2 a a
          d4 d d2. d4 bes bes c2 c c\breve*1/8 c2 c4 c bes2 bes4 bes a2 a a
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pè -- re,_ "j’ai gar" -- dé en ton Nom ceux que tu m’as don -- nés.
     Et pour eux je me con -- sa -- cre, 
     "afin qu’ils" soient con -- sa -- crés dans ta vé -- ri -- té.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 (g) g1 g\breve*1/8 a2 a4 a f2 g g4 g e2 f f
          a4 a a2. a4 g g g2 g g\breve*1/8 a2 a4 a f2 g4 g e2 f f
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 (g) c,1\resp c\breve*1/8 a2 a4 a bes2\resp g g4 g a2 d d
          d4 d d2. d4 g g c,2 c \resp c\breve*1/8 a2 a4 a bes2 \resp
          g4 g a2 d d\fermata
        }  \transpose a d \tonIIIgh
        %\tonIeh
      }
   >>
>>