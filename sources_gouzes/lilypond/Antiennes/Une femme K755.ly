\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \relative c''
     { \clef "treble" \armure \omit Score.BarLine %\tempo  2. = 50
       \partial4 d8 c bes2. (a8 g) a2. bes8 a g2 
       f4 ees f2 g4 a d,2.\fermata\resp 
       d4 bes'2. \tuplet 3/2 { d8 c bes } a2. bes8 a 
       g2 (f4) ees f2 g4 (a) g1\fermata 
       \revert Score.BarLine.stencil \bar "|."
     }\cadenzaOn \transpose g bes \tonIIif
   }
   \new Lyrics \lyricsto soprano 
   { 
     U -- ne fem -- me pour -- rait_- elle ou -- bli -- er son en -- fant_?
     Voi -- ci_: Je t’ai gra -- vé sur la pau -- me de mes mains_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \relative c'
        { \clef "bass" \armure
          \partial4 s4^\markup\italic"b.f." \voiceOne d2 (bes) c (a) bes (g) a (f) g (d2*1/2)
          s4 d'2 (bes) c (a) bes (g) a (f) g1
        }\cadenzaOn \transpose g bes \tonIIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial4 d4\rest g1 (f) (ees) (d) (g,2) (d'2*1/2)\resp
          s4 g1 (f) (ees) (d) (g,\fermata)
        }
      }
   >>
>>