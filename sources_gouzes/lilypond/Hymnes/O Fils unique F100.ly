\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   print-page-number = ##f
%   ragged-last-bottom = ##f
% }
% 
% #(set-global-staff-size 16)
% 
% \header {
%   title = \markup \center-column { "Ô Fils unique" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
%   tagline = "Ne pas emporter ni plier s’il vous plaît"
% }
 
\layout {
  indent = #0
  \context {
    \Score \remove "Bar_number_engraver"
  }
  \context {
    \Lyrics
    \override LyricText.font-size = #2
    \override LyricSpace.minimum-distance = #1
  } 
}

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 1
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

armure = { \key d \minor \time 2/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn %\tempo  2. = 50
          f8 ([e]) f [g] a4 a bes bes8 [bes] a4.\resp
          a8 c [bes] a [a] a [a] a4. a8 g ([a]) bes [a] g4\resp
          a8 [bes] c4 c8 [c] c [c] bes ([a]) bes [c] a2 \bar "|"
          f4 %\omit Score.BarLine 
          f8 [g] a4 a g8 [a] bes [bes] a4.\resp
          a8 c [bes] a4 %\time 3/4 
          a g2 \bar "|"
          %\time 2/4
          c4 %\omit Score.BarLine 
          a8 [bes] c4. c8 d4 c c2\resp
          a8 [bes] c4. c8 bes [a] bes4 c a2\bar "|"
          f4. %\omit Score.BarLine 
          e8 f [g] a4 (g8) [a] bes4 bes a4.\resp
          a8 c [bes] a [a] a [a] a4 g8 [f] g4 a g\resp
          a8 [bes] c4 bes8 [c] d4 c c4.\resp
          c8 bes4. (a8) bes4 c a2%\undo \omit Score.BarLine
          \bar "|."
        }%\cadenzaOn \ton
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          c4 c8 [c] f4 f f f 8[e] f4. f8 f [e] f [f] f [f] f4. f8 e ([f]) g [f] e4
          f8 [g] a4 a8 [a] a [a] g ([f]) g [e] f2
          c4 c8 [c] f4 f f8 [f] f [e] f4. f8 f [e] f4 f e2
          f4 f8 [f] f4. f8 f4 g f2 f8 [g] a4. a8 g [f] g4 e f2
          c4. c8 c [c] f4. f8 f4 e f4. f8 f [e] f [f] f [f] f4 
          c8 [c] c4 c8 ([d]) e4
          f8 [g] a4 g8 [a] bes4 g a4. f8 e4. (f8) g4 e f2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Ô Fils u -- nique et Ver -- be de Dieu,
      toi l’im -- mor -- tel qui as dai -- gné, pour no -- tre sa -- lut,
      pren -- dre chair de la sain -- te Mè -- re de Dieu_;
      Toi, qui sans per -- dre ta di -- vi -- ni -- té, 
      t’es fait sem -- blable à nous_;
      Christ no -- tre Dieu, qui mis en croix,
      par ta mort as é -- cra -- sé la mort_;
      Toi qui dans la sain -- te Tri -- ni -- té 
      es glo -- ri -- fié a -- vec le Père et le Saint Es -- prit,
      sau -- ve_- nous, prends pi -- tié de nous, 
      ô Christ, no -- tre Dieu_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a8 ([g]) a [bes] c4 c d d8 [c] c4. c8 c [c] c [c] c [c] c4. 
          c8 c4 c8 [c] c4 c8 [c] f4 f8 [f] f [f] c4 c8 [c] c2
          a4 a8 [bes] c4 c bes8 [c] d [c] c4. c8 c [c] c4 c c2
          c4 c8 [c] c4. c8 bes4 bes a2 c8 [c] f4. f8 c [c] c4 c c2
          a4. g8 a bes c4 (bes8) [c] d4 c c4. c8 c [c] c [c] c [c] c4
          bes8 [a] bes4 a c c8 [c] f4 f8 [f] f4 e f4. c8 c2 c4 c c2
        }%\cadenzaOn \ton
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          f4 f8 [f] f4 f bes, bes8 [c] f4.\resp
          f8 a [g] f [f] f [f] f4. f8 c ([f]) e [f] c4\resp
          f8 [f] f4 f8 [f] f [f] f4 e8 [c] f2
          f4 f8 [f] f4 f f8 [f] bes, [c] f4.\resp
          f8 a [g] f4 f c2
          a'4 f8 [g] a4. a8 g4 e f2\resp
          f8 [f] f4. f8 f [f] e4 c f2
          f4. c8 f [f] f4. f8 bes,4 c f4.\resp
          f8 a [g] f [f] f [f] f4 f8 [f] e4 f c \resp
          f8 [f] f4 f8 [f] <bes, bes'>4 <c c'> f4.\resp
          a8 g4. (f8) e4 c f2
        }
      }
   >>
>>