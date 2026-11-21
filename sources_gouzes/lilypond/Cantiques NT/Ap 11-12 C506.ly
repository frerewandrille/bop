\version "2.24.0"

\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes b\breve*1/16 \unHideNotes }
armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "rall." )))

Rs = { c4 c8 [b] c2\fermata\resp
       c\breve*1/16 d2-> (c4 b2->
       a4 c b2-> a) g1\fermata \bar"|."}
Ra = { g4 g8 [g] g2 g\breve*1/16 g2.~ g1. fis2 d1 }
Rt = { e4 e8 [d] e2 e\breve*1/16 f2 (e4 d2 c4 e d2 c) b1 }
Rb = { c4 c8 [g'] c,2\fermata\resp
       c\breve*1/16 g'2.~-> (g2 e4 c d1->) g\fermata }
RT = \lyricmode { 
  \override Lyrics.LyricText.font-series = #'bold
  Ô no -- tre Dieu, "nous te rendons" grâ -- ce_!
  \revert Lyrics.LyricText.font-series }

cIs = \relative c'' {
  c2->\resp b\breve*1/16 c2 (b4) a2\resp
  b4 (c d) c2 c\breve*1/16 d2 (c4) b2\bar "|" 
  c\breve*1/16 b4 c2 \allowBreak
  c\breve*1/16 b2 a4 c b2 a4 a g2 g\resp 
  c\breve*1/16 d2 b4 c2 (b) a\fermata\bar "|." }
cIa = \relative c'' {
  g2 g\breve*1/16 g2. e2 g2. g2 g\breve*1/16 g2. g2
  g\breve*1/16 g4 g2 
  g\breve*1/16 g2 g4 g g2 fis4 fis d2 d 
  g\breve*1/16 g2 g4 g1 e2 }
cIt = \relative c' {
  e2 d\breve*1/16 e2 (d4) c2 d4 (e f) e2 
  e\breve*1/16 f!2 (e4) d2
  e\breve*1/16 d4 e2 
  e\breve*1/16 d2 c4 e d2 c4 c b2 b 
  e\breve*1/16 f!2 d4 e2 (d) c2 }
cIb = \relative c {
  c2->\resp g'\breve*1/16 c,2 (g'4) a2\resp g2. c,2 
  c\breve*1/16 b2 (c4) g'2
  c,\breve*1/16 g'4 c,2 
  c\breve*1/16 g'2 e4 c d2 d4 d g2 g\resp 
  c,\breve*1/16 g'2 g4 c,2 (g') a2\fermata }
cIT = \lyricmode { 
  Dieu, "nous te rendons" grâ -- ce, 
  Sei -- gneur, "maître du" mon -- de,
  "toi qui es et qui" é -- tais, "car tu as pris en" main
  ton im -- men -- se puis -- san -- ce,
  "et tu as éta" -- blis ton Rè -- gne. }

cIIs = \relative c'' {
  a\breve*1/16 b4 c-> c b a2\allowBreak 
  a4 b c c b c d^\> c2 (b) a\!\resp 
  a4 b c2 b\breve*1/16 b4-> c b a2\bar "|" 
  b4 c d2 c\breve*1/16 d4 c b2\resp
  c4 d2 (a4) c b a g2 g\resp
  c\breve*1/16 d2 b4 c2 b a\fermata\bar "|." }
cIIa = \relative c' {
  e\breve*1/16 g4 g g g e2 e4 g g g g g g g1 e2
  e4 g g2 g\breve*1/16 g4 g g e2
  g4 g g2 g\breve*1/16 g4 g g2
  g4 g2. g4 g fis d2 d g\breve*1/16 g2 g4 g2 g e2 }
cIIt = \relative c' {
  c\breve*1/16 d4 e e d c2 c4 d e e d e f! e2 (d) c
  c4 d e2 d\breve*1/16 d4 e d c2
  d4 e f!2 e\breve*1/16 f!4 e d2 e4 d2 (c4) e d c b2 b
  e\breve*1/16 f!2 d4 e2 d c }
cIIb = \relative c' {
  a\breve*1/16 g4 c,-> c g' a2 
  a4 g c, c g' g g c,2 (g') a\resp
  a4 g c,2 g'\breve*1/16 g4-> c, g' a2
  g4 g g2 c,\breve*1/16 b4 c g'2\resp
  c,4 g'2. c,4 d d g2 g\resp
  c,\breve*1/16 g'2 g4 c,2 g' a\fermata }
cIIT = \lyricmode { 
  "Les nations s’é" -- taient mises en fu -- reur,
  mais voi -- ci ve -- nue ta co -- lè -- re
  et le temps "pour les morts" d’ê -- tre ju -- gés
  et le temps "de récompenser tes" ser -- vi -- teurs,
  les saints et les pro -- phè -- tes, 
  "ceux qui craignent ton" Nom, pe -- tits et grands. }

cIIIs = \relative c'' {
  b4 c2-> b4 b b c2-> c4 c b a2 a \resp
  b4 c d2 c\breve*1/16 d4-> c b2\resp
  c4 c b2-> (a4) c b2 a g\bar "|" 
  c4 c b c2 c\breve*1/16 d2 d4 d c2\espressivo c \resp
  c\breve*1/16 d2 d4 b c2^\markup\italic"rall." b4^\> b a2\!\fermata\bar "|." }
cIIIa = \relative c'' {
  g4 g2 g4 g g g2 g4 g g e2 e 
  g4 g g2 g\breve*1/16 g4 g g2 g4 g g2. g4 g2 fis d 
  g4 g g g2 g\breve*1/16 g2 g4 g g2 g
  g\breve*1/16 g2 g4 g g2 g4 g e2 }
