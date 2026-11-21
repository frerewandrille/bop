\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose f ees
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         f8 [a] c4. (d8 c [b] d4. e8 c [b]) c4 (a\fermata)\bar"|"
         a8 [c] d [c] b [c] a4.\allowBreak%\breathe dans l’original
         c8 d16 ([c b a] c8 [a]) a4.\resp
         a8 c [c] b [c] a4.\fermata\bar"|"
         a8 g [a] f4. g8 g ([a]) f4 f\fermata
         \bar"|."
       } \tonVff
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f8 [e] d4. (g8 f [e] d4. a'8 g4) f8 ([e] d4)
         a'8 [a] g [g] g [g] f4. a8 g4 (f8 [g]) a4.
         f8 a [a] g [g] f4. f8 d [d] c4. d8 d4 c c
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Le Sei -- gneur a ré -- vé -- lé sa gloi -- re 
     à tou -- tes les na -- tions_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f\breve*1/8 s s s s s s f4~ f
          d'8 [d] e [e] e [e] d4. f8 e4 (d8 [e]) f4.
          d8 e [e] e [e] d4. d8 b [b] a4. b8 b4 a a
        } \tonVfh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f\breve*1/8 s s s s s s f4~ f\fermata
          f8 [f] a [a] c [c] d4. d8 a ([c] d4) d4.\resp
          d8 a [a] c [c] d4.\fermata
          f,8 f [f] f4. f8 f4 f f\fermata
        } 
      }
   >>
>>