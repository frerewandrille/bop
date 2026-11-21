\version "2.24.0"
%\include "TonsDef.ly"

resp = { \breathe\allowBreak }

\transpose a fis
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 3/2  \tempo 2. = 54
          \cadenzaOn
          a4 c2. a4^> c d c2 \resp 
          d4 f2 f4 e2 d4 c2. f,2 g4 a2. \bar "|"        
          a4^>  a a c2 d4 a2. \resp
          \once \override Staff.DynamicLineSpanner.outside-staff-priority = #500
          g2^\markup{\italic élargir}^\> g4 g^> g d a'2.\!\fermata
          \bar "|."
        }\cadenzaOn \tonVIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c' 
        {\cadenzaOn
         \partial4 f4 e2. d4 c f8 ([g]) a2 
         f8 ([g]) a2 a4 a2 f8 ([g]) a2. d,2 e4 f2.
         f4 f f e2 f8 ([g]) a2. d,2 d4 d d d f2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano
   {
     Le Roi, ton Bien_- Ai -- mé, dé -- si -- re ta beau -- té, ô Ma -- rie_!
     En -- tre dans son jar -- din, toi, la Rei -- ne des cieux_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c' 
        { \clef "bass" \key f \major\cadenzaOn
          \partial4 c4 a2. f'4 e d e2 d4 c2 c4 c2 d4 e2. d2 bes4 c2.
          c4 c c a2 bes4 c2. bes2 bes4 bes bes bes c2.
        }\cadenzaOn \tonVIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c 
        {\cadenzaOn
         \partial4 f4 a2. d,4-> a' bes a2 \breathe bes4 f2 f4 a2 bes4 a2. bes4 (a) g f2.
         f4-> f f a2 g4 f2. \breathe f2 f4 f f f f2.\fermata
        }
      }
   >>
>>