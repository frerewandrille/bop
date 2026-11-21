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
    \override InstrumentName.X-offset = 1
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key a \minor
  \time 3/2
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

sopMusic = \relative c' {
  \slurDashed\tieDashed
  f4 e2 f4-> g a-> g f2 d4-> f e-> (f) g-> (f) e2\resp
  g4 a-> c a-> g f-> g g-> f e2 d2.\fermata\bar"|"
  c4 d-> d d2 c4-> d f-> e d-> e e2~ e\resp
  g4 g-> a g-> (f) d-> f e-> f g-> f e2\fermata
  \bar "|."\slurSolid
  e2 (f4 e) d2 (e)\breathe d4 c d (e) e2\fermata
  \bar "|."
}

altoMusic = \relative c' { 
  \slurDashed\tieDashed
  d4 e2 d4 d c c f2 d4 d e (d) c (d) e2
  4 d d e e f f e e d2 2.
  d4 d d d2 d4 d d d d d c2~ c
  c4 c c c~ c d d d d c d e2
  \slurSolid
  e2 (f4 e) d2 (e) d4 c d (e) e2
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. " \set shortVocalName = "1."
  \im Ô Christ, toi qui as se -- mé ton sa -- lut __\skip4 dans nos cœurs,
  en toi nous con -- nais -- sons l’a -- mour du Pè -- re.
  Splen -- deur du jour qui ray -- on -- ne sur le mon -- de,
  tu es lu -- miè -- __\skip4 re pour ceux qui croient en toi.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "  \set shortVocalName = "2."
  \im Ô Christ, toi qui as vain -- cu le pé -- ché par ton a -- mour,
  A -- gneau qui por -- tes le pé -- ché du mon -- de,
  res -- sus -- ci -- té, tu ac -- cueil -- les ton é -- pou -- se
  que tu as pu -- ri -- fiées par l’Es -- prit et le sang.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. " \set shortVocalName = "3."
  \im Ô Christ, toi qui as bri -- sé les puis -- san -- ces de l’en -- fer,
  toi qui t’é -- lèves en gloire au -- près du Pè -- re,
  tu nous en -- traînes a -- vec toi dans ton tri -- om -- phe,
  nous qui é -- tions cap -- tifs au pou -- voir de la mort.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. " \set shortVocalName = "4."
  \im Ô Christ, toi qui fais bril -- ler ta mi -- sé -- ri -- cor -- __\skip4 de,
  pour nous pé -- cheurs, tu es par -- don du Pè -- re
  et tu ras -- sembles en ton Corps qui est l’É -- gli -- se
  tous ceux qui crient vers toi, é -- le -- vé sur la croix.
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5. " \set shortVocalName = "5."
  \im Ô Christ, toi qui nous con -- duis au Ro -- yau -- __\skip4 me des cieux
  où nous se -- rons com -- blés de ton vi -- sa -- ge,
  tu es -- suie -- ras tou -- te lar -- me de nos yeux. __\skip4
  En ta lu -- mière, ô Christ, nous ver -- rons la lu -- mière.
}

altoWordssix= \lyricmode { 
  \set stanza = #"6. " \set shortVocalName = "6."
  \im Ô Christ, toi qui es mon -- té près du Pè -- re dans les cieux,
  à toi nos chants, à toi no -- tre lou -- an -- ge,
  dans l’Es -- prit_- Saint, par qui no -- tre cœur e -- xul -- te
  car tu nous l’as pro -- mis pour nous con -- duire à toi.
  \imstop A -- men_! Al -- lé -- lu -- ia_!
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
  \new Lyrics \lyricsto "sopranos" \altoWordssix
>>