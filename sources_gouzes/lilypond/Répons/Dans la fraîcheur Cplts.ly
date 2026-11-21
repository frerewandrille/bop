\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") indent = 0 } #(set-global-staff-size 17)

armure = { \key f \major \time 3/4 }
%retrait = \once \override LyricText.X-offset = #retrait
retrait = { \once \override LyricText.X-offset = 4 }

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
  { \armure \cadenzaOn \tonRIcf }

%   \addlyrics
%   { 
%     \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
%     "Le Seigneur nous ac" -- "corde l’intimi" -- "té et la" joie des Noces_:
%     "Bienheureux les invi" -- "tés au fes" -- tin de l’A -- gneau_!
%     "Aimons de tout notre" "cœur le Sei" -- "gneur en" sa beau -- té,
%     "Lui dont l’amour rend plus heu" -- "reux et la con" -- templa -- tion plus fort !
%   }
%   \addlyrics
%   { 
%     \set shortVocalName = \markup\right-align"2." 
%     \repeat unfold 18 {\skip4}
%     "Splendeur de gloire"
%   }
%   \addlyrics
%   { 
%     \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
%     "Il nous comble de sa bon" -- "té, il nous" "baigne de" sa dou -- ceur,
%     "La mémoire de son" "Nom est lu" -- "mière en" no -- tre cœur.
%     "Son parfum nous ressus" -- "cite et sa vi" -- "sion nous" ré -- jou -- it,
%     \set shortVocalName = "" 
%     \retrait"et vie sans" "fin dans la Jé" -- rusa -- lem du Ciel_!
%   }
  \addlyrics
  { 
    \set stanza = #"(L.) 1." \set shortVocalName = \markup\right-align"1." 
    "Contemplons-nous," 
  }
  \addlyrics
  { 
    \set shortVocalName = \markup\right-align"1." 
    \retrait "mes bien-ai" -- "mées, dans le mi" -- "roir de" Jé -- sus_- Christ,
    "Dans le miroir où resplen" -- "dit la pauvre" -- "té du" Bien_- Ai -- mé,
    "Pour parer notre" "cœur de la" ro -- be des noces,
    "Et fleurir notre" "tête de sa cou" -- ron -- ne de gloire.
  }
  \addlyrics
  { 
    \set stanza = #"(V.) 2." \set shortVocalName = \markup\right-align"2." 
    "Dans ce miroir resplen" -- "dit l’amour du" "Christ no" -- tre Sei -- gneur,
    "La pauvreté du Fils de" "Dieu, enfant cou" -- "ché dans" u -- ne crèche,
    "L’humilité du Roi du" "Ciel qui a souf" -- "fert pour" nous sau -- ver,
    "Et l’ineffable a" -- "mour qui l’a con" -- "duit jus" -- qu’à la Croix.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    "Et nous qui pas" -- "sons par le che" -- "min de" son a -- mour,
    "Contemplons-le dans le mi" -- "roir de sa dou" -- "leur et" de sa Croix_!
    "Que la mé" -- "moire de notre" "âme ne l’oub" -- lie ja -- mais,
    "Embrasée chaque" "jour de la fer" -- "veur de" sa ten -- dresse_!
  }
  %   \addlyrics
  %   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  %   { 
  %     \set stanza = #"6. " \set shortVocalName = \markup\right-align"6." 
  %     "Prends-nous avec" "toi, ô" "Christ, toi notre é" -- poux cé -- leste_!
  %     "Nous te suivons dans l’i" -- "vresse et la dou" -- "ceur de" ton par -- fum.
  %     "Que tes bras nous é" -- "treignent dans le bai" -- "ser de" ton sa -- lut,
  %     "Lorsque nous entre" -- "rons dans le se" -- "cret de" ton a -- mour.
  %   }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set shortVocalName = \markup\right-align"4." 
    \repeat unfold 12 {\skip4}
    "Soyons toujours avec le" "Christ, qui nous"
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #" (Dox.) 4." \set shortVocalName = \markup\right-align"4." 
    "Que Dieu notre" "Père nous bé" -- nisse et nous garde_!
    "Sur nous que resplen" -- "disse la lu" -- mière de sa face_!
    \set shortVocalName = "" 
    \repeat unfold 1 {\skip4} \retrait"fait gran" -- dir en sa grâce,
    \set shortVocalName = \markup\right-align"4." 
    "Nous qui" "sommes enfants de" "Dieu dans" l’Es -- prit_- Saint.
  }
  \addlyrics
  { 
    \set stanza = #"8. " \set shortVocalName = \markup\right-align"8." 
  
  }

  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIch }
>>