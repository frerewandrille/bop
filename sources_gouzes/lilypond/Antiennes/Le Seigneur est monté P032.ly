\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 2/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         d4^\markup\italic"détaché" f d2 c4 f g a a bes a2\resp
         a4 c c (d) c a a2 a4 g a2\fermata\bar"|"
         d,4 a' a (g) a4 (b8 [c] d4 c8 [b!] a2)\resp
         d,4 a' a (g8 [f] g4 a f e) d2\fermata
         \bar"|."
       } \tonIef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 f d2 c4 f g a a bes a2 f4 a fis2 g4 fis! fis2 e4 e e2
         d4 f f (e) f (g8 [a] g4 a8 [g] f2)
         d4 f f (e8 [d] e2 d4 e) fis2
         
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Sei -- gneur est mon -- té dans les hau -- teurs.
     Il en -- traîne a -- vec lui ses cap -- tifs.
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          d4 f d2 c4 f g a a bes a2 c4 f d2 e4 d d2 c4 c cis2
          r2 d c b c b! c b! (c) <a d>
        } \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
         d4 f d2 c4 f g a a bes a2\resp
         f4 f a2 a4 d d2 c4 c a2\fermata
         d, e f (d) f \resp g f d (a'4 g) d2\fermata
        } 
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" }
   \lyricsto "ténor"
   {
     \repeat unfold 19 { \skip4 }
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Lyrics %\with { alignAboveContext = "hommes" }
   \lyricsto "basse"
   {
     \repeat unfold 19 { \skip4 }
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
>>