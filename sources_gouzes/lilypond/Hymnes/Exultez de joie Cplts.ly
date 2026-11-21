\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"


% \paper {
%   #(set-paper-size "a5" )
%   system-system-spacing.basic-distance = #17
%   top-margin = 20
%   bottom-margin = 20
%   tagline = ##f
%   print-page-number = ##f
% }
% 
% #(set-global-staff-size 16)
% 
% \layout {
%   indent = #0
%   \context {
%     \Score \remove "Bar_number_engraver"
%   }
%   \context {
%     \Lyrics
%     \override LyricText.font-size = #2
%   } 
% }
% 
% \header {
%   title = \markup \center-column { "Exultez de joie" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
%   tagline = ##f
% }
% 

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRIIhf }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Heureux ceux qui ont une â" -- me de pauvre_:
    "Le Royaume des cieux" est à eux.
    Heu -- reux les doux_:
    "Ils posséde" -- ront la terre.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Heureux le cœurs in" -- con -- so -- lés,
    "car le Seigneur les" gué -- ri -- ra.
    "Heureux les affamés et assoiffés" de jus -- tice,
    "car ils seront" ras -- sa -- siés.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Heureux hommes" de par -- don_:
    "Ils obtiendront mi" -- sé -- ri -- corde.
    "Heureux les cœurs purs qui" cher -- chent Dieu_:
    "L’Agneau de Dieu les" il -- lu -- mine.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Heureux les arti" -- sans de paix_:
    "Ils seront appelés" fils de Dieu.
    "Heureux les persécutés pour" la jus -- tice_:
    "Le Royaume des cieux" est à eux.
  }

  \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRIIhh }
>>