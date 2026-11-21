\version "2.24.0"

\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

Rs = \relative c'' { 
  g4 g-> g d'-> d d2. d4 c2 bes a1\fermata\resp
  a4-> a bes-> bes c-> c a1\fermata\resp g2\fermata f\fermata g1\fermata
  \bar"|."
}
Ra = \relative c' { 
  d4 d d d d d2. e4 fis2 g fis!1 
  fis4 fis g g g g fis!1 g4 (c,) d2 d1
}
Rt = \relative c' { 
  bes4 bes bes a a bes2. bes4 c2 d4 (e) d1 
  d4 d d d c c d1 bes4 (g) a2 bes1
}
Rb =\relative c' { 
  g4 g-> g fis-> fis g2. g4 a2 bes4 (c) d1\fermata\resp
  d,4-> d g-> g ees-> ees d1\fermata\resp
  ees2\fermata d\fermata <g, g'>1\fermata 
}
RT = \lyricmode { 
  \override Lyrics.LyricText.font-series = #'bold
  Nous vous en sup -- pli -- ons, au nom du Christ,
  lais -- sez_- vous ré -- con -- ci -- lier a -- vec Dieu_!
  \revert Lyrics.LyricText.font-series }

cIs = \relative c'' {
  g\breve a4\resp
  a\breve  bes8 [a] g4 \bar"|"
  g\breve g8 [a] f4\resp
  f\breve  bes8 [a] g4\fermata\bar "|." }
cIa = \relative c' {
  d\breve d4
  d\breve s8 s ees4
  ees\breve ees8 [ees] d4
  d\breve f8 [f] d4 }
cIt = \relative c' {
  bes\breve a4
  a\breve s8 s bes4
  bes\breve c8 [c] a4
  a\breve d8 [c] bes4 }
cIb = \relative c' {
  g\breve f4\resp
  f\breve s8 s ees4
  ees\breve c8 [c] d4\resp
  d\breve d8 [f] g4\fermata }

\transpose g e
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne 
       { \clef "treble" \armure \cadenzaOn \tempo 2 = 60
         \Rs } 
     }
     \new Voice = "alto"
     { \voiceTwo \Ra }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     \set stanza = " Ref. "\RT
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne 
        { \clef "bass" \armure \cadenzaOn
          \Rt } 
      }
      \new Voice = "basse"
      { \voiceTwo \Rb }
   >>
>>

\transpose g e
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne 
       { \clef "treble" \armure \cadenzaOn
         \cIs  } 
     }
     \new Voice = "alto"
     { \voiceTwo \cIa }
   >>
   \addlyrics 
   { 
     \set stanza = #"1. " \set shortVocalName = "1." 
     "Si quelqu’un est dans le" Christ,
     "il est une créa" -- tion nou -- velle_:
     "ce qui est ancien a" dis -- pa -- ru,
     "un être nouveau est" ap -- pa -- ru_!
   }
   \addlyrics 
   { 
     \set stanza = #"2. " \set shortVocalName = "2." 
     "Et toute chose vient de" Dieu,
     "qui nous a réconciliés avec lui" par le Christ_;
     "et c’est à nous qu’il" a con -- fié
     "le ministère de la récon" -- ci -- lia -- tion.
   }
   \addlyrics 
   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
     \set stanza = #"3. " \set shortVocalName = "3." 
     "C’était Dieu qui, dans le" Christ,
     "se réconciliait" l’U -- ni -- vers,
     "ne te" -- nant plus compte
     "des fau" -- tes des hommes.
   }
   \addlyrics 
   { 
     \set stanza = #"4. " \set shortVocalName = "4." 
     "Il a mis sur nos" lèvres
     "la Parole de récon" -- ci -- lia -- tion_:
     "Nous sommes en ambassade" pour le Christ,
     "c’est Dieu qui ex" -- horte en nous_!
   }
   \addlyrics 
   { 
     \set stanza = #"5. " \set shortVocalName = "5." 
     "Celui qui n’avait pas connu le pé" -- ché,
     "Dieu l’a fait pé" -- ché pour nous,
     "afin qu’en lui nous" de -- ve -- nions
     justi -- ce de Dieu.
   }
   \addlyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
     \set stanza = #"6. " \set shortVocalName = "6." 
     "Rendons gloire au Père tout-puis" -- sant,
     "à son Fils Jésus-Christ" le Sei -- gneur,
     "à l’Esprit qui habite" en nos cœurs,
     "pour les siècles des siè" -- cles. A -- men.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne 
        { \clef "bass" \armure \cadenzaOn
          \cIt } 
      }
      \new Voice = "basse"
      { \voiceTwo \cIb }
   >>
>>