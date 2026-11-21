\version "2.24.0"

\include "vowel-set.ly"
%\include "TonsDef.ly"

armure = { \key a \major \time 2/2 }
resp = { \breathe\allowBreak }

\transpose a g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 72
          a4-> a a-> gis a-> b cis2 cis4 cis d2 cis4 a b1\fermata\resp
          b4-> b gis-> a b2 \allowBreak cis4-> b a-> (gis) a2\resp
          a a4-> a cis-> cis cis2 (b4 a) gis1\fermata
          \bar"|."
        } \transpose b cis' \tonIIIcf
        %\tonVIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e4 e e e e e a2 a4 a a2 a4 fis gis1
          gis4 gis e fis gis2 a4 gis fis (eis) fis2 
          fis fis4 fis fis fis eis!2. (fis4) eis!1
        }    
      }
   >>
   \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Je ne vous ap -- pel -- le plus ser -- vi -- teur, mais_: a -- mis_!
      Ce que j’ai ap -- pris de mon Pè -- re,
      je vous l’ai fait con -- naî -- tre.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          cis4 cis cis b cis d e2 e4 e fis2 e4 cis e1
          e4 e b b e2 e4 e cis2 cis cis cis4 cis a b cis1 cis
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4-> a a-> a a-> a a2 a4 a d,2 e4 fis e1\fermata\resp
          e4-> e e-> e e2 e4-> e fis-> (cis) fis2\resp
          fis2 fis4-> fis a-> a gis2. (fis4) cis1\fermata
        } \transpose b cis' \tonIIIch
        %\tonVIIdh
      }
   >>
>>