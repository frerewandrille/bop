\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose e d
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         e4-> e e d2 d4 b2.\resp b2 b4 b2 a4 b2. b4 b b b2 b4 d2 (b4) d2\resp
         b4 a-> (fis) a b2\fermata\bar"|"
         gis!4 gis-> gis gis e-> e e a-> a a gis!2\resp 
         gis!4 a2 a4 gis!2.\fermata
         \bar"|."
       } \tonIVbf
       %\tonIIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g4 g g fis2 fis4 g2. g2 g4 fis2 fis4 fis2. fis4 fis fis g2
         g4 fis2. gis2 gis!4 fis2 fis4 gis!2
         e4 e e e c? c c c c d e2 e4 c2 d4 e2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Jé -- sus, le Fils de Dieu, rè -- gne sur le 
     trô -- ne de Da -- vid son pè -- re, al -- lé -- lu -- ia_!
     L’a -- mour du Sei -- gneur est fon -- dé pour tou -- jours, 
     al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 b b b2 cis8 ([d]) e2. e2 e4 cis!2 cis4 dis2. dis4 dis dis e2
          e4 d2. e2 e4 cis! (d) cis! e2
          b4 b b b a a a a a a b2 b4 a2 a4 b2.
        } \tonIVbh
        %\tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4-> e e b2 b4 e2. e4 (fis) g fis2 fis4 b2. b4 b b e,2
          e4 b'2. e,2\resp e4 fis2 fis4 e2\fermata
          e4 e-> e e a-> a g f-> f f e2\resp e4 f!2 f4 e2.\fermata
        } 
      }
   >>
>>