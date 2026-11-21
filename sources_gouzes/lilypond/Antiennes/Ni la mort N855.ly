\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         e8 [e] e4 (fis8 [d] fis [a]) a4 (b8 [cis] b4\fermata)\bar "|"
         e,4 fis8 a [fis a] b4.\resp
         b8 [a b] d4. cis8 [b a] b\resp
         b [b] a4 gis8 fis4. a8 [fis gis] e4.\fermata
         \bar"|."
       } \tonVIIcf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         gis8 [a] b4 (d8 [b] d [fis]) e2.
         e4 d8 cis [d e] e4. e8 [e e] fis4. e8 [d cis] e
         e [e] cis4 e8 d4 (cis8) b [d b] b4.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Ni la mort, ni la vie,
     rien ne pour -- ra nous sé -- pa -- rer de 
     l’a -- mour du Christ res -- sus -- ci -- té_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          e8 [fis] gis4 (a8 [fis] a4) a (gis8 [fis] gis4)
          cis8 [(b) a] a [a a] gis4.
          gis8 [fis gis] b4. a8 [fis fis] gis
          gis [gis] a4 cis8 a4. a8 [a a] gis4.
        } \tonVIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e8 [e] e4 (d2) cis4 (e2\fermata)
          a8 [(gis) fis] e [d cis] e4.\resp
          e8 [e e] b [ (cis d)] e [e e] e \resp
          e [e] fis4 cis8 d4. fis8 [fis d] e4.\fermata
        } 
      }
   >>
>>