\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn
         a2 a4 4 gis4 4 a gis fis2\resp eis4 fis eis2\resp 
         fis4\fermata gis\fermata gis2\fermata\bar"|"
         a2 gis4 a b cis a2\resp 4 4 gis (a) b\fermata gis\fermata a2\fermata
          \bar"|."
        } \tonVIIIef
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { 
         e2 4 4 4 4 4 4 cis2 4 4 2 4 e e2 2 4 4 4 4 2 4 4 2 4 4 2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Je ne vous ap -- pe -- le -- rai plus ser -- vi -- teurs, mais A -- mis.
     Heu -- reux les in -- vi -- tés au fes -- tin de l’A -- gneau.
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          cis2 4 4 b b cis b a2 gis4 a gis2 a4 b b2
          cis2 b4 cis d e cis2 4 4 b (cis) d b cis2
        } \tonVIIIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 4 4 e e a e fis2\resp cis4 fis cis2\resp
          fis4\fermata e\fermata e2\fermata
          a2 e4 a gis gis a2\resp 4 4 e2 4\fermata e\fermata a,2\fermata
        } 
      }
   >>
>>