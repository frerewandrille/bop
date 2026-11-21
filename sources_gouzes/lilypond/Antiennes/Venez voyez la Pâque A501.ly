\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key e \minor \time 2/2 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\transpose d c
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2 = 80
          d4 g-> b a-> g d'2 b \allowBreak e4 e d c b1\fermata\bar"|"
          b8-\markup\italic"sans presser" [a b c] b [(c) b a] \allowBreak g2.
          \silN \allowBreak c8 [(b) c d] c [d c b] \allowBreak a2.*2/3  \allowBreak s4 \resp
          d,4 g4-> b a \allowBreak g d'2 b \allowBreak e4-\markup\italic"élargir" e d c b1\fermata
          \bar "|."
        }\cadenzaOn \transpose a b \tonVIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          d8 ([c]) b4 g' d e fis2 g g4 g fis e d1
          g8 [fis g a] g [(a) g fis] e2. s4 a8 [(g) a b] a [b a g] fis2.*2/3 s4
          b,4 d d d e fis2 g g4 g fis e d1
        }          
      }
   >>
   \new Lyrics 
   \lyricsto soprano 
   { 
     \repeat unfold 12 {\skip4}
     Peu -- ples, bé -- nis -- sez le Sei -- gneur
     car il nous a don -- né la vie_!
     Ve -- nez, vo -- yez 
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Ve -- nez, vo -- yez la Pâ -- que du Res -- sus -- ci -- té_!
     \repeat unfold 20 {\skip4}
     la Pâ -- que du Res -- sus -- ci -- té_!
   }
   \new Staff = "hommes"%\with {\remove Time_signature_engraver }
   <<    
     \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
     { \voiceOne \relative c'
       { \clef "bass" \armure \override Beam.breakable = ##t
         b4 d d a b d2 d c4 c a g8 ([a]) b1
         r1 c8 [b c d] c [(d) c b] a2. r4 d8 [(c) d e] d [e d c] b2 
         r4 b4 d2 d c4 c a g8 ([a]) g1
       }\cadenzaOn \transpose a b \tonVIah
     }
     \new Voice = "basse"
     { \voiceTwo \relative c'
       {
         g4 g-> g fis-> e d2 g c,4 c d e8 ([fis]) g1\fermata
         s1 s1 s1 s2.*2/3 r4 g4 g-> g fis e d2 g c,4 c d e8 ([fis]) g1\fermata
       }
     }
     \new Lyrics \with { alignAboveContext = "hommes" } 
     \lyricsto ténor
     { \repeat unfold 12 {\skip4}
       Peu -- ples, bé -- nis -- sez le Sei -- gneur
       car il nous a don -- né la vie_!
     }
     \new Lyrics \lyricsto basse
     { \repeat unfold 12 {\skip4} Ve -- nez, vo -- yez
     }
   >>
>>