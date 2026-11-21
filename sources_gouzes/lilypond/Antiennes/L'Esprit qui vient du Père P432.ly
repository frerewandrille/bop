\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Calme"
         f8 f4. e8 d [c] d ([f]) f4.\fermata\resp
         f8 e [f] g [a] a ([g]) g4.\resp
         g8 g [f] g4 a8 [g] d4.\resp\bar"|"
         f8 f [e] f ([g] f4)\resp d8 [c] d ([e]) e2\fermata
         \bar"|."
       } \tonIVaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d8 d4. b8 a [a] a16 ([b c8]) d4. 8 8 [8] e [d] d ([e]) e4.
         8 e [d] e4 d8 [e] d4. 8 d [d] d2 8 [c] d4 e2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     L’Es -- prit qui vient du Pè -- re me ren -- dra té -- moi -- gna -- ge,
     et vous se -- rez mes té -- moins, al -- lé -- lu -- ia, al -- lé -- lu -- ia.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a8 4. g8 f [e] f16 ([g a8]) 4. 8 b [a] b [c] c ([b]) 4.
          8 b [c] b4 c8 [b] a4. 8 a [g] a ([b] c4) 8 [c] c ([b]) a2
        } \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d\breve*12/16\resp d8 g [g] g [f] f ([g]) g4.\resp
          8 g [a] g4 f8 [g] d4.\fermata 8 d [d] f4 (a)\resp 8 [a] a4 a2\fermata
        } 
      }
   >>
>>