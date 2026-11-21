\version "2.24.0"

%\include "TonsDef.ly"

armure = { \key e \minor \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     g2^\ppp^\< fis8 (g) a4 (g fis) g2 (a4)\resp
          b2 a8 (b) c4 (b a) b2 (g4)
          b4\!^\f c b c2 b4 c2 c4 b2.
          b2^\> a8 (b) c4 (b a) b2 (g4)\resp
          g2 fis8 (g) a4 (g fis) \noBreak g2.\!^\ppp
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure %\tempo  2. = 50
          \omit Score.BarLine
          g2-> fis8 (g) a4 (g fis) g2 (a4)\resp
          b2-> a8 (b) c4 (b a) b2 (g4)\undo \omit Score.BarLine
          b4-- \omit Score.BarLine c-- b-- c2-> b4-- c2-> c4 b2.
          \undo \omit Score.BarLine
          b2-> \omit Score.BarLine a8 (b) c4 (b a) b2 (g4)\resp
          g2-> fis8 (g) a4 (g fis) \noBreak g2.\fermata
          \undo \omit Score.BarLine   \bar "|."
        }\cadenzaOn \tonVIef
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          d2 d4 d2. d g2 g4 g2. g
          gis4 a gis a2 gis4 a2 fis4 g!2.
          g2 g4 g2. g d2 d4 d2. d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
     Jour d’al -- lé -- gresse et jour de joie_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          b2 a8 (b) c4 (b a) b2 (c4) 
          d2 c8 (d) e4 (d c) d2 (b4)
          e4 e e e2 e4 e2 d4 d2.
          d2 c8 (d) e4 (d c) d2 (b4)
          b2 a8 (b) c4 (b a) b2. 
        }\cadenzaOn \tonVIeh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g2-> d8 (g) fis4 (g d) g2.\resp
          g2-> g4 c,2. g'
          e4-- a-- e-- a2-> e4-- a2-> d,4 g2.->
          g2-> g4 c,2. g'\resp
          g2-> d8 (g) fis4 (g d) g2.
        }
      }
   >>
>>

%{
convert-ly (GNU LilyPond) 2.20.0  convert-ly: Traitement de «  »...
Conversion en cours : 2.19.2, 2.19.7, 2.19.11, 2.19.16, 2.19.22,
2.19.24, 2.19.28, 2.19.29, 2.19.32, 2.19.40, 2.19.46, 2.19.49,
2.19.80, 2.20.0
%}
