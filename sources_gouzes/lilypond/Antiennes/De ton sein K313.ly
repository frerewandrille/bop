\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key f \major \time 3/4 \omit Score.BarLine \tempo 2. = 40
          a2 c4 a2 g4 a\breathe f g a2 a4 c (a) g a2. a2
          \revert Score.BarLine.stencil \bar "|"
          a4^\markup{\italic élargir} \omit Score.BarLine a2 a4 g2^> a4 d,^> 
          \allowBreak e f g^> f e d2^> c4 d2.
          \revert Score.BarLine.stencil \bar "|."
        }\cadenzaOn \tonIdf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          e4 (f) e d (c) d e f e d (c) d e (f) e d (c d) e2
          e4 d2 d4 d2 c4 d d d d d c a2 g4 a2.
        }          
      }
   >>
   % \new Lyrics \with { alignAboveContext = "femmes" }
%    \lyricsto "soprano"
%    {
%       De ton sein, ô Christ, ont cou -- lé des flots d’eau vi -- ve_!
%    }   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      De ton sein, ô Christ, ont cou -- lé des flots d’eau vi -- ve_!
      Le fleu -- ve de l’Es -- prit ré -- jou -- it la ci -- té de Dieu_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \key f \major \time 3/4
          a2.^\markup\italic"b.f." bes c bes a bes c2 c4 bes2 bes4 bes2 c4 bes a g bes a g f 
          \override BalloonText.annotation-balloon = ##f 
          <e \balloonText #'(1 . 3)\markup { "" } >2
          f2.
        }\cadenzaOn \tonIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          a2. bes c bes a bes c2 c4 d (e) f g_> (f) e d_> c bes g_> a c d_> a2 d2.
        }
      }
   >>
>>