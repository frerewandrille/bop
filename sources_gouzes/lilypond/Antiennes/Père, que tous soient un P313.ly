\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2 = 52
         g8 ([c] a [g] a [b]) b4\fermata\resp c d8 [c] b4.\fermata\resp
         c8 a [g] a [b] 4\resp c8 [a] b ([a]) g2\bar"|"
         g4 a8 [c] b4 g a8 [a] g4\fermata 8 
         [f] d [a'] b [b] a4 b a8 [g] a [g] d4.\fermata\resp
         f8 4 (g8 [f]) d4 2\fermata
         \bar"|."
       } \transpose d a, \tonIff % \tonIIIgf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         g4 (f e) e d8 ([e]) f16 [(e) d8] e4. d8 e [e] d [d] e4 d8 [f] d4 e2
         4 f8 [d] e4 8 ([d]) c [d] e4 8 [d] d [d] d [e] f ([e]) d4
         e8 [e] d [e] d4. 8 4 (e8 [d]) c4 d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pè -- re, que tous soient un, com -- me nous som -- mes un, al -- lé -- lu -- ia_!
     Tu es en moi et moi en eux,
     a -- fin que le mon -- de croie que tu m’as en -- vo -- yé, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g4 (a b) b a8 ([g]) f [a] b4. a8 b [d] c [c] b4 a8 [c] b ([c]) d2
          4 c8 [c] b4 4 a8 [b] 4 8 [b] a [a] g [g] a4 g8 ([a]) b [b] c [b] c4.
          b8 c4 (b) a8 ([g]) a2
        } \transpose d a, \tonIfh % \tonIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2. 4\fermata\resp f8 ([e]) d [f] g4.\fermata\resp
          f8 g [b] a [a] g4\resp f8 [a] g ([a]) b2
          4 a8 [a] g4 8 ([f]) e [f] g4\fermata 8 [g] f [f] e [e] d4
          e8 ([f]) g [g] f [g] a4.\fermata\resp
          8 4 (g) f8 ([e]) d2\fermata
        } 
      }
   >>
>>