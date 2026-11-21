\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         b2 b4-> d b2 a \resp g g4 b g2 fis \resp e e4 d e2.\fermata\resp
         e4 g-> e a-> a fis-> a b2\fermata\bar"|"
         b2. b4 d-> b a2 \resp g b4-> g fis2. \resp
         e4 e-> d e-> e g-> e a-> a fis-> a b1\fermata
         \bar"|."
       } \tonVIef
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         g2 g4 fis g2 fis e e4 d e2 d c b4 b b2. c4 e c d fis d d dis2
          g2. g4 fis g fis2 e d4 e d2. c4 b b b c e c d fis d d dis1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Tu nous fais vi -- vre d’u -- ne seule â -- me et d’un seul cœur 
     al -- lé -- lu -- ia, al -- lé -- lu -- ia,
     nous qui par -- ta -- geons le mê -- me pain, 
     al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2 d4 d e2 d b b4 b c2 b a fis4 fis gis2. a4 b a a a a fis fis2
          d'2. d4 d e d2 b b4 c b2. a4 fis fis gis a b a a a a fis fis1
        } \tonVIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 g4-> b c2 d \resp e, e4 g a2 b \resp a, b4 b e2.\fermata\resp
          a4 e-> a fis-> d fis-> d b2\fermata
          g'2. g4 b-> c d2 \resp e, g4-> a b2. \resp
          a,4 b-> b e-> a e-> a fis-> d fis-> d b1\fermata
        } 
      }
   >>
>>