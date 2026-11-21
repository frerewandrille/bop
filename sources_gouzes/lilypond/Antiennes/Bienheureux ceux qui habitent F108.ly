\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


\transpose aes f
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key aes \major \time 2/2 \cadenzaOn %\tempo "" 2 = 52
          aes8 [bes] bes4. bes8 c [des] c [bes] bes [aes] bes4. \breathe\allowBreak
          c8 c [bes] \allowBreak c [d] c ([bes] c [f,]) f4.\fermata\breathe\allowBreak
          f8 aes4. aes8 bes [c] c2 \bar "|."
        }\transpose bes aes \tonVIIIbf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          ees8 [f] f4. f8 g [aes] g [f] f [ees] f4. 
          ees8 ees [d] ees [f] ees16 ([f g8] aes [ees]) d!4.
          d8 f4. f8 f [f] aes2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Bien -- heu -- reux ceux qui ha -- bitent en ta mai -- son_! 
      Ils chan -- tent ta lou -- an -- ge, au -- tour de ton au -- tel.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key aes \major \time 2/2 \cadenzaOn
          c8 [des] des4. des8 ees [f] ees [des] des [c] des4.
          c8 c [d!] c [bes] c ([ees16 d!] c4) bes4. bes8 c4. c8 d! [d] ees2
        } \transpose bes aes \tonVIIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          aes\breve*3/4 aes4.\breathe aes8 aes [bes] aes [g] aes ([bes] aes4) bes4.\fermata\breathe
          bes8 f4. f8 aes [aes] aes2
        }
      }
   >>
>>