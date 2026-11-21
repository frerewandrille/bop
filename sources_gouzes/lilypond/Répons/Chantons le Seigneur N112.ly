\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key f \major \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure %\tempo "" 2. = 50
          \partial8  d8 d4 d8 c d4 d8 d a' g g f a4. bes8 d (c a g) g4. 
          g8 g f f e a4. g8 f e d c d2\fermata
          \bar "|."
        }\cadenzaOn \tonIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial8 d8 d4 d8 c d4 d8 d a' g g f a4. bes8 d (c a g) g4.
          r8 r c, c c c c c4~ \autoBeamOff c8  
          \autoBeamOn c d e f g a4\fermata
        }          
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" }
   \lyricsto soprano 
   { 
      \repeat unfold 15 \skip4 Il a je -- té à l’eau
      che -- val et ca -- va -- lier_!
   }
   \new Lyrics %\with { alignAboveContext = "hommes" }
   \lyricsto alto 
   { 
      Chan -- tons le Sei -- gneur, 
      car il a fait é -- cla -- ter sa gloi -- re_:
      Il a je -- té à l’eau che -- val et ca -- va -- lier_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \partial8 r8 R2 a2 a a8 (g) g (f) a4. bes8 d c c a g4.
          g8 f e d c d2 (d)
        }\cadenzaOn \tonIah % Pas de ton dans l’original
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial8 d8 d4 d8 c d4 d8 c d d d c d4. d8 d (e d c) c4.
          c8 c c c c c4. c8 d e f e d2\fermata
        }
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" }
   \lyricsto ténor 
   { 
      Chan -- tons le Sei -- gneur_: 
      Il a je -- té à l’eau che -- val et ca -- va -- lier_!
   }
   \new Lyrics %\with { alignAboveContext = "hommes" }
   \lyricsto basse 
   { 
      Chan -- tons le Sei -- gneur, 
      car il a fait é -- cla -- ter sa gloi -- re_:
      Il a je -- té à l’eau che -- val et ca -- va -- lier_!
   }
>>