cIIIt = \relative c' {
  d4 e2 d4 d d e2 e4 e d c2 c
  d4 e f!2 e\breve*1/16 f!4 e d2
  e4 e d2 (c4) e d2 c b
  e4 e d e2 e\breve*1/16 f!2 f4 f e2 e2 
  e\breve*1/16 f!2 f4 d e2 d4 d c2 }
cIIIb = \relative c' {
  g4 c,2-> g'4 g g c,2-> c4 c g' a2 a\resp
  g4 g g2 c,\breve*1/16 b4-> c g'2\resp
  c,4 c g'2-> (e4) c d2 d g
  c,4 c g' c,2 c\breve*1/16 b2 b4 b c2 c\resp 
  c\breve*1/16 g'2 g4 g c,2 g'4 g a2\fermata }
cIIIT = \lyricmode { 
  Le Rè -- gne, la vic -- toire et la puis -- san -- ce,
  main -- te -- nant, "sont venus pour" no -- tre Dieu,
  et l’em -- pi -- re pour son Christ.
  Il est vain -- cu, l’accusa -- teur de nos frè -- res,
  "lui qui les accu" -- sait jour et nuit de -- vant Dieu. }

cIVs = \relative c'' {
  a\breve*1/16 b4 c2 c4 c b2 b4 b a2\resp
  b\breve*1/16 c4 d2 (c4) b2\allowBreak
  c\breve*1/16 b2 a4 (c) d2 a g\bar "|" 
  c2->\breathe c\breve*1/16 b4 c2\resp
  c4 d2-> d4 d b c2 b a\fermata\bar "|." }
cIVa = \relative c' {
  e\breve*1/16 g4 g2 g4 g g2 g4 g e2 
  g\breve*1/16 g4 g2. g2
  g\breve*1/16 g2 g g fis d
  g2 g\breve*1/16 fis4 g2
  g4 g2 g4 g g g2 g e }
cIVt = \relative c' {
  c\breve*1/16 d4 e2 e4 e d2 d4 d c2
  d\breve*1/16 e4 f!2 (e4) d2
  e\breve*1/16 d2 c4 (e) d2 c b
  e2 e\breve*1/16 d4 e2 e4 f!2 f4 f d e2 d c }
cIVb = \relative c' {
  a\breve*1/16 g4 c,2 c4 c g'2 g4 g a2\resp
  g\breve*1/16 c,4 b2 (c4) g'2
  c,\breve*1/16 g'2 e4 (c) d2 d g
  c,2\breathe c\breve*1/16 g'4 c,2\resp 
  c4 g'2-> g4 g g c,2 g' a\fermata }
cIVT = \lyricmode { 
  "Eux-mêmes l’ont" vain -- cu par le sang de l’A -- gneau
  "et grâce au témoignage de leur" mar -- ty -- re,
  "car ils ont méprisé leur" vie jus -- \apostrophe qu’à la mort.
  Cieux_! \gauche "Soyez donc dans" la joie,
  et vous les ha -- bi -- tants des cieux_! }

cVs = \relative c'' {
  c2->\breathe b\breve*1/16 c4-> b a2\resp
  b4 c d c2 c4 c^\markup\italic"rall." d^\> c b2\!\bar "|" 
  c4 c b2 (a4) c b2 a g2\resp 
  c\breve*1/16 d2 b4\resp c2 (b) a\fermata\bar "|." }
cVa = \relative c'' {
  g2 g\breve*1/16 g4 g e2 g4 g g g2 g4 g g g g2
  g4 g g2. g4 g2 fis d 
  g\breve*1/16 g2 g4 g1 e2 }
cVt = \relative c' {
  e2 d\breve*1/16 e4 d c2 d4 e f! e2 e4 e f! e d2
  e4 e d2 (c4) e d2 c b
  e\breve*1/16 f!2 d4 e2 (d) c2 }
cVb = \relative c {
  c2->\breathe g'\breve*1/16 c,4-> g' a2\resp 
  g4 g g c,2 c4 c b c g'2
  c,4 c g'2 (e4) c d2 d g \resp 
  c,\breve*1/16 g'2 g4\resp c,2 (g') a2\fermata }
cVT = \lyricmode { 
  Gloire "au Père, au Fils, au" Saint_- Es -- prit,
  comme il é -- tait au com -- men -- ce -- ment,
  main -- te -- nant et pour tou -- jours,
  "dans les siècles des" siè -- cles. A -- men_! }


\new ChoirStaff
<< \new Dynamics 
   {
     c4 c8 [b] c2
     c\breve*1/16^\< d2^\! (c4 b2\rall^\>
     a4 c b2 a) g1\!
   }
   \new Staff \with {\remove Time_signature_engraver }
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
      { \voiceTwo \relative c
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
         %         \cIs\break\cIIs\break\cIIIs\break\cIVs\break\cVs%\cVIs\cVIIs\cVIIIs
         \cIs\cIIs\cIIIs\cIVs\cVs%\cVIs\cVIIs\cVIIIs
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         \cIa\cIIa\cIIIa\cIVa\cVa%\cVIa\cVIIa\cVIIIa
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
     \set stanza = "Dox."\cVT
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \cIt\cIIt\cIIIt\cIVt\cVt%\cVIt\cVIIt\cVIIIt
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \cIb\cIIb\cIIIb\cIVb\cVb%\cVIb\cVIIb\cVIIIb
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