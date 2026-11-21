\version "2.24.0"
\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes b4 \unHideNotes \allowBreak }
armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "president" 
  { \armure \relative c'' { 
    \cadenzaOn g2 g4 fis e g2 g\fermata \bar"||"}
  }
  \new Lyrics \lyricsto "president"
  { Dieu, viens à mon ai -- de_! }
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          b8 b4.\fermata\resp b8 c [c] c [c] b2\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g8 g4. g8 g [g] fis [fis] g2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sei -- gneur, viens vite à mon se -- cours_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 d4. d8 e [e] d [d] d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 g4.\fermata\resp g8 c,8 [c] d [d] g2\fermata\fermata
        } 
      }
   >>
>>

\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "president" 
  { \armure \relative c'' { 
    \cadenzaOn g\breve*1/8 \ss \ss \ss \ss \ss \ss \ss fis4 e g2
    g4 g a2 a4 a g2\fermata \bar"||"}
  }
  \new Lyrics \lyricsto "president"
  { Gloire au Père, et au Fils, et au Saint_- Es -- prit, 
    \gauche main -- te -- nant et tou -- jours, }
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          b\breve*1/8 \ss \ss \ss c8 [c c] b4\resp b8 [c] b4 (a) g2\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g\breve*1/8 s s s g8 [g fis] g4 g8 [g] g4 (fis) d2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     dans les siècles des siè -- cles. A -- men_! Al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d\breve*1/8 s s s e8 [e d] d4 d8 [e] d4 (c) b2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*1/8 s s s c,8 [c d] g4\resp g8 [g] g4 (d) <g, g'>2\fermata
        } 
      }
   >>
>>