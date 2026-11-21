\version "2.24.0"

\include "vowel-set.ly"
%
% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 20
%   right-margin = 20
%   ragged-last = ##t
% }
% 
% #(set-global-staff-size 14)
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
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
    \override InstrumentName.X-offset = 0.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
  }
  \context {
    \Voice
    \consists "Horizontal_bracket_engraver"
  }
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

<< 
  \new Staff = main \with {\remove Time_signature_engraver }
  <<
    \new Voice = "soprano" 
    { \relative c'
      { \clef "treble" \time 1/4 \key c \major %\tempo 4 = 84
        \cadenzaOn \tieDashed
        s8 d8\startGroup [ d\stopGroup ] d8~ [d] d [f] d [c] f [g] a4~ 8\resp
        a8 g [c] c4 d8 [c] c [b] a [g] a4~ 4\bar"|"
        d,8 [a'] a [b] a [g] g4 e8 [f] e [d] d4 e4.*2/3\resp
        s8 c8 e [d] g4 a8 [g] f [e] d [c] d4\fermata
        \bar "|."
        d4 ( e8 [d]) c4 (d) c8 [f] e([d]) d4\fermata
        \bar "|."
      } 
    } \\
    { \relative c' 
      { <a d>\breve*14/16 <a d>\breve*15/16 
        \once \override NoteColumn.force-hshift = #-1.25 <a d>\breve 
        <g c>\breve*12/16 a4
      } 
    }
  >>
  
  \new Lyrics \lyricsto soprano
  { \set stanza = #"1."\set shortVocalName = "1."
    \im \skip4 \skip4 In -- vi -- tés aux no -- ces de l’A -- gneau_ __ \skip4
    et re -- vê -- tus d’u -- ne ro -- be de lu -- miè -- re,
    nous ve -- nons de tra -- ver -- ser l’eau de la Mer Rou -- ge_:
    chan -- tons le Christ_: Il nous ou -- vre le che -- min.
  }
  \new Lyrics \lyricsto soprano
  { \set stanza = #"2."\set shortVocalName = "2."
    \im \skip4 \skip4 Lui_ __ \skip4 dont le Corps vê -- tu de gloi -- re
    s’est im -- mo -- lé sur l’au -- tel_ __ \skip4 de la Croix,_ __ \skip4 
    il a ré -- pan -- du son Sang pour la vie du mon -- de_;
    en le bu -- vant, nous vi -- vons en son a -- mour.
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto soprano
  { \set stanza = #"3."\set shortVocalName = "3."
    \im \skip4 \skip4 Pro -- té -- gés au soir de cet -- te Pâ -- que
    con -- tre les coups de l’ange ex -- ter -- mi -- na -- teur,_  __ \skip4 
    il nous a tous ar -- ra -- chés à la ser -- vi -- tu -- de.
    Les eaux s’ou -- vri -- rent a -- lors __ \skip4 sous nos pas.
  }
  \new Lyrics \lyricsto soprano
  { \set stanza = #"4."\set shortVocalName = "4."
    \im Au -- jour -- \apostrophe d’hui,_ __ \skip4 no -- tre Pâ -- que, c’est le Christ._ __ \skip4
    Il est l’A -- gneau im -- mo -- lé pour nos pé -- chés_;_  __ \skip4 
    il nous a don -- né sa chair com -- me nour -- ri -- tu -- re_:
    le pain très pur, l’a -- zy -- me sin -- cè -- __ \skip4 re.
  }
  \new Lyrics \lyricsto soprano
  { \set stanza = #"5."\set shortVocalName = "5."
    \im \skip4 \skip4 Il est la vic -- ti -- me vrai -- ment di -- gne
    par qui l’en -- fer a é -- té a -- né -- an -- ti_:_  __ \skip4 
    Il dé -- lie la terre en -- tiè -- re, te -- nue cap -- ti -- ve.
    Il lui re -- don -- ne les biens __ \skip4 de la vie.
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto soprano
  { \set stanza = #"6."\set shortVocalName = "6."
    \im \skip4 \skip4 Jé -- sus Chrit se lè -- ve du tom -- beau __ \skip4 
    et il re -- tour -- ne vain -- queur_ __ \skip4 des en -- fers_;_  __ \skip4 
    il en -- chaî -- ne les ty -- rans, chas -- se les té -- lè -- bres
    et il nous ou -- vre les por -- __ \skip4 tes du ciel.
  }
  \new Lyrics \lyricsto soprano
  { \set stanza = #"7."\set shortVocalName = "7."
    \im \skip4 \skip4 Gloire à toi, ô Christ, no -- tre Sau -- veur, __ \skip4 
    toi qui tri -- omphes au -- jour -- \apostrophe d’hui d’en -- tre les morts_;_  __ \skip4 
    gloire au Père et à l’Es -- prit qui nous il -- lu -- mi -- ne,
    vous qui ré -- gnez pour les siè -- cles é -- ter -- nels. \imstop A -- men. Al -- lé -- lu -- ia_!
  }
>>