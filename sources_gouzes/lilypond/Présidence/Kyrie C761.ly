\version "2.24.0"

ss = { \hideNotes b4 \unHideNotes \allowBreak }
armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "president" 
  { \armure \relative c'' { 
    \cadenzaOn g\breve*1/8 \ss \ss fis8 [e] g2 \fermata \bar"||"}
  }
  \new Lyrics \lyricsto "president"
  { En paix, prions le Sei -- gneur }
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          g4. g8 g [fis] a4. a8 g2\fermata\resp
          b4. b8 a [b] c2 (b4) a g2\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4. d8 d [d] fis4. 8 d2 g4. 8 8 [8] 2 (fis4) 4 d2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ky -- ri -- e e -- le -- i -- son,
     Ky -- ri -- e e -- le -- i -- son.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4. 8 8 [a] c4. 8 b2 d4. 8 c [d] e2 (d4) c b2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4. 8 8 [d] d4. 8 g2\fermata\resp
          g4. 8 8 [8] c,2 (d4) 4 g2\fermata
        } 
      }
   >>
>>