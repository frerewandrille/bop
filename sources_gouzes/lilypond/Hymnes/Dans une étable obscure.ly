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
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
  } 
}

global = {
  \key f \major
  \time 4/4
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

sopMusic = \relative c'' {
  \partial2 c2 c4 c d c c2 a bes a4 g f2 e f\fermata
  c' c4 c d c c2 a bes a4 g f2 e f\fermata
  r4 a8 a g4 (e) f d c2. 
  c'4 c c d c c2 a bes a4 g f2 e f\fermata
  \bar "|."
}
altoMusic = \relative c' {
  f2 4 4 4 4 e2 f g d4 d c2 c c
  f2 4 4 4 4 e2 f g d4 d c2 c c
  r4 c8 c b4 (c) d b c2.
  f4 f f f f e2 f g d4 d c2 c c
}
tenorMusic = \relative c' {
  a2 4 4 bes a g2 f d' c4 bes a2 g a
  a2 4 4 bes a g2 f d' c4 bes a2 g a
  r4 f8 f d4 (a') a f e2.
  a4 a a bes a g2 f d' c4 bes a2 g4 (bes) a2
}
bassMusic = \relative c { 
  f2 f4 f bes, f' c2 d g, a4 bes c2 c f,\fermata
  f'2 f4 f bes, f' c2 d g, a4 bes c2 c f,\fermata
  r4 f8 f g4 (a) d g, c2.
  f4 f f bes, f' c2 d g, a4 bes c2 c f,\fermata
}

altoWordsun = \lyricmode {  
  \set shortVocalName = \markup\right-align"1." \set stanza = #"1."
  Dans une é -- table obs -- cu -- re,
  Sous le ciel é -- toi -- lé
  Et d’u -- ne Vier -- ge pu -- re,
  Un doux Sau -- veur est né.
  Le Sei -- gneur Jé -- sus Christ
  Est né dans u -- ne crè -- che
  Quand a son -- né mi -- nuit.
}
altoWordsdeux = \lyricmode {  
  \set shortVocalName = \markup\right-align"2." \set stanza = #"2." 
  Tan -- dis que les rois ma -- ges,
  Tan -- dis que les ber -- gers
  Lui por -- tent leurs hom -- ma -- ges,
  Por -- tons_- lui nos bai -- sers_:
  Le Sei -- gneur Jé -- sus Christ
  Sau -- ra bien nous sou -- ri -- re,
  En cette heu -- reu -- se nuit.
}
altoWordstrois = \lyricmode {  
  \set shortVocalName = \markup\right-align"3." \set stanza = #"3."
  Plein d’u -- ne foi pro -- fon -- de,
  Le monde est à ge -- noux.
  Frê -- le Ma -- jes -- té blon -- de,
  É -- tends les mains sur nous_:
  Ô Jé -- sus tout pe -- tit,
  Le monde en -- tier t’ac -- cla -- me
  Dans l’a -- do -- ra -- ble nuit. 
}

\new ChoirStaff 
<<
  \new Staff = "women" \with { \consists "Merge_rests_engraver" }
  <<
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
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordstrois
  
  \new Staff = "men" \with { \consists "Merge_rests_engraver" }
  <<
    \clef bass
    \new Voice = "ténors" {
      \voiceOne
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo 
      << \global \bassMusic >>
    }
  >>
>>