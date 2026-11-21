\version "2.24.0"
%%\include "TonsRDef.ly"

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 2/2 \omit Score.BarLine \tempo "Marcato ; comme un tiento" %2 = 52
          a4^- a^- a^- a^- b2 g \breathe 
          a4-> b8 (c) b4-> a a-> g a2 e\fermata \breathe
          \revert Score.BarLine.stencil \bar  "||" \mark \markup{\musicglyph "scripts.segno"}
          e4-> \omit Score.BarLine e e-> fis d2 (g8 fis e4) e2 d4 e2\fermata
          \revert Score.BarLine.stencil \bar "|."
        }\cadenzaOn \tonRIVcf\mark \markup{al \musicglyph "scripts.segno"}
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        {
          e4 e e fis g4. (fis8) e2 e4 e fis fis e e e2 c 
          b4 b c c b1 c4 
          \override BalloonText.annotation-balloon = ##f 
          <b \balloonText #'(1 . -1)\markup { "" } >2
          b
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto soprano
   {
      Je sais un -- e sour -- ce qui jail -- lit et qui s’é -- cou -- le,
      Mais c’est au pro -- fond de la nuit.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 2/2
          c4 c c c b2 e4. (d8) c4 b8 (a) d4 c b b c4. (b8) a2
          g4 g a a fis2 (e8 fis g4) a 
          \override BalloonText.annotation-balloon = ##f 
          <fis \balloonText #'(2 . 3)\markup { "" } >2
          gis
        }\cadenzaOn \tonRIVch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          a4_- a_- a_- a_- e2 e \breathe a4-> a d,-> d e-> e a,2 a\fermata\breathe
          e'4-> e a,-> a b2. e4 a, b2 e\fermata
        }
      }
   >>
>>