\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   system-system-spacing.basic-distance = #0
%   top-margin = 4
%   bottom-margin = 4
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter ni plier svp"
%   print-page-number = ##f
% }
% 
% #(set-global-staff-size 14)
% 
% \header {
%   title = \markup \center-column { "Ô Seigneur, pasteur fidèle" }
%   subtitle = " "
%   poet = ""
%   composer = ""
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
    \override InstrumentName.X-offset = 3
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = { \key g \minor \time 4/4 }

resp = { \breathe }
im = \set ignoreMelismata = ##t

sopMusic = \relative c'' {
  g4 a bes bes bes c d d\fermata\resp
  d d c bes a4. g8 g2\fermata\resp\bar":|."
  d'4 d ees ees d d c c\fermata\resp
  c c d d c c bes bes\fermata\resp
  bes c d \slurDashed c8 (bes) a4 a g g\fermata
  \bar"|."
}

altoMusic = \relative c' {
  d4 d d d d f f f f bes bes8 (a) a (g) g4
  \override BalloonText.annotation-balloon = ##f 
  <fis \balloonText #'(2 . -3)\markup { "" } >
  d2
  g4 g g aes aes g8 (f) f (d) e4 f f f g g f8 (ees) ees (c) d4
  ees ees d \once \slurDashed d8 (d) e4 d8 (c) c (a) b4
}

tenorMusic = \relative c' {
  bes4 a g g g a bes bes 
  bes8 (c) bes (a) g (a) bes (d) ees4 
  \override BalloonText.annotation-balloon = ##f 
  <d \balloonText #'(2 . 4)\markup { "" } >8
  (c) bes2
  b8 (c) d (b) c4 c c b c g
  a8 (bes) c (a) bes4 bes bes a bes f
  g g a \slurDashed g8 (g) g4 fis g d
}

bassMusic = \relative c' {
  g4 fis g g, g' f bes bes,\fermata\resp
  bes'8 (a) g (f) e (fis) g4 c, d g,2\fermata\resp
  g'8 (a) b (g) c (bes) aes (g) f (d) g4 c, c\fermata\resp
  f8 (g) a (f) bes (a) g (f) ees (c) f4 bes, bes\fermata\resp
  ees d8 (c) fis (d) \slurDashed g (g) cis,4 d g g,\fermata
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. "\set shortVocalName = "1." 
  Ô Sei -- gneur, Pas -- teur fi -- dè -- le, 
  toi qui con -- nais tes bre -- bis,
 
}

altoWordsunb = \lyricmode { 
  \set shortVocalName = "1." 
  tu conn -- ais le cœur du Pè -- re 
  et le Pè -- re te con -- naît.
  Que nos cœurs à ta pa -- ro -- le 
  s’ouvrent et brû -- lent par ta grâ -- ce
  et s’é -- veillent à ta pré -- sen -- ce.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "\set shortVocalName = "2." 
  Vois le trou -- peau qui s’é -- ga -- re 
  loin de ton a -- mour, Sei -- gneur.
}

altoWordsdeuxb = \lyricmode { 
  \set shortVocalName = "2." 
  Viens cher -- cher sur tes é -- pau -- les 
  la bre -- bis qui s’est per -- due.
  Joie au ciel et sur la ter -- re 
  quand tu viens et fais re -- naî -- tre
  les pé -- cheurs \im à la vie nou -- vel -- le.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. "\set shortVocalName = "3." 
  Toi, l’A -- gneau de la vraie Pâ -- que, 
  im -- mo -- lé sur u -- ne croix,
}

altoWordstroisb = \lyricmode { 
  \set shortVocalName = "3." 
  bon Pas -- teur qui, pour ton peu -- ple, 
  li -- vres ta vie à la mort.
  Dans ta chair s’ouvre u -- ne por -- te_: 
  Dans le feu de tes bles -- su -- res,
  res -- plen -- dit l’a -- mour du Pè -- re.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. "\set shortVocalName = "4." 
  Ta vie, c’est toi qui la don -- nes, 
  nul ne peut te la ra -- vir.
}

altoWordsquatreb = \lyricmode { 
  \set shortVocalName = "4." 
  Tu es ve -- nu dans le mon -- de 
  pour nous don -- ner la vraie vie.
  Fais_- nous vivre en ta pro -- mes -- se 
  et gran -- dir en ta pa -- ro -- le_:
  “Ai -- mez_- vous les uns les au -- tres”. 
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5."\set shortVocalName = "5." 
  Dans l’au -- ro -- re de ta Pâ -- que, 
  tu te lè -- ves du tom -- beau.
}

altoWordscinqb = \lyricmode { 
  \set shortVocalName = "5." 
  Aux en -- fers et sur la ter -- re, 
  tu dé -- li -- vres ton trou -- peau.
  Dans la joie de ta vic -- toi -- re, 
  viens, Sei -- gneur, et res -- sus -- ci -- te
  ceux qui cher -- chent ton vi -- sa -- ge.

}

