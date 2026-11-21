\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 2. = 50
         e2-> e4 e-> (d) e f2. e2\fermata 
         e4 g2-> g4 g-> (f) g a2\fermata\resp
         a4 c-> (b) a c-> b a c2-> (a4) a2.\resp
         a4-> g f g-> g a a2.\fermata
         \bar"|."
       } \tonIVbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c2 c4 c (b) c d (c b) c2 c4 e2 e4 e (d) e f2
         f4 a (g) f a g f a (g f) f2. f4 e d e e e e2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sans te voir en -- co -- re, nous tres -- sail -- lons de joie,
     dé -- jà rem -- plis de ta gloi -- re_:
     Nous at -- ten -- dons ta ve -- nue.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a4 a2 a4 a2. a2 a4 b2 b4 b (c) b c2
          c4 a (b) c a b c a (b c) c2. c4 b c b b cis cis2.
        } \tonIVbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2-> a4 a2-> a4 d,2. a'2\fermata
          a4 e2-> e4 g-> (a) g f2\fermata\resp
          f4 f-> (g) a f-> g a f2.-> f\resp 
          f4-> g a g-> e <a, a'>4 q2.\fermata
        } 
      }
   >>
>>