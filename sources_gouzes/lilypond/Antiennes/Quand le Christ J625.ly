\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 6/4 }
resp = { \breathe\allowBreak }

\transpose g e
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo 2. = 56
          \revert Staff.TimeSignature.style
          \partial2. g2 bes4 a2 g4 a2 bes4 a2. a2 bes4 c2 d4 bes2 a4 g2.\resp
          a2 bes4 c2 bes4 a2 g4 f2.\resp c'2 d4 e4. (d8 e4 d2 cis4) d2.\resp
          d2 d4 c2 a4 bes2 g4 a2.\resp d2 d4 c2 a4 bes4. (a8) g4 a2.\resp
          a2 bes4 c2 (d4 bes a2) \noBreak g2.\fermata
          \bar "|."
        }\cadenzaOn \tonIIhf
      }
      \new Voice = "alto" %\with { \consists "Balloon_engraver" }
      %\override BalloonText.annotation-balloon = ##f 
      %<fis \balloonText #'(2 . -2)\markup { "" } >
      { \voiceTwo \relative c'
        {
          \partial2. d2 g4 f2 d4 f2 g4 fis2. 
          fis2 g4 a2 f!4 d2 d4 bes2 (d4)
          fis2 g4 g2 g4 f2 e4 c2. f2 f4 g2. (f2 e4) fis2. 
          g2 g4 a2 fis4 g2 d4 fis2.
          f2 f4 f2 f4 g2 d4 fis2. f2 g4 a2. (g2 fis4) g2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Quand le Christ no -- tre Sei -- gneur
     se se -- ra ma -- ni -- fes -- té,
     vous se -- rez ma -- ni -- fes -- tés dans sa gloi -- re.
     A -- vec lui vous re -- vi -- vrez,
     a -- vec lui vous ré -- gne -- rez,
     al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          \partial2. bes2 d4 d2 bes4 c (d) bes d2.
          d2 d4 a2 a4 bes8 (a g4) fis g2 (bes4)
          d2 d4 ees2 ees4 c2 c4 a2. a2 a4 c4. (d8 c4 a2.) a
          bes2 d4 f (e) d d2 bes4 d2. bes2 d4 a2 c4 d4. (c8) bes4 d2.
          d2 d4 e2 (a,4 d2.) b
        }\cadenzaOn \tonIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          \partial2. g2 g4 d2 g4 f (d) g d2.
          d2 g4 f2 d4 g (<g, g'>) d' <g, g'>2 (g'4)\resp
          d2 g4 c,2 ees4 f2 c4 f2.\resp f2 d4 c4. (bes8 c4 d2 a4) d2.\resp
          g2 bes4 a2 d,4 g2 g4 d2.\resp bes2 bes'4 f2 a4 g2 <g, g'>4 d'2.\resp
          d2 bes'4 a2 (fis4 g d2) <g, g'>2.\fermata
        }
      }
   >>
>>