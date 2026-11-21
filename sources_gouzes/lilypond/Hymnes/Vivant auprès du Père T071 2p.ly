\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 9
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   print-page-number = ##f
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 14)
% 
% \layout {
%   indent = #0
%   \context {
%     \Score \remove "Bar_number_engraver"
%   }
% }
% 
% \header {
%   title = \markup \center-column { "Vivant auprès du Père" }
%   subtitle = ""
%   poet = ""
%   composer =  ""
% } 
% 
% \markup{ \vspace #0.75 }
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
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}


resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

global = {
  \key ees \major
  \time 3/4
}

sopMusic = \relative c' { \tieDashed
  c2 (d4) ees2 f4 g2 c4 b2 b4 c2 (d4) ees2 g,4 f2 f4 ees2.
  c2 d4 ees2 f4 g2 c4 b2. c2 (d4) ees2 g,4 f2 f4 ees2 ees4
  f2 f4 g2 bes4 aes2 f4 g2. bes2 bes4 c2 ees4 d (c) b 
  c2~ c4
  f,2 f4 g2 bes4 aes2 f4 g2. bes2 bes4 c2 ees4 d (c) b 
  c2.~ c
  \bar "|."
}

altoMusic = \relative c' {\tieDashed
  c2 (b4) c2 d4 ees2 ees4 g2 g4 ees2 (f4) g (f) ees c2 d4 ees2.
  c2 b4 c2 d4 ees2 ees4 g2. ees2 (f4) g (f) ees c2 d4 ees2 ees4
  d4 (c) bes ees2 d4 f (ees) d ees2. d2 ees4 ees2 g4 f (ees) d 
  ees2~ ees4
  d4 (c) bes ees2 d4 f (ees) d ees2. d2 ees4 ees2 g4 f (ees) d 
  ees2.~ ees
}

tenorMusic = \relative c {\tieDashed
  ees2 (g4) g2 bes4 bes2 c4 d2 d4 c (bes aes) g2 g4 aes (g) f g2.
  ees2 g4 g2 bes4 bes2 c4 d2. c4 (bes aes) g2 g4 aes (g) f g2 g4
  f2 bes4 bes2 bes4 c2 bes4 bes2. bes2 g4 aes2 bes4 aes (g) g 
  g2~ g4
  f2 bes4 bes2 bes4 c2 bes4 bes2. bes2 g4 aes2 bes4 aes (g) g 
  g2.~ g
}

bassMusic = \relative c {\tieDashed
  c2 (g4) c2 bes4 ees (d) c g'2 g4 aes (g f) ees2 c4 aes2 bes4 ees2.
  c2 g4 c2 bes4 ees (d) c g'2. aes4 (g f) ees2 c4 aes2 bes4 ees2 ees4
  bes4 (c) d ees2 g4 f2 bes,4 ees2 (f4) g2 ees4 aes2 ees4 f (g) g, 
  c2~ c4
  bes4 (c) d ees2 g4 f2 bes,4 ees2 (f4) g2 ees4 aes2 ees4 f (g) g, 
  c2.~ c
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "
  \set shortVocalName = "1."
  Vi -- vant au -- près du Pè -- re, 
  Jé -- sus res -- sus -- ci -- té,
  Tu as -- sis -- tes cha -- que jour 
  l’É -- gli -- se ton é -- pou -- se.
  Par les té -- moins de ta vie, 
  tu di -- ri -- ges le trou -- peau.  __
  Bien -- heu -- reux le peu -- ple saint, 
  dont le Sei -- gneur est le Dieu. __
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. "\set shortVocalName = "2."
  Mer -- veil -- le de ta grâ -- ce, 
  lou -- ange à toi Sei -- gneur_!
  Tu con -- fies à des pé -- cheurs 
  l’an -- non -- ce du Roy -- au -- me.
  Bap -- ti -- sés dans ton Es -- prit, 
  ils parlent en toute as -- su -- 
  %\set melismaBusyProperties = #'() 
  \im ran -- ce.\imstop
  %\unset melismaBusyProperties
  Voi -- ci qu’ils sont de -- ve -- nus 
  les fon -- de -- ments de l’É -- \im gli -- se. 
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Nour -- ris de ta pa -- ro -- le, brû -- lants de ton a -- mour,
  Ils ap -- por -- tent ton sa -- lut à ceux qui les é -- cou -- tent. 
  Ton ap -- pel les a lan -- cés sur les che -- mins de la \im ter -- re. \imstop
  Ils ont mar -- ché sur tes pas, toi la rou -- te vers le \im Pè -- re. 
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  La cha -- ri -- té les brû -- le, c’est l’ar -- me de l’Es -- prit.
  Et ta Croix, ô Jé -- sus Christ 
  dé -- truit les for -- te -- res -- ses.
  Leur pa -- role a re -- ten -- ti, 
  qui nous don -- ne le par -- don. __
  Et tout ce qu’ils ont re -- mis 
  l’est pour tou -- jours dans le ciel. __
}

