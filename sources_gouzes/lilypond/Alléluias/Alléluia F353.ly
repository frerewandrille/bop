\version "2.24.0"

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff ="femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif et marqué" 2 = 126
          g4-- a-- a (g) a2\resp a4-- b-- b (a) b2\resp
          b4 c c2^\markup\italic"rall." (b4 a g2 a) a1\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e4 e e (d) e2 e4 fis fis (g) fis2 fis4 g g (fis) e2
          e4 d c (d) e1
        }    
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" } \lyricsto "soprano"
   {
      \repeat unfold 8 { \skip4 } Al -- lé -- lu -- ia.
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "alto"
   {
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b4 c c (b) c2 c4 d d (c) d2 d4 e e (d) c2
          c4 b a (b) c1
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4-- e-- e (g) e2\resp e4-- e-- e (a) e2\resp
          e4 e e2 g a4 a a2 <a, a'>1\fermata
        } 
      }
   >>
>>