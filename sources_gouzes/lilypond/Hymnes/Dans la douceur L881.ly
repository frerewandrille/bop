\version "2.24.0"

\include "vowel-set.ly"


% \paper {
%   #(set-paper-size "a5" )
%   %system-system-spacing.basic-distance = #17
%   top-margin = 8
%   bottom-margin = 7
%   left-margin = 10
%   right-margin = 10
%   print-page-number = ##f
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% #(set-global-staff-size 14)
% 
% \header {
%   title = \markup \center-column { "Dans la douceur de ton amour" }
%   subtitle = ""
%   poet = ""
%   composer =  ""
% } 
% \markup{ \vspace #1 }
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
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

resp = { \breathe\allowBreak }

global = {
  \key c \major
  \time 4/4
}

sopMusic = \relative c'' {
  \partial 4 c4 b a g f8 (e) a4 a g\fermata\resp
  c4 b a g f8 (e) a4 a g\fermata\resp
  g a b c8 (d) e4 d (c2 b4) c2\fermata \oneVoice r4 \bar ":|." \voiceOne
  c4 c d c8 (b) a (b) c4 c b\fermata\resp
  b c d c8 (b) a (b) c (e) d4 b\resp
  e e e d c c b c\fermata\resp
  b c b a g g fis g\fermata\resp
  e' d c b\fermata\resp e f8 (e) d4 e c c b c\fermata\resp
  c c c d c c2. b4 c1\fermata
  \bar "|." 
}

altoMusic = \relative c'' {
  \partial 4 g4 g e e d8 (c) c4 f e e e8 (d) c (d) e (d) c (b) c (d) d4 e
  e e8 (a) g (f) e (d) c4 d2 (e4 f) e2 s4
  e f f e4. 
  \override BalloonText.annotation-balloon = ##f 
  <e \balloonText #'(-1 . -3)\markup { "" } >8
  d (e) fis4 g g g f! e f g a g
  g g a a f e d e f e d8 (g) e4 e e d d
  c d8 (e16 f) e8 (fis) gis4 a a gis8 (a) e4 e ees8 (d) d4 e
  e f f f e d2 
  \override BalloonText.annotation-balloon = ##f 
  <d \balloonText #'(2 . -2)\markup { "" } >
  e1
}

tenorMusic = \relative c' {
  \partial 4 e4 d c b bes a8 (g) a (b!) c4
  e,8 (f) g4 a8 (b) c4 f,8(g) a (c) b (a) b4
  c c8 (f) e (d) c (g) bes4 a2 (g) g s4
  g a a a8 (b) c (b) a4 d d d g, g g d' c8 (b) a4 d
  c c c d d g, g g d' g,8 (a) b4 c b c8 (b) a4 b g8 (a) b4 c8 (a) e'4
  a, d8 (c) b (a) b4 a a g g bes a8 (b!) c4 g g a2 
  \override BalloonText.annotation-balloon = ##f 
  <g \balloonText #'(2 . 3)\markup { "" } >
  g1
}

bassMusic = \relative c {
  \partial 4 c4 g' a e g f f, c'\fermata\resp
  a e' f c8 (b) a (g) f4 f' e\fermata\resp 
  c f g a8 (b,) c4 <f, f'> (<fis fis'> <g g'>2) c\fermata\oneVoice r4 \voiceTwo
  c4 f8 (e) d4 a a'8 (g) fis (e) d4 g\fermata\resp
  g8 (f) e (d) c (b) c4 d e fis g\resp
  c, c'8 (b) a (g) f (g) a (f) g4 g, c\fermata\resp
  d e8 (fis) g (e) c (d) e (c) a4 d g,\fermata\resp
  c g' a e\fermata\resp 
  cis d8 (e) f4 gis, a <fis fis'> <g g'> c\fermata\resp 
  c f8 (g) a4 b, c <fis, fis'>2 <g g'> c1\fermata
}

altoWordsun = \lyricmode {  
  Dans la dou -- ceur de son a -- mour,
  mon bien_- ai -- mé s’est en -- dor -- mi,
  ce -- lui que mon cœur ai -- me.
}

altoWordsdeux = \lyricmode {  
  N’é -- veil -- lez pas mon bien_- ai -- mé, 
  blot -- ti dans le creux du ro -- cher
  jus -- \apostrophe qu’au ma -- tin de Pâ -- ques.  
  Dans les té -- nè -- bres des en -- fers, 
  le Roi des rois, le Christ Sei -- gneur,
  vient par sa mort bri -- ser la mort
  et dé -- li -- vrer A -- dam cap -- tif.
  Jé -- sus vain -- queur, a -- mour plus fort que no -- tre mort,
  rends_- nous la vie par ton a -- mour_!
}

\transpose c bes,
\new ChoirStaff 
<<
  \new Staff = "women" %\with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne \tempo "Calme, paisible"
      \set Staff.beamExceptions = #'()
      \set Staff.baseMoment = #(ly:make-moment 1/4)
      \set Staff.beatStructure = 1,1,1,1
      << \global \sopMusic >>
    }
    \new Voice = "altos" %\with { \consists "Balloon_engraver" }
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  \new Lyrics = "altoWordsun"
  \new Lyrics = "altoWordsdeux" \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  
  \new Staff = "men" %\with {\remove Time_signature_engraver }
  <<
    \clef bass
    \new Voice = "tenors" %\with { \consists "Balloon_engraver" }
    {
      \voiceOne 
      \set Staff.beamExceptions = #'()
      \set Staff.baseMoment = #(ly:make-moment 1/4)
      \set Staff.beatStructure = 1,1,1,1
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
    \context Lyrics = "altoWordsun" \lyricsto "tenors" \altoWordsun
    \context Lyrics = "altoWordsdeux"  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "tenors" \altoWordsdeux

  >>
>>
