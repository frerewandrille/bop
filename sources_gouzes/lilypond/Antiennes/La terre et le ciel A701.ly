\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 4/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo 4 = 100
          \partial 2 d4. d8 d4. d8 ees4 ees d4. 
          d8 d4 c bes2 (a) g
          \silN bes4^\markup{\dynamic p \italic "subito"} 
          d c bes ees d d2. r1 r  r2 r4 \omit Score.TimeSignature
          bes^\markup{\dynamic f \italic"large"} \time 6/4 d c 
          bes ees d c \time 4/4 bes2 (a) \noBreak g\fermata
          \bar "|."
        }\cadenzaOn \transpose g bes \tonIIcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4. g8 g4. g8 g4 g g4. a8 bes (g4) fis8 g2. (fis4) g2
          s4 g bes a g c bes g g g g g g (fis g2. fis4) g2.
          g4 g fis g g fis g g2. (fis4) g2
        }          
      }
   >>
   \new Lyrics \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     La terre et le ciel te chantent et ren -- dent gloi -- re.
     Et ton peu -- ple s’a -- van -- ce à la clar -- té de ton vi -- sa -- ge.
   }
   \new Lyrics \lyricsto alto 
   { 
     \repeat unfold 18 \skip4 Et ton peu -- ple s’a -- van -- ce %à la clar -- té de ton vi -- sa -- ge.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne 
        \set Staff.beamExceptions = #'()
        \set Staff.baseMoment = #(ly:make-moment 1/4)
        \set Staff.beatStructure = 1,1,1,1
        \relative c'
        { \clef "bass" \armure
          bes4. bes8 bes4. bes8 c4 g8 (a) bes (c d) 
          d d4 d d2 (ees4 d) d2 s2 s1 s4 
          bes d c bes ees d (c bes2 a) g2.
          d'4 g, c d c a g8 (a) bes4 (c d2) d
        }\cadenzaOn \transpose g bes \tonIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g4. g8 g4. g8 c, (d) ees (f) g (a bes) c d4 d,
          g (bes c d) g,2 \oneVoice r2 r1 r4 \voiceTwo
          g bes a g c bes (a g2 d) g,2. \breathe
          g4 bes a g c d ees d1 g2\fermata
        }
      }
   >>
>>