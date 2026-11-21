\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }


\transpose g d
\new ChoirStaff
<< \new Staff 
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn 
         g2-> fis8 [g] a2-> 4 bes-> (a) g fis2\fermata\resp
         fis!4 g2. a bes\fermata\bar"|"
         d2-> 8 [8] f4-> f f d2-> (c4) bes2-> \resp
         bes4-- d2-- c4-- 2.--\fermata
         \bar"|."
       } \transpose e g \tonVIIbf %orig. \transpose e g \tonIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d2 8 [8] f2 4 2 d4 2 4 2. f f2.
         2 8 [8] 4 4 4 2 (fis4) g2 4 2 4 a2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Christ est res -- sus -- ci -- té des morts, il ne meurt plus_!
     Al -- lé -- lui -- a, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff 
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 a8 [bes] c2 4 d (c) bes a2 4 bes2 (a8 [bes]) c4 (bes c) d2.
          2 8 [8] c4 c c d2. 2 4 e2 4 f2.
        } \transpose e g \tonVIIbh %orig. \transpose e g \tonIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2-> d8 [g] f!2-> 4 d-> (f) g d2\fermata \resp
          4 g2. f! bes,\fermata
          bes'2-> 8 [8] a4-> 4 4 bes2-> (a4) g2-> \resp 
          g4-- 2-- 4-- f2.\fermata
        } 
      }
   >>
>>