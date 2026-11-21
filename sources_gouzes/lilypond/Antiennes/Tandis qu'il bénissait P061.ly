\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Calme"
         ees8 4. f8 f [g] f4 g8 [bes] g ([f]) ees4.\resp
         8^\markup\italic"accelerando" 8 [g] bes [c] d [c] c4 \allowBreak
         bes8^\markup\italic"a tempo" [a] bes ([a]) g4.\fermata\bar"|"
         g8^\ppp bes [a^\markup\italic"extatique"] g4 8 [g] f4 g8 [f] ees4 4\resp
         f4 (g8) [g] f4 2\fermata
         \bar"|."
       } \tonVIIIgf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         c8 4. d8 d [c] d4 ees8 [c] d4 c4. 
         8 8 [ees] g [a] bes [a] g4 f8 [f] 4 ees4.
         8 8 [d] ees4 8 [8] d4 8 [d] c4 c d (c8) [c] d4 c2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tan -- dis qu’il bé -- nis -- sait ses dis -- ci -- ples, 
     Jé -- sus fut en -- le -- vé au ciel, al -- lé -- lu -- ia_! 
     Il s’est as -- sis à la droi -- te du Pè -- re, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes8 4. a8 a [g] a4 bes8 [g] a4 bes4.
          8 8 [a] g [f] ees [f] g4 c8 [c] d4 c4.
          8 c [c] c4 8 [c] c4 8 [c] bes4 4 a (bes8) [8] a ([bes]) c2
        } \tonVIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 4. f8 f [ees] f4 ees8 [8] f4 g4.\resp
          8 8 [f] ees [d] c [d] ees4 g8 [g] a4 c4.\fermata
          bes8 8 [8] 4 8 [8]a4 8 [a] g4 g\resp
          f (ees8) [8] f4 2\fermata
        } 
      }
   >>
>>