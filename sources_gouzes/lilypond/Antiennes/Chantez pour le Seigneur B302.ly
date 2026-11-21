\version "2.24.0"

%\include "TonsDef.ly"

\transpose bes g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 3/8 \omit Score.BarLine \tempo 8 = 100 
          \partial 8 bes16 (c) d8-> d c16 bes c4-> a16 bes c8-> c bes16 (a) g4-> \breathe
          bes16 c d8-> d ees16 d c4-> a16 bes c8-> c16 d bes a \noBreak g4.\fermata
          \revert Score.BarLine.stencil \bar "|."
        }\cadenzaOn \transpose d g \tonIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        {
          \partial 8 g16 (a) bes8 bes a16 g a4 f16 g a8 a g16 (f) g4
          g16 a bes8 bes c16 bes a4 f16 g a8 a16 bes g f g4.
        }          
      }
   >>
   \new Lyrics %\with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano
   { %\set associatedVoice = #"soprano"
      Chan -- tez pour le Sei -- gneur le can -- ti -- que nou -- veau.
      An -- non -- cez de jour en jour la nou -- vel -- le de son sa -- lut_!
   }
   \new Lyrics = "tenorsword"   \with {\override VerticalAxisGroup.staff-affinity = #DOWN }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major
          \partial 8 d8 d4 c8 c4 c8 c4 d8 d4 d8 d4 c8 c4 c8 c4 d8 d4.
        }\cadenzaOn \transpose d g \tonIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          \partial 8 g8 g4 f8 f4 f8 f4 g8 g4 g8 g4 f8 f4 f8 f4 g8 g4.
        }
      }
   >>
   \context Lyrics = "tenorsword" \lyricsto "ténor" 
   { %\set associatedVoice = #"soprano"
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia_!
   }
>>