\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     \override Hairpin.to-barline = ##f
     ees4^\f d c bes2 g4 c2. c4 c c bes2
     g4 g2 g4 
     aes g aes bes2. g2
     g4^\< g g^\> f ees2.\! f2^\< f4 
     g^\> ees f
     g2. g\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo "Vif" 2. = 63
          ees4 d c bes2 g4\breathe c2.-> c4 c c bes2\resp
          g4^\markup{\dynamic p \italic"subito"} g2-> g4 
          aes-> g aes bes2. g2\fermata\resp
          g4 g-> g f ees2. f2 f4 
          g->^\markup\italic"rall. progressivement" ees f
          g2.\fermata \noBreak g\fermata
          \bar "|."
        }\cadenzaOn \tonVaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        {
          g4 f ees d2 ees4 ees2. ees4 ees f g2 
          ees4 ees2 ees4 ees ees ees f2. ees2 ees4 ees ees d c2.
          d2 d4 d c d d2. d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     La ter -- re trem -- ble_: Pâ -- que du Sei -- gneur.
     La mer re -- tourne en ar -- riè -- re,
     le peu -- ple de Dieu mar -- che vers le Roy -- au -- me.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          bes4 bes g g2 g4 aes2. aes4 aes aes bes2
          bes4 bes2 bes4 c bes c d2. <bes ees>2
          bes4 bes bes bes g2. bes2 bes4 b g c b2. b
        }\cadenzaOn \tonVah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          ees4 bes c g2 c4\resp aes2.-> aes4 aes aes ees'2\resp
          ees4 ees2-> ees4 aes,-> ees' c bes2. ees2\fermata\resp
          ees4 ees-> ees bes c2. bes2 bes4 g-> c aes g2.\fermata g\fermata
        }
      }
   >>
>>