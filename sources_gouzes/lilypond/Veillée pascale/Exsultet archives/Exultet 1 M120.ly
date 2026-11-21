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
  \new Voice = "melodie" \relative c'' { 
    a4 c^> c\breve*1/8 \ss \ss \ss \ss \ss \ss \ss d2 c4 a 
    c2 c a4 a2 a\breve*1/8 g4 f a2 \resp a\breve*1/8 \ss \ss \ss \ss 
    c4^> c a g a2 a \resp 
    c\breve*1/8  \ss \ss c4^> d c a c2\fermata
    
    a4 a a c2 d4 c a c2 c
    a\breve*1/8 \ss \ss g4 f a2 a \resp a\breve*1/8 \ss \ss \ss c4 
    a g a2 \resp c\breve*1/8 \ss \ss \ss \ss d4 c a c2\fermata
    
    a4 a a c2 \saut c4 c^> d c a c2 c
    a\breve*1/8 \ss \ss g4 f a2 a\breve*1/8 \ss \ss 
    c4^> c \saut c a g a2 \resp c\breve*1/8 \ss d4 c a c2\fermata
    
    c\breve*1/8 \ss \ss c2 \resp c4 c d c a c2 c
    a\breve*1/8 \ss \ss \ss \ss g4 f a2
    a\breve*1/8 \ss \ss c2^> c \resp c4 c^> d c a c2\fermata\bar "|."
  }
  \new Lyrics %\with {
  %    \override VerticalAxisGroup.nonstaff-relatedstaff-spacing = #'((basic-distance . 7))
  %  }
  \lyricsto "melodie" {
    \mark \markup "C1" 
    Qu’e -- xul -- te de joie dans le ciel la multi -- tu -- de des an -- ges_!
    \bar "|" \mark \markup "C2"
    Chan -- tez, \aligne servi -- teurs de Dieu, 
    et que retentisse la trom -- pet -- te tri -- om -- pha -- le, 
    pour la vic -- toi -- re du grand Roi_!
    
    \bar "|." \mark \markup "C1"
    Ré -- jou -- is_- toi,  ô no -- tre ter -- re,
    \bar "|" \mark \markup "C2"
    \aligne resplendissante d’une lumière \saut é -- cla -- tan -- te,
    car il t’a prise en sa clar -- té 
    et son règne a dis -- si -- pé ta nuit_!
    
    \bar "|." \mark \markup "C1"
    Ré -- jou -- is_- toi, É -- gli -- se no -- tre Mè -- re,
    \bar "|" \mark \markup "C2"
    toute remplie de sa splen -- deur, \bar "|" 
    et que ré -- son -- ne l’ac --
    cla -- ma -- tion du peuple des fils de Dieu_!
    
    \bar "|." \mark \markup "C1"
    \aligne Unissez, frères bien-ai -- més, vo -- tre voix à la mien -- ne,
    \bar "|" \mark \markup "C2"
    pour que je chante en vo -- tre nom
    \bar "|" \mark \markup "C1"
    la merveilleuse lu -- miè -- re du Christ res -- sus -- ci -- té_!
    
    c\breve*1/8 a2 \resp c\breve*1/8 c2 \resp c\breve*1/8 d2 d4 c a c2 c \pause
    c\breve*1/8 a2 a4 a a g f a2 \pause g\breve*1/8 f4 g2 \resp g\breve*1/8 g2 \resp
    g\breve*1/8 f4 a2\fermata a
  }
>>