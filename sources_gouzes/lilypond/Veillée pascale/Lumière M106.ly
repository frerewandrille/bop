\version "2.24.0"

\include "vowel-set.ly"

Clefs = {   \override Score.BreakAlignment.break-align-orders =
            #(make-vector 3 '(left-edge
                              cue-end-clef
                              ambitus
                              breathing-sign
                              staff-bar
                              time-signature
                              clef
                              cue-clef
                              key-cancellation
                              key-signature
                              custos))
            \override Staff.Clef.full-size-change = ##t
}
armure = { \key c \major \time 2/4 \Clefs}
resp = { \breathe\allowBreak }
silC = { \oneVoice r8 \voiceOne }


\new ChoirStaff
<< 
  \relative c'
  { 
    \new Staff \with {\remove Time_signature_engraver }
    <<
      \new Voice = "soprano"
      { \armure \omit Score.BarLine 
        \relative c' { 
          \partial8 d8^\markup\italic\with-color #(rgb-color 0.86 0.1 0.01)" À l’entrée de l’église :"
          a' (g16 a c8 a) a g a2\fermata
          \undo \omit Score.BarLine \bar"|"
        }
      }
      \new Lyrics \lyricsto "soprano"
      { Lu -- miè -- re du Christ_! }
    >>
    <<
      << 
        { \voiceOne \clef "treble" \armure \cadenzaOn 
          \tempo \markup { 
            \column {
              \line { \concat { 1\super re " " : " "  } \dynamic pp }
              \line { \concat { 2\super e " " : " "  } \dynamic mf } 
              \line { \concat { 3\super e " " : " "  } \dynamic ff }
            }
          }
          \silC e8^\markup\italic"marcato" f4. e8 f4-- f-- f-- f\fermata f-- e4. \allowBreak\silC
          e4 e8 [e] f4 e f4. \allowBreak\silC
          e8 e4. e8 e [e] f4 e d4. \silC \allowBreak e4 e f2\fermata
          \bar":|."
        } 
        \new Voice = "alto"
        { \voiceTwo \relative c'
          { 
            s8 cis8 d4. cis!8 d4 d d d d c4. s8
            c4 cis8 [cis] d4 cis! d4. s8
            c8 c4. c8 c [c] d4 c b4. s8 cis4 cis d2
          }    
        }
      >>
      \new Staff \with {\remove Time_signature_engraver }
      << \new Voice = "ténor"
         { %\accidentalStyle neo-modern-voice
           \voiceOne \relative c'
           { \clef "bass" \armure \cadenzaOn
             \silC a8 a4. a8 a4 a a b b g4. \silC
             g4 a8 [a] a4 a a4. \silC
             g8 g4. g8 g [g] g4 g g4. \silC a4 a a2
           } 
         }
         \new Voice = "basse"
         { \voiceTwo \relative c
           { 
             s8 a8 d4. a8 d4-- d-- d-- g,\fermata g-- c4.
             s8 c4 a8 [a] d4 a d4. s8 
             c c4. c8 c [c] b4 c g4. s8 a4 a d2\fermata
           } 
         }
      >>
    >>
  }
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "soprano"
  {
    \repeat unfold 5 \skip4 \set stanza = #"Chœur :"
    Le Christ est res -- sus -- ci -- té des morts_!
    Il a vain -- cu la mort_!
    À ceux qui é -- taient au tom -- beau, rend la vie_!
  }
>>

%\markup \vspace #1
\transpose d e
<< 
  \new Staff \with {\remove Time_signature_engraver }
  \new Voice = "soprano"
  { \armure \omit Score.BarLine 
    \relative c' { 
      \partial8 d8^\markup\italic\with-color #(rgb-color 0.86 0.1 0.01)" Au milieu de l’église :"
      a' (g16 a c8 a) a g a2\fermata
      \undo \omit Score.BarLine \bar"|" 
      r8 \omit Score.BarLine e8 f4.
    }
  }
  \new Lyrics \lyricsto "soprano"
  { Lu -- miè -- re du Christ_! Le Christ... }
>>

%\markup \vspace #1
\transpose d fis
<< 
  \new Staff \with {\remove Time_signature_engraver }
  \new Voice = "soprano" 
  { \armure \omit Score.BarLine 
    \relative c' { 
      \partial8 d8^\markup\italic\with-color #(rgb-color 0.86 0.1 0.01)" À l’autel :"
      a' (g16 a c8 a) a g a2\fermata
      \undo \omit Score.BarLine \bar"|" 
      r8 \omit Score.BarLine e8 f4.
    }
  }
  \new Lyrics \lyricsto "soprano"
  { Lu -- miè -- re du Christ_! Le Christ... }
>>