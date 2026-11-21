\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key g \minor \time 4/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }

\transpose bes g
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \tempo "Rapide"% 2. = 50
          \override Hairpin.to-barline = ##f
          bes4 bes ^\> bes a g1 g\! \silN bes4^\< bes c d1^\!
          bes4^\markup\italic"ritard. marqué" c bes a g2. \silN
          bes1\fermata^\f bes2. c4^\markup\italic"marqué"
          d -- d -- d-- d-- c2 bes4^\< bes a2-> bes-> c1\!-> ~
          c4 \silN g4^\mf a bes2 bes4 bes a (g) fis2~ fis4 \silN 
          g^\markup{\dynamic pp \italic"en écho"} a bes2 bes4 bes a (g) fis2~ fis4
          \silN bes2^\markup{\italic"vif et" \dynamic f}~ 
          bes4 bes bes c d1-> bes \silN 
          d4-- d-- d-- c2-- bes-- a-- bes-- c2.\fermata \silN
          \silN g4^\markup{\dynamic mf \italic"et retenu" } g a
          bes2 a4 g fis2. \silN
          g4^\markup{\dynamic pp \italic"en écho"} a bes2 a4 g fis2~ fis4
          \silN bes2^\markup{\italic"vif et" \dynamic f}~ 
          bes4 bes bes c d1 bes2.\fermata\silN
          \silN d4 \tuplet 3/2 { d4-> d d } d2-> d4 d c2 bes4 bes
          a2 bes4 bes c2. \silN
          bes1\fermata^\f bes\fermata \silN 
          d4^\markup\italic"ritard. maestoso" d d c2 bes4 bes a1 bes2 a g1\fermata
          \bar "|."
        }
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          f4 f f f d1 d s4 f f f f1 f4 f f f d2. s4 f1 f2.
          f4 f f f f f2 f4 f f2 f g1~ g4 s d f f2 f4 f f (d) d2~ d4
          s d f f2 f4 f f (d) d2~ d4 s f2~ f4 f f f bes1 f s4
          bes bes bes f2 f f f g2. s4 s d d f f2 f4 d d2. s4 
          d f f2 f4 d d2~ d4 s f2~ f4 f f f bes1 f2. s4
          s4 bes bes4*2/3 bes bes bes2 bes4 bes
          f2 f4 f f2 f4 f g2. s4 f1 f s4 bes bes bes f2 f4 f fis1 fis2 fis d1
        }          
      } 
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
      Le Sei -- gneur se lè -- ve_!
      Ses en -- ne -- mis se -- ront dis -- per -- sés_!
      Pâ -- que_!
      Nous cé -- lé -- brons ce jour saint et so -- len -- nel_:
      Pâ -- que sainte et nou -- vel -- le, paix de Dieu sur la ter -- re_!
      Pâ -- que de lu -- miè -- re,
      tu es le Christ li -- bé -- ra -- teur_!
      Tu nous ar -- raches à la mort,
      tu nous rends à la vie_!
      Pâ -- que d’al -- lé -- gres -- se_!
      Tu ou -- vres les por -- tes du ciel,
      il -- lu -- mi -- ne nos cœurs_!
      Pâ -- que_!
      Tu sanc -- ti -- fies l’u -- ni -- vers à ja -- mais_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure 
          d4 d d c bes1 bes \silN d4 d ees f1 d4 ees d c bes2.
          \silN d1 d2. ees4 f f f f ees2 d4 d c2 d ees1~ ees4 \silN
          bes4 c d2 d4 d c (bes) a2~ a4 \silN 
          bes c d2 d4 d c (bes) a2~ a4 \silN
          d2~ d4 d d ees f1 d \silN f4 f f ees2 d c d ees2. \silN
          \silN bes4 bes c d2 c4 bes a2. \silN
          bes4 c d2 c4 bes a2~ a4
          \silN d2~ d4 d d ees f1 d2. \silN
          \silN f4 f4*2/3 f f f2 f4 f ees2 d4 d 
          c2 d4 d ees2. \silN
          d1 d \silN f4 f f ees2 d4 d c1 d2 c bes1
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          bes4 bes bes f g1 g s4 bes bes bes bes1 
          bes4 a bes f g2. s4 bes1\fermata bes2.
          bes4 bes-- bes-- bes-- bes-- a2 bes4 bes f2-> d-> c1~->
          c4 s g' f bes2 bes4 bes f (g) d2~ d4 s
          g f bes2 bes4 bes f (g) d2~ d4 s
          bes'2~ bes4 bes bes bes bes1-> bes 
          s4 bes-- bes-- bes-- a2-- bes-- f-- d-- c2.\fermata s4
          s4 g' g f bes2 f4 g d2. s4 g f bes2 f4 g d2~ d4 
          s4 bes'2~ bes4 bes bes bes bes1 bes2.\fermata s4
          s bes \tuplet 3/2 { bes-> bes bes } bes2-> bes4 bes
           a2 bes4 bes f2 d4 d c2. s4 bes'1\fermata bes\fermata
           s4 bes bes bes a2 bes4 bes d,1 d2 d g1\fermata
        }
      }
   >>
>>