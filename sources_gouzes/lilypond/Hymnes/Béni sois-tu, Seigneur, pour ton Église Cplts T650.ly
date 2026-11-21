\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose c bes,
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   { \clef "treble" \key c \major
     \cadenzaOn\tonRCaf
   }
   \addlyrics
   { 
     \set stanza = #"1. " \set shortVocalName = "1." 
     "Tu as choisi tes A" -- pô -- tres, Sei -- gneur,
     "comme témoins de ta" "vie, de ta ré"  -- sur -- rec -- tion_;
     "Tu as soufflé sur" "eux ton" Es -- prit saint,
     "pour qu’ils portent du" "fruit en" a -- bon -- dance.
   }
   \addlyrics
   { 
     \set stanza = #"2. " \set shortVocalName = "2." 
     "Ô Christ, tu as" "fait de" tes dis -- ciples
     "les fondements de l’É" -- glise, ton é -- pouse_;
     "Tu as inscrit leurs noms sur le" li -- vre de vie
     "et sur les remparts de la nou" -- "velle Jé" -- ru -- sa -- lem.
   }
   \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
     \set stanza = #"3. " \set shortVocalName = "3." 
     "Comme le Père, qui est vi" -- "vant, t’a" en -- voy -- é,
     "tu les as envoyés jusqu’aux li" -- mites de la terre_;
     "Par eux a retenti la Pa" -- ro -- le de vie,
     "dans tout l’univers et les" î -- les loin -- taines.
   }
   \addlyrics
   { 
     \set stanza = #"4. " \set shortVocalName = "4." 
     "Tu aimes le par" -- "don plus que les" sa -- cri -- fices.
     "Tu es venu partager le re" -- pas des pé -- cheurs.
     "Tu as choisi un publicain pour qu’il" soit ton A -- pôtre_:
     "Tu l’as guéri et revê" -- "tu de ta mi" -- sé -- ri -- corde.
   }
   \addlyrics
   { 
     \set stanza = #"5. " \set shortVocalName = "5." 
     "Il a trouvé le trésor caché du Roy" -- au -- me nou -- veau,
     "il a tout quitté pour mar" -- cher à ta suite_;
     "Bienheureux les pau" -- "vres, les arti" -- sans de paix_:
     "C’est à eux qu’appartient le Roy" -- au -- me des cieux_!
   }
   \addlyrics
   { 
     \set stanza = #"6. " \set shortVocalName = "6." 
     "Gloire à toi, Père saint, qui" règne pour les siècles,
     "par l’Agneau immolé qui nous a rache" -- tés par son sang,
     "dans l’Esprit souverain, qui fut don" -- "né aux" douze A -- pôtres,
     "pour qu’ils fondent l’Église en tout lieu à la lou" -- ange de ton nom.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   { \clef "bass" \key c \major
     \cadenzaOn\tonRCah
   }
>>