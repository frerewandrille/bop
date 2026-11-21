\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key f \major 
          \revert Staff.TimeSignature.style \time 6/8 \cadenzaOn %\tempo "" 2 = 52
          d8 a'4-> g16 [a] c8-> [bes a] a4. \breathe \allowBreak
          d4-> d16 [d] c4. bes4-> a16 [g] a4-> bes8 a4.\fermata \bar "|."
        }\tonIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d8 fis4 e16 [fis!] a8 [ g g] fis!4. 
          f4 f16 [f] a4. g4 fis16 [e] fis!4 d16 ([e]) fis!4.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      J’i -- rai vers le Dieu de ma joie_: 
      J’e -- xul -- te -- rai, je le loue -- rai sans fin_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key f \major  
          \revert Staff.TimeSignature.style \time 6/8 \cadenzaOn
          d8 d4 d16 [d] e8 [d e] d4.
          d4 d16 [d] f4. d4 d16 [d] d4 bes16 ([c]) d4.
        }\tonIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d8 d4-> d16 [d] a'8-> [bes c] d4. \breathe
          bes4-> bes16 [bes] f4. g4-> a16 [bes] a4 g8 d4.\fermata
        }
      }
   >>
>>