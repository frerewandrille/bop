\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

% \paper {
%   #(set-paper-size "a5")
%   system-system-spacing.basic-distance = #20
%   top-margin = 8
%   bottom-margin = 8
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter ni plier svp"
%   print-page-number = ##f
% }
% 
% #(set-global-staff-size 16)
% 
% \header {
%   title = \markup \center-column { "Quand le Christ ton Bien-Aimé" }
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
    \override InstrumentName.X-offset = 3
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = { \key g \minor \time 4/4 }

resp = { \breathe }

sopMusic = \relative c'' {
  g4 g f bes a8 (g) a4 g2\fermata
  g8 (a) bes4 c bes c d bes2\fermata
  bes4 c d8 (c) bes4 c8 (bes) a4 g2\fermata
  g4 g f! bes a8 (g) a4 g2\fermata
  \bar"|."
}

altoMusic = \relative c' {
  d4 c d d d8 (e) fis4 d2
  d8 (fis) g4 c, f ees d8 (ees16 f) ees2
  ees4 ees d d c8 (g') fis4 d2
  cis8 (d) e4 d d ees!8 (bes) c4 b2
}

tenorMusic = \relative c' {
  bes4 a8 (g) a (g) f (g) a (bes) c4 bes2
  bes8 (c) d (ees) a, (g) f (g) a4 bes8 (f) g2
  g4 a8 (bes) a4 g g d'8 (c) bes2
  e,4 a a g g4. fis8 <d g>2
}

bassMusic = \relative c' {
  g8 (f) ees4 d4. e8 fis (g) d4 g,2\fermata
  g4 g' f!8 (ees!) d4 c bes ees2\fermata
  ees8 (d) c4 fis g8 (f) ees (c) d4 g,2\fermata
  a8 (b) cis (a) d (c) bes (g) c (d16 ees) d4 g,2\fermata
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. "\set shortVocalName = "1." 
  Quand le Christ, ton Bien_- Ai -- mé,
  dans sa chair t’é -- pou -- se -- ra,
  crie de joie, Jé -- ru -- sa -- lem,
  à la voix de ton Sei -- gneur_!
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "\set shortVocalName = "2." 
  Quand le Christ, au temps mar -- qué,
  t’ou -- vri -- ra les cieux nou -- veaux,
  il é -- veil -- le -- ra ton cœur
  au bon -- heur de la vraie vie.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. "\set shortVocalName = "3." 
  Quand le ciel s’as -- som -- bri -- ra,
  quand le so -- leil s’é -- tein -- dra,
  en toi brû -- le -- ra sa joie,
  le flam -- beau de son a -- mour.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. "\set shortVocalName = "4." 
  Quand vien -- dra le jour nou -- veau
  où Dieu se -- ra tout en tous,
  tous ceux qui sont morts en lui
  en toi re -- ce -- vront la vie.
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5. "\set shortVocalName = "5." 
  Lors -- qu’en toi de -- meu -- re -- ra
  ton Sei -- gneur et ton É -- poux,
  tes en -- fants lui chan -- te -- ront
  le can -- ti -- que de l’A -- gneau.

}

altoWordssix = \lyricmode { 
  \set stanza = #"6. "\set shortVocalName = "6." 
  Quand ce mon -- de pas -- se -- ra,
  brû -- lé de peine et de pleurs,
  lui vien -- dra chan -- ger ton deuil
  en un chant d’é -- ter -- ni -- té.
}

altoWordssept = \lyricmode { 
  \set stanza = #"7. "\set shortVocalName = "7." 
  Quand le Christ vien -- dra sau -- ver
  tous ceux qui é -- taient per -- dus,
  Jé -- ru -- sa -- lem, c’est en toi
  qu’il vien -- dra les con -- so -- ler.
}

altoWordshuit = \lyricmode { 
  \set stanza = #"8. "\set shortVocalName = "8." 
  Que ce mon -- de meure en toi
  pour qu’il vi -- ve par ta Croix.
  Que ta grâ -- ce vienne en lui
  pour qu’ils vi -- vent de ta vie.
}

altoWordsneuf = \lyricmode { 
  \set stanza = #"9. "\set shortVocalName = "9." 
  Que l’Es -- prit veille en nos cœurs
  pour le jour où tu vien -- dras.
  Qu’il creuse en nous cet -- te soif
  de te voir et de t’ai -- mer.
}

altoWordsdix = \lyricmode { 
  \set stanza = #"10. "\set shortVocalName = "10." 
  Viens Sei -- gneur, viens nous sau -- ver.
  Viens cher -- cher tes fils per -- dus.
  Viens, Sei -- gneur res -- sus -- ci -- té,
  viens pour nous don -- ner ta vie_!
}


\new ChoirStaff <<
  \set ChoirStaff.beamExceptions = #'()
  \set ChoirStaff.baseMoment = #(ly:make-moment 1/4)
  \set ChoirStaff.beatStructure = #'(1 1 1 1)
  \new Staff = "women" 
  <<
    \new Voice = "sopranos" {
      \voiceOne
      << \global \sopMusic >>
    }
    \new Voice = "altos" \with { \consists "Balloon_engraver" }{
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "sopranos" \altoWordscinq
%   \new Lyrics \lyricsto "sopranos" \altoWordssix
%   \new Lyrics \lyricsto "sopranos" \altoWordssept
%   \new Lyrics \lyricsto "sopranos" \altoWordshuit
%   \new Lyrics \lyricsto "sopranos" \altoWordsneuf
%   \new Lyrics \lyricsto "sopranos" \altoWordsdix

  \new Staff = "men" 
  <<
    \clef bass
    \new Voice = "tenors" \with { \consists "Balloon_engraver" }{
      \voiceOne
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>

\new ChoirStaff <<
  \set ChoirStaff.beamExceptions = #'()
  \set ChoirStaff.baseMoment = #(ly:make-moment 1/4)
  \set ChoirStaff.beatStructure = #'(1 1 1 1)
  \new Staff = "women" 
  <<
    \new Voice = "sopranos" {
      \voiceOne
      << \global \sopMusic >>
    }
    \new Voice = "altos" \with { \consists "Balloon_engraver" }{
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
%   \new Lyrics \lyricsto "sopranos" \altoWordsun
%   \new Lyrics \lyricsto "sopranos" \altoWordsdeux
%   \new Lyrics \lyricsto "sopranos" \altoWordstrois
%   \new Lyrics \lyricsto "sopranos" \altoWordsquatre
%   \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics \lyricsto "sopranos" \altoWordssix
  \new Lyrics \lyricsto "sopranos" \altoWordssept
  \new Lyrics \lyricsto "sopranos" \altoWordshuit
  \new Lyrics \lyricsto "sopranos" \altoWordsneuf
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "sopranos" \altoWordsdix
   
  \new Staff = "men" 
  <<
    \clef bass
    \new Voice = "tenors" \with { \consists "Balloon_engraver" }{
      \voiceOne
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>

%{
convert-ly (GNU LilyPond) 2.22.0  convert-ly: Traitement de «  »...
Conversion en cours : 2.21.0, 2.21.2, 2.22.0
%}
