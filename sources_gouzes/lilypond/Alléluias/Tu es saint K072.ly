\version "2.24.0"

% %\include "TonsDef.ly"
% \include "vowel-set.ly"
% \layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 112
         g8 [a] \bar"|"bes4\fermata g\fermata\resp
         g8 [a] \bar"|"bes4\fermata g\fermata\resp
         g4 \bar"|" g8 [a] bes4\fermata\resp 
         g8 [bes] \bar"|" a2 a \bar"|" \noBreak g\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d8 [fis] g4 d d8 [fis!] g4 d d d8 [fis!] g4 d8 [fis!] g2 fis! d
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu es saint, Dieu_! Tu es saint, fort_!
     Saint, im -- mor -- tel, prends pi -- tié de nous_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes8 [d] d4 bes bes8 [d] d4 bes bes bes8 [d] d4 
          bes8 [d] ees2 d4 (c) bes2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 [d] g4\fermata g\fermata\resp
          g8 [d] g4\fermata g\fermata\resp
          g 4 g8 [d] g4\fermata g8 [g] c,2 d g\fermata
        } 
      }
   >>
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo 4 = 112
         g\breve g4\resp
         g\breve g g4\bar"|" 
         g8 g\breve g g4\resp 
         g8 g\breve fis4\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         bes\breve c4 
         c\breve d ees4 
         ees8 d\breve c bes4
         bes8 ees\breve d4
       }    
     }
   >>
%    \new Lyrics \lyricsto "soprano"
%    {
%      "Dieu, nous nous prosternons devant ta pure i" -- mage,
%      "nous implorons le par" -- "don de nos"  fautes.
%      Ô "Christ, par ta" "croix, sauve-" nous,
%      en -- seigne_- nous_!
%    }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          g\breve g4 
          g\breve g a4 
          a8 bes\breve a g4
          g8 a\breve a4
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          g\breve a4\resp 
          a\breve bes c4 
          c8 d\breve ees d4\resp
          d8 c\breve d4\fermata
        } 
      }
   >>
>>