\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g\minor \time 3/4 }
resp = { \breathe\allowBreak }
silB = { \oneVoice r2 \voiceOne }


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 4 = 63
         d4 2. 4 ees d d2. \resp 4-- 4 4 bes2-- 4 2-> 4 4-> (a2\fermata) \silB\bar"|"
         a4 b2-> 4 c2 4 b!2.\fermata
         \bar"|."
       } \transpose g bes \tonIIcf % pas de ton dans l’orig.
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g4 2. 4 4 4 fis2. fis!4 4 4 g2 g8 [(f)] e2 4 d2. s2 d4 2 4 ees2 d8 ([c]) d2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Christ s’est fait pour nous o -- bé -- is -- sant jus -- \apostrophe qu’à la mort, 
     la mort sur u -- ne croix.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 2. 4 c bes a2. 4 4 4 g2 4 2 4 4 (fis2\fermata) \silB
          fis4 g2 4 2 4 2.
        } \transpose g bes \tonIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 2. 4 c, g' d2.\resp 4-- 4 4 ees2-- d4 cis2-> 4 d2.-> s2 
          d4 g,2-> 4 c2 4 g'2.\fermata
        } 
      }
   >>
>>