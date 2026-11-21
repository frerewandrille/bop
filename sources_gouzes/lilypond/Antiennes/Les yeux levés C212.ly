\version "2.24.0"

%\include "TonsDef.ly"

\transpose bes a
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key bes \major \time 3/4 \cadenzaOn \tempo "Vif" 2. = 58
          bes4 bes-> (c) d c2 d4 bes2 g4 f2. \breathe \allowBreak
          f4->^\markup{\italic"rall. sub."} g g f2 f4 g2-> g4 g-> (f) ees f2.\fermata \bar "|."
        }\tonVIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          f4 f (g) a g2 a4 g2 ees4 c2. d4 c c d2 d4 ees2 ees4 ees (d) c d2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Les yeux le -- vés vers toi, Sei -- gneur, tes ser -- vi -- teurs at -- ten -- dent ton re -- tour.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key bes \major \time 3/4 \cadenzaOn
          d4 d (ees) f ees2 f4 d (bes) c a2. bes4 bes bes bes2 bes4 bes2 bes4 bes2 bes4 bes2.
        }\tonVIIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          bes4 bes2-> bes4 bes2 f4 g2 ees4 f2. \breathe
          bes,4-> ees ees d2 d4 c2-> c4 c-> (d) ees bes2.\fermata
        }
      }
   >>
>>