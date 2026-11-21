\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key ees \major \time 3/4 }
ptRetrait = \once \override LyricText.X-offset = #2

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 6
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVImf }

  \addlyrics
  { 
    \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
    "Je bénirai le Sei" -- "gneur en" tout temps,
    "sa louange sans" "cesse à" mes lèvres.
    "En Dieu que mon âme trouve sa" gloire,
    "que les pauvres" m’en -- tendent_' et "soient en" fête.
  }
  \addlyrics
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    "Proclamez avec moi que le Sei" -- gneur est grand.
    "Exaltons tous en" -- semble son nom_!
    "J’ai cherché le Seigneur et il m’a répon" -- du.
    "De toutes mes" ter -- reurs_' il "m’a déli" -- vré.
  }
  \addlyrics
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    "Tournez vous vers le Seigneur et vous se" -- "rez illu" -- mi -- nés,
    "Votre visage ne sera" "pas couvert" de honte_;
   " Un pauvre a crié, et Dieu a enten" -- du,
    "Le Seigneur l’a" sau -- vé_' de "toutes ses an" -- goisses.
  }
  \addlyrics
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
    "L’ange du Seigneur a éta" -- bli son camp,
    "Il entoure et délivre" "ceux qui" le craignent.
    "Goûtez et voyez que le Seigneur est" doux,
    Bienheureux
  }
  \addlyrics
  { 
    \repeat unfold 10 { \skip4 }
    \ptRetrait "l’homme qui trouve" en lui_' \skip4 "son a" -- bri !
  }
  \addlyrics
   \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"5." \set shortVocalName = \markup\right-align"5." 
    "Saints du Seigneur, ado" -- "rez le" Sei -- gneur,
    "Ceux qui le craignent ne" manquent de rien.
    "Les riches s’appauvrissent et ils ont" faim,
    "Mais ceux"
  }
  \addlyrics
   \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \repeat unfold 10 { \skip4 }
    \ptRetrait "qui cherchent le" Sei -- gneur_' "sont com" -- "blés de tout" bien.
  }
%   \addlyrics
%   { 
%     \set stanza = #"6." \set shortVocalName = \markup\right-align"6." 
%     Venez, mes fils, écoutez moi
%     Je vous enseignerai la crainte du Seigneur ;
%     Quel est l’homme qui désire la vie
%     Qui aime les jours où il voit le bonheur ?
%   }
%   \addlyrics
%   { 
%     \set stanza = #"7." \set shortVocalName = \markup\right-align"7." 
%     Que ta langue se garde du mal
%     Et tes lèvres du mensonge.
%     Ecarte-toi du mal et fais le bien,
%     Recherche la paix et poursuis-la toujours.
%   }
%   \addlyrics
%   { 
%     \set stanza = #"8." \set shortVocalName = \markup\right-align"8." 
%     Le Seigneur tourne sa face contre ceux qui font le mal
%     Pour effacer de la terre leur souvenir
%     Mais ses yeux regardent ceux qui l’aiment
%     Il tend l’oreille, vers ceux qui l’appellent.
%   }
%   \addlyrics
%   { 
%     \set stanza = #"9." \set shortVocalName = \markup\right-align"9." 
%     Ils ont crié, et le Seigneur a entendu,
%     De la détresse, il les a délivrés.
%     Il est proche de ceux qui ont le cœur brisé
%     Il vient sauver ceux dont la vie est déchirée.
%   }
%   \addlyrics
%   { 
%     \set stanza = #"10." \set shortVocalName = \markup\right-align"10." 
%     Tant de fois, le malheur a éprouvé le juste
%     Mais toujours, le Seigneur l’a délivré,
%     Il veille sur lui, il garde tous ses os,
%     Pas un seul ne sera brisé.
%   }
%   \addlyrics
%   \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
%   { 
%     \set stanza = #"11." \set shortVocalName = \markup\right-align"11." 
%     Le mal fera mourir le méchant,
%     Lui qui avait pris en haine le juste, il sera condamné.
%     Le Seigneur rachète la vie de ses serviteurs,
%     En lui, ils ont cherché refuge, ils ne seront pas condamnés. 
%   }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVImh }
>>