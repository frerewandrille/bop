\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key ees \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose g e
\new ChoirStaff
<< \new Staff = "femmes"
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Large"
         g4 c d bes c2 \resp d4 ees2 d8 [c] d4 c bes c2. g2\fermata\resp
         g4 ees2 f4 g2 g4 aes2 g8 ([f]) g2\fermata\bar"|"
         g4 c d ees d c bes c bes c g2\fermata\bar"|"
         g4 c2 (d8 [ees]) d4 (c bes c2.) g2\resp
         g4 ees2 f4 g2 g4 c2 (d8 [ees] d4 c) bes c2\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         g4 g2 g4 g2 f4 ees2 4 f2 4 ees2 4 d2 ees4 c2 d4 ees2 4 c2 d4 ees2
         g4 2 4 f2 4 ees2 4 d2 4 g2 4 f2 4 ees2 4 d2 
         ees4 c2 d4 ees2 4 2 (aes8 [g]) f4 (ees f) g2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \with { alignAboveContext = "femmes" }
   \lyricsto "soprano"
   {
     Ve -- nez et man -- gez, le Christ nous in -- vite à sa ta -- ble,
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!_
     Il vient par -- mi nous, prend du pain et nous sert,
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "alto"
   {
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!_
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!_ 
     Al -- lé -- lu -- ia,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes"
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          ees4 f2 4 ees2 d4 c2 4 d2 4 c2 4 bes2 4 c2 aes4 bes2 4 aes2 4 c2
          ees4 2 4 d2 4 c2 4 bes2 4 ees2 4 d2 4 c2 4 bes2 
          4 c2 aes4 bes2 4 c2. bes4 (c d) ees2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          c4 d2 4 c2 \resp bes4 aes2 4 bes2 4 aes2 4 g2\fermata\resp
          ees4 aes (g) f ees2 4 f2 f4 c2\fermata c'4 2 4 bes2 4 aes2 4 g2
          4 c2 4 bes2 4 aes2 4 g2\resp ees4 aes (g) f ees2 4 aes4 (g f) g2. c,2\fermata
        } 
      }
   >>
>>