\version "2.24.0"
%\include "TonsRDef.ly"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         \partial8 g4 a8 a g fis e4 g8 fis e4 d e\fermata\resp
         g8 [a] b a b c b4 a a8 b g4 fis e2\fermata
         \bar"|."
       } \tonRIIlf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 fis8 fis e b b4 e8 b b4 b b
         g'8 [g] g g g g g4 fis fis8 fis e4 b b2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Chante et ré -- jou -- is_- toi, car voi -- ci qu’il vient_!
     Le Sei -- gneur nous ras -- sa -- sie des biens de sa mai -- son.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 b8 b b a g4 b8 a g4 fis g
          b8 [c] d c d e d4 d d8 d b4 a g2
        } \tonRIIlh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 b8 b e b e4 e8 b b4 b e\fermata\resp
          g8 [g] g g g g g4 d d8 d e4 b e2\fermata
        } 
      }
   >>
>>