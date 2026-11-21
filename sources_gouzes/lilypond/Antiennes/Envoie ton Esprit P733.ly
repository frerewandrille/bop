\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn
         f4 f-> bes g f2 4 ees2 f4 g2 f4 ees2 f4 2.\fermata\resp
         f4->^\markup\italic{ "violent et " \dynamic f } a bes
         c2 4 2 4 2. bes4-> g bes4 2 (c4) bes2.\resp
         2->^\markup\italic{ \dynamic p " et souple" } 4 a-> g a bes-> g f ees2 4\resp
         f->- (g) g f2. f\fermata
         \bar"|."
       } \tonVIIIgf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4 f f ees c2 4 2 4 2 4 2 4 2. 4 f f g2 a4 e2 f4 e2. f4 f f f2 (e!4) f2.
         2 4 f d f f ees c c2 4 c (ees) ees c2. c
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     En -- voie ton Es -- prit, Sei -- gneur, et tout se -- ra cré -- é.
     Tu re -- nou -- vel -- le -- ras la fa -- ce de la ter -- re.
     Tu te ré -- jou -- i -- ras dans tes œu -- vres, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f4 f d' bes a2 4 bes2 a4 bes2 a4 bes2 4 a2.
          4 c d e2 f4 c2 4 2. d4 d d d2 (c4) d2. 2 4 c bes c bes bes a bes2 4
          a (bes) bes4 2. a
        } \tonVIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4 f-> bes ees, f2 4 g2 f4 ees2 f4 g2 4 f2.\fermata\resp
          4-> f d c2 f4 g2 a4 g2. f4-> bes f f2 (g4) bes2.\resp
          2-> 4 f-> g f bes,-> ees f g2 4\resp f-> (ees) ees f2. f\fermata
        } 
      }
   >>
>>