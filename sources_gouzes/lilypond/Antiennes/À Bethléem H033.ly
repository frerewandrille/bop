\version "2.24.0"

%\include "vowel-set.ly"
\include "TonsDef.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose a g
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure %\tempo "" 2. = 50
          \revert Staff.TimeSignature.style
          \partial4 a4 c2 b4 e,2. fis2 gis4 a2 c4 b (a) c b2\resp
          a4 c2 b4 e,2. fis2 gis4 a2 c4 b (gis) b a2\resp
          a4 a gis a b2 c4 d c b e c\resp
          a4 a (gis) a b2 c4 d (c) b \noBreak a2.\fermata
          \bar "|."
        }\cadenzaOn \tonIIIff
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial4 e4 dis2 dis4 e2. e2 e4 e2 e4 e2 e4 e2
          e4 dis2 dis4 e2. c2 e4 e2 e4 e2 d4 c2 r4
          e2. e e e2 e4 c2 c4 e2 e4 f (e) d c2.
        }          
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" }
   \lyricsto soprano 
   { 
      \repeat unfold 22 {\skip4}
      Il don -- ne la paix aux hom -- mes qu’il ai -- me, 
   }
    \new Lyrics \with { \override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      À Beth -- lé -- hem, la ci -- té du roi Da -- vid,
      le Christ est né de Ma -- rie, al -- lé -- lu -- ia_! \skip4 
      \once\override Lyrics.LyricText.font-shape = #'italic \once\small b.f.
      \repeat unfold 9 {\skip4}
      al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   << \new Voice = "ténor"\with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          \partial4 a4 a2 a4 gis (fis gis) a2 b4 c2 c4 gis 
          \override BalloonText.annotation-balloon = ##f 
          <fis \balloonText #'(1 . 3)\markup { "" } >2
          gis
          a4 a2 a4 gis (fis gis) a2 b4 e,2 fis4 gis8 (a b4) gis a2 r4
          c2. b2 a4 gis2. a2 a4 a2 
          a4 a (gis) \resp a a2 gis4 <e a>2.
        }\cadenzaOn \tonIIIfh
      }
      \new Voice = "basse"\with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c
        {
          \partial4 a4 b2 b4 e2. e2 d4 d (c) a e'2 e4 e2\resp
          a,4 b2 b4 e2. e4 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(1 . 4)\markup { "" } >2
          d4 (c) a e'2 e4 a,2 r4
          a2. a4 gis a b e d c2\resp
          c4 f2 f4 e2 e4 d2 e4 a,2.\fermata
        }
      }
   >>
>>