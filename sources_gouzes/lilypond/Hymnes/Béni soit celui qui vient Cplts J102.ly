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
    "Aujourd’hui sont accom" -- "plis les signes et" les pro -- diges_:
    "tu es manifes" -- "té, ô Christ" no -- tre Dieu_:
    "la terre et les cieux ra" -- "content la gloire"  de Dieu_!
  }
  \addlyrics
  { 
    \set stanza = #"2. " \set shortVocalName = \markup\right-align"2." 
    "Voici que se" "lève une gran" -- de clar -- té_:
    "elle guide les" "mages et illumine" les ber -- gers
    "et réveille la joie du" "cœur de tous"  les peuples.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3. "\set shortVocalName = \markup\right-align"3." 
    "La voix des Pro" -- phè -- tes s’est tue,
    "car voi" -- "ci la louan" -- ge nou -- velle,
    "et les na" -- "tions battent" des mains_!
  }
  \addlyrics
  { 
    \set stanza = #"4. " \set shortVocalName = \markup\right-align"4." 
    "Une étoile appa" -- "raît, un astre" s’est le -- vé,
    "en Jacob s’est ou" -- "vert un chemin" de lu -- mière_:
    "sur lui s’a" -- "vancent les princes des"  na -- tions.
  }
  \addlyrics
  { 
    \set stanza = #"5. " \set shortVocalName = \markup\right-align"5." 
    "Ils viennent offrir l’en" -- "cens et ado" -- rent leur Dieu.
    "Ils lui offrent la" "myrrjhe en signe" du tom -- beau,
    "où il s’éveille" -- "ra, victorieux de"  la Mort.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"6. " \set shortVocalName = \markup\right-align"6." 
    "Ils offrent" "l’or à" l’En -- fant Dieu,
    "au trésor des na" -- "tions, couché dans" u -- ne crèche_:
    "les rois du" "monde viennent adorer sa pau"  -- vre -- té.
  }
  \addlyrics
  { 
    \set stanza = #"7. " \set shortVocalName = \markup\right-align"7." 
    "Aujourd’hui à Bethlé" -- "em est né le Pasteur" d’Is -- ra -- ël.
    "Il apporte le sa" -- "lut à tous les peuples" de la terre,
    "et les rois d’Ori" -- "ent marchent vers sa"  Lu -- mière.
  }
  \addlyrics
  { 
    \set stanza = #"8. " \set shortVocalName = \markup\right-align"8." 
    "L’Agneau s’a" -- "vance et porte le pé" -- ché du monde.
    "Les eaux fré" -- "missent à l’approche" de la Croix.
    "Le Jourdain est consa" -- "cré par le Sang de"  l’A -- gneau.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"9. " \set shortVocalName = \markup\right-align"9." 
    "À Cana se cé" -- "lèbrent les naoces" de l’A -- gneau,
    "et l’Époux Bien-ai" -- "mé s’unit à" son É -- glise_:
    "Courons avec les" "mages boire le vin"  nou -- veau_!
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