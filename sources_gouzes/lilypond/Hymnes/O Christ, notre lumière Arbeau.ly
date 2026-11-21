\version "2.24.0"
% 
% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 3
%   bottom-margin = 0
%   left-margin = 10
%   right-margin = 10
%   tagline = ##f
% }
% 
% #(set-global-staff-size 17)
% 
% \header {
%   title = "Ô Christ, notre lumière"
%   subtitle = " "
%   poet = ""
%   composer =  "Arbeau"
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

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key d \minor
  \time 2/2
}

sopMusic = \relative c'' {
  \partial2 g2 g4 fis g a bes2 bes4 d c bes bes a bes2 \breathe \allowBreak \break
  g g4 fis g a bes2 bes4 d c bes bes a bes2 \breathe \allowBreak \break
  bes a4 a g g f2 d e8(f) g4 g fis g2 \breathe \allowBreak \break
  bes a4 a g g f2 d e8(f) g4 g fis g2 \bar "|."
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
  \set stanza = #"1. " \set shortVocalName = "1."
  Ô Christ, no -- tre lu -- miè -- re, no -- tre so -- leil le -- vant,
  Fils bien_- ai -- mé du Pè -- re, tu es le Dieu vi -- vant.
  So -- leil en no -- tre nuit, dis -- si -- pe nos pé -- chés.
  Lu -- mière en no -- tre vie, prends_- nous en ta clar -- té.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "\set shortVocalName = "2."
  Tu viens gui -- der nos â -- mes pour les me -- ner vers Dieu.
  Tu nous four -- nis les ar -- mes du com -- bat glo -- ri -- eux_:
  Par ta  di -- vi -- ne loi, tu viens nous é -- clai -- rer.
  Af -- fer -- mis no -- tre foi_: Rien ne peut l’é -- bran -- ler.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Nous a -- vons l’as -- su -- ran -- ce de ta fi -- dé -- li -- té.
  Don -- ne_- nous l’es -- pé -- ran -- ce de ton é -- ter -- ni -- té.
  L’eau vi -- ve de l’Es -- prit a -- breu -- ve no -- tre cœur.
  En pro -- met -- tant ta vie, tu of -- fres le bon -- heur.
}

\markup { \vspace #-0.75 }

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
    
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "sopranos" \altoWordstrois
    
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