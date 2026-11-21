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
    \cadenzaOn bes8 a2\resp a\breve*1/8 \ss \ss \ss g8 bes2\fermata \bar"||"}
  }
  \new Lyrics \lyricsto "president"
  { En paix, \gauche prions et supplions le Sei -- gneur_!_}
>>

\new StaffGroup
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         bes8 [bes] bes [bes] bes4. bes8 bes4 
         \(a\) bes8 bes [bes] a2 a bes1
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g8 [g] g [g] g4. g8 g4 \(fis\) g8 g [g] g2 fis! g1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ky -- ri -- e e -- le -- i -- son, 
     Ky -- ri -- e e -- le -- i -- son_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 [d] d [d] d4. d8 d4 \(d\) d8 d [d] ees2 d d1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 [g] g [g] g4. g8 g4 \(d\) g8 g [g] c,2 d <g, g'>1
        } 
      }
   >>
>>

\new Staff \with {\remove Time_signature_engraver }
  { \armure \relative c'' { 
    \cadenzaOn bes\breve*1/8 g4 \bar"|" bes\breve*1/8 g8 a4 \bar"|" 
    a\breve*1/8 g8 bes2 \bar"||"}
  }


\new StaffGroup
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          bes\breve*1/8 \ss \ss bes4.\resp  g8 a2 a bes1
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g\breve*1/8 \ss \ss g4. e8 f2 fis g1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     À toi, Sei -- gneur, à toi, Sei -- gneur_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d\breve*1/8 \ss \ss d4. c8 c2 d d1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*1/8 \ss \ss g4.\resp c,8 f2 d <g, g'>1
        } 
      }
   >>
>>