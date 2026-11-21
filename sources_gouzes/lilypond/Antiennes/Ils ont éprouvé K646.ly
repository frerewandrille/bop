\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose d b,
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Marqué" 2 = 63
          d4^\f^> d ees ees d c d2 b4 b b^> b c2^>^\< (b!)^\> b\fermata\!\resp 
          g4^>^\p g g g g2 g^\pp fis g1\fermata
          \bar"|."
        } \transpose a c' \tonIVff
        %\tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g g g g fis g2 g4 g g g a1 g2 d4 d d d ees2 d d d1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ils ont é -- prou -- vé le Jus -- te par des ou -- tra -- ges_! 
     Nous a -- vons con -- nu sa dou -- ceur.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 b c c b! c b2 d4 d d d ees2 (d) d b!4 b b b c2 bes a b1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4_> g c, c g' a g2 g4 g g_> g fis2_> (g) g\fermata\resp 
          g4_> g g g c,2 d d g1\fermata
        } \transpose a c' \tonIVfh
        %\tonIIah
      }
   >>
>>