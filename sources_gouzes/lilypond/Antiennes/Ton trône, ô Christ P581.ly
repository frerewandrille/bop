\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         g8 a [b] b4. b8 b [a] c4 a8 [g] g ([e]) e2\fermata\bar"|"
         g8 [a] c [b] a4\allowBreak g8 [b] g4 f8 [e] d4\fermata\bar"|"
         d8 [a'] a ([c]) g4\resp g8 [f] e4 e2\fermata
         \bar"|."
       } \tonIVmf
       %\tonIIIgf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         e8 e [e] e4. e8 e [e] d ([e]) f [f] e ([d]) d2
         e8 [e] d [d16 (f)] f4 e8 [e] e4 d8 [d] c4
         c8 [d] d16 ([e f8]) e4 e8 [d] e4 e2
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Ton trône, ô Christ,
     est à la droi -- te du Pè -- re_:
     Voi -- ci qu’il a mis tou -- tes choses à tes pieds, 
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 d [d] c4. c8 b [b] a4 a8 [a] b ([c]) b2
          d8 [c] a [b] c4 d8 [d] d ([c]) c [b] a4
          a8 [c] a4 b b8 [c] d ([c]) b2
        } \tonIVmh
        %\tonIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          b8 b [b] a4. a8 g [g] f ([e]) d16 [(e) f8] g ([a]) b2\fermata
          b8 [ a16 (g)] f8 [g] a4 b8 [b] b ([a]) a [g] f4\fermata
          f8 [a] f16 ([e d8]) g4\resp g8 [a] b ([a]) e2\fermata
        } 
      }
   >>
>>