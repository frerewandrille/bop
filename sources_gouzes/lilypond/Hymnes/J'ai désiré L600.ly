\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   %system-system-spacing.basic-distance = #17
%   top-margin = 9
%   bottom-margin = 8
%   left-margin = 10
%   right-margin = 10
%   print-page-number = ##f
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% #(set-global-staff-size 15)
% 
% \header {
%   title = \markup \center-column { "J’ai désiré" }
%   subtitle = ""
%   poet = ""
%   composer =  ""
% } 
% \markup{ \vspace #1 }
% 
% \layout {
%   indent = #0
%   \context {
%     \Score \remove "Bar_number_engraver"
%   }
%   \context {
%     \Lyrics
%     \override LyricText.font-size = #2
%     \override LyricSpace.minimum-distance = #1
%   } 
% }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très doux, léger mais pathétique"% 2 = 52
         a2 a4 a c2 c d4 (c) bes2 a2.\fermata\resp
         a4 a2 a4 a f1 g2 g a1\fermata\allowBreak
         \silN a4 f1\fermata e2\fermata e\fermata d1\fermata
         \bar"|."
       } \tonIbf
     }
     \new Voice = "alto" \with { \consists "Balloon_engraver"
                                 \override BalloonText.annotation-balloon = ##f }
     { \voiceTwo \relative c'
       { 
         f2 f4 f e (a2) 
         <g \balloonText #'(-1 . -3)\markup { "" } >4
         f2 g f2. f4 f2 f4 f d1 d2 d cis1
         s4 cis!4 d2 (c) bes bes a1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     J’ai dé -- si -- ré d’un grand dé -- sir
     man -- ger cet -- te Pâque a -- vec vous
     a -- vant de souf -- frir.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d4 d c2 e d d4 (e) c2. 
          c4 d2 d4 c bes2 (a) g4 (f) e (d) e1
          \silN e4 d2 (e4 f) g2 g a1
        } \tonIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 (e) f g a2 a bes bes f2.\fermata\resp
          e4 d2 d4 d d2. (c4) bes2 bes a1\fermata
          s4 a4 d1\fermata d2\fermata d\fermata d1\fermata
        } 
      }
   >>
>>

%\markup{ \vspace #1 \italic\huge "Couplets"}
%\include "J'ai désiré Cplts L600.ly"