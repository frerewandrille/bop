\version "2.24.0"
\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

% 
% \paper {
%   system-system-spacing.basic-distance = #14
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = ##f
% }
% 
% \layout {    
%   indent = #0
%   \context { 
%     \Score \remove "Bar_number_engraver"
%   }
%   \context { 
%     \Lyrics
%     \override LyricText.font-size = #2
%     \override InstrumentName.X-offset = 1.5
%     \override InstrumentName.font-size = 0
%     \override InstrumentName.font-series = #'bold
%     \override LyricSpace.minimum-distance = #1
%   }
% } 
% 
% #(set-global-staff-size 19)
% 
% \header {
%   title = \markup \center-column { "Notre Père" }
%   subtitle = " "
%   poet = ""
%   composer =  "d’après Rimski Korsakov"
% }

divisioMaior = {
  \once \override BreathingSign.stencil = #ly:breathing-sign::divisio-maior
  \once \override BreathingSign.Y-offset = #0
  \breathe
}

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          a8 [a] a4 a8 \breathe a8 g [f] g2 \divisioMaior\allowBreak
          g8 [g] g [g] g [g]  g2 \divisioMaior\allowBreak
          g8 [g] a4. a8 a4 (g) f2 \divisioMaior\allowBreak
          f8 [f] f [f] f [f] g4 g \breathe\allowBreak
          g8 [g] g [g] a [a]  bes2 \divisioMaior\allowBreak
          bes8 [bes] bes [bes bes] bes [bes bes] g [g g] a2 \divisioMaior\allowBreak
          a8 a [g] f [f f] g4 g8 \breathe \allowBreak
          g [g g] g [g] g [f] g4 \breathe \allowBreak
          g8 a [a a] a [a g] f2 \divisioMaior\allowBreak
          f8 f [f] f [f] g4. g8 g [g] a [a] bes2 \divisioMaior\allowBreak
          bes8 [bes] bes [bes] g [g] a2 \bar "|."          
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          f8 [f] f4 f8 c c [d] e2
          e8 [e] e [e] e [e] e2
          e8 [e] f4. f8 f4 (e) d2
          d8 [d] d [d] d [d] e4 e e8 [e] e [e] f [f] g2
          g8 [g] g [g g] g [f f] e [e e] f2
          c8 c [c] d [d d] e4 e8 e [e e] e [e] e [d] e4
          e8 f [f f] f [e e] d2
          d8 d [d] d [d] e4. e8 e [e] f [f] g2
          g8 [g] g [g] e [e] f2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     No -- tre Pè -- re, qui es aux cieux,
     que ton nom soit sanc -- ti -- fié,
     que ton rè -- gne vien -- ne,
     que ta vo -- lon -- té soit fai -- te sur la ter -- re comme au ciel.
     Don -- ne_- nous au -- jour -- d’hui no -- tre pain de ce jour.
     Par -- don -- ne_- nous nos of -- fen -- ses,
     com -- me nous par -- don -- nons aus -- si à ceux qui nous ont of -- fen -- sés.
     Et ne nous lais -- se pas en -- trer en ten -- ta -- tion,
     mais dé -- li -- vre_- nous du Mal.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 2/2 \cadenzaOn
          c8 [c] c4 c8 f, g [a] c2 
          c8 [c] c [c] c [c] c2
          c8 [c] c4. c8 c2 a
          a8 [a] a [a] a [a] c4 c c8 [c] c [c] c [c] d2
          d8 [d] d [d d] d [d d] c [c c] c2
          f,8 f [g] a [a a] c4 c8 c [c c] c [c] c [a] c4
          c8 c [c c] c [c c] a2
          a8 a [a] a [a] c4. c8 c [c] c [c] d2
          d8 [d] d [d] c [c] c2
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          f8 [f] f4 f8 \breathe f e [d] c2\divisioMaior
          c8 [c] c [c] c [c] c2\divisioMaior
          c8 [c] f4. f8 f4 (c) d2\divisioMaior
          d8 [d] d [d] d [d] c4 c \breathe c8 [c] c [c] a [a] g2
          <g g'>8 [q] q [q q] q [q q] c [c c] <f, f'>2\divisioMaior
          f'8 f [e] d [d d] c4 c8 \breathe
          c [c c] c [c] c [d] c4 \breathe
          c8 f [f f] f [c c] d2\divisioMaior
          d8 d [d] d [d] c4. c8 c [c] a [a] g2\divisioMaior
          <g g'>8 [q] q [q] c [c] <f, f'>2
        }
      }
   >>
>>