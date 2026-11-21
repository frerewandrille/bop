\version "2.24.0"
%\include "TonsDef.ly"
%ss = { \hideNotes bes\breve*1/8 \unHideNotes \allowBreak }
armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }
barre = { \undo \omit Score.BarLine }
barress = { \omit Score.BarLine }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo "" 2. = 50
          \barress
          
          \barre
          \bar "|."
        }\cadenzaOn \ton
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          
        }          
      }
   >>
   \new Lyrics \lyricsto soprano 
   { 
      
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          
        }\cadenzaOn \ton
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          
        }
      }
   >>
>>