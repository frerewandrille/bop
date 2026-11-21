\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f\major \time 2/2 }
resp = { \breathe\allowBreak }



\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << 
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \tempo "Très paisible" 2 = 56
         a1 f2. g4 a2\fermata\resp bes2 4 c bes a a2\resp
         g4 fis g2 a4 4 bes2 c4 (bes) a2\resp g4 (f) g2 a \noBreak f1\fermata
         \bar "|."
       }\cadenzaOn \tonVIaf %pas de ton dans l'orig.
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       {
         f1 c2. f4 2 2 4 4 4 4 2 d4 d4 2 f4 4 2 2 2 2 e e c1
       }          
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Que dans la mort je ne m’en -- dor -- me pas. 
     Il -- lu -- mi -- ne mes yeux, Sei -- gneur,  é -- veil -- le_- moi_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          c1 a2. bes4 c2 d2 4 ees d c4 2 
          bes4 a bes2 c4 c d2 ees4 (d) c2 bes4 (a) bes2 c a1
        }\cadenzaOn \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          f1 2. 4 2\fermata\resp <bes, bes'>2 <bes bes'>4 q q f' f2\resp
          g4 d g2 f4 f bes2 a4 (bes) f2\resp 2 c c f1\fermata
        }
      }
   >>
>>