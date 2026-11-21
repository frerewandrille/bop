\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   %system-system-spacing.basic-distance = #17
%   top-margin = 9
%   bottom-margin = 0
%   left-margin = 10
%   right-margin = 10
%   print-page-number = ##f
%   tagline = ##f
% }
% 
% #(set-global-staff-size 16)
% 
% \header {
%   title = \markup \center-column { "En toi, ô Dieu, soit mon refuge" }
%   subtitle = ""
%   poet = ""
%   composer =  ""
%   tagline = ##f
% } 
% \markup{ \vspace #1 }

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

resp = { \breathe\allowBreak }

global = {
  \key bes \major
  \time 4/4
}

sopMusic = \relative c'' {
  \partial2 d4 d a bes c bes8 a a4 g\resp
  bes bes a g fis g a2\resp
  d4 d a bes c bes8 a a4 g\resp
  bes bes a g fis g a2\resp %\break
  a4 bes c8 bes a4 bes a8 (g) g4 f\resp
  bes c d d ees d8 c c4 bes\resp
  d d c d bes c d2\fermata
  d4 d c bes a a g2\fermata
  \bar "|." 
}

tenorMusic = \relative c'' {
  \partial2 bes8 (a) bes4 fis g g g8 g fis4 g
  g g e8 (fis) d (ees) d4 g fis2
  bes8 (a) bes4 fis g g g8 g fis4 g
  g g e8 (fis) d (ees) d4 g fis2
  fis4 g8 (f) g g f4 f f e f
  f g f f bes g8 g a4 f
  f bes a fis g8 (fis) g (a) fis2
  bes8 (a) bes4 fis g g g8 (fis) g2
}

bassMusic = \relative c'' {
  \partial2 g4 g, d' d ees c8 c d4 g\resp
  g8 (f) ees (d) c4 bes8 (c) d4 ees d2\resp
  g4 g, d' d ees c8 c d4 g\resp
  g8 (f) ees (d) c4 bes8 (c) d4 ees d2\resp
  d4 d e8 d c4 d8 (c) bes4 c f\resp
  d4 ees bes bes'8 (a) g (f) ees ees f4 d\resp
  bes8 (c) d (ees) f (ees) d4 d ees d2\fermata
  g4 g, d' d ees d g,2  \fermata
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. " \set shortVocalName = "1."
  En toi, ô Dieu, soit mon re -- fu -- ge
  et le lieu de mon a -- bri.
  En toi j’ai mis mon es -- pé -- ran -- ce_:
  Je ne se -- rai pas dé -- çu,
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = "2."
  Sei -- gneur, tu as vu ma mi -- sè -- re,
  tu con -- nais mon af -- flic -- tion.
  Quand je te sup -- plie, tu m’é -- cou -- tes.
  En tes mains, je me con -- fie,
  \set stanza = #"  Ref. " \set shortVocalName = ""
  Car c’est toi le Dieu qui me sau -- ve, 
  mon rem -- part et ma for -- te -- res -- se.
  Pour la gloi -- re de ton Nom,
  sois mon guide et mon pas -- teur.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. " \set shortVocalName = "3."
  Gloire et puis -- sance à Dieu le Pè -- re.
  Gloire au Fils et à l’Es -- prit.
  C’est toi, ô Sei -- gneur, que je chan -- te.
  À ja -- mais, tu es bé -- ni,
}

%\transpose c bes,
\new ChoirStaff 
<<
  \new Staff = "women" %\with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \set Staff.beamExceptions = #'()
      \set Staff.baseMoment = #(ly:make-moment 1/4)
      \set Staff.beatStructure = 1,1,1,1
      << \global \sopMusic >>
    }
  >>
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordstrois
  \new Staff = "men" %\with {\remove Time_signature_engraver }
  <<
    %\clef bass
    \new Voice = "tenors" \with { \consists "Balloon_engraver" }
    {
      \voiceOne 
      \set Staff.beamExceptions = #'()
      \set Staff.baseMoment = #(ly:make-moment 1/4)
      \set Staff.beatStructure = 1,1,1,1
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>
