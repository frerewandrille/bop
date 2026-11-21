\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

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
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

global = {
  \key c \major
  \time 4/4
}

sopMusic = \relative c'' {
  \bar "|." 
}

altoMusic = \relative c'' {
}

tenorMusic = \relative c' {
}

bassMusic = \relative c {
}

altoWordsun = \lyricmode { 
}

altoWordsdeux = \lyricmode { 
}

\transpose c bes,
\new ChoirStaff 
<<
  \new Staff = "women" \with { \consists "Merge_rests_engraver" }
  %\with {\remove Time_signature_engraver }
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
  
  \new Staff = "men" \with { \consists "Merge_rests_engraver" }
  %\with {\remove Time_signature_engraver }
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
