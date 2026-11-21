\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Paisible"% 2 = 52
         g4 g f2 g\fermata\resp g4 g f2 g\fermata\resp
         bes bes4 a a2\fermata\resp bes4 a g2 f g1\fermata
         \bar"|."
       } \tonIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 e d2 d d4 e! d2 d f f4 f f2 f4 f d (e!) d2 d1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu es saint, Dieu_! Tu es saint, fort_!
     Saint im -- mor -- tel, prends pi -- tié de nous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 c a2 bes bes4 c a2 bes d d4 c c2 
          d4 c bes (c) a2 bes1
        } \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 c, d2 g\fermata\resp g4 c, d2 g\fermata\resp
          bes, bes4 f' f2\fermata\resp
          bes,4 f' g (c,) d2 g1\fermata
        } 
      }
   >>
>>% 
% 
% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRIIaf }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRIIah }
% >>