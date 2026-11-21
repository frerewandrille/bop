\version "2.24.0"

\include "vowel-set.ly"
%
% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 20
%   right-margin = 20
%   ragged-last-bottom = ##f
% }
% 
% #(set-global-staff-size 16)
% 
% \header {
%   title = \markup \center-column { "Invités aux noces" }
%   subtitle = " "
%   poet = ""
%   composer = ""
%   tagline = ##f
% }

\layout {
  indent = #0
  \context {
    \Score \remove "Bar_number_engraver"
  }
  \context {
    \Lyrics
    \override LyricText.font-size = #2
    \override LyricSpace.minimum-distance = #1
  } 
}


\layout {
  \context {
    \Lyrics
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}

resp = { \breathe\allowBreak }

<< 
  \new Staff = main \with {\remove Time_signature_engraver }
  \new Voice = "soprano" 
  { \relative c'
    { \clef "treble" \time 1/4 \key c \major %\tempo 4 = 84
      \cadenzaOn
      d8 [d] d [f] d [c] f [g] a4.\resp
      a8 g [c] c4 d8 [c] c [b] a [g] a4 4\bar"|"
      d,8 [a'] a [b] a [g] g4 e8 [f] e [d] d4 e4.\resp
      c8 e [d] g4 a8 [g] f [e] d [c] d2\fermata
      \bar "|."

      d4 d8 [f] d [c] f [g] a4 a8\resp
      a8 g [c] c4 d8 [c] c [(b)] a [g] a2\bar"|"
      d,8 [a'] a [b] a [g] g4 e8 [f] e [d] d4 e4.\resp
      c8 e [d] g4 a8 [g] f [e] d [c] d2\fermata
      \bar "|."

      d8 [d] d [f] d [c] f [g] a4 a8\resp
      a8 g [c] c4 d8 [c] c [b] a [g] a2\bar"|"
      d,8 [a'] a [b] a [g] g4 e8 [f] e [d] d4 e4.\resp
      c8 e [d] g4 a8 [g] f [(e)] d [c] d2\fermata
      \bar "|."

      d8 [d] d4 d8 [f] d [c] f [g] a4.\resp
      a8 g [c] c4 d8 [c] c [b] a [g] a2\bar"|"
      d,8 [a'] a [b] a [g] g4 e8 [f] e [d] d4 e4.\resp
      c8 e [d] g4 a8 [g] f [e] d [(c)] d2\fermata
      \bar "|."

      d8 [d] d [f] d [c] f [g] a4 a8\resp
      a8 g [c] c4 d8 [c] c [b] a [g] a2\bar"|"
      d,8 [a'] a [b] a [g] g4 e8 [f] e [d] d4 e4.\resp
      c8 e [d] g4 a8 [g] f [(e)] d [c] d2\fermata
      \bar "|."

      d8 [d] d [f] d [c] f [g] a4.\resp
      a8 g [c] c4 d8 [c] c [(b)] a [g] a2\bar"|"
      d,8 [a'] a [b] a [g] g4 e8 [f] e [d] d4 e4.\resp
      c8 e [d] g4 a8 [g] f [(e)] d [c] d2\fermata
      \bar "|."

      d8 [d] d [f] d [c] f [g] a4.\resp
      a8 g [c] c4 d8 [c] c [b] a [g] a4.\bar"|"
      d,8 [a'] a [b] a [g] g4 e8 [f] e [d] d4 e4.\resp
      c8 e [d] g4 a8 [g] f [e] d [c] d2\fermata
      \bar "|."
      d4 ( e8 [d]) c4 (d) c8 [f] e([d]) d2\fermata
      \bar "|."

    } 
  }
  
  \new Lyrics \lyricsto soprano
  { \set stanza = #"1."
    In -- vi -- tés aux no -- ces de l’A -- gneau
    et re -- vê -- tus d’u -- ne ro -- be de lu -- miè -- re,
    nous ve -- nons de tra -- ver -- ser l’eau de la Mer Rou -- ge_:
    chan -- tons le Christ_: Il nous ou -- vre le che -- min.
    
    \set stanza = #"2."
    Lui dont le Corps vê -- tu de gloi -- re
    s’est im -- mo -- lé sur l’au -- tel de la Croix,
    il a ré -- pan -- du son Sang pour la vie du mon -- de_;
    en le bu -- vant, nous vi -- vons en son a -- mour.

    \set stanza = #"3."
    Pro -- té -- gés au soir de cet -- te Pâ -- que
    con -- tre les coups de l’ange ex -- ter -- mi -- na -- teur,
    il nous a tous ar -- ra -- chés à la ser -- vi -- tu -- de.
    Les eaux s’ou -- vri -- rent a -- lors sous nos pas.

    \set stanza = #"4."
    Au -- jour -- \apostrophe d’hui, no -- tre Pâ -- que, c’est le Christ.
    Il est l’A -- gneau im -- mo -- lé pour nos pé -- chés_;
    il nous a don -- né sa chair com -- me nour -- ri -- tu -- re_:
    le pain très pur, l’a -- zy -- me sin -- cè -- re.

    \set stanza = #"5."
    Il est la vic -- ti -- me vrai -- ment di -- gne
    par qui l’en -- fer a é -- té a -- né -- an -- ti_:
    Il dé -- lie la terre en -- tiè -- re, te -- nue cap -- ti -- ve.
    Il lui re -- don -- ne les biens de la vie.
    
    \set stanza = #"6."
    Jé -- sus Chrit se lè -- ve du tom -- beau
    et il re -- tour -- ne vain -- queur des en -- fers_;
    il en -- chaî -- ne les ty -- rans, chas -- se les té -- lè -- bres
    et il nous ou -- vre les por -- tes du ciel.
    
    \set stanza = #"7."
    Gloire à toi, ô Christ, no -- tre Sau -- veur,
    toi qui tri -- omphes au -- jour -- \apostrophe d’hui d’en -- tre les morts_;
    gloire au Père et à l’Es -- prit qui nous il -- lu -- mi -- ne,
    vous qui ré -- gnez pour les siè -- cles é -- ter -- nels. A -- men. Al -- lé -- lu -- ia_!
  }
>>