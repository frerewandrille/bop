\version "2.24.0"

%\include "TonsRDef.ly"

barre = { \undo \omit Score.BarLine }
barress = { \omit Score.BarLine }

\transpose g e
\new ChoirStaff 
<< \new Staff %\with {\remove Time_signature_engraver }	
   << \new Voice = "soprano" 
      { \voiceOne \relative c''
        { \clef "treble" \key d \minor \time 3/4 \tempo "Dansant et martelé"
          \barress \partial4 d4 d2. c4 bes c d2. 
          \oneVoice r4 \voiceOne c bes a2. g4 f g a2. g
          e'4 f e d2 d4 c2 bes8 c d2 d4\breathe
          bes2 a4 g2\breathe f8 g a4 (bes a) g2
          \fermata\barre \bar"|."
        } %\cadenzaOn\tonRIff
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c''
        {
          \partial4 bes4 bes2. a4 g a bes2. s4 a g f2. d4 f d c2. d
          c'4 d c bes2 bes4 a2 g8 a bes2 bes4 g2 f 4 d2 f8 g a4 (g f) g2
      } }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "soprano" {
     Jé -- sus, Fils de Da -- vid, 
     an -- non -- cé par les pro -- phè -- tes
     et re -- con -- nu par Jean le Bap -- tis -- te, 
     gloire à toi_! Al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c' 
        { \clef "bass" \key d \minor \time 3/4
          \partial4 d4 d2. f4 d f d2. 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(1.5 . 2.5)\markup { "" } >2
          d4 c2. d4 c d e2. d 
          c4 c c d2 d4 e 
          \override BalloonText.annotation-balloon = ##f 
          <f \balloonText #'(2 . 1.5)\markup { "" } >
          e d2 d4 d2 c4 d2 e8 e d2 (c4) d2
        } %\cadenzaOn\tonRIfh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c'
        {
          \partial4 g4 g2. a4 bes a g2. d2 d4 f2. g4 a g f2. g
          c,4 c c g'2 g4 c2 d8 c g2 g4\breathe
          d2 f4 g2\breathe a8 a g2 (f4) g2\fermata
      } }
   >>
>>