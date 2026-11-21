\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Léger" %2 = 52
         d8 ([f]) d [(c)] d ([e]) e4.\fermata\resp
         e8^\markup\italic"mystérieux" e4. d8 g [g] g [a] e4.\allowBreak
         e8 f [e] d [c] d [e] e4 (f8 [d] g [e]) f [e] d4\fermata\bar"|"
         g8 [a] c [b] a [(g)] a [f] e2\resp
         \once \override NoteColumn.force-hshift = #0 c8 [e] e ([d]) f [(e] d4)\resp e8 [d] c ([d]) d2\fermata
         \bar"|."
       } \tonIef
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d8 ([f]) d ([c]) c ([b]) b4. b8 b4. c8 d [d] d [c] d4.
         d8 c [c] c [c] c [c] b4 (a b) a8 [a] a4
         d8 [d] e [e] e4 d8 [d] d2 \once\override NoteColumn.force-hshift = #1.25 d8 [d] d4 c2 b8 [b] a4 a2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     L’Es -- prit fait res -- plen -- dir sur nous
     la con -- nais -- san -- ce de la gloi -- re de Dieu
     qui est sur la fa -- ce du Christ.
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c16 ([b a b ]) c4 a b4. g8 g4. a8 b [b] a [a] b4.
          b8 a [a] a [a] a [a] g4 (f e) d8 [e] f4
          b8 [b] a [a] b4 c8 [c] b2 c8 [b] a4 a2 g8 [g] g4 a2
        } \tonIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a16 ([g f g]) a8. ([g16]) f4 e4.\fermata\resp
          c8 c4. f8 e [e] f [f] g4. g8 d [e] f [f] f [f] c2. c8 [c] c4\fermata
          e8 [e] f [f] g4 f8 [a] g2\resp 
          a8 [g] f ([e]) d ([e] f4)\resp c8 [d] e4 d2\fermata
        } 
      }
   >>
>>