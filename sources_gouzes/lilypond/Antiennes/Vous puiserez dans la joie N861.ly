\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose c a,
\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn
         c8 ([bes]) a ([bes]) c ([d]) c4.\fermata\bar"|"
         c8 d [bes] c4 8 [bes] a4.\fermata\resp
         bes8 ([a]) g [a] bes [c] bes4\fermata\bar"|"
         a8 ([bes]) c ([g]) f4 4\fermata
         \bar"|."
       } \transpose b c' \tonVIIcf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         a8 ([g]) f ([g]) a ([bes]) a4. f8 f [g] f4 8 [d16 (e)] f4.
         4 d8 [d] g [g] f4 4 4 ees8 ([d]) c4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_! Vous pui -- se -- rez dans la joie
     aux sour -- ces du sa -- lut_! Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c8 ([d]) ees ([d]) c ([bes]) c4. 8 bes [d] c4 8 [bes] c4.
          d8 ([c]) bes [c] d [ees] d4 c8 ([d]) ees ([d]) c ([bes]) a4
        } \transpose b c' \tonVIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*6/16 4.\fermata a8 g [bes] a4 8 [g] f4.\fermata\resp
          f\breve*6/16 4\fermata 4 4 4 4\fermata
        } 
      }
   >>
>>