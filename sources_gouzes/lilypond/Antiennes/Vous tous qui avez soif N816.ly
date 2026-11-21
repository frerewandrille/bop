\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose f c
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         f8 [g a] a4\fermata (c8 [b a] c4\fermata d8 [e] c4\fermata a\fermata)\bar"|"
         c8 ([b]) a4.\fermata c8 d [e] c4.\fermata\resp
         c8 b [c] a4.\fermata\resp 
         a8 g [a] b [b] a4\fermata g\fermata f\fermata
         \bar"|."
       } \tonVbf
     }
     \new Voice = "alto" 
      { \voiceTwo \relative c'
       { 
         d8 [f f] f4~ (f8 [g a] f2 a8 [g] f4)
         a8 ([g]) f4. a8 b [c] a4. a8 g [g] f4. 
         f8 e [f] e [d] c ([d]) e4 a
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Vous tous qui a -- vez soif,
     ve -- nez à moi_!
     Bu -- vez aux sour -- ces de la vie_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          f8 [e d] d4~ (d4.~ d4 b c d)
          d4 d4. d8 d [c] d4. d8 d [d] d4. d8 d [c] b [b] c4 b c
        } \tonVbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 [f f] f4\fermata (a8 [b c] a4\fermata g f~\fermata f\fermata)
          a8 ([b]) c4.\fermata a8 g [g] f4.\fermata\resp
          a8 b [b] c4.\fermata\resp
          c8 b [a] g [g] a4\fermata g\fermata f\fermata
        } 
      }
   >>
>>