\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \omit Score.BarLine %\tempo  2. = 50
          \partial4 e4 e2^> e4 e-> (f2)~f\fermata\resp 
          f4 f2-> e4 e-> (a2)~ a4\fermata\resp 
          b4\rest a8 b c2 b8 a d2 (c8 b c b) a2\fermata\resp
          b4\rest e,4 e f-> f a
          \revert Score.BarLine.stencil \bar "|"\time 2/2
          e2. \omit Score.BarLine e4 e-> e d-> e f2 (g4 f) e1\fermata
          \revert Score.BarLine.stencil \bar "|."
        }\cadenzaOn \tonIVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 e4 e2 e4 e (d2)~ d d4 d2 c4 c (e2)~ e4 s 
          e\breve*1/8 s s s f2.~ f4 e2 s4 
          e e d c b c2. c4 c c b c d2 (b) c1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Jé -- ru -- sa -- lem_! Jé -- ru -- sa -- lem, 
     toi qui tues les pro -- phè -- tes, 
     tu n’as pas re -- con -- nu le temps de ta vi -- si -- te_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure
          \partial4 e4 e2 e4 e (a2)~ a a4 a2 a4 a8-> (b c2)~ c4 s 
          c8 d e2 d8 c f2 (e8 d e d) c2 s4 
          e, e a a a \time 2/2 a2. a4 a a a a a2 (g) a1
        }\cadenzaOn \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial4 e4 e2-> e4 e-> (d2)~ d\fermata\resp 
          d4 d2-> e4 e2.~ e4\fermata d\rest 
          e\breve*1/8 s s s d2.~ d4 e2\fermata\resp 
          d4\rest e4 e d-> d d a2. a4 a-> a f'-> e d1 a\fermata
        }
      }
   >>
>>

% \new Staff \with {\remove Time_signature_engraver } { 
%   \cadenzaOn \voiceOne\relative c' 
%   { e\breve gis8 a2\breathe\allowBreak\slurDashed
%     a\breve b8_- c ([a]) %\parenthesize a 
%       a2 \bar"|"
%     a\breve f8 e2\breathe\allowBreak
%     e\breve d8_- %\parenthesize g 
%       g ([f]) %\parenthesize e 
%       e2 } \bar"|."
% }