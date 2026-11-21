\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose e d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Libre" %2 = 52
          e8 [fis] a [fis a] b2\resp \tempo 4 = 88 cis8 
          [cis] cis [cis] cis4. (d8 cis [b] cis [d]) cis4.\resp
          cis8 \tuplet 3/2 {cis ([b cis])} b [a] b [cis] cis ([d]) 
          cis2\fermata
          \bar"|."
        } \tonVIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e8 [fis] a [fis a] gis2 a8 [a] a [a] a2~ (a8 [fis] a4) a4.
          a8 \scaleDurations 2/3 {a ([fis a]) } fis [fis] fis [fis] gis4 a2          
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Ac -- cla -- mez le Sei -- gneur_! 
      Que tou -- te la ter -- re tres -- sail -- le 
      de -- vant sa gloi -- re_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e8 [fis] a [fis a] e'2 e8 [e] e [e] 
          e4. (fis8 e [d] e [fis]) e4.
          e8 \tuplet 3/2 {e ([d e]) } d [cis] d [d] e4 e2
          
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e8 [fis] a [fis a] e2\resp
          a8 [a] a [a] a2.. (fis8) a4.\resp
          a8 a4 a8 [a] fis [fis] e4 a2\fermata         
        } \tonVIIdh
      }
   >>
>>