\version "2.24.0"

\include "vowel-set.ly"
%\include "TonsRDef.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17)

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose g e
\new ChoirStaff 
<< \new Staff \with {\remove Time_signature_engraver }
   { \key d \minor \time 3/4 \cadenzaOn\tonRIff }
   
   \addlyrics
   { 
     \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
     "Ô Christ, tu es descendu des" "cieux dans le sein" de la Vierge.
     "L’Église célèbre les té" -- "moins de ton In" -- car -- na -- tion_:
     "Gabriel, qui annonça la Bonne Nou" -- "velle" à Ma -- rie,
     "Les Anges, qui t’ont accueil" -- li par leurs chants,
     "Et Jean, le Précurseur, qui a bondi de" "joie à" ta ve -- nue.
   }
   \addlyrics
   { 
     \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
     "Au ciel, ' l’étoile de l’au" -- "rore annonçait aux mages" le Sau -- veur,
     "Jean au milieu du" "peuple montre l’A" -- gneau de Dieu,
     "Zacharie et Élisabeth bé" -- "nissent le" Dieu fi -- dèle,
     "Au-devant du Fils de Dieu" "marche le" Pré -- cur -- seur_:
     "Il reconnaît la voix de l’Époux de l’É" -- "glise et sa joie" est par -- faite.
   }
   \addlyrics
   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   { 
     \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
     "Aujourd’hui, ' Élisabeth et Zacha" -- "rie chantent les miséricor" -- des de Dieu.
     "Aujourd’hui, '" "les prophètes acclament le plus grand" des pro -- phètes.
     "Aujourd’hui, ' les martyrs es" -- "cortent ' celui qui a précédé Jésus dans" les En -- fers.
     "Aujourd’hui, ' les Apôtres entendent Jean procla" -- "mer : ' “Voici l’A" -- gneau de Dieu_!”
     "La création tout entière loue" "Jean, le plus grand des en" -- fants des hommes.
   }
   \addlyrics
   { 
     \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
     "L’ami de l’É" -- "poux a fiancé le Christ et l’Église" au Jour -- dain.
     "Il attendit dans l’espé" -- "rance le salut" d’Is -- ra -- ël.
     "À la mort, il pré" -- "dit le vainqueur" de la mort.
     "À tout homme, il an" -- "nonce le Royau" -- me de Dieu.
     "À tous les hommes, il annonce le" "Christ, a" -- mi des hommes.
   }
   \addlyrics
   { 
     \set stanza = #"5." \set shortVocalName = \markup\right-align"5." 
     "Gloire au" "Père qui a envoyé sont Fils par" -- mi les hommes.
     "Gloire au" "Fils ' qui est venu planter sa tente" par -- mi nous.
     "Gloire à l’Es" -- "prit qui ne cesse d’accomplir" des mer -- veilles.
     "Avec Jean qui mar" -- "chait dans la for" -- ce d’É -- lie,
     "Trinité Sainte, nous te bénis" -- sons_: Gloire à toi_!
   }
   \addlyrics
   { 
     \set stanza = #"6. " \set shortVocalName = \markup\right-align"6." 
    
   }
   \addlyrics
   { 
     \set stanza = #"7. " \set shortVocalName = \markup\right-align"7." 
    
   }
   \addlyrics
   \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
     \set stanza = #"8. " \set shortVocalName = \markup\right-align"8." 
    
   }
  
   \new Staff \with {\remove Time_signature_engraver }
   { \clef "bass" \key d \minor \cadenzaOn\tonRIfh }
>>