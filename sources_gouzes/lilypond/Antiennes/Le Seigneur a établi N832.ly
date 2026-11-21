\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose d c
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn
         d8 [c] a' ([b]) a4\fermata\bar"|"
         a8 [a] a4. a\breve*1/8 g8 [a] c ([d] c [b]) a4.\fermata\resp
         e8 g [f] e4. \bar"|" g8 f ([e]) d4\fermata d\fermata
         \bar"|."
       } \transpose d a, \tonIff %\tonIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d\breve*4/16 d4 g8 [g] f4. f\breve*1/8 e8 [f] e ([f] e [g]) f4.
         e8 c [d] e4. e8 c4 b8 ([c]) d4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_! 
     Le Sei -- gneur "a éta" -- bli son Rè -- gne à tout ja -- mais_!
     Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a8 [g] a ([c]) d4 e8 [e] d4. d\breve*1/8 e8 [d] c ([a] c4) d4.
          b8 a [a] b4. b8 a4 g8 ([a]) b4
        } \transpose d a, \tonIfh %\tonIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d\breve*4/16 d4\fermata 
          e'8 [e] d4. d\breve*1/8 a8 [a] a2 d,4.\fermata\resp
          e8 f8 [f] g4. e8 f4 g\fermata g\fermata
        } 
      }
   >>
>>