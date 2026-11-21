\version "2.24.0"

%\include "TonsDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \minor \time 2/4 }
resp = { \breathe\allowBreak }

\transpose d b,
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   <<
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 78
         d4.-> c16 ([bes]) c4.-> d8 d4-> (c8) bes c2\resp
         bes4.-> a16 ([g]) a4-> (g8 [a]) bes4 c8 ([bes]) a2\fermata\resp
         d4. c16 [bes] c4 (bes8 [a]) bes4 a g2\fermata
         \bar"|."
       } \transpose g bes \tonIIcf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         g4. g8 a4. f8 f4. g8 a2 f4. d8 d4 (g) g a8 ([g]) f2
         f4. f16 [g] a4 (g) g f d2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Viens, Sei -- gneur, ne tar -- de plus_!
     En veil -- lant dans la nuit, nous at -- ten -- dons ton re -- tour_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      {
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4. d8 f4. d8 d4. d8 f2 d4. c16 ([bes]) c4 (bes8 [c]) d4 f8 ([d]) d2
          d4. d16 [d] f4 (d8 [c]) d4 c bes2
       } \transpose g bes \tonIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes 4. a16 ([g]) f4. bes8 bes4 (a8) g f2\resp
          g4. g8 d2 g4 f8 ([g]) d2\fermata\resp
          bes'4. a16 [g] f4 (g) d f g2\fermata
        }
      }
   >>
>>