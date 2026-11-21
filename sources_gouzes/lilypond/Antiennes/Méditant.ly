\version "2.24.0"
%\include "TonsDef.ly"

resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     a4 g f2^\< a4 bes c2\! c4 c d2 a4^\> bes c2\!
     c2^\< c4 c f,2\! f4 f bes2^\> 
     bes4 a g2.\! a4^\< f2\> g a1\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 2/4 \cadenzaOn \tempo "Calme" 4 = 76
          a4 g f2 a4 bes c2 c4 c d2 a4 bes c2 \resp
          c2 c4 c f,2 f4 f bes2 \allowBreak
          bes4 a g2. a4 f2 g a1\fermata
          \bar "|."
        } \transpose b a \tonIIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          f4 e d2 e4 d e2 e4 e d (e) f8 ([e]) d4 e2
          e e4 e d2 d4 d d2 d8 ([e]) f4 e2. e4 d2 d cis1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
     Mé -- di -- tant jour et nuit ta pa -- ro -- le, Sei -- gneur, 
     il a bâ -- ti sa mai -- son sur le roc de ton a -- mour.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 3/4 \cadenzaOn
          c4 c a2 a4 g a2 a4 a g2 a4 g a2 a a4 g f2 f4 f g2 g4 c c2. c4 a2 d, e1
        } \transpose b a \tonIIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          f4 c d2 c4 bes a2 a4 a bes2 d4 bes a2 \resp
          a a4 a bes2 bes4 a g2 g4 f c'2. c4 d2 bes a1\fermata
        }
      }
   >>
>>