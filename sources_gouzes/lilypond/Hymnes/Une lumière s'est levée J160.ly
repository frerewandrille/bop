\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

% \paper {
%   #(set-paper-size "a5" )
%   %system-system-spacing.basic-distance = #17
%   top-margin = 8
%   bottom-margin = 7
%   left-margin = 10
%   right-margin = 10
%   print-page-number = ##f
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% #(set-global-staff-size 14)
% 
% \header {
%   title = \markup \center-column { "Dans la douceur de ton amour" }
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
    \override InstrumentName.X-offset = 3
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

global = {
  \key g \major
  \time 4/4
}

sopMusic = \relative c'' {
  \partial4 g4 g8 (a) b4 a g a a b\fermata\resp
  g8 (a) b4 c d c8 (b) a (g) a4 g\fermata\bar":|." 
  b4 b a g fis g8 (a) b4 a\fermata\resp
  a4 g fis g d \once\slurDashed g (a) b\fermata\resp
  g8 (a) b4 c d c8 (b) a (g) a4 g\fermata
  \bar "|."}

altoMusic = \relative c' {
  d4 e8 (fis) g4 8 (fis) g4 g fis g 
  e8 (fis) g (b4) a16 (g) fis4 g g fis d
  g4 g4. fis8 fis (e) e (dis) e4 d! d
  d d8 (c) d4 d8 (c) b4 \once\slurDashed b4 (e) dis
  b e e d8 (e16 fis) g4 4 fis d
}

tenorMusic = \relative c' {
  b4 b e e8 (d) d4 e8 (c) a (d) d4
  e4 d g,8 (a) b (c) d4 d c8 (b) b4
  d4 d d 8(c) b (c) fis, (b) b (a) a (g) fis4
  fis g8 (a) b (c) b (a) g4 \once\slurDashed 4 (fis8 e) fis4
  e8 (fis) g4. a8 b (c) d4 4 c8 (b) b4
}

bassMusic = \relative c' {
  g8 (fis) e4. d8 c4. b8 c (a) d4 g,\fermata\resp
  c4 g'8 (fis) e4 b8 (a) g4 d' d, g\fermata
  g'8 (a) b (c) d4 g,8 (a) b4 e,8 (fis) g4 d\fermata\resp
  d'8 (c) b4. a8 g4. fis8 \once\slurDashed e (d c4) b\fermata\resp
  e4 8 (d) c4 b8 (a) g4 d' d g,\fermata
}

altoWordsun = \lyricmode { 
}

altoWordsdeux = \lyricmode { 
}

