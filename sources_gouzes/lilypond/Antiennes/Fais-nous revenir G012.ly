\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose b a
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 46
          b4 b-> b d cis2 a4 b2 a4 fis2.\resp
          b2 d4 cis2 cis4 b2 b4 a a b fis2.\resp
          fis2 fis4 a2 g4 fis2. e2  g4 fis2.
          \bar"|."
        } \transpose a b \tonIVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          fis4 fis fis fis fis2 fis4 d (e) fis d2.
          fis2 fis4 fis2 fis4 d2 e4 fis fis e d2.
          d2 d4 cis2 e4 d2. b2 cis4 d2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Fais_- nous re -- ve -- nir à toi, Sei -- gneur_!
      Que ton peuple en toi re -- trou -- ve sa joie_!
      Ma -- ni -- fes -- te_- nous ton sa -- lut_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d d b a2 cis4 b2 cis4 d2.
          d2 b4 a2 a4 b2 b4 cis cis b a2.
          a2 a4 a2 b4 a2. g2 g4 b2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          b4 b-> b b fis'2 fis4 g2 fis4 <b, b'>2.\resp
          b2 b4 fis'2 fis4 g2 g4 fis fis g d2.\resp
          d2 d4 fis2 g4 d2. e2 e4 b2.
        } \transpose a b \tonIVah
      }
   >>
>>