\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose bes a
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme"% 2 = 52
         bes4-> bes bes bes-> c bes bes2 (a4) bes2.\resp
         bes4-> bes bes bes2 a4 g2 bes4 a2 g4 f2. f \bar"|"
         f2-> f8 [g] f4-> \resp f f g2 (bes4) a2\resp 
         a4 bes2 bes4 a2.\fermata
         \bar"|."
       } \tonVIIIgf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f4 f f f g g f2. f f4 f f f2 f4 d2 g4 e2 e4 c2. c
         d2 d8 [ees] d4 d d ees2 (d4) f2 f4 f2 f4 f2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     J’ai de -- man -- dé à mon Pè -- re_: 
     Il m’a don -- né les peuples en hé -- ri -- ta -- ge,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d d d ees ees d2 (c4) d2. d4 d d d2 c4 bes2 d4 c2 bes4 a2. a
          bes2 bes8 [bes] bes4 bes bes bes2. c2 c4 d2 d4 c2.
        } \tonVIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes4-> bes bes bes-> bes bes bes2 (f4) <bes, bes'>2. \resp 
          <bes bes'>4-> q q q2 f'4 g2 g4 c,2 c4 f2. f
          bes,2-> bes8 [ees] bes4-> \resp bes bes ees2 (g4) f2\resp
          f4 bes,2 d4 f2. \fermata
        } 
      }
   >>
>>