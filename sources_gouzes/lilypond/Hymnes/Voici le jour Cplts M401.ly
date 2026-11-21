\version "2.24.0"

\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn 
    << \relative c'' { \tieDashed\slurDashed
      g8 [a] c [c] g [f] a4~ a8 \resp
      f8 f [d] g4 f8 [d] e [c] d4~ d\bar"|"
      f8 [e] d [e] g [(f)] d [c] e4~ e8\resp
      e d [f] d [c] d [e] e2\fermata
      \bar"|."
       } \\
       \relative c' { e\breve*6/16 d\breve*3/16 d\breve*13/16
       d\breve*1/2 c\breve*3/16 c\breve*7/16 b2
       }
    >> 
  }

  \addlyrics
  { 
    \set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
    \im Que les cieux se ré -- jou -- is -- sent 
    et que la joie rè -- gne sur la ter -- re_:
    Le Sei -- gneur a li -- bé -- ré son peu -- ple, 
    car é -- ter -- nel est son a -- mour.
  }
  \addlyrics
  { 
    \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    \im Au le -- ver du Jour nou -- veau,_ __ \skip4
    Jé -- sus n’est plus où vous le cher -- chez._ __ \skip4
    Il nous guide en ter -- __ \skip4 re pro -- mi -- se_:
    Vous le ver -- rez comme il l’a dit.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3. " \set shortVocalName = \markup\right-align"3." 
    \im Les té -- nèbres ont dis -- pa -- rues,_ __ \skip4
    la Vé -- ri -- té s’est ma -- ni -- fes -- tée._ __ \skip4
    Dieu pour nous s’est li -- vré comme A -- gneau_ __ \skip4
    pour nous con -- duire au Pa -- ra -- dis.
  }
  \addlyrics
  { 
    \set stanza = #"4. " \set shortVocalName = \markup\right-align"4." 
    \im À la sour -- ce du sa -- lut,_ __ \skip4
    ve -- nez pui -- ser la vie é -- ter -- nel -- le_!
    Il nous of -- fre le par -- don du Pè -- re
    en nous don -- nant son Es -- prit Saint.
  }
  \addlyrics
  { 
    \set stanza = #"5. " \set shortVocalName = \markup\right-align"5." 
    \im Au pé -- ché, vous ê -- tes morts_ __ \skip4
    et vo -- tre vie est ca -- chée en Dieu._ __ \skip4
    Quand le Christ se -- ra ma -- ni -- fes -- té,_ __ \skip4
    nous pa -- raî -- trons en plei -- ne gloire.
  }
  \addlyrics
  { 
    \set stanza = #"6. " \set shortVocalName = \markup\right-align"6." 
    \im Gloire au Pè -- re tout_- puis -- sant._ __ \skip4
    Gloire au Sei -- gneur Christ res -- sus -- ci -- té._ __ \skip4
    À l’Es -- prit dont il nous a com -- blés,_ __ \skip4
    lou -- ange et gloire, al -- lé -- lu -- ia.
  }
  \addlyrics
  { 
    \set stanza = #"7. " \set shortVocalName = \markup\right-align"7." 
    
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"8. " \set shortVocalName = \markup\right-align"8." 
    
  }
>>