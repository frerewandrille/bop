\version "2.24.0"

\include "vowel-set.ly"

ss = { \hideNotes bes\breve*1/8 \unHideNotes  }
armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }
rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Très vif" 2 = 120
         \override TextScript.outside-staff-priority = #1
         f4 f f\fermata\resp f e f g g2\fermata\resp
         a\breve*1/8 a2 \allowBreak
         a4 g2 g4 \agauche a\rall^\> f2 (g) g1\fermata\!\bar "|"
         \tempo "Plus calme" g\breve*1/8 \ss \resp
         \ss a4 a f2.\resp \agauche f4\rall^\> g2 f e1\fermata\!\bar "|"
         \tempo "Vif" e4 -- e -- f -- e-- f2\resp
         f4 e f g a2 a4 \allowBreak
         a a g a \agauche bes\rall^\> a2. (g4 f2 g) g1\fermata\!\bar "|"
         \tempo "Plus calme" g4 g a2 a4 a f2 \resp
         f4 f g g g f e2\fermata\bar "|"
         \tempo "Vif" e4 f2 f4-- f-- f-- e-- f-- g-- a2\resp
         a4 a a g a bes a \allowBreak
         a \agauche g\rall^\> f f2 (g) g1\fermata\!\bar "|"
         \tempo "Plus calme" g\breve*1/8 a2 a4 f2 f\resp
         g4 \agauche g\rall^\> g2 f e1\fermata\!\bar "|"
         \oneVoice r4 \voiceOne \tempo "Vif"
         e-- e-- e-- f2. f4 f e f g g2\fermata g2.\fermata\resp
         g4 g \agauche g\rall^\> g f4 e2 e1\fermata\!\bar "|"
         \tempo "Vif"e4-- e-- f-- e f2. \allowBreak
         f4 f e f g g2\fermata g\fermata\resp
         g4 \agauche g\rall^\> g2 f e1\fermata\!\bar "|"
         \tempo "Vif"e4-- e-- f-- e f2\resp f4 e f g a2. \resp
         a4 a g a bes a2. (g4) \allowBreak f2 g g1\fermata\!\bar "|"
         \oneVoice r4 \voiceOne g g g a a f2 \resp
         f4 f g2 g4 \agauche g\rall^\> g f e2\fermata e\fermata\!\bar "|"
         f1*1/2\fermata^\< s\> e1\fermata\!
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 d d d cis d e e2 f\breve*1/8 f2 f4 e2 e4 e d2 (e) e1
         e\breve*1/8 s s e4 e d2. d4 e2 d cis!1
         cis!4 cis d cis! d2 d4 cis! d e f2 f4 f f f f f
         f2. (e4 d2 e) e1
         e4 e e2 e4 e d2 d4 d e e e d cis!2
         cis!4 d2 d4 d d cis! d e f2 f4 f f f f f f f e d d2 (e) e1
         e\breve*1/8 e2 e4 d2 d e4 e e2 d cis!1
         s4 cis! cis cis d2. d4 d cis! d e e2 e2. e4 e e e d cis!2 cis1
         cis!4 cis d cis! d2. d4 d cis! d e e2 e e4 e e2 d cis!1
         cis!4 cis d cis! d2 d4 cis! d e f2. f4 f e f f f2. (e4) d2 e e1
         s4 e e e e e d2 d4 d e2 e4 e e d cis!2 cis d1 a
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Gloire à Dieu, au plus haut des cieux_!_
     "Et paix sur la" terre aux hom -- mes qu’il ai -- me.
     "Nous te lou" -- ons, "nous te" bé -- nis -- sons.
     Nous t’a -- do -- rons, nous te glo -- ri -- fions. 
     Nous te ren -- dons grâ -- ce, pour ton im -- men -- se gloi -- re.
     Sei -- gneur Dieu, Roi du ciel, Dieu le Pè -- re tout_- puis -- sant.
     Sei -- gneur, Fils u -- ni -- que, Jé -- sus Christ.
     Sei -- gneur Dieu, A -- gneau de Dieu, le Fils du Pè -- re.
     "Toi qui enlèves les pé" -- chés du mon -- de, prends pi -- tié de nous.
     Toi qui en -- lè -- ves les pé -- chés du mon -- de, re -- çois no -- tre pri -- è -- re.
     Toi qui es as -- sis à la droi -- te du Pè -- re, prends pi -- tié de nous.
     Car toi seul es saint, toi seul es Sei -- gneur.
     Toi seul es le Très_- Haut, Jé -- sus Christ, 
     A -- vec le Saint_- Es -- prit, dans la gloi -- re de Dieu le Pè -- re.
     A -- men.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a a a a a c c2 c\breve*1/8 c2 c4 c2 c4 a a2 (c) c1
          c\breve*1/8 s s a4 a a2. a4 c2 a a1
          a4 a a a a2 a4 a a c c2 c4 c c bes c d c1 (a2 c) c1
          c4 c a2 a4 a a2 a4 a c c c a a2
          a4 a2 a4 a a a a c c2 c4 c c bes c d c c c a a2 (c) c1
          c\breve*1/8 a2 a4 a2 a c4 c c2 a a1
          s4 a a a a2. a4 a a a c c2 c2.  c4 c c c a a2 a1
          a4 a a a a2. a4 a a a c c2 c c4 c c2 a a1
          a4 a a a a2 a4 a a c c2. c4 c bes c d c1 a2 c c1
          s4 c c c a a a2 a4 a c2 c4 c c a a2 a a (b) cis1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d d\fermata\resp d a d c c2\fermata\resp
          f\breve*1/8 f2 f4 c2 c4 cis d2 (c) c1\fermata
          c\breve*1/8 s \resp s cis4 cis d2.\resp 
          d4 c2 d a1\fermata
          a4-- a-- d-- a-- d2\resp d4 a d c f2 f4 f f f f f 
          f2. (c4 d2 c) c1\fermata
          c4 c cis2 cis4 cis d2\resp d4 d c c c d a2\fermata
          a4 d2 d4-- d-- d-- a-- d-- c-- f2\resp
          f4 f f f f f f f c d d2 (c) c1\fermata
          c\breve*1/8 cis2 cis4 d2 d\resp c4 c c2 d a1\fermata
          \oneVoice r4 \voiceTwo a4-- a-- a-- d2. 
          d4 d a d c c2\fermata c2.\fermata\resp
          c4 c c c d a2 a1\fermata
          a4-- a-- d-- a-- d2. d4 d a d c c2\fermata c\fermata\resp
          c4 c c2 d a1\fermata
          a4-- a-- d-- a-- d2\resp 
          d4 a d c f2. \resp
          f4 f f f f f2. (c4) d2 c c1\fermata
          \oneVoice r4 \voiceTwo  c4 c c cis cis d2 d4 d c2 c4 c c d a2\fermata a\fermata
          d1\fermata a\fermata
        } 
      }
   >>
>>