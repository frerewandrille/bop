\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Recueilli"% 2 = 52
         r8 g [a] b ([c]) b2\resp b8 [c] d [e] d [c] b4 a8 ([c]) b4\fermata
         b8 [a] c [a] g [a] b [a] g4\resp f8 [g] a ([g]) g2\fermata\bar"|"
         g8 [b] c [d] d2\fermata\resp a8 [b] c [b] a4 b8 [a] g4 g\bar"|"
         f8 [e] f ([g]) g4 g8 [f] e4 e2\fermata
         \bar"|."
       } \tonIVbf
       %\tonIIIgf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e\breve*9/16 e8 [e] f [f] g [g] f4 f16 ([e d8]) e4
         e8 [e] d [d] e16 ([d) c8] d [c16 (d)] e4 d8 [e] f16([e d8]) d2
         d8 [d16 (e)] f8 [f] g2 e8 [e] f [f] f4 e8 [e] e4 e
         d8 [d] d ([e]) d4 c8 [d] d ([c]) b2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Tu as vi -- si -- té la terre, ô Christ,
     et l’as fé -- con -- dée de ton Es -- prit, al -- lé -- lu -- ia_!
     Don -- ne_- nous ta joie, pour que no -- tre joie soit par -- fai -- te,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          r8 g [a] b ([c]) b2 b8 [b] a [a] g [g] a4 a b
          b8 [b] a [a] b [b] a [a] b4 c8 [b] c ([b]) b2
          d8 [b] a [a] b2 c8 [c] d [d] d4 c8 [c] d4 d
          c8 [c] c ([b]) a4 a8 [a] b ([c]) b2
        } \tonIVbh
        %\tonIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e\breve*9/16\resp g8 [g] f [f] e [e] d4 f g\fermata
          g8 [g] f [f] e [e] f [f] g4\resp a8 [g] f ([g16 a]) b2\fermata
          b16 ([a) g8] f16 ([e) d8] g2\fermata\resp
          g\breve*3/8 g8 [a] b4 b 
          a8 [a] a ([g]) f ([e]) d16 ([e) f8] g ([a]) e2\fermata
        } 
      }
   >>
>>