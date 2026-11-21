\version "2.24.0"

\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0

\transpose bes g
\new ChoirStaff
<< \new Dynamics 
   {
     bes2. g2 bes4 c2 (d4) c2
     d4 f ees d c2. \agauche bes^\>^\rall g2 bes4 c2.\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Décidé" 2. = 76
         bes2. g2 bes4 c2 (d4) c2\resp
         d4 f-> ees d c2.\resp bes
         g2 bes4 c2.\fermata
         \bar"|."
       } \transpose c bes, \tonVIIIdf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f2. ees2 d4 f2. f2 f4 f g8 ([a]) bes4 f2.
         d ees2 d4 f2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Par ta Pa -- ro -- le, Sei -- gneur, sou -- tiens_- moi,
     et je vi -- vrai_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d2. bes2 bes4 a2 (bes4) a2 bes4 c bes bes a2. 
          bes c2 bes4 a2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          bes2. ees2 g4 f2 (bes,4) f'2\resp 
          bes4 a-> g8 ([f]) ees4 f2.\resp g c,2 g'4 f2.\fermata
        } \transpose c bes, \tonVIIIdh
      }
   >>
>>