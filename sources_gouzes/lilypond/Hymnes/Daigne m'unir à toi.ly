\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 20
%   right-margin = 20
% }
% 
% % #(set-global-staff-size 15)
% 
% \layout { 
%   tagline = ##f
%   indent = #0
%   \context { \Score \remove "Bar_number_engraver"
%   }
%   \context { \Lyrics \override LyricText.font-size = #2.5
%     \override LyricSpace.minimum-distance = #1
%   }
% }
% 
% \header {
%   title = \markup \center-column { "Daigne m’unir à toi" }
%   subtitle = " "
%   poet = ""
%   composer = ""
%   tagline = ##f
% }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key f \minor
  \time 3/2
}

sopMusic = \relative c' { \tieDashed
  f2~ f g aes~ aes aes2 bes2 2 aes4 (g) f2 g ees f1~ f2 \breathe
  f1 g2 aes aes bes c1 c2 des1 c2 \once \slurDashed bes (aes) bes c1~ c2\breathe 
  f,2. <g \balloonText #'(-1.5 . -3)\markup { "" } >4
  aes2 bes1 aes2 g1. f2 (g) aes g g f e1~ e2 \breathe 
  g2. (aes4 bes2) aes1 g2 f1 
  <e \balloonText #'(-1.5 . -3)\markup { "" } >2 f1.\fermata \bar "|."
}

altoMusic = \relative c' { \tieDashed
  c2~ c e f (f) f2 f2 ees des c des c c1~ c2
  c1 ees2 ees ees des c1 f2 f1 ees2 \once \slurDashed  des (c) f e1~ e2
  c2 des ees f1 f2 ees1. c2 (des) ees ees ees c2 c1~ c2
  bes2. (c4 des2) ees1 ees2 c c1 c1.
}

tenorMusic = \relative c' { \tieDashed
  aes2~ aes c c~ c c2 des c bes aes bes g aes1~ aes2
  aes1 bes2 aes aes g aes1 aes2 aes1 aes2 \once \slurDashed  f (aes) f g1~ g2
  aes2 bes c des1 des2 bes1. aes2 (bes) c bes bes aes2 g1~ g2
  ees1 (f2) aes1 bes2 aes g1 aes1.
}

bassMusic = \relative c { \tieDashed
  f2~ f c f~ f f2 bes, c des c bes c f1~ f2\breathe
  f1 ees4 (des) c2 c bes aes1 f'4 (ees) des1 aes2 \phrasingSlurDashed des \(f4 (ees)\) des2 c1~ c2\breathe
  f2 des c bes2. (c4) des2 ees1. f4 (ees des2) c ees ees f2 c1~ c2\breathe
  ees1 (bes2) c1 ees2 f c1 f1.\fermata
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. " \set shortInstrumentName = "1." \set associatedVoice = #"altos"
  Dai2 -- gne m’u -- nir1 __ à2 toi,2 vi2 -- gne sainte et sa -- crée.1. __
  Et1 mon2 fai -- ble ra -- meau1 te2 don1 -- ne2 -- ra1 __ son2 fruit.1. __
  Et2 je pour -- rai1 t’of2 -- frir1. u1 -- ne2 grap -- pe do -- rée,1. __
  Sei1. -- gneur,1 dès2 au2 -- jour1 --\apostrophe d’hui.1.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "  \set shortInstrumentName = "2." \set associatedVoice = #"altos"
  Cet1 __ -- te2 grap -- pe d’a -- mour,2 dont les grains sont des â1 -- mes, 2
  Je1 n’ai2 pour la for -- mer1 que2 ce1 jour2 qui1 __ s’en2 -- fuit.1. __
  Ah_!2 don -- ne_- moi,1 Jé2 -- sus,1. d’un1 a2 -- pô -- tre, les flam1 -- mes,2
  Rien1. que1 pour2 au2 -- jour1 --\apostrophe d’hui.1.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. " \set shortInstrumentName = "3." \set associatedVoice = #"altos"
  Sei2 -- gneur, je veux1 __ te2 voir, sans voile et sans nu -- a1 -- ge,2
  Mais1 en2 -- core ex -- i -- lée1 je2 me1 lan2 -- guis loin de toi.1. __
  Qu’il2 ne me soit1 ca2 -- ché,1. ton1 ai2 -- ma -- ble vi -- sa1 -- ge,2
  Rien1. que1 pour2 au2 -- jour1 --\apostrophe d’hui.1.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. " \set shortInstrumentName = "4." \set associatedVoice = #"altos"
  Je2 vo2 -- le2 -- rai1 __ bien2 -- tôt2 pour2 chan2 -- ter2 tes2 lou2 -- an1 -- ges2
  Quand1 le2 jour sans cou -- chant1 lui2 -- ra1 sur2 ma1 __ pauvre2 â1 -- me.2
  A2 -- lors je chan1 -- te2 -- rai1. sur1 la2 ly -- re des an1 -- ges2
  L’é1. -- ter1 -- nel2 au2 -- jour1 --\apostrophe d’hui.1.
}

\score {
  \new ChoirStaff <<
    \new Staff = "women" <<
      \new Voice = "sopranos" 
      \with { \consists "Balloon_engraver" } \with { \override BalloonText.annotation-balloon = ##f }
      {
        \voiceOne
        << \global \sopMusic >>
      }
      \new Voice = "altos" {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>
 
    \new Lyrics \altoWordsun
    \new Lyrics \altoWordsdeux
    \new Lyrics \altoWordstrois
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \altoWordsquatre
 
    \new Staff = "men" <<
      \clef bass
      \new Voice = "tenors" {
        \voiceOne
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo << \global \bassMusic >>
      }
    >>
  >>
}