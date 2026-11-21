\version "2.24.0"

\include "vowel-set.ly"


armure = { \key d \major \time 3/4 }
silN = { \oneVoice r4 \voiceOne }
resp = { \breathe\allowBreak }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\score {
  \new ChoirStaff
  << 
    \new Staff \with {\remove Time_signature_engraver }
    { \armure \cadenzaOn 
      <<
        \relative c'' {
          a\breve b4 \resp a\breve 4 \breve g8 [fis8] a4 \bar "|"  
          fis\breve fis4 \resp fis\breve fis4 \breve e8 [d8] e4 \bar"|"\break
          a\breve b4 \resp a\breve a4 \breve g8 [fis8] a4 \bar "|"
          \silN a4 d cis2. d\fermata \bar "|." 
        } \\
        \relative c' { 
          fis\breve g4 \resp fis\breve 4 \breve b,8 [d] e4 \bar "|"  
          d\breve d4 \resp d\breve d4 \breve b8 [b] cis4 
          fis\breve g4 \resp fis\breve fis4 \breve b,8 [d] e4 \bar "|"  
          s4 d fis e2. fis
        } 
      >>
    }
    \addlyrics 
    { 
      \set stanza = #"1. " \set shortVocalName = "1." 
      "« C’est la Pâque du Seigneur », clame l’Es" -- prit,
      "« C’est la Pâque du Sei" -- "gneur '" en vé -- ri -- té_!_»
      "Le Seigneur a versé son" sang,
      "en signe de l’Es" -- prit  "qui de" -- vait ve -- nir.
      "Il nous a signés de son" sang
      "et nous avons é" -- té \skip4 pro -- té -- 
      \set shortVocalName = "1-7."
      gés. 
      Al -- lé -- lu -- ia_!
    }
    \addlyrics 
    { 
      \set stanza = #"2. " \set shortVocalName = "2." 
      "Seigneur, ' tu as étendu les mains sur la" croix,
      "tu nous a abri" -- tés \skip4 sous tes ailes_:
      "Tu as versé le sang d’un" Dieu
      "pour sceller l’Al" -- lian -- \skip4 ce nou -- velle.
      "Tu as éloigné de nous la co" -- lère,
      "tu nous réconci" -- lies\skip4 a -- vec Dieu.
    }
    \addlyrics 
    { 
      \set stanza = #"3. " \set shortVocalName = "3." 
      "Tu ouvres la fête de l’Es" -- prit,
      "tu nous entraînes dans la" dan -- \skip4 se mys -- tique.
      "Ô Pâque de Dieu, ' qui descend du ciel sur la" terre,
      "et qui, de la terre, re" -- mon -- te vers le ciel_!
      "En Toi la création toute en" -- tière
      s’as -- semble "et se" ré -- jou -- it.
    }
    \addlyrics 
    { 
      \set stanza = #"4. " \set shortVocalName = "4." 
      "Ô joie de l’uni" -- vers, 
      "festin de" grâ -- \skip4 \skip4 \skip4 ce,
      "tu dissipes les ténèbres de la" mort,
      "tu ouvres les" por -- tes de la vie_:
      "En toi les promesses sont accom" -- plies,
      "les chants sont ren" -- dus \skip4 à la terre.
    }
    \addlyrics 
    { 
      \set stanza = #"5. " \set shortVocalName = "5." 
      "Ô Pâque, ' Noces de l’A" -- gneau,
      "Le Dieu du ciel vient s’unir à" nous \skip4 dans l’Es -- prit_!
      "L’immense salle des" noces 
      "est rem" -- plie \skip4 de con -- vives.
      "Tous portent la robe nup" -- tiale,
      "et nul" n’est \skip4 re -- je -- té.
    }  
    \addlyrics 
    { 
      \set stanza = #"6. " \set shortVocalName = "6." 
      "Ô Pâque, ' nouvelle clar" -- té, 
      "splendeur du cor" -- tè -- ge vir -- gi -- nal_:
      "Chez tous, le feu de la grâce" brûle
      "dans le" corps et dans l’Es -- prit.
      "Les lampes ne s’éteindront" plus,
      "car c’est l’huile du" Christ qui brûle en elles.
    }  
    \addlyrics 
    { 
      \set stanza = #"7. " \set shortVocalName = "7." 
      "Ô Christ, ' Dieu souverain, ' roi dans l’Es" -- prit,
      "étends les mains sur ton Ég" -- lise,_' protège- -- la du mal_!
      "Et donne-lui de pouvoir chanter avec Mo" -- ïse 
      le chant \skip4 tri -- om -- phal.
      "Car à toi est la vic" -- toire
      "dans les" siè -- \skip4 cles des siècles.
    }  
    \new Staff \with {\remove Time_signature_engraver }
    { \clef "bass" \armure \cadenzaOn 
      <<
        \relative c' { 
          d\breve d4 \resp d\breve cis4 \breve e8 [d] cis4 \bar "|"  
          a\breve b4 \resp  b\breve a4 \breve g8 [fis] a4 
          d\breve d4 \resp d\breve cis4 \breve e8 [d] cis4 \bar "|"  
          \silN d4 a a2. a 
        } \\
        \relative c { 
          d\breve g4 \resp d\breve fis4 \breve e8 [b'] a4 \bar "|"  
          d,\breve b4 \resp b\breve d4 \breve e8 [b] a4 
          d\breve g4 \resp d\breve fis4 \breve e8 [b'] a4 \bar "|"  
          s4 fis d a2. d\fermata
        } 
      >>
    }
  >>
  \layout { ragged-last = ##t }
}