\new ChoirStaff 
<<
  \new Staff = "women" \with { \consists "Merge_rests_engraver" }
  %\with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne
      \set Staff.beamExceptions = #'()
      \set Staff.baseMoment = #(ly:make-moment 1/4)
      \set Staff.beatStructure = 1,1,1,1
      << \revert Staff.TimeSignature.style \global \sopMusic >>
    }
    \new Voice = "altos"
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "1." \set shortVocalName = \markup\right-align"1." 
    U -- ne lu -- miè -- re s'est le -- vée
    Al -- le -- lu -- ia, al -- le -- lu -- ia,

  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } 
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER } \lyricsto "sopranos"
  { 
    Il -- lu -- mi -- nant ceux qui mar -- chaient,
    dans les té -- nè -- bres de la mort.
    \set shortVocalName = \markup\right-align"1." 
    Le Ver -- be s'est ma -- ni -- fes -- té.
    Nous a -- vons vu sa Gloi -- __ re,
    \set stanza = "  1-7." \set shortVocalName = \markup\right-align"" 
    Al -- le -- lu -- ia, al -- le -- lu -- ia.
  }
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "2." \set shortVocalName = \markup\right-align"2." 
    Jé -- sus, Lu -- miè -- re des na -- tions,
    Al -- le -- lu -- ia, al -- le -- lu -- ia,
 
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } \lyricsto "sopranos"
  { 
    A res -- plen -- di dans no -- tre nuit.
    Sur nous ray -- on -- ne son A -- mour.
    \set shortVocalName = \markup\right-align"2." 
    Il fait con -- naî -- tre son Sa -- lut
    jus -- \apostrophe qu'aux loin -- tains du mon -- __ de,
%    Al -- le -- lu -- ia, al -- le -- lu -- ia.
  }
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "3." \set shortVocalName = \markup\right-align"3." 
    Ceux qui at -- ten -- dent sa ve -- nue,
    Al -- le -- lu -- ia, al -- le -- lu -- ia.
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } \lyricsto "sopranos"
  { 
    Ont vu son astre à son le -- ver,
    ont vu l'au -- ro -- re du Sa -- lut.
    \set shortVocalName = \markup\right-align"3." 
    Voi -- ci que mar -- chent les na -- tions
    à sa clar -- té nais -- san -- __ te,
%    Al -- le -- lu -- ia, al -- le -- lu -- ia.
  }
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "4." \set shortVocalName = \markup\right-align"4." 
    Lè -- ve les yeux au -- tour de toi,
    Al -- le -- lu -- ia, al -- le -- lu -- ia,
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } \lyricsto "sopranos"
  { 
    Vers toi la gloi -- re des na -- tions,
    comme un tor -- rent dé -- bor -- __ \skip4 de.
    \set shortVocalName = \markup\right-align"4." 
    Ve -- nez, en -- trez, pros -- ter -- nons_- nous
    de -- vant le Dieu qui \im nous \imstop a faits,
%    Al -- le -- lu -- ia, al -- le -- lu -- ia.
  }
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "5." \set shortVocalName = \markup\right-align"5." 
    Voi -- ci qu'un Fils nous est don -- né,
    Al -- le -- lu -- ia, al -- le -- lu -- ia,
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } \lyricsto "sopranos"
  { 
    Em -- ma -- nu -- el, Prin -- ce de paix,
    En -- fant de la Pro -- mes -- __ \skip4 se.
    \set shortVocalName = \markup\right-align"5." 
    Mes -- sie Sau -- veur, Jé -- sus est là
    a -- vec Ma -- rie sa Mè -- __ re,
%    Al -- le -- lu -- ia, al -- le -- lu -- ia.
  }
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "6." \set shortVocalName = \markup\right-align"6." 
    Au Fils du Roi l'or de Sa -- ba
    Al -- le -- lu -- ia, al -- le -- lu -- ia.
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } \lyricsto "sopranos"
  { 
    Et de -- vant lui comme un en -- cens,
    s'é -- lè -- vent nos lou -- an -- __ \skip4 ges.
    \set shortVocalName = \markup\right-align"6." 
    Par -- fum de myrrhe aux pieds du Christ
    dont la Pas -- sion nous sau -- __ ve,
%    Al -- le -- lu -- ia, al -- le -- lu -- ia.
  }
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "7." \set shortVocalName = \markup\right-align"7." 
    Nous te lou -- ons Pè -- re très saint,
    Toi qui nous as don -- né ton Fils,
  }
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER } \lyricsto "sopranos"
  { 
    Pour qu'en sa chair brille à ses yeux,
    l'A -- mour dont tu nous as ai -- més.
    \set shortVocalName = \markup\right-align"7." 
    Gloire à l'Es -- prit qui nous con -- duit
    vers la Lu -- miè -- re \im de \imstop la Vie,
%    Al -- le -- lu -- ia, al -- le -- lu -- ia. 
  }

  
  \new Staff = "men" \with { \consists "Merge_rests_engraver" }
  %\with {\remove Time_signature_engraver }
  <<
    \clef bass
    \new Voice = "tenors" %\with { \consists "Balloon_engraver" }
    {
      \voiceOne 
      \set Staff.beamExceptions = #'()
      \set Staff.baseMoment = #(ly:make-moment 1/4)
      \set Staff.beatStructure = 1,1,1,1
      << \revert Staff.TimeSignature.style \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>
