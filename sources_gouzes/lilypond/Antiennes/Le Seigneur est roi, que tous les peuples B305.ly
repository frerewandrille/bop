\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose f d
\new ChoirStaff
<<  \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn  \tempo 4 = 76
         f8-- [f--] g-- [bes--] c2-- \bar"|"
         \tempo "Vif" ees8 [ees16 ees] ees [ (d) c bes] c4 c8 [g] bes2\fermata
         \bar"|."
       } \tonVIIIhf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f8 [f] ees [ees] c2 g'8 [g16 g] g [(bes) g f] ees4 g8 [ees] <d f>2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Sei -- gneur est roi_!
     Que tous les peu -- ples cé -- lè -- brent son Nom_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f8 [f] bes [bes] a2 bes8 [bes16 bes] bes8 [c16 d] ees4 c8 [c] d2
        } \tonVIIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8-- [f] ees-- [g--] f2-- ees8 [ees16 ees] ees [(g) ees d] c4 ees8 [c] bes2\fermata
        } 
      }
   >>
>>