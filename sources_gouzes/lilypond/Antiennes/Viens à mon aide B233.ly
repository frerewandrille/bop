\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\new ChoirStaff
<< \new Dynamics 
   {
     a\breve*1/16\< a4 (g8 [a]\! b4\> c8 [b]) b4.\! \allowBreak b8 c ([b16 a] b4.) g8 a4 g8 ([f]) e2\bar "|."
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c\major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          a\breve*1/16 a4 (g8 [a] b4 c8 [b]) b4. \allowBreak b8 c ([b16 a] b4.) g8 a4 g8 ([f]) e2\fermata\bar "|."
        }\tonIVaf
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        { \cadenzaOn
          e\breve*1/16 e2 (g) g4. g8 g4. (f8) 
          \override BalloonText.annotation-balloon = ##f 
          < e \balloonText #'(1.5 . -2)\markup { "" } >4
          d d e2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     "Viens à mon" ai -- de_!_ J’ai soif de ton sa -- lut_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \key c\major \time 2/2 \cadenzaOn
          c\breve*1/16 c4 (b8 [c] d4 e8 [d]) d4. d8 e8 ([d16 c] d4) 
          \override BalloonText.annotation-balloon = ##f 
          < b \balloonText #'(1.5 . 3.5)\markup { "" } >
          c a b2
        }\tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          a\breve*1/16 a2 (g) g4. g8 g2 g4 f f e2\fermata
        }
      }
   >>
>>