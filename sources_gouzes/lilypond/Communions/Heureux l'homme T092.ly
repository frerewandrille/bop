\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose b a
\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Large" 4 = 63
         fis4 b b (a8 [g]) fis4\resp e8 [fis] g4 fis8 [e] e4 (fis) fis\resp
         8 [8] 4. (a8 fis4 e) fis2\fermata\bar"|"
         4^\markup\italic"cresc." 8 [8] b4 \allowBreak 8 [8] 4 ais8 [gis] ais!4.\fermata\resp
         ais!8^\< b [cis] d4 8 [8] 4.\! \allowBreak 8 cis [b] b4 (a) b2\fermata
         \bar"|."
       } \transpose a b \tonIVaf % absent dans l'origin.
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         fis4 4 e2 fis4 cis8 [d] e4 d8 [d] d ([cis] b [cis]) cis4 8 [8] d2. (b8 [cis]) dis2
         dis!4 8 [8] e4 8 [8] fis4 8 [8] 4. 8 8 [8] b4 8 [8] g4. 8 8 [8] fis2 2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Heu -- reux l’hom -- me qui sup -- por -- te l’é -- preu -- ve, al -- lé -- lu -- ia_!
     Il re -- ce -- vra la cou -- ron -- ne de vie 
     que le Sei -- gneur a pro -- mise à ceux qui l’ai -- ment_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 cis b4. (cis8) d4 b8 [b] b4 8 [8] 2 ais4 ais!8 [8] b2 (a4 g) b2
          4 8 [8] 4 8 [cis] d4 cis8 [b] cis4. 8 d [e] fis4 8 [8] e4. 8 8 [d] cis2 dis
        } \transpose a b \tonIVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          b4 a g (fis8 [e]) b4\resp g'8 [fis] e4 fis8 [g] g2 fis4\resp
          8 [8] b,4 (cis d e) <b b'>2\fermata 
          b'4 a8 [a] g4 8 [8] fis4 8 [8] 4.\fermata\resp
          e8 d [cis] b4 8 [8] e4. 8 8 [8] fis2 <b, b'>\fermata
        } 
      }
   >>
>>