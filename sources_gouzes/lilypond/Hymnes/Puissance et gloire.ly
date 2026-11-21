\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   top-margin = 15
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 17)
% 
% \layout { 
%   indent = #0
%   \context { \Score \remove "Bar_number_engraver"
%   }
%   \context { \Lyrics \override LyricText.font-size = #2.5
%   }
% }
% 
% \header {
%   title = \markup \center-column { "Heureux les pauvres" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
%   tagline = ##f
% }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key e \major
  \time 3/4
}

silN = { \oneVoice r4 \voiceOne }

sopMusic = \relative c' {
  \partial4 e4 gis2 gis4 fis2 fis4 gis2 gis4 e2 \breathe\allowBreak
  gis4 b2 b4 cis2 cis4 gis2.~gis4 \silN \breathe\allowBreak
  b4 cis2 cis4 dis2 dis4 b2 b4 gis2 \breathe\allowBreak
  gis4 e2 e4 fis2 fis4 gis2.~gis2\bar "|."
}

altoMusic = \relative c' {
  \partial4 e4 e2 e4 dis2 dis4 e2 e4 cis2 cis4 dis2 dis4 b2 b4 e2.~e4 s
  gis a2 gis4 fis2 fis4  gis2 fis4 e2 dis4 cis2 cis4 b2 b4 e2.~e2
}


altoWordsun = \lyricmode {  
  \set shortVocalName = "1."\set stanza = #"1."
  Puis -- sance et gloi -- re de l’Es -- prit_: 
  Heu -- reux les vrais mar -- tyrs_!
  La chair dont Dieu les a pé -- tris 
  En lui pour -- ra sur -- gir.
}
altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2."\set stanza = #"2."
  Pa -- reils aux grains qui sont bro -- yés 
  Pour ê -- tre no -- tre pain, 
  Leur corps se joint au corps bri -- sé 
  Qui s’of -- fre par nos mains.
}
altoWordstrois = \lyricmode {  
  \set shortVocalName = "3."\set stanza = #"3."
  Leur sang se mêle au sang sau -- veur 
  Qui la -- ve nos pé -- chés.
  Ils sont l’a -- mour du mê -- me cœur 
  Qui nous a tant ai -- més.
}
altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4."
  Heu -- reux qui don -- ne sans comp -- ter 
  Jus -- qu’à sa pro -- pre chair_!
  Il trouve en Dieu sa li -- ber -- té, 
  Vi -- sa -- ge dé -- cou -- vert.
}
altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5."
  La chair est vai -- ne sans l'Es -- prit
  Et cen -- dre dans la mort.
  Par vo -- tre croix, Sei -- gneur, sur -- vit
  La gloi -- re de nos corps.
}
altoWordssix = \lyricmode {  
  \set shortVocalName = "6." \set stanza = #"6."
  Dans vos mar -- tyrs, c’est vous qu’on tue, 
  Mais vous qu’on glo -- ri -- fie,
  Car votre É -- glise en eux sa -- lue 
  La for -- ce de l’Es -- prit.
}
altoWordssept = \lyricmode {  
  \set shortVocalName = "7." \set stanza = #"7."
  Le grain sur -- vit dans la mois -- son,
  Au jour de vo -- tre Jour_;
  La vie, la mort n'ont plus de nom
  Au rè -- gne de l'A -- mour. 
}


\score {
  \new ChoirStaff 
  <<
    \new Staff = "women" \with { \remove "Time_signature_engraver" }
    <<
      \new Voice = "sopranos" {
        \voiceOne
        \global \sopMusic
      }
      \new Voice = "altos" {
        \voiceTwo
        \global \altoMusic
      }
    >>
    
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics \with {\override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = 4 }
    \lyricsto "sopranos" \altoWordsquatre
    \new Lyrics \lyricsto "sopranos" \altoWordscinq
    \new Lyrics \lyricsto "sopranos" \altoWordssix
    \new Lyrics \lyricsto "sopranos" \altoWordssept
  >>
}