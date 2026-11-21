\version "2.24.1"

\include "vowel-set.ly"

% \header {
%   title = "O Dieu qui fit jaillir de l‘ombre"
%   subtitle = "HO83"
%   composer = "J. Berthier"
%   % Supprimer le pied de page par défaut
%   tagline = ##f
% }
% 
% \paper {
%   #(set-paper-size "a5")
%   indent = 0
% }

\layout {
  \context {
    \Score
    \remove "Bar_number_engraver"
  }
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = { \key a \minor }
resp = { \breathe\allowBreak }


sopranoVoice = \relative c' {
  \global
  \cadenzaOn \voiceOne
  e2 a4 b c2 b a4 gis a2 e\resp g a4 g f e e2 d e1\bar"|"
  b'2 c4 d e2 d c4 c b2\resp r4 e d c b2 a g4 a b2 a1\bar"|."
}

altoVoice = \relative c' {
  \global
  \cadenzaOn \voiceTwo
  e2 a4 g c,2 d e4 4 f2 e e c4 e f \tiny g a2 c b1 \normalsize
  e,2 a4 g c2 g a4 d, e2 r4 c g' a e2 f f4 e <d g>2 <a e'>1
}


verseOne = \lyricmode {
  \set stanza = "1."\set shortVocalName = \markup\right-align"1." 
  % Ajouter ici des paroles.
  Ô Dieu qui fis jail -- lir de l’om -- bre
  Le monde en son pre -- mier ma -- tin,
  Tu fais bril -- ler dans no -- tre nuit
  La con -- nais -- san -- ce de ta gloi -- re.
}

verseTwo = \lyricmode {
  \set stanza = "2."\set shortVocalName = \markup\right-align"2." 
  % Ajouter ici des paroles.
  Tu es l’i -- ma -- ge de ton Pè -- re
  Et la splen -- deur de sa beau -- té.
  Sur ton vi -- sage, ô Jé -- sus Christ,
  Brille à ja -- mais la joie du mon -- de.
}

verseThree = \lyricmode {
  \set stanza = "3."\set shortVocalName = \markup\right-align"3." 
  % Ajouter ici des paroles.


  Tu es toi -- mê -- me la lu -- miè -- re
  Qui luit au fond d’un lieu obs -- cur.
  Tu es la lam -- pe de nos pas
  Sur u -- ne rou -- te de té -- nè -- bres.

}

verseFour = \lyricmode {
  \set stanza = "4."\set shortVocalName = \markup\right-align"4." 
  % Ajouter ici des paroles.

  Quand tout dé -- cli -- ne, tu de -- meu -- res,
  Quand tout s’ef -- fa -- ce, tu es là_!
  Le soir des -- cend, tu res -- plen -- dis
  Au cœur de tou -- te cré -- a -- tu -- re.

}

verseFive = \lyricmode {
  \set stanza = "5."\set shortVocalName = \markup\right-align"5." 
  % Ajouter ici des paroles.

  Et quand l’au -- ro -- re qui s’an -- non -- ce
  Se lè -- ve -- ra sur l’u -- ni -- vers,
  Tu ré -- gne -- ras dans la ci -- té
  Où dis -- pa -- rais -- sent les té -- nè -- bres.
}

\score {
  \new Staff \with { \consists "Merge_rests_engraver" } \with { \remove Time_signature_engraver }
  { << \sopranoVoice \altoVoice >>}
  \addlyrics { \verseOne }
  \addlyrics { \verseTwo }
  \addlyrics { \verseThree }
  \addlyrics { \verseFour }
  \addlyrics { \verseFive }
}
