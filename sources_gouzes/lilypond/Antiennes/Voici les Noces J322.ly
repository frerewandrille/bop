\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 2/2 }
resp = { \breathe\allowBreak }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Dynamics 
   {
     b8^\< [(c)] b [a] g4.^\> a8 b4 c a2\!
     b8\rest a^\< b [c] d4\! d8 [d] d [d] 
     c4^\> (b8 [d] c [b]) a4\!
     a8\p^\< [a] b2^\> g4.\!
     g8 g [g] g [g] b4 b8 [a]^\> g2 (a) b\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très vif" 2 = 56
         b8 [(c)] b [a] g4. a8 b4 c a2\resp
         \silC a8 b [c] d4 d8 [d] d [d] 
         c4 (b8 [d] c [b]) a4\resp
         a8 [a] b2 g4. \allowBreak
         g8^\markup\italic"poco accel." 
         g [g] g [g] b4 b8 [a] g2 (a) b\fermata
         \bar"|."
       } \tonIIIdf
       %\tonVIbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c''
       { 
         g4 g8 [fis] e4. fis8 g4 g fis2 s8 fis g [fis] 
         g4 g8 [g] g [g] fis4 (g fis8 [g]) fis4 fis8 [fis] fis2 e4.
         e8 e [e] e [e] fis4 fis8 [fis] e2 (fis) fis
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Voi -- ci les No -- ces de l’A -- gneau_!
     Vers lui s’a -- van -- ce dans l’al -- lé -- gres -- se 
     son é -- pou -- se,
     vê -- tue d’u -- ne lu -- mière é -- cla -- tan -- te.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 [(e)] d [d] b4. d8 d4 e d2 \silC d8 d [d] d4 b8 [d] c [b] 
          a4 (g8 [b] a [b]) d4 d8 [d] dis2 b4.
          b8 b [b] b [b] dis!4 dis8 [dis] b2 (d) dis
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g8 [d] e4. d8 g4 c, d2\resp
          s8 d g [a] b4 g8 [b] a [g] d2. d4\resp d8 [d] b2 e4.
          e8 e [e] e [e] b4 b8 [b] e2 (d) b\fermata
        } \tonIIIdh
        %\tonVIbh
      }
   >>
>>