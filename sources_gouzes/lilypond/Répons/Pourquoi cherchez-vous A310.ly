\version "2.24.0"
%\include "TonsDef.ly"
%\include "TonsRDef.ly"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }


\transpose e c
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Vif" 4. = 72
         e8 b' [ b a] b4 c8 d [(c) d] b4 b8 e4 e8 d [(e) c] d4.\bar"|"
         e8 [e e] d [d e] c4 c8 e4 e8 d4 e8 b2.
         \bar"|."
       } \transpose f g \tonXaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e8 gis [8 f!] e4 d8 c ([f) d] e4 b'8 a4 f8 a [(f) a] g4.
         e'8 [d c] b [a g] a4 g8 f [(g) a] f [(g) a] gis2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Pour -- quoi cher -- chez_- vous par -- mi les morts
     ce -- lui qui est vi -- vant_?
     Ve -- nez, pui -- sez dans la joie aux sour -- ces du Sau -- veur_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b\breve*10/16 4 8 c4 d8 d [(c) d] b4.
          c8 [b a] g [a b] c4 8 a4 8 c4 b8 <b e>2.
        } \transpose f g \tonXah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e\breve*10/16 4 g!8 f4 a8 c [(a) f] g4.
          c,8 [d e] f [f g] f4 e8 d [(e) f] a [(g) f] e2.
        } 
      }
   >>
>>