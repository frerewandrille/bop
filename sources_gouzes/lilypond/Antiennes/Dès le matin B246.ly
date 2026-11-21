\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
silB = { \oneVoice r2 \voiceOne }


\transpose bes g
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo 4 = 76
         bes8 [c bes] bes4. bes8 c [d] bes [bes] c [bes] bes4.\resp
         \silC bes8 g ([f] g [bes]) bes4. (c8 bes [d] c [bes]) bes2\fermata
         \bar"|."
       } \transpose a bes \tonVIIdf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f8 [g f] f4. f8 g [ees] f [f] g [ees] f4.
         s8 g ees ([d] ees [g]) g4. (ees8 g [f] ees [g]) f2
       }    
     }
   >>
   \new Lyrics 
   \lyricsto "soprano"
   {
     \repeat unfold 12 {\skip4}
     al -- lé -- lu -- ia_!
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Dès le ma -- tin, mon cœur est prêt pour te chan -- ter,
   }
   \new Lyrics = "voix hommes"
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 [ees ees] d4. d8 ees [c] d [d] ees [c] d4.
          \override BalloonText.annotation-balloon = ##f 
          d4 c bes c bes c c d2
        } \transpose a bes \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes8 [bes bes] bes4. bes8 ees, [g] bes [bes] ees, [g] bes4.\resp
          bes,4 ees g ees g ees g bes2\fermata
        } 
      }
   >>
   \context Lyrics = "voix hommes" \lyricsto "ténor"
   { \repeat unfold 12 {\skip4}
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }

>>