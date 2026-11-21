\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très vif"
         bes4 4-> 4 4 4-> 4 4 c-> bes a bes2.\resp
         4-> 4 a g2. bes4-> a g f2.\resp
         4-> 4 4 g-> ees g bes-> 4 a f2.\resp
         g4-> ees g bes2. g4-> ees g f2.\fermata
         \bar"|."
       } \tonVIIIff
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4 f f f f ees f g f ees f2. d4 ees f ees2. d8 ([ees]) f4 ees c2.
         4 c c8 ([d]) ees4 c ees d d8 ([ees]) f4 d2. ees8 ([d]) c4 c d2. 
         ees4 c ees8 ([d]) c2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci qu’ap -- pa -- ru -- rent des lan -- gues de feu
     qui se po -- saient sur cha -- cun d’eux.
     L’É -- gli -- se chan -- te la gloi -- re de Dieu, 
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d d d d c d ees d c d2. bes4 4 4 2. 4 c bes a2.
          4 bes a bes4 4 4 4 4 c4 2. bes4 4 g bes2. c4 bes4 4 a2.
        } \tonVIIIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          bes4 4-> 4 4 4-> 4 4 4-> 4 4 2.\resp 4-> c d ees2 (f4) g-> f g a2.\resp
          a4-> g f ees-> g8 ([f]) ees4 g-> g f8 ([g]) a2.\resp
          g4-> g8 ([f]) ees ([f]) g2. ees8-> ([f]) g4 ees f2.\fermata
        } 
      }
   >>
>>