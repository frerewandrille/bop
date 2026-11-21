\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\new ChoirStaff
<<  \new Staff = "femmes" %\with {\remove Time_signature_engraver }
    << %\accidentalStyle neo-modern-voice
      \new NullVoice = "aligne" { << \armure  >> }
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Vif, rythmé et détaché" 2. = 80
          f4-> f e f2 f4 g2. a4-> a g a2 a4 \resp
          a-> bes a bes2 a4 g f2 g2. \resp
          \silN	g4 g a-> a a f-> (e f) \resp
          g-> f g g-> f g \override Script.outside-staff-priority = #1000
          a2.^\markup\italic{élargir}\fermata a\fermata
          \bar"|."
        } \tonIbf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { 
          d4 d cis d2 d4 e2. f4 f e f2 f4 f f f f2 f4 e d2 e2.
          s4 e4 e e e e d (cis d) e d e e d e e2. e
        }    
      }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "soprano"
    {
      Ar -- bre de vie plan -- té sur le cal -- vai -- re, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
      De la croix du Sei -- gneur cou -- lent des fleu -- ves d’eau vi -- ve.
    }
    \new Staff = "hommes" %\with {\remove Time_signature_engraver }
    << \new Voice = "ténor" 
       { %\accidentalStyle neo-modern-voice
         \voiceOne \relative c'
         { \clef "bass" \armure \cadenzaOn
           a4 a a a2 a4 c!2. c4 c c c2 c4 c d c d2 c4 c a2 c2.
           \silN c4 c cis cis cis a2. c4 a c c a c cis2. cis
         } \tonIbh
       }
       \new Voice = "basse"
       { \voiceTwo \relative c
         { 
           d4-> d a d2 d4 c!2. f4-> f c f2 f4 \resp
           f-> bes, f' bes,2 f'4 c d2 c2. \resp
           s4 c4 c a-> a a d-> (a d) \resp
           c!-> d c c-> d c a2.\fermata <a a'>\fermata
         } 
       }
    >>
>>