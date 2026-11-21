\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

ss = { \hideNotes bes4 \unHideNotes \allowBreak }
ssf = { \hideNotes bes4\! \unHideNotes \allowBreak }
armure = { \key g \minor \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \omit Score.BarLine \tempo "Très calme"
          bes8^\p bes bes4 bes8 bes bes bes a4\resp 
          a8 a c^\> c c c bes4\!
          \revert Score.BarLine.stencil \bar "|"
          d8^\< d \omit Score.BarLine  d^\> d d4 (c) bes\! 
          \revert Score.BarLine.stencil \bar "|"
          bes\breve*1/8^\<^\markup\italic"accel." \omit Score.BarLine \ss \ss \ssf 
          a4*2/3 a8*2/3 a8 a 
          c4*2/3^\markup\italic"rall."^\> c8*2/3 bes4 a g4\!
          \revert Score.BarLine.stencil \bar "|"
          bes\breve*1/8^\ppp \omit Score.BarLine \ss
          a4 a8 a c4 c8 c \noBreak bes4
          \revert Score.BarLine.stencil \bar "|"
          d\breve*1/8^\<^\markup\italic"accel." \omit Score.BarLine 
          \hideNotes bes4^\> \unHideNotes \ss d4 d\! \resp
          d\breve*1/8 \ss \ss c8 bes4 bes8 bes4 bes8 bes c4 c8 c \noBreak bes4
          \revert Score.BarLine.stencil \bar "|"
          bes\breve*1/8 \omit Score.BarLine \ss \ss \ss a8 bes4 bes8
          c8^\< c bes4 a g4^\f\!\resp 
          g\breve*1/8^\p^\> \ss g4^\markup\italic"très lent"\! g g2\fermata
          \revert Score.BarLine.stencil \bar "|."
        }
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c''
        {
          g8 g g4 g8 g g g g4 g8 g g g a a g4 bes8 bes bes bes a2 g4
          g\breve*1/8 s s s g4*2/3 g8*2/3 g8 g a4*2/3 a8*2/3 g4 fis g
          g\breve*1/8 s g4 g8 g a4 a8 a g4
          bes\breve*1/8 s s a4 a 
          a\breve*1/8 s s a8 g4 g8
          g4 g8 g bes4 a8 a g4 g\breve*1/8 s s s g8 g4 g8 a a g4 fis g
          ees\breve*1/8 s ees4 ees d2
        }          
      }
   >>
   \new Lyrics \lyricsto soprano 
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
        { \clef "bass" \armure
          d8 d d4 d8 d d d c4 c8 c ees ees ees ees d4 f8 f f f f4 (ees) d
          d\breve*1/8 s s s c4*2/3 c8*2/3 c8 c ees4*2/3 ees8*2/3 d4 c bes
          d\breve*1/8 s c4 c8 c ees4 ees8 ees d4
          f\breve*1/8 s s f4 f f\breve*1/8 s s ees8 d4 
          d8 d4 d8 d ees4 ees8 ees d4 
          d\breve*1/8 s s s c8 d4 d8 ees ees d4 c bes 
          bes\breve*1/8 s  c4 c bes2
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g8 g g4 g8 g g g g4\resp g8 g g g fis fis g4
          bes8 bes bes bes f4 (fis) g 
          g\breve*1/8 s s s g4*2/3 g8*2/3 g8 g fis4*2/3 fis8*2/3 g4 d g
          g\breve*1/8 s g4 g8 g fis4 fis8 fis g4 
          bes\breve*1/8 s s f!4 f\resp f\breve*1/8 s s fis8 g4
          g8 g4 g8 g fis4 fis8 fis g4
          g\breve*1/8 s s s g8 g4 g8 fis fis g4 d ees\resp
          ees\breve*1/8 s c4 c <g g'>2\fermata
        }
      }
   >>
>>