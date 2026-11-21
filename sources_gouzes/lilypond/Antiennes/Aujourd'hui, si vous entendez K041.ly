\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 4 = 104
         bes8 ([a]) bes ([c]) bes2 \allowBreak bes8 [bes] bes [a] g2 fis g4 \breathe
         g8 [a] bes4^> bes a2 g4^> fis g1\fermata         
         \bar"|."
       } \transpose a g\tonIIIaf% Sans ton dans l’original (invitatoire)
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         g4 g g2 g8 [g] g [fis] d2 d d4 d8 [f] f4 f f2 d4 d d1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Au -- jour --\apostrophe d’hui, si vous en -- ten -- dez sa voix, 
     n’en -- dur -- cis -- sez pas vo -- tre cœur.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 ([c]) d ([ees]) d2 d8 [d] d [c] bes2 a bes4 bes8 [c] d4 d c2 bes4 a bes1
        }\cadenzaOn \transpose a g\tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g g2 g8 [g] g [d] d2 d g4 \breathe 
          g8 [f] bes,4-> bes f'2 g4-> d g1\fermata
        } 
      }
   >>
>>