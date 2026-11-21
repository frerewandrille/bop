\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose f d
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         f8 [bes] bes4 (a8 [g] bes [c]) c4.\fermata\bar"|"
         d8 d [d] d [d] ees [d] c4.\resp
         c8 c [bes] c [d] d4\resp bes8 [a] g4. f8 a [g] g4\fermata
         \bar"|."
       } \transpose g bes \tonIIif
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d8 [d] d4 (f8 [ees] d4) f4. f8 f [f] f [f] g [f] f4.
         f8 f [d] ees [f] f4 g8 [ees] d4. d8 c [d] d4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     No -- tre ci -- té est dans les cieux_:
     De là nous at -- ten -- dons Jé -- sus Christ res -- sus -- ci -- té.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c8 [c] bes4 (d8 [bes] bes4) a4. bes8 bes [bes] bes [bes] bes [bes] a4.
          a8 a [bes] a [bes] bes4 bes8 [c] bes4. a8 a [c] bes4
        } \transpose g bes \tonIIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a8 [a] g4 (d8 [ees] g4) f4.\fermata
          bes,8 bes [bes] d [d] g [ees] f4.\resp
          f8 ees [d] c [bes] bes4\resp
          ees8 [c] d4. d8 f [g] g4\fermata
        } 
      }
   >>
>>