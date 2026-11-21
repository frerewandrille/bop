\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     g4^\< aes8 [aes] c4^\> c8 [c] c2 c4 b c2 c4\!
     c^\< b!4. b8 a2 a4\! bes a2 a1
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif et marqué" 4 = 112
          g4 aes8 [aes] c4 c8 [c] c2 c4 b c2 c4\resp
          c b!4. b8 a2 a4 bes a2-> a1\fermata
          \bar"|."
        } \tonXaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 f8 [f] g4 g8 [g] aes!2 g4 g g2 g4 g g4. g8 e2 e4 g e2 fis1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     La ter -- re tremble et re -- vient au si -- len -- ce,
     quand Dieu se lè -- ve pour sié -- ger.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 c8 [c] e!4 e8 [e] f2 d4 d ees2 ees4 
          ees d4. d8 cis2 cis4 d d (cis!) d1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 f8 [f] c4 c8 [c] f2 g4 g c,2 c4\resp
          c g'4. g8 a2 a4 g a2-> d,1\fermata
        } \tonXah
      }
   >>
>>