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

global = { \key a \minor \time 2/4}
resp = { \breathe\allowBreak }


sopranoVoice = \relative c' {
  \revert Staff.TimeSignature.style \global
  \voiceOne
  e8 a a a a4 c8 b a b c (b) a4 
  e8 a a a a4 c8 b a b c (b) a4
  a8 e' e e e (d) c4 e8 e d c \time 3/4 b2 
  e,8 e \time 2/4 e a a g a2\fermata
  \bar"|."
}


verseOne = \lyricmode {
  \set stanza = "1."\set shortVocalName = \markup\right-align"1." 
  Tout le ciel s’em -- plit
  D’u -- ne joie nou -- vel -- le_:
  On en -- tend la nuit
  Di -- re la mer -- veil -- le,
  Fê -- te sans pa -- reil -- le_:
  Le Sau -- veur est né,
  L’En -- fant_- Dieu nous est don -- né.
}

verseTwo = \lyricmode {
  \set stanza = "2."\set shortVocalName = \markup\right-align"2." 
  Le Sei -- gneur pa -- raît,
  Ver -- be de lu -- miè -- re_:
  L’u -- ni -- vers con -- naît
  La bon -- té du Pè -- re.
  Dieu sur no -- tre ter -- re
  Vient tra -- cer la voie
  Où che -- mi -- ne -- ront nos pas.
}

verseThree = \lyricmode {
  \set stanza = "3."\set shortVocalName = \markup\right-align"3." 
  A -- vec les ber -- gers,
  A -- vec tous les sa -- ges,
  C’est le monde en -- tier
  Qui vers lui s’en -- ga -- ge
  Pour voir le vi -- sa -- ge
  De l’A -- mour vi -- vant
  Qui pour nous s’est fait en -- fant.
}

verseFour = \lyricmode {
  \set stanza = "4."\set shortVocalName = \markup\right-align"4." 
  Gloire à Jé -- sus Christ_!
  Gloire au Fils du Pè -- re_!
  Gloire à son Es -- prit
  Dont l’a -- mour é -- clai -- re
  L’é -- cla -- tant mys -- tè -- re
  Qui rem -- plit le ciel_:
  Gloire à l’Hom -- me_- Dieu, No -- ël_!
}

\score {
  \new Staff \with { \consists "Merge_rests_engraver" } %\with { \remove Time_signature_engraver }
  { \sopranoVoice }
  \addlyrics { \verseOne }
  \addlyrics { \verseTwo }
  \addlyrics { \verseThree }
  \addlyrics { \verseFour }
}
