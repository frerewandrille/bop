\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     e2 e4 f f g e e g e2.
     g4^\< g g a a\! a b2.^\> b2 b4 a2 a4 e2.\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Allant" 2. = 63
         e2 e4 f-> f g e-> e g e2.\fermata\resp
         g4-> g g a-> \allowBreak a\! a b2. \allowBreak 
         b2 b4 a2 a4 e2.\fermata
         \bar"|."
       } \tonIIIbf
       %\tonIVcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c2 c4 d d d c c b cis2. 
         e4 e e e e e g2. g2 g4 e2 e4 e2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pour tou -- jours ta Pa -- ro -- le, Sei -- gneur,
     tu l’as plan -- tée dans les cieux, 
     é -- ter -- nel -- le -- ment.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a4 a a b g g g a2. b4 b b cis cis cis d2. 
          d2 d4 cis!2 cis4 b2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 a4 d,-> d g c,-> c e a2.\fermata\resp
          e4-> e e a-> a a g2. g2 g4 a2 a4 e2.\fermata
        } \tonIIIbh
        %\tonIVch
      }
   >>
>>