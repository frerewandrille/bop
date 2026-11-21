\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Léger et vif" 2. = 72
          a4 fis2. a4 b g a2 b4 c b c a2\resp d4 d(c) b a2.\bar"|"
          a4^\pp a a e2 e4 g fis g a2. a\resp
          a4 a a e2 g4 a2 a4 c (b) a a2.
          \bar"|."
        } \tonVIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 d2. d4 d e d2 d4 e e e d2 fis4 e2 e4 fis2.
          e4 e e d2 c4 b b e e2. e e4 e e e2 e4 g2 g4 g2 g4 fis2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Lou -- ez et bé -- nis -- sez le Nom du Sei -- gneur, 
      Al -- le -- lu -- ia_!
      Il a com -- blé Ma -- rie de sa grâ -- ce
      pour qu’el -- le soit la Mè -- re des vi -- vants.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          fis4 a2. fis4 g g fis2 g4 g g g fis2 a4 c2 a4 a2.
          a4 a a b2 a4 g a b cis2. cis
          cis!4 cis cis d2 d4 e2 e4 e (d) c! d2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d2. d4 g, e' d2 g,4 c c c d2\resp d4 a2 c4 d2.
          c4 c c b2 c4 e e e a2. a\resp
          a4 a a b2 b4 c2 c4 a2 a4 d,2.
        } \tonVIIah
      }
   >>
>>