altoWordscinq = \lyricmode {  
  \set stanza = #"5. "\set shortVocalName = "5."
  Dans la ci -- té nou -- vel -- le, a -- pô -- tres du Sei -- gneur,
  Im -- plo -- rez pour nous Jé -- sus 
  qui vous con -- fie l’É -- gli -- se_:
  Que nous sa -- chions tout quit -- ter 
  pour ré -- pan -- dre l’É -- van -- \im gi -- le_!\imstop
  Que l’Es -- prit de son a -- mour, 
  de nos cœurs, chas -- se la \im crain -- te.
}

altoWordssix = \lyricmode {  
  \set stanza = #"6. " \set shortVocalName = "6."
  Bé -- ni sois_- tu, ô Pè -- re, Sei -- gneur de l’u -- ni -- vers,
  Ton mys -- tère est i -- gno -- ré des sages et des ha -- bi -- les.
  Mais tu veux le ré -- lé -- ver aux pauvres et aux tout pe -- tits, __
  Par le Fils et dans l’Es -- prit, pour les siè -- \skip4 cles sans fin_! __
  A -- men_!
}

\transpose c b,
\new ChoirStaff 
<<
  \new Staff = "women" \with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne 
      << \global \sopMusic >>
    }
    \new Voice = "altos" \with { \consists "Balloon_engraver" }
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "sopranos" \altoWordstrois
%  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
%  \new Lyrics \lyricsto "sopranos" \altoWordscinq
%  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
%   \lyricsto "sopranos" \altoWordssix
   
  \new Staff = "men" \with {\remove Time_signature_engraver }
  <<
    \clef bass
    \new Voice = "tenors" \with { \consists "Balloon_engraver" }
    {
      \voiceOne 
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>

\transpose c b,
\new ChoirStaff 
<<
  \new Staff = "women" \with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne 
      << \global \sopMusic >> \relative c'' { c2. c } \bar "|." 
    }
    \new Voice = "altos" \with { \consists "Balloon_engraver" }
    {
      \voiceTwo
      << \global \altoMusic >> \relative c' { f2. e }
    }
  >>
%   \new Lyrics \lyricsto "sopranos" \altoWordsun
%   \new Lyrics \lyricsto "sopranos" \altoWordsdeux
%   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
%    \lyricsto "sopranos" \altoWordstrois
 \new Lyrics \lyricsto "sopranos" \altoWordsquatre
 \new Lyrics \lyricsto "sopranos" \altoWordscinq
 \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordssix
   
  \new Staff = "men" \with {\remove Time_signature_engraver }
  <<
    \clef bass
    \new Voice = "tenors" \with { \consists "Balloon_engraver" }
    {
      \voiceOne 
      << \global \tenorMusic >> aes2. g 
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >> { f2. c } 
    }
  >>
>>