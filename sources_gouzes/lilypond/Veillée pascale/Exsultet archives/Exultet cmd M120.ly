\version "2.24.0"

\include "vowel-set.ly"
\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
saut = \allowBreak
pause = \bar "|"

ital = { \override Lyrics.LyricText.font-series = #'bold }
norm = { \revert Lyrics.LyricText.font-series }

Mus-Intro = \relative c'' { 
  a4 c^> c\breve*1/8 d2 c4 a 
  c2 c a4 a2 a\breve*1/8 g4 f a2 \resp a\breve*1/8 
  c4^> c a g a2 a \resp 
  c\breve*1/8  c4^> d c a c2\fermata
  
  a4 a a c2 d4 c a c2 c
  a\breve*1/8 g4 f a2 a \resp a\breve*1/8 c4 
  a g a2 \resp c\breve*1/8 d4 c a c2\fermata
  
  a4 a a c2 \saut c4 c^> d c a c2 c
  a\breve*1/8 g4 f a2 a\breve*1/8 
  c4^> c \saut c a g a2 \resp c\breve*1/8 d4 c a c2\fermata
  
  c\breve*1/8 c2 \resp c4 c d c a c2 c
  a\breve*1/8 g4 f a2
  a\breve*1/8 c2^> c \resp c4 c^> d c a c2\fermata\bar "|."
}
Texte-Intro = \lyricsto "melodie" {
  \mark \markup "C1" 
  Qu’e -- xul -- "te de joie dans le ciel la multi" -- tu -- de des an -- ges_!
  \bar "|" \mark \markup "C2"
  Chan -- tez, servi -- teurs de Dieu, 
  "et que retentisse la trom" -- pet -- te tri -- om -- pha -- le, 
  "pour la vic" -- toi -- re du grand Roi_!
  
  \bar "|." \mark \markup "C1"
  Ré -- jou -- is_- toi,  ô no -- tre ter -- re,
  \bar "|" \mark \markup "C2"
  "resplendissante d’une lumière" \saut é -- cla -- tan -- te,
  "car il t’a prise" en sa clar -- té 
  "et son règne a dis" -- si -- pé ta nuit_!
  
  \bar "|." \mark \markup "C1"
  Ré -- jou -- is_- toi, É -- gli -- se no -- tre Mè -- re,
  \bar "|" \mark \markup "C2"
  "toute remplie de" sa splen -- deur, \bar "|" 
  "et que ré" -- son -- ne l’ac --
  cla -- ma -- tion "du peuple" des fils de Dieu_!
  
  \bar "|." \mark \markup "C1"
  "Unissez, frères bien-ai" -- més, vo -- tre voix à la mien -- ne,
  \bar "|" \mark \markup "C2"
  "pour que je chante en" vo -- tre nom
  \bar "|" \mark \markup "C1"
  "la merveilleuse lu" -- miè -- re du Christ res -- sus -- ci -- té_!
}

Mus-dial = \relative c' { 
  f\breve*1/8 e4 d f2 \bar "||" 
    <<    
      <<
        { \voiceOne a\breve*1/8^\markup\italic"vif" bes4 bes a2 } 
        \new Voice { \voiceTwo f\breve*1/8 e4 e f2 }
      >>
      \new Staff \with {\remove Time_signature_engraver }
      << \clef "bass" \key f \major \cadenzaOn
         { \voiceOne c\breve*1/8 c4 c c2 } 
         \new Voice  { \voiceTwo f,\breve*1/8 c4 c f2 }
      >>
    >>     \bar "|." \break
    f'\breve*1/8 g2 g4 g f2 \bar "||" 
    <<    
      <<
        { \voiceOne a\breve*1/8^\markup\italic"vif" bes a2 } 
        \new Voice { \voiceTwo f\breve*1/8 e f2 }
      >>
      \new Staff \with {\remove Time_signature_engraver }
      << \clef "bass" \key f \major \cadenzaOn
         { \voiceOne c\breve*1/8 c c2 } 
         \new Voice  { \voiceTwo f,\breve*1/8 c f2 }
      >>
    >>     \bar "|." \break
    f'\breve*1/8 e4 d f2 \bar "||" 
    <<    
      <<
        { \voiceOne a\breve*1/8^\markup\italic"vif" bes4 bes a2 } 
        \new Voice { \voiceTwo f\breve*1/8 f4 e f2 }
      >>
      \new Staff \with {\remove Time_signature_engraver }
      << \clef "bass" \key f \major \cadenzaOn
         { \voiceOne c\breve*1/8 d4 c c2 } 
         \new Voice  { \voiceTwo f,\breve*1/8 bes,4 c f2 }
      >>
    >>     \bar "|."
}
Texte-dial = \lyricsto "melodie" {    
  "Le Seigneur soit" a -- vec vous_! 
  \ital "Et avec" votre es -- prit_! \norm
  Éle -- vons no -- tre cœur_! 
  \ital" Nous le tour" --  "nons vers le Sei" -- gneur_! \norm
  "Rendons grâce au Seigneur" no -- tre Dieu_! 
  \ital "Cela est" juste et bon_!
}

