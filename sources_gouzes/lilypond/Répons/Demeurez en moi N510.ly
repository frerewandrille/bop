\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

global = {\key bes \major \time 3/4}
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \global \cadenzaOn %\tempo "" 2 = 52
          c2 c4 bes2 c4 g2.\resp 
          g2 g4 bes2 bes4 aes!2 bes4 g2.\bar "|"
          g\breve*1/8^\markup{\italic"large et extatique"} 
          bes4 aes! g2 (d4) d2. \resp
          d4 d d f2 g4 g2.\fermata
          \revert Score.BarLine.stencil \bar "|."
        } \tonIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        {
          g4 (f) g aes (g) f e2. e!4 (f) e! c (d!) e! f (e!) d! e!2. 
          e!\breve*1/8 g4 f e2 (d4) d2. d4 d d d2 d4 d2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      De -- meu -- rez en moi, com -- me je de -- meure en vous._
      "C’est la gloire" de mon Pè -- re que vous por -- tiez du fruit.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \global\cadenzaOn
          ees4 (des) ees f (ees) des! c2. \breathe
          c4 (d!) c aes (bes) c des (c) bes c2. 
          c\breve*1/8 s2 c2 (bes4) bes2. bes4 bes bes a!2 b4 b2. 
        } \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c,
        { \override Rest.staff-position = #-2
          s2. s s \oneVoice r1*3/4 \voiceTwo s s s
          c'\breve*1/8 s2 c2 (g'4) g2.\breathe
          g4 g g d2 <g, g'>4 q2.\fermata
        }
      }
   >>
>>