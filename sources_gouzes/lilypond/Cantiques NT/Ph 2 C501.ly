\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

Rs = { a4 a bes2 a4 a bes2 c4 d ees (d) ees c d2 (c) bes1\fermata \bar"|."}
Ra = { fis!4 fis g2 fis!4 fis g2 a4 bes c (bes) c a bes2 (fis!) g1 }
Rt = { d4 d d2 d4 d d2 f4 f f2 f4 f f2 (d) d1 }
Rb = { d4 d g2 d4 d g2 f4 f f2 f4 f bes2 (a) g1\fermata }
RT = \lyricmode { 
  \override Lyrics.LyricText.font-series = #'bold
  Jé -- sus Christ est Sei -- gneur à la gloi -- re du Pè -- re. 
  \revert Lyrics.LyricText.font-series }

cIs = \relative c'' {
  d\breve*1/16 c4 bes2 (a) bes\resp
  bes4 bes c d d c bes a2 \bar "|" 
  bes\breve*1/16 a\breve*1/16  g2\fermata\bar "|." }
cIa = \relative c'' {
  bes\breve*1/16 a4 g2 (fis!) g g4 g a bes bes a g fis!2
  g\breve*1/16 fis!\breve*1/16 g2 }
cIt = \relative c' {
  f\breve*1/16 f4 d1 d2 d4 d f f f f d d2 
  d\breve*1/16 d\breve*1/16 bes2 }
cIb = \relative c' {
  bes\breve*1/16 f4 g2 (d) g\resp g4 g f bes bes f g d2
  g\breve*1/16 d\breve*1/16 g2\fermata }
cIT = \lyricmode { 
  "Jésus, qui était de condition" di -- vi -- ne, 
  ne re -- tint pas ja -- lou -- se -- ment 
  "le rang qui l’éga" -- "lait à" Dieu. }

cIIs = \relative c'' {
  d\breve*1/16 c4 bes2 (a) bes\resp
  bes4 bes c d c bes a2 a \bar "|" 
  bes\breve*1/16 a\breve*1/16 g2\fermata\bar "|." }
cIIa = \relative c'' {
  bes\breve*1/16 a4 g2 (fis!) g g4 g a bes a g fis!2 fis
  g\breve*1/16 fis!\breve*1/16 g2 }
cIIt = \relative c' {
  f\breve*1/16 f4 d1 d2 d4 d f f f d d2 d
  d\breve*1/16 d\breve*1/16 bes2 }
cIIb = \relative c' {
  bes\breve*1/16 f4 g2 (d) g\resp g4 g f bes f g d2 d
  g\breve*1/16 d\breve*1/16 g2\fermata }
cIIT = \lyricmode { 
  "Mais il s’anéantit" lui_- mê -- me, 
  pre -- nant con -- di -- tion d’es -- cla -- ve, 
  "devenant semblable aux" hom -- mes. }

cIIIs = \relative c'' {
  d\breve*1/16 c4 bes2 (a) bes\resp
  bes4 bes c d2 c4 bes a2 a \bar "|" 
  bes\breve*1/16 a2\resp
  bes\breve*1/16 a\breve*1/16 g2\fermata\bar "|." }
cIIIa = \relative c'' {
  bes\breve*1/16 a4 g2 (fis!) g g4 g a bes2 a4 g fis!2 fis
  g\breve*1/16 fis!2 g\breve*1/16 fis!\breve*1/16 g2 }
cIIIt = \relative c' { 
  f\breve*1/16 f4 d1 d2 d4 d f f2 f4 d d2 d
  d\breve*1/16 d2 d\breve*1/16 d\breve*1/16 bes2 }
cIIIb = \relative c' {
  bes\breve*1/16 f4 g2 (d) g\resp g4 g f bes2 f4 g d2 d
  g\breve*1/16 d2\resp g\breve*1/16 d\breve*1/16 g2\fermata }
cIIIT = \lyricmode {  
  "À son aspect reconnu pour" un hom -- me, 
  il s’hu -- mi -- lia plus en -- co -- re,
  "obéissant jusqu’à la" mort, 
  "à la" "mort sur une" croix. }

