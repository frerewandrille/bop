\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff 
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif et rythmé"
         b8 [b] d4-> d-- d-- b2 b8 [b] g4-> g a b2.\fermata\resp
         b2 8 [b] 2 4 c2 b8 ([a]) b2.\fermata\bar"|"
         e4-- 4-- 4-- d2 4 c2 b8 [a] b2\resp b4-- c2-- 4-- b2.\fermata
         \bar"|."
       } \transpose a b \tonImf % orig. \tonVIef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g8 [g] a4 a a g2 g8 [g] e4 e e dis2. dis!2 8 [8] e2 4 2 4 2.
         g4 4 4 2 4 e2 8 [8] 2 4 2 8 ([fis]) gis2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Jé -- sus Christ, no -- tre Pâque, a é -- té im -- mo -- lé,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
     C’est le Sei -- gneur, il vit à ja -- mais, al -- lé -- lu -- ia_!
   }
   \new Staff 
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 [d] 4 4 4 e2 8 [8] b4 4 a fis2. 2 8 [8] gis2 4 a2 gis!8 ([fis]) gis!2.
          c4 4 4 b2 4 a2 8 [8] gis2 gis!4 a2 c4 e2.
        } \transpose a b \tonImh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 [g] fis4-> 4-- 4-- e2 8 [8] d4-> 4 c b2.\fermata\resp
          2 8 [8] e2 4 a,2 4 e'2.\fermata
          c4-- 4-- 4-- g'2 4 a2 g8 [f] e2 4-- a,2-- 4-- e'2.\fermata
        } 
      }
   >>
>>