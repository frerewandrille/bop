\version "2.24.1"
\include "vowel-set.ly"

ss = { \hideNotes bes\breve*1/8 \unHideNotes \allowBreak  }
armure = { \key f \major \time 3/4 }
resp = { \breathe\allowBreak  }

Clefs = { \override Score.BreakAlignment.break-align-orders =
          #(make-vector 3 '(left-edge
                            cue-end-clef
                            ambitus
                            breathing-sign
                            staff-bar
                            time-signature
                            clef
                            cue-clef
                            key-cancellation
                            key-signature
                            custos))
          \override Staff.Clef.full-size-change = ##t
}

silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
saut = \allowBreak 
pause = \bar "|"
inv = \once \hideNotes
\defineBarLine "|" #'("|" "" "")
\defineBarLine "|." #'("|." "" "")

ital = { \override Lyrics.LyricText.font-series = #'bold }
norm = { \revert Lyrics.LyricText.font-series }

Mus-Intro = \relative c'' {
  a4 a c\breve*1/8 c2 \saut c\breve*1/8 d2 c4 a c2 c %    Exultez dans le ciel, multitudes des anges!
  a\breve*1/8 a4 \resp 
  a\breve*1/8 g4 f a2 \resp  %Exultez, célébrez les mystères divins!
  a4 a2 a4 \saut a c4^> c a g a2 \resp %Résonne, trompette du salut,
  c\breve*1/8 c2 c4 \saut d c a c2\fermata%pour la victoire d’un si grand Roi!
  
  a4 a c\breve*1/8 d2 \saut c4 a c2 c % Que la terre, elle aussi, soit heureuse,
  a\breve*1/8 g4 f a2 \pause % irradiée de tant de feux:
  a\breve*1/8 c2 \saut a4 g a2 \resp 
  c\breve*1/8 c2 \saut
  c\breve*1/8 d c4 a c2\fermata 
  
  a4 a a c2 \saut c4 d^> d c a c2 c % Réjouis-toi, Église notre mère,
  a\breve*1/8 g4 f a2 a \pause % parée d’une lumière si éclatante!
  a\breve*1/8 c2^> c4 c a g a2 \resp 
  c\breve*1/8 d \saut c4 a c2\fermata c\fermata
  
  c\breve*2/64\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*1/8c2*3/8\breathe\allowBreak 
  c\breve*2/64\allowBreak \inv a4*2/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*8/8\allowBreak \inv a4*3/8\allowBreak \inv a4*2/8\allowBreak \inv a4*3/8\allowBreak \inv a4*6/8\allowBreak a2*4/8 a\breathe\allowBreak 
  c\breve*6/64\allowBreak \inv a4*4/8\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak \inv a4*3/8\allowBreak c2*2/8\allowBreak 
  c\breve*2/64\allowBreak \inv a4*7/8\allowBreak \inv a4*2/8\allowBreak d2*3/8\allowBreak c4*1/8\allowBreak a4*1/8c2*2/8
  a\breve*2/64\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*2/8\allowBreak \inv a4*7/8\allowBreak \inv a4*2/8\allowBreak \inv a4*3/8\allowBreak \inv a4*2/8\allowBreak g4*2/8\allowBreak f4*1/8a2 a\breathe\allowBreak 
  a\breve*1/8 c4 c a g a2 a\resp
  c\breve*1/8 c2 
  c\breve*1/8 d2 c4 a c2\fermata\bar "|." \mark \markup "C1"
}

Mus-dial = \relative c' {
  f\breve*1/8 e4 d f2 \bar ".|" 
  <<    
    <<
      { \Clefs \voiceOne \clef "treble" \armure a\breve*1/8^\markup\italic"vif" bes4 bes a2 } 
      \new Voice { \voiceTwo f\breve*1/8 e4 e f2 }
    >>
    \new Staff \with {\remove Time_signature_engraver }
    << \Clefs\clef "bass" \key f \major \cadenzaOn
       { \voiceOne c\breve*1/8 c4 c c2 } 
       \new Voice  { \voiceTwo f,\breve*1/8 c4 c f2 }
    >>
  >>     \bar "|" \break
  f'\breve*1/8 g2 g4 g f2 \bar ".|" 
  <<    
    <<
      { \Clefs \voiceOne \set Staff.forceClef = ##t \clef "treble" \armure a\breve*1/8^\markup\italic"vif" bes a2 } 
      \new Voice { \voiceTwo f\breve*1/8 e f2 }
    >>
    \new Staff \with {\remove Time_signature_engraver }
    << \Clefs\clef "bass" \key f \major \cadenzaOn
       { \voiceOne c\breve*1/8 c c2 } 
       \new Voice  { \voiceTwo f,\breve*1/8 c f2 }
    >>
  >>     \bar "|" \break
  f'\breve*1/8 e4 d f2 \bar ".|" 
  <<    
    <<
      { \Clefs \voiceOne \set Staff.forceClef = ##t \clef "treble" \armure a\breve*1/8^\markup\italic"vif" bes4 bes a2 } 
      \new Voice { \voiceTwo f\breve*1/8 f4 e f2 }
    >>
    \new Staff \with {\remove Time_signature_engraver }
    << \Clefs\clef "bass" \key f \major \cadenzaOn
       { \voiceOne c\breve*1/8 d4 c c2 } 
       \new Voice  { \voiceTwo f,\breve*1/8 bes,4 c f2 }
    >>
  >>     \bar "|" \break
}

musBI = \relative c'' {
  a4*1/8c\breve*2/64\allowBreak \inv a4*1/8\allowBreak \inv a4*2/8\allowBreak \inv a4*3/8\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak \inv a4*1/8d\breve*1/64\allowBreak \inv a4*1/8\allowBreak c4*1/8a4*2/8\allowBreak c2*2/8\breathe\allowBreak 
  c\breve*2/64\allowBreak \inv a4*3/8\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak a\breve*2/64\allowBreak \inv a4*1/8\allowBreak g4*2/8\allowBreak f4*1/8a2*2/8\breathe
  \allowBreak g\breve*2/64\allowBreak \inv a4*3/8\allowBreak \inv a4*8/8\allowBreak \inv a4*2/8\allowBreak \inv a4*1/8\allowBreak f4*1/8g2*1/8 g\breathe
  g\breve*1/64\allowBreak \inv a4*2/8\allowBreak \inv a4*1/8\allowBreak \inv a4*5/8\allowBreak \inv a4*4/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak f4*1/8a2*2/8
  \fermata \bar "|." \mark \markup "G"
 
  c\breve*3/64\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak \inv a4*4/8\allowBreak \inv a4*3/8\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak d4*2/8\allowBreak c4*1/8a4*1/8c2*2/8\breathe\allowBreak 
  c\breve*2/64\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak a\breve*3/64\allowBreak \inv a4*6/8\allowBreak g4*2/8\allowBreak f4*1/8a2*4/8\breathe\allowBreak 
  g\breve*3/64\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak \inv a4*5/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*2/8\allowBreak f4*1/8g2*3/8\breathe\allowBreak 
  g\breve*2/64\allowBreak \inv a4*4/8\allowBreak \inv a4*2/8\allowBreak \inv a4*8/8\allowBreak \inv a4*3/8\allowBreak \inv a4*4/8\allowBreak f4*1/8a2*2/8
  \fermata \bar "|." \mark \markup "G"
 
  a\breve*3/64\allowBreak \inv a4*1/8c2*2/8\allowBreak  c4*2/8\allowBreak d\breve*4/64\allowBreak c4*2/8\allowBreak a4*3/8\allowBreak c2*3/8 c\breathe\allowBreak 
  c\breve*4/64\allowBreak \inv a4*8/8\allowBreak \inv a4*3/8\allowBreak \inv a4*2/8\allowBreak \inv a4*3/8\allowBreak a2*6/8\allowBreak a\breve*6/64\allowBreak g4*1/8f4*1/8a2*3/8 a\breathe\allowBreak 
  g\breve*3/64\allowBreak \inv a4*3/8\allowBreak \inv a4*4/8\allowBreak \inv a4*8/8\allowBreak \inv a4*3/8\allowBreak \inv a4*6/8\allowBreak \inv a4*4/8\allowBreak f4*1/8a2*3/8
  \fermata \bar "|." \mark \markup "G"
 
  a\breve*3/64\allowBreak \inv a4*3/8\allowBreak  c4*3/8\allowBreak  c\breve*2/64\allowBreak \inv a4*2/8\allowBreak d4*2/8->\allowBreak  c4*1/8c4*2/8->\allowBreak a4*1/8c2*1/8c2*2/8\breathe\allowBreak 
  c\breve*2/64\allowBreak \inv a4*8/8\allowBreak \inv a4*1/8\allowBreak \inv g4*3/8\allowBreak \inv f4*3/8\allowBreak a2*1/8 a\breathe\allowBreak 
  a\breve*3/64\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*5/8\allowBreak \inv a4*3/8\allowBreak \inv a4*4/8\allowBreak \inv a4*3/8\allowBreak g4*3/8\allowBreak f4*2/8\allowBreak a2*1/2
  \fermata \bar "||" %\mark \markup "G"
 
  a\breve*4/64\allowBreak \inv a4*3/8\allowBreak c4*4/8\allowBreak c\breve*2/64\allowBreak \inv a4*3/8\allowBreak \inv a4*5/8\allowBreak \inv a4*3/8\allowBreak \inv a4*1/8d\breve*5/64\allowBreak c4*1/8\allowBreak a4*1/8\allowBreak c2*1/8 c\breathe\allowBreak 
  a\breve*1/64\allowBreak \inv a4*1/8\inv a4*3/8\allowBreak \inv a4*8/8\allowBreak g4*1/8\allowBreak f4*1/8a2*3/8\fermata 
  \bar "||" %\mark \markup "G"
 
  a\breve*3/64\allowBreak \inv a4*3/8\allowBreak c2*3/8\allowBreak c\breve*2/64\allowBreak \inv a4*6/8\allowBreak \inv a4*3/8\allowBreak \inv a4*4/8\allowBreak \inv a4*1/8c2*2/8\allowBreak c\breve*1/64\inv a4*3/8\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak a2*4/8\breathe\allowBreak 
  c\breve*3/64\allowBreak \inv a4*3/8\allowBreak \inv a4*8/8\allowBreak \inv a4*3/8\allowBreak \inv a4*4/8\allowBreak d4*3/8\allowBreak c4*1/8a4*1/8c2*3/8\breathe\allowBreak 
  c\breve*3/64\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak a2*3/8\allowBreak g4*3/8\allowBreak f4*3/8\allowBreak a2*5/8\bar"|"
  c\breve*3/64\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak d4*3/8\allowBreak c4*2/8\allowBreak a4*3/8\allowBreak c2*2/8c2*1/8\breathe\allowBreak 
  c\breve*3/64\allowBreak \inv a4*3/8\allowBreak a\breve*4/64\allowBreak \inv a4*2/8\allowBreak \inv a4*1/8 g4*3/8\allowBreak f4*4/8\allowBreak a2*3/8
  \fermata 
  \bar "||" %\mark \markup "G"
 
  a\breve*5/64\allowBreak \inv a4*4/8\allowBreak c4*4/8\allowBreak c\breve*3/64\allowBreak \inv a4*5/8\allowBreak  a2*8/8\allowBreak a\breve*8/64\allowBreak \inv a4*5/8\allowBreak a4*5/8\allowBreak g4*3/8\allowBreak f4*5/8\allowBreak g2*7/8\breathe\allowBreak 
  g\breve*5/64\allowBreak \inv a4*8/8\allowBreak \inv a4*1/8g2*6/8\allowBreak g\breve*3/64\allowBreak \inv a4*2/8\allowBreak f4*6/8\allowBreak a2*5/8
  \fermata 
  \bar "|." \mark \markup "G"
 
  a4*2/8\allowBreak c\breve*3/64\allowBreak \inv a4*3/8\allowBreak \inv a4*6/8\allowBreak \inv a4*2/8\allowBreak a2*4/8\allowBreak c\breve*2/64\allowBreak \inv a4*2/8\allowBreak \inv a4*1/8d2*2/8\allowBreak d4*1/8 c4*2/8\allowBreak a4*1/8c4*2/8\breathe\allowBreak 
  c\breve*2/64\allowBreak \inv a4*7/8\allowBreak \inv a4*1/8a2*3/8\allowBreak a\breve*2/64\allowBreak \inv a4*2/8\allowBreak \inv a4*1/8a2*3/8\allowBreak g4*1/8f4*3/8\allowBreak a2*3/8\breathe\allowBreak 
  g\breve*8/64\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak f4*1/8g2*4/8\breathe\allowBreak 
  g\breve*3/64\allowBreak \inv a4*1/8\breve*3/64\allowBreak \inv a4*1/8g2*2/8g2*1/8\breathe\allowBreak g\breve*2/64\allowBreak \inv a4*2/8\allowBreak \inv a4*3/8\allowBreak  f4*2/8\allowBreak a2*2/8
  \fermata \bar "|." \mark \markup "G"
 
  a4*3/8\allowBreak a4*1/8c\breve*3/64\allowBreak \inv a4*3/8\allowBreak \inv a4*6/8\allowBreak \inv a4*1/8a2*5/8\allowBreak c\breve*3/64\allowBreak \inv a4*4/8\allowBreak \inv a4*4/8\allowBreak \inv a4*5/8\allowBreak d2*4/8\allowBreak c4*1/8a4*1/8c2*3/8\breathe\allowBreak 
  c\breve*4/64\allowBreak \inv a4*1/8a4*1/8g4*4/8\allowBreak a2*1/8a2*5/8\breathe\allowBreak 
  g\breve*5/64\allowBreak \inv g4*4/8\allowBreak \inv f4*1/8g2*3/8\allowBreak g4*1/8g2*4/8\allowBreak g4*1/8f4*1/8a2*4/8
  \fermata \bar "|." \mark \markup "G"
}

musBII = \relative c'' {
  a4*4/8\allowBreak c4*4/8->\allowBreak d4*4/8\allowBreak c4*5/8\allowBreak a4*1/8c2*5/8\breathe\allowBreak 
  c\breve*4/64\allowBreak \inv a4*7/8\allowBreak \inv a4*7/8\allowBreak \inv a4*4/8\allowBreak \inv a4*1/8a\breve*6/64\allowBreak \inv a4*5/8\allowBreak g4*5/8\allowBreak f4*4/8\allowBreak a2*1/8a2*3/8\breathe\allowBreak 
  g\breve*3/64\allowBreak \inv a4*5/8\allowBreak \inv a4*5/8\allowBreak \inv a4*3/8\allowBreak \inv a4*6/8\allowBreak \inv a4*4/8\allowBreak \inv a4*8/8\allowBreak f4*6/8\allowBreak a2*5/8\fermata  
  \fermata\bar "|." \mark \markup "G"
  
  %\break

  a\breve*3/64\allowBreak \inv a4*3/8\allowBreak c2*4/8\allowBreak c4*3/8\allowBreak d4*2/8\allowBreak c4*2/8\allowBreak a4*1/8c2*3/8\breathe\allowBreak 
  c\breve*2/64\allowBreak \inv a4*3/8\allowBreak \inv a4*1/8a\breve*3/64\allowBreak \inv a4*1/8g4*2/8\allowBreak f4*3/8\allowBreak a2*4/8\breathe\allowBreak 
  g\breve*3/64\allowBreak \inv a4*4/8\allowBreak \inv a4*5/8\allowBreak \inv a4*3/8\allowBreak \inv a4*8/8\allowBreak \inv a4*4/8\allowBreak f4*3/8\allowBreak a2*3/8\fermata  
  \fermata\bar "|." \mark \markup "G"
  
  c\breve*2/64\allowBreak \inv a4*3/8\allowBreak \inv a4*5/8\allowBreak \inv a4*8/8\allowBreak \inv a4*2/8\allowBreak \inv a4*4/8\allowBreak a2*4/8\breathe\allowBreak 
  c\breve*4/64\allowBreak \inv a4*3/8\allowBreak c2*4/8\allowBreak c4*2/8\allowBreak d4*1/8-> c4*2/8\allowBreak a4*2/8\allowBreak c2*1/8c2*3/8\breathe\allowBreak 
  c\breve*4/64\allowBreak \inv a4*8/8\allowBreak \inv a4*3/8\allowBreak \inv a4*1/8a2*4/8\allowBreak a\breve*3/64\allowBreak \inv a4*8/8\allowBreak \inv a4*2/8\allowBreak g4*1/8f4*1/8a2*3/8\breathe\allowBreak 
  a\breve*5/64\allowBreak \inv f4*2/8\allowBreak g2*1/8g2*3/8\breathe\allowBreak 
  g\breve*5/64\allowBreak \inv a4*1/8\allowBreak \inv a4*2/8\allowBreak  f4*1/8g2*1/8g2*2/8\breathe\allowBreak 
  g\breve*2/64\allowBreak \inv a4*6/8\allowBreak \inv a4*4/8\allowBreak  f4*1/8 a2*1/8\fermata a2*1/8\fermata
  \fermata\bar "|." \mark \markup "G"
  
  c\breve*3/64\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*2/8\allowBreak \inv a4*4/8\allowBreak a2*3/8\breathe\allowBreak 
  c\breve*8/64\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*2/8\allowBreak \inv a4*1/8d2*1/8c4*2/8\allowBreak a4*2/8\allowBreak c2*2/8\breathe\allowBreak 
  c\breve*2/64\allowBreak \inv a4*6/8\allowBreak \inv a4*5/8\allowBreak \inv a4*2/8\allowBreak \inv a4*4/8\allowBreak \inv a4*5/8\allowBreak \inv a4*2/8\allowBreak a2*1/8a2*2/8\breathe\allowBreak 
  a\breve*5/64\allowBreak g4*2/8\allowBreak f4*1/8a2*1/8a2*3/8\breathe\allowBreak 
  g\breve*2/64\allowBreak \inv a4*2/8\allowBreak \inv a4*4/8\allowBreak \inv a4*5/8\allowBreak \inv a4*4/8\allowBreak \inv a4*3/8\allowBreak f4*4/8\allowBreak a2*3/8\fermata
  \fermata\bar "|." \mark \markup "G"
  
  c\breve*3/64\allowBreak \inv a4*4/8\allowBreak \inv a4*3/8\allowBreak \inv a4*5/8\allowBreak \inv a4*2/8\allowBreak \inv a4*4/8\allowBreak \inv a4*7/8\allowBreak \inv a4*4/8\allowBreak \inv a4*1/8a2*1/8a2*3/8\breathe\allowBreak 
  c\breve*4/64\allowBreak \inv a4*3/8\allowBreak \inv a4*4/8\allowBreak \inv a4*1/8c2*3/8\allowBreak d4*3/8->\allowBreak d4*1/8c4*3/8\allowBreak a4*3/8\allowBreak c2*6/8\breathe\allowBreak c
  \breve*4/64\allowBreak \inv a4*2/8\allowBreak \inv a4*3/8\allowBreak \inv a4*7/8\allowBreak \inv a4*3/8\allowBreak a2*1/8a2*3/8\breathe\allowBreak 
  a\breve*3/64\allowBreak \inv a4*4/8\allowBreak \inv a4*2/8\allowBreak \inv a4*1/8g4*1/8f4*3/8\allowBreak a2*4/8\breathe\allowBreak 
  c\breve*2/64\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*5/8\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak \inv a4*4/8\allowBreak \inv a4*6/8\allowBreak \inv a4*2/8\allowBreak \inv a4*1/8a2*1/8a2*3/8\allowBreak  
  a\breve*6/64\allowBreak \inv a4*2/8\allowBreak  g4*1/8f4*2/8\allowBreak a2*1/8a2*3/8\breathe\allowBreak 
  g\breve*3/64\allowBreak \inv a4*5/8\allowBreak \inv a4*2/8\allowBreak \inv a4*8/8\allowBreak \inv a4*2/8\allowBreak \inv a4*3/8\allowBreak \inv a4*6/8\allowBreak \inv a4*1/8f4*1/8a2*1/8\fermata a2*1/8\fermata
  \fermata\bar "|." \mark \markup "G"

  a4*4/8\allowBreak c4*4/8->\allowBreak d4*4/8\allowBreak c4*4/8\allowBreak a4*1/8c2*5/8\breathe\allowBreak 
  c\breve*4/64\allowBreak \inv a4*2/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*1/8a2*2/8\allowBreak g4*2/8\allowBreak f4*3/8\allowBreak a2*1/8a2*3/8\breathe\allowBreak 
  g\breve*4/64\allowBreak \inv a4*8/8\allowBreak \inv a4*1/8f4*4/8\allowBreak a2*3/8\fermata  
  \bar "|." \mark \markup "G"
}

musBIII = \relative c'' {
  c\breve*6/64\allowBreak \inv a4*4/8\allowBreak \inv a4*5/8\allowBreak \inv a4*5/8\allowBreak \inv a4*1/8a2*6/8\breathe\allowBreak 
  c\breve*8/64\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*5/8\allowBreak \inv a4*8/8\allowBreak \inv a4*4/8\allowBreak \inv a4*1/8d2*3/8\allowBreak c4*3/8\allowBreak a4*4/8\allowBreak c2*5/8\breathe\allowBreak 
  c\breve*5/64\allowBreak \inv a4*4/8\allowBreak \inv a4*1/8a2*4/8\allowBreak a\breve*4/64\allowBreak \inv a4*7/8\allowBreak \inv a4*3/8\allowBreak \inv a4*8/8\allowBreak \inv a4*3/8\allowBreak g4*1/8f4*3/8\allowBreak a2*5/8\breathe\allowBreak 
  g\breve*3/64\allowBreak \inv a4*3/8\allowBreak \inv a4*4/8\allowBreak \inv a4*4/8\allowBreak \inv a4*6/8\allowBreak \inv a4*1/8f4*1/8g2*1/8g2*2/8\breathe\allowBreak 
  g\breve*2/64\allowBreak \inv a4*5/8\allowBreak \inv a4*3/8\allowBreak \inv a4*4/8\allowBreak \inv a4*2/8\allowBreak \inv a4*4/8\allowBreak \inv a4*2/8\allowBreak f4*1/8a2*1/8\fermata a2*2/8\fermata  
  \bar "|." \mark \markup "G"

  c\breve*5/64\allowBreak \inv a4*3/8\allowBreak \inv a4*8/8\allowBreak \inv a4*4/8\allowBreak \inv a4*2/8\allowBreak \inv a4*7/8\allowBreak d\breve*4/64\allowBreak c4*3/8\allowBreak a4*1/8c2*3/8\breathe\allowBreak 
  c\breve*2/64\allowBreak \inv a4*6/8\allowBreak \inv a4*3/8\allowBreak \inv a4*1/8a2*3/8\allowBreak a\breve*3/64\allowBreak \inv a4*2/8\allowBreak \inv a4*7/8\allowBreak \inv a4*3/8\allowBreak g4*3/8\allowBreak f4*1/8a2*4/8\breathe\allowBreak 
  a4*4/8\allowBreak c\breve*5/64\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*1/8d2*2/8\allowBreak d4*2/8\allowBreak d4*1/8c4*3/8\allowBreak a4*4/8\allowBreak c2*4/8\breathe\allowBreak 
  c\breve*3/64\allowBreak \inv a4*6/8\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak \inv a4*5/8\allowBreak \inv a4*1/8a2*3/8\allowBreak a\breve*2/64\allowBreak \inv a4*4/8\allowBreak g4*2/8\allowBreak f4*3/8\allowBreak a2*4/8\breathe\allowBreak 
  g\breve*3/64\allowBreak \inv a4*3/8\allowBreak \inv a4*2/8\allowBreak \inv a4*2/8\allowBreak \inv a4*6/8\allowBreak \inv a4*3/8\allowBreak \inv a4*3/8\allowBreak \inv a4*6/8\allowBreak f4*3/8\allowBreak a2*1/8\fermata a2*2/8\fermata
  \bar ".|" %\mark \markup "G*"
  <<    
    <<
      { \Clefs \voiceOne \set Staff.forceClef = ##t \clef "treble" \key f \major a2\fermata a2\fermata } 
      \new Voice { \voiceTwo f2 f2 }
    >>
    \new Staff \with {\remove Time_signature_engraver }
    << \Clefs\clef "bass" \key f \major \cadenzaOn
       { \voiceOne c2 c2 } 
       \new Voice  { \voiceTwo f,2\fermata f2\fermata }
    >>
  >>     
  \bar "|."  
}

Texte-Intro = \lyricmode {
  \mark \markup "C1" 
  Ex -- ul -- "tez dans le" ciel, multi -- tu -- des des an -- ges_!
  \bar "|" \mark \markup "C2"
  Exul -- tez, "célébrez les mystè" -- res di -- vins_!
  Ré -- son -- ne, trom -- pet -- te du sa -- lut,
  "pour la vic" -- toi -- re d’un si grand Roi_!
  
  \bar "|." \mark \markup "C1"
  Que la "terre, elle aus" -- si, soit heu -- reu -- se,
  \bar "|" \mark \markup "C2"
  "irradiée de" tant de feux_:
  "illuminée de la splendeur du" Roi é -- ter -- nel,
  "qu’elle voie s’en aller l’obscuri" -- té
  "qui recou" -- "vrait le" monde en -- tier_!

  \bar "|." \mark \markup "C1"
  Ré -- jou -- is- toi, É -- gli -- se no -- tre Mè -- re,
  \bar "|" \mark \markup "C2"
  "parée d’une lumière si" é -- cla -- tan -- te_!
  "Que reten" -- tis -- se dans ce lieu saint
  l’acclama -- "tion de" tous les peu -- ples_!
  
  \bar "|." \mark \markup "C1"
  Et vous, mes frères et sœurs bien-ai -- més,
  qui vous tenez ici dans l’admirable clarté de cette lumière sain -- te,
  invoquez avec moi, je vous prie,
  la miséricorde de Dieu tout- -- puis -- sant.
  \bar "|" \mark \markup "C2"
  Il m’a choisi dans mon indignité pour être à son ser -- vi -- ce_:
  "qu’il répande la clar" -- té de sa lu -- miè -- re
  "pour que je puisse chan" -- ter "la louange du" cier -- ge pas -- cal. 
}

Texte-dial = \lyricmode {
  "Le Seigneur soit" a -- vec vous.
  "Et avec" votre Es -- prit.

  Éle -- vons no -- tre cœur.
  "Nous le tour" -- "nons vers le Sei" -- gneur.

  "Rendons grâce au Seigneur" no -- tre Dieu.
  "Cela est" juste et bon.
}

textBI = \lyricmode {
  Vrai -- ment il est juste et bon chan -- ter à plei -- ne voix, 
  dans tout l’élan du cœur et de l’es -- prit, 
  le Père tout-puissant, Dieu in -- vi -- si -- ble, 
  et son fils unique, Jésus Christ, notre Sei -- gneur. 
 
  C’est lui qui a remis pour nous au Père é -- ter -- nel 
  le prix de la dette encourue par A -- dam_; 
  c’est lui qui répandit son sang par a -- mour 
  pour effacer la condamnation du premier pé -- ché. 
 
  Car voi -- ci la fête de la Pâ -- que 
  dans laquelle est mis à mort l’Agneau vé -- ri -- ta -- ble, 
  dont le sang consacre les portes des croy -- ants. 
 
  Voici la nuit où tu as ti -- ré d’É -- gy -- pte 
  les enfants d’Isra -- ël, nos Pè -- res, 
  et leur as fait passer la mer rouge à pied sec. 
 
  Voici la nuit où le feu d’une co -- lonne lu -- mi -- neu -- se 
  a dissipé les ténèbres du pé -- ché. 
 
  Voici la nuit qui arrache au monde corrom -- pu, aveu -- glé par le mal,
  ceux qui, aujourd’hui et dans tout l’u -- ni -- vers, 
  ont mis leur foi dans le Christ_;_ 
  nuit qui les rend à la grâ -- ce 
  et leur ouvre la commu -- nion des saints. 
 
  Voici la nuit où le Christ, 
  brisant les liens de la mort, 
  s’est relevé, victo -- rieux, du séjour des morts. 
 
  À quoi nous servirait-il de naître 
  sans le bon -- heur d’ê -- tre sau -- vé_? 
  Ô merveilleuse condescen -- dance 
  de ta ten -- dresse en -- vers nous_! 
  Inestimable choix de ton a -- mour_: 
  pour rache -- ter l’es -- cla -- ve, tu as livré le fils_! 
 
  Il fal -- lait le péché d’A -- dam, 
  que la mort du Christ a -- bo -- lit. 
  Ô bienheu -- reu -- se fau -- te 
  qui nous va -- lut pa -- reil Ré -- demp -- teur_! 
}

textBII = \lyricmode {
  Ô nuit de vrai bon -- heur
  qui seule mérita de con -- naître le temps et l’heu -- re
  où le Christ a surgi du séjour des morts_!
 
  Voici la nuit dont il est é -- crit_:
  "“La" nuit resplendi -- ra com -- me le jour_;
  la nuit même est lumière pour ma "joie.”"

  Car le pouvoir sanctifiant de cette nuit
  chasse les crimes et la -- ve les fau -- tes,
  rend l’innocence aux cou -- pables 
  et l’allégresse aux af -- fli -- gés,
  dissipe la hai -- ne,
  dispose à la con -- cor -- de et soumet toute puis -- san -- ce.
 
  Dans la grâce de cette nuit, accueille, Père très saint,
  en sacri -- fi -- ce du soir, 
  la flamme montant de cette colonne de ci -- re,
  œuvre des a -- beil -- les,
  que la sainte Église t’offre par nos mains.

  Mais déjà nous savons ce que proclame cette co -- lo -- nne 
  qui brûle avec é -- clat en l’hon -- neur de Dieu_:
  quand on en transmet la flam -- me, 
  sa clarté ne di -- mi -- nue pas.
  Car elle se nourrit de la cire produite par l’a -- beil -- le,
  comme par u -- ne mè -- re,
  pour former la substance de ce précieux lu -- mi -- nai -- re.

  Ô nuit de vrai bon -- heur,
  nuit où le ciel s’u -- nit à la ter -- re,
  où l’homme rencon -- tre Dieu.
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
  lui qui vit et règne pour les siècles des siè -- cles. A -- men.
}
