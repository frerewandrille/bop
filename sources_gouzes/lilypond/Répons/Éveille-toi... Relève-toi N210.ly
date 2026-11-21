\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }


\transpose e d
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn
         e4 d c d2 b4 c (b) a b2. \resp c4 b a b2 g4 a2 4 2.\bar"|"
         e'2 fis8 ([e]) d2 b4 c b a b2. \resp c2 b8 [a] b2 g4 a2 4 2.\fermata
         \bar"|."
       } \tonIIIhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         c4 b a g2 4 a (e) fis? g2. a4 e fis g (fis) e fis2 4 e2.
         c'4 (b) a b (a) g a e fis g2. a4 e fis8 [fis] g4 (fis) e fis2 4 e2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     É -- veil -- le_- toi, ô toi qui dors_!
     Re -- lè -- ve_- toi d’en -- tre les morts
     et le Christ t’il -- lu -- mi -- ne -- ra.
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 d e d2 4 e (d) c b2. e4 d c b2 4 d2 4 c2.
          e4 (d) c d (c) b e d c b2. e4 (d) c8 [c] b2 4 d2 4 c2.
        } \tonIIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 4 b2 4 a2 4 e2 4 \resp 
          <a, a'>2 <a a'>4 e'2 4 d2 4 <a a'>2 4
          a'2 4 b2 4 a2 4 e2 4 \resp a2 4 e2 4 d2 4 <a a'>2 4
        } 
      }
   >>
   \new Lyrics \lyricsto "basse"
   {
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
>>