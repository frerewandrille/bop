\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

ss = { \hideNotes b\breve*1/16 \unHideNotes }
armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }

Rs = { g8 a4.-> g8 a4-> b c-> (b8 [c] b [a]) g4\resp
       a8 [b] c4^\markup\italic"rall." b a2\fermata \bar"|."}
Ra = { e8 e4. e8 e4 g g~ (g4. d8) d4 g8 [g] g4 g e2 }
Rt = { b8 c4. b8 c4 d e (d8 [e] d [c]) b4 c8 [d] e4 d c2 }
Rb = { e8 a4.-> e8 a4-> g c,-> (g'2) g4\resp e8 [d] c4 g' a2\fermata }
RT = \lyricmode { 
  \override Lyrics.LyricText.font-series = #'bold
  Puis -- sance, hon -- neur et gloi -- re à l’A -- gneau de Dieu.
  \revert Lyrics.LyricText.font-series }

cIs = \relative c'' {
  a\breve*1/16 a4 g-> g a2\resp
  b\breve*1/16 \hideNotes \allowBreak b\breve*1/16-> \unHideNotes a2 g\bar "|" 
  c\breve*1/16 b4-> (c) b a g2\resp
  a\breve*1/16 b4 c2 \allowBreak
  c\breve*1/16 b4 a-> a g-> g a2\fermata\bar "|." }
cIa = \relative c' {
  e\breve*1/16 fis4 d e e2
  g\breve*1/16 s d2 d
  g\breve*1/16 g2 g4 d d2
  g\breve*1/16 g4 g2 g\breve*1/16 g4 e fis d e e2 }
cIt = \relative c' {
  c\breve*1/16 c4 b b c2
  d\breve*1/16 s c2 b
  e\breve*1/16 d4 (e) d c b2
  c\breve*1/16 d4 e2 e\breve*1/16 d4 c c b b c2 }
cIb = \relative c' {
  a\breve*1/16 d,4 g-> e a2\resp
  g\breve*1/16 s g2 g
  c,\breve*1/16 g'2-> g4 g g2\resp
  e\breve*1/16 d4 c2 c\breve*1/16 g'4 a-> d, g-> e a2\fermata }
cIT = \lyricmode { 
  "Tu es digne, ô Sei" -- gneur no -- tre Dieu,
  "de recevoir l’honneur, la" "gloire et la puis" -- san -- ce_:
  "C’est toi qui cré" -- as l’u -- ni -- vers,
  "c’est par ta vo" -- lon -- té "qu’il reçut l’e" -- xis -- tence
  et fut cré -- é. }

cIIs = \relative c'' {
  a\breve*1/16 a4 g2 a2\resp
  b\breve*1/16 a2 a4 a g2\bar "|" 
  c\breve*1/16 b4 c2\resp
  c\breve*1/16 b4\fermata \allowBreak b (c b) a g2\resp
  a\breve*1/16^\< b4 c2->\! \allowBreak
  c4 c b4 a-> a g-> g a2\fermata\bar "|." }
cIIa = \relative c' {
  e\breve*1/16 fis4 d (e) e2
  g\breve*1/16 d2 d4 d d2
  g\breve*1/16 g4 g2 g\breve*1/16 g4 g2.d4 d2
  g\breve*1/16 g4 g2 g4 g4 g e fis d e e2 }
cIIt = \relative c' {
  c\breve*1/16 c4 b2 c2
  d\breve*1/16 c2 c4 c b2
  e\breve*1/16 d4 e2 e\breve*1/16 d4 d (e d) c b2
  c\breve*1/16 d4 e2 e4 e d4 c c b b c2 }
cIIb = \relative c' {
  a\breve*1/16 d,4 g-> (e) a2\resp
  g\breve*1/16 g2 g4 g g2
  g\breve*1/16 g4 c,2\resp
  c\breve*1/16 g'4\fermata g2. g4 g2\resp
  e\breve*1/16 d4 c2-> c4 c g'4 a-> d, g-> e a2\fermata }
