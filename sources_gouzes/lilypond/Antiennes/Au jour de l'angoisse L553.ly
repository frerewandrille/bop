\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 4/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure  \tempo "Calme" 4 = 80
          \partial4 g4^\< a2 a4 a c2 c4\resp 
          c\! bes2. bes4 a2. a4 bes2.\fermata
          \bar "|."
        }\cadenzaOn \tonIIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 d4 f2 f4 f g2 g4 g g2. g4 g2. fis4 g2.
        }          
      }
   >>
   \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Au jour de l’an -- gois -- se, je crie vers toi, Sei -- gneur_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \partial4 bes4 c2 c4 c ees2 ees4 ees d2. d4 d2. d4 d2.
        }\cadenzaOn \tonIIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          \partial4 g4 f2 f4 f ees2 ees4 \resp ees g2. g4 d2. d4 g2.\fermata
        }
      }
   >>
>>