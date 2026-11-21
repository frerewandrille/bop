\version "2.24.0"
\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes4 \unHideNotes \allowBreak }
armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }


\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "president" 
  { \armure \relative c'' { 
    \cadenzaOn bes\breve*1/8 a4 a8 [g] bes2\fermata \bar"||"}
  }
  \new Lyrics \lyricsto "president"
  { \gauche Bénis -- sons le Sei -- gneur_! }
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          bes\breve*1/8 \ss a2 a bes1\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g\breve*1/8 s g2 fis g1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Nous rendons grâce à Dieu_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d\breve*1/8 s ees2 d d1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*1/8 s c,2 d g1\fermata
        } 
      }
   >>
>>