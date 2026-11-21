\version "2.24.0"

%\include "TonsRDef.ly"\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

%\paper { #(set-paper-size "a5") }

armure = { \key ees \major \time 3/4 }
retrait = \once \override LyricText.X-offset = #2

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 1
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose g e
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn 
    <<
      \relative c'' { c\breve bes c8  g4 \bar "'" g\breve f g8 [aes] g4 \bar "|" 
                      ees'\breve c d8 [bes] c4 \bar "'" f\breve d ees d8 [bes] c4 \bar "|." } \\
      \relative c'' { g\breve f s8 ees4\bar "'" ees\breve d s4  ees\bar "|" 
                      g\breve aes g8 [g] aes4 \bar "'" aes\breve g f g8 [f] g4 } >>
  }

  \addlyrics 
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Accueillons le Sei" -- "gneur, ' qui tient en sa main les sept" é -- toiles_:
    "Il a pris sur lui notre fai" -- "blesse ' et le poids" de nos chutes_;
    "Il vient renouveler en" "nous ' l’amour des" pre -- miers jours
    "et nous donne de goûter au" "fruit ' de" l’arbre de sa Croix.
  }
  \addlyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Accueillons le Sei" -- "gneur, ' lui qui était mort et qui a re" -- pris vie_!
    "Il a connu nos é" -- "preuves, ' pris part à" nos souf -- frances_;
    "Il vient parmi nous ' dans la" "gloire de sa ré" -- sur -- rec -- tion.
    "Il vient nous donner la cou" -- "ronne ' de la" vie é -- ter -- nelle.
  }
  \addlyrics 
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Accueillons le Sei" -- "gneur, ' dont la Parole est comme une épée af" -- fi -- lée_:
    "Il vient combattre en" "nous ' le péché" et la mort_;
    "Il vient nourrir nos" "cœurs ' de la man" -- ne ca -- chée.
    "Il vient graver en nous ' le nom nou" -- "veau de son a" -- "mour res" -- sus -- ci -- té.
  }
  \addlyrics 
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Accueillons le Sei" -- "gneur, ' dont les yeux sont une flamme" ar -- dente_:
    "Il nous donne de porter du" "fruit ' dans la fi" -- dé -- li -- té_:
    "Par lui, tenons fermes dans l’espé" -- "rance, ' attendant" sa ve -- nue,
    "quand il se lèvera dans nos" "cœurs, '"% comme l’É" -- toile du ma -- tin.
  }
  \addlyrics 
  { 
    \repeat unfold 15 { \skip4 }
    \retrait "comme l’É" -- toile du ma -- tin.
  }
  \addlyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"5. " \set shortVocalName = "5." 
    "Accueillons le Sei" -- "gneur, ' qui possède les sept Esprits" de Dieu_!
    "Il vient nous revêtir ' de la splen" -- "deur de sa ré" -- sur -- rec -- tion_:
    "Veillons pour que revive en nous ' la pa" -- "role qu’il nous a" -- vait don -- née_!
    "Veillons pour qu’il ne nous surprenne" "pas ' dans la" "nuit comme" un vo -- leur_!
  }
  \addlyrics 
  { 
    \set stanza = #"6. " \set shortVocalName = "6." 
    "Accueillons le Sei" -- "gneur, ' qui tient en sa main la clef de" Da -- vid_!
    "Qu’il ouvre notre cœur ' à la" "joie de sa ré" -- sur -- rec -- tion_!
    "Qu’il fasse de nous ' les co" -- "lonnes de son" tem -- ple saint
    "et grave en nous le nom de la sainte ci" -- "té, ' Jérusa" -- "lem, por" -- te du ciel_!
  }
  \addlyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"7. " \set shortVocalName = "7." 
    "Accueillons le Sei" -- "gneur, ' le Témoin fidèle" et vrai_!
    "Il vois notre tié" -- "deur ' et nos faus" -- ses ri -- chesses.
    "Il se tient à notre" "porte ' et le voi" -- ci qui frappe_:
    "Ouvrons-lui notre" "cœur : ' Il nous"% partage le fes" -- tin de sa Pâque.
  }
  \addlyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \repeat unfold 15 { \skip4 }
    \retrait "partage le fes" -- tin de sa Pâque.
  }
   
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn 
    <<
      \relative c' { ees\breve  d s8 c4 \bar "'" c\breve c s4 c\bar "|" 
                     ees\breve ees d8 [d] ees4 \bar "'" c\breve d c d8 [d] ees4 } \\
      \relative c { c\breve g' s8 c4 \bar "'" c\breve aes g8 [f] c4 \bar "|" 
                    c'\breve aes bes8 [bes] aes4 \bar "'" aes\breve bes aes bes8 [g] c,4 } >>
  }
>>