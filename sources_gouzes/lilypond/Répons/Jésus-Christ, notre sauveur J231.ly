\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 6/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo  2. = 56
          \partial2. g2 bes4 a2 g4 a2 bes4 a2. a4 a bes c2 d4 bes2 (a4) g2.\resp
          a2 bes4 c2 bes4 a2 g4 f2. c'2 d4 e4. (d8) e4 d2 cis4 d2.\resp
          d2 d4 c2 a4 bes2 g4 a2. d2 d4 c2 a4 bes4. (a8) g4 a2.
          a2 bes4 c2 (d4 bes a2) \noBreak g2.
          \bar"|."
        } \cadenzaOn\tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          \partial2. d2 g4 f2 d4 f2 g4 fis2. fis4 fis g a2 f!4 d2. bes2 (d4)
          fis2 g4 g2 g4 f2 e4 c2. f2 f4 g2 g4 f2 d4 fis2. 
          g2 g4 a2 fis4 g2 d4 fis2. f!2 f4 f2 f4 g2 d4 fis2.\resp
          f2 g4 a2. (g2 fis4) g2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Jé -- sus Christ, no -- tre Sau -- veur, Fils bien_- ai -- mé du Pè -- re,
      que ta chair en -- se -- ve -- lie dans le fleu -- ve du Jour -- dain
      fas -- se res -- plen -- dir en nous ton Es -- prit de sain -- te -- té, 
      al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure 
          \partial2. bes2 d4 d2 bes4 c (d) bes d2. 
          d4 d d a2 a4 bes8 (a g4 fis) g2 (bes4)
          d2 d4 ees2 ees4 c2 c4 a2. a2 a4 c4. (d8) c4 a2 a4 a2.
          bes2 d4 f (e) d d2 bes4 a2. bes2 d4 a2 c4 d4. (d8) bes4 d2.
          d2 d4 e2 (a,4 d2.) b
        } \cadenzaOn\tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          \partial2. g2 g4 d2 g4 f (d) g d2. 
          d4 d g f2 d4 g4 (g, d') g,2 (g'4)\resp
          d2 g4 c,2 ees4 f2 c4 f2. f2 d4 c4. (bes8) c4 d2 a4 d2. \resp
          g2 bes4 a2 d,4 g2 g4 d2. bes2 bes'4 f2 a4 g2 <g, g'>4 d'2.\resp
          d2 bes'4 a2 (fis4 g d2) <g, g'>2.
        } 
      }
   >>
>>