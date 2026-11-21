\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose bes g
  \new ChoirStaff
  << \new Staff %\with {\remove Time_signature_engraver }
     << %\accidentalStyle neo-modern-voice
       \new Voice = "soprano"
       { \voiceOne \relative c''
         { \clef "treble" \armure \cadenzaOn \tempo "Vif, allant" 2. = 63
           bes2^\< bes4 c2.^\! c4^\markup{\italic"céder"}-> c d bes-> bes bes a-> a bes
           g2. f\allowBreak f2^\markup { \dynamic p \italic"subito" } f4
           g2 g4^\markup{\italic"en dehors"} f ees f g2. f\fermata
           \bar"|."
         } \tonVIIIcf
       }
       \new Voice = "alto"
       { \voiceTwo \relative c'
         { 
           f2 f4 g2. g4 g a bes f f f f f ees2 (d4) c2.
           c2 d4 ees2 d4 c c c ees2 (d4) c2.
         }    
       }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
     {
       Le Sei -- gneur a ras -- sem -- blé les en -- fants de l’É -- gli -- se
       à la ta -- ble de son Roy -- au -- me.
     }
     \new Staff %\with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { %\accidentalStyle neo-modern-voice
          \voiceOne \relative c'
          { \clef "bass" \armure \cadenzaOn
            d2 d4 ees2. ees4 ees f d d d c c d bes2. a
            a2 a4 bes2 bes4 a g a bes2. a
          } 
        }
        \new Voice = "basse"
        { \voiceTwo \relative c'
          { 
            bes2 bes4 bes2. bes4-> bes f bes-> bes bes f-> f d ees2. f
            f2 f4 ees2 ees4 f f f ees2. f\fermata
          } \tonVIIIch
        }
     >>
  >>