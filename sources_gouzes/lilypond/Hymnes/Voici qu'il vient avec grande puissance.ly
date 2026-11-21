\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% #(set-global-staff-size 13)
% 
% \header {
%   title = \markup \center-column { "Ô très doux Créateur" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
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

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
  } 
}

global = {
  \key a \major
  \time 2/2
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

sopMusic = \relative c' {
  e2 a cis b4 b cis e d cis b2 a r a gis4 fis e e a a b cis d2 cis r
  cis e4 d cis2 b a4 gis a b cis2 r d cis b a1
  \bar "|."
}
altoMusic = \relative c' {
  e2 fis a gis4 4 a a a a a (gis) a2 r e e4 d cis b e cis e e fis2 eis r 
  e! a4 a a2 gis fis4 e fis gis a2 r a a a4 (gis) a1
}
tenorMusic = \relative c' {
  cis2 2 e e4 e e cis fis cis e2 e r cis cis4 a a gis a a gis gis b2 a r 
  a cis4 fis e2 e cis4 cis cis e e2 r fis e e e1
}
bassMusic = \relative c' {  
  a2 fis cis e4 e a a d, a e'2 a, r a cis4 d a e' cis fis e cis b2 cis r 
  a a4 d a'2 e fis4 cis fis e a2 r d, a' e a,1
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Voi -- ci qu’il vient a -- vec gran -- de puis -- san -- ce.
  %Il est re -- vê -- tu de tou -- te sa gloi -- re.
  Il est re -- vê -- tu d’une im -- men -- se gloi -- re.
  Il a re -- çu pou -- voir sur tou -- te chair.
  Le Christ est roi_!
}
altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  %Jé -- sus qui pour nous est mort sur u -- ne croix,
  Jé -- sus Christ, par la mort qu’il a souf -- fer -- te,
  Dieu l’a é -- ta -- bli Sei -- gneur sur le mon -- de
  en le res -- sus -- ci -- tant d’en -- tre les morts.
  Le Christ est roi_!
}
altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Voi -- ci qu’il fait tou -- te cho -- se nou -- vel -- le,
  le Pre -- mier_- né de tou -- te cré -- a -- tu -- re,
  %il ré -- con -- ci -- lie la terre et le ciel.
  ré -- con -- ci -- liant la terre a -- vec le ciel.
  Le Christ est roi_!
}
altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Que les na -- tions de -- vant toi se pros -- ter -- nent,
  car est ve -- nu le temps de ton Roy -- au -- me.
  Qu’ex -- ul -- tent tous les a -- mants de ton Nom.
  Le Christ est roi_!
}
altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  Sa -- lut, puis -- sance, hon -- neur et gloire au Pè -- re,
  par Jé -- sus Christ qui é -- ta -- blit son rè -- gne,
  %il nous com -- ble des dons de son Es -- prit.
  en nous com -- blant des dons de son Es -- prit.
  Le Christ est roi_!
}

\transpose a g
\new ChoirStaff 
<<
  \new Staff = "women" \with { \consists "Merge_rests_engraver" }
  <<
    \new Voice = "sopranos" {
      \voiceOne  << \global \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo << \global \altoMusic >>
    }
  >>
  
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics %\with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordscinq
  
  \new Staff = "men" \with { \consists "Merge_rests_engraver" }
  <<
    \new Voice = "ténors" \with { \consists "Balloon_engraver" } {
      \clef bass \voiceOne << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>