\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose f d
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         f8 [bes] a ([bes]) g ([a] g4.\fermata)\bar"|"
         bes8 a [g] a [bes] c ([d] c [bes]) c4.\resp
         d8 ees [d] c ([bes]) c4\fermata\bar"|"
         a8 [bes] c ([bes]) a4 (g8 [f]) g4 bes8 ([a]) g4 g\fermata
         \bar"|."
       } \tonIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f8 [bes] a ([bes]) g ([a] g4.)
         g\breve*1/16 s s s s g2 a4. bes8 g [bes] g4 g 
         f8 [f] g4 f (d) d8 ([ees]) f4 ees8 ([d]) d4
       }    
     }
   >>
   \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_! Je mon -- te vers mon Pè -- re
     et vo -- tre Pè -- re_! Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 [d] ees4 c (d4.) d8 c [d] ees [f] ees ([d] c [d]) f4.
          f8 ees [f] ees ([f]) ees4 
          d8 [d] ees4 d4. (c8) bes ([c]) d ([c]) c4 bes
        } \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes\breve*1/4 bes4~ bes4.\fermata
          g8 a [bes] c [d] c ([bes] a [g]) f4. \resp
          bes8 c [d] c ([d]) c4\fermata
          d8 [d] c4 d8 ([c] bes [a]) g4 d8 ([f]) g4 g\fermata
        } 
      }
   >>
>>