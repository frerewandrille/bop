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
       { \clef "treble" \armure \cadenzaOn
         f8 f [bes] g [f] ees4 f8 ([g]) f4\fermata\resp
         8 [g] 4 ees8 [g] g ([f]) f4. \resp 
         8 g [bes] 8 [g] bes [c] 4\fermata\resp
         8 [d] bes ([a]) g4\resp bes8 [g] f4\fermata f\fermata
         \bar"|."
       } \tonVIIIgf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f8 f [bes] g [f] c4 d8 ([c]) d4 8 [ees] 4 c8 [c] d ([c]) c4.
         c16 ([d]) ees8 [f] ees [8] d [ees] f4 8 [f] g16 ([f ees8]) 16 ([d c8])
         d [ees16 (d)] c4 4         
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Je suis sor -- ti de toi, Pè -- re et ve -- nu dans le mon -- de. 
     Et main -- te -- nant, je viens à toi, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f8 f [bes] g [f] bes4 a8 ([bes]) a4 8 [bes] c4 bes16 [(a) g8] a8 ([bes]) a4.
          8 bes [8] c [bes] 8 [8] a4 8 [bes] 8 ([c]) bes4
          8 [8] 4 a
        } \tonVIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 f [bes] g [f] g4 f8 ([ees]) f4\fermata\resp
          8 [ees16 (d)] c8 ([d]) ees8 [8] f ([g]) f4.\resp
          8 ees [d] c16 [(d) ees (f)] g8 [g] f4\fermata\resp
          16 [(ees) d8] ees16 ([d c d]) ees4\resp
          g16 [(f) ees8] f ([g]) f4\fermata
        } 
      }
   >>
>>