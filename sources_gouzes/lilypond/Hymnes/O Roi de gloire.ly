\version "2.24.0"

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

global = {
  \key f \minor
  \time 6/4
}

sopMusic = \relative c' {
  \partial 1 c4 f2 aes4 g2 f4 g (f) ees f2 \breathe\allowBreak
  f4 aes2 bes4 c2 aes4 bes2 bes4 
  \time 9/4 c2.~c2 \breathe\allowBreak
  aes4 c2 bes4 \time 6/4 c4 (bes) aes bes2 aes4 g2 \breathe\allowBreak
  c,4 f2 aes4 g2 f4 g (f) ees f2.~ f2 \bar "|."
}

altoMusic = \relative c' {
  \partial 1 c4 c2 c4 des2 des4 bes2 c4 f2
  f4 ees2 des4 c2 f4 des2 ees4 aes2.~ aes2
  f4 e (f) g c,2 c4 d2 d4 e2 
  c4 des!2 c4 bes2 des4 bes (c) c f2.~ f2
}


altoWordsun = \lyricmode {  
  \set stanza = #"1. "\set shortVocalName = "1."
  Ô Roi de gloi -- re, Jé -- sus_- Christ, a -- mi des hommes et bon pas -- teur,
  Heu -- reux ceux_- là qui ont mar -- ché par les che -- mins de ton a -- mour.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = "2."
  Choi -- sis de toute é -- ter -- ni -- té, à ton ap -- pel, ils ont vi -- bré.
  La croix qui sau -- ve l’u -- ni -- vers, en te sui -- vant, ils l’ont por -- tée.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Té -- moin de Dieu pour tous les temps, leur mort chan -- tait dé -- jà ton nom. 
  Leur vie en toi trans -- fi -- gu -- rée an -- nonce aux hom -- mes ton sa -- lut.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  Vers toi, ô Père, ils ont cou -- ru, vers toi, l’Es -- prit les a pous -- sés. 
  Ton Fils  qui s’est li -- vré pour eux, dans son Roy -- au -- me, les u -- nit.
}


\score {
  \new ChoirStaff 
  <<
    \new Staff = "women" \with { \remove "Time_signature_engraver" }
    <<
      \new Voice = "sopranos" {
        \voiceOne
        \global \sopMusic
      }
      \new Voice = "altos" {
        \voiceTwo
        \global \altoMusic
      }
    >>
    
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  >>
}