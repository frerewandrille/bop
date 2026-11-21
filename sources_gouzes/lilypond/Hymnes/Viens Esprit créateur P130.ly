\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 20
%   right-margin = 20
% }
% 
% 
% \header {
%   title = \markup \center-column { "Viens, Esprit créateur" }
%   subtitle = " "
%   poet = ""
%   composer = ""
%   tagline = ##f
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
  \key g \minor
  \time 3/2
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t

sopMusic = \relative c' {
  \slurDashed
  f4-> g f-> ees f g-> f bes-> c bes2\resp
  bes4-> f g-> bes c-> bes c-> d c2.\bar "|"
  bes4 c-> d bes-> a g-> f bes-> c f,-> (g) bes2\resp
  a4-> bes g f-> ees g g-> (a) g f-> (ees) f2\fermata \bar "|."
}

altoMusic = \relative c' { 
  \slurDashed\tieDashed
  f4 ees d c d ees d c c d2 d4 d ees d c d ees ees f2.
  bes4 a a g f ees ees d d ees~ ees d2
  f4 d ees d c c bes (a) bes c (d) c2
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. " \set shortVocalName = "1."
  \im Viens, Es -- prit Cré -- a -- teur nous vi -- si -- ter,
  Viens é -- clai -- rer l’â -- me de tes fils,
  Em -- plis nos cœurs de grâce et de lu -- miè __  -- \skip4 re,
  Toi qui cré -- as tou -- te chose __ \skip4 a -- vec a -- mour.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "  \set shortVocalName = "2."
  \im Toi le Don, l’en -- vo -- yé du Dieu Très_- Haut,
  Tu t’es fait pour nous le Dé -- fen -- seur,
  Tu es l’A -- mour, le Feu, la sour -- ce vi __  -- \skip4 ve,
  Force et dou -- ceur de la grâ __ -- \skip4 ce du Sei -- gneur.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. " \set shortVocalName = "3."
  \im Don -- ne_- nous les sept dons de ton  a -- mour,
  Toi le doigt qui œuvres au Nom du Père,
  Toi dont il nous pro -- mit le règne et la ve -- nue,
  Toi qui ins -- pi -- res nos lan __ -- \skip4 gues pour chan -- ter.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. " \set shortVocalName = "4."
  \im Mets en nous ta clar -- té, em -- bra -- se_- nous,
  En nos cœurs, ré -- pands l’a -- mour du Père,
  Viens for -- ti -- fier nos corps dans leur fai -- bles __ -- \skip4 se,
  Et don -- ne_- nous ta vi -- gueur é -- ter -- nel __ -- \skip4 le.
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5. " \set shortVocalName = "5."
  \im Chasse au loin l’en -- ne -- mi qui nous me -- nace,
  Hâ -- te_- toi de nous don -- ner la paix,
  A -- fin que nous mar -- chions sous ta con -- dui __ -- \skip4 te,
  Et que nos vies soient  la -- vées __ \skip4 de tout pé -- ché.
}

altoWordssix= \lyricmode { 
  \set stanza = #"6. " \set shortVocalName = "6."
  \im Fais_- nous voir le vi -- sa -- ge du Très_- Haut,
  Et ré -- vè -- le_- nous ce -- lui du Fils,
  Et toi l’Es -- prit com -- mun qui les ras -- sem __ -- \skip4 ble,
  Viens en nos cœurs, qu’à ja -- mais nous croy -- ions en toi.
}

altoWordssept = \lyricmode { 
  \set stanza = #"7. " \set shortVocalName = "7."
  \im Gloire à Dieu, no -- tre Pè -- re, dans les cieux,
  Gloire au Fils qui mon -- te des En -- fers,
  Gloire à l’Es -- prit de Force et de Sa -- ges __ -- \skip4 se,
  Dans tous les siè -- cles des siè __ -- \skip4 cles. A __ -- \skip4 men
}


\new ChoirStaff <<
  \new Staff = "women"\with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne \cadenzaOn
      << \global \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo
      << \global \altoMusic >>
    }
  >> 
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
  \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
  \lyricsto "sopranos" \altoWordssix
  \new Lyrics \lyricsto "sopranos" \altoWordssept
>>