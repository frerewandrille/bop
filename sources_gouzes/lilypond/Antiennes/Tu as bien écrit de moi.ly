\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< 
  \new Staff = "femmes" \with {\remove Time_signature_engraver }
  << %\accidentalStyle neo-modern-voice
    \new Voice = "soprano"
    { \voiceOne \relative c'
      { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
        d8 [d] e4-> e f-> g g\fermata\resp g a-> a bes-> c a2\fermata\bar"|"
        d4. (c8) bes-> ([a]) g ([f]) g4 a4.->\resp
        g8 (f-> [e] d4) e2 d\fermata
        \bar"|."
      } \tonIbf
    }
    \new Voice = "alto" \with { \consists "Balloon_engraver" }
    { \voiceTwo \relative c'
      { 
        d8 [d] c4 c d e e e f f g e f2 f f4 e8 ([d]) e4 f4.
        e8 (d [c] d2) 
        \override BalloonText.annotation-balloon = ##f 
        <cis \balloonText #'(-1.5 . -2)\markup { "" } >4
        d2
      }    
    }
  >>
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "soprano"
  {
    Tu as bien é -- crit de moi_!
    Que veux_- tu en re -- tour_?
    Rien d’au -- tre que toi, ô mon Dieu_!
  }
  \new Staff = "hommes" \with {\remove Time_signature_engraver }
  << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
     { %\accidentalStyle neo-modern-voice
       \voiceOne \relative c'
       { \clef "bass" \armure \cadenzaOn
         a8 [a] a4 a a c c c c d d c c2
         bes4. (c8) d4 c8 ([bes]) c4 c 
         \override BalloonText.annotation-balloon = ##f 
         <d \balloonText #'(1.5 . 2)\markup { "" } >
         (a g) a2 a
       } \tonIbh
     }
     \new Voice = "basse"
     { \voiceTwo \relative c
       { 
         d8 [d] a4-> a d-> c c\fermata\resp c f-> d g-> c, f2\fermata
         bes,4. (a8) bes4-> c8 ([d]) c4 f->\resp
         d4. (a8 bes4) a2 d\fermata
       } 
     }
  >>
>>