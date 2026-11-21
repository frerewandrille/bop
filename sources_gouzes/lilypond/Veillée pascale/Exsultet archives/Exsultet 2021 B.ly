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
    f\breve*1/8 \ss \ss e,4 d f2 \bar "||" 
    <<    
      <<
        { \voiceOne a\breve*1/8^\markup\italic"vif" \ss bes4 bes a2 } 
        \new Voice { \voiceTwo f\breve*1/8 s e4 e f2 }
      >>
      \new Staff \with {\remove Time_signature_engraver }
      << \clef "bass" \key f \major \cadenzaOn
         { \voiceOne c\breve*1/8 s c4 c c2 } 
         \new Voice  { \voiceTwo f,\breve*1/8 s c4 c f2 }
      >>
    >>     \bar "|." \break
    f'\breve*1/8 g2 g4 g f2 \bar "||" 
    <<    
      <<
        { \voiceOne a\breve*1/8^\markup\italic"vif" \ss \ss bes \ss \ss \ss a2 } 
        \new Voice { \voiceTwo f\breve*1/8 s s e s s s f2 }
      >>
      \new Staff \with {\remove Time_signature_engraver }
      << \clef "bass" \key f \major \cadenzaOn
         { \voiceOne c\breve*1/8 s s c s s s c2 } 
         \new Voice  { \voiceTwo f,\breve*1/8 s s c s s s f2 }
      >>
    >>     \bar "|." \break
    f'\breve*1/8 \ss \ss \ss e,4 d f2 \bar "||" 
    <<    
      <<
        { \voiceOne a\breve*1/8^\markup\italic"vif" \ss bes4 bes a2 } 
        \new Voice { \voiceTwo f\breve*1/8 s f4 e f2 }
      >>
      \new Staff \with {\remove Time_signature_engraver }
      << \clef "bass" \key f \major \cadenzaOn
         { \voiceOne c\breve*1/8 s d4 c c2 } 
         \new Voice  { \voiceTwo f,\breve*1/8 s bes,4 c f2 }
      >>
    >>     \bar "|." \break
    
    a'4 c\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss \ss c2 %   Vraiment il est juste et bon
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
    
    a4 c-> d4 c a c2 \resp % Ô nuit de vrai bonheur
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

    a4 c\breve*1/8 \ss \ss \ss \ss a2 \resp % Aussi nous t’en prions
    c\breve*1/8 \ss \ss \ss \ss \ss \ss d4 c4 a c2 \resp
    c\breve*1/8 \ss \ss a2 
    a\breve*1/8 \ss \ss \ss \ss g4 f4 g2 \pause
    g\breve*1/8 \ss \ss \ss \ss a \ss g2 g\resp
    g\breve*1/8 \ss \ss \ss \ss \ss \ss f4 a2\fermata  a\fermata  
    \bar "|." \mark \markup "G"

    a4 c\breve*1/8 \ss \ss \ss \ss d c4 a c2 \resp % Qu’il brûle encore
    a\breve*1/8 \ss \ss \ss \ss \ss \ss \ss g4 f4 g2 \pause
    a4 c\breve*1/8 \ss \ss \ss d2 d4 d c4 a c2 \resp 
    a\breve*1/8 \ss \ss \ss \ss \ss a2 
    a\breve*1/8 \ss f \ss \ss g2\resp  
    g\breve*1/8 \ss \ss \ss \ss \ss \ss \ss f4 a2\fermata  a\fermata  
    \bar "|" %\mark \markup "G*"
    <<    
      <<
        { \voiceOne a2\fermata a2\fermata } 
        \new Voice { \voiceTwo f2 f2 }
      >>
      \new Staff \with {\remove Time_signature_engraver }
      << \clef "bass" \key f \major \cadenzaOn
         { \voiceOne c2 c2 } 
         \new Voice  { \voiceTwo f,2\fermata f2\fermata }
      >>
    >>     
    \bar "|."  
  }
  
  
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #LEFT }
  \lyricsto "melodie" {   
    Le Sei -- gneur soit avec vous.
    Et avec votre Es -- prit.

    Éle -- vons no -- tre cœur.
    Nous le tour -- nons vers le Sei -- gneur

    \aligne Rendons grâce au Sei -- gneur notre Dieu.
    Cela est juste et bon.

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

    Aus -- si nous t’en prions, Sei -- gneur_:
    permets que ce cierge consacré en l’hon -- neur de ton nom
    brûle sans déc -- lin 
    pour dissiper les ténèbres de cet -- te nuit.
    Qu’il te soit d’un par -- fum agré -- a -- ble
    et joigne sa clarté à celle des é -- toi -- les.

    Qu’il brûle encore quand se lèvera \aligne l’astre du ma -- tin,
    cet astre sans pareil qui ne connaît pas de cou -- chant,
    le Christ, ton fils, reve -- nu du sé -- jour des morts
    qui répand sur le genre hu -- main sa lumi -- ère et sa paix,
    lui qui vit et règne pour les siècles des siè -- cles. A -- men
  }
>>