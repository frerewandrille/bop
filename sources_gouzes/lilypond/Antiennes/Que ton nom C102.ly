\version "2.24.0"
%\include "TonsDef.ly"

\transpose bes g
\new ChoirStaff  
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \cadenzaOn \time 3/4
          \tempo "Très vif" 2. = 66
          \oneVoice r4 \voiceOne bes bes bes-> a bes g2-> g4 f2. \bar "|"
          \tempo 2 = 66 \time 2/4
          \oneVoice r4 \voiceOne d' d-> c d-> e f (d) d2\fermata\!  \bar "||" %\noBreak
        }\tonVIIIcf
        %\tonVIIIbf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          s4 f f f f f ees2 ees4 d2. s4 f f a f g a (<f bes>) <f bes>2
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Que ton Nom soit bé -- ni, Sei -- gneur,
     et que ton rè -- gne vien -- ne_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \cadenzaOn \time 3/4
          \oneVoice r4 \voiceOne d d d c d bes2 bes4 bes2. 
          \time 2/4
          \oneVoice r4 \voiceOne d d f d c c (d) d2
        }\tonVIIIch
        %\tonVIIIbh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c'
        { \cadenzaOn 
          s4 bes bes bes-> f d ees2-> ees4 bes2.
          s4 bes' bes-> f bes-> g f (bes) bes2\fermata
        }
      }
   >>
   
>>