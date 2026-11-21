\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très vif"
         bes4 4 2. r4 bes4 4 4-> 4 4 c-> bes a bes2.\resp
         r4 bes a g2. bes4-> a g f2.\resp 
         r2 f4 f-> f f g2. \allowBreak ees4-> g bes a2.\resp
         g4-> ees g bes2. \allowBreak g4-> ees g f2.\fermata
         \bar"|."
       } \tonVIIIff
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4 f f2. r4 f f f f f f f f f2. r4 f4 4 d2. 4 f e c2.
         r2 c4 d d d ees2. 4 4 f f2. ees4 c ees d2. ees4 4 4 c2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tout à coup é -- cla -- ta dans le ciel un grand bruit,
     plus vio -- lent que l'ou -- ra -- gan.
     Ils fu -- rent rem -- plis du Saint_- Es -- prit,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d d2. r4 d d d d d ees d c d2. r4 d c bes2. 4 c bes a2.
          r2 a4 bes4 4 4 2. 4 4 4 c2. bes4 aes bes4 2. 4 4 4 a2.
        } \tonVIIIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes4 4 2. r4 bes4 4 4-> 4 4 a-> bes f bes2.\resp
          r4 bes f g2. 4-> f c f2.\resp
          r2 f4 bes,-> 4 4 ees2. g4-> ees d f2.\resp
          g4-> aes g f2. ees4-> g ees f2.\fermata
        } 
      }
   >>
>>