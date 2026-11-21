\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         e8 [fis] a [a] b [cis] b4 \resp
         b8 [b] a [b] d [cis] b [a] b ([cis]) b4\bar"|"
         b8 [b] fis [b] a [gis] fis4 \resp 
         fis fis8 [e] fis4 (e\fermata)\bar"|"
         d8 [e] fis4 (a8 [fis]) fis2\fermata
         \bar"|."
       } \transpose b cis' \tonIIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e8 [fis] a [a] e [d] e4 e8 [e] fis [e] fis [e] fis [fis] e ([d]) e4
         e8 [e] d [d] e [e] d4 d d8 [cis] d ([cis] b4)
         b8 [cis] d ([e] d4) cis2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Dieu a é -- ta -- bli son Fils 
     au_- des -- sus de tou -- te cré -- a -- tu -- re.
     Il l’a fait Sei -- gneur et Christ, Dieu tout en tous_!
     Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e8 [fis] a [a] b [a] b4 b8 [b] cis [b] a [gis] a [a] gis ([a]) gis4
          gis8 [gis] a [a] a [a] a4 a a8 [gis] a4 (gis)
          a8 [gis] a4 (fis16 [gis a b]) <a cis>2
        } \transpose b cis' \tonIIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e8 [fis] a [a] gis [fis] gis4\resp
          gis8 [gis] fis [gis] d [e] fis [fis] e ([d]) e4
          e8 [e] d [d] cis [cis] d4 \resp d d8 [e] d4 (e\fermata)
          fis8 [e] d ([cis] b4) <fis fis'>2\fermata
        } 
      }
   >>
>>