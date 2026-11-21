\version "2.24.0"

%\include "vowel-set.ly"
%\include "TonsDef0.ly"


armure = { \key d \major \time 3/4 }
silN = { \oneVoice r4 \voiceOne }

\score {
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \tempo \markup{"Vif et rythmé " \dynamic mf}
         a4 a a b2 a4 a (g) fis a2. \breathe fis4^\p 4 4 2 4 4 (e) d e2. \breathe
         a4^\f a a b2 a4 a g fis a2. \breathe\silN a4 d cis2. \noBreak d\fermata
         \bar"|."
       } \cadenzaOn\tonVgf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         fis4 4 4 g2 fis4 4 (b,) d e2. d4 d d d2 cis4 d (b) b cis2. 
         fis4 4 4 g2 fis4 4 b, d e2. s4 d fis e2. fis
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Il est vrai -- ment res -- sus -- ci -- té_: Pour -- quoi cher -- cher par -- mi les morts_?
     Il est vi -- vant comme il l’a pro -- mis. Al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure
          d4 4 4 2 4 cis (e) d cis2. a4 4 4 b2 a4 a (g) fis a2.
          a4 d d d2 4 cis e d cis2. \silN d4 a4 2. 2.
        } \cadenzaOn\tonVgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 4 4 g2 d4 fis (e) b' a2. \breathe d,4 d d b2 fis'4 d (e) b a2. \breathe
          fis'4 d4 4 g2 d4 fis e b' a2. \breathe s4 fis d a2. d\fermata
        } 
      }
   >>
>>
}
%\include "TonsDef0.ly" %\include "TonsRDef0.ly" 
