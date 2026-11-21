\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key f \major  \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 3
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRIdf }

  \addlyrics
  { 
    \set stanza = #"1." \set shortVocalName = \markup\right-align"1." 
    Du fond de "sa souffrance, elle" "a cri" -- "é vers" toi,
    "Et toi, mon" "Dieu, tu" l’as gué -- rie.
    "Tu as affermi ses" "pas sur le" "roc de ta Pa" -- role
    "Pour qu’elle te fasse connaître et ai" -- "mer, Sei" -- "gneur Jé" -- sus.
  }
  \addlyrics
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    Quand deux ou "trois se ras" -- semblent "en ton" Nom,
    "Tu es, Sei" -- "gneur, au" mi -- lieu d’eux.
    "Tu fis lever ta ser" -- "vante au mi" -- "lieu de ton" peuple
    "Afin qu’elle proclame ta lou" -- "ange dans la" "grande assem" -- blée.
  }
  \addlyrics
  %\with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"3." \set shortVocalName = \markup\right-align"3." 
    Lais -- sez ve -- "nir à" "moi les pe" -- "tits en" -- fants_:
    "Je leur enseigne" -- "rai l’amour" du Sei -- gneur.
    "Je ne veux con" -- "naître que Jé" -- "sus mon Sei" -- gneur,
    "Jésus Christ cruci" -- "fié pour le sa" -- "lut de" tous.
  }
  \addlyrics
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
    Tu con -- nais, "Seigneur, le se" -- "cret de" "son dé" -- sir_:
    "Que le monde tourne son" "cœur vers" ton A -- mour.
    "C’est dans l’u" -- "nique ser" -- "vice de ta Volon" -- té
    "Qu’elle a cherché la" gloire véri -- table.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #" Dox." \set shortVocalName = \markup\right-align"D." 
    Lou -- ange à "toi, notre Père, qui nous as ai" -- més "le pre" -- mier.
    "Louange au" "Fils, dont le cœur est le cœur" de l’É -- glise.
    "Gloire à l’Es" -- "prit qui nous con" -- "duit vers le Roy" -- aume.
    "Trinité bienheureuse, ' repos de tous les" saints, "gloire à" toi_!
  }
  \addlyrics
  { 
    \set stanza = #"6." \set shortVocalName = \markup\right-align"6." 
    
  }
  \addlyrics
  { 
    \set stanza = #"7." \set shortVocalName = \markup\right-align"7." 
    
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"8." \set shortVocalName = \markup\right-align"8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIdh }
>>