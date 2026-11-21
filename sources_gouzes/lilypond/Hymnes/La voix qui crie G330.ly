\version "2.24.0"
 
\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 14)
% 
% \header {
%   title = \markup \center-column { "La voix qui crie dans le désert" }
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
  } 
}

global = {
  \key g \major
  \time 4/4
}

resp = { \breathe\allowBreak }

sopMusic = \relative c' {
  \partial4 
  d4 g a b e d4. c8 b4\resp
  e4 d c b c8 (d) a2 g4\fermata\bar":|."
  d'4 e e a, a d d g,\resp
  b a g fis g8 (fis) e2 d4\fermata\resp
  d'4 c! b a^\markup\italic"rall." b8 (c) a2 g4
  \fermata \bar "|."
}

altoMusic = \relative c' {
  \partial4 
  b8 (c) d4 d d e8 (fis) g4 fis g 
  g fis g8 (a) b (a) g4 g (fis) d
  g g g fis fis8 (g) a (g) fis4 e
  e e d8 (cis) d4 d d (cis) d
  g8 (fis) e4 d8 (e) fis4 g g (fis) d
}

tenorMusic = \relative c' {
  \partial4 
  g8 (a) b4 a g g8 (a) b4 a8 (d) d4
  c8 (b) a4 e' d e e (d8 c) b4
  b c8 (b) a4 d d a b b g a a a g8 (a) b4 (a8 g) fis4
  g g8 (a) b (c) d4 d d8 (c16 b c8 a) b4
}

bassMusic = \relative c {
  \partial4 
  g4 g' fis g c, b8 (c) d4 g,\resp
  c d e8 (fis) g (fis) e (d) c4 (d) g,\fermata
  g' c, cis d d8 (e) fis4 b, e\resp
  e8 (d) cis (b) a4 d8 (cis) b (a) g4 (a) d\fermata\resp
  b e8 (fis) g4 d8 (c) b (g) d'2 g,4
  \fermata
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  La voix qui crie dans le dé -- sert_:
  "“Fra" -- yez pour Dieu la rou -- "te !”"
}

altoWordsdeux = \lyricmode {  
  La voix d’É -- lie a re -- ten -- ti
  qui lui pré -- pare un peu -- ple.
  \set shortVocalName = "1."
  Que vos che -- mins de -- vien -- nent droits_!
  Por -- tez un fruit de grâ -- ce_!
  Cro -- yez à l’É -- van -- gi -- le_!
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Quel -- qu’un que vous ne vo -- yez pas
  dé -- jà se ma -- ni -- fes -- te_:
}

altoWordsquatre = \lyricmode {  
  Il ô -- te -- ra vo -- tre pé -- ché,
  comme un a -- gneau sans ta -- che.
  \set shortVocalName = "2."
  Voi -- ci qu’il vient der -- riè -- re moi,
  et vous ver -- rez sa gloi -- re
  bril -- ler au cœur du mon -- de_!
}

altoWordscinq = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Je vous bap -- tise a -- vec de l’eau,
  chan -- geant vos cœurs de pier -- re.
}

altoWordssix = \lyricmode {  
  Mais lui bap -- ti -- se dans l’Es -- prit,
  le Feu qui il -- lu -- mi -- ne.
  \set shortVocalName = "3."
  Il est ce -- lui qui doit ve -- nir_:
  Dé -- jà les sourds en -- ten -- dent
  et les lé -- preux gué -- ris -- sent.
}

altoWordssept = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Comme u -- ne lampe a -- vant le jour,
  j’an -- non -- ce sa lu -- miè -- re_:
}

altoWordshuit = \lyricmode {  %\set stanza = #". "
  Tan -- dis que moi, je di -- mi -- nue,
  il faut que lui gran -- dis -- se.
  \set shortVocalName = "4."
  Un cri s’é -- lève en no -- tre nuit_:
  "“L’É" -- poux s’a -- vance aux no -- ces.
  Ma joie est de l’en -- ten -- "dre.”"
}


\transpose d c
\new ChoirStaff 
<<
  \set ChoirStaff.beamExceptions = #'()
  \set ChoirStaff.baseMoment = #(ly:make-moment 1/4)
  \set ChoirStaff.beatStructure = #'(1 1 1 1)
  \new Staff = "women" <<
    \new Voice = "sopranos" {
      \voiceOne
      << \global \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordssix
  \new Lyrics \lyricsto "sopranos" \altoWordssept
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordshuit
  
  \new Staff = "men" <<
    \clef bass
    \new Voice = "tenors" \with { \consists "Balloon_engraver" } {
      \voiceOne
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo 
      << \global \bassMusic >>
    }
  >>
>>