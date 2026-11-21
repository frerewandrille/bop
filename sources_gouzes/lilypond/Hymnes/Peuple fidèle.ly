\version "2.24.0"
% 
% \paper {
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 20)
% 
% \header {
%   title = \markup \center-column { "Peuple fidèle" }
%   subtitle = " "
%   poet = " Paroles : Claude Rozier"
%   composer =  "Musique : J. F. Wade (1740)"
% }

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
    \override InstrumentName.X-offset = 3
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key g \major
  \time 4/4
}

sopMusic = \relative c'' {
  g2^\mf d4 g a2 d, b'4 a b c b2 a4 \breathe
  g g2 fis4 e fis (g) a b fis2 e d1
  d'2^\f c4 b c2 b a4 b g a fis (e) d \breathe
  g^\p g fis g a g2 d4 \breathe b'^\markup\italic"cresc." b a b c b2 a4 \breathe
  b c b a g fis2 g4 \breathe c^\f b2 a4. g8 g1
  \bar "|." 
}

altoMusic = \relative c' {
  d2 d4 d d2 d d4 d d e d (e) fis d b (cis) d e d2 d4 d d2 d4 (cis) a1
  g'2 g4 g g (a) g2 a4 d, e e d2 a4 d d d d d d2 d4 g g a g fis g2 d4
  g c, d e e d2 d4 e g2 fis4. d8 d1
}

tenorMusic = \relative c' {
  b4 (c) d b a (fis) g (a) g a g g g (b) d
  g, g2 a4 a a2 a4 g d' (a) a4. (g8) fis1
  d'2 d4 d e (d) d2 d4 g, b a a (g) fis b b a b c b2 b4
  d d d d d d2 d4 d g, g g g c2 b4 a g (b) d c b1
}

bassMusic = \relative c' {
  g4 (a) b g fis( d) e (fis) g fis e8 (d) c4 d2 d4 \breathe
  b e2 d4 cis d (e) fis g a (fis8 d) a2 d1
  b'2 a4 g e (fis) g2 fis4 g e8 (d) cis4 d2 d4 \breathe r R1 r2 r4 \breathe
  g g fis g a g2 fis4 \breathe f e d c b a2 b4 \breathe c d2 d4 d <g, g'>1
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Peu -- ple fi -- dè -- le,
  le Sei -- gneur t’ap -- pel -- le_!
  C’est fê -- te sur ter -- re_:
  Le Christ est né.
  Viens à la crè -- che
  voir le roi du mon -- de.
  \set shortVocalName = "" \set stanza = #"     Ref. "
  \override Lyrics.LyricText.font-shape = #'bold
  En lui viens re -- con -- naî -- tre,
  en lui viens re -- con -- naî -- tre,
  en lui viens re -- con -- naî -- tre
  ton Dieu, ton Sau -- veur.
}

altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Ver -- be, Lu -- miè -- re,
  et Splen -- deur du Pè -- re,
  il naît d’u -- ne mè -- re,
  pe -- tit en -- fant.
  Dieu vé -- ri -- ta -- ble,
  le Sei -- gneur fait hom -- me.
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Peu -- ple, ac -- cla -- me,
  a -- vec tous les an -- ges,
  le Maî -- tre des hom -- mes
  qui vient chez toi.
  Dieu qui se don -- ne
  à tous ceux qu’il ai -- me_!
}

altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Peu -- ple fi -- dè -- le,
  en ce jour de fê -- te,
  pro -- cla -- me la gloi -- re
  de ton Sei -- gneur.
  Dieu se fait hom -- me
  pour mon -- trer qu’il t’ai -- me.
}

\score {
  \new ChoirStaff <<
    \new Staff = "women" <<
      \new Voice = "sopranos" {
        \voiceOne
        << \global \sopMusic >>
      }
      \new Voice = "altos" {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "sopranos" \altoWordsquatre
   
    \new Staff = "men" <<
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