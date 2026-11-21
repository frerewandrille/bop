\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose g d
\new ChoirStaff  %\with { instrumentName = #"2" }
<< \new Staff \with {\remove Time_signature_engraver } 
   << \new Voice = "soprano" 
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \major \cadenzaOn \tempo "Libre"
          g8 [a] b \breve*1/8 a8 [b] c4 (a8 [c]) b4 \resp
          e8 [e] e8 [d e] fis4 (e8 [d] e4 d8 [b]) b2 \fermata \bar "|."
        } \tonIIIcf
      }     
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        {
          e8 [e] fis \breve*1/8 a8 [fis] g2 fis4 g8 [g] g8 [b c] a4 (c8 [b] a [g] a [g]) fis2
        }
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   { 
     Tu es "au milieu de" ton É -- gli -- se,_
     quand se lè -- ve l’au -- ro -- re_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \cadenzaOn
          b8 [c] d\breve*1/8 c8 [d] e2 d4 e8 [e] e[ fis g] fis4 (g8 [fis] e4 fis8 [e]) d2
        } \tonIIIch
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          e,8 [e] d\breve*1/8 a'8 [a] a4 ( c8 [a]) d4 \breathe 
          c8 [c] c [d c] d4 (a8 [b] c4 d) b2\fermata
        } 
      }
   >>
>>