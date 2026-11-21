\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Doux" 2. = 75
          bes4 bes2. a4-> bes a g2. g2\resp bes4 g2 bes4 a2.\resp
          g2 f4 g2. \allowBreak a4-> bes a g-> g f g2.
          \bar"|."
        } \tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 f2. f4 f f d2. d2 d4 ees2 d4 f2. 
          d2 d4 d2. f4 f f d d d d2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Brû -- lante est ta pa -- ro -- le, Sei -- gneur mon Dieu, 
      c’est pour -- quoi ton ser -- vi -- teur l’a ai -- mée.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d2. c4 d c bes2. bes2 bes4 bes2 bes4 c2.
          bes2 a4 bes2 (c4) c d c bes a a bes2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          bes4 bes2. f'4-> bes, f' g2. g2\resp g4 ees2 g4 f2.\resp
          g2 d4 g2 (a4) f-> bes, f' g-> d d g2.
        } \tonIIah
      }
   >>
>>