\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

Rs = \relative c'' { d4 d cis2 a4 a fis2 b a2.\resp fis4 b b a2 fis4 fis e2. e4 g g fis1\fermata \bar"|."}
Ra = \relative c' { fis4 fis fis2 fis4 fis fis2 d4 (e) fis2. d4 d e fis2 d4 d d2. cis4 b cis d1 }
Rt = \relative c' { b4 b a2 cis4 cis d2 b cis2. b4 b b cis2 b4 b b2. a4 g g b1 }
Rb = \relative c { b4 b fis'2 fis4 fis b2 g fis2.\resp b4 g g fis2 fis4 fis g2. g4 e e b1\fermata }
RT = \lyricmode { 
  \override Lyrics.LyricText.font-series = #'bold
  Bap -- ti -- sés dans le Christ Jé -- sus,
  c’est dans sa mort que nous som -- mes bap -- ti -- sés.
  \revert Lyrics.LyricText.font-series }

cIs = \relative c'' {
  d\breve cis a8 b4\bar"|"
  b\breve a b8 fis4 \bar"|"
  fis\breve g a8 fis4\fermata\bar "|." }
cIa = \relative c' {
  fis\breve fis fis8 fis4
  fis\breve fis fis8 dis4
  dis!\breve e e8 dis!4 }
cIt = \relative c' {
  b\breve a cis8 d4
  d\breve cis cis8 b4
  s\breve b a8 b4 }
cIb = \relative c {
  b\breve fis' fis8 fis4
  fis\breve fis fis8 b4
  b\breve e, cis8 b4\fermata }

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
     "Par le baptême, ' nous avons été enseve" -- "lis avec lui dans" la Mort,
     "comme le Christ est ressuscité des morts ' pour la" gloire du Père,
     "nous vivrons, nous aus" -- "si, dans une vie" nou -- velle.
   }
   \addlyrics 
   { 
     \set stanza = #"2. " \set shortVocalName = "2." 
     "C’est un même être que nous sommes deve" -- "nus avec" le Christ,
     "par une mort sem" -- "blable à" la sienne.
     "Et nous le serons aus" -- "si par une résurrection semblable à" la sienne.
   }
   \addlyrics 
   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
     \set stanza = #"3. " \set shortVocalName = "3." 
     "Notre vieil homme a été cruci" -- "fié a" -- vec lui,
     "pour que fut détruit ce" "corps de" pé -- ché,
     "afin que nous ne soyions plus asser" -- "vis au" pé -- ché.
   }
   \addlyrics 
   { 
     \set stanza = #"4. " \set shortVocalName = "4." 
     "Mais, si nous sommes" "morts avec" le Christ,
     "nous croyons que nous vivrons aus" -- "si a" -- vec lui,
     "car le Christ, ressuscité des" "morts, ne" meurt plus.
   }
   \addlyrics 
   { 
     \set stanza = #"5. " \set shortVocalName = "5." 
     "La Mort n’a plus d’em" -- pire sur lui_:
     "sa mort fut une mort au pé" -- "ché, ' une fois" pour toutes.
     "Mais sa vie est une" vie pour Dieu.
   }
   \addlyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
     \set stanza = #"6. " \set shortVocalName = "6." 
     "Gloire au Père, et au" "Fils, et au Saint" Es -- prit,
     "au Dieu qui est, ' qui é" -- "tait, et" qui vient,
     "pour les" "siècles des siècles." A -- men.
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