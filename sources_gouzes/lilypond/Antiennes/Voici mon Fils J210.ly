\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
silB = { \oneVoice r2 \voiceOne }

\transpose g f
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 72
         \partial8 g8 g [g] fis2 e4 e fis4.\fermata\resp
         fis8 fis [g] a4 a g fis g2\resp
         g8 (a) b4. g8 g2. fis4 g2\fermata
         \bar"|."
       } \transpose a b \tonVIaf
     }
     \new Voice = "alto" 
      { \voiceTwo \relative c'
       { 
         d8 d [d] d2 d4 cis d4. d8 d [d] fis4 fis d d d2
         d4 g4. e8 d4 (c8 b c4) c b2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci mon Fils bien_- ai -- mé
     en qui j’ai mis tout mon a -- mour.
     Ve -- nez, a -- do -- rons_- le_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b8 b [b] a2 g4 a a4. a8 a [b] c4 c b a b2
          b8 (c) d4. c8 b4 (a8 g a4) a g2
        } \transpose a b \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 g [g] d2 d4 a d4.\fermata\resp d8 d [d] d4 d d d g2\resp
          g4 g4. c,8 d2. d4 g,2\fermata
        } 
      }
   >>
>>