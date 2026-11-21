\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/8 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\transpose b g 
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme et joyeux" 4. = 66
         \partial8 b8 b4. b8 a b c4. b4 a8 b4.\allowBreak
         d8 d d e4 e8 d4 c8 b4 \allowBreak d8 c4 b8 a4.\resp
         a8 a a g4 a8 b4. b8 [b b] c b a b4.\resp
         \silN d8 e4 e8 e ([d) c] d4 b8 c4 c8 b4.
         \bar"|."
       } \tonVIff
       %\tonIVhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g8 g4. g8 g g g4. fis4 fis8 g4. g8 g g g4 g8 g4 fis8 g4
         g8 e ([fis) g] fis4.
         fis8 fis fis e4 fis8 g4. g8 [g g] g g g g4.
         s4 g8 g4 g8 g4 g8 g4 g8 g4 fis8 g4.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Un as -- tre s’est le -- vé en Ja -- cob,
     un homme est né en Is -- ra -- ël,
     al -- lé -- lu -- ia_!
     "“Je" suis le re -- je -- ton de la li -- gnée de Da -- vid,
     l’é -- toi -- le ra -- di -- eu -- se du ma -- "tin !”"
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 d4. d8 c d e4. d4 d8 d4. b8 b b c4 c8 b4 a8 g4
          b8 c4 d8 d4.
          d8 d d b4 d8 d4. d8 [d d] e d c d4.
          \silN b8 c4 c8 c [(b) a] b4 d8 e4 d8 d4.
        } \tonVIfh
        %\tonIVhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 g4. g8 g g c,4. d4 d8 g4. g8 g g c,4 c8 d4 d8 g4
          g8 a4 g8 d4.\resp
          d8 d d e4 e8 g4. g8 [g g] c, c c g'4.\resp
          s4 g8 c,4 c8 c4 c8 g'4 g8 c,4 d8 g4.
        } 
      }
   >>
>>