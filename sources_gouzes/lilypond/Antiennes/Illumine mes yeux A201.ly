\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose cis a,
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2. = 50
         cis2 cis4 cis-> a b cis2\resp cis4 d2 d4 cis2 cis4 b2.\resp
         b2 b4 cis -> cis cis a2.\resp
         a2^\markup\italic"rall." a4 b-> b b b2.\fermata
         \bar"|."
       } \tonVIIcf
       %\tonVIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         a2 a4 a e e a2 a4 a2 a4 a2 fis4 gis2.
         gis2 gis4 gis gis gis fis2. fis2 fis4 fis fis fis gis2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Il -- lu -- mi -- ne mes yeux, Sei -- gneur, en ton sa -- lut_!
     Que dans un chant de joie,
     je m’é -- veil -- le des morts_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e2 e4 e cis d e2 e4 fis2 fis4 e2 e4 e2.
          e2 e4 eis eis eis cis2. cis2 cis4 dis dis dis e2.
        } \tonVIIch
        %\tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 a4 a-> a a a2\resp a4 a2 a4 a2 a4 e2.\resp
          e2 e4 cis-> cis cis fis2.\resp fis2 fis4 fis-> fis fis e2.\fermata
        } 
      }
   >>
>>