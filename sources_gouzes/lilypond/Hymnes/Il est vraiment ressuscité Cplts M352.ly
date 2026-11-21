\version "2.24.0"

\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17)

armure = { \key d \major \time 3/4 }
% retrait = \once \override LyricText.X-offset = #retrait
% retrait = \once \override LyricText.X-offset = #10
\defineBarLine "|" #'("|" "" "")
\defineBarLine "|." #'("|." "" "")
barPoint = { \bar "!" \noBreak }
silN = { \oneVoice r4 \voiceOne }

coupure = { \allowBreak }


\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new StaffGroup
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn 
    <<
      \relative c'' { a\breve b2 \breathe \coupure a\breve a2  \barPoint a\breve*1/2 \barPoint g4 fis a2 \bar "|" \coupure 
                      fis\breve fis2 \breathe \coupure fis\breve fis2 \barPoint fis\breve*1/2 \barPoint e4 d e2 \bar"|" \coupure 
                      a\breve b2 \breathe \coupure a\breve a2 \barPoint a\breve*1/2 \barPoint g4 fis a2 \bar "|" \silN a4 d cis2. d \bar "|." } \\
      \relative c' {  fis\breve g2 \breathe \coupure fis\breve fis2 fis\breve*1/2 b,4 d e2 \bar "|" \coupure 
                      d\breve d2 \breathe \coupure d\breve d2 d\breve*1/2 b4 b cis2 \bar"|" \coupure 
                      fis\breve g2 \breathe \coupure fis\breve fis2 fis\breve*1/2 b,4 d e2 \bar "|" \coupure  s4 d4 fis e2. fis \bar "|." } 
    >>
  }

  \addlyrics
  { 
    \set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
    "“C’est la Pâque du Seigneur”, ' clame l’Es" -- prit,
    "“C’est la Pâque du Sei" -- "gneur '" en vé -- ri -- "té !”"
    "Le Seigneur a versé son" sang,
    "en signe de l’Es" -- prit "qui de" -- vait ve -- nir.
    "Il nous a signés de son" sang
    "et nous avons é" -- té \skip4 pro -- té -- gés.
    Al -- lé -- lu -- ia_!
  }
  \addlyrics
  { 
    \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    "Seigneur, ' tu as étendu les mains sur la" croix,
    "tu nous as abri" -- tés \skip4 sous tes ailes_:
    "Tu as versé le sang d’un" Dieu
    "pour sceller l’Al" -- lian -- \skip4 ce nou -- velle.
    "Tu as éloigné de nous la co" -- lère,
    "tu nous réconci" -- lies \skip4 a -- vec Dieu.
    Al -- lé -- lu -- ia_!
  }
  \addlyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3. " \set shortVocalName = \markup\right-align"3." 
    "Tu ouvres la fête de l’Es" -- prit,
    "tu nous entraînes dans la" dan -- \skip4 se mys -- tique.
    "Ô Pâque de Dieu, ' qui descends du ciel sur la" terre.
    "et qui de la terre re" -- mon -- tes vers le ciel_!
    "En toi la création toute en" -- tière
    s’assem -- ble "et se" ré -- jou -- it.
    Al -- lé -- lu -- ia_!
  }
  \addlyrics
  { 
    \set stanza = #"4. " \set shortVocalName = \markup\right-align"4." 
    "Ô joie de l’uni" -- vers, 
    "festin de" grâ -- \skip4 \skip4 \skip4 ce,
    "Tu dissipes les ténèbres de la" mort,
    "tu ouvres les" por -- tes de la vie_:
    "En toi les promesses sont accom" -- plies,
    "les chants sont ren" -- dus \skip4 à la terre.
    Al -- lé -- lu -- ia_!
  }
  \addlyrics
  { 
    \set stanza = #"5. " \set shortVocalName = \markup\right-align"5." 
    "Ô Pâque, ' Noces de l’A" -- gneau,
    "le Dieu du ciel vient s’unir à" nous \skip4 dans l’Es -- prit_!
    "L’immense salle des" noces "est rem" -- plie \skip4 de con -- vives.
    "Tous portent la robe nup" -- tiale,
    et nul n’est re -- je -- té.
    Al -- lé -- lu -- ia_!
  }
  \addlyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"6. " \set shortVocalName = \markup\right-align"6." 
    "Ô Pâque, ' nouvelle clar" -- té, 
    "splendeur du cor" -- tè -- ge vir -- gi -- nal_:
    "Chez tous, le feu de la" grâce "brûle dans le" corps et dans l’Es -- prit.
    "Les lampes ne s’éteindront" plus,
    "car c’est l’huile du" Christ qui brûle en elles.
    Al -- lé -- lu -- ia_!
  }
  \addlyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"7. " \set shortVocalName = \markup\right-align"7." 
    "Ô Christ, ' Dieu souverain, ' roi dans l’Es" -- prit,
    "Étends les mains sur ton É" -- "glise, '" "protège -" la du mal_!
    "Et donne-lui de pouvoir chanter avec Mo" -- ïse 
    le chant \skip4 tri -- om -- phal.
    "Car à toi est la vic" -- toire
    "dans les" siè -- \skip4 cles des siècles.
    Al -- lé -- lu -- ia_!
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn 
    <<
      \relative c' {  d\breve d2 \breathe \coupure d\breve cis2 cis\breve*1/2 e4 d cis2 \bar "|" \coupure 
                      a\breve b2 \breathe \coupure b\breve a2 a\breve*1/2 g4 fis a2 \bar"|" \coupure 
                      d\breve d2 \breathe \coupure d\breve cis2 cis\breve*1/2 e4 d cis2 \bar "|"  \silN d4 a a2. a \bar "|."  } \\
      \relative c {  d\breve g2 \breathe \coupure d\breve fis2 fis\breve*1/2 e4 b' a2 \bar "|" \coupure 
                     d,\breve b2 \breathe \coupure b\breve d2 d\breve*1/2 e4 b a2 \bar"|" \coupure 
                     d\breve g2 \breathe \coupure d\breve fis2 fis\breve*1/2 e4 b' a2 \bar "|" \coupure  s4 fis4 d a2. d \bar "|."  } 
    >>
  }
>>