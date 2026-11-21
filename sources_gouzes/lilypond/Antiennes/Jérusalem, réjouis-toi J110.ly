\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 120
         \revert Staff.TimeSignature.style
         \partial8 fis8 ([e]) fis g a4 a b4. a8 g2\resp
         a4 b c2 (b4) a g2\resp fis4 g a2. g4 fis2 e4 e fis2\fermata
         \bar"|."
       } \tonVIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 d8 d d4 d g4. fis8 d2 e4 g g2. fis4 d2
         d4 d d2. d4 d2 d4 cis d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Jé -- ru -- sa -- lem, ré -- jou -- is_- toi_!
     Sois il -- lu -- mi -- née_!
     Car voi -- ci ve -- nir ton Sau -- veur_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \revert Staff.TimeSignature.style
         a8 ([g]) a b c4 c d4. c8 b2 c4 d e2 (d4) c b2
         a4 b c2. b4 a2 a4 a a2
        } \tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d8 d d4 d d4. d8 g2\resp
          c,4 b a2 (d4) d g2\resp
          d4 d d2. d4 d2 a4 a d2\fermata
        } 
      }
   >>
>>