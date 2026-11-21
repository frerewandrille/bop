\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key b \minor \time 2/2 }
resp = { \breathe\allowBreak }

\transpose b a
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure\cadenzaOn\tempo 2 = 76
          b4 b a b fis2.\resp fis4 d d e e fis2 fis\fermata\resp
          fis4 fis d2 d4 d e2 e \resp e e4 e g2 g4 g fis1\fermata\resp
          fis4 fis b b a cis b2\fermata\resp
          cis d4-> cis b b a cis d (b) b2\fermata
          \revert Score.BarLine.stencil \bar "|."
        } \transpose a b \tonIVmf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          fis4 fis a fis fis2. cis4 d d cis8 ([b]) cis4 d2 d
          d4 d8 ([cis]) b2 d4 d b2 e e e4 e e2 e4 e fis1
          fis4 fis e8 ([fis]) g4 fis8 ([e]) fis4 fis2
          a fis4 e fis e fis a8 ([g]) fis ([e] fis [gis]) fis2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Je suis de -- ve -- nu mi -- nis -- tre de l’Ég -- li -- se
     en ver -- tu de la char -- ge que le Sei -- gneur m’a con -- fiée,
     de ré -- a -- li -- ser chez vous 
     l’a -- vè -- ne -- ment de sa pa -- ro -- le.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure\cadenzaOn
          d8 ([e]) fis4 e8 ([fis]) e4 d (cis d) cis b8 ([a]) b4 g g a2 a
          a4 b8 ([a]) g2 b8 ([a]) b ([a]) g4 (a) b (cis) 
          d (cis) b8 ([cis]) b4 b2 b8 ([cis]) d4 cis1
          d8 ([cis]) b ([cis]) b4 e8 ([d]) cis4 cis dis2
          e4 (fis) d!8 ([b]) cis4 d8 ([cis]) b4 cis fis8 ([e]) d ([cis] d [e]) d2
        } \transpose a b \tonIVmh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          b8 ([cis]) d4 cis8 ([d]) cis4 b (a b)\resp
          a g8 ([fis]) g ([fis]) e4 e  d2 d\fermata\resp
          d8 ([cis]) b4 g' (fis) g8 ([fis]) g ([fis]) e4 (fis) g (a)\resp
          b (a) g8 ([a]) g ([fis]) e4 (fis) g8 ([a]) b4 ais1\fermata\resp
          b8 ([a!]) g ([a]) g ([fis]) e4 fis a b2\fermata\resp
          a4 (fis) b8 ([g]) a4 b8 ([a]) g4 a8 ([g]) fis ([a]) b2 <b, b'>\fermata
        }
      }
   >>
>>