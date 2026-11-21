\version "2.24.0"

\include "vowel-set.ly"

ss = { \hideNotes bes4 \unHideNotes \allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "" 2 = 52
          bes\breve*1/8 \ss \ss \ss bes4^- bes8 [bes] a\breve*1/8 \ss \ss bes4 bes 
          \breathe \allowBreak
          c4 c a2 \allowBreak a8 [a] \allowBreak a4^\markup\italic"rall." a bes2\fermata \bar"||"
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g\breve*1/8 \ss \ss \ss g4 g8 [g] fis\breve*1/8 \ss \ss g4 g 
          g4 g f2 f8 [f] fis4 fis g2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Gloire à toi, ô Christ, qui nous montres la lu -- miè -- re_! 
     Gloire à Dieu au plus haut des cieux_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \minor \time 3/4 \cadenzaOn
          d\breve*1/8 \ss \ss \ss d4 d8 [d] d\breve*1/8 \ss \ss d4 d 
          e4 e c2 c8 [c] d4 d d2 
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*1/8 \ss \ss \ss g4_- g8 [g] d\breve*1/8 \ss \ss g'4 g \breathe 
          c,4 c f2 f8 [f] d4 d g2\fermata         
        }
      }
   >>
>>