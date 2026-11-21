\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 9/8 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver } \with { \consists "Merge_rests_engraver" }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \tempo "Calme" 4. = 56
          \partial8 d8 g4 bes8 a4 (c8) bes4 a8 g4. (a) d,
          r4 d8 
          \time 9/8 g4 bes8 a4 c8 bes4 a8 
          \time 12/8 g4. (f) g\fermata
          r4 \allowBreak bes8 bes4 c8 bes4 a8 bes4 c8 d4 d8 c4 c8 bes4 bes8 a4.\fermata
          r4 \allowBreak bes8 c4 bes8 a4 g8 a4 a8 d,4. 
          \time 9/8 g bes8 (a bes) g4 (f8) \noBreak g2.\fermata
          \bar "|."
        }\cadenzaOn \tonIIhf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial8 d8 g4 bes8 a4 (c8) bes4 a8 
          \time 12/8 g4. (a) d, r4
          r8 c4. d ees c d d r4
          d8 ees4 ees8 d4 d8 g4 g8 f4 f8 e4 e8 e4 e8 d4. r4 r8 
          ees2. ees4. d
          bes4 (f'8) ees4. d d2.
        }          
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" }
   \lyricsto soprano 
   { 
     \repeat unfold 8 {\skip4}
     le Verbe a pris chair de Ma -- ri -- e
     \repeat unfold 14 {\skip4}
     par la puis -- san -- ce de l’Es -- prit, 
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Par un é -- change ad -- mi -- ra -- ble, \skip4
     \once \override Lyrics.LyricText.font-shape = #'italic \once\small b.f.
     \repeat unfold 7 {\skip4}
     et il nous fait par -- ti -- ci -- per de sa di -- vi -- ni -- té \skip4
     \once \override Lyrics.LyricText.font-shape = #'italic \once\small b.f.
     \repeat unfold 6 {\skip4}
     al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver } \with { \consists "Merge_rests_engraver" }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \partial8 d8 bes4 d8 c4 (ees8) d4 c8 bes4. (c) bes (a)
          g f g g a bes 
          r4 bes8 bes4 bes8 bes4 bes8 bes4 bes8 bes4 bes8 a4 a8 g4 g8 fis4.
          r4. g2. g4. fis
          g d'8 (c bes) a4. bes2.
        }\cadenzaOn \tonIIhh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          \partial8 r8 g4.-\markup\italic"b.f." g g g f g f
          ees d c ees d g\fermata r4
          g8 g4 g8 f4 f8 ees4 ees8 bes4 bes8 c4 c8 c4 c8 d4.\fermata r
          c2. c4. d  ees4 (d8) c4. d <g, g'>2.\fermata
        }
      }
   >>
>>