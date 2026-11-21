\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   system-system-spacing.basic-distance = #0
%   top-margin = 10
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter svp"
%   print-page-number = ##f
% }
% 
% #(set-global-staff-size 12.5)
% 
% \header {
%   title = \markup \center-column { "Pourquoi regardez-vous" }
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
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = { \key a \minor \time 4/4 }

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

sopMusic = \relative c'' {
  \tieDashed
  \partial 4 a4 a a g a f e d\fermata\resp
  a'8 (b) c4 d a b c b a\fermata\bar":|."
  c c c8 (bes) a (g) f (g) a4 g f\fermata\resp
  a4 a a g f8 (e) e4~ e d\fermata\resp
  a' a g a b c8 (b) a4 g\fermata\resp
  d' e d a8 (b) c4 b a b~ b a2.\fermata
  \bar"|."
}

altoMusic = \relative c' {
  e4 f f f e e8 (d) d (cis) d4 f e d8 (e) f4 f e d cis
  a' g8 (f) e (d) c4 d8 (e) f4 e f c8 (d) e4 d d d \once \slurDashed d (cis) d
  e f4. e8 f (a) g (f) e (d) c4 b g' g f8 (e) d4 e e8 (d) c4 \once \slurDashed f (e8 d) cis2.
}

tenorMusic = \relative c' {
  a4 d d d a a4. g8 f4 d' c8 (b) a4 d d gis,8 (a4) gis8 a4
  e' c g a a8 (bes) c4. bes8 a4 a a8 (g) f4 g8 (a) bes4 \once \slurDashed a4. (g8) f4
  a d8 (c) bes4 c d g,4. fis8 g4 b c8 (b) a (gis) a4 a gis a \once \slurDashed a (gis) a2.
}

bassMusic = \relative c { 
  cis4 d8 (e) f4 b, cis d a d\fermata\resp
  d a'8 (g) f (e) d (c) b (a) e'4 e a,\fermata
  a' e8 (d) c4 f8 (e) d4 a8 (bes) c4 f,\fermata\resp
  f' cis d8 (c) bes (a) g4 \once \slurDashed a (a) d\fermata\resp
  cis d g f8 (e) d4 c d g,\fermata\resp
  g' c, d8 (e) f4 e8 (f) e4 f8 (e) \once \slurDashed d4 (e) a,2.\fermata
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. "\set shortVocalName = "1." 
  Pour -- quoi re -- gar -- dez_- vous le ciel_?
  Il vous en -- voie dans l’u -- ni -- vers.
}

altoWordsunb = \lyricmode { 
  Al -- lez dans tou -- tes les na -- tions por -- ter la joie de son sa -- lut_!
  \set shortVocalName = "1." 
  Ce -- lui qui vous est en -- le -- vé re -- vien -- dra dans sa gloi -- __  re.
  A -- lors vers -- lui se lè -- ve -- ront 
  les yeux de ceux qui l’a -- vaient \im trans -- per -- \imstop cé.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "\set shortVocalName = "2." 
  Pour -- quoi re -- gar -- dez_- vous le ciel vers Jé -- sus Christ, le cru -- ci -- fié_?
}

altoWordsdeuxb = \lyricmode { 
  Sa croix de souf -- france et de mort de -- vient pour tous sour -- ce de paix.
  \set shortVocalName = "2." 
  Bri -- sant les por -- tes de la mort, voi -- ci qu’il ou -- vre \im le che -- \imstop min
  où il en -- traî -- ne les cap -- tifs
  vers l’O -- ri -- ent brû -- lant de \im son a -- \imstop mour.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. "\set shortVocalName = "3." 
  Pour -- quoi re -- gar -- dez_- vous le ciel_?
  Jé -- sus vous a pro -- mis l’Es -- prit,
}

altoWordstroisb = \lyricmode { 
  ou -- vrant vos cœurs à son ap -- pel, à l’hé -- ri -- ta -- ge de la vie.
  \set shortVocalName = "3." 
  Que sa puis -- sance a -- gisse en vous. Mar -- chez dans sa lu -- miè -- __ re,
  et vous se -- rez res -- sus -- ci -- tés,
  sié -- geant a -- vec lui dans sa gloi -- __ re.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. "\set shortVocalName = "4." 
  Pour -- quoi re -- gar -- dez_- vous le ciel_?
  Il siège en gloire au -- près du Père.
}

altoWordsquatreb = \lyricmode {
  Car Dieu a don -- né à son Christ le Nom au_- des -- sus de tout nom.
  \set shortVocalName = "4." 
  Et tout pou -- voir lui est don -- né pour qu’il ras -- semble en \im un seul \imstop corps
  l’hu -- ma -- ni -- té que dans sa chair, A -- dam a -- vait bri -- sée par \im son pé -- \imstop ché.  
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5. "\set shortVocalName = "5." 
  Pour -- quoi re -- gar -- dez_- vous le ciel
  vers Jé -- sus Christ le seul Sei -- gneur_?
}

altoWordscinqb = \lyricmode {
  Il est la tê -- te de ce corps où Dieu veut ê -- tre tout en tous.
  \set shortVocalName = "5." 
  Vi -- vez se -- lon l’Es -- prit d’a -- mour qu’il a pro -- mis à \im ceux \imstop qui l’aiment_:
  Il est mon -- té dans les hau -- teur pour vous don -- ner sa paix, sa \im vé -- ri -- \imstop té.
}

altoWordssix = \lyricmode { 
  \set stanza = #"6. "\set shortVocalName = "6." 
  Pour -- quoi re -- gar -- dez_- vous le ciel.
  Il est tou -- jours au -- près de vous,
}

altoWordssixb = \lyricmode {
  at -- ti -- rant tou -- tes choses à lui dans l’es -- pé -- ran -- ce de son Jour.
  \set shortVocalName = "6." 
  Il monte aux cieux pour no -- tre joie pour y fon -- der Jé -- \im ru -- sa -- \imstop lem,
  a -- fin que, là où il se -- ra,
  vous de -- meu -- riez u -- nis dans \im son a -- \imstop mour.
}

\transpose a g
\new ChoirStaff <<
  \new Staff = "women"   <<
    \set Staff.beamExceptions = #'()
    \set Staff.baseMoment = #(ly:make-moment 1/4)
    \set Staff.beatStructure = 1,1,1,1
    \new Voice = "sopranos" {
      \voiceOne 
      << \global \sopMusic >>
    }
    \new Voice = "altos" %\with { \consists "Balloon_engraver" }
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsunb
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsdeuxb
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordstroisb
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics  
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsquatreb
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordscinqb
  \new Lyrics \lyricsto "sopranos" \altoWordssix
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordssixb

  \new Staff = "men"
  <<
    \set Staff.beamExceptions = #'()
    \set Staff.baseMoment = #(ly:make-moment 1/4)
    \set Staff.beatStructure = 1,1,1,1    \clef bass
    \new Voice = "tenors"
    {
      \voiceOne
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>