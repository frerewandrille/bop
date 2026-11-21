\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"
%gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes\breve*1/16 \unHideNotes }
armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose f d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          f8 [f] f4. (g8 [ees g] bes [g] bes [c]) c4\fermata\bar"|"
          g\breve*1/16 \ss \ss \ss f4\resp
          g8 g [g g] ees [g bes] bes ([a]) f4\resp
          g8 ees [g] a [f] f4\fermata
          \bar"|."
        } \transpose c' bes \tonVIIIdf
      }
   >>
   \new Lyrics \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia_!
      Dieu nous a recré -- és 
      pour u -- ne vi -- vante es -- pé -- ran -- ce 
      en son Fils bien_- ai -- mé.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c\breve*1/16 s8*11 c4 bes\breve*1/16 s s s c4
          c8 c [c c] d [c c] bes4 c c8 d  [c] bes [bes] c4
        }  \transpose c' bes \tonVIIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*1/16 s8*11 f4\fermata 
          ees\breve*1/16 s s s ees4\resp
          ees8 ees\breve*1/16 s8*7 f4\resp
          f\breve*1/16 s s s s f4\fermata
        } 
      }
   >>
>>