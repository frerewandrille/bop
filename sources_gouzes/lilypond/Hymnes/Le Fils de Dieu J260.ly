\version "2.24.0"
% 
% \paper {
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 21)
% 
% \header {
%   title = \markup \center-column { "Le Fils de Dieu" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
% }

% \layout {
%   indent = #0
%   \context {
%     \Score \remove "Bar_number_engraver"
%   }
%   \context {
%     \Lyrics
%     \override LyricText.font-size = #2
%     \override LyricSpace.minimum-distance = #1
%   } 
% }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key g \major
  \time 3/4
}

resp = { \breathe\allowBreak }

sopMusic = \relative c'' {
  \partial4 
  g4 b2 c4 d2 c4 b2 a4 b2\resp b4 b2 a4 c2 a4 g2 (fis4) g2 \resp
  g4 b2 c4 d2 c4 b2 a4 b2\resp b4 b2 a4 c2 a4 g2 (fis4) g2 \resp
  g4 g2 a4 c2 b4 a2 g4 a2 \resp a4 b2 c4 d2 c4 b2 a4 b2 \resp
  g4 a2 c4 b2 a4 g2 fis4 g2
  \fermata \bar ":|."
}

altoMusic = \relative c'' {
  \partial4 
  g4 g2 g4 a2 a4 g2 fis4 g2 d4 g2 fis4 e2 e4 d2. b2
  g'4 g2 g4 a2 a4 g2 fis4 g2 d4 g2 fis4 e2 e4 d2. b2
  d4 e2 fis4 a2 f4 e2 e4 e2 fis4 g2 g4 a2 a4 g2 e4 fis2
  e4 fis2 e4 e2 e4 d2 d4 b2
}

tenorMusic = \relative c' {
  \partial4 
  b4 d2 e4 fis2 e4 d2 d4 d2 g,4 d'2 d4 c2 c4 b (a2) g
  b4 d2 e4 fis2 e4 d2 d4 d2 g,4 d'2 d4 c2 c4 b (a2) g
  b4 b2 d4 e2 d4 d (c) b c2 d4 d2 e4 fis2 e4 e2 e4 dis2
  b4 d!2 c4 g2 c4 b 
  \override BalloonText.annotation-balloon = ##f
  <a \balloonText #'(1.5 . 3)\markup { "" } >2
  g
}

bassMusic = \relative c' {
  \partial4 
  g4 g (fis) e d2 a4 b (c) d g,2 \resp g'4 b, (c) d a2 c4 d2. g,2 \resp
  g'4 g (fis) e d2 a4 b (c) d g,2 \resp g'4 b, (c) d a2 c4 d2. g,2 \resp
  g'4 e2 d4 a2 d4 e2 e4 a,2 \resp d4 g (fis) e d2 a4 e' (d) c b2 \resp
  e4 d2 a4 e'2 c4 d2 d4 g,2
  \fermata
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Le Fils de Dieu, le Bien_- Ai -- mé, 
  s’est fait sem -- blable aux hom -- mes.
  Tou -- te jus -- tice est ac -- com -- plie 
  par sa ve -- nue au mon -- de.
  \set shortVocalName = "" \set stanza = #"   1-4. "
  \override Lyrics.LyricText.font-series = #'bold
  Voi -- ci mon Fils_: É -- cou -- tez_- le_!
  Sur lui re -- po -- se mon Es -- prit. En lui de -- meu -- re mon a -- mour.
}

altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Ce -- lui qui n’a ja -- mais pé -- ché vient vers Jean le Bap -- tis -- te.
  L’A -- gneau nous mon -- tre le che -- min vers la vie vé -- ri -- ta -- ble.
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Il ouvre aux hom -- mes le che -- min de sa mi -- sé -- ri -- cor -- de_:
  Naî -- tre de l’eau et de l’Es -- prit pour goû -- ter le Roy -- au -- me.
}

altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  J’ai vu les cieux se dé -- chi -- rer, l’Es -- prit de Dieu des -- cen -- dre_;
  pour la nou -- vel -- le cré -- a -- tion, ou -- vrir sur l’eau ses ai -- les.
}

altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  L’Es -- prit de lu -- mière et de paix, l’Es -- prit d’in -- tel -- li -- gence, 
  l’Es -- prit de force et de conseil, de joie et de sa -- gesse.
}

altoWordssix = \lyricmode {  
  \set shortVocalName = "6." \set stanza = #"6. "
  L’Es -- prit de lu -- mière et de paix, l’Es -- prit d’in -- tel -- li -- gence, 
  l’Es -- prit de force et de conseil, de joie et de sa -- gesse.
}

altoWordssept = \lyricmode {  
  \set stanza = #"4. "
  Gloire à toi, no -- tre Pè -- re, qui nous at -- tires à toi,
  \set stanza = #"4. "
  Fais_- nous gran -- dir sans ces -- se dans l’a -- mour de ton Fils,
}

altoWordshuit = \lyricmode {  %\set stanza = #". "
  Pour vivre en ta lu -- miè -- re la joie des fils de Dieu.
  %\set stanza = #". "
  Et re -- cher -- cher ta fa -- ce, gui -- dés par ton Es -- prit.
}

\new ChoirStaff 
<<
  \new Staff = "women" <<
    \new Voice = "sopranos" {
      \voiceOne
      << \global \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordsquatre
  
  \new Staff = "men" <<
    \clef bass
    \new Voice = "tenors" \with { \consists "Balloon_engraver" } {
      \voiceOne
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo 
      << \global \bassMusic >>
    }
  >>
>>


%{
convert-ly (GNU LilyPond) 2.20.0  convert-ly: Traitement de «  »...
Conversion en cours : 2.19.2, 2.19.7, 2.19.11, 2.19.16, 2.19.22,
2.19.24, 2.19.28, 2.19.29, 2.19.32, 2.19.40, 2.19.46, 2.19.49,
2.19.80, 2.20.0
%}
