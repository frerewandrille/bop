\version "2.24.0"
 
\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" ’landscape)
%   %system-system-spacing #'basic-distance = #10
%   top-margin = 9
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 16)
% 
% \header {
%   title = \markup \center-column { "Louange à Dieu" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
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

global = {
  \key g \major
  \time 3/4
}

gauche = {}% \once \override LyricText.self-alignment-X = #-1 }

sopMusic = \relative c' {
  e4 b' b b2 g4 a2 c4 b2 b4 | b4 b d c2 b4 a2 a4 g2 g4
  b4 a g a2 fis4 g2 g4 fis2 fis4 | fis4 g a b2 g4 a fis2 e2.
  \bar "|."
}

altoMusic = \relative c' {
 b4 e e dis2 e4 c2 e4 e2 e4 | g4 g fis e2 d4 d2 d4 d2 d4
 d4 d b d2 d4 b2 e4 dis2 dis4 | dis4 e fis g2 e4 e dis2 e2.
}

tenorMusic = \relative c' {
  g4 g g fis2 e4 e2 a4 gis2 gis4 | e4 g! b g2 g4 fis2 fis4 g2 g4
  g4 fis e fis2 a4 g2 b4 b2 b4 | b4 b d d2 c4 c b2 b2.
}

bassMusic = \relative c {
  e4 e e b2 c4 a2 a4 e'2 e4 | e4 e b c2 g4 d'2 d4 g,2 g4
  g4 d' e d2 d4 e2 e4 b2 b4 | b4 e d g2 c,4 a b2 e2.
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
    Lou -- ange à Dieu, Très_- Haut Sei -- gneur, __\skip4
    Pour la beau -- té de tes ex -- ploits. __\skip4
    Par la mu -- sique et par nos voix, __\skip4
    Lou -- ange à lui dans les hau -- teurs_!
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = "2." 
    Lou -- ange à lui, puis -- sance, hon -- neur, __\skip4
    Pour les ac -- tions de son a -- mour. __\skip4
    Au son du cor et du tam -- bour, __\skip4
    Lou -- ange à lui pour sa gran -- deur_!
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3." 
      Tout vient de lui, tout est pour lui_! __\skip4
      Har -- pes, ci -- tha -- res, lou -- ez_- le. __\skip4
      Cor -- des et flû -- tes, chan -- tez_- le, __\skip4
      Que tout vi -- vant le glo -- ri -- fie_!
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4." 
      Que no -- tre joie soit donc en  lui, __ \skip4
      Le sou -- ve -- rain de gloire im -- men -- se.
      Les yeux sur les na -- tions, il veil -- le.
      Qu’on ne se dres -- se con -- tre lui_!
}

altoWordscinq = \lyricmode {  
  \set stanza = #"5. "\set shortVocalName = "5." 
      Gloire au Sei -- gneur, vous tous les peu -- ples,
      Ex -- al -- tez_- le, tous les pa -- ys. __ \skip4
      Ar -- dent est son a -- mour pour nous, __\skip4
      Et pour tou -- jours sa vé -- ri -- té_!
}


%\markup { \vspace #-1 }
\score {
  \new ChoirStaff <<
    \new Staff = "women" <<
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
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "sopranos" \altoWordscinq
  
    \new Staff = "men" <<
      \clef bass
      \new Voice = "tenors" {
        \voiceOne
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo << \global \bassMusic >>
      }
    >>
  >>
}