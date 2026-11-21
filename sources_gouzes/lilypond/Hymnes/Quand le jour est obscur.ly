\version "2.24.0"

\include "vowel-set.ly"

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

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key g \major
  \time 2/4
}

sopMusic = \relative c' {
  e2 fis4 g e2 d e\fermata\breathe e fis4 g e d e2 e2.\breathe\allowBreak%\fermata
  e4 g g a a b2.\fermata\breathe\allowBreak b4 e e d d b2 a \breathe \allowBreak
  a a4 a b b g2 \fermata\breathe\allowBreak e4 e g2 g4 g fis2 \fermata%\breathe
  e\fermata e\fermata d\fermata e\fermata \revert Score.BarLine.stencil \bar "|."
}

altoMusic = \relative c' {
  b2 c4 c b2 b4 (a) g2 c c4 c b b b2 b2. c4 d e g fis g2. g4 g g fis fis g2 d
  d d4 d dis dis e2 c4 c b2 b4 c d2 c b b b
}

tenorMusic = \relative c' {
  g!2 a4 a fis2 fis e a a4 a fis fis g2 g2. g4 g b d d d2. d4 c c a a g2 fis
  fis fis4 fis fis fis e2 g4 g g2 g4 g a2 a fis fis gis
}

bassMusic = \relative c {
  e2 a,4 a b2 b e\fermata\breathe a, a4 a b b e2 e2.\breathe%\fermata
  c4 b e d d g,2.\fermata\breathe g'4 c, c d d g,2 d'\breathe
  d d4 d b b e2\fermata\breathe c4 c e2 e4 e d2\fermata%\breathe
  a\fermata b\fermata b\fermata e\fermata
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "\set shortVocalName = "1."
  Quand le jour est obs -- cur et que dé -- fail -- le l’hom -- me, gar -- dien de la ci -- té, 
  Voi -- ci que tu ré -- vè -- les, fem -- me con -- nue de Dieu, un vi -- sa -- ge nou -- veau d’hu -- ma -- ni -- té.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. "\set shortVocalName = "2."
  Ta pré -- sence est un feu, u -- ne pa -- role ar -- den -- te, qui brû -- le dou -- ce -- ment.
  Mais vien -- ne la tem -- pê -- te, souffle un vent de fo -- lie_: ta pa -- role est un cri lan -- cé vers Dieu.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Ta pré -- sen -- ce de foi qui sou -- te -- nait l’É -- gli -- se ray -- on -- ne jus -- \apostrophe qu’à nous_:
  Vi -- sa -- ge de lu -- miè -- re, fem -- me qui an -- non -- çait le Roy -- au -- me pro -- mis à tous les temps.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  Ta pré -- sence a bra -- vé les ty -- ran -- nies du mon -- de au nom d’un seul a -- mour_:
  Pas -- sion qui te rend for -- te, li -- bre pour ton Sei -- gneur, dans la pleine as -- su -- ran -- ce de l’Es -- prit.
}

altoWordscinq = \lyricmode {  
  \set stanza = #"5. "\set shortVocalName = "5."
  Ta pré -- sence est un chant, c’est l’es -- pé -- ran -- ce neu -- ve d’un peuple en dé -- sar -- roi_:
  Sa -- ges -- se qui é -- clai -- re, fem -- me qui pa -- ci -- fie et ra -- ni -- me la foi sans rien bri -- ser.
}


\score {
  \new ChoirStaff 
  <<
    \new Staff = "women" \with {\remove Time_signature_engraver }
    <<
      \new Voice = "sopranos" {
        \voiceOne \omit Score.BarLine
        << \global \sopMusic >>
      }
      \new Voice = "altos" {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>
    \new Lyrics \lyricsto "altos" \altoWordsun
    \new Lyrics \lyricsto "altos" \altoWordsdeux
    \new Lyrics \lyricsto "altos" \altoWordstrois
    \new Lyrics \lyricsto "altos" \altoWordsquatre
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "altos" \altoWordscinq
   
    \new Staff = "men" \with {\remove Time_signature_engraver }
    <<
      \clef bass
      \new Voice = "tenors" {
        \voiceOne
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo << \global \bassMusic >>
      }
    >>
  >>
}