\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn
         d8 [fis] g ([a]) a4.\fermata\resp
         b8 d [d] a [b] a4 a8 [fis] g [a] a4\resp
         g8 [e^\markup\italic"rall."] d4 d\fermata\bar"|"
         g8 [fis] e^\markup\italic"large et en-dehors" [g] a [(b)] a4\allowBreak
         a8 [b] a [g] g [fis] e4.\resp fis8 e ([fis]) d4\fermata d\fermata
         \bar"|."
       } \tonVIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d8 [fis] g ([a]) a4. d,8 d [d] d [c] d4 d8 [a16 (b)] c8 [c] d4
         b8 [c16 (b)] b8 ([a]) a4 e'8 [d] d [b] b16 ([cis d e]) e4
         e8 [e] c [c] b [b] c!4. c8 b ([a]) g4 a
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     La gloi -- re du Sei -- gneur rem -- plit l’u -- ni -- vers, 
     al -- lé -- lu -- ia_!
     É -- le -- vé de ter -- re, il at -- ti -- re tout à lui, 
     al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          d8 [fis] g ([a]) a4. b8 a [g] fis [e] fis4 a16 ([g) fis8]
          e16 [(d) e8] fis4 g8 [g] fis ([g]) a4 b8 [cis] b16 [(a) g (fis)]
          g ([a b8]) cis!4 b8 [b] a [a] fis [fis] g4. g8 fis4 e fis
        } \tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d8 [fis] g ([a]) a4.\fermata\resp g8 fis [e] d [c] d4
          fis16 [(e) d8] c16 [(b) a8] d4\resp
          e16 [(d) c8] d ([e]) fis4\fermata
          g8 [a] g16 [(fis) e (d)] e8 ([fis16 g)] a4 g8 [g] e [e]
          d [d] c4.\resp c8 d4 d\fermata d\fermata
        } 
      }
   >>
>>