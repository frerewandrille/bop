\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"
%gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes\breve*1/8 \unHideNotes \allowBreak }
armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "" 2 = 52
          
          \bar"|."
        } 
      }
   >>
   \new Lyrics \lyricsto "soprano"
   {
      
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          
        } 
      }
   >>
>>