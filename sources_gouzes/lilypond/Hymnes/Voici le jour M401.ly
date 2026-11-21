\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \voiceOne \relative c''
     { \clef "treble" \armure \cadenzaOn \tempo "Andante et léger"% 2 = 52
       g8 e4 g8 a4 g8 f [e d] e4 \resp g8 a [(c) a] g4 8 f4 d8 e4. \resp
       f4 e8 d4 f8 a4 g8 e4. d4 \resp f8 g [a g] f [ d e] e4.\fermata
       \bar"|."
     } \tonIVcf
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci le jour que fit le Sei -- gneur,
     jour d’al -- lé -- gresse et jour de joie,
     quand le bien_- ai -- mé du Pè -- re 
     nous a dé -- li -- vrés de la mort.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   \new Voice = "ténor"
   { %\accidentalStyle neo-modern-voice
     \voiceTwo \relative c
     { \clef "bass" \armure \cadenzaOn
       e8 g4 e8 d4 e8 f [g f] e4 \resp 8 d [(e) f] g4 8 a [(g) f] e4.\resp
       d4 e8 f4 e8 d4 e8 f4. g4\resp f8 e [d e] f [g f] <e b'>4.\fermata
     } \tonIVch
   }
>>