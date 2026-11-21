\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   system-system-spacing.basic-distance = #0
%   top-margin = 10
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter svp"
%   print-page-number = ##f
% }
% 
% #(set-global-staff-size 13)
% 
% \header {
%   title = \markup \center-column { "Il est ressuscité des morts" }
%   subtitle = " "
%   poet = ""
%   composer = ""
% }
%
\layout {
  indent = #0
  \context {
    \Score \remove "Bar_number_engraver"
  }
  \context {
    \Lyrics
    \override LyricText.font-size = #2
    \override LyricSpace.minimum-distance = #1
  } 
}

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = { \key g \minor \time 4/4 }
resp = { \breathe }
silN = { \oneVoice r4 \voiceOne }

sopMusic = \relative c'' {
  \repeat volta 2 {
    g2 g4 bes a g bes c d2\fermata\breathe 
    d2--^\markup{\italic bien détaché} d4-- d-- f-- d-- d c8 (bes) c4 c }
  \alternative { { bes2.\fermata \silN }  { bes2\fermata \bar"||" } }
  %  g2 g4 bes a g bes c d2\fermata\breathe
  %  d2--^\markup{\italic bien détaché} d4-- d-- f-- d-- d c8 (bes) c4 c bes2\fermata \bar"||"
  bes2 bes4 d c a bes c d2\fermata\breathe d2 d4 d c c bes a8 (g) fis2\fermata\breathe
  \repeat volta 2 { bes8. (c16) d4 c (d bes a) } \alternative{ { g2\fermata } { g1\fermata } }
  %bes8. (c16) d4 c (d bes a) g1\fermata
  \bar"|."
}

altoMusic = \relative c' {
  \repeat volta 2 {
    d2 d4 f f d d f f2 
    f4 (g8-. a-.) bes4 f a8 (g) f4 bes g bes a } 
  \alternative { { f2. s4 }  { f2 } }
  %   d2 d4 f f d d f f2 
  %   f4 (g8-. a-.) bes4 f a8 (g) f4 bes g bes a f2
  f2 g4 f f f d g fis2 f! f4 f f f d ees d2
  \repeat volta 2 { f4 f fis (g2 fis4) } \alternative{ { d2 } { d1 } }
  %f4 f fis (g2 fis4) d1
}

tenorMusic = \relative c' {
  \repeat volta 2 { bes2 bes4 d c bes bes a bes2 d f4 d c d f ees c f } 
  \alternative { { d2. \silN }  { d2 } }
  %  bes2 bes4 d c bes bes a bes2 d f4 d c d f ees c f d2
  d2 d4 bes a c bes g a2 bes bes4 bes a a bes c a2
  \repeat volta 2 { d4 d d8 (c bes4 c8 bes a4) } \alternative{ { bes2 } { bes1 } }
  %d4 d d8 (c bes4 c8 bes a4) bes1
}

bassMusic = \relative c' { 
  \repeat volta 2 {g2 g4 d f g g f bes,2\fermata\breathe
                   bes'-- bes4-- bes-- f-- bes-- bes ees, f f }
  \alternative{ { bes2.\fermata s4 }  { bes2\fermata } }
  %  g2 g4 d f g g f bes,2\fermata\breathe
  %  bes'-- bes4-- bes-- f-- bes-- bes ees, f f bes2\fermata
  bes g4 bes, f' f g ees d2\fermata\breathe
  bes bes4 bes f' f g c, d2\fermata\breathe
  \repeat volta 2 { <bes bes'>4 bes' a (g c, d) } \alternative{ { g2\fermata } { g1\fermata } }
  %<bes, bes'>4 bes' a (g c, d) g1\fermata
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. "\set shortVocalName = "1." 
  Il est res -- sus -- ci -- té des morts. 
  Voi -- ci qu’il se tient au mi -- lieu de nous.
}

altoWordsunb = \lyricmode { 
  A -- vec Tho -- mas, nous pro -- cla -- mons_:
  "“Jé" -- sus, tu es mon Sei -- gneur et mon \skip4 "Dieu !”"
  \set shortVocalName = "1." 
  Heu -- reux ceux qui, sans a -- voir vu,
  ont cru au Christ, le Fils de Dieu_!
  \set stanza = #"  1-4. "\set shortVocalName = "1-4." 
  Al -- lé -- lu -- ia,  ia_!
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "\set shortVocalName = "2." 
  Il est res -- sus -- ci -- té des morts, 
  lui que nous a -- vions clou -- é sur la Croix.
}

altoWordsdeuxb = \lyricmode { 
  "“Voi" -- ci mes mains, voi -- ci mes pieds.
  Re -- gar -- dez ce -- lui qui fut trans -- per -- \skip4 cé_!
  \set shortVocalName = "2." 
  Voi -- ci la plaie de mon cô -- té
  d’où l’eau et le sang ont cou -- "lé !”"
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. "\set shortVocalName = "3." 
  Il est res -- sus -- ci -- té des morts. 
  Il nous rem -- plit de joie par sa ve -- nue.
}

altoWordstroisb = \lyricmode { 
  Nul ne pour -- ra nous en -- le -- ver 
  la paix que le mon -- de ne peut don -- \skip4 ner.
  \set shortVocalName = "3." 
  "“Paix" soit à vous, dit le Sei -- gneur,
  par -- fai -- te soit en vous la "joie !”"
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. "\set shortVocalName = "4." 
  Il est res -- sus -- ci -- té des morts. 
  Il mon -- te vers son Dieu et no -- tre Dieu.
}

altoWordsquatreb = \lyricmode {
  D’au -- près du Pè -- re, l’Es -- prit_- Saint, 
  l’Es -- prit de vé -- ri -- té nous est don -- \skip4 né.
  \set shortVocalName = "4." 
  Gloire à Dieu Père et à l’Es -- prit, 
  gloire à Jé -- sus res -- sus -- ci -- té_!
}

\transpose g e
\new ChoirStaff <<
  \new Staff = "women"   <<
    \new Voice = "sopranos" {
      \voiceOne \tempo "Assez vif"
      << \global \sopMusic >>
    }
    \new Voice = "altos" %\with { \consists "Balloon_engraver" }
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsunb
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsdeuxb
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordstroisb
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics 
  \lyricsto "sopranos" \altoWordsquatreb

  \new Staff = "men"
  <<
    \clef bass
    \new Voice = "tenors"
    {
      \voiceOne
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>