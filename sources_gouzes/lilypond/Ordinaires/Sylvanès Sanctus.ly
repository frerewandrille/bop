\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Rythmé"
         bes2-> g-> a4-> a8 [a] bes2\fermata\resp
         bes4.-> bes8 c2 a  bes\fermata \bar":|."  
         bes\breve*1/8 bes4. bes8 a [bes] c4 c8 [bes] a2  a\fermata
         \bar ".|:-|"  \tempo "Vif" bes4 a8 ([bes]) c4 bes8 [c] a4 a bes2\fermata
         \bar":|." 
         bes\breve*1/8 a8 [bes] c2 c8 [bes]  a2\fermata
         \bar ".|:-|"  \tempo "Vif" bes4 a8 ([bes]) c4 bes8 [c] a4 a bes2\fermata
         \bar":|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f2 ees f4 f8 [f] f2 f4. f8 g2 f f
         f\breve*1/8 f4. f8 f [f] g4 g8 [g] f2 f
         f4 f g g8 [g] f4 f f2
         f\breve*1/8 f8 [f] g2 g8 [g] f2
         f4 f g g8 [g] f4 f f2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Saint, saint, saint, le Sei -- gneur, Dieu de l’u -- ni -- vers_!
     "Le ciel et la" ter -- re sont rem -- plis de ta gloi -- re.
     Ho -- san -- na au plus haut des cieux.
     "Béni soit celui qui" vient au nom du Sei -- gneur.
     Ho -- san -- na au plus haut des cieux.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure
          d4 (c8 [d]) ees4 (d8 [ees]) c4 d8 [ees] d2
          f4 (ees8) [d] ees4 (d8 [c]) d4 (ees) d2
          d\breve*1/8 d4. d8 c [d] ees4 ees8 [d] c2 c
          d4 c8 ([d]) ees4 d8 [ees] c4 d8 ([ees]) d2
          d\breve*1/8 c8 [d] ees2 ees8 [d] c2
          d4 c8 ([d]) ees4 d8 [ees] c4 d8 ([ees]) d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          bes2-> c-> f4-> f8 [f] bes,2\fermata\resp
          d4.-> d8 c2 f bes,2\fermata
          bes\breve*1/8 bes4. 8 <f f'>8 [d'] c4 c8 [c] <f, f'>2 q\fermata
          bes4 f'8 ([d]) c4 c8 [c] <f, f'>4 q bes2\fermata
          bes\breve*1/8 f'8 [d] c2 c8 [c] <f, f'>2\fermata
          bes4 f'8 ([d]) c4 c8 [c] <f, f'>4 q bes2\fermata
        } 
      }
   >>
>>