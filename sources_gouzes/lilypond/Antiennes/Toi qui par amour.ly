\version "2.24.0"
%\include "TonsDef.ly"

global = {\key d \major \time 2/2}

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \global \cadenzaOn %\tempo "" 2 = 52
          a2. a4 b b fis2. fis4 d2 e fis2. \allowBreak \breathe
           fis4 fis fis e2 e4 e fis2 fis \fermata\allowBreak \breathe
           d' d d4 d cis2 \allowBreak cis4 cis b2 b4 b a2 a \allowBreak \breathe
           a4 a d,2 d4 e fis2\fermata fis\fermata \bar "|."
        }\transpose c a, \tonVcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          fis2. fis4 d e fis d2. d2 b4 (cis) d2. 
          d4 d d b2 cis4 cis d2 d 
          fis fis fis4 fis fis2 fis4 fis d2 d4 e fis2 fis 
          fis4 fis d2 b4 cis d2 d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Toi qui par a -- mour de ton Sei -- gneur as tout quit -- té pour le sui -- vre, 
      re -- çois de ses mains la cou -- ron -- ne de gloi -- re et la vie é -- ter -- nel -- le.
   }
%{     \new Lyrics \lyricmode
   { \set associatedVoice = #"soprano"
      
   }
 %}   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"\with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \global \cadenzaOn
          d2 
          \override BalloonText.annotation-balloon = ##f 
          <cis \balloonText #'(2 . 2.5)\markup { "" } >
          b4 b a2 b b4 (a) g2 a2. 
          a4 a a g2  g4 g b2 b 
          b b b4 b a2 a4 a b2 b4 b d2 d
          d4 d b2 g4 g a2 a
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d2 fis g4 g d2 g g4 (fis) e2 d2.\breathe
          d4 d d e2 e4 e b2 b\fermata\breathe
          b b b4 b fis'2 fis4 fis g2 g4 g d2 d\breathe
          d4d g (fis) e e d2\fermata d\fermata
        } \transpose c a, \tonVch
      }
   >>
>>