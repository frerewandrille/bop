\version "2.24.0"
%\include "TonsDef.ly"

rall = #(make-dynamic-script 
         (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0


\new ChoirStaff  
<< \new Dynamics 
   {
     e a2.\> c8([b]) a4 (f2)\! e4 b'2. d8 ([c]) b2.
     e,4 f2. f4 f2 a4 f f e e^\rall^\> d e2\!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key a \minor \time 2/2 \cadenzaOn \tempo "Librement" 2 = 44
          e4 a2.-> c8([b]) a4 (f2)  \breathe e4 b'2.-> d8 ([c]) b2.\bar "|"
          e,4 f2. f4 f2 a4 f f-> e \allowBreak e-> d\fermata e2 \fermata\bar "||" \noBreak
        } \tonIVaf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c' 
        { \cadenzaOn 
          e\breve e\breve %e2.
          b4 d2. d4 d2 d4 d d d cis d cis!2 
        }
      }
   >>
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Jé4 -- ru2. -- sa4 -- lem,2. Jé4 -- ru2. -- sa4 -- lem_!2.
     Que4 Dieu2. es4 -- suie2 tou4 -- te lar -- me de nos yeux_!2
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c
        { \clef "bass" \key a \minor \cadenzaOn 
          e4 c'2. e8 ([d]) c4 (a2) e4 gis2. b8 ([a]) gis!2.
          gis!4 a2. a4 a2 a4 a a a a gis! a2
        }\tonIVah
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        { \cadenzaOn 
          e\breve \breathe e\breve %e2. 
          e4 d2. d4 d2 f4 d d-> d a-> bes\fermata a2\fermata
        }
      }
   >>
   
>>