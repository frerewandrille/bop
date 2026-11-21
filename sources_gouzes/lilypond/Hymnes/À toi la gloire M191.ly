\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   %system-system-spacing.basic-distance = #17
%   top-margin = 9
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   print-page-number = ##f
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 16)
% 
% \header {
%   title = \markup \center-column { "À toi la gloire !" }
%   subtitle = ""
%   poet = ""
%   composer =  ""
% } 
% \markup{ \vspace #1 }
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

sil = { \oneVoice r4 \voiceOne }
resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

global = {
  \key e \major
  \time 2/2
}


sopMusic = \relative c'' {
  b2 gis4. a8 b2 e, fis8 (gis) a (b) a4 gis fis2. \sil
  gis8 (a) b (cis) b4 b e2 b 
  a4 gis8 (fis) fis4. e8 e2. \sil\break \bar "|."
  \once \slurDashed gis8 (fis) gis (a) gis4 gis fis2 e 
  a4 gis fis e dis2. \sil 
  \once \slurDashed  e8 (dis) \once \slurDashed e (fis) e4 e cis'2 ais 
  b4 cis8 (b) ais4. b8 b2. \sil
  \bar "|." \mark "D.C."
}

altoMusic = \relative c' {
  e2 e4. dis8 e2 e dis8 (e) fis (gis) fis4 e dis2. s4
  e4 e e e e2 gis dis4 e e  
  \override BalloonText.annotation-balloon = ##f 
  <dis \balloonText #'(1.5 . -2)\markup { "" } >
  e2. s4
  \once \slurDashed e8 (dis) e (fis) e4 e dis2 cis 
  fis4 e dis cis bis2. s4
  \once \slurDashed cis8 (bis) \once \slurDashed cis (dis) cis4 cis e2 e 
  dis4 gis fis 
  \override BalloonText.annotation-balloon = ##f 
  <fis \balloonText #'(2 . -3)\markup { "" } >
  dis2. s4
}

tenorMusic = \relative c' {
  gis2 b4. fis8 gis2 b a4 fis b b b2. \sil
  b4 b b b b 2 gis a4 b b 
  \override BalloonText.annotation-balloon = ##f 
  <a \balloonText #'(1.5 . 2)\markup { "" } >
  gis2. \sil
  \once \tieDashed b8~ b b4 b b a2 gis bis4 cis a gis gis2. \sil
  \once \tieDashed gis8~ gis \once \tieDashed gis~ gis gis4 gis fis2 cis'
  b4 e8 (dis) cis4 
  \override BalloonText.annotation-balloon = ##f 
  <cis \balloonText #'(2 . 3)\markup { "" } >
  b2. \sil
}

bassMusic = \relative c {
  e2 gis4. fis8 e2 gis fis4. 
  \override BalloonText.annotation-balloon = ##f 
  <e \balloonText #'(-1 . 3)\markup { "" } >8
  dis4 e b2. s4
  e8 (fis) gis (a) gis4 gis gis2 e 
  fis4 gis8 (a) b4 b, e2. s4
  \once \tieDashed e8~ e e4 e e b2 cis dis4 e fis cis gis2. s4
  \once \tieDashed cis8~ cis \once \tieDashed cis~ cis cis4 b ais2 fis'
  gis4 e fis fis, b2. s4
}


altoWordsun = \lyricmode {  
  \set stanza = "Ref. "
  À toi la gloi -- re, ô Res -- sus -- ci -- té_!
  À toi la vic -- toi -- re pour l’é -- ter -- ni -- té.
  \set shortVocalName = "1."
  Sois __ dans __ l’al -- lé -- gres -- se, 
  peu -- ple du Sei -- gneur,
  et __ re __ -- dis sans ces -- se 
  que Christ est vain -- queur_!
}
altoWordsdeux = \lyricmode {  
  \repeat unfold 21 { \skip 4 }
  \set shortVocalName = "2."
  Il __ est __ ma vic -- toi -- re, 
  mon li -- bé -- ra -- teur,
  ma __ vie __ et ma gloi -- re,
  le Christ, mon sau -- veur_!
}
altoWordstrois = \lyricmode {  
  \repeat unfold 21 { \skip 4 }
  \set shortVocalName = "3."
  Hon __ -- neur __ et puis -- san -- ce 
  à l’A -- gneau vain -- queur,
  \im Roi des \imstop rois __ pour les siè -- cles, 
  Sei -- gneur des sei -- gneurs_!
}
altoWordsquatre = \lyricmode {  
  \repeat unfold 21 { \skip 4 }
  \set shortVocalName = "4."
  \im Fais de \imstop nous __ pour ta gloi -- re un peu -- ple de rois,
  un __ peu __ -- ple de prê -- tres, Sei -- gneur des sei -- gneurs.
}
altoWordscinq = \lyricmode {  
  \repeat unfold 21 { \skip 4 }
  \set shortVocalName = "5."
  \im Que tes \imstop œu __  -- vres sont gran -- des, Dieu de l’u -- ni -- vers_!
  Ta __ \im cré -- a  -- \imstop tion te chan -- te_: Toi seul, tu es saint.
}
altoWordssix = \lyricmode {  
  \repeat unfold 21 { \skip 4 }
  \set shortVocalName = "6."
  Toi __ qui __ nous ra -- chè -- tes au prix de ton sang,
  con __  -- duis_- __ nous au Pè -- re_: Tu es le che -- min.
}
altoWordssept = \lyricmode {  
  \repeat unfold 21 { \skip 4 }
  \set shortVocalName = "7."
  Toi __ qui __ nous ras -- sem -- bles dans l’u -- nique Es -- prit,
  Fais __ de __ nous des frè -- res, ô Christ, no -- tre paix.
}
altoWordshuit = \lyricmode {  
  \repeat unfold 21 { \skip 4 }
  \set shortVocalName = "8."
  \im Tu en -- \imstop voies __ tes dis -- ci -- ples dans le monde en -- tier
  por __ -- ter __  l’É -- van -- gi -- le de paix, de par -- don.
}
altoWordsneuf = \lyricmode {  
  \repeat unfold 21 { \skip 4 }
  \set shortVocalName = "9."
  Bé __ -- nis __ -- sons le Pè -- re, par son Fils Jé -- sus,
  \im par l’Es -- \imstop prit __ de lu -- miè -- re, al -- lé -- lu -- \skip4 ia.
}

%\transpose c bes,
\new ChoirStaff 
<<
  \new Staff = "women" \with { \revert TimeSignature.style }
  <<
    \new Voice = "sopranos" {
      \voiceOne %\tempo "Calme, paisible"
      \set Staff.beamExceptions = #'()
      \set Staff.baseMoment = #(ly:make-moment 1/4)
      \set Staff.beatStructure = 1,1,1,1
      << \global \sopMusic >>
    }
    \new Voice = "altos" \with { \consists "Balloon_engraver" }
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics \lyricsto "sopranos" \altoWordssix
  \new Lyrics \lyricsto "sopranos" \altoWordssept
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordshuit
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordsneuf
  
  \new Staff = "men" \with { \revert TimeSignature.style }
  <<
    \clef bass
    \new Voice = "tenors" \with { \consists "Balloon_engraver" }
    {
      \voiceOne 
      \set Staff.beamExceptions = #'()
      \set Staff.baseMoment = #(ly:make-moment 1/4)
      \set Staff.beatStructure = 1,1,1,1
      << \global \tenorMusic >>
    }
    \new Voice = "basses" \with { \consists "Balloon_engraver" }
    {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>
