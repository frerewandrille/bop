\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   system-system-spacing.basic-distance = #30
%   top-margin = 8
%   bottom-margin = 0
%   left-margin = 10
%   right-margin = 10
%   tagline = ##f
% }
% 
% #(set-global-staff-size 17)
% 
% \header {
%   title = \markup \center-column { "Jésus, lumière né de la lumière" }
%   subtitle = " "
%   poet = ""
%   composer = ""
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
    \override InstrumentName.X-offset = 2.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key a \minor
  \time 6/4
}


altoMusic = \relative c'' {
  r4 d,^\markup\italic"Mystérieux" e^> f g^> a d,^> e f^> g f^> (e) e2.\fermata\breathe\allowBreak
  g4 a^> c c2.^> b4 a^> g a^> b b2\fermata\bar"|"
  r4 a4^\markup{\concat{\dynamic pp}{\italic", en dehors"}} a^> c d^> c c^> b a^> g a^> f e^> (d f g) a2\fermata\breathe\allowBreak
  d,4^\markup\italic"Large" e^> f g^> a g^> f g^> f e2\fermata\bar"|." e2 (f4 e) d2 (e)\bar"|."
}

tenorMusic = \relative c' {
  b2 a b c b a b2. r4 r2 e d c d d~ d d d e e d d d c
  c4 c c b b b a a a <b e>2
  a2 (g4 a) b2 (a)
}

bassMusic = \relative c {
 e\breve*6/4 2. \breathe r4 r2 c d e f g\fermata~ \breve*2 f2\fermata\breathe
 r4 r2 r4 d e-> f g-> a <e b'>2\fermata
 e2 (d) d (<a e'>)
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "\set shortVocalName = \markup\right-align"1."
  Jé -- sus, lu -- miè -- re né de la lu -- miè -- re,
  Par ta splen -- deur nos yeux sont é -- blou -- is_;
  Dans ta lu -- mière, ô Christ, nous vo -- yons la lu -- miè -- re
  Et no -- tre cœur dé -- bor -- de de ta joie.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = \markup\right-align"2."
  Ve -- nu d’au -- près de Dieu, sau -- veur des hom -- mes,
  Tu as pris chair sans ces -- ser d’ê -- tre Dieu_;
  Ô Christ, toi qui re -- po -- ses dans le sein du Pè -- re,
  Tu as fait ta de -- meu -- re par -- mi nous.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = \markup\right-align"3."
  Toi le buis -- son ar -- dent que vit Mo -- ï -- se,
  En no -- tre chair, tu brû -- les comme un feu_;
  Tu fais bril -- ler sur nous l’i -- ma -- ge de ton Pè -- e.
  Tu res -- plen -- dis au cœur de no -- tre nuit.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = \markup\right-align"4."
  En -- gen -- dré par le Père a -- vant les siè -- cles,
  Tu le ré -- vèles à ceux qui croient en toi_:
  En te vo -- yant ô Christ, nous con -- tem -- plons sa fa -- ce,
  Nos yeux ont vu ton in -- vi -- sible a -- mour.
}

altoWordscinq = \lyricmode {  
  \set stanza = #"5. "\set shortVocalName = \markup\right-align"5."
  La nuit est en -- glou -- tie dans la lu -- miè -- re,
  Ton jour nou -- veau n’au -- ra pas de cou -- chant_;
  La crêche où tu re -- poses est rem -- plie de ta gloi -- re,
  La terre en -- tière é -- clate en cris de joie.
}

altoWordssix = \lyricmode {  
  \set stanza = #"6. "\set shortVocalName = \markup\right-align"6."
  Gloire à toi, Christ Sei -- gneur, né de la Vier -- ge,
  Gloire à l’Es -- prit qui fa -- çon -- na ton corps_;
  Lou -- ange au Pè -- re Saint qui a ai -- mé le mon -- de,
  Et lui don -- na le Fils de son a -- mour. A -- men.
}


\score {
  \new ChoirStaff 
  <<
    \new Staff = "women" \with { \remove "Time_signature_engraver" }
    \new Voice = "altos" {
       \cadenzaOn \altoMusic
    }
    
    \new Lyrics \lyricsto "altos" \altoWordsun
    \new Lyrics \lyricsto "altos" \altoWordsdeux
    \new Lyrics 
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
    \lyricsto "altos" \altoWordstrois
    \new Lyrics \lyricsto "altos" \altoWordsquatre
    \new Lyrics \lyricsto "altos" \altoWordscinq
    \new Lyrics \lyricsto "altos" \altoWordssix
    \new Staff = "men" \with { \remove "Time_signature_engraver" } \with { \consists "Merge_rests_engraver" }
    <<
      \clef bass
      \new Voice = "ténors" {
        \voiceOne
        << \global \cadenzaOn \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo 
        << \global \cadenzaOn \bassMusic >>
      }
    >>
  >>
}