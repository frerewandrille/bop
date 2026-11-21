\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key ees \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Allant" 2 = 63
          g2 bes4 c2 c4 d2 d4 bes2. bes4-> c bes bes2. g\resp
          g4->^\markup{\dynamic pp \italic " calme" } g g f2. f4-> f f aes2. g
          \bar"|."
        } \transpose a bes \tonVgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          ees2 g4 aes2 aes4 f2 f4 g2. g4 aes g f2. ees
          ees4 ees ees c2. d4 d d c2 (d4) ees2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      De mes pè -- res, j’ai re -- çu l’in -- te -- li -- gen -- ce 
      pour me tour -- ner vers ta Pa -- ro -- le.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 ees4 ees2 ees4 d2 d4 ees2. ees4 ees ees d2. ees
          bes4 bes bes aes2. bes4 bes bes aes2. bes
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          ees2 ees4 aes2 aes4 bes2 bes4 ees,2. ees4-> aes ees bes'2. ees,\resp
          ees4-> ees ees f2. bes,4-> bes bes f'2. ees
        } \transpose a bes \tonVgh
      }
   >>
>>