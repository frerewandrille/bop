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
    a'4 c\breve*1/8 \ss \ss \ss \ss a2 \resp % Aussi nous t’en prions
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