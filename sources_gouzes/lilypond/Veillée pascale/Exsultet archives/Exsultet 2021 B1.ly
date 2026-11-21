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
  \new Voice = "melodie" \relative c'' { 
    a4 c\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss \ss c2 %   Vraiment il est juste et bon
    c \breve*1/8 \ss \ss \ss d2 d4 c a c2 \resp
    c\breve*1/8 \ss \ss c2 
    c\breve*1/8 \ss a2 a\resp 
    a\breve*1/8 \ss g4 f g2 g\resp
    g\breve*1/8 \ss \ss f4 a2\fermata  \bar "|." \mark \markup "G"
    
    a4 c\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss c2\resp % C’est lui qui a remis pour nous au Père éter -- nel
    c\breve*1/8 \ss \ss \ss \ss \ss d2 c4 a \saut c2 \pause 
    a\breve*1/8 \ss \ss \ss \ss a2 g4 f g2 \resp 
    g\breve*1/8 \ss \ss \ss \ss \ss f4 a2\fermata
    \bar "|." \mark \markup "G"
    
    c\breve*1/8 \ss \ss a2 a \resp % Car voici la Pâ -- que
    c\breve*1/8 \ss \ss \ss \ss \ss \ss d2 c4 \saut a c2 c\resp %\mark \markup "G"
    a\breve*1/8 \ss \ss \ss g2 g g\breve*1/8 \ss \ss f4 a2\fermata  \bar "|." \mark \markup "G"
    
    a\breve*1/8 \ss c2 \saut % Voici la nuit où tu as ti -- ré d’Egypte
    c\breve*1/8 \ss \ss \ss \ss c2 c 
    c\breve*1/8 \ss \ss d2 c4 (a) c2 c\resp
    a\breve*1/8 \ss \ss \ss \ss \ss \ss g2 g4 f a2\fermata  
    \bar "|." \mark \markup "G"
    
    a\breve*1/8 \ss c2 \saut % Voici la nuit où le feu
    c\breve*1/8 \ss \ss \ss \ss d4 d c a c2 c \resp
    a\breve*1/8 \ss g2 g\breve*1/8 \ss \ss f4 a2\fermata  
    \bar "|." \mark \markup "G"
    
    a\breve*1/8 \ss c2 \saut % Voici la nuit qui arrache
    c\breve*1/8 \ss \ss \ss \ss c2
    c\breve*1/8 d2 c4 a c2\resp 
    c\breve*1/8 \ss \ss \ss \ss \ss \ss a2 \resp
    a\breve*1/8 \ss \ss g2 g4 f a2 \pause
    g\breve*1/8 \ss \ss \ss \ss f4 g2 g \resp
    g\breve*1/8 \ss \ss \ss \ss \ss f4 a2\fermata  
    \bar "|." \mark \markup "G"
    
    a\breve*1/8 \ss c2 \saut % Voici la nuit où le feu
    c\breve*1/8 \ss \ss \ss \ss \ss d2 c4 a c2 \resp
    a\breve*1/8 \ss \ss g2 
    g\breve*1/8 \ss f4 a2\fermata  
    \bar "|." \mark \markup "G"
    
    a4 c\breve*1/8 \ss \ss \ss a2 a % À quoi nous servirait-il
    c\breve*1/8 \ss \ss d4 c4 a c2 \pause
    c\breve*1/8 \ss \ss a2 a 
    a\breve*1/8 \ss \ss a2 g4 f a2 \pause
    g\breve*1/8 \ss \ss \ss f4 g2 \resp
    g\breve*1/8 \ss a \ss g2 g \resp
    g\breve*1/8 \ss \ss f4 a2\fermata  
    \bar "|." \mark \markup "G"
    
    c\breve*1/8 \ss \ss \ss \ss a2 %  Il fallait le péché
    c\breve*1/8 \ss \ss \ss d2 c4 a c2 \pause
    c\breve*1/8 \ss a4 g a2 a \resp 
    g\breve*1/8 \ss \ss \ss g2 g4 f4 a2\fermata  
    \bar "|." \mark \markup "G"
  }
 
  
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #LEFT }
  \lyricsto "melodie" {   
    Vrai -- ment il est juste et bon
    de chanter à pleine voix,
    dans tout l’élan du cœur et de l’es -- prit,
    le Père tout-puis -- sant, Dieu invi -- si -- ble,
    et son fils u -- ni -- que, 
    \aligne Jésus Christ, notre Sei -- gneur.
    
    C’est lui qui a remis pour nous au Père éter -- nel
    le prix de la dette encou -- rue par A -- dam_;
    c’est lui qui répandit son sang par a -- mour
    pour effacer la \gauche condamnation du premier pé -- ché.
    
    Car voici la Pâ -- que
    dans laquelle est mis à mort l’A -- gneau vé -- ri -- ta -- ble,
    dont le sang con -- sa -- cre les portes des cro -- yants.
    
    \aligne Voici la nuit où tu as tiré d’É -- gyp -- te
    les enfants d’Isra -- ël, nos Pè -- res,
    et leur as fait passer la mer \aligne rouge à pied sec.
    
    Voici la nuit où le feu d’une co -- lon -- ne lu -- mi -- neu -- se
    a dissi -- pé les ténèbres du pé -- ché.
    
    Voici la nuit qui arrache au monde corrom -- pu,  aveu -- glé par le mal, 
    ceux qui, aujourd’hui et dans tout l’uni -- vers, 
    ont mis leur foi dans le Christ_;
    nuit qui les rend à la grâ -- ce
    et leur ouvre la commu -- nion des saints.
    
    Voici la nuit où le Christ,
    bri -- sant les liens de la mort,
    s’est relevé, victo -- rieux, du séjour des morts.
    
    À quoi nous servirait-il de naî -- tre 
    sans le bonheur d’ê -- tre sau -- vé_?
    Ô merveilleuse condescen -- dan -- ce
    de ta ten -- dresse en -- vers nous_!
    \gauche Inestimable choix de ton a -- mour_:
    pour rache -- ter l’es -- cla -- ve, tu as livré le fils_!
    
    Il fallait le péché d’A -- dam,
    que la mort du Christ  a -- bo -- lit.
    Ô \aligne bienheu -- reu -- se fau -- te
    qui nous valut pa -- reil Ré -- demp -- teur_!
  }
>>