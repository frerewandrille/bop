\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key cis \minor \time 2/2 }
resp = { \breathe\allowBreak }

\transpose e d
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \omit Score.BarLine \tempo "Calme"% 2. = 50
          gis4-> a b-> a gis2 a4-> a cis2 (b4 a) b2.\fermata\resp
          b4 b-> cis b-> a a-> gis fis2 a4 a a2 a4 gis e2\fermata
          \revert Score.BarLine.stencil \bar "|"
          e^\pp \omit Score.BarLine e4-> fis e-> d e-> fis fis2\fermata\resp
          fis a4 (b) b2\fermata a4-> fis fis2 a b\fermata
          \revert Score.BarLine.stencil \bar "|."
        }\cadenzaOn \tonVIIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          e4 e e fis eis2 fis4 fis e!2 (fis) fis2. 
          fis4 fis e! fis fis fis cis cis2 cis4 cis cis (dis) e e b2
          b b4 d b b b d d2 d e dis! e4 e dis!2 cis dis!
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano
   { 
     A -- vec les en -- fants et les an -- ges, 
     so -- yons fi -- dèles à cé -- lé -- brer le vain -- queur de la mort,
     et di -- sons_- lui à plei -- ne voix_: 
     Ho -- san -- na au plus haut des cieux_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          b4 cis b cis cis2 cis4 cis cis2 (dis4 e) dis2.
          dis4 dis cis dis cis cis b a2 a4 a a2 b4 b gis2
          gis gis4 a gis fis gis a a2 a a fis a4 a b2 fis fis
        }\cadenzaOn \tonVIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          e4-> a gis-> fis cis'2 fis,4-> gis a2 (b4 cis) b2.\fermata\resp
          b4 b-> a b-> fis fis-> cis fis2 fis4 fis fis2 e4 e e2\fermata
          e e4-> d e-> b e-> d d2\fermata\resp
          d cis b\fermata cis4-> cis b2 fis' b,\fermata 
        }
      }
   >>
>>