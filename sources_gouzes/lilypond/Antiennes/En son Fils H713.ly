\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \tempo "Vif"% 2. = 50
          \revert Staff.TimeSignature.style
          f2 g4 a2 a4 a4. bes8 c [a] bes2 g4
          g2 g4 g2 g4 g4. (a8) bes ([g]) a2 f4
          f2 g4 a2 a4 a4. (bes8) c [a] bes2 g4
          g4. a8 bes [g] a4. g8 f4 e4. d8 e4 \noBreak f2 f4
          \bar "|."
        }\cadenzaOn \tonVIaf
      }
      \new Voice = "alto"\with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        {
          f2 e4 f2 f4 f4. f8 e [e] g2 e4
          d2 d4 e2 e4 e 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(2.5 . -2)\markup { "" } >2
          f d4
          c2 e4 f2 f4 f2 e8 e g2 e4 
          e4. e8 d [d] f4. f8 c4 c4. d8 c4 a2 a4
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      En son Fils, Dieu nous a fait con -- naî -- tre
      son sa -- lut et sa pro -- mes -- se_;_
      et jus -- \apostrophe qu’aux loin -- tains de la ter -- re,
      il a ré -- vé -- lé son a -- mour à son peu -- ple.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"\with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          a2 c4 c2 c4 c4. c8 c [c] d2 c4 
          bes2 bes4 c2 c4 c 
          \override BalloonText.annotation-balloon = ##f 
          <bes \balloonText #'(2.5 . 2)\markup { "" } >2
           c bes4
          a2 c4 c2 c4 c2 c8 c d2 c4
          c4. c8 bes [bes] c4. bes8 a4 g4. g8 g4 f2 f4
        }\cadenzaOn \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          f2 c4 f2 f4 f4. g8 a [a] g2 c,4
          g'2 g4 c,2 c4 c g'2 f bes,4
          f'2 c4 f2 f4 f4. (g8) a [a] g2 c,4
          c4. c8 g' [g] f4. f8 f4 c4. bes8 c4 f,2 f4
        }
      }
   >>
>>