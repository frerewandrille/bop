\version "2.24.0"
% 
% \paper {
%   #(set-paper-size "a5")
%   top-margin = 25
%   left-margin = 15
%   right-margin = 15
% }
% 
% #(set-global-staff-size 19)
% 
% \header {
%   title = \markup \center-column { "Hymne de sexte du Carême" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
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

sopMusic = \relative c'' {
  a8 a f g a bes a g4\breathe\allowBreak g8 g bes a f g bes a4 \bar "|"\break
  bes8 c bes a g bes a g4 \breathe\allowBreak a8 a f g a bes a g4\bar "|."%\break
  g4 (a8 [g]) f4 (g)\bar"|."
}


altoWordsun = \lyricmode {  
  \set stanza = #"1. " \set shortVocalName = "1."
  Voi -- ci l’heure où le Christ eut soif,
  l’heure où il mon -- ta sur la croix_;
  qu’il don -- ne soif de la jus -- tice
  à ceux qui le chantent à cette heure.
}
altoWordsdeux = \lyricmode {  
  \set stanza = #"2. "\set shortVocalName = "2." 
  Qu’ils res -- sentent aus -- si cet -- te faim
  que lui seul peut ras -- sa -- si -- er_;
  que le pé -- ché leur soit dé -- goût
  et la ver -- tu, tout leur dé -- sir.
}
altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Qu’il ré -- pan -- de sur ceux qui chantent
  le don du Saint Es -- prit de Dieu,
  tem -- pé -- rant l’ar -- deur de la chair, 
  ré -- chauf -- fant la froi -- deur de l’âme.
}
altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  Im -- plo -- rons le Christ et le Père
  et l’Es -- prit du Père et du Christ_:
  ô Tri -- ni -- té, une et puis -- sante,
  daigne é -- cou -- ter ceux qui te prient.
  A -- men.
}


\score {
  \new ChoirStaff 
  <<
    \new Staff = "women" \with { \remove "Time_signature_engraver" } 
    \new Voice = "sopranos" {
      \cadenzaOn \key g \minor \time 2/4 \sopMusic
    }
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  >>
}