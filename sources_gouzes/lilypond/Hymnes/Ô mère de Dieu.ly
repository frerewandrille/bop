\version "2.24.0"

\include "vowel-set.ly"

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

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 0.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff 
<< \new Staff \with {\remove Time_signature_engraver }
   \with { \consists "Merge_rests_engraver" }
   << \new Voice = "soprano" 
      { \voiceOne \relative c'
        { \clef "treble" \key c \major \cadenzaOn
          d4^> a' b^> g a2 \breathe \allowBreak b4^> d c^> b a^> g a2. \breathe \allowBreak a4 a^> d, e^> g f^> e d2 \bar "|"
          r4 f e^> g a^> a d,2 \breathe \allowBreak e4^> f e^> d c2. \breathe \allowBreak e4 g^> e f^> e d2 \fermata \bar "|." 
      } }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        {
          d4 f e e d (e8 [f])e4 e f g f e d2. d4 e \small f8 ([g]) a4 a a g a2
          \normalsize
          r4 f e e d d \small f2 g4 g g g a2. a4 a a f g a2 
      } }
   >>
   \new Lyrics \lyricmode { 
     \set associatedVoice = #"soprano" \set shortVocalName = "1." \set stanza = #" 1." 
     Ô4 Mè -- re de Dieu,2 
     tout4 -- te belle et sans dé -- faut,2.
     de4 -- meu -- re di -- gne du Sei -- gneur,2
     \skip 4 En4 toi fut fa -- çon -- né2
     le4 Fils Bien_- Ai -- mé,2.
     le4 prin -- ce de la Vie.2
   }
   \new Lyrics \lyricmode { 
     \set associatedVoice = #"soprano" \set shortVocalName = "2." \set stanza = #"2."
     Buis4 -- son qui brû -- lait,2
     con4 -- te -- nant "“Ce" -- lui qui "est”" 2.
     mais4 sans en ê -- tre con -- su -- mée.2
     \skip 4 Il4 a pris chair en toi,2
     le4 Ver -- be de Dieu,2.
     né4 a -- vant tous les temps.2
   }
   \new Lyrics 
   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
   \lyricmode { 
     \set associatedVoice = #"soprano" \set shortVocalName = "3." \set stanza = #"3."
     As4 -- tre du ma -- tin,2
     ta4 lu -- mière a res -- plen -- di2.
     a4 -- vant le le -- ver du so -- leil_:2
     \skip 4 Il4 s’est ma -- ni -- fes -- té,2
     Gloi4 -- re d’Is -- ra -- ël,2.
     lu4 -- miè -- re des na -- tions.2
   }
   \new Lyrics \lyricmode { 
     \set associatedVoice = #"soprano" \set shortVocalName = "4." \set stanza = #"4."
     Pa4 -- ra -- dis nou -- veau,2
     ton4 sein pur et vir -- gi -- nal2.
     por4 -- te le fruit qui don -- ne vie.2
     \skip 4 De4 l’ar -- bre de la Croix2
     a4 jail -- li pour nous2.
     la4 sour -- ce qui gué -- rit.2
   }
   \new Lyrics \lyricmode { 
     \set associatedVoice = #"soprano" \set shortVocalName = "5." \set stanza = #"5."
     Il4 est né de toi,2
     l’ar4 -- ti -- san de l’u -- ni -- vers,2.
     la4 ré -- sur -- rec -- tion et la Vie.2
     \skip 4 Du4 tom -- beau, il sur -- git,2
     le4 nou -- vel A -- dam,2.
     res4 -- sus -- ci -- té des morts.2
   }
   \new Lyrics 
   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
   \lyricmode { 
     \set associatedVoice = #"soprano" \set shortVocalName = "6." \set stanza = #"6."
     Ô4 Vier -- ge Ma -- rie,2
     le4 Sei -- gneur t’a cour -- ron -- née2.
     de4 tous les dons de l’Es -- prit Saint.2
     \skip 4 Nous4 chan -- tons ta beau -- té,2
     fil4 -- le d’Is -- ra -- ël,2.
     é4 -- pouse im -- ma -- cu -- lée.2
   }
   \new Lyrics %\with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode { 
     \set associatedVoice = #"soprano" \set shortVocalName = "7." \set stanza = #"7." 
     %\override Lyrics.LyricText.font-shape = #'italic
     Gloire4 au Dieu d’a -- mour,2
     Pè4 -- re Saint qui don -- ne vie,2.
     au4 Fils ve -- nu dans no -- tre chair,2
     \skip 4 Et4 gloire au Saint Es -- prit,2
     qui4 fit de Ma -- rie2.
     le4 tem -- ple du Très_- Haut_!2
   }

   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key c \major \cadenzaOn
          r2 d^"b.f." (c) (b) (a) (c4) (b) (a2.) a4 (b2) (c) (d) (d)
          a (g) (f4) (g) (a2) a (a) (a2.) a4 (c2) (a) (a)
      } }
      \new Voice = "basse" 
      { \voiceTwo \relative c
        {
          d2-"b.f." (e) (f) \(\breathe g\) (a) (a4) (g) (f2.) \breathe f4 (e) (d) (c2) (a4) (c) (d2)
          d (d) (d) (d) \breathe c (c) (c2.) \breathe c4 (c2) (d) (d)\fermata 
      } }
   >>
>>