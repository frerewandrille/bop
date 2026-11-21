\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 3/8 }
resp = { \breathe\allowBreak }
silC = { \oneVoice r8 \voiceOne }

\transpose bes g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo  4. = 80
          \silC f8 ([g]) bes4. \silC bes8 [bes] bes [c d] 
          bes4. (g8 [f g]) bes2.%\resp
          \time 2/8 \tempo 4 = 69 \bar"|"
          d8 [d16 d] d8 [d] c16 [bes c ees] d2.
          \bar "|."
        } \transpose a bes \tonVIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          s8 f ([g]) bes4. s8 bes [bes] bes [c d] 
          bes4. (g8 [f g]) bes2.
          bes8 [bes16 bes] bes8 [bes] g16 [g g a] bes2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Al -- lez_! En -- sei -- gnez tous les peu -- ples_!_
     Que l’u -- ni -- vers voie le sa -- lut de Dieu_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          \silC f8 ([g]) bes4. \silC bes8 [bes] bes [c d] 
          bes4. (g8 [f g]) bes2.
          f'8 [f16 f] f8 [f] ees16 [d ees ees] f2. 
        } \transpose a bes \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          s8 f ([g]) bes4. s8 bes [bes] bes [c d]
          bes4. (g8 [f g]) bes2.
          bes8 [bes16 bes] bes8 [bes] c16 [c c c] bes2.
        }
      }
   >>
>>