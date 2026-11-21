\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 2/4 }
resp = { \breathe\allowBreak }

\transpose d c
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif"% 2 = 52
         \once \omit Staff.TimeSignature
         \tupletSpan 4 %\omit TupletBracket
         \tuplet 3/2 { c8 [a c] c4 (d8 } c4 e8-> [ d c b] c2 a)\bar":|."
         \time 2/4 c4 a g a2 a4 a c2. (a4) a2\resp
         a4 a a a a g a2 \allowBreak a4 a c2 b4 (c) a2\bar"|"
          \tuplet 3/2 { c8 [a c] c4 (d8 } c4 e8 [ d c b] c2 a)
        \bar"|."
       } \tonVIIhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         \scaleDurations 2/3 { a8 [fis a] a4 (b8 } a4 c8 [ b a g] a2 fis)
         a4 fis e fis2 g4 g fis2. (g4) fis2
         fis4 fis fis fis fis e fis2 fis4 fis g2 g fis
         \scaleDurations 2/3 { a8 [fis a] a4 (b8 } a4 c8 [ b a g] a4 g fis2)
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Jé -- ru -- sa -- lem_!
     Elle est ve -- nue, ta lu -- miè -- re,
     et la gloi -- re du Sei -- gneur s’est le -- vée sur toi_!
     Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
         \once \omit Staff.TimeSignature
          d\breve*7/8 d2
          e4 d e d2 e4 e d2. (e4) d2 d4 d d d d e d2 d4 d e2 e fis
          \scaleDurations 2/3 { e8 [d e] e4 (fis8 } g4~ g8 [fis e d] e2 d)
        } \tonVIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \tupletSpan 4 %\omit TupletBracket
          d\breve*7/8 d2 
          \time 2/4 a'4 d, a' d2 c4 c a2. (c4) d2\resp
          d,4 d d d d a' d,2 d4 d a'2 c d
          \tuplet 3/2 { a8 [d a] a4 (d8 } e4 c8 [d a d] c2 d)
        } 
      }
   >>
>>