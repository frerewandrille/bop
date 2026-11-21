\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \minor \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2 = 66
         g2 g4 f ees2 ees4\resp ees f g aes2 aes4 (g) f2\fermata\bar"|"
         g4^\markup\italic"libre" aes bes\breve*1/8 ees,4 f g2\bar"|"
         c bes bes2\fermata\resp bes\breve*1/8 aes2 aes4 aes2 aes g\fermata
         \bar"|."
       } \transpose b g \tonVIff %\tonVff
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         ees2 ees4 d c2 c4 c d ees ees2 ees d
         ees4 f g\breve*1/8 \small g4 aes bes2
         \normalsize aes f g g\breve*1/8 f2 f4 f2 f ees
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Com -- me l’a -- veu -- gle, je viens vers toi, Sei -- gneur,
     re -- pen -- "tant, et criant dans une" joie sans fin_:
     Gloire à toi, "lumière qui illu" -- mi -- ne no -- tre nuit_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 bes4 bes g2 g4 g bes bes c2 c4 (bes) bes2
          bes4 bes ees\breve*1/8 bes4 bes ees2
          ees d ees ees\breve*1/8 c2 c4 d2 d bes
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          ees2 ees4 bes c2 c4\resp c bes ees aes,2 aes4 (ees') bes2\fermata
          ees4 ees ees\breve*1/8 ees4 ees ees2
          aes bes ees,\fermata\resp ees\breve*1/8 f2 f4 f2 bes, ees\fermata
        } \transpose b g \tonVIfh
      }
   >>
>>

% \transpose g a
% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRVIef }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRVIeh }
% >>