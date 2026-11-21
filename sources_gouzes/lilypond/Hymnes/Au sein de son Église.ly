\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

% \paper {
%   #(set-paper-size "a5")
%     top-margin = 12
% }
% 
% #(set-global-staff-size 16)
% 
% \layout { 
%   indent = #0
%   \context { \Score \remove "Bar_number_engraver"
%   }
%   \context { \Lyrics \override LyricText.font-size = #2
%    \override LyricSpace.minimum-distance = #1
%   }
% }
% 
% \header {
%   title = \markup \center-column { "Au sein de son Église" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
%   tagline = ##f
% }
% 
\layout {    
  \context { 
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  }
} 

global = {
  \key g \major
  \time 2/2
}
resp = { \breathe\allowBreak }

sopMusic = \relative c' {
  \partial4 d g b a a b4. (c8) d4 \resp d c b a a g2. \bar ":|.:"
  g4 fis e d g g (a) b \resp b a g g fis g2.\fermata \bar ":|."
}

altoMusic = \relative c' {
  \partial4 b4 b d d d d2 d4 d g g g fis g2.
  d4 c c d b b (e) dis d d b e d d2.
}

tenorMusic = \relative c' {
  \partial4 g4 g g g fis g4. (a8) b4 \breathe a c d d d b2.
  b4 a g g g g (e) fis \breathe g fis g c a b2.
}

bassMusic = \relative c' {
  \partial4 g4 e b c d g2 g4 fis e g d d g,2.
  g4 a c b g e' (c) b g d' e c d <g, g'>2.\fermata
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "   \set shortVocalName = #"1. "
  Au sein de son É -- gli -- se, le Sei -- gneur l’ap -- pe -- la.
  Le com -- bla de sa -- ges -- se, de gloi -- re, le vê -- tit,
}

altoWordsdeux = \lyricmode {  %\set stanza = #"2. " 
  Pour por -- ter sa Pa -- ro -- le, il lui don -- na l’Es -- prit,
  Et sur lui fit des -- cen -- dre al -- lé -- gresse et bon -- heur.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = #"2. "
  Aux sour -- ces d’É -- van -- gi -- le, le Sei -- gneur le me -- na,
  Lui don -- na sans me -- su -- re la sè -- ve du sa -- voir,
}

altoWordsquatre = \lyricmode {  %\set stanza = #"V 3. "
  Le plan -- ta comme un ar -- bre près des eaux du sa -- lut,
  Lui fit en a -- bon -- dan -- ce por -- ter du fruit de choix.
}

altoWordscinq = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = #"3. "
  Du tré -- sor de ses grâ -- ces, le Sei -- gneur l’ins -- trui -- sit,
  Il lui don -- na d’en vi -- vre a -- vec fi -- dé -- li -- té,
}

altoWordssix = \lyricmode {  %\set stanza = #". "
  De la nou -- velle Al -- lian -- ce, lui en -- sei -- gna la loi.
  %\set stanza = #". "
  D’en -- sei -- gner dans l’É -- gli -- se a -- vec hu -- mi -- li -- té.
}

altoWordssept = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = #"4. "
  Gloire à toi, no -- tre Pè -- re, qui nous at -- tires à toi,
  Fais_- nous gran -- dir sans ces -- se dans l’a -- mour de ton Fils,
}

altoWordshuit = \lyricmode {  %\set stanza = #". "
  Pour vivre en ta lu -- miè -- re la joie des fils de Dieu.
  %\set stanza = #". "
  Et re -- cher -- cher ta fa -- ce, gui -- dés par ton Es -- prit.
}


\score {
  \new ChoirStaff <<
    \new Staff = "women"     
  \with { \override VerticalAxisGroup.staff-staff-spacing.minimum-distance = #0 }
    <<
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
    \new Lyrics 
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
    \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics 
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
    \lyricsto "sopranos" \altoWordsquatre
    \new Lyrics \lyricsto "sopranos" \altoWordscinq
    \new Lyrics 
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
    \lyricsto "sopranos" \altoWordssix
    \new Lyrics \lyricsto "sopranos" \altoWordssept
    \new Lyrics 
    \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "sopranos" \altoWordshuit
    
    \new Staff = "men" <<
      \clef bass
      \new Voice = "tenors" {
        \voiceOne
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo 
        << \global \bassMusic >>
      }
    >>
  >>
}
