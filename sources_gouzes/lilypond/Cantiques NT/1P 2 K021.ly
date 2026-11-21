\version "2.24.0"

\include "vowel-set.ly"
\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }

Rs = { a4 a^\< a a g^\> g f2 e\!\resp e4^\> e e e e2 e\fermata\! \bar"|."}
Ra = { e4 e e e e e c2 g g4 g a a a2 gis }
Rt = { c4 c c c b b a (b) c2 c4 c c c b2 b }
Rb = { a4 a a a e' e f2 c\resp c4 c a a e'2 e\fermata }
RT = \lyricmode { 
  \override Lyrics.LyricText.font-series = #'bold
  C’est par tes souf -- fran -- ces, Sei -- gneur, que nous som -- mes sau -- vés_!
  \revert Lyrics.LyricText.font-series }

cIs = \relative c' {
  \tempo "Calme"
  e\breve*1/16 d8 e4\resp
  e\breve*1/16 f4 f8 [f] e2 \bar"|"
  e\breve*1/16 d8^\markup\italic"rall."
  c\breve*1/16 b2^\ppp b\fermata\bar "|." }
cIa = \relative c' {
  c\breve*1/16 b8 c4
  c\breve*1/16 c4 c8 [c] b2
  c\breve*1/16 b8 a\breve*1/16 gis2 gis}
cIt = \relative c' {
  a\breve*1/16 s a4
  a\breve*1/16 a4 a8 [a] gis2
  g\breve*1/16 g8 e\breve*1/16 e2 e }
cIb = \relative c {
  a\breve*1/16 s a4\resp
  a\breve*1/16 d4 d8 [d] e2
  c\breve*1/16 g8 a\breve*1/16 e'2 e\fermata }
cIT = \lyricmode { 
  \once \override LyricText.X-offset = #center-on-vowel
  "C’est pour nous que le Christ a" souf -- fert,
  "il nous a mon" -- tré le che -- min,
  "afin que nous" mar -- "chions sur ses" tra -- ces. }

cIIs = \relative c' {
  e\breve*1/16 f4 f8 e2 e\bar"|"
  e\breve*1/16 d8 c\breve*1/16 b2\bar "|." }
cIIa = \relative c' {
  c\breve*1/16 c4 c8 b2 b
  c\breve*1/16 b8 a\breve*1/16 gis!2}
cIIt = \relative c' {
  a\breve*1/16 a4 a8 gis2 gis
  g\breve*1/16 g8 e\breve*1/16 e2 }
cIIb = \relative c {
  a\breve*1/16 d4 d8 e2 e
  c\breve*1/16 g8 a\breve*1/16 e'2 }
cIIT = \lyricmode { 
  "Lui qui n’a pas com" -- mis de fau -- te,
  "et il ne s’est trouvé en" sa "bouche aucun" mal. }

cIIIs = \relative c' {
  e\breve*1/16 d8 e4 e\resp
  e\breve*1/16 f4 f8 [f] e2 e\bar"|"
  e\breve*1/16 d8
  c\breve*1/16 b2 b\bar "|." }
cIIIa = \relative c' {
  c\breve*1/16 b8 c4 c
  c\breve*1/16 c4 c8 [c] b2 b
  c\breve*1/16 b8 a\breve*1/16 gis!2 gis}
cIIIt = \relative c' {
  a\breve*1/16 s a4 a
  a\breve*1/16 a4 a8 [a] gis2 gis
  g\breve*1/16 g8 e\breve*1/16 e2 e }
cIIIb = \relative c {
  a\breve*1/16 s a4 a\resp
  a\breve*1/16 d4 d8 [d] e2 e
  c\breve*1/16 g8 a\breve*1/16 e'2 e }
cIIIT = \lyricmode {  
  "Lui qui, insulté, ne rendit pas" l’in -- sul -- te,
  "maltraité ne fit" pas de me -- na -- ce,
  "s’en remettant à celui" qui "juge avec jus" -- ti -- ce. }

cIVs = \relative c' {
  e\breve*1/16 f4 f8 [f] e2\bar"|"
  e\breve*1/16 d8 c\breve*1/16 b2\bar "|." }
cIVa = \relative c' {
  c\breve*1/16 c4 c8 [c] b2
  c\breve*1/16 b8 a\breve*1/16 gis!2}
cIVt = \relative c' {
  a\breve*1/16 a4 a8 [a] gis2
  g\breve*1/16 g8 e\breve*1/16 e2 }
cIVb = \relative c {
  a\breve*1/16 d4 d8 [d] e2
  c\breve*1/16 g8 a\breve*1/16 e'2 }
cIVT = \lyricmode { 
  \once \override LyricText.X-offset = #center-on-vowel
  "C’était nos pé" -- chés sur le bois
  "qu’il portait" lui_- "même en son" Corps. }

cVs = \relative c' {
  e\breve*1/16 d8 e4\resp
  e\breve*1/16 f4 f\breve*1/16 e2 e\bar"|"
  e\breve*1/16 e2 e\resp
  d8 c\breve*1/16 b2\bar "|." }
cVa = \relative c' {
  c\breve*1/16 b8 c4
  c\breve*1/16 c4 c\breve*1/16 b2 b
  c\breve*1/16 c2 c b8 a\breve*1/16 gis!2}
cVt = \relative c' {
  a\breve*1/16 s a4
  a\breve*1/16 a4 a\breve*1/16 gis2 gis
  g\breve*1/16 g2 g g8 e\breve*1/16 e2 }
cVb = \relative c {
  a\breve*1/16 s a4\resp
  a\breve*1/16 d4 d\breve*1/16 e2 e
  c\breve*1/16 c2 c\resp g8 a\breve*1/16 e'2 }
cVT = \lyricmode { 
  "Afin que, morts à nos" pé -- chés,
  "nous vi" -- vions "pour la jus" -- ti -- ce_:
  "par ses souf" -- fran -- ces, nous "sommes gué" -- ris. }

cVIs = \relative c' {
  e\breve*1/16 d8 e4 \resp
  e\breve*1/16 e4 e8 [e] f4 f8 [f] e2\bar"|"
  e\breve*1/16 d8
  c\breve*1/16 b2\bar "|." }
cVIa = \relative c' {
  c\breve*1/16 b8 c4 
  c\breve*1/16 c4 c8 [c] c4 c8 [c] b2
  c\breve*1/16 b8 a\breve*1/16 gis!2}
cVIt = \relative c' {
  a\breve*1/16 s a4 
  a\breve*1/16 a4 a8 [a] a4 a8 [a] gis2
  g\breve*1/16 g8 e\breve*1/16 e2 }
cVIb = \relative c {
  a\breve*1/16 s a4 \resp
  a\breve*1/16 a4 a8 [a] d4 d8 [d] e2
  c\breve*1/16 g8 a\breve*1/16 e'2 }
cVIT = \lyricmode {  
  "Gloire au Père, au Fils, au Saint" Es -- prit,
  "au Dieu qui" est, qui é -- tait et qui vient, 
  "pour les siècles" des "siècles. A" -- men_! }

%\transpose a fis
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Très lent" 4 = 60
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

%\transpose a fis
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         %         \cIs\break\cIIs\break\cIIIs\break\cIVs\break\cVs\break\cVIs
         \cIs\cIIs\cIIIs\cIVs\cVs\cVIs
         %\cIs\break\cIIs\cIIIs\break\cIVs\cVs\break\cVIs
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