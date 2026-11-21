\version "2.24.0"
%\include "TonsDef.ly"
armure = { \key f \major \time 3/8 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn%\tempo "" 2. = 50
          \partial8 f8 g a a4. a8 g a bes4. a8 g f a4.\resp
          f8 f g g4. g8 f g a4. g4 f8 f4.\fermata\resp
          f8 g a a4 a8 a [g a] bes4. a8 g f a4 a8\resp
          a4. a8 g a bes4. a8 g f a4. a\fermata\resp
          a4 c8 c4. d8 c bes a4 a8 \resp
          a4 g8 bes4 a8 g4 f8 a [f g] a4.\fermata\resp
          g8 (a g f4) e8 d [e f] g4 a8 g4. \resp
          g4 a8 f4 (e8) d [(c) d] e (f e) d4. d\fermata
          \bar "|."
        } \tonIdf
        %\tonIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          c8 c f f4. f8 f f f4. f8 f c f4.
          c8 c d d4. d8 d d e4. d4 d8 c4.
          c8 c f f4 f8 f [f f] f4. f8 f c f4 f8 f4. f8 f f f4. f8 f c f4. f
          f4 f8 f4. f8 [f c16 (e)] f4 f8 
          f4 d8 d [(e) f] e4 d8 c [d e] f4.
          c4.~ c4 c8 bes [c c] c4 c16 (d) e4. 
          e4 f8 d4 (c8) d [(c) d] c4. a4 (bes8) a4.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto soprano 
   { 
      C’est au -- jour -- d’hui qu’est né Jé -- sus, le Fils de Dieu.
      C’est au -- jour -- d’hui qu’est ap -- pa -- ru le Sau -- veur.
      C’est au -- jour -- d’hui qu’e -- xul -- tent 
      les an -- ges sur la ter -- re,
      que se ré -- jou -- is -- sent les ar -- chan -- ges.
      Au -- jour -- d’hui, la terre e -- xul -- te 
      et les an -- ges crient de joie en chan -- tant_:
      Gloire à Dieu au plus haut des cieux, 
      al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure\cadenzaOn
          a8 bes c c4. c8 bes c d4. c8 bes a c4.
          a8 a bes bes4. bes 8a bes c4. bes4 bes8 a4.
          a8 bes c c4 c8 c [bes c] d4. c8 bes a c4 c8
          c4. c8 bes c d4. c8 bes a c4. c
          c4 a8 a4. bes8 a bes c4 c8 
          c4 bes8 bes4 c8 c4 a8 a [bes bes] c4.
          a8 (bes c a4) g8 f [g f] e4 f8 c'4. 
          c4 c8 bes4 (g8) a [(bes) a] g (a g) f4 (g8) a4.
        } \tonIdh
        %\tonIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          f8 f f f4. f8 f f bes,4. f'8 f f f4.\resp
          f8 f f f4. f8 f f c4. c4 c8 f4.\fermata\resp
          f8 f f f4 f8 f [f f] bes,4. f'8 f f f4 f8 \resp
          f4. f8 f f bes,4. f'8 f f f4. f\fermata\resp
          f4 f8 f4. bes,8 f' g f4 f8 \resp
          f4 g8 g4 f8 c4 d8 f bes16 (a) g8 f4.\fermata\resp
          f4.~ f4 c8 d [c g] c4 f8 c4.\resp
          c4 f8 bes4 (g8) f4 f8 c4. d d\fermata
        }
      }
   >>
>>