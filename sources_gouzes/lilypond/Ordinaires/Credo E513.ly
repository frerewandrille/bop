\version "2.24.0"

\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
divisioMaior = {
  \once \override BreathingSign.stencil = #ly:breathing-sign::divisio-maior
  \once \override BreathingSign.Y-offset = #0
  \breathe
}
\defineBarLine "," #'("#ly:breathing-sign::divisio-maior" "" "#ly:breathing-sign::divisio-maior")

\transpose bes a
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "Très vif" 2 = 120
         \override TextScript.outside-staff-priority = #1
         bes\breve*1/8 bes2\resp bes4 g\breve*1/8 a2\divisioMaior\allowBreak
         a\breve*1/8 g4 a bes2 bes \bar "|"
         d\breve*1/8 d2\resp d\breve*1/8 bes2 bes \breve*1/8 c2 \divisioMaior \allowBreak
         c\breve*1/8 c2\resp c\breve*1/8 a\breve*1/8 bes2\bar"||"
         bes\breve*1/8 bes2 bes4 \resp bes\breve*1/8 g2\resp 
         g4 g2 \resp g\breve*1/8 a2\divisioMaior \allowBreak
         a\breve*1/8 g4 a bes2 \bar"|"
         d\breve*1/8 d2\resp d\breve*1/8 bes4 bes c2\divisioMaior \allowBreak
         c4 c a a bes2\bar"||"
         bes\breve*1/8 bes2\resp bes4 g\breve*1/8 a2\divisioMaior \allowBreak
         a\breve*1/8 g4 a bes2\bar"|"
         d\breve*1/8 bes2\resp bes\breve*1/8 c2 c\divisioMaior \allowBreak
         c\breve*1/8 a4 a bes2\bar"|"
         d\breve*1/8 bes2\resp bes\breve*1/8 c2\divisioMaior \allowBreak
         c4 c a2 a4 a bes2 bes \bar"||"
         d4 (c8 [bes] c4 a) bes2\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f\breve*1/8 f2 f4 ees\breve*1/8 f2 f\breve*1/8 f4 f f2 f
         bes\breve*1/8 bes2 bes\breve*1/8 g2 g\breve*1/8 g2 g\breve*1/8 g2 g\breve*1/8 f f2
         f\breve*1/8 f2 f4 f\breve*1/8 ees2 ees4 ees2 ees\breve*1/8 f2 f\breve*1/8 f4 f f2
         bes\breve*1/8 bes2 bes\breve*1/8 g4 g g2 g4 g f f f2
         f\breve*1/8 f2 f4 ees\breve*1/8 f2 f\breve*1/8 f4 f f2
         bes\breve*1/8 g2 g\breve*1/8 g2 g g\breve*1/8 f4 f f2
         bes\breve*1/8 g2 g\breve*1/8 g2 g4 g f2 f4 f f2 f
         bes4 (g g a) f2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     "Je crois en" Dieu, 
     le "Père tout-puis" -- sant, 
     "créateur du ciel et" de la ter -- re. 

     "Et en Jésus" Christ, "son Fils u" -- ni -- "que, notre Sei" -- gneur,
     "qui a été conçu du Saint-Es" -- prit, 
     "est né de la"  "Vierge Ma" -- rie,
     "a souffert sous Ponce-Pi" -- la -- te, "a été cruci" -- fié, 
     est mort "et a été enseve" -- li, 
     "est descendu" aux en -- fers, 
     "le troisième" jour,  "est ressusci" -- té des morts,
     est mon -- té aux cieux, 
     "est assis à la droite de" Dieu le "Père Tout-Puis" -- sant, 
     "d’où il viendra juger les vivants " et les morts. 

     "Je crois en l’Esprit-" -- Saint, 
     "à la Sainte Église catho" -- li -- que, 
     "à la commu" -- nion des saints, 
     "à la rémission des pé" -- chés,_
     "à la résurrection de la" chair, 
     à la vie é -- ter -- nel -- le.
     A -- men.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d\breve*1/8 d2 d4 c\breve*1/8 c2 c\breve*1/8 d4 ees d2 d
          f\breve*1/8 f2 f\breve*1/8 d2 d\breve*1/8 ees2 ees\breve*1/8 ees2 ees\breve*1/8 c d2
          d\breve*1/8 d2 d4 d\breve*1/8 c2 c4 c2 c\breve*1/8 c2 c\breve*1/8 d4 ees d2
          f\breve*1/8 f2 f\breve*1/8 d4 d ees2 ees4 ees c c d2
          d\breve*1/8 d2 d4 c\breve*1/8 c2 c\breve*1/8 d4 ees d2
          f\breve*1/8 d2 d\breve*1/8 ees2 ees c\breve*1/8 c4 c d2
          f\breve*1/8 d2 d\breve*1/8 ees2 ees4 ees c2 c4 c d2 d
          f4 (ees8 [d] ees4 c) d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          bes\breve*1/8 bes2\resp bes4 c\breve*1/8 f2 \divisioMaior f\breve*1/8 <f, f'>4 <f f'> bes2 bes
          d\breve*1/8 d2\resp d\breve*1/8 g2 g\breve*1/8 c,2 \divisioMaior c\breve*1/8 c2\resp c\breve*1/8 f bes,2
          bes\breve*1/8 bes2 bes4\resp bes\breve*1/8 c2\resp c4 c2\resp c\breve*1/8 f2 \divisioMaior 
          f\breve*1/8 <f, f'>4 <f f'> bes2
          d\breve*1/8 d2\resp d\breve*1/8 g4 g c,2 \divisioMaior c4 c f f bes,2
          bes\breve*1/8 bes2\resp bes4 c\breve*1/8 f2 \divisioMaior f\breve*1/8 <f, f'>4 <f f'> bes2
          d\breve*1/8 g2\resp g\breve*1/8 c,2 c \divisioMaior c\breve*1/8 f4 f bes,2
          d\breve*1/8 g2\resp g\breve*1/8 c,2 \divisioMaior c4 c f2 f4 f bes,2 bes
          d4 (ees c f) bes,2\fermata
        } 
      }
   >>
>>