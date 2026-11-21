\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

% \paper {
%   #(set-paper-size "a5")
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% \header {
%   title = \markup \center-column { "Heureux ceux que tu combles" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
% }
% 
% #(set-global-staff-size 13)
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
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

resp = { \breathe\allowBreak }

global = {
  \key f \major
  \time 2/2
}

sopMusic = \relative c' {
  \partial4 c4 f g a c bes2 a4\resp g f g a g8 ([f]) g2.\resp
  c,4 f g a c bes2 a4\resp g f g a g8 ([f]) g2.\resp
  g4 g g a g f g e\resp d f g a bes a2 g\resp
  c2 bes4 g a2 g f2.\fermata
  \bar "|."
}

altoMusic = \relative c' {
  \partial4 a4 d e f f f (e) f e d e f e8 ([d]) e2.
  a,4 d e f f f (e) f e d e f e8 ([d]) e2.
  e4 d e f e d d cis d d e f f f2 e
  f f4 e c 
  \override BalloonText.annotation-balloon = ##f 
  <f \balloonText #'(2 . -3)\markup { "" } >2
  (e4) f2.
}

tenorMusic = \relative c {
  \partial4 f4 a c c c d (c8 [bes]) c4 c a c c c c2.
  f,4 a c c c d (c8 [bes]) c4 c a c c c c2.
  c4 b c c c a bes a a a c c d c2 c
  c d4 c \slurUp a (bes) c2 c2.
}

bassMusic = \relative c {
  \partial4 f4 d c f a g2 f4\resp c4 d c f f c2.\resp
  f4 d c f a g2 f4\resp c4 d c f f c2.\resp
  c4 g' c, f c d g, a\resp d d c f bes, f'2 c\resp
  a bes4 c f2 c f2.\fermata
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "
  \set shortVocalName = "1."
  Heu -- reux ceux que tu com -- bles du prix de ton a -- mour,
  et qui marchent à ta sui -- te de la mort à la Vie.
  Le grain de blé qui est se -- mé et meurt dans no -- tre ter -- re,
  por -- te beau -- coup de fruit.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. "\set shortVocalName = "2."
  Heu -- reux ceux qui re -- çoi -- vent les ta -- lents de la vie,
  les ser -- vi -- teurs fi -- dè -- les leur font por -- ter du fruit.
  Quand tu cou -- ron -- nes leur a -- mour, c’est ton a -- mour lui_- mê -- me
  que tu viens cou -- ron -- ner.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Heu -- reux ceux qui t’ac -- cueil -- lent, Jé -- sus li -- vré pour nous,
  de ta croix tu leur don -- nes le sang de ton a -- mour.
  A -- fin qu’au_- de -- là du tom -- beau, ils goûtent en ton Roy -- au -- me
  la joie du vin nou -- veau.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  Heu -- reux ce -- lui qui veil -- le at -- ten -- dant ton re -- tour_:
  Sa lam -- pe brille en -- co -- re du feu de ton a -- mour.
  Tu l’é -- ta -- blis sur ta mai -- son et lui donnes en par -- ta -- ge
  la joie des fils de Dieu.
}

altoWordscinq = \lyricmode {  
  \set stanza = #"5. "\set shortVocalName = "5."
  Heu -- reux qui tend l’o -- reil -- le aux pas de ta ve -- nue,
  qui a le cœur en fê -- te lors -- que tu viens à lui.
  Voi -- ci que tu es là, Sei -- gneur, et tu frappes à la por -- te 
  pour par -- ta -- ger le pain.
}

%\transpose c d

\new ChoirStaff 
<<
  \new Staff = "women" \with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne %\cadenzaOn
      << \global \sopMusic >>
    }
    \new Voice = "altos" \with { \consists "Balloon_engraver" }
    {
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
  \new Staff = "men" \with {\remove Time_signature_engraver }
  <<
    \clef bass
    \new Voice = "tenors" %\with { \consists "Balloon_engraver" }
    {
      \voiceOne %\cadenzaOn
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>