\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Dynamics 
   {
     fis2 g4 a2 bes4 (g2.) f\bar "|" \cadenzaOff\time 2/2 \tempo "Vif" 2 = 80
     s4 ees^\< d2 f4 g f bes bes bes~\! bes
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn \tempo "Assez ample" 4 = 112
          fis2 g4 a2 bes4 (g2.) f\bar "|" \cadenzaOff\time 2/2 \tempo "Vif" 2 = 80
          s4^\markup{\italic"sub. marcato"} ees^- d2^- f4^- g^- f^- bes^- 
          bes^- bes^-~ bes a bes \breathe
          bes8 bes a4 (g) g2. fis4 \noBreak g2\fermata\bar"|."
        } \cadenzaOn \transpose c bes, \tonIIIhf %Ton à quatre stique dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d2 e4 f!2 f4 (ees2.) d r4 bes bes2 d4 ees d f g f~ f f f f8 f f4 (ees)
          d2. d4 d2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
     Lè2 -- ve-4 toi,2 Sei1 -- gneur_!2. \skip4 En4 -- tends2 la4 cla -- meur
     de tes en2 -- ne4 -- mis qui8 ou -- tra2 -- gent2. ton4 nom_!2
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \key g \minor \time 3/4 \cadenzaOn
          a2 c4 c2 d4 (bes2.) bes s4 g f2 bes4 bes bes d ees d 
          \override BalloonText.annotation-balloon = ##f 
          <c \balloonText #'(2 . 2.5)\markup { "" } >2 
          d4 d8 d c2 a2. a4 b2
        } \cadenzaOn\transpose c bes, \tonIIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d2 c4 f2 bes,4 (ees2.) bes d4\rest ees_- bes2_- bes4_- ees_- bes_- bes_-
          ees_- bes_- f'2 bes,4 \breathe bes8 bes f'4 (c) 
          d2. d4 g2\fermata
        }
      }
   >>
>>