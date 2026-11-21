\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new NullVoice = "aligne" { << \armure  >> }
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo  8 = 144
         b8 [b16 b] e,8 [b'] c16 [(b) a8] b [e,] \resp
         b'8 [b16 b] e,8 [b'] c16 [b a8] b4\fermata\bar"|"
         d8 [d16 d] a8 ([d]) e [c] d [a] \resp
         d8 [d16 d] a8 ([d]) e [c] d2\fermata         
         \bar"|."
       } \tonIIIbf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       { 
         s1 s1 a8 [a16 a] g8 [(a]) c [g] a [fis]
         a8 [a16 a] g8 [(a]) c [g] a2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Le Sei -- gneur est vê -- tu de gloi -- re.
     Il é -- ta -- blit son trône à ja -- mais_:
     À lui re -- vient la vic -- toi -- re.
     À lui la gloire et l’hon -- neur.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          s1 s1 fis8 [fis16 fis] e8 ([fis]) g [e] fis [d]
          fis8 [fis16 fis] e8 ([fis]) g [e] fis2
        } \tonIIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          e8 [e16 e] b'8 [e,] d [a'] e [b'] \resp
          e,8 [e16 e] b'8 [e,] d16 [d16 a'8] e4\fermata
          d8 [d16 d] a'8 ([d,]) c [e] d [a']\resp
          d,8 [d16 d] a'8 ([d,]) c [e] d2\fermata          
        } 
      }
   >>
>>