\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17)

armure = { \key bes \major \time 3/4 }

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
  { \armure \cadenzaOn \tonRIIIbf }

  \addlyrics
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Je suis la Vigne, ' vous" "êtes les" sar -- ments.
    "Demeurez en moi ' et vous prote" -- "rez beaucoup" de fruit.
    "Si ma Parole demeure en vous, ' vous se" -- "rez mes" dis -- ciples_:
    "Tout ce que vous demanderez au Père"
  }
  \addlyrics
  { 
    \repeat unfold 12 {\skip4 } 
    \retrait "en mon" "Nom, ' il vous l’accor" -- de -- ra.
  }
  \addlyrics
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Je vous donne un com" -- "mandement" nou -- veau_:
    "Aimez-vous les uns les autres ' comme" "je vous ai" ai -- més.
    "Voici que je fais toutes" "choses" nou -- velles.
    "Demeurez en moi ' et vous porterez les" "fruits du monde" nou -- veau.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Je m’en vais vous prépa" -- "rer une" de -- meure
    "et je reviendrai pour vous" "prendre a" -- vec moi.
    "Voici la demeure de" "Dieu parmi" les hommes_:
    "Demeurez en moi ' et je de" -- "meurerai" en vous.
  }
  \addlyrics
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "Ce n’est pas vous qui m’avez choisi, '"
  }
  \addlyrics
  { 
    \set shortVocalName = "4." 
    \retrait "mais c’est" "moi qui vous ai" choi -- sis,
    "pour que vous alliez et portiez un" "fruit qui" de -- meure_:
    "Allez vous aussi travail" -- "ler à" ma vigne_!
    "Je vous donnerai les" " fruits de ma résur" -- rec -- tion_!
  }
  \addlyrics
  { 
    \set stanza = #"5. " \set shortVocalName = "5." 
    "Dans l’aube de Pâques, '"
  }
  \addlyrics
  { 
    \set shortVocalName = "5." 
    \retrait "le Bien-aimé est descen" -- "du dans le" jar -- din_:
    "pour voir les grenadiers en fleurs et la" "vigne qui" bour -- geonne.
    "Il est venu dans le jardin ' pour" "paître son" trou -- peau,
    "son Église bien-aimée ' en qui il a" "mis tout son" a -- mour.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"6. " \set shortVocalName = "6." 
    "Ma vigne bien-aimée ex" -- "hale son" par -- fum_:
    "Je l’ai plantée près de la source" "vive de" l’Es -- prit.
    "Elle est un jardin clos ' où je" "trouve le" re -- pos_:
    "Et son vin géné" -- "reux m’a réjoui" le cœur.
  }
  \addlyrics
   { 
    \set stanza = #"7. " \set shortVocalName = "7." 
    "Béni soit le Père ' qui nous a ai" -- "més le" pre -- mier
    "et qui a glorifié Jésus, son en" -- "fant bien -" -- ai -- mé.
    "Béni soit l’Esprit '"
  }
 \addlyrics
   { 
    \repeat unfold 8 {\skip4 } 
    \ptretrait "qui fait de nous la demeure de" "Dieu parmi" les hommes.
    \set shortVocalName = "7." 
    "Béni soit le Dieu vivant ' qui met sa" "gloire dans l’homme" vi -- vant.
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   { 
    \set stanza = #"8. " \set shortVocalName = "8." 
    "Réjouis-toi, ' car le Seigneur a fait de" "toi sa" de -- meure.
    "Il a fait de toi, Vierge Ma" -- "rie, ' la Mère des" vi -- vants.
    "Le Seigneur est avec toi ' car tu as" "cru a sa" Pa -- role.
    "Par sa chair, ' il t’a glori" -- "fiée dans" ta chair.
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIIIbh }
>>