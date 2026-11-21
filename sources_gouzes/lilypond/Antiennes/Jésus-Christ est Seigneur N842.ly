\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose c bes,
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         c8 [c] \tuplet 3/2 { c ([d c]) } c ([b] c4 a\fermata)\bar "|"
         a8 [g] f4 a8 [c] a4\resp 
         c8 [c] \tuplet 3/2 { c [d c] } c [b] c4 a4.\fermata\bar "|"
         a8 f [a] c [a] f [a] g4\fermata
         \bar"|."
       } \transpose bes c' \tonVIIIcf
       %\transpose a c' \tonVef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         a8 [a] \scaleDurations 2/3 { a ([b a]) } a ([g] a [g] f4)
         f8 [e] d4 f8 [e] f4 
         a8 [a] \scaleDurations 2/3 { a [b a] } a [g] a ([g]) f4.
         f8 d [f] e [f] d [f] d4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_! Jé -- sus Christ est Sei -- gneur
     à la gloi -- re de Dieu le Pè -- re_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a8 [b] \scaleDurations 2/3 { c ([b c]) } a ([b] c4 d)
          c8 [b] c4 c8 [c] d4
          a8 [b] \scaleDurations 2/3 { c [b c] } a [b] c4 d4.
          d8 c [c] c [d] c [c] b4
        } \transpose bes c' \tonVIIIch
        %\transpose a c' \tonVeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f8 [g] \tuplet 3/2 { a ([ g a]) } f ([g] f4 d\fermata)
          f8 [g] a4 f8 [a] d4\resp
          f,8 [g] \tuplet 3/2 { a [g a] } f [g] f4 d4.\fermata
          f8 a [f] a [d] a [f] g4\fermata          
        } 
      }
   >>
>>