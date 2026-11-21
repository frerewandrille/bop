\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key f \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff = "femmes"%\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Calme" 2 = 58
         a4 a bes2 bes4 bes a2. a4 a-> a g2 g4 g a2 a1\resp
         a4 a b2. \allowBreak b4 b-> b a2 a4 a a2 (g) a2.\resp
         a4 \bar"|"\cadenzaOff a a a2~ a1 r2 a g bes 
         a (f d) g \noBreak f1\fermata
         \bar"|."
       } \cadenzaOn\tonVIaf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         f4 f f2 f4 f f2. f4 f f ees2 ees4 ees f2 f1
         f4 f f2. f4 f f f2 f4 f f1 e2.
         e4 e e f2~ f1 R1 r4 c d e f1 r4 c d e c1
       }    
     }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" } \lyricsto "soprano"
   { %\set associatedVoice = #
     \repeat unfold 29 { \skip8 } se -- ra le Fils de Dieu.
   }
   \new Lyrics \lyricsto "alto"
   {
     \repeat unfold 29 {\skip4 } se -- ra le Fils, le Fils de Dieu.
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "alto"
   {
     La nu -- ée du Très_- Haut te cou -- vri -- ra de son om -- bre.
     L’Es -- prit Saint vien -- dra sur toi, ô Ma -- ri -- e,
     et ton en -- fant
   }
   \new Staff = "hommes"%\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 c des2 des4 des c2. c4 c c bes2 bes4 bes c2 c1
          d4 d d2. d4 d d d2 d4 d d1 cis2.
          cis4 \cadenzaOff cis cis d2~ d c! c1~ c2 c c1~ c2 bes a1
        } \cadenzaOn \tonVIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c,
        { 
          <f f'>4 q q2 q4 q q2. q4 q-> q q2 q4 q q2 q1\resp
          d'4 d g2. g4 g-> g g2 g4 a b1 a2.\resp
          a4 a a a2~a1 r2 f e d c (d bes) c f,1\fermata
        } 
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" } \lyricsto "ténor"
   { %\set associatedVoice = #
     \repeat unfold 29 { \skip8 } se -- ra le Fils de Dieu.
   }
   \new Lyrics \lyricsto "basse"
   {
     \repeat unfold 29 { \skip8 } se -- ra le Fils de Dieu.

   }
>>