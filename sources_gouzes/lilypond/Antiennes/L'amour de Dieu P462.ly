\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         f8 (d) [c] f [(g)] f4.\resp 
         f8 g [f] f4 f8 [a] bes ([a]) g [a] f4 g8 [f] f4\fermata\resp
         g8 [f] g ([a]) f4.\fermata\bar"|"
         f8 d [c] f4 g8 [a] bes [a] g [f] g4\resp g8 [a] bes ([a]) g4\resp
         g8 [a] f4\fermata f\fermata         
         \bar"|."
       } \tonVIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f8 (d) [c] f [(g)] f4. d8 e [d] d4 d8 [f] g4 d8 [e] e4 d8 [d] d4
         d8 [d] d ([e]) d4. d8 d [c] d4 d8 [f] g [f16 (e)] d8 [d] d4
         d8 [e] f8. ([e16]) d4 d8 [e] d4 c
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     L’a -- mour de Dieu a é -- té ré -- pan -- du en nos cœurs, al -- lé -- lu -- ia_!
     par l’Es -- prit Saint qui nous a é -- té don -- né,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f8 (d) [c] f [(g)] f4. 
          d'8 c [d] d4 bes8 [c] d ([c]) bes [c] bes4 bes8 [c] d4
         bes8 [c] bes ([c]) c4.
         c8 bes [bes] a4 bes8 [c] d [c] bes [c] bes4
         bes8 [c] d ([c]) bes ([c]) bes [c] c ([bes]) a4
        } \tonVIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 (d) [c] f [(g)] f4.\resp
          bes8 bes [bes] bes4 bes8 [a] g4 g8 [c,] d4 g8 [a] bes4\fermata\resp
          g8 [a] g4 a4.\fermata
          a8 g [g] f ([e]) d [d] d16 [(e) f8] g [a] bes4\resp
          g16 [(f) e8] d16 ([e f8]) g ([a])\resp bes [bes] a ([g]) f4\fermata
        } 
      }
   >>
>>