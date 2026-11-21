\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

Rs = { a2 a\fermata\resp
       a\breve*1/16^\markup\italic"accel." g4 a b2-> c4 b a2\resp
       a4 g2-- g4 g fis2\fermata \bar"|."}
Ra = { fis2 fis fis\breve*1/16 d4 d g2 g4 g fis2 fis4 d2 d4 d d2 }
Rt = { d2 d c\breve*1/16 b4 c d2 e4 d c2 c4 b2 b4 b a2 }
Rb = { d2 d\fermata\resp
       d\breve*1/16 g4 g g2-> g4 g d2\resp d4 d2-- d4 d d2\fermata }
RT = \lyricmode { 
  \override Lyrics.LyricText.font-series = #'bold
  Gran -- des, 
  merveilleuses sont tes œu -- vres, Sei -- gneur,
  ô Roi des na -- tions_!
  \revert Lyrics.LyricText.font-series }

cIs = \relative c'' {
  a2-> a4 a g a b-> b g2\resp
  b\breve*1/16 a4 b b a2\resp a4^\markup\italic"rall. sub." (g) fis2
  g4 fis e2\fermata\bar "|." }
cIa = \relative c' {
  fis2 fis4 fis d d g g d2
  g\breve*1/16 g4 g g fis2 fis4 (d) d2 d4 d b2 }
cIt = \relative c' {
  d2 c4 c b c d d b2 d\breve*1/16 c4 d d d2 
  d8 ([c] b4) a2 g4 a g2 }
cIb = \relative c {
  d2-> d4 d g g g-> g g2\resp
  g\breve*1/16 g4 g g d2\resp d4 (g) d2 b4 d e2\fermata }
cIT = \lyricmode { 
  Ô Sei -- gneur Dieu, ô Tout_- Puis -- sant,
  "justes et vrais" sont tes che -- mins, ô Roi des na -- tions. }

cIIs = \relative c'' {
  a2-> a4 g a b2-> g4 g2\resp
  b\breve*1/16 a4 b2 b4 b a2\resp a4^\markup\italic"rall. sub." g fis2
  g4 fis e2\fermata\bar "|." }
cIIa = \relative c' {
  fis2 fis4 d d g2 d4 d2
  g\breve*1/16 g4 g2 g4 g fis2 fis4 d d2 d4 d b2 }
cIIt = \relative c' {
  d2 c4 b c d2 b4 b2 d\breve*1/16 c4 d2 d4 d d2 
  c4 b a2 g4 a g2 }
cIIb = \relative c {
  d2-> d4 g g g2-> g4 g2\resp
  g\breve*1/16 g4 g2 g4 g d2\resp d4 g d2 b4 d e2\fermata }
cIIT = \lyricmode { 
  Qui ne te crain -- drait, Sei -- gneur_!
  "Qui ne ren" -- drait gloire à ton Nom,
  car toi seul, tu es saint. }

cIIIs = \relative c'' {
  a\breve*1/16 a4\resp a\breve*1/16 g4 a b b g2\resp
  b\breve*1/16 a4 b2 b4 b a2\resp a4^\markup\italic"rall. sub." (g) fis2
  g4 fis e2\fermata\bar "|." }
cIIIa = \relative c' {
  fis\breve*1/16 fis4 fis\breve*1/16 d4 d g g d2
  g\breve*1/16 g4 g2 g4 g fis2 fis4 (d) d2 d4 d b2 }
cIIIt = \relative c' {
  d\breve*1/16 c4 c\breve*1/16 b4 c d d b2 
  d\breve*1/16 c4 d2 d4 d d2 d8 ([c] b4) a2 g4 a g2 }
cIIIb = \relative c {
  d\breve*1/16 d4\resp d\breve*1/16 g4 g g g g2\resp
  g\breve*1/16 g4 g2 g4 g d2\resp d4 (g) d2 b4 d e2\fermata }
cIIIT = \lyricmode { 
  "Toutes les na" -- tions "viendront se pros" -- ter -- ner de -- vant toi,
  "car tes jugements" se sont ré -- vé -- lés, 
  ô Roi des na -- tions. }

cIVs = \relative c'' {
  a2\espressivo a4 g a b-> b g2\resp
  b\breve*1/16 a4 b2-> b4 b a2\resp 
  a\breve*1/16 a4 g a2\resp a4^\markup\italic"rall. sub." fis
  g-> (a) g fis e2 e\fermata\bar "|." }
cIVa = \relative c' {
  fis2 fis4 d d g g d2
  g\breve*1/16 g4 g2 g4 g fis2
  fis\breve*1/16 fis4 d fis2 fis4 d d2 d4 d b2 b }
cIVt = \relative c' {
  d2 c4 b c d d b2 d\breve*1/16 c4 d2 d4 d d2 
  d\breve*1/16 c4 b c2 c4 a b (c) b a g2 g }
cIVb = \relative c {
  d2 d4 g g g-> g g2\resp
  g\breve*1/16 g4 g2-> g4 g d2\resp 
  d\breve*1/16 d4 d d2\resp d4 d g-> (fis) g d e2 e\fermata }
cIVT = \lyricmode { 
  Gloire au Pè -- re Tout_- Puis -- sant,
  "à son Fils Jé" -- sus Christ, le Sei -- gneur,
  "à l’Esprit qui habite" en nos cœurs,
  pour les siè -- cles des siè -- cles_! }


%\transpose a g
\new ChoirStaff
<< \new Dynamics 
   {
     a2\espressivo a
     a\breve*1/16^\< g4\! a b2 c4^\> b a2\!
     a4^\< g2^\> g4 g fis2\!
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
     { \voiceTwo \relative c'
       { \Ra%\cIa\cIIa\cIIIa\cIVa\cVa\cVIa
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
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \Rt%\cIt\cIIt\cIIIt\cIVt\cVt\cVIt
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \Rb%\cIb\cIIb\cIIIb\cIVb\cVb\cVIb
        } 
      }
   >>
>>

%\transpose a g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         %         \cIs\break\cIIs\break\cIIIs\break\cIVs
         \cIs\cIIs\cIIIs\cIVs
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         \cIa\cIIa\cIIIa\cIVa
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     \set stanza = "1."\cIT
     \set stanza = "2."\cIIT
     \set stanza = "3."\cIIIT
     \set stanza = "Dox."\cIVT
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \cIt\cIIt\cIIIt\cIVt
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \cIb\cIIb\cIIIb\cIVb
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