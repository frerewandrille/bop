\version "2.24.0"
%\include "TonsDef.ly"
global = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }

\transpose b a
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \global \cadenzaOn \tempo "Calme"% 2 = 52
          b4 b b b2 a4 b2.\resp b4 b d cis2 cis4 b2 a4 b2.\fermata\resp
          b4 cis d e2 e4 d2 d4 cis2. \resp b2 d4 cis2. cis4 b a b2.\fermata b\fermata 
          \bar "|."
        } \transpose a b \tonIIIgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          fis4 fis fis e2 e4 fis2. fis4 fis g a2 fis4 g (e) fis fis2. 
          g4 a fis g2 g4 fis2 g4 a2. fis2 fis4 fis2. e4 e fis fis2. fis
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
     Ce n’est plus moi qui vis, mais c’est le Christ qui vit en moi_;
     et la puis -- san -- ce du Sei -- gneur se dé -- ploie dans ma fai -- bles -- se_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \global \cadenzaOn
          d4 cis b cis2 cis4 d2. d4 cis b cis2 cis4 d (b) cis dis2. 
          e4 e d! b2 b4 b2 cis8 ([d]) e2. d2 b4 a2. b4 b cis dis2. dis2.
        } \transpose a b \tonIIIgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          b4 a g fis2 fis4 b2.\resp b4 a g fis2 a4 g2 fis4 b,2.\fermata\resp
          e4 a b e,2 e4 b2 b4 a2. \resp b2 d4 fis2. g4 g fis b,2.\fermata b\fermata
        }
      }
   >>
>>