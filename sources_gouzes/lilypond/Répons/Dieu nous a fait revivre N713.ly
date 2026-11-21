\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }


\transpose a fis
\new ChoirStaff
<< \new Staff 
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn
         a2 g8 [a] bes2 c4 d4. (c8 bes4) a2.\resp
         a2 g8 [a] bes2 4 c2 (f8) [ees!] d2.\bar".|:"
         d4. c8 bes4 c2 (a4) \resp bes4. a8 g4 a2.\bar":|."
       } 
     }
     \new Voice = "alto" \with { \consists "Balloon_engraver"
                                 \override BalloonText.annotation-balloon = ##f }
     { \voiceTwo \relative c'
       { 
         fis2 e8 [fis] g2 a4 bes2 f4 2. fis2 e!8 [fis!] g2 4 a2 
         <a \balloonText #'(2 . -2.5)\markup { "" } >4 bes2.
         4 <bes \balloonText #'(2 . -2.5)\markup { "" } >4 f8 ([g]) a4. (g8 f4) 
         g4 <g \balloonText #'(2 . -2)\markup { "" } > d8 ([e!]) fis2.
       } \transpose g bes \tonIIcf
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Dieu nous a fait re -- vi -- vre en Jé -- sus Christ res -- sus -- ci -- té,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff 
   << \new Voice = "ténor" \with { \consists "Balloon_engraver"
                                   \override BalloonText.annotation-balloon = ##f }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 8 [8] 2 f!4 4 (ees d) c2. d2 8 [8] 2 4 f!2 
          <f \balloonText #'(2 . 1.5)\markup { "" } >4 2.
          f4 <ees \balloonText #'(2 . 1.5)\markup { "" } > d c2. 
          d4 <c \balloonText #'(2 . 2)\markup { "" } > bes <a d>2.
        } \transpose g bes \tonIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 8 [8] g2 f4 bes2. f \breathe
          d2 d'8 [a] g4 (a) bes f (g) a bes2.
          4 4 4 f (g a)\breathe g4 4 4 d2.          
        } 
      }
   >>
>>