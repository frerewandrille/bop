\version "2.24.0"

%\include "TonsDef0.ly"
%\include "TonsRDef.ly"
\include "vowel-set.ly"

% #(set-global-staff-size 16)
% 
% \paper { #(set-paper-size "a4" ’landscape) 
%          tagline = ##f 
%          print-page-number = ##f
% }
% 
% \header { title = \markup \center-column { "Communion pour la Transfiguration" } }
% 
% \layout {
%   indent = #0
%   \context { \Score \remove "Bar_number_engraver" }
%   \context { \Staff
%              \override Script.font-size = #-1
%              \override TimeSignature.style = #'single-digit
%   }
%   \context { \Lyrics
%              \override LyricText.font-name = #"EB Garamond"
%              \override LyricText.font-size = #3
%              \override LyricSpace.minimum-distance = #1
%   }
% }
% \markup{ \vspace #1 }
% 
% \include "Jésus prit avec lui T561.ly"


\layout {
  \context { \Lyrics
             \override InstrumentName.X-offset = 2
             \override InstrumentName.font-size = 0
             \override InstrumentName.font-series = #'bold
  }
}

armure = { \key f \major \time 3/4 }
retrait = \once \override LyricText.X-offset = #retrait


\transpose a fis
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIbf }

  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Jésus prit avec" "lui ’ Pierre, Jacques, et" Jean son frère,
    "il les emme" -- "na ’ sur une hau" -- te mon -- tagne,
    "et, tandis qu’il priait, ’ il fut transfigu" -- "ré de" -- vant eux,
    "et ses vêtements devinrent" "blancs ’ com" -- me la neige.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Voici qu’une nu" -- "ée les couvrit" de son ombre,
    "et que du ciel la voix du" "Père se" fit ent -- endre_:
    "celui-ci est mon Fils bien-aimé," écou -- tez_- le_!
    "Seigneur, dans ta lu" -- "mière, nous avons vu" la lu -- mière_!    
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  {
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Voici que Moïse et É" -- "lie, apparus" dans la gloire,
    "s’entretenaient avec lui de son e" -- "xode à Jé" -- ru -- sa -- lem_;
    "car le Fils de l’homme sera li" -- "vré aux" bour -- reaux,
    "il sera mis mort, mais le troisième" "jour il ressus" -- ci -- te -- ra_!
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Seigneur, je t’en" "prie, fais-moi" voir ta face_!
    "Et Dieu dit : “Je te cache" -- "rai dans la fente" du ro -- cher,
    "et je pose" -- "rai ma main" sur toi_;
    "mais ma face, on ne peut la" voir sans mou -- rir_!”
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"5. " \set shortVocalName = "5." 
    "Dieu, per" -- "sonne ne l’a" ja -- mais vu,
    "mais le Fils qui est dans le sein du" "Père, ’ lui, nous l’a" ré -- vé -- lé.
    "Et nous avons vu la" "gloire qu’il tient de" son Père
    "comme Fils unique ’ plein de" "grâce et de" vé -- ri -- té.
  }
  %   \addlyrics \with {\override LyricText.X-offset = #centrer }
  %   { 
  %     \set stanza = #"6. " \set shortVocalName = "6." 
  %     "Nous tous qui, le visage décou" -- "vert, réfléchissons comme en"
  %   }
  %   \addlyrics \with {\override LyricText.X-offset = #centrer }
  %   { 
  %     \skip4 \retrait "un miroir la gloire" du Sei -- gneur,
  %     \set shortVocalName = "6." 
  %     "nous sommes transformés de gloire en " "gloire en cette" même i -- mage,
  %     "pour faire resplendir la connais" -- "sance de la gloire" de Dieu,
  %     "qui est sur la" fa -- ce du Christ.
  %   }

  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIbh }
>>