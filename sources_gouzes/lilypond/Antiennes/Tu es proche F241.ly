\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Dynamics 
   {
       g4^\< a c2\! c4^\> c b2\!^\p  c c4 c^\> d (c) b2\!
       a^\markup{\italic subito \dynamic pp}^\> g e^\! \bar "|."
     }
     \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "soprano"
        { \voiceOne \relative c''
          { \clef "treble" \key c \major \time 2/2 \cadenzaOn \tempo "Vif" 2 = 63
            g4 a c2 c4 c b2 \breathe c c4 c d (c) b2 \breathe
            a\fermata g\fermata e\fermata \bar "|."
          }\tonIIIff
        }
        \new Voice = "alto"
        { \voiceTwo \relative c'
          { \cadenzaOn
            e4 f a2 a4 a e2 a a4 a a2 gis f! d e
          }          
        }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
     \lyricsto "soprano"
     { %\set associatedVoice = #
       Tu es pro -- che, Sei -- gneur. 
       Par ta Pa -- ro -- le, sau -- ve_- moi_!
     }
     \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { \voiceOne \relative c'
          { \clef "bass" \key c \major \time 2/2 \cadenzaOn
            b4 d e2 e4 e e2 e e4 e f (e) e2 c b c
          }\tonIIIfh
        }
        \new Voice = "basse"
        { \voiceTwo \relative c
          { \cadenzaOn
            e4 d a'2 a4 a gis2 \breathe a a4 a d, (e) e2 \breathe 
            f\fermata g \fermata a\fermata
          }
        }
     >>
   >>