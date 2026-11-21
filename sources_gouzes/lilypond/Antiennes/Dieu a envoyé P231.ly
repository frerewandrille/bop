\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose c g,
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn% \tempo "" 2 = 52
         c8 [a] b [c] c4 b8 [c] d4 d8 [c] d [e] d4\resp
         c8 [b] a [g] a4. a8 c4\resp g (f8 [g]) a4\bar"|"
         g4 a8 ([g]) f4 f2\fermata
         \bar"|."
       } \tonVbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e8 [e] f [f] e4 a8 [a] a4 a8 [a] a16 ([g) f (e)] f4
         f8 [f] e [e] d4. d8 f4 e (c8 [e]) f4 e f8 ([e]) d4 c2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Dieu a en -- vo -- yé dans nos cœurs l’Es -- prit de son Fils
     qui nous fait cri -- er_: "“Ab" -- "ba”," Pè -- re.
     Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e8 [c] d [d] c4 d8 [e] f4 d8 [d] c [c] d4
          d8 [d] b [b] c4. c8 d4 d (c8 [b]) c4
          d c8 [(d)] c ([b]) a2
        } \tonVbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a8 [a] a [a] a4 g8 [g] f4 f8 [f] a [a] a4\resp
          a8 [a] g [g] g4. f8 a4\resp b4 (a8 [g]) f4
          b4 a8 ([b]) a ([g]) f2\fermata
        } 
      }
   >>
>>