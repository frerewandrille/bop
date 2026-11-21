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
%   title = \markup \center-column { "Louange à toi" }
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
  e4 b' b b2 g4 a2 c4 b2. | b4 b d c2 b4 a2 a4 g2.
  b4 a g a2 fis4 g2 g4 fis2. | fis4 g a b2 g4 a fis2 e2.
  \bar "|."
}

altoMusic = \relative c' {
 b4 e e dis2 e4 c2 e4 e2. | g4 g fis e2 d4 d2 d4 d2.
 d4 d b d2 d4 b2 e4 dis2. | dis4 e fis g2 e4 e dis2 e2.
}

tenorMusic = \relative c' {
  g4 g g fis2 e4 e2 a4 gis2. | e4 g! b g2 g4 fis2 fis4 g2.
  g4 fis e fis2 a4 g2 b4 b2. | b4 b d d2 c4 c b2 b2.
}

bassMusic = \relative c {
  e4 e e b2 c4 a2 a4 e'2. | e4 e b c2 g4 d'2 d4 g,2.
  g4 d' e d2 d4 e2 e4 b2. | b4 e d g2 c,4 a b2 e2.
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
    Lou -- ange à toi, Sei -- gneur Jé -- sus.
    L’hum -- ble che -- min de ta ve -- nue
    gui -- de nos pas jus -- \apostrophe qu’au sa -- lut.
    %\set stanza = #" 1-4."
    Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = "2." 
    La mort n’a pu gar -- der sa proie.
    L’en -- fer vain -- cu s’ouvre à ta voix.
    L’a -- mour tri -- om -- phe par la croix.
    Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3." 
      Voi -- ci la tom -- be des -- cel -- lée,
      et ses té -- moins pour l’an -- non -- cer
      sont en -- voy -- és au monde en -- tier.
    Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4." 
      Tu es vi -- vant_! Gloire à ton nom_!
      Hâ -- te le temps où nous pour -- rons
      vi -- vre sans fin dans ta mai -- son.
    Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
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
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "sopranos" \altoWordsquatre
  
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