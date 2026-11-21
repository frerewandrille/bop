\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose bes a
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 76
         g2 g4 g f2 f4 f g2 g d\resp g g bes \allowBreak bes4 bes c2 c d\fermata\resp
         d2 d4 d f2 d4 (c) bes2 \allowBreak bes g1 bes2 c bes1 bes
         \bar"|."
       } \tonVIIIbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d2 d4 d d2 d4 d bes2 bes4 (c) a2 bes c d d4 d f2 f f
         f g4 a g2 f d ees ees1 d2 f d1 d
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ce n’est pas vous qui m’a -- vez choi -- si,
     mais c’est moi qui vous ai choi -- sis,
     a -- fin que vous por -- tiez un fruit qui de -- meu -- re.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 bes4 bes a2 a4 a g2 g fis g ees f g4 bes a (g) a2 bes
          bes bes4 a bes2 a g g c1 bes2 a bes1 bes
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 g4 g d2 d4 d ees2 ees d\resp 
          ees4 (d) c2 bes4 (a) g g' f2 f bes,\fermata\resp
          bes'4 (a) g f ees2 f g4 (f) ees (d) c1 g'2 f <bes, f'>1 q
        } \tonVIIIbh
      }
   >>
>>