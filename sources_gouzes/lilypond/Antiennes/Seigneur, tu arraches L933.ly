\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key d \minor \time 4/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo "Calme" 4 = 84
          a2 g~^\< g4 g8 g a4^\> a8 a f2.\fermata\! \resp 
          f4 d'4. d8 c4 c c1\fermata
          \bar "|."
        }\cadenzaOn \transpose b a \tonVIff
        %\tonVInf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          f2 e~ e4 e8 e e4 e8 e d2. d4 f4. f8 e4 e f1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Sei -- gneur, tu ar -- ra -- ches ma vie 
      aux por -- tes des En -- fers.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          c2 c~ c4 c8 c a4 a8 a a2. a4 bes4. bes8 g4 g a1
        }\cadenzaOn \transpose b a \tonVIfh
        %\tonVInh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          f2 c~ c4 c8 c cis4 cis8 cis d2.\fermata\resp
          d4 bes4. bes8 c4 c f1\fermata
        }
      }
   >>
>>