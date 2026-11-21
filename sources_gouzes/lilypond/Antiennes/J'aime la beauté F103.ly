\version "2.24.0"
%\include "TonsDef.ly"


\new ChoirStaff
<< \new Staff 
   << \new Voice = "soprano"
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          a2. a4 b c b2 g a b4 (c) b2 g (e) e2.\fermata \bar "|"
          e4 e2 e4 g a a2 a2. \breathe \allowBreak a4 a2. b4 g a a2\fermata \bar "|."
        }
        \tonIIIdf
        %\tonIIIgf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { \cadenzaOn
          e2. e4 fis fis fis2 e e fis e e1 e2.
          c!4 c2 c4 e g fis2 fis2. fis4 fis2. fis4 e g fis2
        }          
      }
   >>
   \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      J’ai2. -- me4 la beau -- té2 de ta mai -- son, Sei1 -- gneur_!2.
      Je4 veux2 te4 ren -- dre grâ2 -- ce2. au4 cœur2. de4 l’as -- sem -- blée_!2
   }
   \new Staff
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \time 2/2 \cadenzaOn
          c2. c4 d e d (c) b2 c b4 (a) g (a) b2 (cis) cis2.
          a4 a2 a4 b c d2 d2. d4 d2. d4 b c d2
        }
        \tonIIIdh
        %\tonIIIgh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c'
        { \cadenzaOn 
          a2. a4 d, d d2 e4 (d) c2 d e e (a) a2.\fermata
          a4 a2 a4 e e d2 d2. \breathe d4 d2. d4 e e d2\fermata
        }
      }
   >>
>>