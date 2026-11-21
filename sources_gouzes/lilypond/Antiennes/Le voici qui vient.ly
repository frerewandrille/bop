\version "2.24.0"

\include "TonsDef.ly"
%\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose bes g
\new ChoirStaff
<< \new Dynamics 
   {
         bes8 [8 8 c] d [c d] ees [d c] d\> [ees] d [c] d2\!
         bes8 [8] c4 8 [c] d4 8 [d] d [d] ees2 c4 c d2     
   }
   \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif"
         bes8 [8 8 c] d-> [c d] ees-> [d c] d-\markup\italic"élargi" ([ees] d [c]) d4\fermata\resp
         bes8 [8] c4 8 [c] d4\fermata\resp 8 [d] d [d] ees2 c4-- c-- d2\fermata
         \bar"|."
       } \transpose a bes \tonVIIdf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f8 [f f g] a [g a] bes [a g] a ([bes] a [g16 a]) bes4
         f8 [f] g4 8 [g] bes4 8 [8] 8 [8] 2 4 a bes2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le voi -- ci qui vient es -- cor -- té de nu -- é -- es,
     et tout œil le ver -- ra, mê -- me ceux qui l'ont trans -- per -- cé.
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 [d d ees] f_> [ees f] g_> [f ees] f ([g] f [ees]) f4
          d8 [d] ees4 8 [8] f4 8 [f] f [f] g2 4 f4 2
        } \transpose a bes \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes\breve*14/16 4\fermata\resp 8 [8] 4 f8 [f] bes,4\fermata\resp
          bes'8 [8] 8 [8] 2 4-- <f bes>-- <bes, bes'>2\fermata
        } 
      }
   >>
>>