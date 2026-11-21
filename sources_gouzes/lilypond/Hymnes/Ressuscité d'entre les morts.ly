\version "2.24.0"
% 
% \paper {
%   #(set-paper-size "a5" ’landscape)
%   top-margin = 9
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter svp"
% 
% }
% 
% #(set-global-staff-size 19)
% 
% \header {
%   title = \markup \center-column { "Ressuscité d’entre les morts" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
% }

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
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key g \major
  \time 3/4
}

sopMusic = \relative c' {
  e4 b' b b2 g4 a2 c4 b2. b4 b d c2 b4 a2 a4 g2.
  b4 a g a2 fis4 g2 g4 fis2. fis4 g a b2 g4 a fis2 e2.\bar "|." 
}

altoMusic = \relative c' {
  b4 e e dis2 e4 e2 e4 e2. g4 g fis e2 d4 d2 d4 d2.
  d4 c b d2 d4 b2 cis4 d2. d4 e fis g2 e4 e dis2 e2.
}

tenorMusic = \relative c' {
  g4 g g fis2 e4 e2 a4 gis2. e4 g! b g2 g4 fis2 fis4 g2.
  g4 fis e fis2 a4 g2 e4 a2. b4 b d d2 c4 c b2 b2.
}

bassMusic = \relative c {
  e4 e e b2 e4 c2 a4 e'2. e4 e b c2 g4 d'2 d4 g,2.
  g4 d' e d2 d4 e2 e4 d2. b4 e d g2 c,4 a b2 e2.
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "
  \set shortVocalName = "1."
  Res -- sus -- ci -- té d’en -- tre les morts,
  bri -- sant les por -- tes des en -- fers,
  Sau -- veur du monde, ô Pre -- mier_- Né,
  tu re -- nou -- vel -- les no -- tre vie.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. "\set shortVocalName = "2."
  A -- dam e -- xulte à ton ap -- pel,
  bre -- bis per -- due que tu con -- duis
  de la té -- nè -- bre de la mort
  à la lu -- miè -- re des vi -- vants.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Nous t’ac -- cla -- mons, Jé -- sus Sei -- gneur_:
  Tu as ou -- vert le Pa -- ra -- dis
  et tou -- te chose est re -- cré -- ée 
  par ta vic -- toi -- re sur la mort.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  Lou -- ange à toi, ô Pè -- re saint,
  par Jé -- sus Christ res -- sus -- ci -- té,
  dans la lu -- miè -- re de l’Es -- prit,
  pour tous les siè -- cles é -- ter -- nels.

}

\new ChoirStaff 
<<
  \new Staff = "women" %\with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne 
      << \global \sopMusic >>
    }
    \new Voice = "altos" 
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "sopranos" \altoWordsquatre
  
  \new Staff = "men" %\with {\remove Time_signature_engraver }
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