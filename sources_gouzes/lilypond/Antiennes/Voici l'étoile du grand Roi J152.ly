\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/8 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\transpose b a 
\new ChoirStaff
<< \new Dynamics 
   { \override Hairpin.to-barline = ##f
     b8 a b c4 c8 b4 a8 b4
     d8 e4 e8 d4 c8 b4 (d8) \allowBreak 
         c4 b8 a4 a8 a4 a8 g4 a8 b4. b
         b8\pp [b b] c (b) a b4
         d8\f\< e4 e8 e ([d) c] d4\! b8  c8 c c b4.
   }
   \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme et joyeux" 4. = 66
         \partial8 b8 a b c4 c8 b4 a8 b4\resp
         d8 e4 e8 d4 c8 b4 (d8) \allowBreak 
         c4 b8 a4 a8 a4 a8 g4 a8 b4. b\bar"|"
         b8 [b b] c (b) a b4\resp
         d8 e4 e8 e ([d) c] d4 b8 \resp c8 c c b4.\fermata
         \bar"|."
       } \tonVIff
       %\tonIVhf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g8 g g g4 g8 fis4 fis8 g4 
         g8 g4 g8 g4 fis8 g4. e8 ([fis) g] fis4 fis8 fis4 fis8 e4 fis8 g4. g
         g8 g g g4 e8 g4 g8 g4 g8 g4 g8 g4 g8 g [g fis] g4.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci l’é -- toi -- le du grand Roi.
     Voi -- ci l’A -- gneau de Dieu
     qui en -- lè -- ve les pé -- chés du mon -- de.
     Voi -- ci l’É -- poux qui vient,
     ve -- nez à sa ren -- con -- tre,
     al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 d d e4 e8 d4 c8 d4 b8 c4 c8 b4 a8 g4 (b8) c4 d8
          d4 d8 d4 d8 b4 d8 d4. d
          d8 [d d] e (d) c d4 b8 c4 c8 c [(b) a] b4 d8 e [e d] d4.
        } \tonVIfh
        %\tonIVhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 g g c,4 c8 d4 d8 g4 \resp
          g8 c,4 c8 d4 d8 g4. a4 g8 d4 d8 d4 d8 e4 d8 g4. g
          g8 g g c,4 c8 g'4\resp g8 c,4 c8 c4 c8 g'4 g8 \resp
          c, c d8 g4.\fermata
        } 
      }
   >>
>>