cIVs = \relative c'' {
  d\breve*1/16 c4 bes2 a bes\resp
  bes4 bes c d c bes a2 \bar "|" 
  bes\breve*1/16 a\breve*1/16 g2\fermata\bar "|." }
cIVa = \relative c'' {
  bes\breve*1/16 a4 g2 fis! g g4 g a bes a g fis!2
  g\breve*1/16 fis!\breve*1/16 g2 }
cIVt = \relative c' {
  f\breve*1/16 f4 d2 d d d4 d f f f d d2 
  d\breve*1/16 d\breve*1/16 bes2 }
cIVb = \relative c' {
  bes\breve*1/16 f4 g2 d g\resp g4 g f bes f g d2
  g\breve*1/16 d\breve*1/16 g2\fermata }
cIVT = \lyricmode { 
  "C’est pourquoi Dieu" l’a ex -- al -- té
  et lui a don -- né le Nom "au-des" -- "sus de tout" nom. }

cVs = \relative c'' {
  d\breve*1/16 c4 bes2 (a) bes\resp
  bes4 bes c d d c bes a2 \bar "|" 
  bes\breve*1/16 a2 (bes) a\fermata\bar "|." }
cVa = \relative c'' {
  bes\breve*1/16 a4 g2 (fis!) g g4 g a bes bes a g fis!2
  g\breve*1/16 fis!2 (g) fis!2 }
cVt = \relative c' {
  f\breve*1/16 f4 d1 d2 d4 d f f f f d d2 
  d\breve*1/16 d1 d2 }
cVb = \relative c' {
  bes\breve*1/16 f4 g2 (d) g\resp g4 g f bes bes f g d2
  g\breve*1/16 d2 (g) d\fermata }
cVT = \lyricmode { 
  "Afin qu’au nom de Jésus, tout genou" flé -- chis -- se
  au ciel, sur terre et aux en -- fers,
  "et que toute langue pro" -- cla -- me_: }

cVIs = \relative c'' {
  d\breve*1/16 c4 bes2 a bes\resp
  bes4 c d2 c4 bes a2 \bar "|" 
  bes\breve*1/16 a\breve*1/16 g2\fermata\bar "|." }
cVIa = \relative c'' {
  bes\breve*1/16 a4 g2 fis! g g4 a bes2 a4 g fis!2
  g\breve*1/16 fis!\breve*1/16 g2 }
cVIt = \relative c' {
  f\breve*1/16 f4 d2 d d d4 d f2 f4 d d2
  d\breve*1/16 d\breve*1/16 bes2 }
cVIb = \relative c' {
  bes\breve*1/16 f4 g2 d g\resp g4 f bes2 f4 g d2
  g\breve*1/16 d\breve*1/16 g2\fermata }
cVIT = \lyricmode {  
  "Gloire au Père, au Fils," au Saint Es -- prit,
  main -- te -- nant et tou -- jours, 
  "dans les siècles des" "siècles. A" -- men_! }

\transpose a fis
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         \Rs%\cIs\cIIs\cIIIs\cIVs\cVs\cVIs
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         \Ra%\cIa\cIIa\cIIIa\cIVa\cVa\cVIa
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     \set stanza = " Ref. "\RT
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \Rt%\cIt\cIIt\cIIIt\cIVt\cVt\cVIt
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \Rb%\cIb\cIIb\cIIIb\cIVb\cVb\cVIb
        } 
      }
   >>
>>

\transpose a fis
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
%         \cIs\break\cIIs\break\cIIIs\break\cIVs\break\cVs\break\cVIs
         \cIs\cIIs\cIIIs\cIVs\cVs\cVIs
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         \cIa\cIIa\cIIIa\cIVa\cVa\cVIa
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     \set stanza = "1."\cIT
     \set stanza = "2."\cIIT
     \set stanza = "3."\cIIIT
     \set stanza = "4."\cIVT
     \set stanza = "5."\cVT
     \set stanza = "Dox."\cVIT
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \cIt\cIIt\cIIIt\cIVt\cVt\cVIt
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \cIb\cIIb\cIIIb\cIVb\cVb\cVIb
        } 
      }
   >>
>>

\layout {
  \context {
    \Lyrics
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}