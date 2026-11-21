 \version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 3/4 \cadenzaOn \tempo "Libre" 2 = 72
          bes4 bes^> bes bes^> a g2 f\fermata\breathe\allowBreak f4 f g2 g4 g f (d) d2\fermata\bar"|"
          d\breve*1/8 f2 f4 f g (a) a2 \breathe\allowBreak g4 g a2 bes4 a g (a) a2.\fermata\bar"|"
          a4 a^> a bes (a) g2\fermata\breathe\allowBreak g\breve*1/8 f4 g (a) a2\fermata\bar"|."
        }\tonVIIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 f f f f d (ees) d2 d4 d c2 c4 c d2 d
          d\breve*1/8 d2 d4 d d (f) f2 d4 d f2 f4 f d (f) f2.
          f4 f f f2 d d\breve*1/8 d4 d (f) f2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Je suis sor -- ti du Pè -- re et ve -- nu dans le mon -- de._
      "Maintenant, je" quit -- te le mon -- de et je vais vers le Pè -- re._
      Gar -- dez cou -- ra -- ge_:_ "J’ai vaincu" le mon -- de_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 3/4 \cadenzaOn
          d4 d d d c bes (c) a2 a4 a g2 g4 g a2 bes
          bes\breve*1/8 a2 a4 a bes (c) c2 bes4 bes c2 d4 c bes (c) c2.
          c4 c c d (c) bes2 bes\breve*1/8 a4 bes (c) c2
        }\tonVIIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes4 bes_> bes bes_> f g (c,) d2\breathe d4 d ees2 ees4 ees d2 g\fermata
          g\breve*1/8 d2 d4 d g (f) f2\breathe g4 g f2 bes4 f g (f) f2.\fermata
          f4 f_> f bes, (f') g2\fermata\breathe 
          g\breve*1/8 d4 g (f) f2\fermata
        }
      }
   >>
>>