\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2 = 72
          d4 d c d bes2. bes4 bes a g2. g4 f2 g d2. \bar"|"
          d4 d d ees2. ees4 f2 g d\resp bes'4 bes a2 a4 a g2 (fis) g1\fermata
          \bar"|."
        } \tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g a a g2. g4 ees ees d2. d4 d (c) bes (c) d2.
          d4 bes bes c2. c4 d (c) bes (c) d2 d4 d ees2 ees4 ees d1 d
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Nous a -- vons pé -- ché con -- tre le ciel et con -- tre toi_!
      Ac -- cueil -- le_- nous dans ta mai -- son, car tu es no -- tre Pè -- re.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 bes d d d2. d4 c c bes2. bes4 a2 g a2.
          a4 g g g2. g4 a2 g a g4 g g2 g4 a bes2 (a) bes1
        } \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g fis fis g2. g4 c, c d2. d4 d2 ees d2.
          d4 g f ees2. ees4 d2 ees d\resp g,4 g c2 c4 c d1 g,\fermata
        } 
      }
   >>
>>

% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \key bes \major \cadenzaOn \tonRIIif }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \key bes \major \cadenzaOn \tonRIIih }
% >>