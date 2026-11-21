\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \minor \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif" 2 = 80
          bes4 bes-> a bes-> a g2.\resp g4 a-> bes c2 (bes4) a bes2.\fermata\resp
          bes4^\markup{\italic"élargir"} bes2 a bes4 a g2\resp 
          g4-> g a2 a4 a g2 (fis) g1\fermata
          \bar"|."
        } \tonIIef %Pas de ton dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 g g g d d2. d4 f f f2. f4 f2. f4 f2 f f4 d d2 
          d4 d ees2 ees4 ees d1 d
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Mar -- chons tant qu’il fait jour vers le re -- pos de Dieu. 
      Ô Christ, ou -- vre mes yeux_! Ma -- ni -- fes -- te ta gloi -- re_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d c d c bes2. bes4 c d ees2 (d4) c d2. d4 d2 c d4 c bes2
          bes4 bes c2 c4 c bes2 (a) bes1
        } \tonIIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g-> g g-> g g2. g4 f-> bes a2 (bes4) f bes2.\fermata\resp 
          bes4 bes2 f f4 fis g2\resp g4-> g c,2 c4 c d1 <g, g'>\fermata         
        } 
      }
   >>
>>