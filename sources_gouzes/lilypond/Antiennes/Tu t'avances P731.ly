\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silB = { \oneVoice r2 \voiceOne }


\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure
         \partial 2 f4 f c' c c f,2. r4 c'4 c bes2 c4 ees d ees c2.~ c
         c4 c c d2. bes4 d c bes2. 4 a g bes2. 4 c c bes (c bes) 2.
         \silB g4 bes (a bes) c (bes a) g2. (f2) f4 a (g a) bes (a g) f2.\fermata
         \bar"|."
       } \cadenzaOn \transpose c bes, \tonVIIIdf %\tonVIId dans l'original
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         r2 r4 a a a a a a2. bes2 a4 g f g f2 (g4 a2.)
         4 a a bes2. f4 g a f2. 4 f g f2. 4 g g f (g ees) f2.
         s2 g4 f (g f) bes (g f) f2 (e4 f2) f4 e (f e) f2 (c4) d2.
       }    
     }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" }
   \lyricsto "soprano"
   {
     Tu t’a -- van -- ces, Sei -- gneur, par des -- sus les ai -- les du vent.
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "alto"
   {
     Tu t’a -- van -- ces, Sei -- gneur, sur les ai -- les du vent.
     Tu prends les vents pour mes -- sa -- gers, pour ser -- vi -- teur, un feu de flam -- mes.
     Al -- lé -- lu -- ia_! Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure
          \silB r4 f f c' c c f,2. r4 c' c bes2 c4 ees d ees c2.
          f4 f f f2. d4 e f d2. d4 c e d2. d4 ees! ees d (ees c) d2.
          r2. d f d2 (c4) d2. c d2 e4 d2.
        } \cadenzaOn \transpose c bes, \tonVIIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          s2 R1*3/4 r4 f f f f f f2. bes2 a4 g f ees f2. 4 f f bes2. 4 4 a bes2. 
          4 f c' bes2. 4 ees,4 4 f2. bes f bes2 (c4) d2. (g,) bes c g2 4 bes2.\fermata
        } 
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" }
   \lyricsto "ténor"
   {
     Tu t’a -- van -- ces, Sei -- gneur, par des -- sus les ai -- les du vent.
     \repeat unfold 17 \skip4      Al -- lé -- lu -- ia_! Al -- lé -- lu -- ia_!
   }
   \new Lyrics 
   \lyricsto "basse"
   {
     Tu t’a -- van -- ces, Sei -- gneur, sur les ai -- les du vent.
     \repeat unfold 17 \skip4      Al -- lé -- lu -- ia_! Al -- lé -- lu -- ia_!
   }
>>