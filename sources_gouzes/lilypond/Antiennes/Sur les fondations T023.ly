\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose gis fis 
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 104
         gis4-> gis b-> b gis-> gis gis-> b gis->\resp
         cis cis-> b cis2.\fermata\bar"|"
         gis4 gis-> gis b-> b gis2.\resp 
         gis4-- cis---> cis--^\markup\italic"rall." b---> b-- a---> b-- cis1\fermata
         \bar"|."
       } \transpose a cis' \tonIVdf
       %\tonVIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         eis4 eis gis gis eis! eis fis fis eis! e fis fis eis2.
         eis!4 eis eis gis gis eis!2. eis!4 e e fis fis d d e1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sur les fon -- da -- tions de la ci -- té, al -- lé -- lu -- ia_!
     é -- taient gra -- vés les noms des douze a -- pô -- tres de l’A -- gneau.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          cis4 cis d d cis cis d d cis cis a fis gis2.
          cis4 cis cis d d cis2. cis4 cis cis a a fis fis a1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          cis4-> cis b-> b cis-> cis b-> b cis->\resp 
          a fis-> d cis2.
          cis'4 cis-> cis b-> b cis2.\resp
          cis4-- a---> a-- d,---> d-- d---> d-- a1\fermata
        } \transpose a cis' \tonIVdh
        %\tonVIIdh
      }
   >>
>>