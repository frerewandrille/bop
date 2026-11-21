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
% #(set-global-staff-size 14)
% 
% \header {
%   title = \markup \center-column { "En toi, ô Mère du Sauveur" }
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
    \override InstrumentName.X-offset = 1
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
  } 
}

global = {
  \key g \major
  \time 4/4
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata


sopMusic = \relative c' {
  
  \fermata \bar "|."
}

altoMusic = \relative c' {
  
}

tenorMusic = \relative c' {
  
}

bassMusic = \relative c {
  
  \fermata
}

altoWordsun = \lyricmode {  
  \set shortVocalName = \markup\right-align"1." \set stanza = #"1."
  
}

altoWordsdeux = \lyricmode {  
  
  \set shortVocalName = \markup\right-align"1."
  
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = \markup\right-align"2." \set stanza = #"2." 
  
}

altoWordsquatre = \lyricmode {  
  
  \set shortVocalName = \markup\right-align"2."
  
}

altoWordscinq = \lyricmode {  
  \set shortVocalName = \markup\right-align"3." \set stanza = #"3."
  
}

altoWordssix = \lyricmode {  
  
  \set shortVocalName = \markup\right-align"3."
  
}

altoWordssept = \lyricmode {  
  \set shortVocalName = \markup\right-align"4." \set stanza = #"4."
  
}

altoWordshuit = \lyricmode {  %\set stanza = #"."
  
  \set shortVocalName = \markup\right-align"4."
  
}


\transpose d c
\new ChoirStaff 
<<
  \set ChoirStaff.beamExceptions = #'()
  \set ChoirStaff.baseMoment = #(ly:make-moment 1/4)
  \set ChoirStaff.beatStructure = #'(1 1 1 1)
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
  \new Lyrics = "altoWordsun"
  \new Lyrics = "altoWordsdeux"
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \new Lyrics = "altoWordstrois"
  \new Lyrics = "altoWordsquatre"
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \new Lyrics = "altoWordscinq"
  \new Lyrics = "altoWordssix"
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \new Lyrics = "altoWordssept"
  \new Lyrics = "altoWordshuit" 
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  
  
  \new Staff = "men" \with { \consists "Merge_rests_engraver" }
  <<
    \clef bass
    \new Voice = "ténors" \with { \consists "Balloon_engraver" } {
      \voiceOne
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo 
      << \global \bassMusic >>
    }
    \context Lyrics = "altoWordsun" \lyricsto "ténors" \altoWordsun
    \context Lyrics = "altoWordsdeux" \lyricsto "ténors" \altoWordsdeux
    \context Lyrics = "altoWordstrois" \lyricsto "ténors" \altoWordstrois
    \context Lyrics = "altoWordsquatre" \lyricsto "ténors" \altoWordsquatre
    \context Lyrics = "altoWordscinq" \lyricsto "ténors" \altoWordscinq
    \context Lyrics  = "altoWordssix" \lyricsto "ténors" \altoWordssix
    \context Lyrics = "altoWordssept" \lyricsto "ténors" \altoWordssept
    \context Lyrics = "altoWordshuit" \lyricsto "ténors" \altoWordshuit
  >>
>>