Mus-corps = \relative c'' { 
  c\breve*1/8 d2 c4 \saut 
  a c2 c \pause c\breve*1/8 a2 a \resp a\breve*1/8 g4 f a2 \pause
  g\breve*1/8 f4 g2 \resp 
  g\breve*1/8 f4 a2\fermata  \bar "|." \mark \markup "G"
  
  c\breve*1/8 d2 \saut 
  c4 a \saut c2 c \pause c\breve*1/8 a2 g4 f a2 \resp 
  g\breve*1/8 f4 a2\fermata
  \bar "|." \mark \markup "G"
  
  c\breve*1/8 c2 c \resp 
  c\breve*1/8 d4 d c4 \saut a c \pause \mark \markup "G"
  c\breve*1/8 c2 c \resp 
  c\breve*1/8 d2 c4 a c2 \resp 
  c\breve*1/8 a2 g4 f a2 \pause
  g\breve*1/8 f4 g2 g \resp 
  g\breve*1/8 f4 a2\fermata  \bar "|." \mark \markup "G"
  
  a4 c2 \saut 
  c\breve*1/8  d4 d c a c2 \pause 
  a\breve*1/8 a2 \resp 
  a\breve*1/8 g4 f a2 \pause
  g\breve*1/8  f4 g2 \resp 
  g\breve*1/8 f4 a2\fermata  
  \bar "|." \mark \markup "G"
  
  c4 c2 \saut c\breve*1/8 a4 c2 c \resp 
  c\breve*1/8 
  d2 \saut d4 d c a c2 \pause 
  c\breve*1/8 a2 
  \resp \mark \markup "G"
  c\breve*1/8 d2 d4 d c2 c \resp 
  a\breve*1/8 g4 f a2 \pause 
  g\breve*1/8 f4 g2 g \resp
  g\breve*1/8 a2 a4 a g2 g \resp 
  g\breve*1/8 f4 a2\fermata  \bar "|." \mark \markup "G"
  
  c\breve*1/8 a2 \resp 
  c\breve*1/8 c2 \resp 
  c\breve*1/8 d2 d4 c a c2 c \resp
  c\breve*1/8 a2 a4 a a g f a2 \pause 
  g\breve*1/8 a4 g2 \saut
  g\breve*1/8 f4 g2 \resp
  g\breve*1/8 f4 a2\fermata a \fermata\bar "|." \mark \markup "G"
  
  c\breve*1/8 d2 \saut d4 d c a c2 \resp 
  c\breve*1/8 a4 g f a2 \pause 
  g\breve*1/8 f4 g2 \resp 
  g\breve*1/8 f4 a2\fermata\bar "|." \mark \markup "G"
  
  c\breve*1/8 a2 a \resp 
  c\breve*1/8 d4 c a c2 c \resp 
  c\breve*1/8 a2 \saut
  a\breve*1/8 g4 f a2 a
  \pause \mark \markup "G"
  a\breve*1/8 c2 \saut
  c\breve*1/8 d4 c a c2 \resp 
  a\breve*1/8 g4 f a2 \saut
  a\breve*1/8 c4 a g a2 \resp
  g\breve*1/8 g2 \saut
  g\breve*1/8 f4 a2\fermata a\fermata\bar "|." 
  %\mark \markup "G*"
  <<    
    <<
      { \voiceOne a2 a2 } 
      \new Voice { \voiceTwo f2 f2 }
    >>
    \new Staff \with {\remove Time_signature_engraver }
    << \clef "bass" \key f \major \cadenzaOn
       { \voiceOne c2 c2 } 
       \new Voice  { \voiceTwo f,2 f2 }
    >>
  >>     \bar "|." 
}

