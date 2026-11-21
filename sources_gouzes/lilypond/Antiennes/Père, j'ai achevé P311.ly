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
       { \clef "treble" \armure \cadenzaOn \tempo "Très calme"
         f4 2 \resp f8 [e] d [e] d4 2.\fermata\resp
         c4 d8 [f] e [d] c2\fermata\bar"|"
         f4 (a8) [g] a [b] a2\fermata\resp
         f4 a8 ([g]) a ([b]) a4\fermata\resp f g8 [a] g [f] g [g] d4\resp
         e8 ([g]) f ([e]) d4 2\fermata
         \bar"|."
       } \tonIef
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d4 2 8 [c] bes [bes] a4 2. 4 g8 [g] bes [8] a2
         a8 ([b] c) [e] f [e] f4 (e) d d8 ([e]) f16 ([e d e]) f4
         d e8 [d] e [f] e [d] c4 d d c a2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pè -- re, j’ai a -- che -- vé l’œu -- vre que tu m’a -- vais don -- née.
     Glo -- ri -- fie ton Fils, al -- lé -- lu -- ia,
     pour que ton Fils te glo -- ri -- fie, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 2 a8 [a] f [g] f4 2. e4 d8 [d] g [f] e2
          f8 ([g] a) [b] c [b] c2 8 ([b]) c ([b]) c ([b]) c4 
          4 b8 [b] c [c] b [b] a4 b c8 ([b]) a ([g]) a2
        } \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 2 \resp d8 [a] bes [g] a4 2.\fermata\resp
          a4 bes!8 [bes] g [g] a2\fermata
          d4 (f8) [g] f [g] a2\fermata\resp
          a8 ([g]) f ([g]) f ([g]) f4\fermata\resp
          a g8 [g] a [a] g [g] f4\resp
          g a8 ([g]) f ([e]) d2\fermata
        } 
      }
   >>
>>