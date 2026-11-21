\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/8 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Dynamics 
   { bes4 c16 [bes] g4 g8 bes4 c16 [bes] g4 g8\resp
     g4.^\markup{\dynamic p \italic "subito"}
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         bes4-> c16 [bes] g4-> g8 bes4 c16 [bes] g4-> g8\resp
         g4.\fermata g4.\fermata\bar"|"
         d'4-> d16 [d] c8-> [bes a] bes4-> (g8) g4.\resp
         g4-> g8 f4-> (g8) g2.\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g4 a16 [g] e4 e8 g4 a16 [g] e4 e8 d4. e
         bes'4 bes16 [bes] a8 [g f] f4. e d4 e8 d4. e2.
       } \transpose b a \tonIIIdf
       %\tonIIaf
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu nous ras -- sem -- bles en ta de -- meu -- re, Sei -- gneur_:
     Tu nous pré -- pares u -- ne ta -- ble, al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d8 c4 c8 d4 d8 c4 c8 bes4. c
          f4 f16 [f] f8 [d c] d4 (bes8) c4. bes4 c8 a4 (bes8) c2.
        } \transpose b a \tonIIIdh
        %\tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g8 c,4 c8 \once \override BreathingSign.Y-offset = #0 \resp g'4 g8 c,4 c8\resp g'4.\fermata c,\fermata
          bes'4-> bes16 [bes] f8-> [f f] d4.-> c->\resp g'4-> c,8 d4-> (g8) c,2.\fermata
        } 
      }
   >>
   \new Lyrics \lyricsto "ténor"
   {
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia,
   }
>>