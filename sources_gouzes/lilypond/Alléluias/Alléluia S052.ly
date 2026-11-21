\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff 
<<
  \new Lyrics = "sopranos" \with {\override VerticalAxisGroup.staff-affinity = #DOWN }
  \new Staff = "women" <<
    \new Voice = "sopranos" {
      \voiceOne \relative c'{ 
        \clef "treble" \key c \major \time 2/2 \tempo 2 = 110
        \partial4 e4 a (b) c (d) b2 \breathe a4 g a2 (b) e,2. \breathe
        e4 a (b) c (d) b2 \breathe a4 g a2 (b) a1
        \bar "|."
      }\cadenzaOn \transpose g a \tonIIef \cadenzaOff
    }
    \new Voice = "altos" {
      \voiceTwo \relative c'{
        \partial4 r4 r2 r4 e b (c) d (e) c c d d c2. e4 e2. fis4 g2 fis4 e d (fis g fis) e1
      }   
    }
  >>
  \new Lyrics = "altos"
  \new Lyrics = "tenors" \with {\override VerticalAxisGroup.staff-affinity = #DOWN }
  \new Staff = "men" <<
    \clef bass
    \new Voice = "tenors" {
      \voiceOne \relative c'{ 
        \clef "bass" \key c \major
        \partial4 s4 s1 s1 s1 s2. r4 c1 d2 d4 (b) b d d b c1
      }\cadenzaOn \transpose g a \tonIIeh \cadenzaOff
    }
    \new Voice = "basses" {
      \voiceTwo \relative c {
        d4\rest d4\rest e a (fis) g (a) b (c) \breathe a a g2 a2. \breathe
        e4 a,1 b4 (c) d (e fis) \breathe d g g a1
      }   
    }
  >>
  \new Lyrics = "basses"
  \context Lyrics = "sopranos" \lyricsto "sopranos" 
  { %\set associatedVoice = #"soprano"
    Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
  }
  \context Lyrics = "altos" \lyricsto "altos" 
  { %\set associatedVoice = #"soprano"
    Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
  }
  \context Lyrics = "tenors" \lyricsto "tenors"     
  { %\set associatedVoice = #"soprano"
    Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
  }
  \context Lyrics = "basses" \lyricsto "basses"     
  { %\set associatedVoice = #"soprano"
    Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
  }

>>