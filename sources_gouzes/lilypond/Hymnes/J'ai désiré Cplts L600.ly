\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   %system-system-spacing.basic-distance = #17
%   top-margin = 9
%   bottom-margin = 8
%   left-margin = 10
%   right-margin = 10
%   print-page-number = ##f
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% #(set-global-staff-size 15)
% 
% \header {
%   title = \markup \center-column { "J’ai désiré" }
%   subtitle = ""
%   poet = ""
%   composer =  ""
% } 
% \markup{ \vspace #1 }
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

armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         a4 a f g a2.\resp a4 bes bes a g a2 f\bar"|"
         f2 f4 f e2. e4 g2 f e e\bar"|." s\breve*1/8\bar"|"\break 
         f4 f f f e e e e g2 f f e 
         \bar"|." s\breve*1/8\bar"|"
       } 
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f4 f d e f2. f4 g g f e f (e) d2
         d2 d4 d d2. d4 d2 d e e 
         \tiny e\breve*1/8\laissezVibrer^\markup\italic"Verset soliste" \normalsize
         d4 d d d d d d d d2 d d e 
         \tiny e\breve*1/8\laissezVibrer^\markup\italic"Verset soliste" \normalsize
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   { \set stanza = "1-5."
     Sou -- viens_- toi de nous, Sei -- gneur, dans ton Roy -- au -- me,
     \set stanza = "1."
     toi qui as dit à tes dis -- ci -- ples_:
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     \repeat unfold 21 {\skip4 } \set stanza = "2."
     toi qui nous in -- vites __ \skip4 au fes -- tin de l’A -- gneau_:
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     \repeat unfold 21 {\skip4 } \set stanza = "3."
     Au soir de ta Pâ -- que, tu an -- non -- ces ta mort_:
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     \repeat unfold 21 {\skip4 } \set stanza = "4."
     toi qui pris le pain et le bé -- nis en di -- sant_:
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     \repeat unfold 21 {\skip4 } \set stanza = "5."
     toi qui pris la coupe et la bé -- nis en di -- sant_:
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d4 d a a d2. d4 d d d d d (cis) d2
          a2 a4 a bes2. bes4 bes2 a4 (b) cis!2 cis \tiny a\breve*1/8\laissezVibrer \normalsize
          a4 a a a b b b b b2 a b! cis! \tiny a\breve*1/8\laissezVibrer \normalsize
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d d d d2. d4 g g a bes a2 d,
          d2 d4 d g2. g4 g2 a a a \tiny a,\breve*1/8\laissezVibrer \normalsize
          d4 d d d g g g g g2 a a a \tiny a,\breve*1/8\laissezVibrer
        } 
      }
   >>
>>