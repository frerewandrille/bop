\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff  = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo 4 = 96
          a4 e a g (fis) g a (b) c b2 b4 
          a4 e a g2 g4 a (b) c b2.\breathe
          d4. d8 c4 d4. d8 b4 a a fis g2\resp
          e4 a4. g8 fis4 g4. a8 b4 b4. b8 b4 \noBreak a2.\fermata
          \bar "|."
        }\cadenzaOn \tonIIIff
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        {
          c2. b c d c b c d g4. g8 e4 fis4. fis8 g4 e e d d2
          c4 e4. e8 d4 d4. d8 g4 g 
          \override BalloonText.annotation-balloon = ##f 
          <e \balloonText #'(1 . -2)\markup { "" } >
          d c2.
        }          
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" } \lyricsto "soprano"
   { 
     Toi, le buis -- son que vit Mo -- ï -- se 
     et qui ne se con -- su -- mait pas,
     %nous te chan -- tons, Ma -- rie, Mè -- re de Dieu_!
     %Le Verbe é -- ter -- nel brûle en toi comme un feu_!
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano
   { \set associatedVoice = "soprano"
     \once \override Lyrics.LyricText.font-shape = #'italic \once\small b.f.
     \repeat unfold 16 {\skip4}
     nous te chan -- tons, Ma -- rie,
     Mè -- re de Dieu_!
     Le Verbe é -- ter -- nel brûle en
     toi comme un feu_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c
        { \clef "bass" \armure
          e2. e e g e e e g b4. b8 c4 a4. a8 g4 a a a b2
          g4 c4. c8 a4 b4. c8 d4 d 
          \override BalloonText.annotation-balloon = ##f 
          <b \balloonText #'(1 . 2.5)\markup { "" } >
          g e2.
        }\cadenzaOn \tonIIIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          a2. e' a, g a e' a, g\breathe
          g'4. g8 a4 d,4. d8 e4 c c d g2\resp
          c,4 a4. a8 d4 g,4. g8 g4 g g g a2.\fermata
        }
      }
   >>
>>

%{
convert-ly (GNU LilyPond) 2.24.0  convert-ly: Traitement de «  »...
Conversion en cours : 2.19.2, 2.19.7, 2.19.11, 2.19.16, 2.19.22,
2.19.24, 2.19.28, 2.19.29, 2.19.32, 2.19.39, 2.19.40, 2.19.46,
2.19.49, 2.20.0, 2.21.0, 2.21.2, 2.22.0, 2.23.1, 2.23.2, 2.23.3,
2.23.4, 2.23.5, 2.23.6, 2.23.7, 2.23.8, 2.23.9, 2.23.10, 2.23.11,
2.23.12, 2.23.13, 2.23.14, 2.24.0
%}
