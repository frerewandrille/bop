\version "2.24.0"

\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

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
%   title = \markup \center-column { "Ô très doux Créateur" }
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
    \override LyricText.X-offset = #centrer
  } 
}

%\layout { ragged-last = ##t indent = #0 }

global = {
  \key f \major
  \time 4/4
}

resp = { \breathe\allowBreak }

sopMusic = \relative c'' { \autoBeamOff
  a8 f-> a c-> c d-> bes c \(\resp c\) d-> bes c-> bes a-> g a4.*1/3\bar"|"
  c8 bes-> g a-> bes a-> g f \(\resp f\) a-> bes c-> bes a-> g a2*1/2
  \fermata \bar "|."
  a4 (bes8 [a]) g4 (a) \bar "|."
}
altoMusic = \relative c'' { \autoBeamOff
  a8 f f a a bes g a \( a \) bes g a g f e f4.*1/3
  a8 g e f g f e f \( f \) f g a g f e f2*1/2
  f4 (g8 [f]) e4 (f)
}
tenorMusic = \relative c' {
  c\breve*1/2 \breve*7/16 4.*1/3
  c\breve*1/2 \breve*7/16 2*1/2 c2 c
}
bassMusic = \relative c { \autoBeamOff
  f\breve*1/2 \resp f\breve*5/16 c8 c f4.*1/3
  f\breve*1/2 \resp f\breve*5/16 c8 c f2*1/2
  \fermata  f c4 (f)
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Ô très doux cré -- a -- teur des cieux, lampe é -- ter -- nel -- le des croy -- ants,
  ô Christ sau -- veur de l’u -- ni -- vers, en -- tends la voix des sup -- pli -- ants_!
}
altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Voy -- ant le monde em -- pli de mort, dans ton a -- mour tu prends pi -- tié_;
  pour le sau -- ver de son mal -- heur, tu le gué -- ris de son pé -- ché.
}
altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Quand fut ve -- nu le soir du temps, la Vier -- ge t’a don -- né le jour_;
  comme un é -- poux de sa mai -- son, tu es sor -- ti du sein très pur.
}
altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Toi qui vien -- dras ju -- ger le monde, ô Dieu très saint nous t’en pri -- ons_:
  dé -- li -- vre_- nous de l’en -- ne -- mi et gar -- de_- nous du -- rant ce temps.
}
altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  De -- vant ta force et ton pou -- voir, tous les ge -- noux de -- vront pli -- er,
  et sur la ter -- re comme au ciel, à ton re -- gard tout se sou -- met.
}
altoWordssix = \lyricmode {  
  \set shortVocalName = "6." \set stanza = #"6. "
  Lou -- ange, hon -- neur, puis -- sance et gloire à Dieu le Père et à son Fils,
  à l’Es -- prit no -- tre dé -- fen -- seur, dans les é -- ter -- ni -- tés sans fin. A -- men_!
}

\new ChoirStaff 
<<
  \new Staff = "women" <<
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
  
  \new Staff = "men" <<
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