\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 3/4 \cadenzaOn \tempo 2 = 76
          b4 b d c2 b4 g2 a4 b2. \breathe\allowBreak
          g2 g4 g2 g4 b^> b b a2.\fermata\bar"|."
        }\tonVIIff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { \cadenzaOn
          g4 g fis a (g) fis e2 fis4 g2. d2 d4 e2 e4 g fis e fis2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Fais_- moi con -- naî -- tre tes che -- mins, gui -- de_- moi dans ta vé -- ri -- té_!
   }

   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/4 \cadenzaOn
          d4 d d e2 d4 c2 c4 d2. b2 b4 c2 c4 d d d d2.
        }\tonVIIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          g4 g b a2 b4 c (b) a g2.\breathe 
          g2 g4 c,2 c4 <g g'>-> q q d'2.\fermata
        }
      }
   >>
>>