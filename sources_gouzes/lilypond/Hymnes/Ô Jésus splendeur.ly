\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   %system-system-spacing #'basic-distance = #17
%   top-margin = 19
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% #(set-global-staff-size 13)
% 
% \header {
%   title = \markup \center-column { "Ô Jésus, splendeur du Père" }
%   subtitle = " "
%   poet = " "
%   composer =  " "
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
  \time 2/2
}

sopMusic = \relative c'' {
  b2 a g4 a b d c2 b \breathe d b c4 \slurDashed b8 (a) g4 b a2 g \breathe
  b2 a g4 a b d c2 b \breathe d b c4 b8 (a) g4 b a2 g \breathe
  d'2 e4 g~ g g fis d e2 d \breathe d2 e4 g~ g g fis d e2 d \breathe
  a2 b c4 c b a a (gis) a2 \breathe b d c4 b a g a2 g \fermata \bar "|."
}

altoMusic = \relative c'' {
  g2 fis e4 d g fis e2 d d g g4 fis e e8 (d) d2 d
  g2 fis e4 d g fis e2 d d g g4 fis e e8 (d) d2 d
  g2 g4 g~ g g a a b (a) fis2 g2 g4 g~ g g a a b (a) fis2
  fis2 g a4 e e c e2 e g g g4 g fis g g (fis) g2
}

tenorMusic = \relative c' {
  d2 d b4 a g b g2 g b d e4 d b g g (fis) g2
  d'2 d b4 a g b g2 g b d e4 d b g g (fis) g2
  b2 b4 e~ e b d d d (cis) d2 b2 b4 e~ e b d d d (cis) d2
  d2 d e4 c gis a b2 a d d e4 d d b d2 b  
}

bassMusic = \relative c' {
  g2 d e4 fis e b c2 g' \breathe g g c,4 d e8 (fis) g4 d2 g\breathe
  g2 d e4 fis e b c2 g' \breathe g g c,4 d e8 (fis) g4 d2 g\breathe
  g2 e4 c~ c e d fis g (a) d,2\breathe g2 e4 c~ c e d fis g (a) d,2\breathe
  d2 b a4 a e' f e2 a\breathe g b, c4 g' d e d2 g\fermata
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "\set shortVocalName = "1." 
  Ô Jé -- sus, splen -- deur du Pè -- re, Toi l’i -- ma -- ge de sa gloi -- re, 
  Trans -- fi -- gure en ta lu -- miè -- re Ceux qui cher -- chent ton vi -- sa -- ge_!
  %\set stanza = #"1. "
  Fils de l’Homme, a -- vant ta Pâ -- que, Tu veux ré -- vé -- ler ta gloi -- re, 
  Pour qu’en ta pas -- sion très sain -- te, Nous re -- con -- nais -- sions le Ver -- be.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "\set shortVocalName = "2." 
  Son vi -- sage est de lu -- miè -- re, Et sa ro -- be com -- me nei -- ge_; 
  Un -- e nu -- ée l’en -- ve -- lop -- pe Et le cou -- vre de son om -- bre_;
  Et du sein de la nu -- é -- e, U -- ne voix se fait en -- ten -- dre_: 
  Oui, c’est lui, mon Fils u -- ni -- que, Bien_- ai -- mé d’a -- vant les siè -- cles_!
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3." 
  Aux cô -- tés du Christ en gloi -- re, Ap -- pa -- raissent Élie et Mo -- ï -- se_; 
  Pour qu’en lui, on re -- con -- nais -- se Des morts et vi -- vants le maî -- tre_;
  %\set stanza = #"2. "
  La ré -- sur -- rec -- tion s’an -- non -- ce Et dé -- jà, el -- le ray -- on -- ne 
  Et nous prend dans sa lu -- miè -- re, Dis -- si -- pant tou -- tes té -- nè -- bres.
}

altoWordsquatre = \lyricmode {  %\set stanza = #"V 3. "
  \set stanza = #"4. "\set shortVocalName = "4." 
  Ô Sei -- gneur, viens et re -- gar -- de: De ton Christ vois le vi -- sa -- ge_! 
  Toi qui don -- nes grâce et gloi -- re, Tout crie joie de -- vant ta fa -- ce_!
  Et vers toi, ô Dieu de vi -- e, Mon cœur et ma chair ju -- bi -- lent, 
  Car no -- tre corps de mi -- sè -- re Par toi re -- de -- vient lu -- miè -- re.
}


\transpose b fis
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
  
  \new Lyrics \lyricsto "sopranos" \altoWordsun
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
      \voiceTwo 
      << \global \bassMusic >>
    }
  >>
>>