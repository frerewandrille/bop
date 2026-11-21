\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

silB = { \oneVoice r2 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key c \major \time 2/2 %\cadenzaOn %
          \partial 4 d4 d e f g a2 a4 a d2 c4 b a2. 
          d,4 d e f g a2 a4 a d2 (c4 b) a2.
          a4 a a8 f g4 g8 a f4 (e) d a' a a8 f g4 g8 a f4 (e) d2 \silB
          d4 d a' a b g a2 a d c4 b a2.
          \bar"|."
          \cadenzaOn a\breve c4 \bar"'"\noBreak 
          b\breve c8 b a4 \bar"'"\noBreak a\breve f e8 d4\bar"||"
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { %\cadenzaOn
          \partial 4 d4 d c d e f2 f4 f d2 e4 e e2.
          d4 d c d e f2 f4 f d2 (e) e2.
          d4 d d8 d e4 e8 e d4 (c) d d4 d d8 d e4 e8 e d4 (c) d2 s
          d4 d d d d e f2 f d e4 e cis2.
          \cadenzaOn c\breve e4 e\breve s4 c4 e\breve d c8 d4
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   { 
     Ré -- veil -- le ta vail -- lan -- ce, ô Christ no -- tre Dieu.
     Fais bril -- ler ton vi -- sa -- ge de gloi -- re.
     Qu’e -- xul -- tent de joie tous les peu -- ples.
     Que tou -- te la ter -- re t’ac -- cla -- me_:
     Bé -- ni soit ce -- lui qui vient au nom de Sei -- gneur.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key c \major \time 2/2 %\cadenzaOn
          \partial 4 a4 a a a c c2 c4 c b2 g4 g a2.
          a4 a a a c c2 c4 c b2 (g) a2.
          a4 a a8 a c4 c8 c a2 a4 a4 a a8 a c4 c8 c a2 a \silB
          a4 a a a g b c2 c b g4 g a2.
          %\cadenzaOn e\breve e4 g\breve s4 f4 e\breve d c8 d4
          \cadenzaOn e\breve a4 g\breve s4 f4 a\breve a a8 a4
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { %
          \partial 4 d4 d a d c f2 f4 f g2 c,4 e a,2.
          d4 d a d c f2 f4 f g2 (c,4 e) a,2.
          d4 d d8 d c4 c8 c d4 (a) d d4 d d8 d c4 c8 c d4 (a) d2 s
          d4 d d d g g f2 f g c,4 e <a, e'>2.
          \cadenzaOn a\breve a4 e'\breve s4 f4 c\breve d a8 d4
        }
      }
   >>
>>