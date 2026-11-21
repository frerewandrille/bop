\version "2.24.0"
%\include "TonsDef.ly"


\transpose d b,
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 3/4 \cadenzaOn \tempo  2. = 50
          d4 (c) bes c2 ees4 d2.\breathe\allowBreak
          bes4 a g a2.\fermata\allowBreak a2 bes4 c2 g4 g2 f4 g2.
          \bar"|."
        }\tonIff
        %\tonIIaf
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c''
        { 
          g4 (a) bes a2 g4 g2. g4 g d f2. f2 f4 g2 d4 ees 
          \override BalloonText.annotation-balloon = ##f 
          < d \balloonText #'(2 . -2)\markup { "" } >2
          d2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Lè -- ve_- toi, Sei -- gneur_! Ra -- chè -- te_- nous en rai -- son de ton a -- mour_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 3/4 \cadenzaOn
          bes4 (a) g a2 c4 bes2. d4 c bes c2. c2 d4 ees( c) bes c 
          \override BalloonText.annotation-balloon = ##f 
          < a \balloonText #'(2 . 3)\markup { "" } >2
          bes2.
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 g4 f2 c4 g'2.\breathe g4 g g f2.\fermata f2 d4 c (ees) g c, d2 <g, g'>2.
        }\tonIfh
        %\tonIIah
      }
   >>
>>

%{
convert-ly (GNU LilyPond) 2.24.1  convert-ly: Traitement de «  »...
Conversion en cours : 2.19.2, 2.19.7, 2.19.11, 2.19.16, 2.19.22,
2.19.24, 2.19.28, 2.19.29, 2.19.32, 2.19.39, 2.19.40, 2.19.46,
2.19.49, 2.20.0, 2.21.0, 2.21.2, 2.22.0, 2.23.1, 2.23.2, 2.23.3,
2.23.4, 2.23.5, 2.23.6, 2.23.7, 2.23.8, 2.23.9, 2.23.10, 2.23.11,
2.23.12, 2.23.13, 2.23.14, 2.24.0
%}
