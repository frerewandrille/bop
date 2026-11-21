\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Dynamics 
   {
     g2^\< g4 g bes2\! bes4 bes c2 c g1  
     g2^\pp^\> g1 g2 g1 fis2 g1\!\bar"|."
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 2/2 \cadenzaOn \tempo "Lent" 2 = 66
          g2 g4 g bes2 bes4 bes c2 c g1\fermata \breathe 
          g2 g1 g2 g1 fis2 g1\fermata\bar"|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { \cadenzaOn
          g2 g4 g g2 g4 g a2 a g1 ees2 d1 d2 d1 d2 d1
        }  \tonIIff        
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
     Que2 cet4 -- te coupe2 en4 ta main,2 Sei -- gneur,1 s’é2 -- loi1 -- gne2
     loin1 de2 moi_!1
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \minor \time 2/2 \cadenzaOn
          ees2 ees4 ees d2 d4 d f2 f ees1 c2 bes1 bes2 a1 a2 bes1
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          c2 c4 c g2 g4 g f2 f c'1\fermata\breathe c2 g1 g2 d1 d2 g1\fermata
        }\tonIIfh
      }
   >>
>>