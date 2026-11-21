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
  \new Voice = "melodie" \relative c'' { 
    a4 a c\breve*1/8 \ss \ss c2 c\breve*1/8 d2 c4 a c2 c %    Exultez dans le ciel, multitudes des anges!
    a\breve*1/8 a4 \resp a\breve*1/8 \ss \ss g4 f a2 \resp  %Exultez, célébrez les mystères divins!
    a4 a2 a4 a c4^> c a g a2 \resp %Résonne, trompette du salut,
    c\breve*1/8  \ss \ss c4^> c d c a c2\fermata%pour la victoire d’un si grand Roi!
   
    a4 a c\breve*1/8 \ss \ss  d4 c a c2 c % Que la terre, elle aussi, soit heureuse,
    a\breve*1/8 \ss g4 f a2 \pause % irradiée de tant de feux:
    a\breve*1/8 \ss \ss \ss \ss c2 a4 g a2 \resp 
    c\breve*1/8 \ss \ss \ss \ss c2
    c\breve*1/8 \ss d4 c a c2\fermata 
    
    a4 a a c2 \saut c4 c^> d c a c2 c % Réjouis-toi, Église notre mère,
    a\breve*1/8 \ss \ss \ss g4 f a2 a \pause % parée d’une lumière si éclatante!
    a\breve*1/8 \ss \ss c2^> c4 c a g a2 \resp 
    c\breve*1/8 d4 c a c2\fermata c\fermata
    
    c\breve*1/8 \ss \ss \ss \ss \ss \ss c2 \resp 
    c\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss \ss a2 a\resp 
    c\breve*1/8 \ss \ss \ss \ss c2 \resp 
    c\breve*1/8 \ss \ss d2 c4 a c2
    a\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss g4 f a2  a\pause %
    a\breve*1/8 \ss \ss \ss c4 c a g a2 a \resp
    c\breve*1/8 \ss \ss \ss \ss c2 
    c\breve*1/8 \ss \ss d2 c4 a c2\fermata\bar "|." \mark \markup "C1"
  }

  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "melodie" {
    \mark \markup "C1" 
    Ex -- ul -- tez dans le ciel, \aligne multi -- tu -- des des an -- ges_!
    \bar "|" \mark \markup "C2"
    Exul -- tez, \aligne célébrez les mystè -- res di -- vins_!
    Ré -- son -- ne, trom -- pet -- te du sa -- lut,
    pour la vic -- toi -- re d’un si grand Roi_!
    
    \bar "|." \mark \markup "C1"
    Que la terre, elle aus -- si, soit heu -- reu -- se,
    \bar "|" \mark \markup "C2"
    \gauche irradiée de tant de feux_:
    \gauche illuminée de la splendeur du Roi é -- ter -- nel,
    qu’elle voie s’en aller l’obscuri -- té
    qui recouvrait le monde en -- tier_!

    \bar "|." \mark \markup "C1"
    Ré -- jou -- is- toi, É -- gli -- se no -- tre Mè -- re,
    \bar "|" \mark \markup "C2"
    \aligne parée d’une lumière si é -- cla -- tan -- te!
    Que re -- ten -- tis -- se dans ce lieu saint
    \aligne l’acclamation de tous les peu -- ples_!
    
    \bar "|." \mark \markup "C1"
    Et vous, mes frères et sœurs bien-ai -- més,
    qui vous tenez ici dans l’admirable clarté de cette lumière sain -- te,
    \gauche invoquez avec moi, je vous prie,
    la miséricorde de Dieu tout- puis -- sant.
    \bar "|" \mark \markup "C2"
    Il m’a choisi dans mon indignité pour être à son ser -- vi -- ce_:
    Qu’il répande la clar -- té de sa lu -- miè -- re
    pour que je puisse chan -- ter la louange du cier -- ge pas -- cal. 
  }
>>