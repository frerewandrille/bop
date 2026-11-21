\version "2.24.0"

\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

% \paper {
%   #(set-paper-size "a5")
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% #(set-global-staff-size 13)
% 
% \header {
%   title = \markup \center-column { "Voici qu’il vient" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
% }
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

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 0.25
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
  } 
}

%\layout { ragged-last = ##t indent = #0 }

global = {
  \key c \major
  \time 4/4
}

resp = { \breathe\allowBreak }

sopMusic = \relative c' {
  e4 c-> e g-> a b-> a a2 a4\resp g4 a-> b c-> b a-> g a-> (b) a2. \bar "|" 
  a4 a-> b g-> g e-> g f-> e d2.\resp e4 c-> e g-> a b-> a a2 \bar "|." 
  a2 (b4 a) g2 (a)  \bar "|." 
}
altoMusic = \relative c' {
  c4 b b a c d e e2 4 e e d c d e f e (d) e2.
  e4 e d d c c b a c d2. c4 b b a c d e e2 e2 (d4 e) f (e e2)
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Ô mer -- veil -- leuse et vraie lu -- miè -- re,
  qui viens sur ceux de la té -- nè -- bre,
  vi -- site et trans -- fi -- gu -- re no -- tre nuit,
  so -- leil le -- vant, Jé -- sus Sau -- veur_!  
}
altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Viens ha -- bi -- ter dans no -- tre mon -- de,
  donne à tous ceux qui te re -- çoi -- vent
  pou -- voir de de -- ve -- nir en -- fants de Dieu,
  toi no -- tre frère, ô Pre -- mier_- Né_!
}
altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Viens ré -- vé -- ler l’a -- mour du Pè -- re
  à ceux qui vont sans es -- pé -- ran -- ce,
  toi le che -- min, la vé -- ri -- té, la vie,
  con -- duis nos pas, ô Bien_- Ai -- mé_!
}
altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Viens ap -- por -- ter la dé -- li -- vran -- ce
  aux pri -- son -- niers que l’ombre en -- chaî -- ne_;
  Dans ta mi -- sé -- ri -- cor -- de, sau -- ve_- les,
  A -- gneau de Dieu, vain -- queur du Mal_!
}
altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  Viens, ouvre aux hom -- mes le Roy -- au -- me,
  a -- chève en nous ce qui com -- men -- ce,
  ô toi nou -- vel -- le terre et ciel nou -- veau,
  toi l’O -- ri -- ent du jour sans fin_!
}
altoWordssix = \lyricmode {  
  \set shortVocalName = "6." \set stanza = #"6. "
  Ac -- tion de grâce, hon -- neur et gloi -- re
  à Dieu le Pè -- re des lu -- miè -- res,
  par Jé -- sus Christ, au -- ro -- re sans dé -- clin,
  dans la clar -- té de l’Es -- prit Saint_!
  A -- men_!
}

\new ChoirStaff 
<<
  \new Staff = "women" \with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne
      << \global \cadenzaOn \tempo 2 = 56 \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo
      << \global \cadenzaOn \altoMusic >>
    }
  >>
  
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics \lyricsto "sopranos" \altoWordssix
>>