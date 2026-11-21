\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a\major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   <<
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Vif et détaché" 4 = 116
         fis8-- [8--] 8-- [8--] a4-- 4-- gis-- 4-- b4.\fermata\resp
         b8 b [b b b] a2 4 4 gis2 4\fermata
         \bar"|."
       } \tonIVif
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         fis8 [8] 8 [8] 4 4 gis4 4 4. 8 8 [8 8 8] e2 fis4 4 gis2 4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ils ont par -- ta -- gé mes vê -- te -- ments, 
     ils ont ti -- ré au sort ma tu -- ni -- que.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      {
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 [8] 8 [8] cis4 4 e4 4 dis4. dis!8 8 [8 8 8] cis2 4 dis! eis2 4
        } \tonIVih
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          b8-- [8--] 8-- [8--] fis4-- 4-- cis'4-- 4-- gis4.\fermata\resp
          8 8 [8 8 8] a2 fis4 4 cis'2 4\fermata
        } 
      }
   >>
>>