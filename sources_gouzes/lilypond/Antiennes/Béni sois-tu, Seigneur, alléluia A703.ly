\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key a \minor \time 4/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   { \override Hairpin.to-barline = ##f
     \partial4 a4 b4.\< b8 b4 b c4.\! c8\> c4 (b) a2 gis\!
     e\< e4 fis g g2 a4 b cis d4. d8 cis2\!
     a\p\<~ a4 a a b c2\! b4 a gis2\> a f e e1\!
   }
   \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \revert Staff.TimeSignature.style \armure \tempo "Large" 4 = 84
          \partial4 a4 b4. b8 b4 b c4.\resp c8 c4 (b) a2 gis\fermata
          e e4 fis g g2 a4 b cis d4. d8 cis2\fermata\resp
          a~ \noBreak a4 a a b c2 b4 a gis2 a f^\pp e 
          \noBreak e1\fermata
          \bar "|."
        }\cadenzaOn \tonIVcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 e4 g4. g8 g4 g g 
          \override BreathingSign.Y-offset = #-1 \breathe
          g e e e1
          cis2 cis4 d d d2 d4 g g fis4. fis8 e2
          e~ e4 e f f g2 g4 e e2 e d b cis1
        }          
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" } \lyricsto soprano 
   { 
     \repeat unfold 6 \skip4 al -- lé -- lu -- ia_!
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto alto 
   { 
     Bé -- ni sois_- tu, Sei -- gneur, al -- lé -- lu -- ia_!
     Tu as ar -- ra -- ché au pou -- voir de la mort
     ton Fils bien_- ai -- mé, pre -- mier_- né de ton a -- mour_!
   }
   \new Staff = "hommes"  %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \partial4 c4 d4. d8 d4 d e4. 
          \override BreathingSign.Y-offset = #4 \breathe 
          e8 a,4 (b) c2 b
          a a4 a b b2 a4 d g, a4. a8 a2
          c!~ c4 c c d e2 d4 c b2 a a a4 (gis) a1
        }\cadenzaOn \tonIVch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          \partial4 a4 g4. g8 g4 g c,
          \once \override BreathingSign.Y-offset = #0 \breathe 
          e a (gis) a2 e\fermata
          a, a4 d <g, g'> g'2 fis4 g e d4. d8 a2\fermata\resp
          a'~ a4 a f d c2 g'4 a e2 cis d e a,1\fermata
          
        }
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" } \lyricsto ténor 
   { 
     \repeat unfold 6 \skip4 al -- lé -- lu -- ia_!
   }
   \new Lyrics \lyricsto basse
   { 
     \repeat unfold 6 \skip4 al -- lé -- lu -- ia_!
   }
>>