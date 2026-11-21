\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key ees \major \time 3/4 }
resp = { \breathe\allowBreak }
rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "ralent." )))
psub = #(make-dynamic-script (markup #:line ( #:dynamic "pp" #:normal-text #:italic "retenu" )))
agauche = \once \override DynamicText.X-offset = #0


\new ChoirStaff
<< \new Dynamics 
   {
     ees4\< f g f g aes\! g\> f g2 ees\!
     d4\< ees f f f\! f\> g aes g2\!\bar"|"
     bes4 4 g aes bes2 4 c (bes) aes bes2\> g\!\resp
     \agauche g4\psub\< g ees f g2 4\! \agauche aes4\rall 4 4 g2     
   }
   \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Calme"
         ees4 f g^\markup\italic"retenu" f g aes \allowBreak g f g2 ees\resp d4 ees f f f \allowBreak f g aes g2\bar"|"
         bes4^\markup{\italic "cresc." \dynamic f } 4 g aes bes2 \allowBreak 4 c (bes) aes bes2 g\resp
         g4 g ees f g2 \allowBreak 4 aes4 4 4 g2\fermata
         \bar"|."
       } \transpose a g \tonVIdf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         bes\breve*12/8 bes4 4 d\breve*1/2 ees4 f ees2
         g4 4 ees f g2 4 aes (g) f g2 ees2
         4 4 bes4 4 ees2 4 4 4 d ees2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     La Sa -- gesse a dres -- sé u -- ne ta -- ble.
     Elle in -- vi -- te les hommes au fes -- tin.
     Ve -- nez au ban -- quet du Fils de l’Hom -- me.
     Man -- gez et bu -- vez la Pâ -- que de Dieu.
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g4 aes bes aes bes c bes aes bes2 g f4 g aes4 4 4 4 bes4 4 2
          ees4 4 bes4 4 ees2 4 2 d4 ees2 bes2
          4 4 g aes bes2 4 c c c bes2
        } \transpose a g \tonVIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
         ees\breve*12/8\resp bes\breve*6/8 ees4 d ees2
         4 4 g g ees2 4 aes (bes) 4 ees,2 2\resp
         4 4 4 4 2 4 aes,4 4 bes ees2\fermata          
        } 
      }
   >>
>>