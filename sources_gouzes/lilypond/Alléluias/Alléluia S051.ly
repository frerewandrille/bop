\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"
% \layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff ="femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \tempo "Léger et dansant" 2. = 66
         \partial 4 a g (f) c' c2 a4 c (bes) g g (a)\breathe
         a g (f) c' c2 a4 c (bes) g f2\breathe
         c'4 f (d) e c2 a4 a (bes) g bes (a)\breathe
         c4 f (d) e c2 a4 a (bes) g f2.\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         \partial 4 a4 g (f) c' c2 a4 c (bes) g g (a)\breathe
         a g (f) c' c2 a4 c (bes) g f2\breathe
         a4 a (bes) g bes (a) c, f (d) e c2
         a'4 a (bes) g bes (a) c, f (d) e f2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff ="hommes"%\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure 
          \partial 4 s4 s2 c4 bes (a) c c2.~ c2
          s4 s2 c4 bes (a) c c2 (bes4) a2
          f4 f2 f4 f2 f4 f2 f4 f2 f4 f2 f4 f2 f4 f (g) bes a2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \partial 4 d4\rest d2\rest a'4 g (f) c' c, (d e f2)\breathe
          d4\rest d2\rest a'4 g (f) c' c, (d e f2)\breathe
          f4 f2 f4 f2 f4 f2 f4 f2\breathe 
          f4 f2 f4 f2 e4 d (bes) c <f, c'>2.\fermata
        } 
      }
   >>
   \new Lyrics \lyricsto "basse"
   {
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, 
     Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
>>