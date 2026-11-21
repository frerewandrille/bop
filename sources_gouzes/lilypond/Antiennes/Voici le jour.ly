\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          b4^> g a b2 b4 c^> b a b2. \breathe b4^> g a b^> (a8 [b]) c4 b2^> a4 b2. \bar "|"
          g4^> fis g a2 a4 g2 g4 fis2.\fermata\bar "|."
        }\transpose f g \tonVIaf
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c''
        { \cadenzaOn
          g4 d e8 ([fis]) g4 (fis) e8 ([fis]) g4 g e8 ([fis]) g2.
          g4 d e8 ([fis]) g4 (e) g fis (e4.) 
          \override BalloonText.annotation-balloon = ##f 
          <fis \balloonText #'(-1 . -2.5)\markup { "" } >8
          g2.
          d4 d d d2 d4 d2 d4 d2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci le jour que fit le Sei -- gneur, jour d’al -- lé -- gresse et jour de joie_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }

   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 2/2 \cadenzaOn
          d4 b c d2 c8 ([d]) e4 d c d2. 
          d4 b c d (c8 [d]) e4 d 
          \override BalloonText.annotation-balloon = ##f 
          <c \balloonText #'(1.5 . 2.5)\markup { "" } >2
          d2.
          b4 a b c2 c4 b2 b4 a2.
        }\transpose f g \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          g4-> g g g2 g4 c,8-> ([e]) g4 g g2. \breathe
          g4-> g g g2-> c,4 d2-> d4 g2.
          g4-> d d d2 fis4 g2 g4 d2.\fermata
          
        }
      }
   >>
>>