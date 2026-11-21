\version "2.24.0"

ss = { \hideNotes bes\breve*1/8 \unHideNotes \allowBreak }

<<
  \new Staff \with {\remove Time_signature_engraver }
  \new Voice = "soprano"
  { \voiceOne \relative c''
    { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "" 2 = 52
      bes4 bes2 \breathe a\breve*1/8 g8 bes2 bes\fermata\bar "|"
    }
  }

  \new Lyrics \lyricsto "soprano"
  {
    Sei -- gneur, ouvre mes lè -- vres_!
  }
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "" 2 = 52
          bes\breve*1/8 \ss \ss \ss a4 a8 [a] bes2 bes\fermata\bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g\breve*1/8 \ss \ss \ss fis4 fis8 [fis] g2 g
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Et ma bouche publie -ra ta lou -- an -- ge_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \minor \time 3/4 \cadenzaOn
          d\breve*1/8 \ss \ss \ss d4 d8 [d] d2 d          
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*1/8 \ss \ss \ss d,4 d8 [d] g2 g\fermata
       
        }
      }
   >>
>>