\version "2.24.0"

\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17) indent = 0

armure = { \key bes \major \time 3/4 }
%retrait = \once \override LyricText.X-offset = #retrait
retrait = \once \override LyricText.X-offset = #4

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}


\transpose d b,
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \relative c''
    << { a\breve bes a8 [g] a4\bar"|" a\breve c bes8 [bes] a4 \bar"|" d\breve c bes8 a2 \bar"|."} \\
       { fis\breve g fis!8 [e] fis4\bar"|" fis!\breve fis g8 [e] fis!4 \bar"|" g\breve fis! g8 fis!2 }
    >>
  }

  \addlyrics
  { 
    \set stanza = #"1. " \set shortVocalName = \markup\right-align"1." 
    "Aujourd’hui"
  }
  \addlyrics
  { 
    \set shortVocalName = \markup\right-align"1." 
    \retrait "la voix Père a reten" -- "ti sur les eaux" in -- nom -- brables.
    "Aujourd’hui la grâce de l’Es" -- "prit repose" sur les eaux.
    "Aujourd’hui le Christ"
  }
  \addlyrics
  { 
    \repeat unfold 10 \skip4
    \retrait "nous donne l’Esprit de sa" -- "gesse et de crainte" de Dieu.
  }
  \addlyrics
  { 
    \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    "Aujourd’hui l’Agneau s’a" -- "vance" vers la Croix.
    "Aujourd’hui l’Ami des" "hommes se "
  }
  \addlyrics
  { 
    \repeat unfold 6 \skip4
    \retrait "hâte pour nous" dé  -- li -- vrer.\set shortVocalName = \markup\right-align"2." 
    "Aujourd’hui il prend sur" "lui le péché" du monde.
  }
  \addlyrics
  { 
    \set stanza = #"3. "
    "Aujourd’hui"
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set shortVocalName = \markup\right-align"3." 
    \retrait "les eaux ont vu le" "Christ et" ont pris peur.
    "Aujourd’hui les" "fleuves ont éle" -- vé la voix.
    "Aujourd’hui le Jourdain éton" -- "né est retourné en" ar -- rière.
  }
  \addlyrics
  { 
    \set stanza = #"4. " \set shortVocalName = \markup\right-align"4." 
    "Aujourd’hui l’amertume des" "eaux est changée" en dou -- ceur.
    "Aujourd’hui"
  }
  \addlyrics
  { 
    
    \repeat unfold 5 \skip4
    \retrait "le Seigneur nous con" -- "duit vers les eaux" jail -- lis -- santes.\set shortVocalName = \markup\right-align"4."
    "Aujourd’hui ceux qui ont" "soif boivent aux sources du" Sau -- veur.
  }
  \addlyrics
  { 
    \set stanza = #"5. " \set shortVocalName = \markup\right-align"5." 
    "Aujourd’hui les eaux du Dé" -- "luge effacent" le pé -- ché.
    "Aujourd’hui la lèpre de Naa" -- "man est" pu -- ri -- fiée.
    "Aujourd’hui la Mer voit et s’en" -- "fuit devant le Peuple" de Dieu.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"6. " \set shortVocalName = \markup\right-align"6." 
    "Aujourd’hui un Feu dévo" -- "rant est descendu dans" le Jour -- dain.
    "Aujourd’hui le Christ a écra" -- "sé le tête" du dra -- gon.
    "Aujourd’hui il fait pé" -- "rir l’Ennemi caché dans" les eaux.
  }
  \addlyrics
  { 
    \set stanza = #"7. " \set shortVocalName = \markup\right-align"7." 
    "Aujourd’hui s’est le" -- "vé le Soleil" sans dé -- clin.
    "Aujourd’hui une source a jail" -- "li à l’Ori" -- ent du Temple.
    "Aujourd’hui le torrent réjou" -- "it la Cité" de Dieu.
  }
  \addlyrics
  { 
    \set stanza = #"8. " \set shortVocalName = \markup\right-align"8." 
    "Aujourd’hui le Peuple" "boit au Rocher" du dé -- sert.
    "Aujourd’hui Israël,"
  }
  \addlyrics
  { 
    \repeat unfold 5 \skip4
    \retrait "traversant le Jour" -- "dain, entre dans la Ter" -- re pro -- mise.\set shortVocalName = \markup\right-align"8." 
    "Aujourd’hui du trône de l’A" -- "gneau jaillit le Fleuve" d’eau vive.
  }
  \addlyrics
  { 
    \set stanza = #"9. " \set shortVocalName = \markup\right-align"9." 
    "Aujourd’hui le Jourdain dé" -- "borde comme" \repeat unfold 3 \skip4
    "Aujourd’hui toutes les" "eaux reçoivent" \repeat unfold 3 \skip4
    "Aujourd’hui"
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \skip4
    \retrait "au temps de" la mois -- son.
    \skip4
    \retrait "la bénédiction" du Jour -- dain.
    \retrait "l’Église est l’Arche du Sa" -- "lut qui nous conduit au Pa" -- ra -- dis.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"10. " \set shortVocalName = \markup\right-align"10." 
    "Gloire au Père éter" -- "nel qui nous donne" un Sau -- veur.
    "Gloire à son Fils Jé" -- "sus qui nous est" ap -- pa -- ru.
    "Gloire à l’Esprit d’A" -- "mour qui l’a mani" -- fes -- té_!
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \relative c'
    << { d\breve d d8 [d] d4 \bar"|" d\breve d d8 [d] d4 \bar"|" d\breve d d8 d2 } \\
       { d,\breve g d8 [d] d4 \bar"|" d\breve a' g8 [g] d4 \bar"|" bes'\breve a g8 d2 }
    >>
  }
>>