\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose a g
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         e4 (f16 [d]) g8 ([e g]) a ([g a] c [b c]) c4\fermata\bar"|"
         a8 c [b] a [d] c [b] c4\resp
         c8 [c] b [a] d4 (e8) [d] c [b] a4.\resp
         a8 a4 a8 [g] b [b] a4\fermata
         \bar"|."
       } \tonIIIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e\breve*12/16 a4 a8 a [a] a [a] a [a] a4
         a8 [a] a [a] a4. a8 a8 [g] f4. f8 f4 f8 [e] e [d] e4
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_!
     Nous a -- vons é -- té en -- gen -- drés à la vie nou -- vel -- le
     par le Christ, Pa -- ro -- le du Dieu vi -- vant.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4. b c (e) f4 f8 e [d] c [f] e [d] e4
          e8 [e] d [c] f4 (g8) [f] e [d] c4. 
          c8 c4 c8 [b] b [b] c4
        } \tonIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          <a e'>4. e' f (a) a4\fermata
          a8 a [a] a [f] f [f] e4\resp 
          e8 [e] e [e] f4. f8 f8 [f] f4.\resp
          f8 f4 f8 [g] g [e] <a, a'>4\fermata
        } 
      }
   >>
>>