\version "2.24.0"

\include "vowel-set.ly"

ss = { \hideNotes a\breve*1/16 \unHideNotes  }
armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     a\breve*1/16\< \ss \ss\hideNotes a\> \unHideNotes \ss a4\! \bar"|"
     f\breve*1/16 \ss \ss \resp \ss f4\< g a\! a g\> f e \noBreak e\! \resp
     e e e e e g g f e f f\bar "|"
     a\breve*1/16 \ss \ss \ss \ss \ss \resp \ss a4\resp
     a\< a bes c2\! bes4 a\> g2\!\resp 
     g\breve*1/16 \ss \ss \ss \ss \ss a4 a\bar"|"
     f\breve*1/16 \ss \ss \ss \ss \ss \resp f4\< f g\! a a g f\> e e\!\resp
     e4 g2 g4  f e f2\bar"|"
     a\breve*1/16 \ss \ss \ss \resp bes4 c c bes a g g\resp 
     g\breve*1/16 \ss \ss \ss \ss \ss a2\bar"|"
     f\breve*1/16 \ss \ss \ss f4 g a2 g4 f e\resp e g g f e f2\bar"|"
     a\breve*1/16 \ss \ss \ss \ss \ss \ss a4 bes c2 bes4 a g2\resp 
     g\breve*1/16 \ss \ss a4\> a\!\bar"|"
     f f f f f f\breve*1/16 \ss \ss \resp
     f4\< g a2\! g4\> f e2\!\resp e4 e g2 f4\> e f2\!\bar"|"
     a\breve*1/16 \ss \ss \ss \ss \ss \ss \ss a4 \resp
     bes c c bes a g2\resp
     g\breve*1/16 \ss \ss \ss \ss g2 g4 g a2 a4\bar"|"
     f\breve*1/16 \ss \ss \ss \ss \resp 
     \ss \ss \ss g4\< a2\! g4 f e2\resp
     e4 e g2 g g4 g f\> e f2\!\bar"|"
     a\breve*1/16 \ss \ss \ss \ss \ss \ss \ss a2 a4 bes c2 bes4 a g2 \resp
     g\breve*1/16 \ss \ss \ss \ss \ss a2\bar"|"
     f\breve*1/16 \ss \ss \ss \ss \ss \ss \ss \ss \ss f4 g a a g f\> e e\!\resp
     e e e g g f e f f\bar"|"
     a\breve*1/16 \ss \ss \ss \ss c4 c\resp bes a g
     g\breve*1/16 \ss a4 a \bar"|"
     f\< f g\! a a g f e2 e4\resp e e e g2 f4\> e f2\!\bar"|"
     a\breve*1/16 \ss bes4 c c bes a g2\resp 
     g\breve*1/16\< \ss \ss \ss g2\! g4\> g a2\!\bar"|"
     g a
   }
   \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "Très vif" 2 = 120
         \override TextScript.outside-staff-priority = #1
         a\breve*1/16 \ss \ss\hideNotes a \unHideNotes \ss a4 \bar"|"
         f\breve*1/16 \ss \ss \resp \ss f4 g a-> a g f e \noBreak e \resp
         e e e e e g-> g f e f-> f\bar "|"
         a\breve*1/16 \ss \ss \ss \ss \ss \resp \ss a4\fermata\resp
         a a bes c2-> bes4 a g2\resp 
         g\breve*1/16 \ss \ss \ss \ss \ss a4-> a\bar"|"
         f\breve*1/16 \ss \ss \ss \ss \ss \resp f4 f-> g a-> a g f e-> e\resp
         e4 g2 g4  f e f2\bar"|"
         a\breve*1/16 \ss \ss \ss \resp bes4 c-> c bes a g-> g\resp 
         g\breve*1/16 \ss \ss \ss \ss \ss a2\bar"|"
         f\breve*1/16 \ss \ss \ss f4 g a2-> g4 f e\resp e g g f e f2\bar"|"
         a\breve*1/16 \ss \ss \ss \ss \ss \ss a4 bes c2-> bes4 a g2\resp 
         g\breve*1/16 \ss \ss a4-> a\bar"|"
         f-- f-- f-- f f f\breve*1/16 \ss \ss \resp
         f4 g a2 g4 f e2\resp e4 e g2 f4 e f2\fermata\bar"|"
         a\breve*1/16 \ss \ss \ss \ss \ss \ss \ss a4 \resp
         bes c-> c bes a g2\resp
         g\breve*1/16 \ss \ss \ss \ss g2 g4 g a2-> a4\fermata\bar"|"
         f\breve*1/16 \ss \ss \ss \ss \resp 
         \ss \ss \ss g4 a2 g4 f e2\resp
         e4 e g2-> g g4 g f e f2\bar"|"
         a\breve*1/16 \ss \ss \ss \ss \ss \ss \ss a2 a4 bes c2-> bes4 a g2 \resp
         g\breve*1/16 \ss \ss \ss \ss \ss a2\bar"|"
         f\breve*1/16 \ss \ss \ss \ss \ss \resp \ss \ss \ss \ss f4 g a-> a g f e e\resp
         e e e g-> g f e f-> f\bar"|"
         a\breve*1/16 \ss \ss \ss \ss c4-> c\resp bes a g->
         g\breve*1/16 \ss a4-> a\fermata \bar"|"
         f f g a-> a g f e2-> e4\resp e e e g2 f4 e f2\bar"|"
         a\breve*1/16 \ss bes4 c c bes-> a g2\resp 
         g\breve*1/16 \ss \ss \ss g2 g4 g a2\fermata\bar"|"
         f4. (g8 a4 g8 [f] e2) f\fermata
         \bar"|." 
         g^\markup\italic"ou bien" a\fermata
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f\breve*1/16 s s s s f4
         d\breve*1/16 s s s d4 e f f e d cis cis cis! cis cis cis cis e e d cis! d d
         f\breve*1/16 s s s s s s f4 f f g a2 g4 f e2 
         e\breve*1/16 s s s s s f4 f
         d\breve*1/16 s s s s s d4 d e f f e d cis! cis cis e2 e4 d cis! d2
         f\breve*1/16 s s s g4 a a g f e e
         e\breve*1/16 s s s s s f2
         d\breve*1/16 s s s d4 e f2 e4 d cis! cis e e d cis! d2
         f\breve*1/16 s s s s s s f4 g a2 g4 f e2
         e\breve*1/16 s s f4 f d d d d d 
         d\breve*1/16 s s d4 e f2 e4 d cis!2 cis!4 cis e2 d4 cis! d2
         f\breve*1/16 s s s s s s s f4 g a a g f e2
         e\breve*1/16 s s s s e2 e4 e f2 f4
         d\breve*1/16 s s s s s s s e4 f2 e4 d cis!2 cis!4 cis e2 e e4 e d cis! d2
         f\breve*1/16 s s s s s s s f2 f4 g a2 g4 f e2
         e\breve*1/16 s s s s s f2
         d\breve*1/16 s s s s s s s s s d4 e f f e d cis! cis cis! cis cis e e d cis! d d
         f\breve*1/16 s s s s a4 a g f e
         e\breve*1/16 s f4 f d d e f f e d cis!2 cis4 cis! cis cis e2 d4 cis! d2
         f\breve*1/16 s g4 a a g f e2
         e\breve*1/16 s s s e2 e4 e f2
         d4. (e8 f4 e8 [d8~] d4 cis!4) d2
         e f
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Je crois en un seul Dieu,
     le Père tout-puissant, créa -- teur du ciel et de la ter -- re,
     de l’u -- ni -- vers vi -- sible et in -- vi -- si -- ble.
     Je crois en un seul Seigneur, Jésus Christ,
     le Fils u -- ni -- que de Dieu, 
     né du Père avant tous les siè -- cles_:
     Il est Dieu, né de Dieu,
     lu -- miè -- re née de la lu -- miè -- re,
     vrai Dieu, né du vrai Dieu,
     Engendré, non pas créé,
     con -- sub -- stan -- tiel au Pè -- re,
     et par lui tout a été fait.
     Pour nous les hommes, et pour no -- tre sa -- lut,
     il des -- cen -- dit du ciel_;
     Par l’Esprit Saint, 
     il a pris chair de la Vier -- ge Ma -- rie,
     et s’est fait hom -- me.
     Cru -- ci -- fié pour nous sous Ponce Pilate,
     il souf -- frit sa pas -- sion et fut mis au tom -- beau.
     Il ressuscita le troisième jour, 
     conformément aux Écri -- tures,
     et il mon -- ta au ciel_; 
     il est assis à la droi -- te du Pè -- re.
     Il reviendra dans la gloire,
     pour juger les vi -- vants et les morts_;
     et son rè -- gne n’au -- ra pas de fin.
     Je crois en l’Esprit Saint,
     qui est Sei -- gneur et qui don -- ne la vie_;
     il procède du Père et du Fils_;
     avec le Père et le Fils,
     il reçoit même a -- do -- ra -- tion et mê -- me gloi -- re_;
     il a par -- lé par les pro -- phè -- tes.
     Je crois en l’Église, une, 
     sain -- te, ca -- tho -- lique et aposto -- li -- que.
     Je re -- con -- nais un seul bap -- tê -- me 
     pour le par -- don des pé -- chés.
     J’attends la ré -- sur -- rec -- tion des morts,
     et la vie du monde à ve -- nir. A -- men. A -- men.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c\breve*1/16 s s s s c4
          a\breve*1/16 s s s a4 a a a bes bes a a a a a a a a a a a a a
          c\breve*1/16 s s s s s s c4 c c c c2 c4 c c2
          c\breve*1/16 s s s s s c4 c
          a\breve*1/16 s s s s s a4 a a a a bes bes a a a a2 a4 a a a2
          c\breve*1/16 s s s c4 c c c c c c
          c\breve*1/16 s s s s s c2
          a\breve*1/16 s s s a4 a a2 bes4 bes a a a a a a a2
          c\breve*1/16 s s s s s s c4 c c2 c4 c c2
          c\breve*1/16 s s c4 c a a a a a
          a\breve*1/16 s s a4 a a2 bes4 bes a2 a4 a a2 a4 a a2
          c\breve*1/16 s s s s s s s c4 c c c c c c2
          c\breve*1/16 s s s s c2 c4 c c2 c4
          a\breve*1/16 s s s s s s s a4 a2 bes4 bes a2 a4 a a2 a a4 a a a a2
          c\breve*1/16 s s s s s s s c2 c4 c c2 c4 c c2
          c\breve*1/16 s s s s s c2
          a\breve*1/16 s s s s s s s s s a4 a a a bes bes a a a a a a a a a a a
          c\breve*1/16 s s s s c4 c c c c
          c\breve*1/16 s c4 c a a a a a bes bes a2 a4 a a a a2 a4 a a2
          c\breve*1/16 s c4 c c c c c2
          c\breve*1/16 s s s c2 c4 c c2
          a2. (bes4 a2) a
          c c
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*1/16 s s s s f4
          d\breve*1/16 s s \resp s d4 d d-> d g g a a \resp a, a a a a a-> a a a d-> d
          f\breve*1/16 s s s s s \resp s f4\fermata\resp
          f f f f2-> f4 f c2\resp
          c\breve*1/16 s s s s s f4-> f
          d\breve*1/16 s s s s s \resp d4 d-> d d-> d g g a-> a\resp
          a, a2 a4 a a d2
          f\breve*1/16 s s s \resp f4 f-> f e f c-> c\resp
          c\breve*1/16 s s s s s f2
          d\breve*1/16 s s s d4 d d2-> g4 g a\resp a, a a a a d2
          f\breve*1/16 s s s s s s f4 f f2-> e4 f c2\resp 
          c\breve*1/16 s s f4-> f d-- d-- d-- d d 
          d\breve*1/16 s s \resp d4 d d2 g4 g a2\resp a4 a a,2 a4 a d2\fermata
          f\breve*1/16 s s s s s s s f4\resp f f-> f e f c2\resp
          c\breve*1/16 s s s s c2 c4 c f2-> f4\fermata
          d\breve*1/16 s s s s \resp s s s d4 d2 g4 g a2\resp a,4 a a2-> a a4 a a a d2
          f\breve*1/16 s s s s s s s f2 f4 f f2-> e4 f c2 \resp
          c\breve*1/16 s s s s s f2
          d\breve*1/16 s s s s s \resp s s s s d4 d d-> d g g a a\resp a, a a a-> a a a d-> d
          f\breve*1/16 s s s s f4 f \resp e f c->
          c\breve*1/16 s f4-> f\fermata d d d d d g g a2-> a4\resp a, a a a2 a4 a d2
          f\breve*1/16 s f4 f f e-> f c2\resp
          c\breve*1/16 s s s c2 c4 c f2\fermata
          d2. (g4 a a,) d2\fermata
          c f\fermata
        } 
      }
   >>
>>