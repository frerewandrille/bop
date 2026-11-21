\version "2.24.0"
%\include "TonsDef.ly"

\transpose a bes
\new ChoirStaff
<< \new Dynamics 
   {
     e4 e fis2. fis4 e2 e4 a a^\> (gis8 [fis] fis4 eis) 
     fis2\!\bar "|"
     fis2. fis4 e! e fis2 (e) e1\bar"|."
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key a \major \time 2/2 \cadenzaOn \tempo "Léger" 2 = 72
          e4 e fis2. fis4 e2 e4^> a^\markup{\italic"rall."}  a^>(gis8 [fis] fis4^> eis) 
          fis2\fermata\bar "|"
          fis2. fis4 e!^> e fis2 (e) e1\fermata\bar"|."
        }\transpose c a, \tonVIIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          cis4 cis d2. d4 cis2 cis4 cis b2 (cis) cis d2. d4 b b d2 (b) cis1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
     Le4 Sei -- gneur2. dé4 -- li2 -- vre4 le pau1 -- vre,2 qui2. ap4 -- pel -- le
     vers1 lui.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key a \major \time 2/2 \cadenzaOn
          a4 a a2. a4 a2 a4 a fis2 (gis) ais2 b2. b4 gis gis 
          a2. (gis4) a1
        }\transpose c a, \tonVIIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          a4 a d,2. d4 a'2 a4_> fis d2_> (cis_>) fis\fermata
          b,2. b4 e_> e d2 (e) a,1\fermata
        }
      }
   >>
>>