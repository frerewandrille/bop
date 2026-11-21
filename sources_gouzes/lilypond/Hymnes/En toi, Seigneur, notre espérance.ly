\version "2.24.0"
% 
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
% \header {
%   title = \markup \center-column { "En toi, Seigneur, notre espérance" }
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
  \key d \major
  \time 6/4
}

sopMusic = \relative c'' {
  \partial2. b4 a b fis2. e4 d e fis2 fis4\resp
  b4 a b fis2. e4 d e fis2.\resp
  fis4 b cis d (cis) b a2 b4 cis2 cis4\resp
  fis, b cis d (cis) b a (b) cis b2.
  \bar"|."
}

altoMusic = \relative c' {
  \partial2. b4 d e fis (g a) g fis g fis (e cis)
  d cis b fis' (b a) g a g fis2.
  e4 d cis b2 cis4 d (cis) b fis' (g) fis
  e fis e d2 e4 fis2 fis,4 b2.
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. " \set shortVocalName = "1."
  En toi Sei -- gneur, mon es -- pé -- ran -- ce.
  Sans ton ap -- pui, je suis per -- du.
  Mais ren -- du fort par ta puis -- san -- ce,
  je ne se -- rai ja -- mais dé -- çu.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = "2."
  Sois mon rem -- part et ma re -- trai -- te,
  mon bou -- cli -- er, mon pro -- tec -- teur.
  Sois mon ro -- cher dans la tem -- pê -- te,
  sois mon re -- fuge et mon sau -- veur.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. " \set shortVocalName = "3."
  Lors -- que du poids de ma mi -- sè -- re
  ta main vou -- dra me dé -- li -- vrer,
  sur u -- ne rou -- te de lu -- miè -- re,
  d’un cœur jo -- yeux je mar -- che -- rai.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. " \set shortVocalName = "4."
  De tout dan -- ger gar -- de mon â -- me_!
  Je la re -- mets en -- tre tes mains.
  De l’en -- ne -- mi qui me ré -- cla -- me,
  pro -- tè -- ge_- moi, je suis ton bien.
}

%\transpose c bes,
\new ChoirStaff 
<<
  \new Staff = "women" %\with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne << \global \sopMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \altoMusic >>
    }
  >>
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
>>
