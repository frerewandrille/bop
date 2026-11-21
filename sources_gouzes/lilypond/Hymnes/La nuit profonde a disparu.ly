\version "2.24.0"
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
% 
% #(set-global-staff-size 28)
% 
% \header {
%   title = \markup \center-column { "La nuit profonde a disparu" }
%   subtitle = " "
%   poet = ""
%   composer =  "Abbaye d’Orval"
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

sopMusic = \relative c' {
  d8 d [d] a' [g] f [e] d4\resp
  a'8 a [a] c [bes] a [g] a4 a4 \bar"|"
  a8 a [a] a [g] a [f] e4 \resp
  d8 d [d] f [g] f [e] d4 d4
  \bar "|."
  d8 ([e d]) c4 (d) \bar "|."
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  La nuit pro -- fonde a dis -- pa -- ru,
  le ciel pâ -- lit,   voi -- ci l’au -- ro -- re.
  Jé -- sus, lu -- miè -- re du che -- min,
  con -- duis nos pas de -- vant ta fa -- ce.
}

altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Ô toi qui son -- des tous les cœurs,
  pé -- nè -- tre_- nous de ta lu -- miè -- re.
  Pu -- ri -- fie_- nous du mal ca -- ché,
  dé -- li -- vre_- nous de nos té -- nè -- bres.
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Que tout le jour, à sa clar -- té
  nos pas s’a -- van -- cent sur la rou -- te
  où nous i -- rons sous ton re -- gard,
  pleins d’al -- lé -- gresse et pleins de for -- ce.
}

altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Ras -- sem -- ble_- nous dans ton a -- mour,
  ra -- mène à toi ceux qui s’é -- ga -- rent,
  rap -- pel -- le la bre -- bis per -- due,
  ac -- cueil -- le ceux qui se re -- pen -- tent.
}

altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  À toi la gloire, ô Pè -- re saint,
  comme à ton Fils est la lou -- an -- ge,
  a -- vec l’Es -- prit con -- so -- la -- teur,
  de -- puis tou -- jours et dans les siè -- cles. A -- men.
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