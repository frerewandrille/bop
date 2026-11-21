\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose g e
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \accidentalStyle forget
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
          g4 ees-> ees f g2. bes4-> c bes bes2. g\allowBreak
          ees'4 d bes c2 (bes4) bes2.\fermata\allowBreak
          bes2 c4 bes2. a2 bes4 g2\resp
          f4^\markup{\dynamic p \italic "rall."}
          g2\fermata ees4\fermata ees2.\fermata
          \bar"|."
        } \tonVdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          ees4 c c d ees2. g4 aes f g2. ees g4 g g ees (f g) g2.
          g2 aes4 f2. f2 f4 ees2 c8 ([d]) ees2 bes4 bes2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Sei -- gneur, nous t’of -- frons le sa -- cri -- fi -- ce
      d’ac -- tion de grâ -- ce_:
      Fais_- nous voir le sa -- lut qui vient de toi_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes4 aes aes aes bes2. ees4 ees d d2. 
          c c4 bes d c2 (d4) ees2.
          ees2 ees4 d2. c2 d 4bes2 a4 bes2 g4 g2.
        } \tonVdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          ees4 aes-> aes8 ([g]) f4 ees2. ees4-> aes bes g2. c,
          c4 g' g aes2 (bes4) ees,2.\fermata
          ees2 aes4 bes2. f2 d4 ees2\resp
          f4 ees2\fermata ees4\fermata ees2.\fermata
        } 
      }
   >>
>>