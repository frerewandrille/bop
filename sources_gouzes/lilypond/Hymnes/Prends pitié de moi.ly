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
% #(set-global-staff-size 13)
% 
% \header {
%   title = \markup \center-column { "Prends pitié de moi" }
%   subtitle = " "
%   poet = ""
%   composer = ""
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
    \override InstrumentName.X-offset = 0.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = { \key a \minor \time 4/4 }
resp = { \breathe }

sopMusic = \relative c' {
  e4^\p e f f e e d d g g f f e1
  g4 g a a b b c c a a a gis a1
  d4^\mf d b b c c a a g g f f e1
  e4^\pp e d d c d e e g g f f e1
  b'4^\f c d2 \time 3/4 c4 (b) a g2 f4 \time 4/4 e2 
  d4^\p e f2 e4 d c1
  \bar"|."
}

altoMusic = \relative c' {
  c4 c c c c c b b b b d d c1
  e4 e f f f f e e f f e e e1
  a4 a g g g g f f d d d d cis1
  c!4 c b b a b c c d d d d b1
  e4 e f2 e f4 e (d) d c2 
  a4 c c2 c4 b c1
}

tenorMusic = \relative c' {
  g4 g a a g g g g g g a b g1
  c4 c c c d d c c c d c b c1
  d4 d d d c c c c b b a a a1
  g4 g g g e g g g g g a a gis1
  gis4 a a2 a4 (b) c c (b) b g2 
  f4 g f2 g4 g8 (f) e1
}

bassMusic = \relative c {
  c4 c f f c c g g'8 (f) e4 e d g, c1
  c4 c f f8 (e) d4 d a' a8 (g) f4 d e e a1
  f4 f g g8 (f) e4 e f f g g d d a1
  c4 c g g a g c c b b d d e1
  e4 a, d2 a'4 (g) f c (g') g, c2
  d4 c a2 g4 g c1
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. "\set shortVocalName = "1." 
  Prends pi -- tié de moi, Sei -- gneur, é -- cou -- te ta bon -- té,
  et que ta mi -- sé -- ri -- corde ef -- fa -- ce mon pé -- ché.
  La -- ve_- moi de la souil -- lu -- re qui sa -- lit mon cœur.
  Crée en moi une â -- me pu -- re qui te fasse hon -- neur.
  \set stanza = #"   Ref. "\set shortVocalName = "" 
  Ô mon Dieu,
  prends pi -- tié de moi_: J’ai pé -- ché con --  tre toi.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "\set shortVocalName = "2." 
  Ne re -- ti -- re pas de moi l’Es -- prit de sain -- te -- té_!
  Sau -- ve_- moi de mon or -- gueil et prends ma li -- ber -- té.
  Si j’a -- pai -- se ta jus -- ti -- ce par un cœur bri -- sé,
  tu ver -- ras mon sa -- cri -- fi -- ce sans le mé -- pri -- ser.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. "\set shortVocalName = "3." 
  Fais re -- naître en moi, Sei -- gneur, la joie de ton sa -- lut,
  et fais_- moi pour ton a -- mour ai -- mer de plus en plus.
  Que je por -- te té -- moi -- gna -- ge de ta sain -- te -- té,
  et vien -- dront te rendre hom -- ma -- ge tous les é -- ga -- rés.
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
 
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "sopranos" \altoWordstrois
 
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