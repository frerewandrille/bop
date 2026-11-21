\version "2.24.0"

%\include "TonsDef.ly"
\include "TonsDef.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "staff" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Mystérieux"% 2 = 52
         d2 a4 c2 b4 a (d) a c2 (b4) a2\fermata\resp
         a4 c2^\markup\italic"large" c4 c c c a2. a4 a a a2. a2 g4 a2.\fermata\bar"|"
         c2 c4 a2 a4 a (g) a c2 c4 a2 a4 a2 g4 a1.\fermata
         \bar"|."
       } \tonIVgf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f2.e f e f2 e4 dis2 dis4 e e e dis!2. 
         dis4 dis dis dis2. e2 e4 e2.
         e2. fis1. e2. fis! e e1.
       }    
     }
   >>
   \new Lyrics \with { alignAboveContext = "staff" }
   \lyricsto "soprano"
   {
     Sous l’au -- tel, je vis les â -- mes 
     \repeat unfold 14 { \skip2 }
     Vois, Sei -- gneur, le sang de tes en -- fants
     ver -- sé pour toi.
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "alto"
   {
     \once \override Lyrics.LyricText.font-shape = #'italic \once\small b.f.
     \repeat unfold 4 { \skip2 }
     de ceux qui fu -- rent tu -- és pour la Pa -- ro -- le de Dieu.
     \once \override Lyrics.LyricText.font-shape = #'italic \once\small b.f.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2. a d a d2 c4 c2 c4 c c c c2. c4 c c a2. b2 b4 cis2.
          a d1. a2. d b cis!1.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          <d d'>2. <a a'> <d d'> <a a'> <d d'>2\fermata\resp
          a'4 aes2 aes4 g g g fis2. fis4 fis fis fis2. e2 e4 a,2.\fermata
          a' d,1. a'2. d, e a,1.
        } \tonIVgh
      }
   >>
>>