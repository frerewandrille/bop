\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 4/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure  \tempo "Vif et marqué" 4 = 120
          \partial2. g4 g g8 g a2-> a4 a bes2-> bes4. 
          bes8 bes4-> bes8 bes a4-> a8 a g4 
          g4.-> g8 f [f] f4 f f2-> es4 d d2\fermata
          \bar"|."
        } \cadenzaOn \tonIIkf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          \partial2. d4 ees ees8 ees f2 f4 f f2 f4.
          f8 f4 f8 f f4 f8 f d4 ees4. ees8 d [d] d4 d c2 c4 a b2
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Les rois de la ter -- re se lè -- vent,
      les prin -- ces se sont as -- sem -- blés
      con -- tre le Sei -- gneur et con -- tre son Christ.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure 
          \partial2. b4 c4 c8 c c2 c4 c d2 d4.
          d8 d4 d8 d c4 c8 c b4 c4. c8 a [a] bes4 bes a2 g4 fis g2
        } \cadenzaOn\tonIIkh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          \partial2. g4 c, c8 c f2-> f4 f bes,2-> bes4.
          bes8 bes4-> bes8 bes f'4-> f8 f g4
          c,4.-> c8 d [d] bes4 bes f'2-> c4 d g,2\fermata
        } 
      }
   >>
>>