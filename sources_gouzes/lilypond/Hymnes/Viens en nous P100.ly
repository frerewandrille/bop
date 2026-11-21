\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   %system-system-spacing #'basic-distance = #17
%   top-margin = 10
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   print-page-number = ##f
%   ragged-last-bottom = ##t
%   ragged-last = ##t
% }
% 
% #(set-global-staff-size 15)
% 
% \layout {
%   indent = #0
%   \context {
%     \Score \remove "Bar_number_engraver"
%   }
%   \context {
%     \Lyrics
%     \override LyricText.font-size = #2
%     \override LyricSpace.minimum-distance = #1
%     \consists "Bar_engraver"
%     \consists "Separating_line_group_engraver"
%     \hide BarLine
%   } 
% }
% 
% \header {
%   title = \markup \center-column { "Viens en nous" }
%   subtitle = ""
%   poet = ""
%   composer =  ""
%   tagline = "Ne pas emporter ni plier, svp"
% } 
% 
% \markup{ \vspace #1 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 3
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

gauche = { \once \override LyricText.self-alignment-X = #LEFT }
armure = { \key a \minor \time 6/4 }
resp = { \breathe }
im = \set ignoreMelismata = ##t

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   <<
     \new Voice = "chant"
     { \relative c'
       { \clef "treble" \armure %\tempo  2. = 50
         \tieDashed\slurDashed
         \revert Staff.TimeSignature.style \numericTimeSignature
         \bar ".|:-|"c2 d4 e2 f4 e d c d2~ d4\resp
         f2 g4 a2 bes4 a8 (g f4) g a2.\resp
         c,2 d4 f2 g4 \once \slurSolid f8 (e d4) c d2 d4\bar ":|.:"
         a'2 c4 d2 d4 c (b) c d2.\resp
         c2 a4 c (b) g f e d c2.\resp
         g'2 f4 g (a) g f8 (e) d4 c d2.\bar ":|.:"
         d'2 d4 c (b) c \once \slurSolid d (c) b a2 a4\resp
         f2 d4 c2 d4 f2 g4 f2~ f4\resp
         g4 (a) bes a2 g4 \once \slurSolid f8 (e d4) c d2.\bar ":|.:"
         \pageBreak a'2 c4 b a b c b a g2.\resp
         a2 a4 f e f g f e d2.\resp
         e2 g4 a2 g4 c2 b4 a2.\bar ":|.:"
         d2 d4 g,2 a4 c2 b4 a2.\resp
         a2 bes4 \slurSolid a (g) a f2 g4 f2.\resp
         e2 g4 a2 d,4 f2 e4 d2.\bar ":|."
         \break d4 (e d) c2 (d4) \time 4/4 c4 f e (d) d2
         \bar "|."
       }
     }   
   >>
   \new Lyrics \lyricsto chant
   {   \set stanza = "1."%\set shortVocalName = "1."
     \im Viens en nous, Es -- prit du Sei -- \gauche gneur, __ \skip4
     com -- ble_- nous de \gauche ton __ \skip4\skip4 a -- mour,
     com -- ble_- nous de ta \skip4 \skip4 lu -- miè -- re_!_
     \set stanza = "3."%\set shortVocalName = "3."
     Toi qui es le \gauche Pa __ -- \skip4 ra -- clet,
     toi qui vis dans le cœur des croy -- ants,
     don -- ne_- nous la fraî -- \gauche cheur __ \skip4 du re -- pos_!_
     \set stanza = "5."%\set shortVocalName = "5."
     Ô lu -- miè -- re de vrai \skip4 bon -- \gauche heur, __\skip4 
     viens bril -- ler au fond du \gauche cœur __\skip4 
     de ceux qui croient en toi, \skip4 \skip4 Sei -- gneur_!_
     \set stanza = "7."%\set shortVocalName = "7."
     Pu -- ri -- fie ce qui est du pé -- ché,
     vi -- vi -- fie ce qui est des -- sé -- ché, 
     viens gué -- rir nos cœurs bles -- sés_!_
     \set stanza = "9."%\set shortVocalName = "9."
     Donne à ceux qui croient en toi,
     dont l’es -- poir \skip4 re -- pose en toi,
     l’a -- bon -- dan -- ce de ta joie_!_
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto chant
   { \set stanza = "2."%\set shortVocalName = "2."
     \im Toi qui es le Pè -- re des pau -- vres,
     toi qui es la sour -- ce de tout don,
     pour nos cœurs, la vraie \skip4 \skip4 lu -- miè -- re_!_
     \set stanza = "4."%\set shortVocalName = "4."
     Dans la pei -- ne, viens a -- pai -- ser,
     dans l’é -- \gauche preu __ -- \skip4 ve, ré -- con -- for -- ter,
     dans les \gauche lar -- __ \skip4 mes, viens nous con -- so -- ler.
     \set stanza = "6."%\set shortVocalName = "6."
     Sans le \gauche don __ \skip4 de ta \skip4 pré -- sen -- ce,
     rien en l’hom -- me qui sub -- sis -- te,
     \gauche rien __ \skip4 qui tien -- ne de -- \skip4 \skip4 vant toi.
     \set stanza = "8."%\set shortVocalName = "8."
     As -- sou -- plis ce qui s’est en -- dur -- ci,
     don -- ne feu à ce qui est sans vie,
     gui -- de_- nous dans no -- tre nuit_!_
     \set stanza = "10."%\set shortVocalName = "10."
     Fais_- nous vi -- vre dans ta loi,
     con -- duis_- nous \skip4 au -- près de toi
     où la joie ne fi -- nit pas_!_
     A -- \skip4 \skip4 men, \skip4 al -- lé -- lu -- \skip4 ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "basse"
   { \relative c'
     { \clef "bass" \armure
       \tieDashed\slurDashed \numericTimeSignature
       a2 f4 e2 d4 c d e d2~ d4\resp
       d2 c4 a2 g4 c8 (e d4) e f2.\resp
       e2 d4 d2 c4 \once \slurSolid d8 (e f4) e d2 d4
       d2 a'4 f2 g4 a (g) a d,2.\resp
       e2 f4 e (d) e d e f e2.\resp
       c2 d4 c (e) d d8 (e) f4 e d2.
       f2 g4 a (g) e \once \slurSolid d (e) g a2 a4\resp
       a2 g4 a2 f4 d2 c4 a2~ a4\resp
       c4~ c d f2 g4 \once \slurSolid a8 (g f4) e d2.
       f2 e4 d f g a e f g2.\resp
       c,2 c4 d c a g a c d2.\resp
       c2 e4 c'2 b4 a2 e4 a2.
       f2 d4 e2 f4 e2 g4 a2.\resp
       f2 d4 \slurSolid c (e) f a2 bes4 a2.\resp
       c,2 e4 f2 g4 d2 c4 d2.
       d4 (c a) f' (e d) e d g2 a
     }
   }
>>