\version "2.24.0"
%\include "TonsDef.ly"

\transpose e d
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \time 3/4 \cadenzaOn \tempo 2. = 54
          e4 e2-> e4 d-> e d c-> (b) a b2-> (g4) e2.\fermata \breathe
          \oneVoice r4 \voiceOne e e f-> f f g-> g a e2. \bar "|" \time 2/2 \tempo 2 = 60
         \oneVoice r4 \voiceOne e' e2 e4 e d2. (c4) b2 \breathe 
         b4-> b b-> b c2 c4 c a1 gis\fermata \bar "|."
        }\tonIVbf
        %\tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { \cadenzaOn
          g4 g2 g4 g g g e (g) f f2 (e4) e2. s4 c c c c d e e e e2.
          s4 g g2 g4 g g2. (e4) e2 e4 e e e e2 e4 e f (e d2) e1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   { %\set associatedVoice = #"soprano"
      Jé -- sus vit Pierre et An -- dré son frè -- re 
      qui je -- taient leurs fi -- lets dans la mer_:
      "“Ve" -- nez à ma sui -- te, 
      et je vous fe -- rai pê -- cheurs d’hom -- "mes !”"
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 3/4 \cadenzaOn
          c4 c2 c4 b c b c (e) c d (c b) c2. s4 a a a a a b b b cis2.
          s4 c c2 c4 c b2. (a4) gis2 gis4 gis gis gis a2 a4 a a1 b
        }\tonIVbh
        %\tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          c4 c2-> c4 g'-> c, g' a-> (e) f d2-> (e4) a2.\fermata\breathe
          \oneVoice r4 \voiceTwo a g f-> f f e-> e e <a, a'>2.
          \oneVoice r4 \voiceTwo c c2 c4 c g'2. (a4) e2 \breathe
          e4-> e e-> e a,2 a4 a d2 (f) e1\fermata
        }
      }
   >>
>>