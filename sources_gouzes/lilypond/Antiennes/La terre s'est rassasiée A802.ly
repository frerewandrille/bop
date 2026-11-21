\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key ees \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose ees d
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme, paisible" 2. = 46
         ees4 d2 (c4) bes2 bes4 aes2 aes4 g2 bes4 c2. (bes2) aes4 g2\resp
         bes4 c2. bes2 (aes4) g2\resp g4 f2 (g4) aes2. g\fermata
         \bar"|."
       } \transpose c bes, \tonVff
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         bes4 bes2 (g4) g2 g4 ees2 d4 ees2 g4 
         ees2 (f4 g f) d ees2
         g4 aes (g f) g2 (f4) g2 ees4 f2 (bes,4) c (aes bes) bes2.
       }    
     }
   >>
   \new Lyrics \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     La ter -- re s’est ras -- sa -- siée du fruit du ciel,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c''
        { \clef "bass" \armure \cadenzaOn
          g4 f2 (ees4) d2 d4 c2 aes4 bes2 bes4 aes2. (g4) 
          \override BalloonText.annotation-balloon = ##f 
          <aes \balloonText #'(1.5 . 3)\markup { "" } >2
          bes
          ees4 ees2. d4 (c d) ees (d) c c (d ees) f (c d) ees2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          ees4 bes'2 (c4) g2 g4 aes2 f4 ees2 ees4 
          aes,2. (ees'2) f4 ees2\resp
          ees4 aes2. bes ees,2 \resp ees4 aes2 (g4) f2. ees\fermata
        } \transpose c bes, \tonVfh
      }
   >>
>>

%{
convert-ly (GNU LilyPond) 2.22.0  convert-ly: Traitement de «  »...
Conversion en cours : 2.19.2, 2.19.7, 2.19.11, 2.19.16, 2.19.22,
2.19.24, 2.19.28, 2.19.29, 2.19.32, 2.19.39, 2.19.40, 2.19.46,
2.19.49, 2.20.0, 2.21.0, 2.21.2, 2.22.0
%}
