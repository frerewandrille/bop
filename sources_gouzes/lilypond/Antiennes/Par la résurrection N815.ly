\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         e8 [e] e4 (fis8 [d] fis [a]) a4 (b8 [cis] b4.\fermata)\bar"|"
         b8 b [b] cis [d] cis [(b]) a [b] b4\resp
         gis8 [b] a [gis] fis4 a8 ([gis]) e [fis] e4\fermata
         \bar"|."
       } \transpose a b \tonVIIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         b8 [b] b4 (d8 [b] d4) e2~ 4.
         e8 e [e] e [fis] e8. [(d16]) cis8 [d] e4
         e8 [e] cis [e] d ([cis]) b4 b8 [a] b4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Par la ré -- sur -- rec -- tion de son Fils,
     Dieu fa -- çonne en nous l’hom -- me nou -- veau.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          gis8 [8] 4 (a2) 4 (gis8 [fis] gis4.)
          8 8 [8] a [a] a [(gis)] a [a] gis4
          b8 [b] a [cis] a4 4 gis8 [fis] gis4
        } \transpose a b \tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e8 [e] e4 (d8 [fis] d4) cis (e~ 4.\fermata)
          8 e [e] cis [b] a ([e']) fis [8] e4\resp
          8 [gis] fis [cis] d4 fis8 ([d]) e [e] e4\fermata
        } 
      }
   >>
>>