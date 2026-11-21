\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

resp = { \breathe\allowBreak }

\layout { ragged-last = ##t }

\score {
  \new ChoirStaff
  << \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "soprano"
        { \voiceOne \relative c'
          { \clef "treble" \key bes \major \time 2/4 \cadenzaOn \tempo 4 = 120
            d4 f8 [g] bes4. bes8 d ([bes] c) [d] c2 
            \breathe\allowBreak d8 [d] d [d] c4. \breathe\allowBreak 
            g8^\markup{\italic élargir} bes ([a]) g [f] g2\fermata
            \bar "|."
          }\cadenzaOn \tonIIbf
        }
        \new Voice = "alto"
        { \voiceTwo \relative c'
          {
            d4 f8 [g] bes4. bes8 d ([bes] c) [g] a2 
            bes8 [bes] bes [bes] a4. d,8 ees4 d8 [d] d2
          }          
        }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
     \lyricsto soprano 
     { 
       Ce jour est saint pour no -- tre Dieu_:
       La joie du Sei -- gneur est no -- tre rem -- part_!
     }
     \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { \voiceOne \relative c
          { \clef "bass" \key bes \major \time 2/4\cadenzaOn
            d4 f8 [g] bes4. bes8 d ([bes] c) [d] f2 
            f8 [f] f [f] f4. bes,8 c4 bes8 [a] bes2
          }\cadenzaOn \tonIIbh
        }
        \new Voice = "basse"
        { \voiceTwo \relative c
          {
            d4 f8 [g] bes4. bes8 d ([bes] c) [bes] f2 \breathe
            bes,8 [bes] bes [bes] f'4. \breathe g8 c,4 d8 [d] g2\fermata
          }
        }
     >>
  >>
  \layout { ragged-last = ##t }
}

<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \relative c'
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn
          d8 f [g] bes\breve*1/16 d8 c4. (g8 bes4 a8 [f]) g2\resp
          d'\breve*1/16 c8 bes [d] c4. \allowBreak c8 c [g] a [bes] g2\bar"|"
          d8 f [g] g\breve*1/16 bes4 (a8 [f]) g2\resp
          c\breve*1/16  bes8 [a] bes4 (a8 [f]) g2
          \bar "|."
        }
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = "1."
     C’est toi, Sei -- "gneur, qui es" l’U -- ni -- que, 
     "c’est toi qui" as fait les cieux et tou -- te leur ar -- mée,
     la terre et "tout ce qu’elle" por -- te,
     "la mer et tout ce qui" vit en el -- le.
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \relative c'
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn
          d8 f [g] bes\breve*1/16 d8 c4 \allowBreak 
          c\breve*1/16 g8 bes4 (a8 [f]) g2\resp
          d'\breve*1/16 c8 bes [d] c4 \allowBreak 
          c8 [c] g [a bes] g2 g\bar"|"
          d8 f [g] g\breve*1/16 bes4 (a8 [f]) g2\resp
          c\breve*1/16 bes8 [a] bes4 a8 [f] g2
          \bar "|."
        }
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = "2."
     C’est toi, Sei -- "gneur, qui" es Dieu, "le Dieu de" nos pè -- res,
     "c’est toi" qui as choi -- si A -- bra -- ham, no -- tre pè -- re_;
     tu as trou -- "vé son cœur fidèle en ta pré" -- sen -- ce,
     "et tu as conclu" une al -- liance a -- vec lui.
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \relative c'
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn
          f8 [g] bes\breve*1/16 d8 c4. (g8 bes4 a8 [f] )g2\resp
          d'\breve*1/16 c8 bes [d] c4. \allowBreak 
          c8 g [a bes] g2\bar"|"
          d8 [f] g\breve*1/16 bes4 (a8 [f]) g2\resp
          c\breve*1/16 c4.\allowBreak 
          bes8 a [bes] a [f] g2
          \bar "|."
        }
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = "3."
     Tu as "vu la détresse de nos pères en" É -- gy -- pte, 
     "tu as en" -- ten -- du leur cri au bord de la mer_:
     de -- vant "eux, tu as ouvert l’a" -- bî -- me,
     "tu as jeté au fond des" eaux ceux qui les pour -- sui -- vaient.
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \relative c'
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn
          d8 f [g] bes\breve*1/16  d8 c4. \allowBreak 
          c\breve*1/16 g8 [bes] a [f] g2\resp
          d'\breve*1/16 c8 [bes d] c4 \allowBreak 
          c\breve*1/16 g8 [a bes] g2\bar"|"
          d8 [f] g\breve*1/16 bes4 a8 [f] g2\resp
          c\breve*1/16 bes8 [a] bes4 \allowBreak 
          bes\breve*1/16 a8 [f] g2
          \bar "|."
        }
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = "4."
     Par la co -- "lonne de" nu -- ée, "tu les gui" -- dais pen -- dant le jour,
     "et la nuit par une co" -- lon -- ne de feu,
    "pour éclai" -- rer leur che -- min.
     Tu est  "descendu sur le" mont Si -- na -- ï,
     "tu leur as don" -- né ta loi "et tes com" -- man -- de -- ments.
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \relative c'
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn
          d8 f [g] bes [d] c4 (g8) [bes] a [f] g4\resp
          d'\breve*1/16 c8 [bes d] c4 \allowBreak 
          c\breve*1/16  g8 [a bes] g2\bar"|"
          d8 [f] g\breve*1/16 bes4. \allowBreak 
          bes8 a [f] g2\resp
          c\breve*1/16 bes8 [a] bes4. \allowBreak bes8 a [f] g2
          \bar "|."
        }
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = "5."
     Nos pères ont re -- fu -- sé de t’o -- bé -- ir,
     "ils ont ou" -- blié les mer -- veil -- "les que tu a" -- vais ac -- com -- plies_;
     mais tu "es un Dieu de ten" -- dresse et de par -- don,
     "et tu ne" les as pas a -- ban -- don -- nés.
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \relative c'
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "Jeudi"
          f8 [g] bes\breve*1/16 d8 c4. (g8 bes4 a8 [f]) g2\resp
          d'8 d [c] bes [d] c4. \allowBreak 
          c8 g [a bes] g2\bar"|"
          d8 [f] g\breve*1/16  bes4. \allowBreak 
          bes8 a [f] g2\resp
          c\breve*1/32 c4 \allowBreak 
          c\breve*1/16 bes8 [a] bes4 a8 [f] g2
          \bar "|."
        }
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = "6."
     Tu leur "as donné un esprit de" sa -- ges -- se,
     et tu leur as four -- ni de l’eau pour leur soif_;
     qua -- rante "ans, tu pris soin" d’eux dans le dé -- sert,
     "et tu multiplias leurs" fils
      comme les é -- toi -- les du ciel.
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \relative c'
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn %\tempo "Jeudi"
          f8 [g] bes8 [d8] c4. (g8 bes) [bes] a8 [f] g2\resp
          d'8 d [c] bes [d] c4. g8 [(a) bes] g2\bar"|"
          d8 [f] g\breve*1/16  bes4. \allowBreak 
          a8 [f] g2\resp
          c\breve*1/16 bes8 [a] bes4 a8 [f] g2
          \bar "|."
        }
      }
   >>
   \new Lyrics \lyricsto "soprano" 
   {
     \set stanza = "6."
     Ren -- dons gloire au Pè -- re tout_- puis -- sant,
     à son Fils Jé -- sus_- Christ, le Sei -- gneur,
     à l’Es -- "prit qui ha" -- bite en nos cœurs,
     "pour les siè" -- cles des siè -- cles. A -- men
   }
>>