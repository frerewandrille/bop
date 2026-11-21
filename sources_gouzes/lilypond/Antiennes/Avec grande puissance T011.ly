\version "2.24.0"
%\include "TonsDef.ly"

\transpose e c
\new ChoirStaff %\with { instrumentName = #"1" }
<< \new Staff %\with {\remove Time_signature_engraver } 
   << \new Voice = "soprano" 
      { \voiceOne \relative c'
        { \clef "treble" \key a \major \time 3/8 \omit Score.BarLine  \tempo 4. = 84
          s8 e [e] a [gis a] b ([a b] d [cis a]) b4.\fermata \breathe \allowBreak 
          s8 b [b] b [cis d] e [d cis] b ([cis d]) b2. \revert Score.BarLine.stencil \bar "|" 
          \time 2/4 
          s4 b b^> b b^> b cis2 cis4 cis a2 a4 b b2\fermata \bar "|."
        }
        \cadenzaOn \tonVIIcf
        %\transpose a b \tonVIIbf
      }
      \new Voice = "alto" 
      { \relative c'
        { r8 \voiceTwo e [e] a [gis a] b ([a b] d [cis a]) gis4. 
          \oneVoice r8 \voiceTwo gis [gis] gis [a a] gis [a a] fis4. gis2. 
          \oneVoice r4 \voiceTwo gis gis gis gis gis gis2 gis4 gis fis2 fis4 fis gis2\bar "|."
        }
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      \skip 8 A8 -- vec gran -- de puis -- san2. -- ce,4. \skip 8 les8 A -- pô -- tres ren -- daient té -- moi -- gna4. -- ge2.
      \skip 4 à4 la Ré -- sur -- rec -- tion2 de4 Jé -- sus2 le4 Sei -- gneur.2
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      {  \relative c
        { \clef "bass" \key a \major \cadenzaOn
          r8 \voiceOne e [e] a [gis a] b ([a b] d [cis a]) e'4.
          \oneVoice r8 \voiceOne e [e] e [e b] b [b cis] d4. e2.
          \oneVoice r4 \voiceOne e4 e e e e eis2 eis4 eis cis2 cis4 dis e2
          }
        \cadenzaOn \tonVIIch
        %\transpose a b \tonVIIbh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { s8 e [e] a [gis a] b ([a b] d [cis a]) e4.\fermata \breathe 
          s8 e [e] e [a fis] e [fis e] d ([cis b]) e2.
          s4 e e_> e e_> e cis2 cis4 cis fis 2 fis4 fis e2\fermata
        }
      }
   >>
>>