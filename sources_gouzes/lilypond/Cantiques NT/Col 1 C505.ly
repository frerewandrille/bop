\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

Rs = { b2-> (a4) b c-> (b^\>) a2 g\! \resp
       a4 b c-> (b) a-> g a2^\> g1\!\fermata \bar"|."}
Ra = { g2. g4 g2 d d e4 g a (g) fis g fis2 d1 }
Rt = { d2 (c4) d e (d) c2 b c4 d e (d) c b c2 b1 }
Rb = { g2. g4 g2-> fis g\resp c,4 b a-> (b) d-> d d2 <g, g'>1\fermata }
RT = \lyricmode { 
  \override Lyrics.LyricText.font-series = #'bold
  Gloire à toi, Sei -- gneur, pre -- mier_- né d’en -- tre les morts_!
  \revert Lyrics.LyricText.font-series }

cIs = \relative c'' {
  b\breve*1/16 c2-> (b4 a) g2\bar "|" 
  g\breve*1/16 a2 a4 a 
  g\breve*1/16 fis2 g2\fermata\bar "|." }
cIa = \relative c'' {
  g\breve*1/16 g2. (fis4) e2
  e\breve*1/16 e2 e4 e e\breve*1/16 dis2 e }
cIt = \relative c' {
  d\breve*1/16 e2 (d4 c) b2
  b\breve*1/16 c2 c4 c b\breve*1/16 b2 b }
cIb = \relative c' {
  g\breve*1/16 c,2-> (d) e
  e\breve*1/16 a,2 a4 a e'\breve*1/16 b2 e\fermata }
cIT = \lyricmode { 
  "Rendons grâce à Dieu le" Pè -- re
  "qui nous appelle à partiger l’héri" -- ta -- ge des "saints dans la lu" -- miè -- re. }

cIIs = \relative c'' {
  b\breve*1/16 a2\espressivo b\resp 
  b\breve*1/16 c2-> b4 a g2\bar "|" 
  g\breve*1/16 a2 a4 a a
  g2 fis4 fis g2\fermata\bar "|." }
cIIa = \relative c'' {
  g\breve*1/16 fis2 fis
  g\breve*1/16 g2 g4 fis4 e2
  e\breve*1/16 e2 e4 e e e2 dis!4 dis e2 }
cIIt = \relative c' {
  d\breve*1/16 d2 d
  d\breve*1/16 e2 d4 c b2
  b\breve*1/16 c2 c4 c c b2 b4 b b2 }
cIIb = \relative c' {
  g\breve*1/16 d2 b\resp
  g'\breve*1/16 c,2-> d4 d e2
  e\breve*1/16 a,2 a4 a a e'2 b4 b e2\fermata }
cIIT = \lyricmode { 
  "Il nous a arrachés au pouvoir des té" -- nè -- bres_;
  "il nous a transférés dans le Royaume de son" Fils Bien_- ai -- mé,
  "en qui nous avons la déli" -- vrance 
  et le par -- don des pé -- chés. }

cIIIs = \relative c'' {
  b\breve*1/16 a2\espressivo b\resp 
  b\breve*1/16 c4-> c b4 a g2 g\bar "|" 
  g\breve*1/16  a2 a4 a g2\resp 
  g\breve*1/16 fis2 fis4 fis fis g2\espressivo g\fermata\bar "|." }
cIIIa = \relative c'' {
  g\breve*1/16 fis2 fis
  g\breve*1/16 g4 g g4 fis4 e2 e
  e\breve*1/16 e2 e4 e e2 
  e\breve*1/16 dis!2 dis4 dis dis e2 e }
cIIIt = \relative c' {
  d\breve*1/16 d2 d
  d\breve*1/16 e4 e d4 c b2 b
  b\breve*1/16 c2 c4 c b2 
  b\breve*1/16 b2 b4 b b b2 b }
cIIIb = \relative c' {
  g\breve*1/16 d2 b\resp
  g'\breve*1/16 c,4-> c d4 d e2 e
  e\breve*1/16 a,2 a4 a e'2\resp
  e\breve*1/16 b2 b4 b b e2 e\fermata }
cIIIT = \lyricmode { 
  "Il est l’image du Dieu invi" -- si -- ble,
  "le Premier-né de" tou -- te cré -- a -- tu -- re,
  "car c’est en lui que" fu -- rent cré -- ées
  "toutes choses dans les" cieux et sur la ter -- re. }

cIVs = \relative c'' {
  b\breve*1/16 a2 a4 a b2\resp 
  b\breve*1/16 c2-> (b4 a) g2\bar "|" 
  g\breve*1/16 a2 a4 a a g2-> fis4 fis g2\fermata\bar "|." }
cIVa = \relative c'' {
  g\breve*1/16 fis2 fis4 fis fis2
  g\breve*1/16 g2. (fis4) e2
  e\breve*1/16 e2 e4 e e e2 dis!4 dis e2 }
cIVt = \relative c' {
  d\breve*1/16 d2 d4 d d2
  d\breve*1/16 e2 (d4 c) b2
  b\breve*1/16 c2 c4 c c b2 b4 b b2 }
cIVb = \relative c' {
  g\breve*1/16 d2 d4 d b2\resp
  g'\breve*1/16 c,2-> (d) e
  e\breve*1/16 a,2 a4 a a e'2-> b4 b e2\fermata }
