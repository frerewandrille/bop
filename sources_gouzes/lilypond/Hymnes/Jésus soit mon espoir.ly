\version "2.24.0"
\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 7
%   bottom-margin = 4
%   left-margin = 10
%   right-margin = 10
%   print-page-number = ##f
%   tagline = "Ne pas plier ni emporter, svp"
% }
% 
% #(set-global-staff-size 17)
% 
% \header {
%   title = \markup \center-column { "Jésus soit mon espoir" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
% }

\layout {
  indent = #0
  \context {
    \Score \remove "Bar_number_engraver"
  }
  \context {
    \Lyrics
    \override LyricText.font-size = #2
    \override LyricSpace.minimum-distance = #1
    \override LyricText.X-offset = #centrer
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key f \major
  \time 2/2
}

resp = { \breathe\allowBreak }

sopMusic = \relative c'' {
  a2 a4 a d c bes2 a c4 bes a a g2 a \resp
  a2 a4 a bes g f2 g a4 d, g f e2 d \breathe
  f e4 d f g a2 c b4 c d b a2 \breathe
  d, a'4 a g f e a g f e e d1 \bar "|."
}

altoMusic = \relative c' {
  f2 e4 f a a g2 f e4 f f f e2 e
  f f4 f g8 [(f)] f (e) d2 e e4 d d d d (c) d2
  d c4 d d d c2 e e4 e f e e2 
  d f4 f e d c f e d d c d1
}

tenorMusic = \relative c' {
  d2 c4 d f f d2 d e4 d c c c2 c 
  d c4 c d c a2 c c4 a bes a a2 a
  a a4 a a g e2 a gis4 a a gis a2
  a d4 c c a a c c a a a a1
}

bassMusic = \relative c {
  d2 a4 d d f g2 d a4 bes f' f c2 a \breathe
  d f4 f bes, c d2 c a4 d g, d' a2 d \breathe
  d a4 d d bes a2 a e'4 a, d e a,2 \breathe
  d d4 f c d a f c' d a a d1
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "  \set shortVocalName = "1."

  Jé -- sus soit mon es -- poir, Jé -- sus soit ma li -- es -- se.
  Jé -- sus soit mon sa -- voir, Jé -- sus soit ma ri -- ches -- se.
  Jé -- sus soit ma dé -- fense et Jé -- sus soit mon Roi.
  Jé -- sus soit mon bon -- heur et Jé -- sus soit ma loi.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. "   \set shortVocalName = "2."

  Jé -- sus soit mon dé -- sir, Jé -- sus soit mon en -- vi -- e.
  Jé -- sus soit en mon goût et de -- dans mon ou -- ï -- e.
  Jé -- sus vi -- ve tou -- jours dans mon en -- ten -- de -- ment.
  Jé -- sus soit mon dé -- sir et mon con -- ten -- te -- ment.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "  \set shortVocalName = "3."

  Jé -- sus soit en mes yeux, Jé -- sus soit en ma bou -- che.
  Jé -- sus soit en mes mains et en ce que je tou -- che.
  Jé -- sus soit mon sen -- tier, Jé -- sus soit en mes pas.
  Jé -- sus me soit Jé -- sus le jour de mon tré -- pas.
}

\markup{ \vspace #-0.75 }

\score {
  \new ChoirStaff <<
    \new Staff = "women" <<
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
    
    \new Staff = "men" <<
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