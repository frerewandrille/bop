\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   %system-system-spacing #'basic-distance = #17
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = ##f
% }
% 
% 
% #(set-global-staff-size 19)
% 
% \header {
%   title = \markup \center-column { "Au ciel les Anges" }
%   subtitle = " "
%   poet = "Texte : fr. Dominique Cerbelaud op"
%   composer =  "Musique : Giovanni Gastoldi (XVIe s.)"
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
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key f \major
  \time 6/4
}

sopMusic = \relative c'' {
  \partial 2. c4 c bes a2 f4 c' c bes a2 f4 \allowBreak c'2 bes4 a2 f4 g2 g4 f2. \allowBreak 
  c'4 c bes a2 f4 c' c bes a2 f4 \allowBreak c'2 bes4 a2 f4 g2 g4 f2. \allowBreak 
  a4 bes c d2 bes4 d ees c d2 bes4 \allowBreak c a bes c2 c4 bes g a bes2 bes4\allowBreak 
  bes bes a g4.( f8) e4 f f e f2. \bar "|."
}

altoMusic = \relative c' {
  \partial 2. f4 f f f2 f4 f f f f2 f4 f2 d4 f2 f4 e4.( d8) e4 f2.
  f4 f f f2 f4 f f f f2 f4 f2 d4 f2 f4 e4.( d8) e4 f2.
  f4 g a bes2 f4 f g f f2 d4 f f f f2 f4 
  d g f f2 f4 f g f e!2 c4 c d c c2.
}

tenorMusic = \relative c' {
  \partial 2. a4a d c2 a4 a a d c2 a4 a2 bes4 c2 a4 c2 c4 a2.
  a4a d c2 a4 a a d c2 a4 a2 bes4 c2 a4 c2 c4 a2.
  c4 ees ees f2 d4 bes bes a bes2 bes4 a c d a2 a4 bes c c d2 d4 
  f ees c c2 g4 a bes g a2.
}

bassMusic = \relative c {
  \partial 2. f4 f bes, f'2 f4 f f bes, f'2 f4 f2 g4 f2 f4 c2 c4 f2.
  f4 f bes, f'2 f4 f f bes, f'2 f4 f2 g4 f2 f4 c2 c4 f2.
  f4 ees c bes2 bes4 bes ees f bes,2 bes4 f' f bes, f'2 f4 g ees f bes,2 bes4
  d ees f c2 c4 f, bes c f,2.
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Au ciel, les An -- ges te crient sans ces -- "se : " 
  “Trois fois saint est le Sei -- gneur.”
  Ils se pros -- ter -- nent de -- vant ton Trô -- ne,
  a -- do -- rant ta Sain -- te -- té.
  Peuple in -- vi -- si -- ble, dont la pri -- è -- re 
  con -- duit nos hym -- nes à ta lou -- an -- "ge :"
  “À toi la Gloi -- "re !" Al -- lé -- lu -- "ia !”"
}

altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  La Vier -- ge pu -- re plei -- ne de grâ -- ce, 
  sain -- te mè -- re du Sau -- veur,
  Jean le Bap -- tis -- te, dont la lu -- miè -- re
  de -- vant toi s’est a -- van -- cée,
  a -- vec les jus -- tes et les pro -- phè -- tes,
  en toi ex -- ul -- tent et te re -- di -- "sent : "
  “À toi la Gloi -- "re !" Al -- lé -- lu -- "ia !”"
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Té -- moins fi -- dè -- les du Fils de l’hom -- me,
  le sui -- vant jus -- \apostrophe qu’à la mort,
  sa vie nou -- vel -- le les il -- lu -- mi -- ne, 
  ils re -- nais -- sent de l’Es -- prit.
  Te -- nant les pal -- mes de la vic -- toi -- re, 
  leur foule im -- men -- se sans fin ac -- cla -- me_:
  “À toi la Gloi -- "re !" Al -- lé -- lu -- "ia !”"  
}

altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Tu nous at -- ti -- res dans ta lu -- miè -- re,
  Christ sau -- veur de tous les temps.
  Ta croix se dres -- se sur no -- tre mon -- de_:
  Terre et ciel sont ré -- u -- nis.
  L’Es -- prit nous gui -- de vers ton mys -- tè -- re.
  En toi se don -- ne l’a -- mour du Pè -- re.
  “À toi la Gloi -- "re !" Al -- lé -- lu -- "ia !”"
}


\score {
  \new ChoirStaff <<
    \new Staff = "women" <<
      \new Voice = "sopranos" {
        \voiceOne \revert Staff.TimeSignature.style
        << \global \sopMusic >>
      }
      \new Voice = "altos" {
        \voiceTwo
%        << \global \altoMusic >>
      }
    >>
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "sopranos" \altoWordsquatre
%     \new Staff = "men" <<
%       \clef bass
%       \new Voice = "tenors" {
%         \voiceOne \revert Staff.TimeSignature.style
%         << \global \tenorMusic >>
%       }
%       \new Voice = "basses" {
%         \voiceTwo << \global \bassMusic >>
%       }
%     >>
  >>
}