\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   system-system-spacing.basic-distance = #0
%   top-margin = 10
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter ni plier svp"
%   print-page-number = ##f
% }
% 
% #(set-global-staff-size 14)
% 
% \header {
%   title = \markup \center-column { "Petits enfants, je vais au Père" }
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
% 
% \markup{ \vspace #1 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = { \key e \minor \time 2/4 }

%resp = { \breathe }
resp = {  }

sopMusic = \relative c'' {
  \partial4   \bar"|:"
  b4^\markup\italic"Jésus" g e c' b a b g2 fis\resp
  r4 g4 fis e dis e a g fis2\resp  \bar ":|."
  %  b4 g e c' b a b g2 fis\resp
  %  r4 g4 fis e dis e a g fis2\resp
  r4 g4^\markup\italic"Disciples" d b' c b a c c2 b\resp
  r4 e4 dis e c b8 (a) g4 fis e2
  r4 g4 d b' c b a c c2 b\resp
  r4 e4 dis e c b8 (a) g4 fis e2\fermata
  \bar"|."
}

altoMusic = \relative c' {
  b4 b e e dis e fis e2 dis 
  r4 e dis e b b fis' e dis2
  r4 d d d c d e d d2 d
  r4 g fis e e e e dis e2
  r4 d d d g fis e fis8 (e) dis2 dis
  r4 e fis g e e e dis e2
}

tenorMusic = \relative c {
  fis4 e g a fis fis fis b2 b
  r4 b4 a b b b b b b2
  r4 b4 g g e8 (fis) g4 g fis g2 g
  r4 b4 b b c c b a g2
  r4 g4 b g g g g a8 (g) fis2 fis
  r4 b4 a b c c b b8 (a) g2
}

bassMusic = \relative c {
  dis4 e c a b cis dis e2 b\resp
  r4 e fis g a g dis e b2\resp
  r4 g b g a b c d g,2 g\resp
  r4 e' b'8 (a) g4 a a, b b c2 
  r4 b g f' e d c a b2 b \resp
  r4 g' fis e a fis b b, e2\fermata 
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. "\set shortVocalName = "1." 
  Pe -- tits en -- fants, je vais au Pè -- re. 
  Que vo -- tre cœur ne crai -- gne pas_:
}

altoWordsunb = \lyricmode { 
  Je vous pré -- pare u -- ne de -- meu -- re 
  dans la lu -- miè -- re sans dé -- clin.\set shortVocalName = "1." 
  Tu nous en -- traî -- nes dans ta gloi -- re,
  tu es tou -- jours au -- près de nous,
  Jé -- sus, jus -- \apostrophe qu’à la fin du mon -- de. 
  Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "\set shortVocalName = "2." 
  Pe -- tits en -- fants, je vais au Pè -- re.
  Je re -- vien -- drai bien -- tôt vers vous.
}

altoWordsdeuxb = \lyricmode { 
  Heu -- reux le ser -- vi -- teur fi -- dè -- le
  qui veil -- le -- ra à mon re -- tour_!\set shortVocalName = "2." 
  En nous ai -- mant les uns les au -- tres,
  nous gar -- de -- rons ta vo -- lon -- té,
  nous en -- tre -- rons dans ton mys -- tè -- re.
  Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. "\set shortVocalName = "3." 
  Pe -- tits en -- fants, je vais au Pè -- re.
  Sur vous re -- po -- se l’Es -- prit Saint_:
}

altoWordstroisb = \lyricmode { 
  Il vous en -- sei -- gne tou -- te cho -- se,
  il vous con -- duit dans mon a -- mour.\set shortVocalName = "3." 
  No -- tre té -- nè -- bre s’il -- lu -- mi -- ne_:
  dans ta bon -- té, tu nous re -- crées
  à ton i -- mage et res -- sem -- blan -- ce.
  Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. "\set shortVocalName = "4." 
  Pe -- tits en -- fants, je vais au Pè -- re.
  D’au -- près de lui je suis ve -- nu,
}

altoWordsquatreb = \lyricmode {
  et c’est en lui que je de -- meu -- re_:
  Je suis l’Al -- pha et l’O -- mé -- ga_!\set shortVocalName = "4." 
  Jé -- sus, tu vis a -- vec le Pè -- re
  dans la lu -- miè -- re de l’Es -- prit_:
  Lou -- ange à toi dans tous les siè -- cles.
  Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
}

\transpose b a
\new ChoirStaff <<
  \new Staff = "women" \with { \consists "Merge_rests_engraver" }  
  <<
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
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordsquatreb

  \new Staff = "men" \with { \consists "Merge_rests_engraver" }
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