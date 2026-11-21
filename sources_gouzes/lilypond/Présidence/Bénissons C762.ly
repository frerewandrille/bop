\version "2.24.0"
\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes4 \unHideNotes \allowBreak }
armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "president" 
  { \armure \relative c'' { 
    \cadenzaOn g\breve*1/8 \ss fis8 [e] g4\fermata \bar"||"}
  }
  \new Lyrics \lyricsto "president"
  { \gauche Bénissons le Sei -- gneur_! }
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          b4-! b-! b-! c8-. ([b-.] a-. [b-.] c4-.) c b2.\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 4 4 2. fis4 g2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Nous ren -- dons grâce à Dieu_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d d e8-. ([d-.] c-. [d-.] e4-.) d d2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4-! g-! g-! 2 (c,4) d g2.\fermata
        } 
      }
   >>
>>