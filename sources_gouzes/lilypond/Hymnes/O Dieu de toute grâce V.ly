\version "2.24.0"
 
\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 15)
% 
% \header {
%   title = \markup \center-column { "Ô Dieu de toute grâce" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
% }

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
%\markup { \vspace #-0.5 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 3
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key g \minor
  \time 2/2
}

sopMusic = \relative c'' {
  \partial2 g2 g4 fis g a bes2 bes4 d c bes bes a bes2 \breathe \allowBreak \break
  g g4 fis g a bes2 bes4 d c bes bes a bes2 \breathe \allowBreak \break
  bes a4 a g g fis2 d e8(f) g4 g fis g2 \breathe \allowBreak \break
  bes a4 a g g fis2 d e8(f) g4 g fis g2 \bar "|."
}

altoMusic = \relative c' {
  \partial2 d2 d4 d d f f2 f4 f e f g f f2
  d d4 d d f f2 f4 f e f g f f2
  f f4 f d ees d2 f c4 d d d b2
  bes f'4 f d ees d2 f c4 d d d d2
}

tenorMusic = \relative c' {
  \partial2 bes2 bes4 a bes c d2 d4 bes g d' c c d2
  bes bes4 a bes c d2 d4 bes g d' c c d2
  d c4 d bes c a2 bes g4 bes a a g2
  d' c4 d bes c a2 bes g4 bes a a g2
}

bassMusic = \relative c' {
  \partial2 g2 g4 d g f bes,2 bes4 bes c d ees f bes,2 \breathe
  g' g4 d g f bes,2 bes4 bes c d ees f bes,2 \breathe
  bes' f4 d g c, d2 bes c4 g d' d g,2 \breathe
  bes' f4 d g c, d2 bes c4 g d' d g,2
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "\set shortVocalName = "1." 
  Ô Dieu de tou -- te grâ -- ce, Pè -- re de Jé -- sus_- Christ,
  Dans ce mon -- de qui pas -- se, tu nous don -- nes la vie.
  Nous som -- mes tes en -- fants_! Veil -- le sur nous, Sei -- gneur.
  En toi, Dieu tout_- puis -- sant, la joie de no -- tre cœur.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = "2." 
  Ô Christ, no -- tre lu -- miè -- re, no -- tre so -- leil le -- vant,
  Fils bien_- ai -- mé du Pè -- re, tu es le Dieu vi -- vant.
  So -- leil en no -- tre nuit, dis -- si -- pe nos pé -- chés.
  Lu -- mière en no -- tre vie, prends_- nous en ta clar -- té.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"L 3. "\set shortVocalName = "3." 
  Ô Es -- prit Saint du Pè -- re et de son Fils Jé -- sus,
  eau vi -- ve pour la ter -- re, en nous tu es ve -- nu.
  Ir -- ri -- gue no -- tre cœur tout au long de ce jour.
  En toi, no -- tre bon -- heur, au -- jour --\apostrophe d’hui et tou -- jours_!
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3." 
  Ô Es -- prit Saint du Pè -- re et de son Fils Jé -- sus,
  eau vi -- ve pour la ter -- re, en nous tu es ve -- nu.
  A -- pai -- se no -- tre cœur à la fin de ce jour.
  En toi, no -- tre bon -- heur, au -- jour --\apostrophe d’hui et tou -- jours_!
}


\score {
  \new ChoirStaff <<
    \new Staff = "women" <<
      \new Voice = "sopranos" {
        \voiceOne
        << \global \sopMusic >>
      }
      \new Voice = "altos" {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>
    
    \new Lyrics \lyricsto "altos" \altoWordsun
    \new Lyrics \lyricsto "altos" \altoWordsdeux
    %\new Lyrics \lyricsto "altos" \altoWordstrois
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "altos" \altoWordsquatre
    
    \new Staff = "men" <<
      \clef bass
      \new Voice = "tenors" {
        \voiceOne
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo << \global \bassMusic >>
      }
    >>
  >>
}