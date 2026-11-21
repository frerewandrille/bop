\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose a g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key c \major \time 3/4 \cadenzaOn \tempo "Pesant et lent" 2 = 48
          a4 e'2 e4 d e1\fermata\breathe\allowBreak bes4\rest a4 a2 a4 b c2. a4 a1\fermata\breathe\allowBreak
          a2 a^>^\< a4 a a^>^\> g a2 e1\!\breathe\allowBreak e4 e f2.^> f4 a2 f e1\fermata\bar"|."
        }\tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e4 g2 a4 a gis?1 s4 e f2 f4 f a2. e4 e1 f2 e e4 e d d e2 e1 c4 c c2. d4 e2 d4 (c) b1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Re -- gar -- de, Sei -- gneur_! J’ou -- blie de man -- ger mon pain_!
     La cendre est ma nour -- ri -- tu -- re, et mes lar -- mes, ma bois -- son.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 3/4 \cadenzaOn
          c4 b2 a4 a b1 s4 c d2 d4 d e2. c4 c1 d2 a a4 a b b c2 b1 c4 c a2. a4 c2 a gis1
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4 g2 f4 f e1\fermata\breathe d4\rest a' d,2 d4 d a2. a4 a1\fermata\breathe
          d2 c_> c4 c b_> b a2 e'1\breathe a4 a d,2._> d4 c2 d e1\fermata
        }\tonIIIah
      }
   >>
>>