\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

aligne = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes\breve*1/8 \unHideNotes \allowBreak }
armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
saut = \allowBreak
pause = \bar "|"

ital = {%\override Lyrics.LyricText.font-shape = #'italic
  \override Lyrics.LyricText.font-series = #'bold
}
norm = {%\revert Lyrics.LyricText.font-shape
  \revert Lyrics.LyricText.font-series
}

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
    c''\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss \ss d2 c4 \saut 
    a c2 c \pause c\breve*1/8 \ss a2 a \resp a\breve*1/8 g4 f a2 \pause
    g\breve*1/8 \ss \ss \ss \ss \ss f4 g2 \resp 
    g\breve*1/8 \ss \ss f4 a2\fermata  \bar "|." \mark \markup "G"
    
    c\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss \ss \ss \ss d2 \saut 
    c4 a \saut c2 c \pause c\breve*1/8 \ss \ss \ss a2 g4 f a2 \resp 
    g\breve*1/8 \ss \ss \ss f4 a2\fermata
    \bar "|." \mark \markup "G"
    
    c\breve*1/8 \ss \ss \ss \ss \ss c2 c \resp 
    c\breve*1/8 \ss \ss \ss \ss d2 c4 \saut a c \pause \mark \markup "G"
    c\breve*1/8 \ss \ss \ss \ss \ss \ss \ss c2 c \resp 
    c\breve*1/8 \ss \ss \ss d2 c4 a c2 \resp 
    c\breve*1/8 \ss \ss \ss \ss \ss \ss a2 g4 f a2 \pause
    g\breve*1/8 \ss \ss \ss \ss \ss \ss \ss f4 g2 g \resp 
    g\breve*1/8 \ss \ss \ss \ss f4 a2\fermata  \bar "|." \mark \markup "G"
    
    a4 c2 \saut 
    c\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss \ss  d4 d c a c2 \pause 
    a\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss a2 \resp 
    a\breve*1/8 \ss \ss g4 f a2 \pause
    g\breve*1/8 \ss  f4 g2 \resp 
    g\breve*1/8 \ss \ss \ss \ss \ss \ss f4 a2\fermata  
    \bar "|." \mark \markup "G"
    
    c4 c2 \saut c\breve*1/8 \ss \ss \ss a4 c2 c \resp 
    c\breve*1/8 \ss \ss \ss \ss \ss \ss \ss \ss \ss 
    d2 d4 d c a c2 \pause 
    c\breve*1/8 \ss \ss \ss \ss \ss a2 
    \resp \mark \markup "G"
    c\breve*1/8 \ss \ss \ss d2 d4 d c2 c \resp 
    a\breve*1/8 \ss \ss \ss \ss \ss \ss g4 f a2 \pause 
    g\breve*1/8 \ss \ss f4 g2 g \resp
    g\breve*1/8 \ss \ss \ss a2 a4 a g2 g \resp 
    g\breve*1/8 \ss \ss f4 a2\fermata  \bar "|." \mark \markup "G"
    
    c\breve*1/8 \ss \ss \ss \ss a2 \resp 
    c\breve*1/8 \ss \ss c2 \resp 
    c\breve*1/8 \ss \ss d2 d4 c a c2 c \pause
    c\breve*1/8 \ss a2 a4 a a g f a2 \pause 
    g\breve*1/8 \ss \ss \ss \ss \ss \ss  f4 g2 \resp 
    g\breve*1/8 \ss \ss \ss \ss g2 \resp
    g\breve*1/8 \ss \ss \ss \ss \ss \ss \ss f4 a2\fermata a \fermata\bar "|." \mark \markup "G"
    
    c\breve*1/8 \ss \ss \ss \ss \ss d2 d4 d c a c2 \resp 
    c\breve*1/8 \ss \ss \ss a4 g f a2 \pause 
    g\breve*1/8 \ss \ss \ss \ss f4 g2 \resp 
    g\breve*1/8 \ss \ss \ss \ss \ss \ss \ss f4 a2\fermata\bar "|." \mark \markup "G"
    
    c\breve*1/8 \ss a2 a \resp 
    c\breve*1/8 \ss \ss d4 c a c2 c \resp 
    c\breve*1/8 \ss a2 
    a\breve*1/8 \ss \ss g4 f a2 a
    \pause \mark \markup "G"
    a\breve*1/8 \ss c2 
    c\breve*1/8 \ss d4 c a c2 \resp 
    a\breve*1/8 \ss \ss \ss g4 f a2 
    a\breve*1/8 \ss c4 a g a2 \resp
    g\breve*1/8 \ss \ss \ss g2 
    g\breve*1/8 \ss \ss f4 a2\fermata a\fermata\bar "|." 
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
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "melodie" {    
    Le Seigneur soit a -- vec vous_! 
    \aligne \ital Et avec votre es -- prit_! \norm
    Éle -- vons no -- tre cœur_! 
    \aligne\ital Nous le tour --  nons vers le Sei -- gneur_! \norm
    \aligne Rendons grâce au Seigneur no -- tre Dieu_! 
    \aligne\ital Cela est juste et bon_! \norm
    \aligne Vraiment, il est juste et bon de proclamer à pleine voix ta lou -- an -- ge,
    Dieu invi -- si -- ble, Père Tout_- Puis -- sant,
    et de chanter ton Fils Bien_- ai -- mé, 
    Jésus_- Christ, notre Sei -- gneur_!
    
    C’est lui qui a payé pour nous la dette encourue par A -- dam no -- tre
    Pè -- re,
    et qui a dé -- truit en son sang la condamnation de l’ancien
    pé -- ché.
    
    Car voici la fête de la Pâ -- que, 
    où l’Agneau véritable est im -- mo -- lé pour nous, 
    voici la Nuit où tu tiras de l’É -- gyp -- te
    nos pères, les en -- fants d’Is -- ra -- ël,  et leur as fait
    passer la Mer Rouge à pied sec, Nuit où le feu de la nuée lu -- mi -- neu -- se
    a repoussé les ténèbres du pé -- ché.
    
    Ô Nuit qui nous rend à la grâce et nous ouvre la com -- mu -- nion
    des saints, Nuit où le Christ, brisant les liens de la mort,
    s’est relevé victorieux des en -- fers_: 
    \aligne heureuse faute d’A -- dam qui nous a valu un tel ré -- demp -- teur_!
    
    Ô Nuit qui seule a pu con -- naî -- tre le temps et l’heure
    où le Christ est sorti vi -- vant du sé -- jour des morts,
    ô Nuit dont il est é -- crit_: 
    «_La nuit comme le jour il -- lu -- mi -- ne,
    la ténèbre autour de moi devient lumière pour ma joie_»,
    ô Nuit bien -- heu -- reu -- se, où se rejoignent le ciel
    et la ter -- re, où s’unissent l’homme et Dieu.
    
    Dans la grâce de cette Nuit, \aligne accueille, Père très saint
    le sacrivice du soir de cet -- te flam -- me que l’É -- gli -- se
    t’of -- fre par nos mains_; \aligne permets que ce cierge pascal consacré à
    ton Nom brûle sans déclin en cette Nuit et qu’il joinge sa
    clarté à celle des é -- toi -- les.
    
    Qu’il brûle encore quand se lève -- ra l’as -- tre du ma -- tin,
    celui qui ne connaît pas de cou -- chant_:  le Christ ressuscité 
    revenu des en -- fers, qui répand sur les hommes sa lumière et sa paix.
    
    Garde ton peu -- ple, nous t’en prions, ô no -- tre Pè -- re,
    dans la joie de ces fê -- tes pas -- ca -- les_;
    par Jésus_- Christ, ton Fils no -- tre Sei -- gneur,
    qui par la puissance de l’Es -- prit, s’est relevé d’en -- tre
    les morts et règne près de toi pour les siècles des siè -- cles.
    A -- men.
  }
>>