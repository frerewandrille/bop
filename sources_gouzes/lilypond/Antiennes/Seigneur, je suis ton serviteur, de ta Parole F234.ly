\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose bes g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2 = 69
          bes2 bes4 a g f g a a2\fermata\resp 
          bes bes4 bes c2 c\fermata\allowBreak c4 d bes2 bes\fermata
          \bar"|."
        } \tonVIIIff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f2 f4 f d d d f f2 f f4 f g2 g g4 a f2 f
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Sei -- gneur, je suis ton ser -- vi -- teur.
      De ta Pa -- ro -- le, fais_- moi vi -- vre_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d4 c bes a bes c c2 d d4 d ees2 ees ees4 f d2 d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes2 bes4 f g d g f f2\fermata\resp
          bes bes4 bes bes2 bes\fermata bes4 f bes2 bes\fermata
        } \tonVIIIfh
      }
   >>
>>