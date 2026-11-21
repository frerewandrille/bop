\version "2.24.0"

\include "vowel-set.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

Rs = { fis4 fis fis a g fis g2-> (a4 g) fis2\resp
       a4 a a g fis2 g4^\markup\italic"rall." fis e2\fermata \bar"|."}
Ra = { d4 d d d d d d1 d2 fis4 fis fis g d2 d4 d b2}
Rt = { a4 a a c b a b2 (c4 b) a2 c4 c c b a2 b4 a g2 }
Rb = { d4 d d d g d g2-> (fis4 g) d2\resp
       d4 d d d d2 g4 d e2\fermata }
RT = \lyricmode { 
  \override Lyrics.LyricText.font-series = #'bold
  Bé -- ni sois_- tu no -- tre Pè -- re, 
  qui nous as bé -- nis dans le Christ_!  
  \revert Lyrics.LyricText.font-series }

cIs = \relative c'' {
  g4^\< g a^\> b2\! 
  a4^\pp g\breve*1/16 a4 a g2\resp
  g\breve*1/16 \hideNotes b\breve*1/16^\< \unHideNotes 
  fis2 g4 g a2\!^\f\bar "|" 
  a4 g2 (a4 b) \allowBreak a^\> g fis2\!\fermata\bar "|." }
cIa = \relative c' {
  d4 d d g2 d4 d\breve*1/16 fis4 fis d2
  d\breve*1/16 s d2 d4 d fis2 fis4 d1 d4 d d2 }
cIt = \relative c' {
  b4 b c d2 c4 b\breve*1/16 c4 c b2 
  b\breve*1/16 s a2 b4 b c2 c4 b2 (c4 d) c b a2 }
cIb = \relative c' {
  g4 g g g2 fis4 g\breve*1/16 d4 d g2\resp
  g\breve*1/16 s d2 d4 d d2 d4 g1 fis4 g d2\fermata }
cIT = \lyricmode { 
  Bé -- ni soit Dieu, le "Père de Jésus le Christ no" -- tre Sei -- gneur,
  "qui nous a bénis et" "comblés des bénédic" -- tions de l’Es -- prit,
  au ciel, dans le Christ.
}

cIIs = \relative c'' {
  g4^\< g g a \allowBreak b->^\> b b a g2\! \resp
  g\breve*1/16 a4 a g2\resp
  g\breve*1/16^\< \hideNotes b\breve*1/16\! \unHideNotes 
  fis2 g a\bar "|" 
  g2 (a4) \allowBreak b a g fis2\fermata\bar "|." }
cIIa = \relative c' {
  d4 d d d g g g d d2 d\breve*1/16 fis4 fis d2
  d\breve*1/16 s d2 d fis2 d2. d4 d d d2 }
cIIt = \relative c' {
  b4 b b c d d d c4 b2 b\breve*1/16 c4 c b2 
  b\breve*1/16 s a2 b c2 b2 (c4) d c b a2 }
cIIb = \relative c' {
  g4 g g g g-> g g fis g2\resp g\breve*1/16 d4 d g2\resp
  g\breve*1/16 s d2 d d2  g2. g4 fis4 g d2\fermata }
cIIT = \lyricmode { 
  A -- vant que le mon -- de fût cré -- é, 
  "il nous a choisis" dans le Christ 
  "pour être devant" "lui, grâce à" son a -- mour, saints et sans pé -- ché.
}

cIIIs = \relative c'' {
  g\breve*1/16^\< a4 b2->^\> b4 a g2\!\resp
  g\breve*1/16^\pp a2 a g2\resp
  g\breve*1/16^\< fis2\! g a\bar "|" 
  a\breve*1/16 g2-> (a4) b \allowBreak a g fis2\espressivo fis\fermata\bar "|." }
cIIIa = \relative c' {
  d\breve*1/16 d4 g2 g4 d d2 
  d\breve*1/16 fis2 fis d2
  d\breve*1/16 d2 d fis2 fis\breve*1/16 d2. d4 d d d2 d }
cIIIt = \relative c' {
  b\breve*1/16 c4 d2 d4 c b2 
  b\breve*1/16 c2 c b2
  b\breve*1/16 a2 b c2 c\breve*1/16 b2 (c4) d c b a2 a }
cIIIb = \relative c' {
  g\breve*1/16 g4 g2-> g4 fis g2\resp
  g\breve*1/16 d2 d g2\resp
  g\breve*1/16 d2 d d2 d\breve*1/16 g2.-> g4 fis4 g d2 d\fermata }
cIIIT = \lyricmode { 
  "D’avance, il nous" a -- vait des -- ti -- nés
  "à devenir pour lui des fils adoptifs par Jé" -- sus le Christ,
  "dessein d’amour" bien -- veil -- lant,
  "à la louange de" gloi -- re de sa grâ -- ce.
}

cIVs = \relative c'' {
  g4 a4 b-> b \allowBreak b a g-> \(g\breve*1/16\) a2 a g2\resp
  g\breve*1/16 fis4 g a2-> a4
  \(\allowBreak a\) a a g2 (a4 b) \allowBreak a g fis2\fermata\bar "|." }
cIVa = \relative c' {
  d4 d4 g g g4 d d \(d\breve*1/16\) fis2 fis d2
  d\breve*1/16 d4 d fis2 fis4 \(fis\) fis 
  fis d1 d4 d d2 }
