\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose bes g
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo \markup{ "Calme, " \dynamic pp } 4. = 54
         g8 g4 g8 bes [(a)] g a4. \resp \time 2/4 \tempo "" 4 = 63 
         a8 [a] a [bes] g [g] fis [fis] g4.\fermata\resp
         bes8 bes [c] d4 c8 [bes] c4. c8 c [d] bes4 bes\fermata
         \bar"|."
       } \transpose a bes \tonVIIdf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d\breve*7/16 d4. d8 [d] d [g] d [d] d [d] d4. f\breve*7/16 f4. f8 g [a] f4 f
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci_: Je viens bien -- tôt et ma ré -- com -- pense est a -- vec moi_:
     Je don -- ne -- rai à cha -- cun se -- lon ses œu -- vres.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes8 bes4 bes8 d [(c)] bes c4. c8 [c] c [d] bes [bes] a [a] bes4.
          d8 d [ees] f4 ees8 [d] ees4. 8 8 [f] d4 4
        } \transpose a bes \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g\breve*7/16 d4. \resp\time 2/4 d8 [d] d [d] g [g] d [d] g4.\fermata\resp
          bes\breve*7/16 f4. f8 f [f] bes4 bes \fermata
        } 
      }
   >>
>>