\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \minor \time 2/4 }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure 
         c4 a8 bes c4 d \time 3/4 c2\breathe a4 bes2 4 a2\breathe
         c4 d2 4 c2\breathe a4 bes2 4 a2.\fermata
         \bar"|."
       } \cadenzaOn \tonVIhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         a4 f8 g a4 bes a2 f4 d8 (e f4) g f2 c4 bes8 (c d4) e f2
         4 d8 (e f4) g f2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Christ est res -- sus -- ci -- té, al -- lé -- lu -- ia, 
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Lyrics = "ténors" \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténors"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure 
          c4 c8 8 4 bes c a8 bes c4 d2 4 c2 a4 bes2 4 a2 c4 d2 c4 2.
        } \cadenzaOn\tonVIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 f8 f f4 bes, f'\breathe f8 g f4 bes2 4 f2 \breathe
          4 d8 (e f4) g a2\breathe f4 bes,8 (c d4) e f2.\fermata
        } 
      }
   >>
      \context Lyrics = "ténors" \lyricsto "ténors" 
      { Christ est res -- sus -- ci -- té, Christ est res -- sus -- ci -- té, }
>>