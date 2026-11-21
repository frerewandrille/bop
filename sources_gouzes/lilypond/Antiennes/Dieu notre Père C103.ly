\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Marqué, vif" 2 = 100
         d2 d4 f d2. d4 d c d f f2 g a\fermata\resp
         a a4 a c c a a^\markup\italic{presser} d c a \allowBreak
         a c b8 ([c]) a4 a d c8 ([b!]) a2.\fermata\bar"|"
         a4^\markup\italic{\dynamic p subito en élargissant} a a a g2
         g4 g^\markup\italic{largando} a2. a4\allowBreak f2 g a\fermata
         \bar"|."
       } \tonIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         d2 d4 f d2. d4 d c d f f2 e e f f4 f g g a a f! g a
         a g g a a f! g fis2.
         f4 f f f e2 e4 e e2. e4 d2 e e
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Dieu no -- tre Père a é -- ta -- bli Jé -- sus Sei -- gneur
     en le res -- sus -- ci -- tant d’en -- tre les morts,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia-!
     Il le fait as -- seoir à sa droi -- te dans les cieux.
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          d2 d4 f d2. d4 d c d f f2 c' cis d d4 d e e fis fis d e fis !
          fis! e e fis! fis d e d2.
          c4 c c c c2 c4 c cis2. cis4 a2 c cis
        } \tonIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d2 d4 f d2. d4 d c d f f2 c a\fermata\resp
          d d4 d a' a <d, d'> q <bes bes'> <c c'> < d d'> q <a a'> <c c'> < d d'>
          
          q <bes bes'> <c c'> <d d'>2.\fermata
          f4 f f f c2 c4 c a2. a4 d2 c a\fermata
        } 
      }
   >>
>>