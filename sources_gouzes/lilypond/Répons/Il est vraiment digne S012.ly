\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

global = {\key d \major \time 3/4}
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \global \cadenzaOn %\tempo "" 2 = 52
          a\breve*1/8 d2\resp cis2 cis4 b a2 \bar "|"
          a\breve*1/8 b2\resp a2 a4 a a a fis2
          \once \override Score.RehearsalMark.break-visibility = #end-of-line-visible
          \mark "Fin"\bar "|."
          
          a\breve*1/8 d2 d\resp cis4 cis cis4 b a2 \bar "|"
          a\breve*1/8 b2 b\resp a4 a a a fis2\bar "||"
          
          a2 a4 a d2 d\allowBreak cis4 cis cis4 b a2 \bar "|"
          a\breve*1/8 b2 b4 a2 a4 a fis2\bar "||"
          
          a\breve*1/8 d2 cis2 cis4 b a2 \bar "|"
          b2 b a2 a fis2\bar "||"
          
          a4 a a2 a4 d2 cis4 cis b a2 \bar "|"
          a\breve*1/8 a2\resp 
          a\breve*1/8 b2 a4 a fis2\bar ":|."\mark "D.C."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          fis\breve*1/8 fis2\resp eis!2 eis4 eis fis2 \bar "|"
          fis\breve*1/8 d2\resp cis2 cis4 cis cis cis d2\bar "|."
          
          fis\breve*1/8 fis2 fis\resp eis!4 eis eis4 eis fis2 \bar "|"
          fis\breve*1/8 d2 d\resp cis4 cis cis cis d2\bar "||"
          
          fis2 fis4 fis fis2 fis\allowBreak eis!4 eis eis4 eis fis2 \bar "|"
          fis\breve*1/8 d2 d4 cis2 cis4 cis d2\bar "||"
          
          fis\breve*1/8 fis2 eis!2 eis4 eis fis2 \bar "|"
          d2 d cis cis d\bar "||"
          
          fis4 fis fis2 fis4 fis2 eis!4 eis eis fis2 \bar "|"
          fis\breve*1/8 fis2\resp 
          fis\breve*1/8 d2 cis4 cis d2\bar ":|."
        }          
      }
      \new Voice = "basse"
      { \voiceTwo \global \cadenzaOn \relative c' 
        {
          d\breve*1/8 b2\resp cis2 cis4 cis fis2 \bar "|"
          d\breve*1/8 g,2\resp a2 a4 a a a d2\bar "|."
          
          d\breve*1/8 b2 b\resp cis4 cis cis4 cis fis2 \bar "|"
          d\breve*1/8 g,2 g\resp a4 a a a d2\bar "||"
          
          d2 d4 d b2 b\allowBreak cis4 cis cis4 cis fis2 \bar "|"
          d\breve*1/8 g,2 g4 a2 a4 a d2\bar "||"
          
          d\breve*1/8 b2 cis2 cis4 cis fis2 \bar "|"
          g,2 g a a d\bar "||"
          
          d4 d d2 d4 b2 cis4 cis cis fis2 \bar "|"
          d\breve*1/8 d2\resp 
          d\breve*1/8 g,2 a4 a d2\bar ":|."
        }
      }      
   >>
   \new Lyrics \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
     "Il est vraiment digne de te bé" -- nir, Mè -- re de Dieu,
     "toujours bienheureuse et toute immacu" -- lée,
     Mè -- re de no -- tre Dieu_!
     "Plus véné" -- ra -- ble que les Ché -- ru -- bins, 
     "et incomparablement plus glori" -- eu -- se que les Sé -- ra -- phins.
     Toi qui, sans per -- dre ton in -- té -- gri -- té, "as enfan" -- té le Ver -- be de Dieu,
     "Tu es vrai" -- ment Mè -- re de Dieu_: nous te glo -- ri -- fions.
     Gloire au Père, au Fils, au Saint Es -- prit, "au Dieu qui est, qui était et qui" vient,
     "pour les siècles des" siè -- cles. A -- men_!
   }
>>

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }{
    \global\cadenzaOn
    \tonVgf
  }
  \new Staff \with {\remove Time_signature_engraver }{
    \global\cadenzaOn \clef "bass"
    \tonVgh
  }
>>