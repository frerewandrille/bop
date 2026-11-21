\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Léger" 2. = 69
          a2 b4 c-> b a g2 a4 b2.\fermata\resp
          b2^\markup{\italic subito \dynamic pp } a4 g2. (a^\markup\italic"rall.") a\fermata
          \bar"|."
        } \tonVIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          fis2 g4 g g fis e2 e4 fis2. fis2 fis4 e2. (fis) fis
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
     \lyricsto "soprano"
   {
      Un can -- ti -- que pour moi, Sei -- gneur, ta Pa -- ro -- le_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d4 e d d b2 e4 dis2. dis!2 dis4 b2. (d) d
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 g4 c,-> g' d e2 c4 b2.\fermata\resp
          b2 b4 e2. (d) d\fermata
        } \tonVIIah
      }
   >>
>>