Texte-corps = \lyricsto "melodie" {    
  "Vraiment, il est juste et bon de proclamer à pleine" voix ta lou -- an -- ge,
  "Dieu invi" -- si -- ble, Père Tout_- Puis -- sant,
  "et de chanter ton Fils Bien -" ai -- mé, 
  "Jésus-Christ, notre" Sei -- gneur_!
  
  "C’est lui qui a payé pour nous la dette encourue par A" -- dam no -- tre
  Pè -- re,
  "et qui a dé" -- truit en son sang "la condamnation de l’ancien"
  pé -- ché.
  
  "Car voici la fête de la" Pâ -- que, 
  "où l’Agneau véritable est" im -- mo -- lé pour nous, 
  "voici la Nuit où tu tiras de l’É" -- gyp -- te
  "nos pères, les en" -- fants d’Is -- ra -- ël,  
  "et leur as fait passer la Mer" Rouge à pied sec, 
  "Nuit où le feu de la nuée lu" -- mi -- neu -- se
  "a repoussé les ténèbres du" pé -- ché.
  
  Ô Nuit "qui nous rend à la grâce et nous ouvre la" com -- mu -- nion
  des saints, 
  "Nuit où le Christ, brisant les liens de la" mort,
  "s’est relevé victorieux" des en -- fers_: 
  "heureuse faute" d’A -- dam "qui nous a valu un tel ré" -- demp -- teur_!
  
  Ô Nuit "qui seule a pu" con -- naî -- tre 
  "le temps et l’heure où le Christ est sorti vi" -- vant du sé -- jour des morts,
  "ô Nuit dont il est é" -- "crit : «"
  "La nuit comme le" jour il -- lu -- mi -- ne,
  "la ténèbre autour de moi devient lumière" pour ma joie_»,
  "ô Nuit bien" -- heu -- reu -- se, "où se rejoignent le" ciel
  et la ter -- re, "où s’unissent l’homme" et Dieu.
  
  "Dans la grâce de cette" Nuit, "accueille, Père très" saint
  "le sacrifice du" soir de cet -- te flam -- me 
  "que l’É" -- gli -- se
  t’of -- fre par nos mains_; 
  "permets que ce cierge pascal consacré à"
  ton Nom "brûle sans déclin en cet" -- te Nuit 
  "et qu’il joinge sa clarté à celle des" é -- toi -- les.
  
  "Qu’il brûle encore quand se lève" -- ra l’as -- tre du ma -- tin,
  "celui qui ne connaît" pas de cou -- chant_:  
  "le Christ ressuscité revenu des" en -- fers, "qui répand sur les hommes sa lumière et" sa paix.
  
  "Garde ton" peu -- ple, "nous t’en prions," ô no -- tre Pè -- re,
  "dans la" joie "de ces fê" -- tes pas -- ca -- les_;
  "par Jésus -" Christ, "ton Fils" no -- tre Sei -- gneur,
  "qui par la puissance" de l’Es -- prit, "s’est relevé" d’en -- tre
  les morts "et règne près de" toi "pour les siècles" des siè -- cles.
  A -- men.
}

% \new Staff \with {\remove Time_signature_engraver }
% << 
%   \cadenzaOn \key f \major
%   \new Voice = "melodie" \Mus-corps
%   \new Lyrics 
%   %\with {\override VerticalAxisGroup.nonstaff-relatedstaff-spacing = #'((basic-distance . 7)) }
%   \Texte-corps
% >>