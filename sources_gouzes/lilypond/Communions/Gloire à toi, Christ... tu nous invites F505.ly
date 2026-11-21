\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
forte = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "forte" )))
agauche = \once \override DynamicText.X-offset = #0


\new ChoirStaff
<< \new Dynamics 
   {
         fis4-\< 8 [8] g2 g a\!\bar"|" \agauche bes4\forte 8 [8] 4 a8 [bes] a4-\> (g) fis\!2 fis!4 8 [8] g4-\> 4 fis!\!2
   }
   \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn 
         fis4 8 [8] g2 g a\bar"|" 
         bes4 8 [8] 4 a8 [bes] a4 (g) fis2 \allowBreak fis!4 8 [8] g4 4 fis!2\fermata
          \bar"|."
        } \tonXcf % absent dans l'orig.
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { 
         d4 8 [8] d2 e f2 4 8 [f] 4 8 [8] 4 (e!) d2 4 8 [8] 4 e! d2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Gloire à toi, Christ sau -- veur_! Tu nous in -- vites à la ta -- ble 
     où tu nous ras -- sa -- sies.
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 8 [8] bes2 2 c d4 8 [8] 4 c8 [d] c4 (bes) a2 4 8 [8] bes4 4 a2
        } \tonXch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 8 [8] g2 g f 
          bes,4 8 [8] 4 f'8 [bes,] f'4 (cis) d2 4 8 [8] 4 4 2\fermata
        } 
      }
   >>
>>