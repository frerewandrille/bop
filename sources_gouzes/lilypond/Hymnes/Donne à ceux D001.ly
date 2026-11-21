\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   %system-system-spacing #'basic-distance = #17
%   top-margin = 9
%   bottom-margin = 0
%   left-margin = 10
%   right-margin = 10
%   print-page-number = ##f
%   tagline = ##f
% }
% 
% #(set-global-staff-size 15)
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
%   title = \markup \center-column { "Donne à ceux qui meurent" }
%   subtitle = ""
%   poet = ""
%   composer =  ""
%   tagline = ##f
% } 
% 
% 
% \markup{ \vspace #1 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 3
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

armure = { \key d \minor \time 4/4 }
resp = { \breathe\allowBreak }

\transpose a b
\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure %\tempo  2. = 50
          \revert Staff.TimeSignature.style
          a4. a8 bes4 a g2 a4\resp c8 c bes4 a a (g8 f) g2
          a f4 f bes4. a8 g2 c4. bes8 a4 bes2 a4 g1 \noBreak f\fermata
          \revert Score.BarLine.stencil \bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          f4. f8 g4 f e2 f4 a8 a g4 f f (e8 d) e2
          f d4 d g4. f8 e2 a4. g8 f4 g8 (f e4) f4 f (e8 d e2) f1          
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Donne à ceux qui meu -- rent le re -- pos é -- ter -- nel,
     et fais bril -- ler sur eux ta lu -- mière é -- ter -- nel -- le.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
        }
      }
      \new Voice = "basse"
      {  \relative c
         {
           d4. d8 g,4 a8 (bes) c2 f,4\resp f8 f g4 a8 (bes) c2 c
           r bes2 g4. g8 c4. bes8 a2 d4 bes8 bes c2 c4 c2. f,1\fermata
         }
      }
   >>
   \new Lyrics \lyricsto basse
   { 
     \repeat unfold 12 {\skip4}
     et fais bril -- ler sur eux ta lu -- mière é -- ter -- nel -- le.
   }
>>

\transpose a b
<<    
  \new Staff %\with {\remove Time_signature_engraver }
  \new Voice = "ténor"
  {  \relative c' 
     { \armure\cadenzaOn
       f8 g a\breve*1/8 g8 a4\resp
       f8 g a\breve*1/8 g8 bes g a4\bar"|"
       f8 g a\breve*1/8 f8 g ([a]) g f4\bar"||"          
     }
  }
  \new Lyrics \lyricsto ténor
  {   \set stanza = #"1. "\set shortVocalName = "1."
      À toi "Seigneur, la louange est due en " Si -- on_!
      Que pour "toi nos vœux soient acquittés en"  Jé -- ru -- sa -- lem.
      É -- cou -- "te ma prière. '  Jusqu’à toi" vient tou -- te chair.
  }
  \new Lyrics \lyricsto ténor
  { \set stanza = "2. "\set shortVocalName = "2."
    Heu -- reux "est ton élu ton fa" -- mi -- lier.
    \skip4 \skip4 "Il demeure" en tes par -- vis.
    Ras -- sa -- "sie-le des biens de ta maison en ton" tem -- ple sa -- cré.
  }
  \new Lyrics \lyricsto ténor
  { \set stanza = "3. "\set shortVocalName = "3."
    Gloire au "Père, et au Fils, et au Saint" Es -- prit,
    Comme il "était au commencement, mainte" -- nant et tou -- jours,
    \skip4 \skip4 "dans les siècles des siè" -- cles. A -- \skip4  men.
  }
>>