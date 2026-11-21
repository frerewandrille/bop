\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose d c
\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         f8\rest [d8 d] d ([f g]) a4. ( d8 [c b] a4.\fermata ) \bar"|"
         r8 d8 d4. e8 [c b] c4 (b8) a4.\resp 
         a4 b8-- g4. g4 a8-- a4.\fermata
         \bar"|."
       } \tonIef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         s8 [d d] d4 (e8) f4. (d4 e8 f4.)
         r8 g8 g4. g8 [g g] g4. f 
         f4 f8 e4. e8 ([d)] e f4.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Hon -- neur, gloire et lou -- an -- ge 
     à l’A -- gneau im -- mo -- lé_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          r8 [d8 d] d ([c b]) a4.~ (a8 [b c] d4.)
          r8 b8 b4. c8 [c d] e4 (d8) c4.
          c4 d8 b4. b4 c8 d4.
        } \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d\breve*1/8 (s s s s s d4.\fermata)
          r8 g8 g4. c,8 [e g] e4. f\resp
          f8 ([e]) d-- e ([d c]) e [(f)] e-- d4.\fermata
        } 
      }
   >>
>>