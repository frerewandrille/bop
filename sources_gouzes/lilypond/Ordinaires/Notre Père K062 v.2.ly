\version "2.24.0"
% 
% \header {
%   title = \markup \center-column { "Notre Père" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
%   tagline = ##f
% }
% 
\include "vowel-set.ly"
% 
% \layout { 
%   ragged-right = ##f
%   ragged-last = ##f
%   indent = 0
%   \context { \Staff  %\override StaffSymbol.thickness = #0.5 
%              \override Script.font-size = #-1
%              \override TimeSignature.style = #'single-digit
%   }
%   \context { \Lyrics 	
%              \override LyricText.font-size = #2 	
%              %\override LyricText.font-name = #"TeX Gyre Pagella"
%              \override LyricSpace.minimum-distance = #1
%   } 
%   \context { \Score \remove "Bar_number_engraver" }
% }	

ss = { \hideNotes bes8 \unHideNotes }
ssf = { \hideNotes bes8\! \unHideNotes }
armure = { \key g \minor \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   { 
     bes8^\p [bes] bes4 bes8 [bes] bes [bes] a4 
     a8 [a] c^\> [c] c [c] bes4\! \bar "|"
     d8^\< [d] d^\> [d] d4 (c) bes\! \bar "|"
     bes\breve*1/16^\< \ss \ss \ssf a4 a8 \allowBreak
     a8 [a] c4^\> c8 bes4 a g4\! \bar "|"
     bes\breve*1/16^\ppp \ss
     a4 a8 [a] c4 c8 [c] bes4 \bar "|"
     d\breve*1/16^\<
     \hideNotes bes8^\> \unHideNotes \ss d4 d\! 
     d\breve*1/16 \ss \ss c8 bes4 \allowBreak 
     bes8 bes4 bes8 [bes] c4 c8 [c] bes4 \bar "|"
     bes\breve*1/16 \ss \ss \ss a8 bes4 bes8\allowBreak
     c8^\< [c] bes4 a g4^\f\! 
     g\breve*1/16^\p^\> \ss g4\! g g2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Très calme"
          bes8 [bes] bes4 bes8 [bes] bes [bes] a4\resp 
          a8 [a] c [c] c [c] bes4 \bar "|"
          d8 [d] d [d] d4 (c) bes \bar "|"
          bes\breve*1/16^\markup\italic"accel." \ss \ss \ssf a4 a8 \allowBreak
          a8 [a]^\markup\italic"rall." c4 c8 bes4 a g4 \bar "|"
          bes\breve*1/16 \ss
          a4 \allowBreak a8 [a] c4 c8 [c] bes4 \bar "|"
          d\breve*1/16^\markup\italic"accel." 
          \ss \ss d4 d \resp
          d\breve*1/16 \ss \ss c8 bes4 \allowBreak 
          bes8 bes4 bes8 [bes] c4 c8 [c] bes4 \bar "|"
          bes\breve*1/16 \ss \ss \ss a8 bes4\allowBreak bes8
          c8 [c] bes4 a g4\resp 
          g\breve*1/16 \ss g4^\markup\italic"très lent" g g2\fermata
          \bar "|."
        }
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c''
        {
          g8 [g] g4 g8 [g] g [g] g4 g8 [g] g [g] a [a] g4 bes8 [bes] bes [bes] a2 g4
          g\breve*1/16 s s s g4 g8 g8 [g] a4 a8 g4 fis g
          g\breve*1/16 s g4 g8 [g] a4 a8 [a] g4
          bes\breve*1/16 s s a4 a 
          a\breve*1/16 s s a8 g4 g8
          g4 g8 [g] bes4 a8 [a] g4 g\breve*1/16 s s s g8 g4 
          g8 a [a] g4 fis! g
          ees\breve*1/16 s ees4 ees d2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     No -- tre Pè -- re, qui es aux cieux,
     que ton nom soit sanc -- ti -- fié,
     que ton rè -- gne vien -- ne,
     que ta volonté soit fai -- te sur la ter -- re comme au ciel.
     Donne-nous aujour -- d’hui no -- tre pain de ce jour.
     Pardonne-nous nos of -- fen -- ses,
     comme nous pardonnons aus -- si à ceux qui nous ont of -- fen -- sés.
     Et ne nous lais -- se pas en -- trer en ten -- ta -- tion,
     mais délivre_- nous du Mal.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 [d] d4 d8 [d] d [d] c4 c8 [c] ees [ees] ees [ees] d4 f8 [f] f [f] f4 (ees) d
          d\breve*1/16 s s s c4 c8 c8 [c] ees4 ees8 d4 c bes
          d\breve*1/16 s c4 c8 [c] ees4 ees8 [ees] d4
          f\breve*1/16 s s f4 f f\breve*1/16 s s ees8 d4 
          d8 d4 d8 [d] ees4 ees8 [ees] d4 
          d\breve*1/16 s s s c8 d4 d8 ees [ees] d4 c bes 
          bes\breve*1/16 s  c4 c bes2
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g8 [g] g4 g8 [g] g [g] g4\resp g8 [g] g [g] fis [fis] g4
          bes8 [bes] bes [bes] f4 (fis) g 
          g\breve*1/16 s s s g4 g8 g8 [g] fis!4 fis8 g4 d g
          g\breve*1/16 s g4 g8 [g] fis!4 fis8 [fis] g4 
          bes\breve*1/16 s s f!4 f\resp f\breve*1/16 s s fis8 g4
          g8 g4 g8 [g] fis!4 fis8 [fis] g4
          g\breve*1/16 s s s g8 g4 g8 fis! [fis] g4 d ees\resp
          ees\breve*1/16 s c4 c <g g'>2\fermata
        }
      }
   >>
>>