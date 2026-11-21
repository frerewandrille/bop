\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 2/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Large"
         a2 4 4 g2 e4 f g2 e4 f d1\fermata\bar"|"
         e2 f4 a g f g2\resp e4 f g2 (f4 e) d2\fermata
         \bar"|."
       } \tonIcf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f2 4 4 e2 d4 4 c2 4 4 bes1 c2 
         4 f8 ([e]) d4 4 c2 4 4 d2. (c4) a2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Je ne vous lais -- se -- rai pas or -- phe -- lins.
     Je re -- vien -- drai vers vous, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 4 4 2 bes4 a g2 4 a8 ([g]) f1
          g2 f4 c' bes a g2 4 a bes2 (a4 g) f2
        } \tonIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 (e8 [f]) g4 a bes (a) g f e (d) c8 ([bes]) a4 bes (c d2\fermata)
          c4 (bes) a8 ([bes]) c4 d8 ([e]) f4 e2\resp
          c8 ([bes]) a4 g2 (a8 [bes] c4) d2\fermata
        } 
      }
   >>
>>