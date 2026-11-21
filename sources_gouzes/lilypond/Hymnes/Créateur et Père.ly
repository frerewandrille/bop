\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }
% 
% \paper {
%   %system-system-spacing #'basic-distance = #17
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = ##f
% }
% 
% #(set-global-staff-size 28)
% 
% \header {
%   title = \markup \center-column { "Créateur et Père" }
%   subtitle = " "
%   poet = ""
%   composer =  "Abbaye d’Orval"
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
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key f \major
  \time 5/4
}

resp = { \breathe\allowBreak }

sopMusic = \relative c'' {
  a8 [a] d4 c8 [d] c [a] g4. \resp a8 g [g] f [f] f [g] a4.\bar "|"
  a8 g [f] e [d] f [g] a4 \resp a8 [bes] g4 g8 [a] f [e] d4 \bar "|."
  d8 ([e d]) c4 (d) \bar "|."
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Cré -- a -- teur et Pè -- re très bon,
  en -- tends l’ap -- pel de tes en -- fants.
  Ce temps sa -- cré, fé -- con -- de_- le,
  sanc -- ti -- fie ces qua -- ran -- te jours.
}

altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Ton re -- gard pé -- nè  tre les cœurs,
  tu sais nos for -- ces li -- mi -- tées.
  À toi nous som -- mes re -- ve -- nus,
  en ta grâ -- ce, par -- don -- ne_- nous.
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Nous sen -- tons pe -- ser nos pé -- chés_:
  Pi -- tié pour ceux qui te l’a -- vouent.
  Li -- bè -- re_- nous de leur far -- deau,
  glo -- ri -- fie à ja -- mais ton nom.
}

altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Que l’es -- prit sou -- met -- te la chair,
  se ren -- de li -- bre pour ai -- mer.
  La loi de mort se -- ra vain -- cue,
  vic -- to -- rieu -- se, la loi du Christ.
}

altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  Tri -- ni -- té, mys -- tère in -- fi -- ni,
  à toi lou -- ange, a -- do -- ra -- tion.
  Qu’il por -- te fruit de sain -- te -- té,
  ce ca -- rême ac -- com -- pli pour toi. A -- men.
}

\new Staff = "women" \with {\remove Time_signature_engraver }
<<
  \new Voice = "sopranos" {
    << \global \cadenzaOn \sopMusic >>
  }
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
>>