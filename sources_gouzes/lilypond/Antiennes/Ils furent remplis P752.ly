\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }


\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très vif"
         bes4 4-> 4 4 2. c4-> bes a bes2. \allowBreak 
         \silN bes4 4 4-> 4 a g2. bes4-> a g f2. f\resp
         f4-> f f g-> ees g bes2 4 a2.\resp g4-> ees g bes2. g4-> ees g f2.
         \bar"|."
       } \tonVIIIff
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4 4 4 4 2. 4 4 4 2. s4 f4 4 4 4 4 d2. 4 f e c2. c
         d4 d d ees4 4 4 f2 4 2. ees4 c ees d2. ees4 4 4 c2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ils fu -- rent rem -- plis du Saint_- Es -- prit.
     Et voi -- ci qu’ils par -- laient en tou -- tes lan -- gues_:
     ils cé -- lé -- braient les splen -- deurs de Dieu,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 4 4 4 2. ees4 d c d2. \silN d4 4 4 4 c bes2. 4 c bes a2. a
          bes4 4 4 4 4 4 2 4 c2. bes4 aes bes4 2. 4 4 4 a2.
        } \tonVIIIfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes4 4-> 4 4 2. a4-> bes f bes2. s4 bes4 4 4-> 4 f g2. 4-> f c f2. f\resp
          bes,4-> 4 4 ees-> g ees d2 4 f2.\resp g4-> aes g f2. ees4-> g ees f2.
        } 
      }
   >>
>>