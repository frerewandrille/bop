\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose bes g
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vif"% 2 = 52
          bes4 c2\resp c4 d-> d d bes-> bes bes g2. f2\resp f4 g2. g f\fermata
          \bar"|."
        } \tonVIIIbf
        %\transpose a bes \tonVIIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          f4 g2 g4 a a a g g g8 ([f]) ees2 (d4) c2 d4 ees2. ees2 (d4) c2.
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Sans fin, je pro -- cla -- me -- rai ta vic -- toi -- re et ton sa -- lut.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 ees2 ees4 f f f8 ([ees]) d4 d c c2 (bes4) a2 
          a4 bes2. c2 (bes4) a2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes4 bes2\resp bes4 f-> f f g-> g8 ([f]) ees ([d]) c2. f2\resp
          f4 ees2 (d4) c2. f\fermata
        } \tonVIIIbh
        %\transpose a bes \tonVIIdh
      }
   >>
>>