\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn
         g4 g-> f g bes-> a f g2.\resp bes2 4 a-> g f g2\fermata\bar"|"
         4 a2 bes4 c2 a4 bes2 4 a2 4 \resp 
         bes2 c4 d2 e4 f-> f d! d2 (cis4) d2\fermata\bar".|:"
         d4 2 4 c2 bes4 a2 g4 a2\fermata\resp g4 bes2 4 a2 g4 2 f4 2.\fermata
         \bar"|."
       } \transpose g bes \tonIIcf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d4 ees d c ees f d d2. 2 4 f ees d d2
         g4 f2 g4 a2 f4 g2 4 f2 4 g2 a4 f2 a4 a a g f2 (e4) fis2
         g4 f2 4 g2 4 f2 ees4 c2 d4 g2 4 f2 ees4 d2 4 2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Vous ê -- tes le peu -- ple choi -- si, sa -- cer -- do -- ce roy -- al
     que Dieu ap -- pel -- le des té -- nè -- bres à son ad -- mi -- ra -- ble lu -- miè -- re.
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 c a g c a c bes2. 2 4 c c a bes2 4 d2 4 f2 c4 d2 4 2 4 2 f4 2 c4 c c c a2. 2
          bes4 2 4 ees2 d4 2 bes4 a2 bes4 ees2 4 c2 4 a2 4 bes2.
        } \transpose g bes \tonIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 c,-> d ees c-> d a' g2.\resp 2 4 f c d g2\fermata
          4 d2 g4 f2 a4 g2 4 d'2 4 \resp g,2 f4 bes2 a4 f-> f c d2 (a'4) d,2\fermata
          g4 bes2 4 c2 g4 d2 ees4 f2\fermata\resp
          g4 ees2 4 f2 c4 d2 4 g2.\fermata
        } 
      }
   >>
>>