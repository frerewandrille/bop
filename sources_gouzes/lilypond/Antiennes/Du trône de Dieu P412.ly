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
         f8 f [a] a4. bes8 g [a] f4.\fermata\resp
         c'8 bes ([g]) a [g] f4.^\markup\italic"rall." ees8 f [g] f2.\fermata\bar"|"
         f8 [f] a [bes] c4 c8 [bes] c4 c4.\resp
         d8 ees ([d]) c ([bes]) c4.\bar"|"
         c8 c4. f,8 g [bes] a [g] f4 f\resp g8 [a] g ([f]) f2\fermata
         \bar"|."
       } \transpose a c' \tonVIIaf
       %\transpose a bes \tonVIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c8 c [c] d4. d8 d [c] c4. 
         f8 d ([ees]) ees [ees16 (d)] c4. c8 d [c] c2.
         d8 [d] d [d] ees ([f]) g [d16 (ees)] f4 f4. 
         f8 g ([f]) ees ([g]) f4.
         f8 f4. d8 ees16 [(d) c8] d [ees] f4 f 
         ees16 [(d) c (d)] ees ([d c8]) c2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
     Du trô -- ne de Dieu et de l’A -- gneau 
     a jail -- li un fleu -- ve d’eau vi -- ve,
     al -- lé -- lu -- ia_!
     C’est lui qui sanc -- ti -- fie l’É -- gli -- se, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a8 a [a] bes4. bes8 bes16 [(a) g8] a4. 
          a8 bes4 c8 [bes] a4. bes8 a [bes] a2.
          c8 [d] c [g] g4 g16 [(a) bes8] a [(bes)] c4. 
          d8 bes4 bes16 ([c d8]) c4.
          c16 ([bes]) a4. c8 bes [g] a [bes] c4 c 
          bes8 [g16 (a)] bes8 [(c16 bes)] a2
        } \transpose a c' \tonVIIah
        %\transpose a bes \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 f [f] f4. f8 ees [ees] f4.\fermata\resp
          f8 g16 ([f ees d]) c [(d) ees8] f4. g8 f [ees] f2.\fermata
          a16 [(c) bes (a)] g [(f) ees (d)] c8 ([d]) ees16 [(f) g8] f ([g]) a4.\resp
          bes16 ([a]) g ([f ees f]) g8 ([bes]) a4.
          a16 ([g]) f4. a8 g16 [(f) ees8] f [g] a4 a\resp
          g16 [(f) ees (f)] g8 ([a16 g]) f2\fermata
        } 
      }
   >>
>>