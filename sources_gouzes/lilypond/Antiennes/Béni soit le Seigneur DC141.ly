\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose c bes,
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Allant"% 2 = 52
          c8 ([b]) c4 a-> a e'8 ([d] e4) c2\resp
          c8 ([b]) c4 a-> a b8 ([a] g4) a2 a\fermata
          \bar"|."
        } \tonIIIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          a4 g fis fis g2 a a8 ([g]) a ([g]) fis ([g]) 
          fis4 g (e) e (fis) e2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Bé -- ni soit le Sei -- gneur._
      Il é -- lè -- ve les hum -- bles.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 d8 ([e]) d4 d e4. (d8) e2 
          e4 e d8 ([e]) d4 e (d) c (d) c2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 b8 ([c]) d4-> d c4. (b8) a2\resp
          a4 a d-> d c (b) a (d,) a2\fermata
        } \tonIIIhh
      }
   >>
>>