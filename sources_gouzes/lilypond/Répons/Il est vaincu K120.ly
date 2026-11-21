\version "2.24.0"

\include "vowel-set.ly"
%\include "TonsDef.ly"

armure = { \key f \minor \time 2/2 }
resp = { \breathe\allowBreak }

\transpose aes g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2 = 120
         aes4 aes-> g aes2. aes4 aes-> g aes-> bes c2 c\resp
         des4-> des des-> des c2 c4 c bes^\markup\italic"élargir" (aes) g (aes) bes2
         \bar"|."
       } \transpose a bes \tonVIIbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f4 f e f2. f4 f e! f g aes2 aes 
         aes4 aes aes aes aes2 aes4 aes g (f) e! (f) g2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Il est vain -- cu, le Prin -- ce de ce mon -- de_: 
     Gloire au Christ vain -- queur qui nous a sau -- vés_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c c c2. c4 c c c ees ees2 ees
          f4 f f f ees2 ees4 ees ees (c) c2 ees
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 f-> c f2. f4 f-> c f-> ees aes2 aes\resp
          des4-> des des-> des aes2 aes4 aes ees (f) c (f) ees2
        }  \transpose a bes \tonVIIbh
      }
   >>
>> 

% \transpose aes g
% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRIIef }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRIIeh }
% >>