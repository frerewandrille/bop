\version "2.24.0"

\include "vowel-set.ly"

\layout {
  \context {
    \Lyrics
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}

\transpose g e
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "Lundi"
          g8^"Soliste" d'\breve*1/8 c8 d4 \breathe\allowBreak 
          c\breve*1/8 f8 [ees] d [c] d4 \bar"|"
          bes8 [c] d\breve*1/8 ees8 [d]\allowBreak 
          d ([c bes]) a4 \breathe\allowBreak
          d,8 [d] bes'4\allowBreak bes8 [bes]\allowBreak a [a bes] g2\fermata\bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        d,\breve*1/8
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Lundi "}
     Sei -- "gneur, nous avons péché de" -- vant toi, "et nous t’a" -- vons dé -- so -- bé -- i_!
     Nous n’a -- "vons pas écouté la voix de" tes pro -- phè -- tes, 
     nous a -- vons ou -- bli -- é tes che -- mins.
   }
>>

\transpose g e
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "Mardi"
          g\breve*1/8 d'\breve*1/8 c8 d4 \breathe\allowBreak 
          c\breve*1/8 \allowBreak f ees8 [d c] d4 \bar"|"
          bes8 [c] d\breve*1/8 d4 \breathe\allowBreak 
          d8 ees8 [(d) d]\allowBreak d [(c) bes] a4 \breathe\allowBreak
          d,8 [d] bes'8 [a]\allowBreak a [bes] g2 g\fermata\bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        d,\breve*1/8
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = \markup {\large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Mardi "}
     "Que ta co" -- "lère se détourne" de nous_! 
     "Nous ne sommes qu’un" "reste par" -- mi les na -- tions_:
     pour la "gloire de ton" Nom, dé -- li -- vre_- nous, Sei -- gneur, 
     et fais_- nous mi -- sé -- ri -- cor -- de_!
   }
>>

\transpose g e
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "Mercredi"
          g8 d'\breve*1/8 c8 d4 d\breathe\allowBreak 
          c\breve*1/8 f \allowBreak ees8 [ees]\allowBreak d [c] d4 \bar"|"
          bes8 [c] d\breve*1/8 ees8 [d] d ([c bes]) a4 \breathe\allowBreak
          d,\breve*1/8 bes'4 bes8 [bes]\allowBreak a [a bes] g2\fermata\bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        d,\breve*1/8
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Mercredi "}
     Re -- "garde, Seigneur, et tends" l’o -- reil -- le_!
     "Dans les en" -- "fers, les morts ne" peu -- vent te lou -- er_;
     mais c’est "un cœur brisé par" la souf -- fran -- ce 
     "qui te rend" gloire et jus -- ti -- ce, Sei -- gneur.
   }
>>

\transpose g e
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "Jeudi"
          g8 d'\breve*1/8 d4 \breathe\allowBreak 
          d\breve*1/8 c8 d4 \breathe\allowBreak 
          c\breve*1/8 \allowBreak f \allowBreak ees8 [d c] d4 \bar"|"
          bes8 [c] d\breve*1/8 ees8 [d]\allowBreak d ([c bes]) a4 \breathe\allowBreak
          d,\breve*1/8 bes'4 a8 [a bes] g2 g\fermata\bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        d,\breve*1/8
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {%\override LyricText.X-offset = #center-on-vowel
     \set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Jeudi "}
     Ac -- "corde-nous, Sei" -- gneur, "au cœur de notre" e -- xil,
     "de rentrer en nous -" "mêmes, et con" -- naî -- tre ton Nom,
     et donne_- "nous un cœur qui s’ouvre à" ta pré -- sen -- ce,
     "et qui cé" -- lè -- bre tes mer -- veil -- les_!
   }
>>

\transpose g e
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo \markup {\large "Vendredi"}
          g8 d'\breve*1/8 c8 d4 \breathe\allowBreak 
          c\breve*1/8 f ees8 [d c] d4 d\bar"|"
          bes8 [c] d\breve*1/8 ees8 [d]\allowBreak d ([c bes]) a4 \breathe\allowBreak
          d,\breve*1/8 bes'4 \breathe\allowBreak 
          bes8 bes [a] a [bes] g2 g\fermata\bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        d,\breve*1/8
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Vendredi "}
     Fais_- "nous revenir," Sei -- gneur, "sur la" "terre que tu as don" -- née à nos pè -- res_;
     é -- ta -- "blis sur nous une alliance " é -- ter -- nel -- le_:
     "Tu seras notre" Dieu, et nous se -- rons ton peu -- ple_!
   }
>>

\transpose g e {
  << \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "soprano"
        { \voiceOne \relative c''
          { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "Samedi"
            g8 d'\breve*1/8 c8 d4 \breathe\allowBreak 
            c\breve*1/8 f4 f8 f\breve*1/8 ees8 [ees]\allowBreak d [c] d4 \bar"|"
            bes8 [c] d\breve*1/8 ees8 [d]\allowBreak d ([c bes]) a4 \breathe\allowBreak
            d,\breve*1/8 bes'\breve*1/8 a8 [a bes] g2\fermata\bar "|."
          }
        }
        \new Voice = "alto"
        { \voiceTwo \relative c''
          d,\breve*1/8
        }
     >>
     \new Lyrics \lyricsto "soprano" 
     {
       \set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Samedi "}
       É -- "coute, Seigneur, et prends" pi -- tié,
       "mets sur nos" lè -- vres "la lou" -- an -- ge de ton Nom_!
       Ne te "souviens pas des fautes " de nos pè -- res, 
       "mais de ton a" -- "mour et de ta ten" -- dres -- se pour nous_!
     }
  >>
}

\transpose g e
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "Doxologie"
          g8 d'\breve*1/8 c8 d4 \breathe\allowBreak 
          c\breve*1/8 f4 ees8 [d c] d4\bar"|"
          bes8 [c] d\breve*1/8 ees8 [d]\allowBreak d [c bes] a4 \breathe\allowBreak
          d,\breve*1/8 bes'4 bes8 [a]\allowBreak a [bes] g2\fermata\bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        d,\breve*1/8
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Doxologie "}
     Ô "Père des misé" -- ri -- cordes, "Dieu de ten" -- dresse et de par -- don,
     con -- ver -- "tis notre cœur" par la Croix de ton Fils,
     "et par la" for -- ce de ton Es -- prit_!
   }
>>