cIVt = \relative c' {
  b4 c4 d d d4 c b \(b\breve*1/16\) c2 c b2
  b\breve*1/16 a4 b c2 c4 \(c\) c c b2 (c4 d) c b a2 }
cIVb = \relative c' {
  g4 g4 g-> g4 g fis g-> \(g\breve*1/16\) d2 d g2\resp
  g\breve*1/16 d4 d d2-> d4 \(d\) d d g1 fis4 g d2\fermata }
cIVT = \lyricmode { 
  C’est la grâ -- ce qu’il nous offre "en son Fils " Bien_- Ai -- mé_:
  "En lui, par son sang, nous avons la" dé -- li -- vran -- ce 
  et le par -- don des pé -- chés.
}

cVs = \relative c'' {
  g4^\< g g a4 b2->^\> (a4) g2\!\resp
  g\breve*1/16 a2\espressivo g2\resp
  g\breve*1/16 g4-> fis4 g a2 
  \allowBreak a4 a a g2 (a4 b) \allowBreak a g fis2\fermata\bar "|." }
cVa = \relative c' {
  d4 d4 d d g2 (d4) d2 d\breve*1/16 fis2 d2
  d\breve*1/16 d4 d d fis2 fis4 fis fis d1 d4 d d2 }
cVt = \relative c' {
  b4 b b c4 d2 (c4) b2 b\breve*1/16 c2 b2
  b\breve*1/16 b4 a4 b c2 c4 c c b2 (c4 d) c b a2 }
cVb = \relative c' {
  g4 g4 g g g2-> (fis4) g2\resp
  g\breve*1/16 d2 g2\resp
  g\breve*1/16 g4-> d4 d d2 d4 d d g1 fis4 g d2\fermata }
cVT = \lyricmode { 
  Grâce in -- é -- pui -- sa -- ble 
  "qui déborde jusqu’à nous en toute sagesse et connais" -- san -- ce,
  "nous révélant ainsi le mys" -- tè -- re d’a -- mour 
  de son des -- sein bien -- veil -- lant.
}

cVIs = \relative c'' {
  g\breve*1/16a4 b2 \allowBreak b4 a g2
  \allowBreak g\breve*1/16 a2-> a4 a g2\resp
  g\breve*1/16 fis2^\< (g)^\> a\! 
  \allowBreak g2 (a4 b a) g fis2\fermata\bar "|." }
cVIa = \relative c' {
  d\breve*1/16 d4 g2 g4 d d2 
  d\breve*1/16 fis2 fis4 fis d2
  d\breve*1/16 d1 fis2 d1 (d4) d d2 }
cVIt = \relative c' {
  b\breve*1/16 c4 d2 d4 c b2 
  b\breve*1/16 c2 c4 c b2
  b\breve*1/16 a2 (b) c2 b2 (c4 d c) b a2 }
cVIb = \relative c' {
  g\breve*1/16 g4 g2 g4 fis g2
  g\breve*1/16 d2-> d4 d g2\resp
  g\breve*1/16 d1 d2 g1 (fis4) g d2\fermata }
cVIT = \lyricmode { 
  "Ce qu’il avait prévu d’ac" -- com -- plir en son Fils
  "à la pléni" -- tu -- de des temps_:
  "récapituler toutes choses du ciel et de la" ter -- re
  dans le Christ.
}

cVIIs = \relative c'' {
  g4^\< g g a \allowBreak b->^\> b b a g2\! \resp
  g\breve*1/16 a2 a4 a g2\resp
  g\breve*1/16 fis2 g a\resp
  a\breve*1/16 g4-> g \allowBreak a4 (b a g) fis2\fermata\bar "|." }
cVIIa = \relative c' {
  d4 d d d g g g d d2 d\breve*1/16 fis2 fis4 fis d2
  d\breve*1/16 d2 d fis2 fis\breve*1/16 d4 d d1 d2 }
cVIIt = \relative c' {
  b4 b b c d d d c4 b2 b\breve*1/16 c2 c4 c b2 
  b\breve*1/16 a2 b c2 c\breve*1/16 b4 b c4 (d c b) a2 }
cVIIb = \relative c' {
  g4 g g g g-> g g fis g2\resp g\breve*1/16 d2 d4 d g2\resp
  g\breve*1/16 d2 d d2 \resp 
  d\breve*1/16 g4-> g4 g2 (fis4 g) d2\fermata }
cVIIT = \lyricmode { 
  Ren -- dons gloire au Pè -- re tou_- puis -- sant,
  "à son Fils Jésus" Christ, le Sei -- gneur,
  "à l’Esprit qui habite" en nos cœurs,
  "pour les siècles des" siè -- cles. A -- men_!
}



\new ChoirStaff
<< \new Dynamics 
   {
     fis4^\< fis fis a g fis g2^\> (a4 g) fis2\!
     a4^\< a a g fis2^\> g4 fis e2\!   }
   \new Staff \with {\remove Time_signature_engraver }
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
         %         \cIs\break\cIIs\break\cIIIs\break\cIVs\break\cVs\break\cVIs\break\cVIIs
         \cIs\cIIs\cIIIs\cIVs\cVs\cVIs\cVIIs
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         \cIa\cIIa\cIIIa\cIVa\cVa\cVIa\cVIIa
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
     \set stanza = "Dox."\cVIIT
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          \cIt\cIIt\cIIIt\cIVt\cVt\cVIt\cVIIt
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          \cIb\cIIb\cIIIb\cIVb\cVb\cVIb\cVIIb
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