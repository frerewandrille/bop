\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" 'landscape)
%   top-margin = 10
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   print-page-number = ##f
%   system-system-spacing.basic-distance = #18
%   tagline = "Ne pas emporter svp"
% 
% }
% 
% #(set-global-staff-size 15)
% 
% \header {
%   title = \markup \center-column { "Tu es béni, Dieu, notre Père" }
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
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key c \major
  \time 4/4
}

sopMusic = \relative c' {
  \partial4 e4 a b c b a b8 a gis4 e\fermata
  \oneVoice r4 \voiceOne g g f e a a gis a2.\bar ":|."
  b4 c d e e d4. c8 c4\fermata \breathe
  e d c b a8 b c4 b a\fermata\bar "|."
}

altoMusic = \relative c' {
  \partial4 c8 d e4 e e e8 d c4 f e b s e e d d8 c c4 f e e2.
  e4 e g g g a
  \override BalloonText.annotation-balloon = ##f
  <g \balloonText #'(1.5 . -2)\markup { "" } >
  g g8 a b4 e, f8 [e] e d e4 e8 d cis4
}

tenorMusic = \relative c' {
  \partial4 a8 b c4 b a gis a d8 c b4 gis s b c g g a b8 c d4 c2.
  gis4 a b c c c
  \override BalloonText.annotation-balloon = ##f
  <b \balloonText #'(1.5 . 2)\markup { "" } >
  e c gis a a8 gis a4 a gis e
}

bassMusic = \relative c {
  \partial4 a4 a' gis a e f8 e d4 e <e, e'>\fermata
  \oneVoice r4 \voiceTwo e' a, b c f8 e d4 e a,2.
  e'4 a g!8 f e d c4 f g c,\fermata\breathe
  c b a d8 e f4 e8 d e4 a,\fermata
}

altoWordsun = \lyricmode {
  \set stanza = #"1. "\set shortVocalName = "1."
  Tu es bé -- ni, Dieu, no -- tre \skip4 Pè -- re,
  Dieu d’Is -- ra -- ël vi -- vant et vrai.
}

altoWordsdeux = \lyricmode {
  Sur les che -- mins de ton al -- \skip4 lian -- ce,
  comme un ber -- ger, tu nous con -- duis.
  \set stanza = #" 1-4."
  \override Lyrics.LyricText.font-series = #'bold
  Gloire et lou -- ange à toi, Sei -- gneur_!
  Gloire et lou -- ange à ton \skip4 saint Nom_!
}

altoWordstrois = \lyricmode {
  \set stanza = #"2. "\set shortVocalName = "2."
  Tu es bé -- ni, ô Fils u -- \skip4 ni -- que,
  Ver -- be fait chair en no -- tre nuit.
}

altoWordsquatre = \lyricmode {
  En no -- tre mort, tu res -- sus -- \skip4 ci -- tes.
  Viens nous don -- ner en -- cor ta vie_!
}

altoWordscinq = \lyricmode {
  \set stanza = #"3. "\set shortVocalName = "3."
  Tu es bé -- ni, toi qui ras -- \skip4 sem -- bles
  ceux qui te cherchent en vé -- ri -- té.
}

altoWordssix = \lyricmode {
  Tu les nour -- ris de ta Pa -- \skip4 ro -- le
  et les in -- vites à ton re -- pas.
}

altoWordssept = \lyricmode {
  \set stanza = #"4. "\set shortVocalName = "4."
  Tu es bé -- ni, Feu du Roy -- \skip4 au -- me,
  flam -- me jail -- lie d’au -- près de Dieu.
}

altoWordshuit = \lyricmode {
  Bé -- nis le pain, bé -- nis la \skip4 cou -- pe
  que ton a -- mour con -- su -- me -- ra.
}

\markup{ \vspace #1 }

\score {
  \new ChoirStaff <<
    \new Staff = "women" << \revert Staff.TimeSignature.style 
      \new Voice = "sopranos" {
        \voiceOne
        << \global \sopMusic >>
      }
      \new Voice = "altos" \with { \consists "Balloon_engraver" } {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>

    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
    \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics 
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
    \lyricsto "sopranos" \altoWordsquatre
    \new Lyrics \lyricsto "sopranos" \altoWordscinq
    \new Lyrics 
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
    \lyricsto "sopranos" \altoWordssix
    \new Lyrics \lyricsto "sopranos" \altoWordssept
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "sopranos" \altoWordshuit

    \new Staff = "men" << \revert Staff.TimeSignature.style 
      \clef bass
      \new Voice = "tenors" \with { \consists "Balloon_engraver" } {
        \voiceOne
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo
        << \global \bassMusic >>
      }
    >>
  >>
}