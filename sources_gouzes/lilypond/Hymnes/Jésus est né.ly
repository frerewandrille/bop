\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   top-margin = 10
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   print-page-number = ##f
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 15)
% 
% \header {
%   title = \markup \center-column { "Jésus est né à Bethléhem" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
% }
% 
% \markup{ \vspace #1 }

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
  } 
}

global = {
  \key d \major
  \time 4/4
}
resp = { \breathe\allowBreak }

sopMusic = \relative c'' {
  \partial2. d4 cis b cis8 (b) a4 b cis d\fermata\resp
  d d a a8 (g) fis (g) a4 g fis\fermata\resp
  fis b b a8 (b) cis4 d8 (cis) b4 a\fermata\resp
  d cis b a b8 (a) g (fis) e4 d\fermata
  \bar "|."
}

altoMusic = \relative c'' {
  \partial2. a4 a8 (g) fis4 gis fis8 (e) d4 e fis
  fis fis fis e d d d d
  d d g8 (fis) e (d) cis4 b8 (fis') g4 fis
  b b8 (a) g4 fis4. 
  \override BalloonText.annotation-balloon = ##f
  <e \balloonText #'(-1.5 . -2)\markup { "" } >8
  d4.
  \override BalloonText.annotation-balloon = ##f
  <cis \balloonText #'(-1.5 . -2)\markup { "" } >8 a4
}

tenorMusic = \relative c' {
  \partial2. fis4 e4. 
  \override BalloonText.annotation-balloon = ##f
  <d \balloonText #'(-1.5 . 2)\markup { "" } >8
  cis4 d8 (cis) b (a) g4 a
  b b8 (cis) d4 cis8 (b) a4 c4.
  \override BalloonText.annotation-balloon = ##f
  <b \balloonText #'(-1.5 . 2)\markup { "" } >8   a4
  d8 (c) b (a) g4 g a8 (g) fis (d) d'4 d
  fis fis8 (cis) d4 cis b8 (cis) d (b) e, (a) fis4
}

bassMusic = \relative c {
  \partial2. d4 a' b eis, fis g8 (fis) e?4 d\fermata\resp
  b8 (cis) d (e) fis (g) a (b) c4 fis, g d\fermata\resp
  b'8 (a) g (fis) e (d) cis (b) a4 b4.
  \override BalloonText.annotation-balloon = ##f
  <cis \balloonText #'(-1 . 4)\markup { "" } >8 d4\fermata\resp
  d8 (e) fis4.
  \override BalloonText.annotation-balloon = ##f
  <e \balloonText #'(-1 . 4)\markup { "" } >4
  \override BalloonText.annotation-balloon = ##f
  <d \balloonText #'(-1 . 4)\markup { "" } >
  \override BalloonText.annotation-balloon = ##f
  <cis \balloonText #'(-1 . 4)\markup { "" } >8
  b16 (cis d8) a' (a,) d4\fermata
}

altoWordsun = \lyricmode {
  \set stanza = #"1. "\set shortVocalName = "1."
  Jé -- sus est né à Beth -- lé -- hem.
  Ré -- jou -- is_- toi, Jé -- ru -- sa -- lem_:
  Voi -- ci ton Roi qui vient vers toi.
  Qu’il soit bé -- ni et glo -- ri -- fié_!
}

altoWordsdeux = \lyricmode {
  \set stanza = #"2. "\set shortVocalName = "2."
  Dans le si -- len -- ce de la nuit,
  il est ve -- nu d’au -- près de Dieu
  pour nous don -- ner la paix des cieux,
  ou -- vrir nos cœurs à la vraie joie.
}

altoWordstrois = \lyricmode {
  \set stanza = #"3. "\set shortVocalName = "3."
  Le Sau -- veur est né au -- jour --\apostrophe d’hui,
  et les ber -- gers s’en vont à lui.
  Dans l’humble é -- table ils sont en -- trés
  a -- vec leur seu -- le pau -- vre -- té.
}

altoWordsquatre = \lyricmode {
  \set stanza = #"4. "\set shortVocalName = "4."
  É -- veil -- le_- toi, ô toi qui dors_!
  Re -- lè -- ve_- toi d’en -- tre les morts.
  Al -- lons vers lui, chan -- tons No -- ël
  et cé -- lé -- brons l’Em -- ma -- nu -- el.
}

\score {
  \new ChoirStaff <<
    \set ChoirStaff.beamExceptions = #'()
    \set ChoirStaff.baseMoment = #(ly:make-moment 1/4)
    \set ChoirStaff.beatStructure = #'(1 1 1 1)
    \new Staff = "women" <<
      \new Voice = "sopranos" {
        \voiceOne
        << \revert Staff.TimeSignature.style \global \sopMusic >>
      }
      \new Voice = "altos" %\with { \consists "Balloon_engraver" }
      {
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
      \new Voice = "tenors" %\with { \consists "Balloon_engraver" } 
      {
        \voiceOne
        << \revert Staff.TimeSignature.style \global \tenorMusic >>
      }
      \new Voice = "basses"  %\with { \consists "Balloon_engraver" } 
      {
        \voiceTwo
        << \global \bassMusic >>
      }
    >>
  >>
}