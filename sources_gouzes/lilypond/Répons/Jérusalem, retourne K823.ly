\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key e \minor \time 3/4 }

\new ChoirStaff
<< \new Dynamics 
   { \override Hairpin.to-barline = ##f
     \partial4 e4^\ppp^\< e2 fis4^\> g2\! 
     e4^\p^\< e2 fis4^\> g2\!
     g4^\mf^\< a2 a8^\f^\> a \time 2/2 b4 (g fis) e \noBreak fis2.\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \relative c'
     { \clef "treble" \armure \override Hairpin.to-barline = ##f
       \partial4 e4 e2 fis4 g2\breathe 
       e4 e2 fis4 g2\breathe
       g4 a2 a8 a \time 2/2 b4 (g fis) e \noBreak fis2.\fermata
       \revert Score.BarLine.stencil \bar "|."
     }\cadenzaOn \transpose a b \tonIef
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Jé -- ru -- sa -- lem_! Jé -- ru -- sa -- lem_! 
     Re -- tourne au Sei -- gneur ton Dieu_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      \with { \consists "Balloon_engraver"
              \override BalloonText.annotation-balloon = ##f
              \override BalloonText.annotation-line = ##f }
      { \voiceOne \relative c
        { \clef "bass" \armure 
          \partial4 <e \balloonText #'(0 . 3)\markup\italic { "Soliste" } >4
          c'2 c4 b2 e,4 c'2 d8 (c) b2
          b4 e2 fis8 e d4 (b2) a4 b2.
        }\cadenzaOn \transpose a b \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial4 e4 a,2 a4 e'2\breathe
          e4 a,2 a4 e'2\breathe
          e4 c2 c8 c b2. c4 b2.\fermata
        }
      }
   >>
>>% 
% 
% \new Staff \with {\remove Time_signature_engraver } { 
%   \key e \minor \cadenzaOn \voiceOne \relative c' 
%   { e\breve c' d8 b2\breathe\allowBreak
%     e,\breve c' e8_- [c] b2\fermata \bar"|"
%     c8 [d] e\breve d8_- [c d]  b2\breathe\allowBreak
%     b\breve c e8_- [c] b2\fermata } \bar"|."
% }