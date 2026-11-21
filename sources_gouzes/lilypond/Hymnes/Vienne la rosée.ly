\version "2.24.0"
% 
% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter svp"
% }
% 
% \header {
%   title = \markup \center-column { "Vienne la rosée" }
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
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key f \major
  \time 4/4
}

resp = { \breathe\allowBreak }

sopMusic = \relative c' {
  d4 e f g a2 a4 g a2 a
  a4 a bes c bes2 a4 g a2 r \bar":|."
  a4 a d a g2. f4 d (f a f) e2 r
  a4 a c a g2 e4 f d1
  \bar "|."
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Vien -- ne la ro -- sée sur la ter -- re,
  Nais -- se l’es -- pé -- rance en nos cœurs,
}

altoWordsdeux = \lyricmode {  
  Bril -- le dans la nuit la lu -- miè -- re_:
  Bien -- tôt va ger -- mer le Sau -- veur.
  \set shortVocalName = "1."
  Au dé -- sert un cri s’é -- lè -- ve_:
  Pré -- pa -- rez les voies du Sei -- gneur.
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Ber -- ger d’Is -- ra -- ël, tends l’o -- reil -- le,
  Des -- cends vite à no -- tre se -- cours,
}

altoWordsquatre = \lyricmode {  
  Et nos yeux ver -- ront tes mer -- veil -- les,
  Nos voix chan -- te -- ront ton a -- mour.
  \set shortVocalName = "2." 
  Fil -- le de Si -- on, tres -- sail -- le_:
  Le Sei -- gneur dé -- jà vient vers toi.
}

altoWordscinq = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Ré -- veille, ô Sei -- gneur, ta vail -- lan -- ce,
  É -- ta -- blis ton rè -- gne de Paix.
}

altoWordssix = \lyricmode {  
  Que les peu -- ples voient ta puis -- san -- ce,
  Ac -- cla -- ment ton Nom à ja -- mais.
  \set shortVocalName = "3." 
  L’u -- ni -- vers at -- tend ta gloi -- re
  Et nous pré -- pa -- rons ton re -- tour.
}

\new Staff = "women" %\with {\remove Time_signature_engraver }
<<
  \new Voice = "sopranos" {
    << \global \sopMusic >>
  }
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics \lyricsto "sopranos" \altoWordssix
>>