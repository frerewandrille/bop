\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         g8 [g] a ([g]) g4.\bar"|" g8 g [fis a] b4.\fermata
         fis8 g [e] d4.\fermata\resp
         g8 g [fis] a [a] b4.\fermata\bar"|"
         b8 b ([a]) a ([g]) g4\fermata
         \bar"|."
       } \tonVIef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d8 [e] e4 d4. d8 e [d e16 (fis)] g4. d8 e [c] d4.
         d8 e [d] e [e16 (fis)] g4. g8 g ([e]) c ([e]) d4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Pour -- quoi cher -- chez_- vous par -- mi les morts
     ce -- lui qui est vi -- vant_? Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b8 [b] c4 b4. b8 b [b c] d4. b16 ([a]) g8 [g] a4.
          b8 b [b] c [c] d4. d8 e ([c]) a ([c]) b4
        } \tonVIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 [e] c ([e]) g4. g8 e [b' a] g4.\fermata
          b,8 c [e] fis4.\fermata \resp g8 e [b'] a [a] g4.\fermata
          g8 g4 g g\fermata
        } 
      }
   >>
>>