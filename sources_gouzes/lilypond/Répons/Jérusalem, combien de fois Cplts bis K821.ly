\version "2.24.0"

\include "vowel-set.ly"

im = \set ignoreMelismata = ##t

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\transpose g e
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "Lundi"
          g8^\markup\italic"Soliste" d'\breve*1/8 c8 d4 \breathe\allowBreak 
          c\breve*1/8 f ees d8 [c] d4 \bar"|"
          bes8 [c] d\breve*1/8  ees8 [d]\allowBreak 
          \phrasingSlurDashed\slurDashed
          d \(([c) bes]\) a4 \breathe\allowBreak
          d,\breve*1/8 bes'  a  bes8 g2\fermata\bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        d,\breve*1/8
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = #"Lu (1.)" \set shortVocalName = \markup\right-align"1."
     Sei -- "gneur, nous avons péché de" -- vant toi, "et nous t’a" -- vons dé -- so -- bé -- i_!
     Nous n’a -- "vons pas écouté la voix de" tes pro -- phè -- \skip4 tes, 
     "nous a" -- "vons ' oubli" -- "é tes" che -- mins.
   }
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = #"Ma (2.)" \set shortVocalName = \markup\right-align"2." 
     "Que ta co" -- "lère se détourne" de nous_! 
     "Nous ne sommes qu’un" "reste par" -- mi les na -- tions_:
     pour la "gloire de ton Nom, ' dé" -- li -- vre_- nous, Sei -- gneur, 
     "et fais -" nous misé -- ri -- corde_!
   }
   \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   \lyricsto "soprano" 
   {
     \set stanza = #"Me (3.)" \set shortVocalName = \markup\right-align"3." 
     Re -- "garde, Seigneur, et tends" l’o -- reille_!
     "Dans les en" -- "fers, les morts ne" peuvent te lou -- er_;
     mais c’est "un cœur brisé par" la souf -- fran -- \skip4 ce 
     "qui te rend" "gloire ' et jus" -- tice, Sei -- gneur.
   }
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = #"Je (4.)" \set shortVocalName = \markup\right-align"4."
     Ac -- "corde-nous, Seigneur, ' au cœur de notre" e -- xil,
     "de rentrer en nous -" "mêmes, et con" -- naî -- tre ton Nom,
     et donne_- "nous un cœur qui s’ouvre à" ta pré -- sen -- \skip4 ce,
     "et qui cé" -- lè_' -- "bre tes" mer -- veilles_!
   }
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = #"Ve (5.)" \set shortVocalName = \markup\right-align"5." 
     Fais_- "nous revenir," Sei -- gneur, "sur la" "terre que tu as don" -- née à nos pères_;
     é -- ta -- "blis sur nous une alliance " é -- ter -- nel -- \skip4 le_:
     "Tu seras notre" "Dieu, ' et nous" serons ton peuple_!
   }
   \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   \lyricsto "soprano" 
   {
     \set stanza = #"Sa (6.)" \set shortVocalName = \markup\right-align"6." 
     É -- "coute, Seigneur, et prends" pi -- tié,
     "mets sur nos" "lèvres ' la lou" -- ange de ton Nom_!
     Ne te "souviens pas des fautes " de nos pè -- \skip4 res, 
     "mais de ton a" -- "mour et de ta ten" -- dresse pour nous_!
   }
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = #"Dox (7.)" \set shortVocalName = \markup\right-align"7." 
     \im Ô "Père des misé" -- ri -- cordes, "Dieu de ten" -- dresse_' et de par -- don,
     con -- ver -- "tis notre cœur" par la Croix de ton Fils,
     "et par la" "for ' - ce" "de ton" Es -- prit_!
   }
>>