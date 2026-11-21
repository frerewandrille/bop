\version "2.24.0"
% 
% \paper {
%   #(set-paper-size "a5")
%   %system-system-spacing #'basic-distance = #17
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = ##f
% }
% 
% \header {
%   title = \markup \center-column { "Heureux les pauvres" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
% }
% 
% #(set-global-staff-size 19)

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
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key f \minor
  \time 6/4
}

sopMusic = \relative c' {
  \partial 1 c4 f2 aes4 g2 f4 g f ees f2 \breathe\allowBreak
  f4 aes2 bes4 c2 aes4 bes2 bes4 
  \time 9/4 c2.~c2 \breathe\allowBreak
  aes4 c2 bes4 \time 6/4 c4 bes aes bes2 aes4 g2 \breathe\allowBreak
  c,4 f2 aes4 g2 f4 g f ees f2.~ f2 \bar "|."
}

altoMusic = \relative c' {
  \partial 1 c4 c2 c4 des2 des4 bes bes c f2
  f4 ees2 des4 c2 f4 des2 ees4 aes2.~ aes2
  f4 e (f) g c, c c d2 d4 e2 
  c4 des!2 c4 bes2 des4 bes c c f2.~ f2
}


altoWordsun = \lyricmode {  
  \set stanza = #"1. "\set shortVocalName = "1."
  Heu -- reux les pau -- vres pour le Sei -- gneur_:
  Le ciel dé -- jà leur est don -- né.
  Heu -- reux les hum -- bles, heu -- reux les doux_: 
  Leur part se -- ra la vie à ja -- mais.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = "2."
  Heu -- reux les frè -- res prêts au par -- don_:
  L’Es -- prit d’a -- mour les a com -- blés.
  Heu -- reux les jus -- tes, heu -- reux les purs,
  Car ils ver -- ront la fa -- ce de Dieu.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Heu -- reux tous ceux qui por -- tent la paix_:
  Ils sont les fils du Dieu vi -- vant.
  Heu -- reux les hommes au cœur simple et droit,
  Car dans sa gloi -- re, Dieu les pren -- dra.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  Heu -- reux les frè -- res per -- sé -- cu -- tés,
  Té -- moins du Christ en sa pas -- sion,
  Car Dieu lui_- mê -- me se -- ra leur joie
  Dans le Roy -- aume où il les at -- tend.
}


\score {
  \new ChoirStaff 
  <<
    \new Staff = "women" \with { \remove "Time_signature_engraver" }
    <<
      \new Voice = "sopranos" {
        \voiceOne
        \global \sopMusic
      }
      \new Voice = "altos" {
        \voiceTwo
        \global \altoMusic
      }
    >>
    
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  >>
}