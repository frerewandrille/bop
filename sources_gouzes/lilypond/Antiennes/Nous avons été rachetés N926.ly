\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn
         e4 (f16 [d]) g8 ([e g]) a ([g a] c [b c]) c4\fermata\bar"|"
         a8 c [b a] d [c b] c4\resp b8 [a] d4 (e8) [d] c [b] a4.\resp
         g8 b [b] a4\fermata
         \bar"|."
       } \tonIIIaf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         e\breve*12/16 a4 8 a [a a] a [a a] a4 8 [a] a4. 8 8 [g] f4.
         e8 8 [d] e4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_! Nous a -- vons é -- té ra -- che -- tés 
     par le sang pré -- cieux du Christ,
     l’A -- gneau de Dieu.
   }
   \new Staff = "hommes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4. b c (e) f4 8 e [d c] f [e d] e4 d8 [c] f4 (g8) [f] e [d] c4.
          b8 b [b] c4
        } \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          <a e'>4. e' f (a) a4\fermata 8 8 [a a] f [f f] e4\resp
          8 [e] f4. 8 f [f] f4.\resp g8 8 [e] <a, a'>4\fermata
        } 
      }
   >>
>>