\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose g e
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 58
         g4-> c bes-> bes a-> f g2.\resp g4 f-> a a2 c4-> a bes2 a2.\bar"|"
         f4 f-> g bes2\resp bes4-> a f-> a g1\fermata
         \bar"|."
       }\transpose g bes \tonIIcf %\tonIIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         g4 g g g g a d,2. d4 d f f2 g4 g g2 f2. d4 d d g2 g4 d d d d1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ma dé -- tresse est de -- vant moi_; vois le mal -- heur qui m’ac -- ca -- ble.
     Viens nous sau -- ver, viens, Sei -- gneur Jé -- sus_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          ees4 4 d d c c bes2. 4 a c c2 4 c d2 c2. c4 c c d2 d4 d c c bes1
        } \transpose g bes \tonIIch %\tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          c4-> c g-> g d-> d g2.\resp g4 g-> f f2 ees4-> ees d2 f2.
          a4 a-> a g2\resp g4-> f d-> f g1\fermata
        } 
      }
   >>
>>