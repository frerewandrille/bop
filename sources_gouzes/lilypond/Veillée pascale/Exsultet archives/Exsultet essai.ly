\version "2.24.0"

\include "vowel-set-calc.ly"
\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

ss = { \hideNotes bes\breve*1/8 \unHideNotes \allowBreak }
armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
saut = \allowBreak
pause = \bar "|"
inv = \once \hideNotes
aligne = \once \override LyricText.X-offset = #center-on-vowel
gauche = \once \override LyricText.self-alignment-X = #LEFT

ital = { \override Lyrics.LyricText.font-series = #'bold }
norm = { \revert Lyrics.LyricText.font-series }

mus = \relative c'' {
  

}

musBIII = \relative c'' {
  c\breve*6/64\allowBreak\inv a4*4/8\allowBreak\inv a4*5/8\allowBreak\inv a4*5/8\allowBreak\inv a4*1/8a2*6/8\breathe\allowBreak
  c\breve*8/64\allowBreak\inv a4*3/8\allowBreak\inv a4*3/8\allowBreak\inv a4*5/8\allowBreak\inv a4*8/8\allowBreak\inv a4*4/8\allowBreak\inv a4*1/8d2*3/8\allowBreakc4*3/8\allowBreaka4*4/8\allowBreakc2*5/8\breathe\allowBreak
  c\breve*5/64\allowBreak\inv a4*4/8\allowBreak\inv a4*1/8a2*4/8\allowBreaka\breve*4/64\allowBreak\inv a4*7/8\allowBreak\inv a4*3/8\allowBreak\inv a4*8/8\allowBreak\inv a4*3/8\allowBreakg4*1/8f4*3/8\allowBreaka2*5/8\breathe\allowBreak
  g\breve*3/64\allowBreak\inv a4*3/8\allowBreak\inv a4*4/8\allowBreak\inv a4*4/8\allowBreak\inv a4*6/8\allowBreak\inv a4*1/8f4*1/8g2*1/8g2*2/8\breathe\allowBreak
  g\breve*2/64\allowBreak\inv a4*5/8\allowBreak\inv a4*3/8\allowBreak\inv a4*4/8\allowBreak\inv a4*2/8\allowBreak\inv a4*4/8\allowBreak\inv a4*2/8\allowBreakf4*1/8a2*1/8\fermata a2*2/8\fermata  
  \bar "|." \mark \markup "G"

   c\breve*5/64\allowBreak\inv a4*3/8\allowBreak\inv a4*8/8\allowBreak\inv a4*4/8\allowBreak\inv a4*2/8\allowBreak\inv a4*7/8\allowBreakd\breve*4/64\allowBreakc4*3/8\allowBreaka4*1/8c2*3/8\breathe\allowBreak
  c\breve*2/64\allowBreak\inv a4*6/8\allowBreak\inv a4*3/8\allowBreak\inv a4*1/8a2*3/8\allowBreaka\breve*3/64\allowBreak\inv a4*2/8\allowBreak\inv a4*7/8\allowBreak\inv a4*3/8\allowBreakg4*3/8\allowBreakf4*1/8a2*4/8\breathe\allowBreak
  a4*4/8\allowBreakc\breve*5/64\allowBreak\inv a4*3/8\allowBreak\inv a4*3/8\allowBreak\inv a4*1/8d2*2/8\allowBreakd4*2/8\allowBreakd4*1/8c4*3/8\allowBreaka4*4/8\allowBreakc2*4/8\breathe\allowBreak
  c\breve*3/64\allowBreak\inv a4*6/8\allowBreak\inv a4*2/8\allowBreak\inv a4*2/8\allowBreak\inv a4*5/8\allowBreak\inv a4*1/8a2*3/8\allowBreaka\breve*2/64\allowBreak\inv a4*4/8\allowBreakg4*2/8\allowBreakf4*3/8\allowBreaka2*4/8\breathe\allowBreak
  g\breve*3/64\allowBreak\inv a4*3/8\allowBreak\inv a4*2/8\allowBreak\inv a4*2/8\allowBreak\inv a4*6/8\allowBreak\inv a4*3/8\allowBreak\inv a4*3/8\allowBreak\inv a4*6/8\allowBreakf4*3/8\allowBreaka2*1/8\fermata a2*2/8\fermata
}


text = \lyricmode {
  Qu’il brûle encore quand se lèvera l’astre du ma -- tin,
  cet astre sans pa -- reil qui ne connaît pas de cou -- chant,
  le Christ, ton fils, reve -- nu du sé -- jour des morts
  qui répand sur le genre hu -- main sa lumière et sa paix,
  lui qui vit et règne pour les siècles des siè -- cles. A -- men
}





textBIII = \lyricmode {
  Aussi nous t’en prions, Sei -- gneur_:
  permets que ce cierge consacré en l’hon -- neur de ton nom
  brûle sans déc -- lin 
  pour dissiper les ténèbres de cet -- te nuit.
  Qu’il te soit d’un parfum a -- gré -- a -- ble
  et joigne sa clarté à celle des é -- toi -- les.

  Qu’il brûle encore quand se lèvera l’astre du ma -- tin,
  cet astre sans pa -- reil qui ne connaît pas de cou -- chant,
  le Christ, ton fils, reve -- nu du sé -- jour des morts
  qui répand sur le genre hu -- main sa lumière et sa paix,
  lui qui vit et règne pour les siècles des siè -- cles. A -- men
}

\new Staff \with {\remove Time_signature_engraver }
<< 
  \cadenzaOn \key f \major
  \new Voice = "melodie" {
    \mus%\break\musBII\break\musBIII
  }

  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "melodie" {
    \text%\textBII\textBIII
  }
>>