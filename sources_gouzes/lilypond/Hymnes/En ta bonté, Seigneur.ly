\version "2.24.0"
% 
% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 20
%   right-margin = 20
% }
% 
%  #(set-global-staff-size 18)
% 
% \header {
%   title = \markup \center-column { "En ta bonté, Seigneur" }
%   subtitle = " "
%   poet = ""
%   composer = ""
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
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key d \minor
  \time 4/4
}

resp = { \breathe\allowBreak }

sopMusic = \relative c' {
  \partial4 f4 e d a'4. g8 f4 e d f e2 d4\resp
  f e d a'4. g8 f4 g bes g a2.\resp
  a4 b cis d4. a8 c4 b a b a2 gis4 \resp
  a b c b4. a8 g4 f e e d2.\fermata
  \bar "|."
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. " \set shortVocalName = "1."
  En ta bon -- té, Sei -- gneur, prê -- te l’o -- reil -- le.
  Ton peu -- ple crie vers toi son re -- pen -- tir.
  Sous ton re -- gard, les fau -- tes se dé -- voi -- lent.
  Mets en nos cœurs la grâ -- ce du par -- don.
  Mets en nos cœurs la grâ -- ce du par -- don.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "  \set shortVocalName = "2."
  Par -- ta -- ge_- nous ta pri -- ère et ta veil -- le,
  Sei -- gneur, ta for -- ce domp -- te -- ra nos corps.
  Pu -- ri -- fie_- nous de tou -- tes nos fai -- bles -- ses,
  ar -- ra -- che_- nous à l’om -- bre de la mort.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. " \set shortVocalName = "3."
  Brille en la nuit pour gui -- der no -- tre rou -- te.
  Mène au dé -- sert ton peu -- ple li -- bé -- ré.
  Frap -- pe nos cœurs et dis -- si -- pe nos dou -- tes,
  fai -- sant fail -- lir la sour -- ce du Ro -- cher.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. " \set shortVocalName = "4."
  Ci -- té de Dieu sur la sain -- te mon -- ta -- gne,
  Jé -- ru -- sa -- lem, nous mon -- te -- rons vers toi.
  En -- tre tes murs où chan -- te l’es -- pé -- ran -- ce,
  qu’un peuple en -- tier re -- trou -- ve l’u -- ni -- té_!
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5. " \set shortVocalName = "5."
  Souf -- fle de Dieu, dis -- si -- pe nos mi -- sè -- res.
  Prends les pé -- cheurs pour faire un peu -- ple saint.
  Fais_- nous mar -- cher en -- sem -- ble vers le Pè -- re
  sur les che -- mins du Christ et de la croix.
}

\new ChoirStaff <<
  \new Staff = "women" %\with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      << \global \sopMusic >>
    }
  >> 
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
>>