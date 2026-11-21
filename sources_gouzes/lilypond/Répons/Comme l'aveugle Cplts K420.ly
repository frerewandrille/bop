\version "2.24.0"

\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") } #(set-global-staff-size 17) indent = 0

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
  { \armure \cadenzaOn \tonRVIef }

  \addlyrics
  { 
    \set stanza = #"(I V) 1." \set shortVocalName = \markup\right-align"1." 
    "Dieu qui a dit : ' “Que du sein de la ténèbre ' brille" la lumi -- ère_!”
    "Voici qu’il a fait briller sa lumière en" nos cœurs_!
    "Je suis la lumiè" -- re du monde_!
    "Celui qui fait la vérité ' vient à" la lu -- mière.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"2." \set shortVocalName = \markup\right-align"2." 
    "Le Seigneur t’a pris" par la main,
    "il t’a désigné comme alliance du peuple ' et lumière des" na -- tions
    "pour ouvrir les yeux" des a -- veugles
    "et faire sortir de prison ' ceux qui habitent" les té -- nèbres.
  }
  \addlyrics
  { 
    \set stanza = #"(Ld.) 3." \set shortVocalName = \markup\right-align"3." 
    "Celui qu’on appelle Jésus ' a fait" de la boue,
    "il m’a enduit les yeux et" m’a dit_:
    "“Va te laver à Siloë, ' à la piscine de" l’En -- vo -- yé_!”
    "Alors j’y suis allé, ' je m’y suis lavé,'" et j’y vois_!
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = #"4." \set shortVocalName = \markup\right-align"4." 
    "Dieu est lumière, ' en lui il n’est point" de té -- nèbres_;
    "éveille-toi, ô toi qui dors, ' et le Christ t’illumi" -- ne -- ra_!
    "Car c’est toi, Seigneur," mon flam -- beau_!
    "Ô mon Dieu, ' illumine" ma té -- nèbre_!
  }
  \addlyrics
  { 
    \set stanza = #"(II V) 5." \set shortVocalName = \markup\right-align"5." 
    "“Crois-tu au" Fils de l’homme_?
    "Tu le vois, ' c’est lui qui" te parle.”
    "Alors, il dit : ' “Je" crois, Sei -- gneur_!”
    "Et se prosternant, ' il" l’a -- do -- ra.
  }
  \addlyrics
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  { 
    \set stanza = \markup{ \left-align "6." } \set shortVocalName = \markup\right-align"6." 
    "Je ferai marcher les aveugles sur" mes sen -- tiers
    "et je changerai devant eux ' les ténèbres en" lu -- mière,
    "par l’amour du Cœur de" no -- tre Dieu,
    "soleil levant ' qui est venu nous" vi -- si -- ter_!
  }
  \addlyrics
  { 
    \set stanza = "(Dox.) 7." \set shortVocalName = \markup\right-align"7." 
    "Gloire au Père des lumières ' de qui vient tout" don par -- fait,
    "gloire au Fils de l’homme, ' lumière née de la" lu -- mière,
    "gloire à l’Esprit ' qui ouvre les yeux de" no -- tre cœur
    "à l’œuvre du salut, ' quand Jésus nous est" en -- vo -- yé_!
  }
  \addlyrics
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = \markup{ \left-align " (Magn.) 8." } \set shortVocalName = \markup\right-align"8." 
    "Maintenant, ' tu peux laisser s’en aller ton" ser -- vi -- teur
    "en paix, ' selon ta" pa -- role_;
    "car mes yeux ont vu" ton sa -- lut,
    "lumière des nations ' et gloire" d’Is -- ra -- ël_! 
  }
  
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRVIeh }
>>