\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "Très vif" 2 = 120
         bes4. bes8 g4 g8 [g] a4 a bes2\resp
         ees4 ees8 [d] c4 c8\resp bes a4 g8 [a] bes2 bes\fermata\bar"||"
         bes\breve*1/8 a8 [bes] c2\resp
         c8 c [bes] a2\bar"|"
         d\breve*1/8 d2 d\resp
         d\breve*1/8 c8 [bes] < a %\footnote #'(1 . 3) 
         %"do dans la première édition, ainsi qu’aux occurences successives" 
         \parenthesize c >4 (bes) bes2\fermata\bar"||"
         bes\breve*1/8 a8 [bes] c2\resp
         c\breve*1/8 bes8 a2\bar"|"
         d\breve*1/8 c8 [bes] < a \parenthesize c >2 bes8 bes2\fermata\bar"||"
         bes\breve*1/8 a8 [bes] c2\resp
         c8 c [bes] a2 a\bar"|"
         d\breve*1/8 d2 d\resp
         c8 [bes] < a \parenthesize c >2 bes8 bes2\fermata\bar"||"
         bes\breve*1/8 a8 [bes] c2 c\resp
         c\breve*1/8 bes8 a2 a\bar"|"
         d\breve*1/8 d2 d\resp
         c8 [bes] < a \parenthesize c >2 bes8 bes2\fermata\bar"||"
         bes\breve*1/8 a8 [bes] c2\resp
         c\breve*1/8 c4 c8 [bes] a2\bar"|"
         d\breve*1/8 d2 \resp
         d\breve*1/8 d2 d8 [d] c8 [bes] < a \parenthesize c >2 q\resp
         bes2*1/2^\< s\> bes1\!\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f4. f8 ees4 ees8 [ees] f4 f f2
         g4 bes8 [g] g4 g8 f f4 f8 [f] f2 f
         f\breve*1/8 f8 [f] g2
         g8 g [f] f2
         bes\breve*1/8 bes2 bes
         bes\breve*1/8 g8 [g] f2 f2
         f\breve*1/8 f8 [f] g2
         g\breve*1/8 g8 f2
         bes\breve*1/8 g8 [g] a2 f8 f2
         f\breve*1/8 f8 [f] g2
         g8 g [f] f2 f
         bes\breve*1/8 bes2 bes
         g8 [g] f2 f8 f2
         f\breve*1/8 f8 [f] g2 g
         g\breve*1/8 g8 f2 f
         bes\breve*1/8 bes2 bes
         g8 [g] f2 f8 f2
         f\breve*1/8 f8 [f] g2
         g\breve*1/8 g4 g8 [g] f2
         bes\breve*1/8 bes2 
         bes\breve*1/8 bes2 bes8 [bes] g8 [g] f2 f
         f2 f1
       } 
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Gloire à Dieu, au plus haut des cieux_! 
     Et paix sur la terre aux hom -- mes qu’il ai -- me.
     "Nous te louons, nous te" bé -- nis -- sons, nous t’a -- do -- rons. 
     "Nous te glorifions,  nous te rendons" grâ -- ce, "pour ton im" -- men -- se gloi -- re.
     "Seigneur Dieu," Roi du ciel, "Dieu le Père tout -" puis -- sant.
     "Seigneur, Fils u" -- ni -- que, Jé -- sus Christ.
     "Seigneur Dieu, A" -- gneau de Dieu, le Fils du Pè -- re.
     "Toi qui enlèves les péchés du" mon -- de, prends pi -- tié de nous.
     "Toi qui enlèves les pé" -- chés du mon -- de, "reçois notre" pri -- è -- re.
     "Toi qui es assis à la droite du" Pè -- re, prends pi -- tié de nous.
     "Car toi seul es saint, toi seul" es Sei -- gneur.
     "Toi seul es le Très_-" Haut, Jé -- sus Christ, 
     "Avec le Saint-Es" -- prit, "dans la" gloi -- re de Dieu le Pè -- re.
     A -- men.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4. d8 ees4 ees8 [d] c4 f d2
          g4 g8 [f] ees4 ees8 d c4 d8 [ees] d2 d
          d\breve*1/8 c8 [d] ees2
          ees8 ees [d] c2
          f\breve*1/8 f2 f
          f\breve*1/8 ees8 [d] c4 (d) d2
          d\breve*1/8 c8 [d] ees2
          ees\breve*1/8 d8 c2
          f\breve*1/8 ees8 [d] c2 d8 d2
          d\breve*1/8 c8 [d] ees2
          ees8 ees [d] c2 c
          f\breve*1/8 f2 f
          ees8 [d] c2 d8 d2
          d\breve*1/8 c8 [d] ees2 ees
          ees\breve*1/8 d8 c2 c
          f\breve*1/8 f2 f
          ees8 [d] c2 d8 d2
          d\breve*1/8 c8 [d] ees2
          ees\breve*1/8 ees4 ees8 [d] c2
          f\breve*1/8 f2 
          f\breve*1/8 f2 f8 [f] ees8 [d] c2 c
          d2 d1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          bes8 ([c d]) bes c ([d]) ees [c] f ([<f, ees'>]) <g d'> ([<a c>]) bes2\resp
          ees8 ([f]) g [ees] c ([d]) ees\resp
          %\set doubleSlurs = ##t 
          c f ([ees]) <f,~ d'> ^([<f c'>]) bes2 bes\fermata
          %\set doubleSlurs = ##f 
          bes\breve*1/8 f'8 [d] c2\resp
          c8 c [c] f2
          d\breve*1/8 d2 d\resp
          d\breve*1/8 ees8 [ees] f4 (bes,) bes2\fermata
          bes\breve*1/8 f'8 [d] c2\resp
          c\breve*1/8 c8 f2
          d\breve*1/8 ees8 [ees] f2 bes,8 bes2\fermata
          bes\breve*1/8 f'8 [d] c2\resp
          c8 c [c] f2 f
          d\breve*1/8 d2 d\resp
          ees8 [ees] f2 bes,8 bes2\fermata
          bes\breve*1/8 f'8 [d] c2 c\resp
          c\breve*1/8 c8 f2 f
          d\breve*1/8 d2 d\resp
          ees8 [ees] f2 bes8 bes2\fermata
          bes\breve*1/8 f8 [d] c2\resp
          c\breve*1/8 c4 c8 [c] f2
          d\breve*1/8 d2 \resp
          d\breve*1/8 d2 d8 [d] ees8 [ees] f2 f\resp
          bes,2 bes1\fermata
        } 
      }
   >>
>>