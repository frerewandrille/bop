\version "2.24.0"
\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% #(set-global-staff-size 14)
% 
% \header {
%   title = \markup \center-column { "Le Christ Jésus" }
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
    \override InstrumentName.X-offset = 2.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
  } 
}

global = {
  \key bes \major
  \time 3/2 
  \revert Staff.TimeSignature.style
}

resp = { \breathe\allowBreak }


sopMusic = \relative c'' {
  bes2 2 c d1 c2 bes1 a2 bes1. 2 2 2 c (bes) a g1 fis2 g1 \allowBreak
  a2 bes1 c2 d2. (ees4) f2 ees (d) c d1.\bar":|."\break
  2 2 2 c1 2 d (c) bes a1. 2 2 b c (bes) a g1 fis2 g1 \allowBreak
  a2 bes1 c2 d1 2 2 cis1 d1.
  \fermata \bar "|."
}

altoMusic = \relative c' {
  d4 (ees) f2 2 1 ees2 d 
  <c \balloonText #'(2 . -1)\markup { "" } >1 
  d1. ees2 f ees ees (d) c d (ees) d d1 
  2 1 f2 1 2 bes (a) g fis1.
  g2 f!4 (ees) f (g) a2 (f) g a1 g2 fis1.
  f!4 (g) f (ees) d2 c (d) ees d (ees) d d1
  fis2 g1 f2 1 e2 e fis (g) fis1.
}

tenorMusic = \relative c' {
  bes2 2 a2 2 (a) g f (g) f f1. g2 f g fis (g) a bes 
  <a \balloonText #'(2 . 2)\markup { "" } >1 bes
  fis2 g4 (a bes2) a bes1 c2 bes (d) ees a,1.
  bes2 2 2 c4 (bes c d) ees2 d1 2 1. 2 2 g, g1 fis2 g (c) a bes1
  d2 2 (ees) c bes1 2 a1 <a \balloonText #'(-2 . 2)\markup { "" } >2 1.
}

bassMusic = \relative c' {
  g2 d f bes,1 c2 d (ees) f bes,1. ees2 d ees a, (bes) c bes (c) d g,1
  d'2 g1 f2 bes1 a2 g (f) ees d1.
  g2 d bes f' (a) g fis1 g2 d1. d4 (c) d (ees) f2 ees (d) c bes (c) d g,1
  d'2 g1 a2 bes (a) g a1 a,2 d1.
  \fermata
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Le Christ Jé -- sus no -- tre Sau -- veur 
  s’est hu -- mi -- lié jus -- qu’à la mort,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!

}

altoWordsdeux = \lyricmode {  
  Ceux qui le sui -- vent dans la mort 
  par -- ta -- ge -- ront la vie de Dieu,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
  \set shortVocalName = "1."
  Heu -- reux les pau -- vres en es -- prit, 
  car le Roy -- au -- me s’ouvre à eux,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!  
  
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Il est la Voie, la Vé -- ri -- té
  de ceux qui cher -- chent son Vi -- sage,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordsquatre = \lyricmode {  
  Ils mon -- te -- ront sur la mon -- tagne_; 
  ils se tien -- dront dans son Lieu saint,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
  \set shortVocalName = "2."
  Heu -- reux les doux, heu -- reux les forts, 
  car ils pos -- sè -- de -- ront la
  terre,   al -- lé -- lu -- ia, al -- lé -- lu -- ia_!  
}

altoWordscinq = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Jé -- sus con -- naît la soif des hommes_; comme un ber -- ger, il les con -- duit,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordssix = \lyricmode {  
  quand ils tra -- ver -- sent les dé -- serts vers les eaux vi -- ves du sa -- lut,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
  \set shortVocalName = "3."
  Heu -- reux ceux qui ont faim et soif. Le Sei -- gneur Dieu les com -- ble -- ra,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordssept = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Il est ve -- nu chez les pé -- cheurs sau -- ver ce qui é -- tait per -- du,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordshuit = \lyricmode {  %\set stanza = #". "
  Sa com -- pas -- sion les trans -- fi -- gure et sa bon -- té les en -- va -- hit,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
  \set shortVocalName = "4."
  Heu -- reux les hom -- mes de par -- don_: ils ob -- tien -- dront mi -- sé -- ri -- corde,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordsneuf = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  Par la ten -- dres -- se de l’Es -- prit, il change en sour -- ce les ro -- chers,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordsdix = \lyricmode {  %\set stanza = #". "
  Pour ceux qui nais -- sent de l’Es -- prit, la joie pa -- raît, l’hi -- ver prend fin.
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
  \set shortVocalName = "5."
  Heu -- reux les ar -- ti -- sans de paix. Ils sont les fils du Dieu A -- mour,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordsonze = \lyricmode {  
  \set shortVocalName = "6." \set stanza = #"6. "
  Sa mort nous ou -- vre le che -- min et ses bles -- su -- res nous gué -- rissent,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordsdouze = \lyricmode {  %\set stanza = #". "
  Ils ont souf -- fert la grande é -- preuve et pu -- ri -- fié leurs vê -- te -- ments,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
  \set shortVocalName = "6."
  Heu -- reux les cœurs in -- con -- so -- lés, car le Sei -- gneur les sau -- ve -- ra,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordstreize = \lyricmode {  
  \set shortVocalName = "7." \set stanza = #"7. "
  Non, il ne dort ni ne som -- meille, 
  ce -- lui qui gar -- de les vi -- vants,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordsquatorze = \lyricmode {  %\set stanza = #". "
  So -- leil ni lu -- ne ne les brûlent, 
  mais “O -- ri -- ent” est leur flam -- beau,
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
  \set shortVocalName = "7."
  Heu -- reux les purs qui cher -- chent Dieu, 
  l’A -- gneau de Dieu les il -- lu -- mine, 
  al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}


%\transpose d c
\new ChoirStaff 
<<
  \set ChoirStaff.beamExceptions = #'()
  \set ChoirStaff.baseMoment = #(ly:make-moment 1/4)
  \set ChoirStaff.beatStructure = #'(1 1 1 1)
  \new Staff = "women" \with { \consists "Merge_rests_engraver" }
  <<
    \new Voice = "sopranos" {
      \voiceOne
      << \global \sopMusic >>
    }
    \new Voice = "altos" \with { \consists "Balloon_engraver"
                                 \override BalloonText.annotation-balloon = ##f }
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordssix
  \new Lyrics \lyricsto "sopranos" \altoWordssept
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordshuit
  \new Lyrics \lyricsto "sopranos" \altoWordsneuf
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsdix
  \new Lyrics \lyricsto "sopranos" \altoWordsonze
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsdouze
  \new Lyrics \lyricsto "sopranos" \altoWordstreize
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordsquatorze
  
  \new Staff = "men" \with { \consists "Merge_rests_engraver" }
  <<
    \clef bass
    \new Voice = "ténors" \with { \consists "Balloon_engraver"
                                  \override BalloonText.annotation-balloon = ##f } 
    {
      \voiceOne
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo 
      << \global \bassMusic >>
    }
  >>
>>