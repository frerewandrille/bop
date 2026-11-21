\version "2.24.0"
%\include "TonsDef.ly"

\transpose bes g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 2/2 \cadenzaOn \tempo "Large et doux" 2 = 60
          bes2 bes4 bes bes^> c c2 c2.\breathe\allowBreak c4 c^> d d2 (c4 d) c2.\breathe\allowBreak
          c4 c^> d d2 d1 \breathe \allowBreak c4 d c (bes) bes2\fermata\bar "|."
        }\transpose a bes \tonVIIIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f2 f4 f f f g2 g 2. g4 g g a2 (g) a2. a4 a a g2 g1 g4 g g2 f
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     De ta mi -- sé -- ri -- cor -- de, la terre est plei -- ne. 
     Fais_- moi con -- naî -- tre ta Pa -- ro -- le_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 2/2 \cadenzaOn
          d2 d4 d d d ees2 ees2. ees4 ees ees f2 (ees) f2. f4 f f ees2 ees1 ees4 ees ees2 d
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes2 bes4 bes bes_> bes bes2 bes2.\breathe bes4 bes_> bes bes1 f2.\breathe
          f4 f_> f bes2 bes1\breathe bes4 bes ees,2 bes'\fermata
        }\transpose a bes \tonVIIIeh
      }
   >>
>>