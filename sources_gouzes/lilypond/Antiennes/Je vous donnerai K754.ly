\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key a \major \time 2/2 \cadenzaOn \tempo "Très calme" 2 = 60
          e4 e fis fis e2. e4 fis2 a b1\fermata\breathe\allowBreak
          cis4 cis d d cis2 a\fermata b\fermata cis1\fermata\bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          cis4 cis d b cis2. cis4 d2 d dis1 
          e4 e fis fis e2 fis2 fis4 (gis) a1
        }      \tonVIIdf    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
      Je4 vous don -- ne rai2. un4 cœur2 nou -- veau_!1
      Je4 met -- trai en vous2 mon es -- prit_!1
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key a \major \time 2/2 \cadenzaOn
          a4 a a a gis2. gis4 a2 fis fis1
          a4 a a b cis2 d d e1
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          a4 gis fis fis cis2. cis4 fis (e) d (cis) b1\fermata \breathe
          a4 a d d a'2 d,4 (cis) b2\fermata a1\fermata
        }\tonVIIdh
      }
   >>
>>