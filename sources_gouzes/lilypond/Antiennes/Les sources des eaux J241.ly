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
         \tuplet 3/2 { c8 [a c] c4 (d8 } c4 e8 [ d c b] c2 a)\bar":|."
         \time 2/4a4 a2 g4 a c2. c4 c c b c a2\resp
         a4 a d d c c a2 a4 a c2 (b4 c) a2\bar"|"
          \tuplet 3/2 { c8 [a c] c4 (d8 } c4 e8 [ d c b] c2 a)
        \bar"|."
       } \tonVIIhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         \scaleDurations 2/3 { a8 [fis a] a4 (b8 } a4 c8 [ b a g] a2 fis)
         fis4 fis2 e4 fis g2. g4 g g g g fis2 a4 a f f g g fis2 fis4 fis g1 fis2
         \scaleDurations 2/3 { a8 [fis a] a4 (b8 } a4 c8 [ b a g] a4 g fis2)
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Les sour -- ces des eaux ont é -- té sanc -- ti -- fiées
     quand le Fils est ap -- pa -- ru dans la gloi -- re_!
     Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
         \once \omit Staff.TimeSignature
          d\breve*7/8 d2
          d4 d2 d4 d e2. e4 e e e e d2 fis4 fis f f e e d2 d4 d e1 fis2
          \scaleDurations 2/3 { e8 [d e] e4 (fis8 } g4~ g8 [fis e d] e2 d)
        } \tonVIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \tupletSpan 4 %\omit TupletBracket
          d\breve*7/8 d2 
          \time 2/4 d4 d2 d4 d a'2. a4 a a c c d2\resp
          d4 d bes bes c c d2 d4 d a2 (c) d
          \tuplet 3/2 { a8 [d a] a4 (d8 } e4 c8 [d a d] c2 d)
        } 
      }
   >>
>>