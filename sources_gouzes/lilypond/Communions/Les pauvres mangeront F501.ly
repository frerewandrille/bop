\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose bes g
\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure 
         \partial4 bes4 a2 g4 fis2 g4 a2. bes2 c4 d2 ees4 d2 c4 bes2. 
         d2 4 c2 bes4 a2 bes4 a2 4 bes2 c4 d2 ees4 d2 c4 bes2.\fermata
         \bar"|."
       } \cadenzaOn\tonVIIIaf %pas de ton dans l'orig.
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f4 2 d4 2 4 f2. 2 4 bes (g) a bes2 a4 f2.
         bes2 4 a2 g4 fis2 g4 fis2 4 g2 a4 bes (g) a bes2 a4 f2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Les pau -- vres man -- ge -- ront à la ta -- ble du Sei -- gneur_;
     il se -- ra leur nour -- ri -- tu -- re, 
     le Sei -- gneur les ser -- vi -- ra.
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure 
          d4 c2 bes4 a2 bes4 c2. d2 ees4 f2 4 2 ees4 d2.
          f2 4 2 d4 2 4 2 4 2 f4 2 4 2 ees4 d2.
        } \cadenzaOn\tonVIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes4 f2 g4 d2 g4 f2. bes2 4 2 f4 bes2 f4 bes2.
          2 4 f2 g4 d2 g4 d2 4 g2 f4 bes2 f4 bes2 f4 bes2.\fermata
        } 
      }
   >>
>>