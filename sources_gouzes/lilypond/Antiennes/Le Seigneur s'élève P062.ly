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
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Vif"
         f8 [f] a [bes] c4 4\resp bes8 [a] g ([a]) f4\fermata\bar"|"
         f8 [g] f [d] f [g] bes4 (c8 [d] c [bes]) c4\fermata\resp
         a8 ([c]) bes [a] g [f] g4\resp d8 [ees] f ([g]) f2\fermata
         \bar"|."
       } \tonVIIIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f8 [f] f [f] f4 f ees8 [8] 8 ([d]) c4 d8 [c] d [c] d [c16 (d)]
         ees8 ([f] g [f] ees16 [f g8]) f4
         f8 ([d]) ees [f] f [d] ees4 c8 [c] d ([c]) c2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Sei -- gneur s’é -- lè -- ve, al -- lé -- lu -- ia_! 
     Par -- mi les chants d’al -- lé -- gres -- se_! 
     Chan -- tons pour no -- tre Dieu_: al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f8 [f] f [g] a4 4 bes8 [8] c ([bes]) a4
          a8 [bes] a [bes] a [bes] g4. (a8 bes [d]) c4
          8 ([a]) bes [c] d [c] bes4 a8 [a] a ([bes]) <a c>2
        } \tonVIIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 [f] f [f] 4 4\resp g8 [g] ees4 f\fermata
          8 [ees] f [g] f [ees16 (d)] d8 ([d] ees [f] g [bes]) a4\fermata\resp
          8 ([f]) g [a] bes [a] g4\fermata f8 [f] f ([ees]) f2\fermata
        } 
      }
   >>
>>