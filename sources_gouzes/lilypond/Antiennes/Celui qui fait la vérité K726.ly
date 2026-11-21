\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key d \minor \time 2/2 }
resp = { \breathe\allowBreak }

\transpose a fis {
  \new ChoirStaff
  << \new Staff %\with {\remove Time_signature_engraver }
     << \new Voice = "soprano"
        { \voiceOne \relative c''
          { \clef "treble" \armure \cadenzaOn \tempo "Vif " 2 = 80
            a4 d^> c d2. e4 f^> d d2\fermata\bar"|"\time 3/4 \tempo "Large"
            d2 d4 d2 c4 d2.\fermata d\fermata
            \bar"|."
          } 
        }
        \new Voice = "alto"
        { \voiceTwo \relative c'
          { 
            f4 f a f2. g4 a g f2 f2 f4 e2 e4 fis2. fis
          }    \tonIgf
        }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
     {
       Ce -- lui qui fait la vé -- ri -- té vient à la lu -- miè -- re.
     }
     \new Staff %\with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { \voiceOne \relative c'
          {
            d4 d e d2 (c4) bes c bes a2 a2 a4 a2 a4 a2. a
          } \tonIgh
        }
        \new Voice = "basse"
        { \voiceTwo \relative c
          { \clef "bass" \armure \cadenzaOn
            d4 bes'_> a bes2 (a4) g f_> g d2\fermata
            d2 d4 <a a'>2 q4 d2.\fermata d\fermata          
          } 
        }
     >>
  >>
}