\version "2.24.0"
%\include "TonsDef.ly"

\transpose d b,
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 3/4 \cadenzaOn \tempo "Paisible mais allant"% 2 = 52
          g4-> g a bes2 a4 bes2 d4 a2 a4\breathe\allowBreak 
          d2 f8 ([e]) d4-> (e c) d2.\fermata\bar "|"
          g,4-> g a bes2 a4 bes-> bes d a2\fermata\breathe\allowBreak
          d4 f2 e4 d-> (e) f d2 c4 d2.\fermata\breathe\allowBreak
          d2 f8 ([e]) d4-> (e c) d2.\fermata\bar "|."
        } \transpose a d' \tonIVef
        %\transpose b d' \tonXbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c' 
        { 
          e4 e f g2 f4 g2 e4 f2 f4 
          bes2 g8 ([a]) bes4 (a g) a2.
          %          bes2 g8 [a] bes4 (a g) a2.
          e4 e f g2 f4 g g e f2 bes4 g2 a4 bes (a) g a2 g4 f2.
          bes2 g8 ([a]) bes4 (a g) a2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Dans la fraî -- cheur et la ten -- dres -- se, al -- le -- lu -- ia_!
     Cher -- chons le Bien_- ai -- mé de nos cœurs.
     L’a -- mour est fort com -- me la mort. Al -- le -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 3/4 \cadenzaOn
          bes4-> bes a g2 a4 g2 g4 a2 a4
          d2 d8 ([e]) f4 (e2) f2.
          bes,4-> bes a g2 a4 g-> g g a2 d4 d2 e4 f (e) d e2 e4 d2.
          d2 d8 ([e]) f4 (e2) f2.
        } \transpose a d' \tonIVeh
        %\transpose b d' \tonXbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2._\markup\italic"b.f." ~ d~ d~ d\fermata\breathe
          g2 bes8 ([c]) d4-> (c a) <d, d'>2.\fermata
          d2.~ d~ d~ d2\fermata\breathe
          g4 bes2 c4 d-> (c) bes a2 a4 bes2.\fermata\breathe
          g2 bes8 ([c]) d4-> (c a) <d, d'>2.\fermata
        }
      }
   >>
>>