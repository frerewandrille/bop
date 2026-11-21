\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 2/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }


\transpose d b,
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Léger" 2 = 63
         d4 d-> d e-> c d2.\resp bes4 bes-> 4 c-> a bes-> (a) g2\bar"|"
         \time 3/4 \tempo  2. = 51
         d'2^\markup\italic"élargir" d4 e!-> e e  c2. \allowBreak\silN c4 c d-> d d bes2 (a4) g2.\fermata
         \bar"|."
       } \tonIIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         bes4 4  4 c a bes2. g\breve*7/8 g2
         g2 g4 g g g f2. s4 f f f f f d (f2) d2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     La nuit est a -- van -- cée, dé -- jà le jour ap -- pro -- che_: 
     Que se lève en nos cœurs le So -- leil de jus -- ti -- ce_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d\breve*5/8 d2. d4 d_> d e_> c d_> (c) bes2 2 4 c c c a2. \silN 
          a4 a bes4 4 4 4 (c2) bes2.
        } \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*5/8 g2. \resp g\breve*7/8 g2 g2 4 c,-> c c f2. s4 
          f4 f bes,4-> 4 4 g' (f2) g2.\fermata
        } 
      }
   >>
>>