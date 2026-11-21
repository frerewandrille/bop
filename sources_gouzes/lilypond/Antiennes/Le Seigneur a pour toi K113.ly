\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key d \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Léger et doux" 2. = 50
          a2 a4 a-> f g a-> a a bes-> bes bes a2. g\resp
          c4-> a bes c2. bes2 bes4 a2.\resp a4->^\markup{\italic"retenu"} a g f2 
          f4 bes->^\markup{\italic"vif"} bes a g2. a
          \bar"|."
        } \transpose b a \tonVIff % Ton à quatre stiques dans l’original
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f2 f4 f c e f f f f f f f2. e f4 f f f2. g2 g4 e2. 
          e4 e e f2 f4 f f f e2. f
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Le Sei -- gneur a pour toi don -- né ordre à ses an -- ges 
      de te por -- ter dans leurs mains, 
      pour que ton pied ne heur -- te la pier -- re.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 c4 c a c c c c d d d c2. c c4 c c c2. d2 d4 cis2.
          cis!4 cis cis d2 d4 d d c c2. c
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f4 f-> f c f-> f f bes,-> bes bes f'2. c\resp
          a'4-> f g a2. g2 g4 a2.\resp
          a4-> a a bes2 bes4 bes,-> bes f' c2. f
        } \transpose b a \tonVIfh
      }
   >>
>>