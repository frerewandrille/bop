\version "2.24.0"

% \include "vowel-set.ly"
% \layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff ="femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure %\tempo 2 = 110
         d4. c8 bes4 c2 (f,4) d'4. c8 bes4 c2 (f,4) 
         bes4. a8 bes4 g2 a4 bes c2 f,2.
         d'4. c8 bes4 c2 (f,4) d'4. c8 bes4 c2 (f,4) 
         bes4. a8 bes4 g2 c4 bes a2 bes2.\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         bes4 a g a2. bes4 a g a2. 
         f4 ees d ees (d c) f4 ees d ees (d c) 
         bes'4 a g a2. bes4 a g a2. 
         f4 ees d ees (d c) f4 f f f2.
       }    
     }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" } \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Lyrics \lyricsto "alto"
   {
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff ="hommes"%\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure 
          f4 ees d ees (d c) f4 ees d ees (d c) 
          d4 c bes bes2 (a4) bes a bes c2.
          f4 ees d ees (d c) f4 ees d ees (d c) 
          d4 c bes bes2 ees4 c2 c4 d2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          bes2 bes4 f'2 f4 bes,2 bes4 f'2 f4
          bes,4 c d ees2 (f4) d c bes a2.
          bes2 bes4 f'2 f4 bes,2 bes4 f'2 f4
          bes,4 c d ees2 ees4 f2 f4 bes,2.
        } 
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" } \lyricsto "ténor"
   {
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Lyrics \lyricsto "basse"
   {
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
>>