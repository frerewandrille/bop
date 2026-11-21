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
% #(set-global-staff-size 16)
% 
% \header {
%   title = \markup \center-column { "Insondable la tendresse" }
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

global = { \key e \minor \time 2/4 }
resp = { \breathe }
silN = { \oneVoice r4 \voiceOne }
im = \set ignoreMelismata = ##t

sopMusic = \relative c'' {
  \tieDashed
  g4 a b d g, b a2 g \resp b4 cis d e d cis d2~ d4\silN \bar":|."
  d4 d c! c b c a fis\resp b b a a g a fis d\resp
  g a b c b a g2\fermata
  \bar"|."
}

altoMusic = \relative c' {
  \tieDashed
  d4 d d d e e e (d8 c) b2 g'4 a a g a e fis2~ fis4 s
  fis e e d d e d d d c c b b e d d b d d c d d8 (c) b2
}

tenorMusic = \relative c' {
  \tieDashed
  b4 a g fis e g g (fis) g2 d'4 e a, b a a a2~ a4 \silN
  d4 b c a g g fis a g g a fis g e a a g fis g g g fis g2
}

bassMusic = \relative c' { 
  \tieDashed
  g4 fis g b, c cis d2 g\resp g4 g fis e fis8 (g) a4 d,2~ d4 s
  b'4 gis a fis g c, d d\resp g e fis dis e cis d fis\resp
  e d g8 (f) e4 d d g,2\fermata
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. "\set shortVocalName = "1." 
  \im In -- son -- da -- ble la ten -- dres -- se 
  de mon Sei -- gneur pour sa vi -- gne,
}

altoWordsunb = \lyricmode { 
  \im car la vi -- gne vé -- ri -- ta -- ble, 
  c’est Jé -- sus li -- vré pour nous. __\skip4
  \set shortVocalName = "1." 
  So -- yez vrai -- ment mes dis -- ci -- ples, 
  ai -- mez_- vous les uns les au -- tres
  com -- me je vous ai ai -- més.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "\set shortVocalName = "2." 
  \im Gran -- de la mi -- sé -- ri -- cor -- de 
  de mon Sei -- gneur pour sa vi -- gne_:
}

altoWordsdeuxb = \lyricmode { 
  \im Comme un cep il don -- ne sè -- ve 
  aux sar -- ments gref -- fés sur lui. __\skip4
  \set shortVocalName = "2." 
  Ma Pa -- ro -- le vous é -- mon -- de_: 
  por -- tez fruits dans la lu -- miè -- re,
  de -- meu -- rez dans mon a -- mour.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. "\set shortVocalName = "3." 
  \im Mer -- veil -- leu -- se l’es -- pé -- ran -- ce 
  de mon Sei -- gneur pour sa vi -- gne_:
}

altoWordstroisb = \lyricmode { 
  \im Il l’a -- me -- na de l’É -- gy -- pte, 
  lui pré -- pa -- ra u -- ne pla -- ce.
  \set shortVocalName = "3." 
  Il leur ou -- vrit u -- ne rou -- te 
  jus -- \apostrophe qu’à la ter -- re pro -- mi -- se.
  Il at -- ten -- dait leur a -- mour. 
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. "\set shortVocalName = "4." 
  \im In -- nom -- bra -- ble la pa -- tien -- ce
  de mon Sei -- gneur pour sa vi -- gne_:
}

altoWordsquatreb = \lyricmode {
  \im Il en fi -- xa la clô -- tu -- re,
  é -- pier -- rant leurs cœurs re -- bel -- les.
  \set shortVocalName = "4." 
  S’é -- loi -- gnant de sa ten -- dres -- se,
  ils ser -- vi -- rent d’au -- tres mai -- tres.
  Lui at -- ten -- dait leur re -- tour.
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5. "\set shortVocalName = "5." 
  \im In -- las -- sa -- ble la clé -- men -- ce
  de mon Sei -- gneur pour sa vi -- gne_:
}

altoWordscinqb = \lyricmode {
  \im Quand les vi -- gne -- rons tu -- è -- rent
  les ser -- vi -- teurs de leur Maî -- tre,
  \set shortVocalName = "5." 
  il li -- vra son Fils u -- ni -- que,
  qui nous ou -- vre l’hé -- ri -- ta -- ge,
  qui nous of -- fre le par -- don.
}

altoWordssix = \lyricmode { 
  \set stanza = #"6. "\set shortVocalName = "6." 
  \im In -- ef -- fa -- ble l’al -- lé -- gres -- se
  de mon Sei -- gneur pour sa vi -- gne,
}

altoWordssixb = \lyricmode {
  \im Son a -- mour est no -- tre fê -- te
  et sa joie est no -- tre joie_! __\skip4
  \set shortVocalName = "6." 
  Par le Fils qui nous ras -- sem -- ble,
  gloire au Pè -- re qui nous don -- ne
  sans me -- su -- re l’Es -- prit Saint.
}

%\transpose f e
\new ChoirStaff <<
  \new Staff = "women"   <<
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
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordstroisb
%   \new Lyrics \lyricsto "sopranos" \altoWordsquatre
%   \new Lyrics 
%   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
%   \lyricsto "sopranos" \altoWordsquatreb
%   \new Lyrics \lyricsto "sopranos" \altoWordscinq
%   \new Lyrics 
%   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
%   \lyricsto "sopranos" \altoWordscinqb
%   \new Lyrics \lyricsto "sopranos" \altoWordssix
%   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
%   \lyricsto "sopranos" \altoWordssixb

  \new Staff = "men"
  <<
    \clef bass
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

\new ChoirStaff <<
  \new Staff = "women"   <<
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
%   \new Lyrics \lyricsto "sopranos" \altoWordsun
%   \new Lyrics 
%   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
%   \lyricsto "sopranos" \altoWordsunb
%   \new Lyrics \lyricsto "sopranos" \altoWordsdeux
%   \new Lyrics 
%   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
%   \lyricsto "sopranos" \altoWordsdeuxb
%   \new Lyrics \lyricsto "sopranos" \altoWordstrois
%   \new Lyrics 
%   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #7 }
%   \lyricsto "sopranos" \altoWordstroisb
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
    \clef bass
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