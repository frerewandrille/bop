\version "2.24.0"
\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes4 \unHideNotes \allowBreak }
armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }


\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "president" 
  { \armure \relative c'' { 
    \cadenzaOn bes2\fermata\resp a4^> a8 [g] bes2 bes\fermata \bar"||"}
  }
  \new Lyrics \lyricsto "president"
  { ieu, viens à mon ai -- de_! }
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          bes8 bes4.\fermata\resp bes8 bes-> [bes] a4 a bes2\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g8 g4. g8 g [g] fis4 fis g2
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
          d8 d4. d8 d [d] d4 d d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 g4.\fermata\resp g8 g-> [g] d4 d g2\fermata
        } 
      }
   >>
>>

\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "president" 
  { \armure \relative c'' { 
    \cadenzaOn bes\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss g8 a2\resp
    a \breve*1/8 \ss g8 bes2\fermata \bar"||"}
  }
  \new Lyrics \lyricsto "president"
  { Gloire au Père, et au Fils, et au Saint_- Es -- prit, 
  \gauche maintenant et tou -- jours, }
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          bes\breve*1/8 \ss \ss \ss \ss a2 bes\resp g4 (a2) bes2\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g\breve*1/8 s s s s g4 (fis) g2 e4 (f fis) g2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     dans les siè -- cles des siè -- cles. A -- men_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d\breve*1/8 s s s s ees4 (d) d2 c2 (d4) d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*1/8 s s s s c,4 (d) g2 \resp c,4 (f d) <g, g'>2\fermata
        } 
      }
   >>
>>