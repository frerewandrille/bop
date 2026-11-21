\version "2.24.0"

\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }


\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< \new Staff = "femmes" \with { \consists "Merge_rests_engraver" }
   \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn
          d8 (a'4.\fermata) b8 a\breve g8 a4\fermata a\resp
          a8 b [c] b [a] b [a]  \once \override Script.script-priority = -100 g4->\fermata f\fermata\bar"|"
          f8 g [a] a [g] a [b] a4\fermata a\resp
          8 g [f] e [d] e [f] e4\fermata d\fermata
          \bar"|."
          d4 (e8 [d]) c4 \fermata (d\fermata)\bar"|."
        } 
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c'
        { 
          d\breve*5/16 <d e>\breve s8 q4 4 
          <d f>\breve*5/16 <d e>\breve*4/16 d4
          d\breve*3/16 <d e>\breve*4/16 <d f>4 4
          8 <a e'>\breve*8/16 d4
          a2 a4 (d)
        }    
      }
   >>
   \addlyrics
   { 
     \set stanza = "1." \set shortVocalName = \markup\right-align"1." 
     Ô __ \skip4\skip4 "Christ, sauveur de tous" les hom -- mes,
     ô toi le Bien_- Ai -- mé du Pè -- re,
     Fils en -- gen -- dré dans le mys -- tè -- re
     a -- vant que com -- men -- ce le mon -- de,
   }
   \addlyrics
   { 
     \set stanza = "2." \set shortVocalName = \markup\right-align"2." 
     Ô __ \skip4 lu -- "mière et splendeur" du Pè -- re,
     seul à ja -- mais notre es -- pé -- ran -- ce,
     en -- tends mon -- ter de par le mon -- de
     l'ac -- cla -- ma -- tion de tes fi -- dè -- les.
   }
   \addlyrics
   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
     \set stanza = "3." \set shortVocalName = \markup\right-align"3." 
     Ô __ \skip4\skip4 "toi la source du" sa -- lut, \skip4
     sou -- viens_- toi qu'en ce jour de grâ -- ce,
     né de la Vier -- ge bien -- heu -- reu -- se,
     tu pris no -- tre corps de mi -- sè -- re.
   }
   \addlyrics
   { 
     \set stanza = "4." \set shortVocalName = \markup\right-align"4." 
     No -- ël re -- "vient, jour d'al" -- lé -- gres -- se,
     No -- ël re -- vient, qui nous pro -- cla -- me,
     que de la seu -- le main du Pè -- re
     le Sa -- lut est ve -- nu aux hom -- mes.
   }
   \addlyrics
   { 
     \set stanza = "5." \set shortVocalName = \markup\right-align"5." 
     Au Pè -- re, "qui t'a en" -- vo -- yé, \skip4
     le ciel et la mer et la ter -- re,
     le peu -- ple -- ment des cré -- a -- tu -- res
     of -- frent leur ru -- meur de lou -- an -- ge.
   }
   \addlyrics
   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
     \set stanza = "6." \set shortVocalName = \markup\right-align"6." 
     Et nous aus -- "si, ton peu" -- ple saint, \skip4
     la -- vés dans ton sang au bap -- tê -- me,
     nous t'ad -- res -- sons un chant nou -- veau \skip4
     en ce grand jour de ta nais -- san -- ce.
   }
   \addlyrics
   { 
     \set stanza = "7." \set shortVocalName = \markup\right-align"7." 
     Hon -- neur et "gloire à toi," Sei -- gneur,\skip4
     qui es né de la Vier -- ge Mè -- re,
     a -- vec le Père et l'Es -- prit Saint \skip4
     tu es vi -- vant pour tous les siè -- cles.
     A -- \skip4\skip4 men.
   }
   \addlyrics
   \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
     \set stanza = "8." \set shortVocalName = \markup\right-align"8." 
    
}>>