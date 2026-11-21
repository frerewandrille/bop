\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

silB = { \oneVoice r2 \voiceOne }
apostrophe = \once \override LyricText.X-offset = #apostrophe

\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très calme" 2 = 56
         bes2 bes4 bes c2 d g, g f1\resp \silB bes2 a a g1\fermata
         \bar"|."
       } \tonIIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d2 ees4 f ees2 f ees4 (d) c (ees) d1 s2 d ees d4 (c) bes1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Don -- ne_- nous au -- jour --\apostrophe d’hui, Sei -- gneur, le Pain de Vie_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 g4 f g (a) bes2 bes g a1 \silB g2 g f g1
        } \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 (f) ees d c2 bes4 (d) ees2 ees d1 \resp s2 g,4 (bes) c2 d g,1\fermata
        } 
      }
   >>
>>