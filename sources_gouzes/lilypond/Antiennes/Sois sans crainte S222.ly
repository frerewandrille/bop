\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo 2. = 56
          a4 (f) e f2 d4 d2 (e4 f8) [e] f4 g a2.\resp
          a2 b4 c2 c4 b!2 b4 a2.\resp
          d2 d4 c2 c4 bes2 c8([bes]) a2\resp
          a4 f2 g4 a2\resp
          a4-- d,2-- c4--  d2.
          \bar"|."
        } \tonIcf
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        { 
          f4 (e) d d2 d4 d2 d4 d2 e4 f2. f2 f4 e2 e4 d2 d4 c2.
          f2 f4 e2 e4 d2 d4 c2 c4 d2 e4 f2 f4 bes, 
          \override BalloonText.annotation-balloon = ##f 
          <a \balloonText #'(1.5 . -1.5)\markup { "" } >2 
          a2.
        }    
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" } \lyricsto "soprano"
   {
      \repeat unfold 4 {\skip4} Fil -- le de Si -- on_!
   }
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = "soprano"
      Sois2 sans4 crain2 -- te,4 Fil2 -- le4 de2 Si4 -- on_!2.
      Le2 Sei4 -- gneur2 est4 a2 -- vec4 toi_!2.
      Tu2 en4 -- fan2 -- te4 -- ras2 un4 fils_:2
      Em4 -- ma2 -- nu4 -- el,2 Dieu4 a2 -- vec4 nous_!2
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 a4 bes2 bes4 a2 a4 bes2 bes4 c2.
          c2 f,4 g2 g4 g2 g4 e2. d2 d4 a'2 a4 f2 f4 f2
          f4 f 
          \override BalloonText.annotation-balloon = ##f 
          <bes \balloonText #'(1 . 2)\markup { "" } >2
            c c4 g 
            <e \balloonText #'(1.5 . 4)\markup { "" }>2 
            f2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 d4 d2 d4 d2 d4 bes2 bes4 f2.\resp
          f'2 d4 c2 c4 g2 g4 a2.\resp
          d2 d4 a2 a4 bes2 bes4 f2\resp
          f4 bes2 g4 f2 \resp f4-- g-- a2-- d2.
        } \tonIch
      }
   >>
>>