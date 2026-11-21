\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key ees \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose g e
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn
         g4 g2.-> 4-> g g g-> g g c-> c c b2->\resp
         b!4 c2.-> 4-> c d ees2.\resp 2-> 4 d-> d c b!2\fermata\bar"|"
         b!4^\markup\italic"élargir subito" c2\fermata 4 g2\fermata\resp
         4 2\fermata 4 2.\fermata
         \bar"|."
       } \transpose e g \tonIVcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 ees2. d4 d d ees4 4 4 4 4 f g2 4 2. 4 4 bes4 2. 2 4 4 4 g g2
         4 2 4 2 d4 ees2 4 d2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Christ, nou -- vel A -- dam, s’est le -- vé du tom -- beau_;
     en lui tous re -- vi -- vront_: Dieu se -- ra tout en tous,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 c2. b!4 4 4 c c c c c c d2 4 ees2. 4 4 f ees2. 2 4 f f ees d2
          4 ees2 4 d2 b!4 c2 4 b2.
        } \transpose e g \tonIVch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 c,2.-> g'4-> g g c,-> c c aes'-> 4 4 g2->\resp
          4 c2.-> 4-> 4 bes ees,2.\resp 2-> 4 bes'-> 4 c g2\fermata
          g4 c2\fermata 4 b2\fermata\resp g4 c,2\fermata 4 <g g'>2\fermata
        } 
      }
   >>
>>