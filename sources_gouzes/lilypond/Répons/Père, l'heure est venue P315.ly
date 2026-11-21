\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très calme et menuré"
         g4 (a8 [e]) g2 4 a8 [b] 2\fermata\resp
         g8 [g g] g [a e] g4. 8 \allowBreak
         g [fis] e [d] g [a] g4. \allowBreak
         8 g [a] b [c] b4 4.\resp c8 c ([b]) a ([b]) g4\resp
         e8 ([d]) g4. (a8) b ([c] a [b]) g2\fermata         
         \bar"|."
       } \tonVIef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e2 d d4 c8 [d] 2 d8 [d d] e [e e] d4. 8 c [c] c [c] c [c] d4. 
         8 e [e] d [d] 4 4. e8 4 4 4 c b2 d8 ([e] d [c]) b2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pè -- re, l'heure est ve -- nue.
     Glo -- ri -- fie_- moi te la gloi -- re que j'a -- vais au -- près de toi
     a -- vant que fût le mon -- de, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 (a) g2 4 e8 [fis] g2 8 [g g] g [g g] g4. 
          8 e [fis] g [fis] e [fis] g4. 8 g [g] fis [fis] g4 4.
          a8 a ([b]) c4 b g g2 fis8 ([g] fis4) g2
        } \tonVIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e8 ([d] c4) b2 4 a8 [a] g2\fermata\resp
          b8 [b b] c [c c] b4. 8 a [a] a [a] a [a] g4.
          8 c [c] d [d] g,4 4.\resp
          e'8 4 e e\resp e d2 8 ([c] d4) g,2\fermata
        } 
      }
   >>
>>