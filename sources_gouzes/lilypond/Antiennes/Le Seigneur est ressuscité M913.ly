\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose a fis
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         a8 [bes] c ([d]) c4\fermata\bar"|"
         c8 [d] bes4 g8 [bes] a [g] f4.\fermata\resp
         g8 ees [g] bes4\fermata g8 [bes] a ([g]) f4\fermata\bar"|"
         g4 bes8 ([a]) f4 f\fermata
         \bar"|."
       } \tonVIIIbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f\breve*1/16 s s s f4 
         f8 [f] g4 ees8 [f] ees [ees] c4.
         ees8 c [ees] f4 ees8 [d] ees4 d
         c8 ([d]) ees4 d16 ([c bes8]) c4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Le Sei -- gneur est res -- sus -- ci -- té_!
     Il est vi -- vant pour les siè -- cles_!
     Al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c8 [bes] a ([g]) a4
          a8 [bes] bes4 c8 [bes] c [bes] a4.
          bes8 bes [bes] bes4 bes8 [bes] c ([bes]) a4
          g c8 ([bes]) a ([g]) a4
        } \tonVIIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*1/16 s s s f4\fermata
          f8 [d] ees4 ees8 [d] c [c] f4.\fermata\resp
          ees8 g [ees] d4\fermata ees8 [g] c,4 d4\fermata
          ees c f f\fermata
        } 
      }
   >>
>>