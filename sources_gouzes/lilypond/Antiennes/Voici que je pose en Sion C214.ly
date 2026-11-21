\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\transpose b a
\new ChoirStaff  
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key a \major \time 3/4 \cadenzaOn 
          \tempo "Très vif, en marquant les appuis" 2. = 76
          b4 b-> b b cis-> b cis cis2. 
          \oneVoice r4 \voiceOne b b a-> fis a b2.^\markup\italic"élargir" b \bar "|" %\noBreak
          e,4->^\markup\italic"poco a poco rall." e e fis-> (e) fis fis2. e \breathe\allowBreak
          e4-> e e fis-!-> (d-!) fis-! e2. \fermata \bar "||"
        } \tonVIIcf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          b'4 gis gis gis fis gis fis gis2. 
          s4 fis fis e d e gis2. gis
          b,4 b b cis (b) cis cis2. 
          b b4 b b cis (b) cis b2.
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano" 
   { 
     Voi4 -- ci que je pose en Si -- on1 u4 -- ne pierre an -- gu -- lai2. -- re_:
     Qui4 se con -- fie2 en4 el2. -- le ne4 se -- ra pas2 dé4 -- çu.2.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c'
        { \clef "bass" \key a \major \time 3/4 \cadenzaOn 
          b4 e e e e e e e2. s4 d d cis b cis e2. e
          gis,4 gis gis a (gis) a a2. 
          gis gis4 gis gis a2 a4 gis2.
        }\tonVIIch
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          e4 e-> e e a-> b a b2.
          \oneVoice r4 \voiceTwo a a fis-> a fis e2. e
          e4-> e e e2-> e4 d2. e \breathe
          e4-> e e d-!-> (fis-!) d-! e2.\fermata
        }
      }
   >>
   
>>