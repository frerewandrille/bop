\version "2.24.0"

\include "vowel-set.ly"

armure = { \key f \major \time 4/4 }
resp = { \breathe\allowBreak }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   <<
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \omit Score.BarLine
         a4. a8 a4 g a2 f4 \resp f g g a2 f\resp g4 g a2 f d \allowBreak 
         g4 g f2 d c1 \resp
         d2.^\markup\italic"rallentendo" e4 f1 1\fermata
         \undo \omit Score.BarLine
         \bar"|."
       } 
     }
     \new Voice = "alto"
     { \voiceTwo \relative c'
       { 
         c4. f8 f4 d f2 d4 d e e f2 d d4 e f2 c bes d4 c a2 bes g1 
         bes2. 4 c1 1
       }    
     }
   >>
   \addlyrics
   { 
     \set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
     Viens, Es -- prit du Pè -- re, sois la lu -- miè -- re, 
     fais jail -- lir des cieux ta splen -- deur de gloire_!
     Al -- le -- lu -- ia_!   }
   \addlyrics
   { 
     \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
     Es -- prit de sa -- ges -- se, qui nous en -- sei -- gnes, 
     à bé -- nir le Père et cri -- er vers lui. 
     Al -- le -- lu -- ia_!   }
   \addlyrics
   { 
     \set stanza = #"3. " \set shortVocalName = \markup\right-align"3." 
     Feu qui il -- lu -- mi -- ne, souf -- fle de vi -- e, 
    par toi res -- plen -- dit la croix du Sei -- gneur. 
     Al -- le -- lu -- ia_!   }
   \addlyrics
   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
     \set stanza = #"4. " \set shortVocalName = \markup\right-align"4." 
     Par toi, les a -- pô -- tres par -- lent sans crain -- te, 
     an -- non -- çant le Christ qui nous a sau -- vés.
     Al -- le -- lu -- ia_!   }
   \addlyrics
   { 
     \set stanza = #"5. " \set shortVocalName = \markup\right-align"5." 
     Es -- prit d’al -- lé -- gres -- se, joie de l’É -- gli -- se, 
     fais jail -- lir des cœurs le chant de l’A -- gneau. 
     Al -- le -- lu -- ia_!   }
   \addlyrics
   { 
     \set stanza = #"6. " \set shortVocalName = \markup\right-align"6." 
     Viens, ro -- sée cé -- les -- te, sour -- ce d’eau vi -- ve, 
     af -- fer -- mis les cœurs, for -- ti -- fie les corps. 
     Al -- le -- lu -- ia_!   }
   \addlyrics
   { 
     \set stanza = #"7. " \set shortVocalName = \markup\right-align"7." 
     Fais_- nous re -- con -- naî -- tre l’a -- mour du Pè -- re, 
     et ré -- vè -- le_- nous la beau -- té du Fils. 
     Al -- le -- lu -- ia_!   }   
   \addlyrics
   \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
     \set stanza = #"8. " \set shortVocalName = \markup\right-align"8." 
     Gloire à toi, ô Pè -- re, et à ton Fils, __ \skip4 et au Saint Es -- prit,
     dans les siè -- __ \skip4 cles.
     Al -- le -- lu -- ia_!   }
   
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4. c8 4 bes c2 bes4 a c c c2 bes bes4 c c2 f, f d4 e f2 f e1 
          g2. 4 <f a>1 q
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4. 8 4 g f2 bes,4 d c c <f, f'>2 bes \resp
          g'4 c, f2 a, bes2 4 c d2 bes c1\resp
          g2. 4 f1 1 \fermata
        } 
      }
   >>
>>