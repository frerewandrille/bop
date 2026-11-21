\version "2.24.0"
%\include "TonsDef.ly"

global = {\key f \major \time 3/4}

\transpose a fis
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \global \cadenzaOn \tempo "Vif et joyeux" 2. = 66
          \partial4 a4 c-> a d c2 c4 f,2 g4 a2 a4 bes (a) g a2\fermata\breathe
          a4 d-> d d c2. \allowBreak f4-> e d c2 c4 f,2 g4 a2\fermata\breathe
          c4 f,2 g4 a2 a4^\markup{\italic "rallentir"} bes (a) g a2.\fermata
          \bar "|."
        } \tonVIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 f4 e f f8 (g) a2 a4 d,2 e4 f2 f4 g (f) e f2
          f4 f f g a2. g4 a bes a2 g4 d2 e4 f2
          e4 d2 e4 f2 f4 g (f) e f2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Le Christ le Sei -- gneur t’a re -- vê -- tue de sa beau -- té. 
      Le peu -- ple de Dieu fe -- ra mé -- moi -- re de ton nom. 
      Al -- le -- lu -- ia, al -- le -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \global\cadenzaOn
          \partial4 c4 c d d e2 e4 d2 bes4 c2 d4 d2 c4 c2
          d4 d d d e2. d4 d d e2 e4 d (bes) bes c2 
          c4 d2 bes4 c2 d4 d2 c4 c2.
        } \tonVIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial4 f4 a-> d, bes' a2 a4 bes (a) g f (e) d g (a8 bes) c4 f,2\fermata\breathe
          d4 bes'-> bes bes a2. bes4-> bes bes c (bes) a bes (a) g f2\fermata\breathe
          a4 bes (a) g f (e) d g (a8 bes) c4 f,2.\fermata
          
        }
      }
   >>
>>