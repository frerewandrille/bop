\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \major \time 2/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Léger" 2 = 72
         b4 gis-> b b2. cis4 d-> b b2 b2.\fermata\resp
         b4 cis cis b b a2 \allowBreak a4 gis a a b b gis2\fermata gis\fermata
         \bar"|."
       } \tonVIIcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 e e e2. e4 fis fis e2 e2. gis4 a a gis gis fis2
         fis4 eis fis fis fis fis e2 e
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu as sau -- vé la vie des pau -- vres.
     En toi se -- ront bé -- nis tous les peu -- ples de la ter -- re.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          gis4 b gis gis2. a4 a a gis2 gis2.
          e'4 e e e e cis2 cis4 cis cis cis dis dis b2 b
        } \tonVIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 e-> e e2. a,4 d-> d e2 e2.\fermata\resp
          e4 a a e e fis2 fis4 cis fis fis b, b e2\fermata e\fermata
        } 
      }
   >>
>>