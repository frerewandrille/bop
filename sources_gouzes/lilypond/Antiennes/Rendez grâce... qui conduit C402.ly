\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \major \time 3/4 \cadenzaOn \tempo "Très vif" 2. = 69
          g4^\markup\italic"rythme marqué" fis e-> e e fis-> fis fis g-> g g e2. fis \breathe \allowBreak
          a2 a4 b-> b a g2. fis \breathe \allowBreak
          a4-> a a a2 b4 g2 a4 a2.\fermata \bar "|."
        }\transpose f g \tonVIaf % Pas de ton dans l’original, mais une cantillation
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          d4 d b b cis d d d d d d b2 (cis4) d2.
          d2 d4 d d d e2. fis fis4 fis fis fis2 fis4 e2 e4 fis2.
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
      Ren -- dez grâce au Sei -- gneur qui con -- duit son É -- gli -- se 
      vers la ter -- re pro -- mi -- se, car é -- ter -- nel est son a -- mour_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 3/4 \cadenzaOn
          b4 a g g a a a a b b a g2. a a2 a4 g g a b2 (cis4) a2. 
          d4 d d d2 d4 b2 cis!4 d2.
        }\transpose f g \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { \cadenzaOn
          g4 d e-> e a, d-> d d g,-> g d' e2. d \breathe fis2 fis4 g-> g fis e2. d \breathe
          d4-> d d d2 b4 e2 a,4 d2.\fermata
        }
      }
   >>
>>