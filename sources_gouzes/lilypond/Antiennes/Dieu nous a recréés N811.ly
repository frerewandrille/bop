\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

%\transpose f d
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          f8 [f] f4. (g8 [ees g] bes [g] bes [c]) c4\fermata\bar"|"
          g4. g8 [ (f) g] a [(g) f] g4\resp
          g8 g [ees g]  bes [bes a] f4 f8\resp
          g8 ees [g] a [f] f4\fermata
          \bar"|."
        } \transpose c' bes \tonVIIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d8 [d] d4. (ees8 [c ees] f [ees] g [bes] ) a4
          g4. ees8 [(d) ees] f [(ees) d] ees4 
          ees8 ees [c ees] f [f c] d4 d8
          ees c [ees] c [bes] c4
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia_!
      Dieu nous a re -- cré -- és 
      pour u -- ne vi -- vante es -- pé -- ran -- ce 
      en son Fils bien_- ai -- mé.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
           d8 [d] c ([bes a] bes4.~ bes8 [c] d4) f
           ees4. c4 c8 c [(bes) c] bes4 
           bes8 bes [bes bes] bes [bes a] c4 c8
           bes bes [bes] a [g] a4
        }  \transpose c' bes \tonVIIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes8 [bes] a ([g f] ees [g ees] d [c] g'4) f\fermata 
          c'4. c4 c8 f, [(g) a] g4\resp
          ees8 ees [g ees] d [d f] a4 a8\resp
          g g [ees] f [f] f4\fermata
        } 
      }
   >>
>>