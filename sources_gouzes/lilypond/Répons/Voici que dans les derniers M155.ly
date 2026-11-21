\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }


\transpose c bes,
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Large"% 2 = 52
          c2 c2. c4 b d c2 b a2.\resp 
          a4 a a a2 a4 a b2. \allowBreak c4^\> b2 a g\fermata\!
          \bar"|."
        } \transpose bes c'\tonVIIIbf % pas de ton dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g2 g2. g4 g g g2 g e2. 
          e4 e e fis!2 fis4 fis g2. g4 g2 fis d
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Voi -- ci que dans les der -- niers jours,
      je ré -- pan -- drai mon Es -- prit sur tou -- te chair.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e2 e2. e4 d f e2 d c2. c4 c c c2 c4 c d2. e4 d2 c b
        } \transpose bes c'\tonVIIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          c2 c2. c4 g' g c2 g a2.\resp
          a4 a a a2 a4 a g2. g4 g2 d g\fermata
        } 
      }
   >>
>>