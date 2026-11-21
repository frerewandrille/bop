\version "2.24.0"
\include "vowel-set.ly"

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
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

resp = { \breathe\allowBreak }

global = {
  \key a \major
  \time 4/4
}

sopMusic = \relative c' {
  \partial4 fis8 (gis) a4 gis fis\fermata\resp fis8 (gis) a4 gis fis\fermata\resp
  cis' b a gis\fermata\resp
  gis a a b b cis cis b a gis2 fis4\fermata\resp
  cis' b a8 (gis) gis4\fermata\resp cis b a8 (gis) gis4\fermata\resp
  gis a a b b cis cis b a8 (gis) gis2 fis4\fermata
  \bar "|." 
}

altoMusic = \relative c' {
  cis4 fis eis fis fis fis eis cis fis fis8 (eis) fis4 eis
  eis fis fis fis8 (gis16 a) gis4 8 (fis) eis (fis) gis4. fis8 4 (eis) cis
  fis fis8 (eis) fis4 eis fis8 (e) dis (e) fis (dis) e4
  gis8 (eis) fis4 a8 (fis) d4 b'8 (gis) a (gis) fis4 8 (eis) fis4 8 (eis16 dis) eis4 cis
}

tenorMusic = \relative c' {
  a8 (b) cis4 8 (b) a4 b cis4 8 (b) a4 a b cis cis
  cis cis d d8 (e16 fis) e8 (d) cis4 b8 (a) d (cis) cis (d) d ([b gis cis]) a4
  a b8 (cis) dis4 cis cis fis, b b
  cis4 8 (a) d4 8 (b) e4 8 (cis) fis (e) d (cis) dis4 cis8 ([gis cis b]) a4
}

bassMusic = \relative c {
  fis4 16 (gis a b) cis8 (cis,) d4\fermata\resp d cis8 (b) cis4 fis,\fermata\resp
  fis' gis a8 (b) cis4\fermata\resp
  cis, fis8 (e) d (cis) d (b) e4 a,8 (a') gis (fis) fis (eis) fis (d) b (gis cis4) fis,\fermata\resp
  fis'8 (e) d (cis) bis4 cis\fermata\resp
  a b8 (cis) dis (b) e4\fermata\resp
  eis8 (cis) fis4 8 (d) g4 gis8 (e) a4 ais8 (fis) b4 bis8 (gis) cis4 (cis,) fis\fermata
}


\new ChoirStaff 
<<
  \new Staff = "women" \with { \consists "Merge_rests_engraver" }
  <<
    \new Voice = "sopranos" {
      \voiceOne 
      \set Staff.beamExceptions = #'()
      \set Staff.baseMoment = #(ly:make-moment 1/4)
      \set Staff.beatStructure = 1,1,1,1
      << \revert Staff.TimeSignature.style \global \sopMusic >>
    }
    \new Voice = "altos" %\with { \consists "Balloon_engraver" }
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  
  \new Lyrics \lyricsto "sopranos" { 
    \set shortVocalName = \markup\right-align"1." \set stanza = #"1."
    Jé -- sus est né_! Le Christ Sau -- veur nous est don -- né_!
    Al -- lons vers lui, al -- lons lui ren -- dre gloi -- re_!
    Il est ve -- nu, l’Em -- ma -- nu -- el, Jé -- sus, Mes -- sie qui vient sau -- ver le mon -- de.
  }
  \new Lyrics \lyricsto "sopranos" { 
    \set shortVocalName = \markup\right-align"2." \set stanza = #"2."
    Jé -- sus est né_! Et dans la nuit de Beth -- lé -- em, 
    un an -- ge vient por -- ter l’an -- nonce aux pau -- vres.
    Vous trou -- ve -- rez un nou -- veau_- né dans u -- ne crèche, en -- ve -- lop -- pé de lan -- ges.
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" { 
    \set shortVocalName = \markup\right-align"3." \set stanza = #"3."
    É -- veil -- le_- toi, ô toi qui dors_! Re -- lè -- ve_- toi_!
    Il res -- plen -- dit, ce -- lui qui t’il -- lu -- mi -- ne.
    Il est ve -- nu dans no -- tre nuit, tan -- dis que tou -- te chose é -- tait si -- len -- ce.
  }
  \new Lyrics \lyricsto "sopranos" {  
    \set shortVocalName = \markup\right-align"4." \set stanza = #"4."
    É -- veil -- le_- toi, Jé -- ru -- sa -- lem_! Re -- lè -- ve_- toi_!
    Car Dieu s’est sou -- ve -- nu de ta dé -- tres -- se.
    Voi -- ci ton Roi qui vient vers toi,
    le Roi de paix d’une é -- ter -- nelle al -- lian -- ce.
  }
  \new Lyrics \lyricsto "sopranos" {  
    \set shortVocalName = \markup\right-align"5." \set stanza = #"5."
    En ces jours_- là, Jus -- tice et Paix re -- fleu -- ri -- ront.
    Lè -- ve les yeux au -- tour de toi, re -- gar -- de_!
    Ve -- nant vers toi de tous cô -- tés, les peu -- ples vont mar -- cher vers ta lu -- miè -- re.
  }
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" {  
    \set shortVocalName = \markup\right-align"6." \set stanza = #"6."
    Qu’il soit bé -- ni, ce -- lui qui vient du haut des cieux_!
    Car le Sei -- gneur prend en pi -- tié son peu -- ple.
    Qu’il soit lou -- é et glo -- ri -- fié_! Cri -- ons de joie_! Que tou -- te chose e -- xul -- te_!
  }
  \new Lyrics \lyricsto "sopranos" {  
    \set shortVocalName = \markup\right-align"7." \set stanza = #"7."
    Il est ve -- nu, le Fils de Dieu, le Pre -- mier_- Né.
    En lui, le Père a mis sa com -- plai -- san -- ce_:
    “Tu est mon Fils, mon Bien_- Ai -- mé. C’est au -- jour -- \apostrophe d’hui le jour où je t’en -- gen -- dre.”
  }
  \new Lyrics \lyricsto "sopranos" {  
    \set shortVocalName = \markup\right-align"8." \set stanza = #"8." 
    L’a -- mour de Dieu ma -- ni -- fes -- té dans no -- tre chair
    vient ac -- com -- plir la mer -- veil -- leuse at -- ten -- te.
    Elle est ve -- nue, la fin des temps.
    En lui, le monde an -- cien se re -- nou -- vel -- le.
  }
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER } 
  \lyricsto "sopranos" {  
    \set shortVocalName = \markup\right-align"9." \set stanza = #"9."
    Il est l’Al -- pha et l’O -- mé -- ga, ce -- lui qui vient_!
    Il ou -- vre l’es -- pé -- ran -- ce bien -- heu -- reu -- se.
    Il est ve -- nu d’au -- près de Dieu
    pour nous don -- ner la paix que nul n’en -- lè -- ve.
  }

  \new Staff = "men" \with { \consists "Merge_rests_engraver" }
  <<
    \clef bass
    \new Voice = "tenors" 
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
