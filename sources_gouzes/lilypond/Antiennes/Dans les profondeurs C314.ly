\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key f\major \time 2/2 \cadenzaOn \tempo "Grave et large" 2 = 58
          f4 e f d e2 d4 c d2 \breathe \allowBreak f4 f g2 g4 a a2\fermata\breathe\allowBreak
          a4 a d d c2. \breathe\allowBreak c4 a2. a4 bes2 a a\fermata\bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d4 c d bes c2 a4 a a2 d4 d d2 f4 e f2
          f4 f f g a2. a4 fis2. fis4 g2 e fis!
        }   \tonIcf       
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Dans les pro -- fon -- deurs de la mort, le Sei -- gneur a veil -- lé. 
      Il s’est re -- le -- vé, au -- ro -- re du sa -- lut.
   }
%{     \new Lyrics \lyricmode
   { \set associatedVoice = #"soprano"
      
   }
 %}   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f\major \time 2/2 \cadenzaOn
          a4 a bes bes g2 f4 e f2 a4 a bes2 bes4 c c2
          c4 c d d e2. e4 d2. d4 d2 cis d
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d4 a g g' c,2 d4 a d2\breathe d4 c bes2 d4 c <f, f'>2\fermata\breathe
          f'4 e d bes' a2. \breathe a4 d,2. d4 g2 a d,\fermata
        }\tonIch
      }
   >>
>>