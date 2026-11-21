\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

global = {\key g \major \time 3/4}


\new ChoirStaff
<< \new Dynamics 
   {
     b4 b b8 [b] a4 a8 [a] g2 
     g4 g8 [g] g [g] fis [g] a2 a 
     a\breve*1/16^\<  a8 a   b c\! ([b]) a^\> [g] a2 g\!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \global \cadenzaOn \tempo "Allant" 2 = 72
          b4 b b8 [b] a4 a8 [a] g2 \breathe\allowBreak
          g4^\markup\italic"accel." g8 [g] g [g] fis [g] a2\espressivo a \breathe\allowBreak
          a\breve*1/16 \hideNotes a8 a \unHideNotes  b c ([b]) a [g] a2 g\fermata\bar"|."
        } \tonVIif % Pas de ton dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { \cadenzaOn
          g4 g g8 [g] fis4 fis8 [fis] e2 
          e4 e8 [e] e [e] dis [e] fis2 fis
          fis\breve*1/16 \hideNotes a8 a \unHideNotes g g4 fis8 [d] e4 (fis) d2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ve -- nez, a -- do -- rons le Sei -- gneur, 
     qui nous ap -- pel -- le des té -- nè -- bres
     à son ad -- mi -- ra -- ble lu -- miè -- re.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \global \cadenzaOn
          d4 d d8 [d] d4 d8 [d] b2 b4 b8 [b] b [b] b [b] d2 d
          d\breve*1/16 \hideNotes a8 a \unHideNotes d e ([d]) c [b] c2 b
        } \tonVIih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          g4 g g8 [g] d4 d8 [d] e2 \breathe 
          e4 e8 [e] e [e] b [e] d2 d \breathe
          d\breve*1/16 \hideNotes a8 a \unHideNotes g' c, ([g']) d [d] d2 g\fermata
        }
      }
   >>
>>