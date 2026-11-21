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
    \override InstrumentName.X-offset = 1
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
  
  \bar "|."
}
altoMusic = \relative c'' {
  
}
tenorMusic = \relative c' {
  
}
bassMusic = \relative c { \autoBeamOff
  
                          \fermata
}

altoWordsun = \lyricmode {  
  \set shortVocalName = \markup\right-align"1." \set stanza = #"1."

}
altoWordsdeux = \lyricmode {  
  \set shortVocalName = \markup\right-align"2." \set stanza = #"2." 

}
altoWordstrois = \lyricmode {  
  \set shortVocalName = \markup\right-align"3." \set stanza = #"3."

}
altoWordsquatre = \lyricmode {  
  \set shortVocalName = \markup\right-align"4." \set stanza = #"4."

}
altoWordscinq = \lyricmode {  
  \set shortVocalName = \markup\right-align"5." \set stanza = #"5."
  
}
altoWordssix = \lyricmode {  
  \set shortVocalName = \markup\right-align"6." \set stanza = #"6."
  
}

\new ChoirStaff 
<<
  \new Staff = "women" \with { \consists "Merge_rests_engraver" }
  <<
    \new Voice = "sopranos" {
      \voiceOne
      << \global \cadenzaOn \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo
      << \global \cadenzaOn \altoMusic >>
    }
  >>
  
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordssix
  
  \new Staff = "men" \with { \consists "Merge_rests_engraver" }
  <<
    \clef bass
    \new Voice = "ténors" \with { \consists "Balloon_engraver" } {
      \voiceOne
      << \global \cadenzaOn \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo 
      << \global \cadenzaOn \bassMusic >>
    }
  >>
>>