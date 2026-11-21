\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn
         r8 [bes8 8] 8 ([c bes]) bes4.\fermata (f\fermata)\bar"|"
         a8 [c] bes [c] bes4\resp 8 [a] g [bes] 8 ([c] bes [a]) bes4\fermata\resp
         8 [a] g4 8 [f] a ([f]) g4\fermata\bar"|"
         8 ([f]) d ([ees]) f ([g]) f4\fermata
         \bar"|."
       } \tonVIIIcf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         r8 [f f] g4. g (f) 8 [f] d [ees] f4 d8 [d] ees [8] d4 (ees) f4
         8 [f] d4 ees8 [d] c ([d]) ees4 8 ([d]) 4 8 ([ees16 d]) c4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_! Le Sei -- gneur Jé -- sus siè -- ge dans la gloi -- re,
     à la droi -- te du Pè -- re_! Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a8\rest [d d] ees4. 4. (d) c8 [a] bes [c] bes4 8 [8] c [c] bes4 (c) bes4
          8 [c] bes4 8 [a] 4 bes4 8 ([a]) bes4 c8 ([bes]) a4
        } \tonVIIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          \once \hide r8 [bes8 8] 4. 2.\fermata f8 [f] g [c,] d4\resp 
          g8 [g] c, [c] d4 (ees) d\fermata\resp
          8 [f] g4 ees8 [f] 4 ees\fermata 8 ([f]) g4 8 ([ees]) f4\fermata
          % original : 8 [f] g4 ees8 [f] 4 ees\fermata 8 ([f]) g4 a8 ([ees]) f4\fermata
        } 
      }
   >>
>>