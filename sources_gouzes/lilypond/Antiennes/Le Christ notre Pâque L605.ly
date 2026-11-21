\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn
         d2 d1 d2 d d (c4 bes c2 d) d1\fermata\bar"|" \time 3/2
         g,2 g1 g2 g1 g2 g (fis1\fermata)\bar"|" \time 2/2
         fis!4 fis g2 a4 a bes2 \resp 
         bes4 bes a2 (g) g fis!4 (e) fis!1\fermata
         \bar"|."
       } \transpose c bes, \tonIIIhf
     }
     \new Voice = "alto" 
      { \voiceTwo \relative c''
       { 
         g2 g1 g2 g g\breve fis1 d2 d1 d2 ees1 e2 d1.
         d4 d d2 d4 d d2 d4 d ees2 (e) d d d1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Christ no -- tre Pâ -- que a é -- té im -- mo -- lé_!
     et nous som -- mes sau -- vés par le sang de l’A -- gneau.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 bes1 bes2 bes bes (a g1) a
          bes2 bes1 bes2 bes1 bes2 a1.
          a4 a g2 fis4 fis g2 g4 g a1 bes2 a4 (g) a1
        } \transpose c bes, \tonIIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 g1 g2 f ees\breve d1\fermata g2 f1 f2 ees1 cis2 d1.
          c4 c bes2 a4 a g2\resp g4 g c2 (cis) d d d1\fermata
        } 
      }
   >>
>>