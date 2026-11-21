\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         e4 fis-> a b b2\resp a4 b2. cis4-> b a b2. b\resp
         \silN gis4 b gis2. a4-> fis e fis2.\resp
         e4-> d e fis-> \resp a fis fis2. fis\fermata
         \bar"|."
       } \transpose b cis' \tonIIIdf
       %\transpose a b \tonIVef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e4 fis e fis fis2 fis4 fis2. a4 fis e fis2. fis
         s4 e e e2. e4 d b d2. b4 b b d cis d cis2 (d4) cis2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Chan -- tez au Sei -- gneur, roy -- au -- mes de la ter -- re_:
     Il che -- vau -- che le so -- leil. 
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e4 b' cis e dis2 cis4 dis!2. e4 dis! cis dis!2. dis
          \silN b4 b b2. cis4 a gis a2. 
          gis4 fis gis a a b ais2 (b4) ais2.
        } \transpose b cis' \tonIIIdh
        %\transpose a b \tonIVeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4 dis-> cis b b'2 \resp fis4 b2. a4-> b fis b2. b\resp
          s4 e, gis e2. cis4-> d e d2. \resp e4-> b e d-> \resp
          fis b, fis'2. fis\fermata
        } 
      }
   >>
>>