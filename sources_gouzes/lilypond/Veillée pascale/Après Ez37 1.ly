\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") }

armure = { \key e \minor }
retrait = \once \override LyricText.X-offset = #retrait

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose c bes,
\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRVIIIbf
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
 "Mon âme a" soif de Dieu,
le Dieu vi -- vant
"quand pourrai-je" m’a -- van -- cer,
paraître face à Dieu_?
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
"Je conduisais vers la maison" de mon Dieu
"la multi" -- tude en fête,
"parmi les" cris de joie
"et les ac" -- tions de grâce.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
"Envoie ta lumière et ta" vé -- ri -- té_:
"qu’elles gui" -- dent mes pas
"et me conduisent à ta mon" -- ta -- gne sainte,
jusqu’en ta de -- meure.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
"J’avancerai jusqu’à l’au" -- tel de Dieu,
"vers Dieu qui est tou" -- te ma joie
"je te rendrai grâce a" -- vec ma harpe,
Dieu, \skip4 mon Dieu_!
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIIIbh
  }
>>