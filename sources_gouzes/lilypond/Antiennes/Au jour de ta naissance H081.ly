\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key d \major \time 6/8 }
resp = { \breathe\allowBreak }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure %\tempo "" 2. = 50
          \partial8 g8 g4 e8 e4 b'8 a4 (g8) e4.~ e\resp
          \silC a8 a a4 (g8) e4.~ e\resp
          b'8 b b cis cis cis b4 a8 e4.\resp
          b'8 b b a4 (g8) e4.~ e\resp
          \silC g8 g a4 a8 b b a \noBreak e2.\fermata
          \bar "|."
        }\cadenzaOn \transpose a b \tonIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        {
          \partial8 g8 e4 e8 e4 e8 e4 (d8 cis4 d8) cis4.
          s8 cis cis d4. (cis4 d8) cis4.
          d8 d d cis cis cis d4 d8 cis4. d8 d d e2. e4.
          s8 e8 e cis4 cis8 d d e d4 (cis8 b4.)
        }          
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" }
   \lyricsto soprano 
   { 
     Au jour de ta nais -- san -- ce, tu es prin -- ce,
     %dans la splen -- deur de ta sain -- te -- té.
     \repeat unfold 9 \skip4
     A -- vant l’au -- ro -- re, 
     %de mon sein, je t’ai en -- gen -- dré.
   }
   \new Lyrics = "txtTénor" \with { %alignAboveContext = "hommes" 
     \override VerticalAxisGroup.staff-affinity = #CENTER
   }
   
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure
          \partial8       e8 b'4 b8 b4 b8 cis4 (b8 a4 b8) a4.
          \silC a8 a b4. (a4 b8) a4.
          b8 b b a a a b4 b8 a4. b8 b b cis4. (d) cis
          \silC cis8 b a4 e'8 b b cis b4 (a8 b4.)
        }\cadenzaOn \transpose a b \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial8 e8 e4 e8 g4 g8 a4 (b8 a4 g8) e4.\resp
          s8 e e g4. (a4 g8) e4.\resp
          g8 g g e e e g4 g8 a4.\resp
          g8 g g a4. (b) a\resp s8 a g e4 e8 g g a b4 (a8 e4.\fermata )
        }
      }
   >>
   \context Lyrics = "txtTénor"{         
     \lyricsto ténor 
     { 
       Au jour de ta nais -- san -- ce, tu es prin -- ce,
       dans la splen -- deur de ta sain -- te -- té.
       A -- vant l’au -- ro -- re, de mon sein,
       je t’ai en -- gen -- dré.
     }
   }
>>