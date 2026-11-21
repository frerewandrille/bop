\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% #(set-global-staff-size 13)
% 
% \header {
%   title = \markup \center-column { "Que mon cœur chante" }
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
    \override InstrumentName.X-offset = 3.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
  } 
}

global = {
  \key c \major
  \time 2/2
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

sopMusic = \relative c'' {
  g2 a4 d c d f e d2\resp
  2 4 e c c a c d2\fermata\bar"|"
  g,2 4 4 a a c c b2\resp
  g2 4 4 a c a a g1*1/2\fermata\bar "|."
  g g\fermata
  \bar "|."
}
altoMusic = \relative c' {
  d2 f4 g g e a g g2 g g4 g a g f e fis2
  d2 4 e f f e fis g2 d2 4 e c g' f f d1*1/2 e d
}
tenorMusic = \relative c' {
  b2 c4 c b c c c b2 b b4 c c c d c a2
  b2 4 4 c c c c d2 b b4 c c c d c b1*1/2 c b
}
bassMusic = \relative c' { \autoBeamOff
  g2 f4 e g a f c g'2\resp
  2 4 c, f e d a' d,2\fermata
  g2 4 4 f f a a g2\resp
  g2 f4 e f e d8 ([e]) f4 g1*1/2\fermata
  c, g'\fermata
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Que mon cœur chan -- te le mys -- tère
  du Corps glo -- rieux de Jé -- sus Christ,
  du Sang pré -- cieux du Fils de Dieu
  ver -- sé pour ra -- che -- ter le monde.
}
altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Né de Ma -- rie, la Vier -- ge Mère,
  il a re -- çu de nous sa chair
  pour y se -- mer son Ver -- be saint
  et don -- ner l’im -- mor -- ta -- li -- té.
}
altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  La nuit de la der -- niè -- re Cène,
  il prend la Pâque a -- vec les siens.
  Rom -- pant le pain, of -- frant le vin,
  il s’offre aux siens en nour -- ri -- ture.
}
altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Il s’est fait chair, lui le vrai pain.
  Son Sang pour nous s’est fait bois -- son.
  Ce que nos sens ne tou -- chent pas,
  la foi en em -- bra -- se nos cœurs.
  }
altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  Ce sa -- cre -- ment est ad -- mi -- rable.
  Cour -- bons nos fronts, a -- do -- rons_- le,
  Dieu ne veut plus des sa -- cri -- fices_:
  voi -- ci l’of -- fran -- de de son Fils.
}
altoWordssix = \lyricmode {  
  \set shortVocalName = "6." \set stanza = #"6. "
  Au Père, au Fils, no -- tre lou -- ange,
  et al -- lé -- gres -- se de nos chants,
  à l’Es -- prit du Père et du Fils,
  é -- gale ac -- cla -- ma -- tion de gloire.
  A -- men.
}

\transpose g e
\new ChoirStaff 
<<
  \new Staff = "women" \with { \consists "Merge_rests_engraver" }
  <<
    \new Voice = "sopranos" {
      \voiceOne
      << \global \cadenzaOn \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo
      << \global \cadenzaOn \altoMusic >>
    }
  >>
  
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordssix
  
  \new Staff = "men" \with { \consists "Merge_rests_engraver" }
  <<
    \clef bass
    \new Voice = "ténors" \with { \consists "Balloon_engraver" } {
      \voiceOne
      << \global \cadenzaOn \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo 
      << \global \cadenzaOn \bassMusic >>
    }
  >>
>>