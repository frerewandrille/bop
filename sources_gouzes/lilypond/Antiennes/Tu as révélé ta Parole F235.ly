\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo  2 = 75
          d2 d4-> d f-> f d-> d g2 g4 bes a2\resp
          a4-> a a4-> a d-> d c-> c a2 (bes) a
          \bar"|."
        } \tonIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d2 d4 d d d d d e2 e4 g e2 e4 e f f f f g g fis2 (g) fis!
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Tu as ré -- vé -- lé ta Pa -- ro -- le, Sei -- gneur,
      pour il -- lu -- mi -- ner le cœur des pau -- vres.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a2 bes4 bes a a bes bes c2 c4 d cis2 
          cis!4 cis d d d d e e d1 d2
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 g4-> g d-> d g-> g c,2 c4 g' a2\resp
          a4-> a <d, d'>-> q <bes bes'>-> q <c c'>-> q d2 (g) <d d'>2
        } \tonIhh
      }
   >>
>>