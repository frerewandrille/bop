\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key g \major \time 3/4 }

\transpose b a
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo 2. = 72
          b8 [a b] d [e d] b ([a g]) b4.
          g8 [e d] e [g a] g ([a b]) b2.\fermata
          \bar"|."
        } \transpose c d \tonVIhf %sans ton dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g8 [fis g] b [c b] g ([fis e]) g4.
          e8 [c b] c [e fis] e([fis g]) g2.
        }    
      }
   >>
   \new Lyrics \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia.
   }
  \new Staff = "hommes"\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e4. d fis e b a c d2.
        } 
      }
      \new Voice = "basse"
      {  \relative c'
        { 
          r4. \voiceTwo b8 [a b] d [e d] b ([a g]) b4.
          g8 [(e) d] e  ([g a]) <g b>2.\fermata
        } \transpose c d \tonVIhh
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" }  \lyricsto "ténor"
   {
      Al -- lé -- lu -- ia, al -- lé -- lu -- ia.
   }
    \new Lyrics \lyricsto "basse"
   {
      Al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia.
   }
>>