\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   top-margin = 15
% }
% 
% \layout {    
%   tagline = ##f
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
%   }
% } 
% 
% 
% \header {
%   title = \markup \center-column { "Au ciel les Anges" }
%   subtitle = " "
%   poet = "Texte : fr. Dominique Cerbelaud op"
%   composer =  "Musique : Giovanni Gastoldi (XVI)"
%   tagline = ##f
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
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key g \major
  \time 2/2
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

sopMusic = \relative c'' {
  \cadenzaOn
  a2 a4-> g c-> c d-> e c2 a1->\resp
  a2 a4-> b g-> g e-> g a1\fermata\resp
  e2 e4-> e g-> g fis-> d \tieDashed e2~ e\resp
  b'2 c4-> e d-> b c2\fermata a\fermata a1\fermata\bar "|."
  g4 (a) a1\fermata\bar "|."
}

altoMusic = \relative c' {
  e2 fis4 g e g g g a (g) fis1
  fis2 fis4 fis e e e e e1
  e2 e4 e e cis d b \tieDashed b2~ b
  e2 e4 e fis e e2 g4 (fis) e1
  e4 (fis) e1
}

tenorMusic = \relative c' {
  c2 d4 b a c b c c2 d1
  d2 d4 d b b c b cis1
  cis!2 cis4 cis b g a a \tieDashed gis2~ gis
  gis!2 a4 a a gis! a2 e'4 (d) c1
  b4 (d) c1
}

bassMusic = \relative c' {
  a2 d,4-> e a-> e g-> c, f2 d1->\resp
  d2 d4-> d e-> e a-> e a,1\fermata\resp
  a'2 a4-> a e-> e d-> fis\tieDashed e2~ e\resp
  e2 a,4-> c d-> e a2\fermata d,\fermata a1\fermata
  e'4 (d) <a a'>1\fermata
}

altoWordsun = \lyricmode {  
  \im \set shortVocalName = "1." \set stanza = #"1. "
  Vous qui cher -- chez la vraie lu -- miè -- re,
  Le -- vez les yeux et con -- tem -- plez_!
  Vo -- yez les si -- gnes du sa -- lut. \skip4
  Re -- con -- nais -- sez Dieu par -- mi vous.
}

altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  \im L’a -- veu -- gle voit, les sourds en -- ten -- dent,
  Tous les in -- fir -- mes sont gué -- ris,
  Les pauvres ac -- cueil -- lent l’É -- van -- gi -- le,
  Et son ro -- yau -- me vient chez nous.
}

altoWordstrois = \lyricmode {  
  \im \set shortVocalName = "3." \set stanza = #"3. "
  Vous qui pei -- nez sous vo -- tre char -- ge
  Et qui plo -- yez sous le far -- deau,
  Ve -- nez à moi et ap -- pre -- nez \skip4
  Com -- bien mon cœur est humble et doux.
}

altoWordsquatre = \lyricmode {  
  \im \set shortVocalName = "4." \set stanza = #"4. "
  Fils é -- ter -- nel ve -- nu du Pè -- re
  Pour pren -- dre notre hu -- ma -- ni -- té,
  Fais res -- plen -- dir en no -- tre chair \skip4
  Les traits de ta di -- vi -- ni -- té.
}

altoWordscinq = \lyricmode {  
  \im \set shortVocalName = "5." \set stanza = #"5. "
  Nous te pri -- ons, Dieu no -- tre Pè -- re_:
  Par Jé -- sus Christ, re -- lè -- ve_- nous.
  Dans l’Es -- prit, don -- ne ta lu -- miè -- re,
  Et nos cœurs brû -- le -- ront d’a -- mour.
  \imstop A -- men.
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
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics \lyricsto "sopranos" \altoWordsquatre
    \new Lyrics \lyricsto "sopranos" \altoWordscinq
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