altoWordssix = \lyricmode { 
  \set stanza = #"6."\set shortVocalName = "6." 
  Près d’u -- ne sour -- ce d’eau vi -- ve, 
  tu nous guides et nous con -- duis_;
}

altoWordssixb = \lyricmode { 
  \set shortVocalName = "6." 
  et sur des prés d’her -- be fraî -- che,
  tu fais paî -- tre ton trou -- peau.
  Sur la ta -- ble que tu dres -- ses,
  tu te livres en nour -- ri -- tu -- re_:
  Pain de vie, Sang de l’Al -- lian -- ce.
}

altoWordssept = \lyricmode { 
  \set stanza = #"7."\set shortVocalName = "7." 
  Bien d’au -- tres bre -- bis en -- co -- re 
  ne sont pas de ton ber -- cail.
}

altoWordsseptb = \lyricmode { 
  \set shortVocalName = "7." 
  Par ta mort, tu les ar -- ra -- ches
  au vo -- leur et au bri -- gand.
  Il faut que tu les ra -- mè -- nes,
  qu’à ta voix, tous se ras -- sem -- blent
  dans l’u -- nique a -- mour du Pè -- re.
}

altoWordshuit = \lyricmode { 
  \set stanza = #"8."\set shortVocalName = "8." 
  Gloire à toi, Ber -- ger fi -- dè -- le,
  toi, la por -- te des bre -- bis_:
}

altoWordshuitb = \lyricmode { 
  \set shortVocalName = "8." 
  Tu nous con -- duis vers le Pè -- re
  pour que ta joie soit en nous.
  Et l’Es -- prit que tu nous don -- nes
  vient ré -- vé -- ler ta ten -- dres -- se
  et cé -- lé -- brer ta lou -- an -- ge.
}

\score {
  \new ChoirStaff <<
    \set ChoirStaff.beamExceptions = #'()
    \set ChoirStaff.baseMoment = #(ly:make-moment 1/4)
    \set ChoirStaff.beatStructure = #'(1 1 1 1)
    \new Staff = "women" 
    <<
      \new Voice = "sopranos" {
        \voiceOne
        << \global \sopMusic >>
      }
      \new Voice = "altos" %\with { \consists "Balloon_engraver" }
      {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>
    \new Lyrics = "altoWordsun"
    \new Lyrics = "altoWordsunb"
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
    \new Lyrics = "altoWordsdeux"
    \new Lyrics = "altoWordsdeuxb"
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
    \new Lyrics = "altoWordstrois"
    \new Lyrics = "altoWordstroisb"
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
    \new Lyrics = "altoWordsquatre"
    \new Lyrics = "altoWordsquatreb"
%     \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
%     \new Lyrics = "altoWordscinq"
%     \new Lyrics = "altoWordscinqb"
%     \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
%     \new Lyrics = "altoWordssix"
%     \new Lyrics = "altoWordssixb"
%     \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
%     \new Lyrics = "altoWordssept"
%     \new Lyrics = "altoWordsseptb"
%     \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
%     \new Lyrics = "altoWordshuit"
%     \new Lyrics = "altoWordshuitb"
    \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    
    \new Staff = "men" 
    <<
      \clef bass
      \new Voice = "ténors" %\with { \consists "Balloon_engraver" }
      {
        \voiceOne
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo << \global \bassMusic >>
      }
      \context Lyrics = "altoWordsun" \lyricsto "ténors" \altoWordsun
      \context Lyrics = "altoWordsunb" \lyricsto "ténors" \altoWordsunb
      \context Lyrics = "altoWordsdeux" \lyricsto "ténors" \altoWordsdeux
      \context Lyrics = "altoWordsdeuxb" \lyricsto "ténors" \altoWordsdeuxb
      \context Lyrics = "altoWordstrois" \lyricsto "ténors" \altoWordstrois
      \context Lyrics = "altoWordstroisb" \lyricsto "ténors" \altoWordstroisb
      \context Lyrics = "altoWordsquatre" \lyricsto "ténors" \altoWordsquatre
      \context Lyrics = "altoWordsquatreb" \lyricsto "ténors" \altoWordsquatreb
%       \context Lyrics = "altoWordscinq" \lyricsto "ténors" \altoWordscinq
%       \context Lyrics = "altoWordscinqb" \lyricsto "ténors" \altoWordscinqb
%       \context Lyrics  = "altoWordssix" \lyricsto "ténors" \altoWordssix
%       \context Lyrics  = "altoWordssixb" \lyricsto "ténors" \altoWordssixb
%       \context Lyrics = "altoWordssept" \lyricsto "ténors" \altoWordssept
%       \context Lyrics = "altoWordsseptb" \lyricsto "ténors" \altoWordsseptb
%       \context Lyrics = "altoWordshuit" \lyricsto "ténors" \altoWordshuit
%       \context Lyrics = "altoWordshuitb" \lyricsto "ténors" \altoWordshuitb
    >>
  >>
}
