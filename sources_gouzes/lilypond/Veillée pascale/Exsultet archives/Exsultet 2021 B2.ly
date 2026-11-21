\version "2.24.0"
%\include "vowel-set.ly"

% \layout {
% %  indent = #0
%   \context {
%     \Score \remove "Bar_number_engraver"
%   }
%   \context {
%     \Lyrics
%     \override LyricText.font-size = #2
%     \override LyricSpace.minimum-distance = #1
%   } 
% }

ss = { \hideNotes bes\breve*1/8 \unHideNotes \allowBreak }
armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
saut = \allowBreak
pause = \bar "|"
aligne = \once \override LyricText.X-offset = #center-on-vowel
gauche = \once \override LyricText.self-alignment-X = #LEFT

ital = { \override Lyrics.LyricText.font-series = #'bold }
norm = { \revert Lyrics.LyricText.font-series }

\new Staff \with {\remove Time_signature_engraver }
<< 
  \cadenzaOn \key f \major 
  \new Voice = "melodie" \relative c' { 
    a'4 c-> d4 c a c2 \resp % Ô nuit de vrai bonheur
    c\breve*1/8 \ss \ss \ss \ss a \ss g4 f4 g2 g \resp
    g\breve*1/8 \ss \ss \ss \ss \ss \ss f4 a2\fermata  
    \bar "|." \mark \markup "G"

    a\breve*1/8 \ss c2 \saut % Voici la nuit dont il est écrit
    c\breve*1/8 \ss \ss \ss a2 \resp
    c\breve*1/8 \ss \ss d2 d4 c a c2 \resp
    a\breve*1/8 \ss \ss \ss \ss g\breve*1/8 \ss f4 a2\fermata  
    \bar "|." \mark \markup "G"
    
    c\breve*1/8 \ss \ss \ss \ss \ss a2 \resp % Car le pouvoir sanctifiant
    c\breve*1/8 \ss c2 c4 d2 c4 a c2 c \resp
    c\breve*1/8 \ss \ss \ss a2
    a\breve*1/8 \ss \ss g4 f4 a2 \resp 
    a\breve*1/8 f4 g2 g \resp 
    g\breve*1/8 \ss \ss a4 g2 g g\breve*1/8 \ss \ss f4 a2 a\fermata
    \bar "|." \mark \markup "G"
    
    c\breve*1/8 \ss \ss \ss \ss a2 \resp % Dans la grâce
    c\breve*1/8 \ss \ss \ss \ss \ss d2 c4 a c2 \resp
    c\breve*1/8 \ss \ss \ss \ss \ss \ss a2 a
    a\breve*1/8 g4 f4 g2 g\resp
    g\breve*1/8 \ss \ss \ss \ss \ss f4 a2\fermata
    \bar "|." \mark \markup "G"
    
    c\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss a2 a \resp % Mais déjà nous savons
    c\breve*1/8 \ss \ss \ss c2 d4 d c a c2 \pause
    a\breve*1/8 \ss \ss \ss \ss c2 c
    c\breve*1/8 \ss \ss \ss a4 g a2 \pause
    a\breve*1/8 \ss \ss \ss \ss \ss \ss \ss f \ss \ss g2 g
    g\breve*1/8 \ss \ss a4 g2 g \resp
    g\breve*1/8 \ss \ss \ss \ss \ss \ss \ss f4 a2\fermata a\fermata
    \bar "|." \mark \markup "G"

    a4 c-> d4 c a c2 \resp % Ô nuit de vrai bonheur
    a\breve*1/8 \ss \ss \ss \ss \ss f4 g2 g \resp
    g\breve*1/8 \ss \ss f4 a2\fermata  
    \bar "|." \mark \markup "G"
}
  
  
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #LEFT }
  \lyricsto "melodie" {   
    Ô nuit de vrai bon -- heur
    qui seule mérita de con -- \aligne naître le temps et l’heu -- re
    où le Christ a surgi du séjour  des morts_!
    
    Voici la nuit dont il est é -- crit_:
    "“La" nuit resplendi -- ra com -- me le jour_;
    la nuit même est lu -- mière pour ma "joie.”"
    
    Car le pouvoir sanctifiant de cette nuit
    \aligne chasse les \aligne crimes et la -- ve les fau -- tes,
    rend l’innocence aux cou -- pables 
    et l’allégresse aux af -- fli -- gés.
    \aligne dissipe la hai -- ne,
    dispose à la con -- cor -- de et soumet toute puis -- san -- ce.
    
    Dans la grâce de cette nuit, \gauche accueille, Père très saint,
    en sacri -- fi -- ce du soir, 
    la flamme montant de cette colonne de ci -- re,
    \gauche œuvre des a -- beil -- les,
    que la sainte Église t’offre par nos mains.

    Mais déjà nous savons ce que proclame cette co -- lo -- nne 
    qui brûle avec é -- clat en l’hon -- neur de Dieu_:
    quand on en transmet la flam -- me, 
    sa clarté ne di -- mi -- nue pas.
    Car elle se nourrit de la cire pro -- duite par l’a -- beil -- le,
    comme par u -- ne mè -- re,
    pour former la substance de ce précieux lu -- mi -- nai -- re.

    Ô nuit de vrai bon -- heur,
    nuit où le ciel s’unit à la ter -- re,
    où l’homme rencon -- tre Dieu.
  }
>>