cIIT = \lyricmode { 
  "Tu es digne, Seigneur, de recevoir" le Li -- vre
  "et d’en ouvrir les" pa -- ges scel -- lées,
  "car tu fus im" -- mo -- lé, "nous rachetant pour" Dieu
  par ton sang, "de toutes" tri -- bus, lan -- gues 
  et peu -- ples et na -- tions. }

cIIIs = \relative c'' {
  a\breve*1/16 a4 g2-> a2\resp
  b\breve*1/16 b2 \allowBreak a4-> a g2-> g\bar "|" 
  c\breve*1/16 b4 c2\resp
  c\breve*1/16 c2-> c4\resp c b (c b) a g2\espressivo g\resp
  a4 (b4) c2-> \allowBreak
  c4 c b4 a2 (g) a2\fermata\bar "|." }
cIIIa = \relative c' {
  e\breve*1/16 fis4 d (e) e2
  g\breve*1/16 g2 d4 d d2 d
  g\breve*1/16 g4 g2 g\breve*1/16 g2 g4 g g2.d4 d2 d
  g2 g g4 g g e (fis d e) e2 }
cIIIt = \relative c' {
  c\breve*1/16 c4 b2 c2
  d\breve*1/16 d2 c4 c b2 b
  e\breve*1/16 d4 e2 e\breve*1/16 e2 e4 e d (e d) c b2 b
  c4 (d4) e2 e4 e d4 c2 (b) c2 }
cIIIb = \relative c' {
  a\breve*1/16 d,4 g-> (e) a2\resp
  g\breve*1/16 g2 g4-> g g2-> g
  g\breve*1/16 g4 c,2\resp
  c\breve*1/16 c2-> c4\resp c g'2. g4 g2 g\resp
  e4 (d4) c2-> c4 c g'4 a (d, g e) a2\fermata }
cIIIT = \lyricmode { 
  "Tu as fait de nous, pour notre Dieu, un Royaume et" des prê -- tres,
  "et nous régne" -- rons sur la ter -- re.
  "Il est digne, l’Agneau im" -- mo -- lé,
  "de recevoir puissance et ri" -- ches -- se,
  sa -- gesse et for -- ce,
  hon -- neur, gloire et lou -- an -- ge. }

cIVs = \relative c'' {
  a\breve*1/16 a4 g-> g a2\resp
  b\breve*1/16 b2 a4 a g2\bar "|" 
  c\breve*1/16 b4 (c) b a g2\resp
  a4 b4 c2-> c4 c c-> b4 a2 (g) a2\fermata\bar "|." }
cIVa = \relative c' {
  e\breve*1/16 fis4 d e e2
  g\breve*1/16 g2 d4 d d2
  g\breve*1/16 g2 g4 d d2
  g4 g4 g2 g4 g4 g g e (fis d e) e2 }
cIVt = \relative c' {
  c\breve*1/16 c4 b b c2
  d\breve*1/16 d2 c4 c b2
  e\breve*1/16 d4 (e) d c b2
  c4 d4 e2 e4 e e d4 c2 (b) c2 }
cIVb = \relative c' {
  a\breve*1/16 d,4 g-> e a2\resp
  g\breve*1/16 g2 g4 g g2
  c,\breve*1/16 g'2 g4 g g2\resp
  e4 d4 c2-> c4 c c-> g'4 a (d, g e) a2\fermata }
cIVT = \lyricmode { 
  "Rendons gloire au Pè" -- re tout_- puis -- sant,
  "à son Fils Jésus" Christ, le Sei -- gneur,
  "à l’Esprit qui ha" -- bite en nos cœurs,
  pour les siè -- cles des siè -- cles. A -- men_! }


\transpose a g
\new ChoirStaff
<< \new Dynamics 
   {
     g8 a4. g8 a4 b c (b8 [c^\>] b [a]) g4\!
     a8^\< [b] c4^\> b a2\!
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

\transpose a g
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