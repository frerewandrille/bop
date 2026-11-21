\version "2.24.0"
%\include "TonsDef.ly"

silB = { \oneVoice r2 \voiceOne }

\transpose e d
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key g \major \time 3/4 %\omit Score.BarLine \tempo "" 2 = 52
          \partial 4 e4 b' b d cis2 cis4 b2 b4 e,2\breathe
          e8 (fis) g2 (a4) g2 (fis4) e2. \silB
          e4 b' b d cis2 cis4 b2 b4 e,2\breathe 
          e8 (fis) g2 (a4) g2 (fis4) e2. \silB
          e4 e'2 e4 d2 d4 b2 b4 e,2 \breathe 
          e4 c'2 c4 b2 e,4 g2 (e4) e2
          e8 (fis) g2 (b8 a) g2 (fis4) \noBreak e2.
          \bar "|."
        }\cadenzaOn \transpose a b \tonIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial 4 e4 e e e e2 e4 e2 e4 e2 e4 e2. e2 (d4) b2. s2
          e4 e e e e2 e4 e2 e4 e2 e4 e2. e2 (d4) b2. s2
          e4 g2 g4 fis2 fis4 g2 g4 e2 e4 dis2 dis4 dis2 e4 e2. b!2
          e4 e2. e2 (d4) b2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano
   { %\set associatedVoice = #"soprano"
      Voi -- ci qu’il se lève à l’O -- ri -- ent, al -- lé -- lu -- ia,
      Jé -- sus le sau -- veur, So -- leil le -- vant, al -- lé -- lu -- ia,
      et sa lu -- mière a res -- plen -- di au sein de nos té -- nè -- bres, al -- lé -- lu -- ia.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \key g \major
          e4 g g g a2 a4 b2 b4 cis2 cis4 b2 (cis4) b (a2) g2. \silB
          e4 g g g a2 a4 b2 b4 cis2 cis4 b2 (cis4) b (a2) g2. \silB
          e4 c'!2 c4 a2 a4 b2 b4 c2 c4 a2 a4 a2 g4 bes2 (g4) g2 a4 b2 (c4) b (a2) g2.
        }\cadenzaOn \transpose a b \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial 4 e4 e e e fis2 fis4 g2 g4 a2 \breathe 
          a4 e2. b e s2
          e4 e e e fis2 fis4 g2 g4 a2 \breathe a4 e2. b e s2
          e4 c2 c4 d2 d4 e2 e4 g2 \breathe 
          g4 fis2 fis4 b,2 c4 c2. e2 \breathe
          c4 b2 (a4) b2. e
        }
      }
   >>
>>