\version "2.24.0"

armure = { \key a \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose e d
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "Calme" 4 = 69
          b4-> cis a b-> b cis d2 (b4) b2\resp e4 d2 cis4 b2.\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          gis4 a fis gis gis a a2 (fis4) gis2 a4 fis (gis) a gis2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Al -- lé -- lu -- ia, Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          e4 e e e e e fis2 (d4) e2 cis4 d2 e4 e2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e4-> a fis e-> e e d2 (fis4) e2\resp a4 b2 a4 e2.\fermata
        } 
      }
   >>
>>