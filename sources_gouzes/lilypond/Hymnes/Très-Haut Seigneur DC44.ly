\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" 'landscape)
%   top-margin = 8
%   bottom-margin = 8
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter ni plier svp"
%   print-page-number = ##f
% }
% 
% #(set-global-staff-size 15)
% 
% \header {
%   title = \markup \center-column { "Très-Haut Seigneur" }
%   subtitle = ""
%   poet = ""
%   composer = ""
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
    \override InstrumentName.X-offset = 1
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}
\layout {
  \context {
    \Lyrics
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}
global = { \key f \major \time 2/2 }

resp = { \breathe }

sopMusic = \relative c' {
  f2 f4 g \allowBreak a2 g4 f bes2 a4 g \allowBreak a2 a 
  g a4 bes \allowBreak a2 g4 f g (bes) a (g) \allowBreak f2 f\bar"|."
  \slurDashed 
  c' c4 (d) \allowBreak bes1 c4 (bes) a (g) \allowBreak a2 a 
  g4 f bes g \allowBreak f2 bes4 (a) g (f) bes g \allowBreak f2 f\bar"||"
  c' c4 d \allowBreak bes2 c4 d ees (d) c a \allowBreak bes2 g 
  f g4 a \allowBreak bes2 a g4 f bes g \allowBreak f2 f
  \bar"|."\mark"D.C."
}

altoMusic = \relative c' {
  c2 c4 e f2 e4 f f2 f4 e f2 f 
  e f4 f f2 e4 f e (f) f (e) c2 c
  \slurDashed\tieDashed
  a' a4~ a g1 g4~ g f (e) f2 f 
  e4 d d e f2 f4~ f e (d) d e c2 c
  a' a4 f g2 g4 bes c (bes) g f f2 e!
  c e4 f f2 f e4 d d e c2 c
}

tenorMusic = \relative c' {
  a2 a4 c c2 c4 c d2 c4 c c2 c
  c c4 d c2 c4 a c (d) c2 a2 a
  \slurDashed\tieDashed
  f' f4~ f d1 e4~ e c~ c c2 c
  c4 a bes c c2 d4 (c) c (a) bes c a2 a
  f' f4 f d2 ees4 f g (f) ees c d2 c
  a c4 c d2 c c4 a bes c a2 a
}

bassMusic = \relative c {
  f2 f4 c f2 c4 f bes,2 f'4 c f2 f
  c f4 bes, f'2 c4 d c (bes) f' (c) f,2 f
  \slurDashed\tieDashed
  f' f4 (d) g1 c,4~ c f (c) f2 f 
  c4 d g, c f2 bes,4 (f') c (d) g, c f2 f
  f f4 d g2 ees4 d c (d) ees f bes,2 c
  f c4 f bes,2 f' c4 d g, c f,2 f
}

altoWordsun = \lyricmode { 
  Très_- Haut Seig -- neur, Tri -- ni -- té bien -- heu -- reu -- se,
  nous t’a -- do -- rons, nous te ren -- dons grâ -- ces.
  \set stanza = #"1. "
  \set ignoreMelismata = ##t
  Tri -- \set shortVocalName = "1."  ni __ -- \skip 4 té glo __ -- \skip 4 ri __ -- \skip 4 eu -- se, 
  viens __ \skip 4 en nos cœurs,
  ô __  \skip 4 vie __  \skip 4 bien -- heu -- reu -- se.
  \set shortVocalName = "" \set stanza = #"2. "
  Père \set shortVocalName = "2." in -- cré -- é, tu con -- tiens __ \skip 4 tou -- tes cho -- ses
  par Jé -- sus Christ, l’I -- ma -- ge de ta gloi -- re.
}

altoWordsdeux = \lyricmode { 
  \repeat unfold 21 { \skip 4 }
  \set stanza = #"3. "
  \set ignoreMelismata = ##t
  Verbe \set shortVocalName = "3." é -- ter -- nel, splen __ -- \skip 4 deur du Pè -- re,
  sour -- ce du par -- don, tu ré -- pands tou -- te lu -- miè -- re.
  \set shortVocalName = "" \set stanza = #"4. "
  Ô \set shortVocalName = "4." Saint Es -- prit, toi le sceau de l’Al -- li -- an -- ce,
  souf -- fle d’A -- mour, ré -- vè -- le ta puis -- san -- ce.
}

altoWordstrois = \lyricmode { 
  \repeat unfold 39 { \skip 4 }
  \set stanza = #"5. "
  \set ignoreMelismata = ##t
  Que \set shortVocalName = "5." sur nos lè -- vres s’é -- lè -- ve la lou -- an -- ge
  et que nos cœurs s’é -- veillent à ta pré -- sen -- ce.
}


\new ChoirStaff <<
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
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }\lyricsto "sopranos" \altoWordsun
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }\lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }\lyricsto "sopranos" \altoWordstrois

\new Staff = "men" 
  <<
    \clef bass
    \new Voice = "tenors" %\with { \consists "Balloon_engraver" }
    {
      \voiceOne
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>