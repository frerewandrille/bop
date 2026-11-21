\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 16) indent = 0

armure = { \key bes \major \time 3/4 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIIbf }

  \addlyrics
  { 
    \set stanza = "1." \set shortVocalName = \markup\right-align"1." 
    Ré -- jou -- "is-toi, fille de Sion! ' Exulte de" tou -- tes tes forces_!
    "Voici que ton" "roi s’avance" vers toi_:
    "Hosanna au plus" haut des cieux_!
    "Béni soit celui qui" "vient, le Seigneur" "Dieu qui nous" il -- lu -- mine_!
  }
  \addlyrics
  { 
    \set stanza = "2." \set shortVocalName = \markup\right-align"2." 
    For -- mez "un cor" -- "tège, ram" -- eaux en main_!
    "Rendez grâce au Sei" -- "gneur, car éternel est son" a -- mour_!
    "Voici l’Époux qui vient! ' Allons à" sa ren -- contre_!
    "L’Esprit et l’Épouse disent :" "Viens! ’ Hosan" -- "na au fils" de Da -- vid_!
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = " Dox." \set shortVocalName = \markup\right-align"3." 
    Ren -- dez "gloire au Seigneur, car éter""nel est" son a -- mour_!
    "Gloire à Dieu notre" "Père, qui nous a donné son Fils" u -- nique.
    "Gloire au Fils ' qui vient visiter le peuple" de l’Al -- liance.
    "Gloire à l’Esprit ' qui ha" -- "bite les lou" -- anges d’Is -- ra -- ël.
  }
  \addlyrics
  { 
    \set stanza = "4." \set shortVocalName = \markup\right-align"4." 
    
  }
  \addlyrics
  { 
    \set stanza = "5." \set shortVocalName = \markup\right-align"5." 
    
  }
  \addlyrics
  { 
    \set stanza = "6." \set shortVocalName = \markup\right-align"6." 
    
  }
  \addlyrics
  { 
    \set stanza = "7." \set shortVocalName = \markup\right-align"7." 
    
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = "8." \set shortVocalName = \markup\right-align"8." 
    
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIIbh }
>>