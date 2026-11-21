\version "2.24.0"
% 
% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 20
%   right-margin = 20
% }
% 
% % #(set-global-staff-size 15)
% 
% \header {
%   title = \markup \center-column { "Du plus profond de ma misère" }
%   subtitle = " "
%   poet = ""
%   composer = ""
%   tagline = ##f
% }
% 
% \markup{ \vspace #1 }

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
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key e \minor
  \time 6/8
}

resp = { \breathe\allowBreak }

sopMusic = \relative c' {
  \partial4. e8 g a b4. b8 a g fis4 fis8\resp
  a8 a g e4 fis8 a4 g8 fis4. \resp
  g8 fis e fis4. a8 fis g e4 d8\resp
  e8 g e fis4. a8 fis g e4.
  \bar "|."
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. " \set shortVocalName = "1."
  Du plus pro -- fond de ma mi -- sè -- re,
  Dieu, je t’ap -- pelle à mon se -- cours_:
  Con -- tre les coups de ta co -- lè -- re,
  mon seul sa -- lut, c’est ton a -- mour.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "  \set shortVocalName = "2."
  Que monte au ciel cet -- te de -- man -- de
  comme on y voit mon -- ter l’en -- cens_:
  Daigne ac -- cueil -- lir comme une of -- fran -- de
  ces pau -- vres mains que je te tends.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. " \set shortVocalName = "3."
  Si mes pé -- chés cou -- vrent l’em -- prein -- te
  que je re -- çus de mon sau -- veur,
  de ton par -- don, cal -- me ma crain -- te,
  rends_- moi l’es -- poir de ta fa -- veur.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. " \set shortVocalName = "4."
  Chan -- ge ma peur en al -- lé -- gres -- se,
  chan -- ge ma nuit en ta clar -- té.
  J’of -- fre mon âme à tes lar -- ges -- ses,
  aux in -- ven -- tions de ta bon -- té.
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5. " \set shortVocalName = "5."
  Au fils pro -- di -- gue, sois un pè -- re,
  rends_- lui sa place en ton fo -- yer
  où son plai -- sir soit de te pla -- ire
  et son bon -- heur de te lou -- er.
}

\new ChoirStaff <<
  \new Staff = "women" %\with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      << \global \sopMusic >>
    }
  >> 
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
>>