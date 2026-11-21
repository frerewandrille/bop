\version "2.24.0"

\include "vowel-set.ly"


armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }

Rs = { f8 [g] a-> [a] \(a->\) [g] bes4\espressivo a\resp
       g8 ([f]) g ([a]) a ([g]) f2\fermata \bar"|."}
Ra = { f\breve*3/8 e4 f f f e c2 }
Rt = { a8 [bes] c [c] \(c\) [bes] d4 c bes8 ([a]) bes ([c]) c ([bes]) a2 }
Rb = { f\breve*3/8 f4 f\resp f f c f2\fermata }
RT = \lyricmode { 
  \override Lyrics.LyricText.font-series = #'bold
  Al -- lé -- lu -- ia_! Al -- lé -- lu -- ia_! 
  Al -- lé -- lu -- ia_!
  \revert Lyrics.LyricText.font-series }

cIs = \relative c'' {
  a\breve*1/16 g8 bes [bes] a4 \bar "|" 
  a\breve*1/16 g8 a4\resp g16 ([a]) bes4-- bes-- a2\bar "|." }
cIa = \relative c' {
  f\breve*1/16 s4. f4 f\breve*1/16 f8 f4 f8 f4 e f2 }
cIt = \relative c' {
  c\breve*1/16 bes8 d [d] c4 
  c\breve*1/16 bes8 c4 bes16 ([c]) d4 c c2}
cIb = \relative c {
  f\breve*1/16 s4. f4 f\breve*1/16 f8 f4\resp
  f8 bes,4-- c-- f2 }
cIT = \lyricmode { 
  "Salut, puissance, honneur, louange" à no -- tre Dieu_!
  "Ils sont justes" et vrais, ses ju -- ge -- ments_! }

cIIs = \relative c'' {
  a\breve*1/16 g8 bes [bes] a4 \bar "|" 
  a\breve*1/16 g8 a4\resp a8 [g16 (a]) bes2-- a2\bar "|." }
cIIa = \relative c' {
  f\breve*1/16 s4. f4 f\breve*1/16 f8 f4 f8 [f] f4 (e) f2 }
cIIt = \relative c' {
  c\breve*1/16 bes8 d [d] c4 
  c\breve*1/16 bes8 c4 c8 [bes16 (c]) d4 (c) c2}
cIIb = \relative c {
  f\breve*1/16 s4. f4 f\breve*1/16 f8 f4\resp
  f8 [f] bes,4-- (c--) f2 }
cIIT = \lyricmode { 
  "Célébrez le Seigneur, servi" -- teurs du Sei -- gneur,
  "vous tous qui le" crai -- gnez, pe -- tits et grands. }

cIIIs = \relative c'' {
  a\breve*1/16 g8 bes [bes] a4 \bar "|" 
  a\breve*1/16 g8 a4\resp a8 [g16 (a]) bes4 bes2-- a2\bar "|." }
cIIIa = \relative c' {
  f\breve*1/16 s4. f4 f\breve*1/16 f8 f4 f8 [f] f4 f (e) f2 }
cIIIt = \relative c' {
  c\breve*1/16 bes8 d [d] c4 
  c\breve*1/16 bes8 c4 c8 [bes16 (c]) d4 d (c) c2}
cIIIb = \relative c {
  f\breve*1/16 s4. f4 f\breve*1/16 f8 f4\resp
  f8 [f] bes,4 bes-- (c--) f2 }
cIIIT = \lyricmode { 
  "Il règne, notre Dieu, le Sei" -- gneur tout puis -- sant_:
  "Exultons pleins" de joie, ren -- dons_- lui gloi -- re_! }

cIVs = \relative c'' {
  a\breve*1/16 g8 bes [bes] a4 \bar "|" 
  a\breve*1/16 g8 a4\resp a8 [g16 (a]) bes4 bes2-- a2\bar "|." }
cIVa = \relative c' {
  f\breve*1/16 s4. f4 f\breve*1/16 f8 f4 f8 [f] f4 f (e) f2 }
cIVt = \relative c' {
  c\breve*1/16 bes8 d [d] c4 
  c\breve*1/16 bes8 c4 c8 [bes16 (c]) d4 d (c) c2}
cIVb = \relative c {
  f\breve*1/16 s4. f4 f\breve*1/16 f8 f4\resp
  f8 [f] bes,4 bes-- (c--) f2 }
cIVT = \lyricmode { 
  "Voici venir déjà les No" -- ces de l’A -- gneau_:
  "Son épouse" pour lui s’est fai -- te bel -- le. }

cVs = \relative c'' {
  a\breve*1/16 g8 bes [bes] a4 \bar "|" 
  a\breve*1/16 g8 a4\resp 
  a\breve*1/16 g16 ([a] bes2--) a2\bar "|." }
cVa = \relative c' {
  f\breve*1/16 s4. f4 f\breve*1/16 f8 f4 
  f\breve*1/16 f4. (e4) f2 }
cVt = \relative c' {
  c\breve*1/16 bes8 d [d] c4 
  c\breve*1/16 bes8 c4 
  c\breve*1/16 bes16 ([c] d4 c) c2}
cVb = \relative c {
  f\breve*1/16 s4. f4 f\breve*1/16 f8 f4\resp
  f\breve*1/16 f8 (bes,4-- c--) f2 }
cVT = \lyricmode { 
  "Gloire au Père, et au Fils, et" au Saint Es -- prit,
  "au Dieu qui est, qui était, et" qui vient, 
  "pour les siècles des siècles." A -- men_! }



\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
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

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         %  \cIs\break\cIIs\break\cIIIs\break\cIVs\break\cVs
         \cIs\cIIs\cIIIs\cIVs\cVs
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         \cIa\cIIa\cIIIa\cIVa\cVa
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
          \cIt\cIIt\cIIIt\cIVt\cVt
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \cIb\cIIb\cIIIb\cIVb\cVb
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