\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

global = {\key f \major \time 4/4}

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \relative c'
     { \clef "treble" \global %\omit Score.BarLine \tempo "" 2 = 52
       \partial4 d8 (e) f4 f8 e f4 d a'4. g8 f (e) d4\breathe
       d8 (e) f4 d e8 (d) c4 d2.\fermata
       \override Score.RehearsalMark.break-visibility = #begin-of-line-invisible
       \bar "|."\mark "Fine"
       \time 2/4 r4 a'8 b \time 4/4 c4 a d d c4. (b8) a4 \breathe 
       a8 b c4 a b8 (a) g4 a2.\fermata \bar ":|."\mark "D.C."\break
     } \cadenzaOn\tonIaf % pas de ton dans l’orig.
   } 
   \new Lyrics \lyricsto soprano %\lyricmode
   { %\set associatedVoice = #"soprano"
     Ô Christ, tu as em -- bra -- sé la ter -- re au feu de ton Es -- prit_! 
     Et le cœur de ta ser -- van -- te a brû -- lé de ton a -- mour_!
   }  

   \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "alto"
   {  \relative c'
      { \clef "treble_8" \global %\omit Score.BarLine \tempo "" 2 = 52
        {
          \partial4 r4 a4. (g8) a4. (c8) d4. (e8) d4. (c8)\breathe
          a4. (g8) a4. (b8) g2 a\fermata
          r2 e4. (d8) e4. (g8) a4. (g8) a4. (g8)\breathe
          f4. (g8) e4 f e2.\fermata
        }          
      }
   }
   \new Lyrics \lyricsto alto %\lyricmode
   { %\set associatedVoice = #"soprano"
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_! 
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   
   \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "ténor"
   {  \relative c
      { \clef "bass" \global %\omit Score.BarLine \tempo "" 2 = 52
        \partial4 r4 d4 d8 c a4 (c d f) \breathe
        d d8 c a4 (c d f e2 d\fermata)
        r2 e4 e8 g a4 (c)\breathe a4 a8 g e4 (g) \breathe
        a4 a8 c a4 (g a2.\fermata)
      }\cadenzaOn\tonIah
   }
   \new Lyrics \lyricsto ténor %\lyricmode
   { %\set associatedVoice = #"soprano"
     Al -- lé -- lu -- ia,  al -- lé -- lu -- ia_!  
     Al -- lé -- lu -- ia,  al -- lé -- lu -- ia,  al -- lé -- lu -- ia_! 
   }
>>

% \new ChoirStaff
% << 
%   \new Staff \with {\remove Time_signature_engraver }{ \key f \major \cadenzaOn \tonRIdf }
%   \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \key f \major \cadenzaOn \tonRIdh }
% >>