\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

% \paper {
%   #(set-paper-size "a5")
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter svp"
% }
% 
%  #(set-global-staff-size 18)
% 
% \header {
%   title = \markup \center-column { "Dieu juste et bon" }
%   subtitle = " "
%   poet = ""
%   composer = ""
%   tagline = ##f
% }
% 
% \layout { 
%   tagline = ##f
%   indent = #0
%   \context { \Score \remove "Bar_number_engraver"
%   }
%   \context { \Lyrics \override LyricText.font-size = #2.5
%              \override LyricSpace.minimum-distance = #1
%   }
% }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 1
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key e \minor
  \time 3/2
}

sopMusic = \relative c' {
  e2 g4 a b2 b cis4 dis e2 e d4 c b2 g b4 a g2
  e fis4 g a b c2 b1\fermata
  b2 a4 b g2 c b4 c a2 d c4 d b g fis2 e1\fermata \bar "|."
}

altoMusic = \relative c' {
  e2 e4 fis dis2 g a4 fis g2 e fis4 a g2 e dis4 fis e2 
  e dis4 e c b a2 e'1
  g2 fis4 dis e2 a g4 e fis2 b a4 fis g e dis2 s1
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. " \set shortVocalName = "1."
  Dieu juste et bon, en -- tends ma voix, 
  viens sans re -- tard et ré -- ponds_- moi,
  toi qui sais ma dé -- tres -- se.
  Oui, j’ai pé -- ché, 
  mais ta bon -- té m’a se -- cou -- ru sans ces -- se.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "  \set shortVocalName = "2."
  Vains et men -- teurs, jus -- ques à quand o -- se -- rons_- nous,
  Dieu tout_- puis -- sant, faire à ta gloire of -- fen -- se_?
  Grands sont nos torts,
  plus grande en -- core soit pour nous ta clé -- men -- ce.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. " \set shortVocalName = "3."
  Qui me fe -- ra voir le bon -- heur_?
  Mon -- tre ta face, ô Dieu sau -- veur, 
  car sa splen -- deur m’est chè -- re plus que le vin, 
  plus que le pain dont tous ont faim sur ter -- re.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. " \set shortVocalName = "4."
  Lors -- qu’au tom -- beau je dor -- mi -- rai, Dieu des vi -- vants,
  c’est dans ta paix que j’at -- ten -- drai cette heu -- re
  où vont s’ou -- vrir
  à mon dé -- sir pour tou -- jours tes de -- meu -- res.
}

\transpose e d

\new ChoirStaff <<
  \new Staff = "women"\with {\remove Time_signature_engraver }
  <<
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
>>