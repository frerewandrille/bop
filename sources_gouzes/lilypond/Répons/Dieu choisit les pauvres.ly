\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose c a,
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 2/2 \cadenzaOn \tempo "Comme un carillon"% 2 = 52
          c4^\pp->^\< g a?-> f g2 ees \breathe c' ees4-> d c2 c\!\fermata \bar "|"
          c4^\markup{ {\dynamic ff} \italic dansant}-> g a8-> ([g]) f4 g2 ees \breathe c' ees4-> d c2 c\fermata \bar "|."
        }\transpose e g \tonIVcf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        { 
          g4 ees d f ees (f) g2 g c4 bes g (a) g2
          g8 ([f]) ees4 d f ees (f) g2 g c4 bes8 ([a]) g4 (a) g2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Dieu choi -- sit les pau -- vres se -- lon le mon -- de_:
     Mar -- chons à sa sui -- te vers le Roy -- au -- me.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 2/2 \cadenzaOn
          ees4 c c d ees (d) c (d) ees (d) c d ees (<d f>) ees2
          ees4 c c d ees (d) c (d) ees (d) c f ees (<d f>) ees2
        } \transpose e g \tonIVch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          c4-> ees f-> a? g (bes) g2\breathe c4 (bes) g bes c2 c\fermata
          c,8-> ([d]) ees4 f8-> ([g]) a4 g (bes) g2\breathe c4 (bes) g8 ([a]) bes4 c2 c\fermata
        }
      }
   >>
>>