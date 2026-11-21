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
%   title = \markup \center-column { "Voici ! J’envoie mon messager" }
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
    Voi -- ci! J’en -- voie mon mes -- sa -- ger, al -- lé -- lu -- ia, al -- lé -- lu -- ia,
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } 
  \lyricsto "sopranos"
  { 
    le Christ, lu -- miè -- re des na -- tions, al -- lé -- lu -- ia, al -- lé -- lu -- ia.
    \set shortVocalName = \markup\right-align"1." 
    Je vous le don -- ne comme un feu
    \im qui vient pu -- ri -- fier vo -- tre cœur, \imstop al -- lé -- lu -- ia, al -- lé -- lu -- ia.
  }
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "2." \set shortVocalName = \markup\right-align"2." 
    L’Es -- prit ré -- vèle à Sy -- mé -- on, al -- lé -- lu -- ia, al -- lé -- lu -- ia
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } 
  \lyricsto "sopranos"
  { 
    que le Sei -- gneur vient en son Temple, al -- lé -- lu -- ia, al -- lé -- lu -- ia.
    \set shortVocalName = \markup\right-align"2." 
    Ses yeux con -- tem -- plent le sa -- lut
    \im pro -- mis par Dieu à Is -- ra -- ël, \imstop al -- lé -- lu -- ia, al -- lé -- lu -- ia.
  }
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "3." \set shortVocalName = \markup\right-align"3." 
    Pour nous sau -- ver de nos pé -- chés, al -- lé -- lu -- ia, al -- lé -- lu -- ia,	
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } 
  \lyricsto "sopranos"
  { 
    tu viens re -- vê -- tir no -- tre chair, al -- lé -- lu -- ia, al -- lé -- lu -- ia,
    \set shortVocalName = \markup\right-align"3." 
    et tu t’es fait sem -- blable à nous,
    \im por -- tant le poids de nos pé -- chés, \imstop al -- lé -- lu -- ia, al -- lé -- lu -- ia.
  }
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "4." \set shortVocalName = \markup\right-align"4." 
    Ma -- rie, un glai -- ve de dou -- leur, al -- lé -- lu -- ia, al -- lé -- lu -- ia	
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } 
  \lyricsto "sopranos"
  { 
    vien -- dra te trans -- per -- cer le cœur, al -- lé -- lu -- ia, al -- lé -- lu -- ia,
    \set shortVocalName = \markup\right-align"4." 
    et sa Pa -- ro -- le, comme un feu,
    \im ré -- vé -- le -- ra le cœur de tous, \imstop al -- lé -- lu -- ia, al -- lé -- lu -- ia.
  }
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "5." \set shortVocalName = \markup\right-align"5." 
    Jé -- ru -- sa -- lem, ré -- veil -- le_- toi, al -- lé -- lu -- ia, al -- lé -- lu -- ia	
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } 
  \lyricsto "sopranos"
  { 
    à la ren -- con -- tre du Sei -- gneur, al -- lé -- lu -- ia, al -- lé -- lu -- ia.
    \set shortVocalName = \markup\right-align"5." 
    Il fait con -- naî -- tre son sa -- lut
    du mi -- lieu de son Tem __ -- ple, \imstop al -- lé -- lu -- ia, al -- lé -- lu -- ia.
  }
  \new Lyrics \lyricsto "sopranos"
  { 
    \set stanza = "6." \set shortVocalName = \markup\right-align"6." 
    Ou -- vrez_- vous, por -- tes é -- ter -- nelles, al -- lé -- lu -- ia, al -- lé -- lu -- ia,	
  }
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 } 
  \lyricsto "sopranos"
  { 
    et qu’il en -- tre, le Roi de gloire, al -- lé -- lu -- ia, al -- lé -- lu -- ia.
    \set shortVocalName = \markup\right-align"6." 
    C’est lui le Fils du Dieu vi -- vant.
    \im C’est le Sei -- gneur de l’u -- ni -- vers, \imstop al -- lé -- lu -- ia, al -- lé -- lu -- ia.
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
      << \revert Staff.TimeSignature.style 
         \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>