\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17)

armure = { \key d \major \time 3/4 }
retrait = \once \override LyricText.X-offset = #retrait

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
  { \armure \cadenzaOn \tonRVIIcf }

\addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Venez, mes fils, écou" -- tez_- moi,
    "que je vous enseigne l’amour" du Sei -- gneur_;
    "Veillez car vous ne savez ni le jour" ni l’heure.
    "Voici l’époux qui vient ! ' Venez à sa" ren -- contre.
   }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Voici qu’aujourd’hui vous entendez" sa voix_;
    "n’endurcissez pas" vo -- tre cœur_!
    "Courez tant que vous avez la lumière de" la Vie
    "de peur que les ténèbres de la mort ne vous" sai -- sissent.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Tournez-vous vers le Seigneur et vous serez illu" -- mi -- nés_!
    "C’est ton visage, Siegneur," que je cherche.
    "Quoi de plus doux que la voix du Seigneur qui vous" in -- vite_:
    "Dans sa bonté, il vous montre le chemin de" la Vie_!
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Que vous reins soinet ceints et vox lampes al" -- lu -- mées_:
    "Soyez des fils de" la lu -- mière,
    "pour partager la joie de Dieu dans sa sainte" de -- meure,
    "et le louer sans fin, dans les siècles" des siècles_!
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
   { 
    \set stanza = #"5. " \set shortVocalName = "5." 
    "Celui qui se glorifie, qu’il se glorifie dans le" Sei -- gneur_!
    "Qu’il bâtisse sa maison sur le roc de" son a -- mour_!
    "Et la splendeur du Seigneur reposera" sur lui,
    "affermissant l’ouvrage de" ses mains.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #"6. " \set shortVocalName = "6." 
    "Gloire au Père qui nous appelle à son" Roy -- aume,
    "gloire au Christ qui nous fait passer de la mort" à la Vie,
    "gloire à l’Esprit qui nous fait désirer la venue du" Sei -- gneur,
    "Trinité sainte, gloire" à toi_!
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIIch }
>>