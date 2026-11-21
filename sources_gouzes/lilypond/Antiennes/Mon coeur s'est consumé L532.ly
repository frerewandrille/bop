\version "2.24.0"
%\include "TonsDef.ly"


\new ChoirStaff
<< \new Dynamics 
   {
     g4^\< g2 bes\! a4^\> a g2\! 
     bes8\rest g8 g [ g g g] g2 \allowBreak g4 f ees4. (f8) g2 fis4 
     g2\bar "|."          
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 2/2 \cadenzaOn \tempo "Lent" 4 = 66
          g4 g2 bes a4 a g2\fermata \bar "|" \tempo 4 = 120 
          bes8\rest^\markup\italic"accel. subito" g8 g [ g g g] g2 \allowBreak g4 f ees4. (f8) g2 fis4 
          g2\fermata\bar "|."          
        }
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { \cadenzaOn
          d4 e2 f f4 f d2 s8 ees! ees [ ees ees ees] ees2 ees4 d c2 d d4 d2
        }\tonIIef   
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
     Mon4 cœur2 s’est con4 -- su -- mé.2 \skip8 Il8 a é -- té ré -- duit2 au4
     né -- ant2 de -- vant4 toi.2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c' 
        { \clef "bass" \key g \minor \time 2/2 \cadenzaOn
          b4 c2 d c4 c b2 s8 bes! bes [bes bes bes] bes2 bes4 bes g2 bes4 
          \override BalloonText.annotation-balloon = ##f 
          <a \balloonText #'(1.5 . 2)\markup { "" } >2
          bes
        }\tonIIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          g4 c,2 bes f'4 f g2\fermata d8\rest ees ees [ees ees ees] ees2 ees4 bes c2
          g4 d'2 g\fermata
        }
      }
   >>
>>