\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   %system-system-spacing.basic-distance = #17
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 15)
% 
% \header {
%   title = \markup \center-column { "Mystère du Calvaire" }
%   subtitle = " "
%   poet = ""
%   composer = ""
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
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = { \key b \minor \time 4/4 }
resp = { \breathe }

sopMusic = \relative c' {
  \partial4 fis4 b a g fis e2 fis4 \resp
  cis' d d cis8 (b) cis4 b2.\allowBreak\break
  fis4 b a g fis e2 fis4 \resp
  cis' d d cis8 (b) cis4 b2.\allowBreak
  d4 cis8 (b) a4 b cis d2 d4\resp
  a b a g g fis2.\allowBreak
  d'4 cis8 (d) e4 d cis b2 cis4\resp
  fis, g fis e a fis2.
  \bar"|."
}

altoMusic = \relative c' {
  \partial4 d4 d d d8 (e) e (d) d4 (cis) d
  e d8 (e) fis4 fis4. 
  \override BalloonText.annotation-balloon = ##f 
  <e \balloonText #'(-1 . -3)\markup { "" } >8
  d2.
  d4 d d d8 (e) e (d) d4 (cis) d
  e d8 (e) fis4 fis4. 
  \override BalloonText.annotation-balloon = ##f 
  <e \balloonText #'(-1 . -3)\markup { "" } >8
  d2.
  fis4 e8 (g) fis (e) d4 g g (fis8 e) fis4
  fis g fis fis e dis2.
  e4 e e fis8 (gis) a4 a (gis) a 
  d,8 (cis) b (cis) d4 d8 (b) cis4 d2.
}

tenorMusic = \relative c' {
  \partial4 a4 g a b8 (a) a4 b (a) a 
  ais fis b b ais b2.
  a4 g a b8 (a) a4 b (a) a 
  ais fis b b ais b2.
  b8 (a!) g (b) d (cis) b (a) g (a) b4 (a8 g) a4
  d d c b b b2.
  b4 a b a8 (b) cis (a) fis'4 e e
  a, g a a a a2.
}

bassMusic = \relative c {
  \partial4 d4 g fis b,8 (cis) d4 g, (a) d\resp 
  cis b8 (cis) d (e) fis4 fis, b2.
  d4 g fis b,8 (cis) d4 g, (a) d\resp 
  cis b8 (cis) d (e) fis4 fis, b2.
  b4 e fis g8 (fis) e4 d2 d4\resp
  d g8 (fis) e (dis) e (fis) g (a) b2.
  gis4 a gis fis e dis e a,\resp
  d e fis8 (g) a4 a, d2.
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. "\set shortVocalName = "1." 
  Mys -- tè -- re du Cal -- vai -- re, scan -- da -- le de la Croix_:
  Le Maî -- tre de la ter -- re, es -- cla -- ve sur ce bois_!
  Vic -- ti -- me dé -- ri -- soi -- re. Toi seul es le Sau -- veur,
  Toi seul, le roi de gloi -- re, au rang des mal -- fai -- teurs.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "\set shortVocalName = "2." 
  Tu sais com -- bien les hom -- mes i -- gno -- rent ce qu’ils font.
  Tu n’as ju -- gé per -- son -- ne, tu don -- nes ton par -- don.
  Par -- tout des pau -- vres pleu -- rent, par -- tout on fait souf -- frir,
  Pi -- tié pour ceux qui meu -- rent et ceux qui font mou -- rir.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. "\set shortVocalName = "3." 
  A -- fin que vien -- ne l’Heu -- re pro -- mise à tou -- te chair,
  Sei -- gneur, ta Croix de -- meu -- re dres -- sée sur l’u -- ni -- vers_:
  Som -- met de no -- tre ter -- re, où meurt la mort vain -- cue,
  Où Dieu se mon -- tre Pè -- re en nous don -- nant Jé -- sus.
}

\score {
  \new ChoirStaff <<
    \set ChoirStaff.beamExceptions = #'()
    \set ChoirStaff.baseMoment = #(ly:make-moment 1/4)
    \set ChoirStaff.beatStructure = #'(1 1 1 1)
    \new Staff = "women" 
    <<
      \new Voice = "sopranos" {
        \voiceOne
        << \global \sopMusic >>
      }
      \new Voice = "altos" %\with { \consists "Balloon_engraver" }
      {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "sopranos" \altoWordstrois
    
    \new Staff = "men" 
    <<
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