\version "2.24.0"
%\include "TonsDef.ly"

\new ChoirStaff
<< \new Dynamics 
   {
     a2^\< a2.  a4 a\! a g2.^\>  g4 fis1\!\bar "|."
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key d \minor \time 2/2 \cadenzaOn \tempo "Très grave" 4 = 80
          a2 a2. \breathe a4 a a g2.^\markup\italic"rall."  g4 fis1\fermata\bar "|."
        }\tonIcf
        %\tonIIjf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { \cadenzaOn
          f2 e2. e4 e d d2. d4 d1
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode
   { \set associatedVoice = #"soprano"
     Sei2 -- gneur,2. ne4 sois pas loin2. de4 moi_!1
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key d \minor \time 2/2 \cadenzaOn
          d2 cis2. cis4 cis a bes2. bes4 a1
        }\tonIch 
        %\tonIIjh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { \cadenzaOn
          d2 a'2. \breathe a4 a fis g2. g4 d1\fermata
        }
      }
   >>
>>