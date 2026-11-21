\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Balancé" 2. = 52
         a2. g a1.\resp e4-> e e g (f) g e2 4 a2 4 g2. e\fermata
         \bar"|."
       }\tonIVaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e2. e e1. 4 4 4 d2 4 e2 4 f2 4 d2. cis
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Au ré -- veil, je me ras -- sa -- sie -- rai de ton vi -- sa -- ge_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c?2. b cis1. 4 4 4 b2 4 cis2 4 c2 4 b2. a
        } \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2. e a,1.\resp a'4-> a a e2 4 a2 4 f2 4 g2. a\fermata
        } 
      }
   >>
>>