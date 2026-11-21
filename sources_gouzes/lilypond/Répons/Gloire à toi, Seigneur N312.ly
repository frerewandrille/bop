\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn
         f2-> 4 g2-> 8 [g] bes4-> 4 a bes2.->\resp
         c2-> 8 [c] d4-> d d bes-> c d c2-> 4\bar"|"
         f,2 8[f] g4-> g g bes2 (a4) bes2.\fermata
         \bar"|."
       } \tonVIIIgf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d2 4 ees2 8 [8] d4 f f f2. 2 8 [f] 4 4 4 d d d e2 4
         c2 8 [c] ees4 4 4 d (f2) 2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Gloire à toi, Sei -- gneur res -- sus -- ci -- té_:
     par ta lu -- miè -- re, tu don -- nes la vi -- e_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 4 2 8 [8] 4 c c d2. a2 8 [a] bes4 4 4 4 4 4 c2 4
          a2 8 [a] bes4 4 4 4 (c2) d2.
        } \tonVIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          bes2-> 4 ees2-> 8 [8] g4-> f f bes,2.->\resp
          f'2-> f8 [f] bes,4-> d f g-> g g c,2 4
          f2-> 8 [f] ees4-> 4 4 g-> (f2) bes,2.\fermata
        } 
      }
   >>
>>