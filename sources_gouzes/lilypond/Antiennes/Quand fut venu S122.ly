\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with { \consists "Merge_rests_engraver" }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      {  \relative c'
        { \clef "treble" \armure  \tempo 4 = 76
          \partial8 d8 g a bes bes a4 g8 f g4 a d,4. 
          d8 g a bes bes a4 g8 f g4 a g r8
          d8 g a bes bes a4 g8 f g4 a d,4. 
          d8 g a bes bes a4 g8 f g4 a g r4
          \voiceOne d'8 d d c bes4 f8 f bes (c) d ees c4 \autoBeamOff c8
          a \autoBeamOn bes8. a16 g8 g a4 f8 f g g a bes \noBreak g2
          \bar"|."
        } \cadenzaOn \transpose g bes \tonIIif
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          \partial8 s8 s2*19 s4. f8 g8. d16 d8 ees f4 d8 d ees ees ees ees d2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Quand fut ve -- nu le temps de no -- tre sa -- lut,
      le Pè -- re des lu -- mières a don -- né son Fils,
      et dans son grand a -- mour, il nous a ai -- més
      pour que nous re -- vi -- vions, sau -- vés par le Christ.
      Com -- me la ro -- sée qui des -- cend sur la ter -- re,
      il est né de Ma -- ri -- e, la Mè -- re des vi -- vants.
   }
   \new Staff \with { \consists "Merge_rests_engraver" }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure 
          \partial8 r8 r4 d~ d bes~ bes c d4. r8 r4 d~ d bes~ bes c d
          r4 r d~ d bes~ bes c d4. r8 r4 d~ d bes~ bes c d r4
          s2*3  s4. c8 d8. c16 bes8 bes c4 a8 a bes bes c c d2
        } \cadenzaOn \transpose g bes \tonIIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          \partial8  r8 g2-\markup\italic"b.f." f ees d4. r8 g2 f ees8 d c4 g' r4 
          g2 f ees d4. r8 g2 f ees8 d c4 g' r4 \oneVoice
          R2 \voiceTwo d'8 d d c bes f bes c f, g \autoBeamOff a
          a \autoBeamOn g8. g16 g8 g f4 f8 f ees ees c c g'2
          
        } 
      }
   >>
   \new Lyrics \lyricsto "basse"
   {
      \repeat unfold 20 { \skip2 } 
      Com -- me la ro -- sée qui des -- cend sur la terre,
   }
>>