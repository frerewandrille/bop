\version "2.24.0"
% 
% \paper {
%   #(set-paper-size "a5" ’landscape)
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 18)
% 
% \header {
%   title = \markup \center-column { "L’heure s’avance" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
% }
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
%   } 
% }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 0.25
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = { \key e \minor \time 2/2 }

resp = { \breathe }

sopMusic = \relative c'' {
  g2 g4 a \time 3/2 b2 b4 c2 c4 \time 2/2 b2 a\resp
  \time 3/2  b c4 b a g \time 2/2  fis2 g a \oneVoice r \voiceOne
  d c4 b \time 3/2  a2 fis g4 fis \time 2/2 e2 d\resp
  \time 3/2 b' c4 b a g \time 2/2 b2 a g\fermata \bar"|."
}

altoMusic = \relative c' {
  d2 e4 fis g2 g4 g2 g4 g2 fis 
  g2 g4 g fis e d2 e fis s
  g2 e4 g fis2 d e4 d d (cis) d2 
  g g4 g fis e fis (g) g (fis) g2
}

tenorMusic = \relative c' {
  b2 b4 d d2 d4 e2 e4 d2 d 
  d e4 d d b b2 b d \oneVoice r \voiceOne 
  b g4 d' d2 a c4 a a2 a 
  d e4 d d b d2 d d
}

bassMusic = \relative c' {
  g2 e4 d g2 g4 c,2 c4 g'2 d \resp
  g c,4 g' d e b2 e d s
  g, c4 g d'2 d c4 d a2 d\resp
  g c,4 g' d e b2 d g,\fermata
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "\set shortVocalName = "1." 
  L’heu -- re s’a -- van -- ce_: Fais_- nous grâ -- ce,
  toi dont le jour n’a pas de fin.
  Reste a -- vec nous, quand tout s’ef -- fa -- ce,
  Dieu des lu -- miè -- res sans dé -- clin.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. "\set shortVocalName = "2." 
  Tu sais toi_- même où sont nos pei -- nes_:
  Porte au Roy -- au -- me nos tra -- vaux.
  Sans toi, notre œu -- vre se -- rait vai -- ne.
  Viens pré -- pa -- rer les temps nou -- veaux.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3." 
  Comme un veil -- leur at -- tend l’au -- ro -- re,
  nous ap -- pe -- lons le jour pro -- mis.
  Mais si la nuit de -- meure en -- co -- re,
  tiens_- nous dé -- jà pour tes a -- mis.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4." 
  Dieu qui sans ces -- se nous en -- fan -- tes,
  à toi ces der -- niers mots du jour.
  L’Es -- prit du Christ en nous les chan -- te
  et les con -- fie à ton a -- mour.
}

\score {
  \new ChoirStaff <<
    \new Staff = "women" \with {\remove Time_signature_engraver }
    <<
      \new Voice = "sopranos" {
        \voiceOne
        << \global \sopMusic >>
      }
      \new Voice = "altos" {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>
    
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "sopranos" \altoWordsquatre
    
    \new Staff = "men" \with {\remove Time_signature_engraver }
    <<
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