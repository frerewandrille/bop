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
%   title = \markup \center-column { "Du cœur de notre misère" }
%   title = \markup \center-column { "Du cœur de notre misère" }
%   subtitle = " "
%   poet = ""
%   composer = ""
%   tagline = ##f
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
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key e \minor
  \time 3/2
}

resp = { \breathe\allowBreak }

sopMusic = \relative c' {
  e8 [b] e [fis] g [a] fis4 e\resp
  g8 [fis] e [fis] g [a] b4\bar "|"
  b8 [c] d [g,] c [b] a4 g\resp
  a8 [a] b [e,] a [g] fis4 e\bar "|."
  d4 e\bar "|."
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. " \set shortVocalName = "1."
  Du cœur de no -- tre mi -- sè -- re,
  nous cri -- ons vers toi, Sei -- gneur_!
  Vers toi mon -- tent nos pri -- è -- res_:
  Sau -- ve_- nous, ô no -- tre Pè -- re.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "  \set shortVocalName = "2."
  Par a -- mour pour tous les hom -- mes, 
  ton Fils a ver -- sé son sang_:
  Il prit sur lui nos souf -- fran -- ces,
  il ef -- fa -- ça nos of -- fen -- ses.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. " \set shortVocalName = "3."
  Toi qui ja -- mais ne te las -- ses
  de par -- don -- ner nos pé -- chés,
  en ton Es -- prit, fais_- nous vi -- vre.
  Que ton a -- mour nous dé -- li -- vre.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. " \set shortVocalName = "4."
  Gloire à toi, Pè -- re du mon -- de,
  et à ton Fils Jé -- sus Christ,
  au Saint_- Es -- prit mê -- me gloi -- re,
  main -- te -- nant et dans les siè -- cles. A -- men_!
}

\new ChoirStaff <<
  \new Staff = "women"\with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \cadenzaOn
      << \global \sopMusic >>
    }
  >> 
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
>>