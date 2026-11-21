\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"


% \paper {
%   #(set-paper-size "a5" )
%   %system-system-spacing = #'((basic-distance . 17) (padding . 0))
%   top-margin = 8
%   bottom-margin = 10
%   tagline = ##f
%   print-page-number = ##f
% }
% 
% #(set-global-staff-size 16)
% 
% \layout {
%   indent = #0
%   \context {
%     \Score \remove "Bar_number_engraver"
%   }
%   \context {
%     \Lyrics
%     \override LyricText.font-size = #2
%     \override LyricSpace.minimum-distance = #1
%   } 
% }
% 
% \header {
%   title = \markup \center-column { "Exultez de joie" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
%   tagline = ##f
% }
% 
% \markup { \vspace #2 }


armure = { \key g \minor \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo "Vif, dansant"% 2 = 52
         d4 g-> g a bes2-> a8[g] a4-> g f g2-> d4\resp
         bes'-> bes c d2 c8 [bes] c2 (a4) bes2\resp
         r4 g-> a bes c-> bes a bes-> a bes c-> d g, bes2\resp
         c4 d2 c8 [bes] c4-> bes a bes2.\resp
         g2 a8([bes]) a4-> g f g1.\fermata
         \bar"|."
       } \tonIIbf
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         d4 d2 d4 d2 c4 c2 c4 d2 f4 f2 f4 f2 f4 f2 f4 f2
         d4 d2 d4 d2 d4 d2 d4 d2 d4 d2 f4 f2 f4 c2 c4 d2
         d4 d2 d4 ees2 d4 d2 d4 d2.
       }    
     }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" } {
     \lyricsto "soprano"
     {
       E -- xul -- tez de joie, tres -- sail -- lez d’al -- lé -- gres -- se, 
       Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
       Car le Ro -- yau -- me des cieux est pro -- mis et don -- né
       aux pau -- vres qui ont tout quit -- té 
       par a -- mour du Sei -- gneur.
     }
   }
   \new Lyrics {
     \lyricsto "alto"{
       \repeat unfold 9 { Al -- lé -- lu -- ia, }
       Al -- lé -- lu -- ia_!
     }
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          s4 s2.*4 d4-> d ees f2 ees8 [d] ees4 (d c) d2
          r4 bes-> c d ees-> d c d-> c d ees-> f ees d2
          ees4 f2 ees8 [d] ees4-> d c d2. 
          bes2 c8 ([d]) c4-> bes a bes1.
        } \tonIIbh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g4 g2 g4 g2 f4 f2 f4 g2 bes4 bes2 bes4 bes2 f4 f2 f4 bes2 
          g4 g2 g4 g2 g4 g2 g4 g2 g4 g2 bes4 bes2 bes4 f2 f4 g2 
          g4 g2 g4 c,2 d4 g2 g4 g2.\fermata
        } 
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" } {
     \lyricsto "ténor"
     {
       Al -- lé -- lu -- ia, Al -- lé -- lu -- ia.
       Car le Ro -- yau -- me des cieux est pro -- mis et don -- né
       aux pau -- vres qui ont tout quit -- té 
       par a -- mour du Sei -- gneur.
     }
   }
   \new Lyrics {
     \lyricsto "basse" {
       \repeat unfold 9 { Al -- lé -- lu -- ia, }
       Al -- lé -- lu -- ia_!
     }
   }

>>

%\include "Exultez de joie Cplts.ly"
