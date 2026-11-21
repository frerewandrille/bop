\version "2.24.0"
%\include "vowel-set.ly"

% \layout {
% %  indent = #0
%   \context {
%     \Score \remove "Bar_number_engraver"
%   }
%   \context {
%     \Lyrics
%     \override LyricText.font-size = #2
%     \override LyricSpace.minimum-distance = #1
%   } 
% }

ss = { \hideNotes bes\breve*1/8 \unHideNotes \allowBreak }
armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
saut = \allowBreak
pause = \bar "|"
aligne = \once \override LyricText.X-offset = #center-on-vowel
gauche = \once \override LyricText.self-alignment-X = #LEFT

ital = { \override Lyrics.LyricText.font-series = #'bold }
norm = { \revert Lyrics.LyricText.font-series }

\score {
  \layout { indent = #0 }
  \new Staff \with {\remove Time_signature_engraver }
  << 
    \cadenzaOn \key f \major 
    \new Voice = "melodie" \relative c' { 
      f\breve*1/8 \ss \ss e,4 d f2 \bar "||" 
      <<    
        <<
          { \voiceOne a\breve*1/8^\markup\italic"vif" \ss bes4 bes a2 } 
          \new Voice { \voiceTwo f\breve*1/8 s e4 e f2 }
        >>
        \new Staff \with {\remove Time_signature_engraver }
        << \clef "bass" \key f \major \cadenzaOn
           { \voiceOne c\breve*1/8 s c4 c c2 } 
           \new Voice  { \voiceTwo f,\breve*1/8 s c4 c f2 }
        >>
      >>     \bar "|." \break
      f'\breve*1/8 g2 g4 g f2 \bar "||" 
      <<    
        <<
          { \voiceOne a\breve*1/8^\markup\italic"vif" \ss \ss bes \ss \ss \ss a2 } 
          \new Voice { \voiceTwo f\breve*1/8 s s e s s s f2 }
        >>
        \new Staff \with {\remove Time_signature_engraver }
        << \clef "bass" \key f \major \cadenzaOn
           { \voiceOne c\breve*1/8 s s c s s s c2 } 
           \new Voice  { \voiceTwo f,\breve*1/8 s s c s s s f2 }
        >>
      >>     \bar "|." \break
      f'\breve*1/8 \ss \ss \ss e,4 d f2 \bar "||" 
      <<    
        <<
          { \voiceOne a\breve*1/8^\markup\italic"vif" \ss bes4 bes a2 } 
          \new Voice { \voiceTwo f\breve*1/8 s f4 e f2 }
        >>
        \new Staff \with {\remove Time_signature_engraver }
        << \clef "bass" \key f \major \cadenzaOn
           { \voiceOne c\breve*1/8 s d4 c c2 } 
           \new Voice  { \voiceTwo f,\breve*1/8 s bes,4 c f2 }
        >>
      >>     
      \bar "|." 
    }
  
  
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #LEFT }
    \lyricsto "melodie" {   
      Le Sei -- gneur soit avec vous.
      Et avec votre Es -- prit.

      Éle -- vons no -- tre cœur.
      Nous le tour -- nons vers le Sei -- gneur

      \aligne Rendons grâce au Sei -- gneur notre Dieu.
      Cela est juste et bon.
    }
  >>
}