cIVT = \lyricmode { 
  "Tout fut créé par" lui et pour lui, 
  "les visibles et les invi" -- si -- bles. 
  "Il est avant toutes" choses et tout sub -- sis -- te par lui. }

cVs = \relative c'' {
  b\breve*1/16 c2-> b4 a g2 g\bar "|" 
  g\breve*1/16  a2 a4^"rall." a a g2\resp 
  g\breve*1/16 fis2 fis4 fis fis g2\fermata\bar "|." }
cVa = \relative c'' {
  g\breve*1/16 g2 g4 fis4 e2 e
  e\breve*1/16 e2 e4 fis fis e2 
  e\breve*1/16 dis!2 dis4 dis dis e2 }
cVt = \relative c' {
  d\breve*1/16 e2 d4 c b2 b
  b\breve*1/16 c2 c4 c c b2 
  b\breve*1/16 b2 b4 b b b2 }
cVb = \relative c' {
  g\breve*1/16 c,2-> d4 d e2 e
  e\breve*1/16 e2 e4 dis dis e2\resp
  e\breve*1/16 b2 b4 b b e2\fermata }
cVT = \lyricmode { 
  "Il est la tête du" Corps, son É -- gli -- se,
  "il est principe premier -" né d’en -- tre les morts,
  "afin qu’il ait en" tout la pri -- mau -- té. }

cVIs = \relative c'' {
  b\breve*1/16 b2 c4-> c b4 a g2 g\bar "|" 
  g\breve*1/16 a2 g4 fis g2\fermata\bar "|." }
cVIa = \relative c'' {
  g\breve*1/16 g2 g4 g g fis e2 e
  e\breve*1/16 e2 e4 dis! e2 }
cVIt = \relative c' {
  d\breve*1/16 d2 e4 e d4 c b2 b
  b\breve*1/16 c2 b4 b b2 }
cVIb = \relative c' {
  g\breve*1/16 g2 c,4-> c d4 d e2 e
  e\breve*1/16 a,2 e'4 b e2\fermata }
cVIT = \lyricmode { 
  "Car il a plu à Dieu de faire habiter en" lui
  tou -- te plé -- ni -- tu -- de,
  "de se réconcilier par" lui l’u -- ni -- vers. }

cVIIs = \relative c'' {
  b\breve*1/16 c2-> b4 a g2\bar "|" 
  g\breve*1/16 g\breve*1/16-- a2 g4 fis g2\fermata\bar "|." }
cVIIa = \relative c'' {
  g\breve*1/16 g2 g4 fis4 e2
  e\breve*1/16 e e2 e4 dis! e2 }
cVIIt = \relative c' {
  d\breve*1/16 e2 d4 c b2
  b\breve*1/16 b c2 b4 b b2 }
cVIIb = \relative c' {
  g\breve*1/16 c,2-> d4 d e2
  e\breve*1/16 e-- a,2 e'4 b e2\fermata }
cVIIT = \lyricmode { 
  "Dieu a uni en lui la" terre et le ciel "en faisant la" "paix par le" sang de sa Croix. }

cVIIIs = \relative c'' {
  b\breve*1/16 b2\resp b4 c2->\resp c4 b4-> a g2\bar "|" 
  g\breve*1/16 g2\resp g4 g a2 a4 a g2\resp
  g\breve*1/16 fis2 fis4 fis-> g2\fermata\bar "|." }
cVIIIa = \relative c'' {
  g\breve*1/16 g2 g4 g2 g4 g fis4 e2
  e\breve*1/16 e2 e4 e e2 e4 e e2
  e\breve*1/16  dis!2 dis4 dis e2 }
cVIIIt = \relative c' {
  d\breve*1/16 d2 d4 e2 e4 d4 c b2
  b\breve*1/16 b2 b4 b c2 c4 c b2
  b\breve*1/16 b2 b4 b b2 }
cVIIIb = \relative c' {
  g\breve*1/16 g2\resp g4 c,2->\resp c4 d4-> d e2
  e\breve*1/16 e2\resp e4 e a,2 a4 a e'2\resp
  e\breve*1/16 b2 b4 b-> e2\fermata }
cVIIIT = \lyricmode { 
  "Gloire au" Père, au Fils, au Saint Es -- prit,
  "comme il était au commence" -- ment, 
  main -- te -- nant et tou -- jours,
  "dans les siècles des" siè -- cles. A -- men_! }


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
     { \voiceTwo \relative c''
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
      { \voiceTwo \relative c'
        { 
          \Rb%\cIb\cIIb\cIIIb\cIVb\cVb\cVIb
        } 
      }
   >>
>>

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
%         \cIs\break\cIIs\break\cIIIs\break\cIVs\break\cVs\break\cVIs\break\cVIIs\break\cVIIIs
         \cIs\cIIs\cIIIs\cIVs\cVs\cVIs\cVIIs\cVIIIs
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         \cIa\cIIa\cIIIa\cIVa\cVa\cVIa\cVIIa\cVIIIa
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
     \set stanza = "6."\cVIT
     \set stanza = "7."\cVIIT
     \set stanza = "Dox."\cVIIIT
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \cIt\cIIt\cIIIt\cIVt\cVt\cVIt\cVIIt\cVIIIt
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \cIb\cIIb\cIIIb\cIVb\cVb\cVIb\cVIIb\cVIIIb
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