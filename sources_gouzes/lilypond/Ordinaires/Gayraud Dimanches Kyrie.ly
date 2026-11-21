\version "2.24.0"

\include "vowel-set.ly"

armure = { \key g \major \time 4/4 }
resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata


\new Staff \with {\remove Time_signature_engraver }
<<
  \new Voice = "soprano"
  { \relative c''
    { \clef "treble" \armure \cadenzaOn % \tempo  2 = 96
      \slurDashed
      a\breve*1/8 (g8) a2\resp a\breve*1/8 \allowBreak b g2 \resp
      g4 g e d e2\fermata
      \bar"||"
    } 
  }
  \new Lyrics \lyricsto "soprano"
  {
    \im Seigneur Jé -- sus,
    "envoyé pour guérir les cœurs qui re" -- 
    "viennent vers" toi_:
    Sei -- gneur prends pi -- tié_!
  }
  \new Lyrics \lyricsto "soprano"
  {
    Ô Christ, "venu appe" -- "ler les pé" -- cheurs_:
    Ô Christ, prends pi -- tié_!
  }
  \new Lyrics \lyricsto "soprano"
  {
    \im Seigneur Jé -- sus,
    "qui sièges à la droite du Père, où tu inter" -- 
    "cèdes pour" nous_:
    Sei -- gneur prends pi -- tié_!
  }
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligner"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn % \tempo  2 = 96
         e4 fis g g g fis g2 \bar"|" 
         g4 g a a b a g2 \bar"|" 
         e4 fis g g fis2 e fis\fermata
         \bar"|."
       } 
     }
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn % \tempo  2 = 96
         \slurDashed
         e4 \(fis\) g g g fis g2 \bar"|" 
         g4 \(g\) a a b a g2 \bar"|" 
         e4 \(fis\) g g fis2 e fis\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { \slurDashed
         e4 \(e\) e e e e e2 e4 \(e\) e e e e e2 b4 \(d\) d d d2 b d
       }    
     }
   >>
   \new Lyrics \lyricsto "soprano"
   {
     Ky -- ri -- e e -- le -- i -- son, 
     Ky -- ri -- e e -- le -- i -- son, 
     Ky -- ri -- e e -- le -- i -- son_!
   }
   \new Lyrics \lyricsto "soprano"
   {
     Chri -- \skip 4 ste e -- le -- i -- son, 
     Chri -- \skip 4 ste e -- le -- i -- son, 
     Chri -- \skip 4 ste e -- le -- i -- son_!
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ky -- ri -- e e -- le -- i -- son, 
     Ky -- ri -- e e -- le -- i -- son, 
     Ky -- ri -- e e -- le -- i -- son_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \slurDashed
          g4 \(a\) b b b a b2 b4 \(b\) c c d c b2 g4 \(a\) b b a2 g a
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \slurDashed
          e4 \(e\) e e e e e2 e4 \(e\) a, a a a e'2 e4 \(d\) g, g d'2 e d\fermata
        } 
      }
   >>
>>