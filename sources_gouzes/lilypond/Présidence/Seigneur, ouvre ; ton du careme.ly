\version "2.24.0"

ss = { \hideNotes bes\breve*1/8 \unHideNotes \allowBreak }
armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }


\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "president" 
  { \armure \relative c'' { 
    \cadenzaOn bes4 bes2\resp a4 a g bes2 bes\fermata \bar"||"}
  }
  \new Lyrics \lyricsto "president"
  { ei -- gneur, ou -- vre mes lè -- vres_! }
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          bes\breve*1/8 \ss \ss \ss a2 a4 a bes2 bes\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g\breve*1/8 \ss \ss \ss fis2 fis4 fis g2 g
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Et ma bouche publie -- ra ta lou -- an -- ge_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d\breve*1/8 \ss \ss \ss d2 d4 d d2 d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*1/8 \ss \ss \ss d,2 d4 d g2 g\fermata
        } 
      }
   >>
>>