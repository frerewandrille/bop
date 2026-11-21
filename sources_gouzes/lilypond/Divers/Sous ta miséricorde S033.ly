\version "2.24.0"

\new ChoirStaff  %\with { instrumentName = #"3" }
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano" 
      { \voiceOne \relative c'' 
        { \clef "treble" \key d \major \cadenzaOn \tempo "Lent et paisible"
          a \breve d2 d \breathe \allowBreak d \breve cis2 cis \breathe \allowBreak fis,4 fis b2 b4 b a2 \bar"|"
          a \breve d,2 d \allowBreak d \breve d4^\markup\italic"rall." d e fis2 \fermata \bar"|"
          fis \breve fis4 fis e2 e fis \breathe \allowBreak 
          fis4 fis fis2 fis4 fis b2 b b4 b a2 a d,^\markup\italic"cresc." e fis \fermata\bar "|." }
          \relative c'' { a \breve b s8 a4 \bar "|" \noBreak a \breve d, e8 fis4 \bar "||" \noBreak a \breve  fis4-+ \bar "|." } }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        {
          fis \breve <fis b>2 <fis b> \breathe \allowBreak <fis b> \breve a2 a \breathe \allowBreak fis4 fis d2 d4 e fis2 \bar"|"
          fis \breve d2 d d \breve b4 b cis d2  \bar"|"
          d \breve d4 d b2 cis d \breathe \allowBreak 
          d4 d d2 d4 d d2 d d4 e fis2 fis d b4 (cis) d2 \bar "|." } 
        \relative c'' { fis, \breve d e8 fis4 \bar "|" \noBreak fis \breve b, cis8 d4 \bar "||" \noBreak fis \breve  d4 } }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
      \once \override LyricText.self-alignment-X = #LEFT "Sous ta miséri"\breve -- cor2 -- de, 
      \once \override LyricText.self-alignment-X = #LEFT "nous cherchons re"\breve -- fu2 -- ge, sain4 -- te Mè2 -- re4 de Dieu_:2 
      \once \override LyricText.self-alignment-X = #LEFT "accueille nos pri"\breve -- è2 -- res 
      \once \override LyricText.self-alignment-X = #LEFT "quand nous"\breve cri4 -- ons vers toi.2
      \once \override LyricText.self-alignment-X = #LEFT "Mais délivre-"\breve nous4 de tout2 dan -- ger, 
      toi,4 Ma -- rie2 tou4 -- jours vier2 -- ge, glo4 -- ri -- eu2 -- se et bé -- nie.
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key d \major \cadenzaOn
          d \breve fis2 fis fis \breve fis2 fis d4 d b2 b4 b cis2
          cis \breve b2 b b \breve a4 g g a2 
          a \breve b4 b g2 g b b4 b b2 b4 b b2 b b4 b cis2 cis b g a }
        \relative c' { d \breve b s8 cis4 \bar "|" \noBreak cis \breve b s8 a4 \bar "||" \noBreak d \breve a4 }
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          d, \breve <b b'>2 <b b'> <b b'> \breve fis'2 fis \breathe b4 b g2 g4 g fis2
          fis \breve g2 g g \breve fis4 e e d2 \fermata
          d \breve b4 b e2 e b \breathe b4 b b2 b4 b g'2 g g4 g fis2 fis g4 (fis) e2 d \fermata }
        \relative c' { d, \breve g s8 fis4 \bar "|" \noBreak fis \breve g s8 d4 \bar "||" \noBreak d \breve d4 }
      }
   >>
>>