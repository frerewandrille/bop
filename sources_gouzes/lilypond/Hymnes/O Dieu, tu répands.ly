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
    \override InstrumentName.X-offset = 0
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key a \minor
  \time 6/4
}

altoMusic = \relative c' {
  d-> f e-> f g-> a d,2 c4 \breathe\allowBreak f e-> f d-> c c2 d \bar "|"
  d4 a'-> g f-> e f-> g g2 a4 \breathe\allowBreak a g-> a b-> c b-> a a2 \bar "|"
  a4-> d c-> b a-> g a-> g f2 e\breathe\allowBreak d4-> g f d-> e d c2 \bar "|"
  e4-> g a d,-> c d-> e f-> e d d2  \fermata\bar"|." 
  \oneVoice d2 (e4 d) c2 (d)\fermata\bar"|."
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "\set shortVocalName = "1."
  Ô Dieu, tu ré -- pands ta grâ -- ce sur tou -- te cré -- a -- tu -- re,
  Et tu sus -- ci -- tes des pro -- phè -- tes, bril -- lantes é -- toi -- les dans la nuit.
  Hé -- ri -- tiers de la Nou -- velle Al -- lian -- ce, tes en -- fants nés de l’es -- prit,
  Non du vou -- loir de l’hom -- me ni de la chair.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = "2."
  Vends tout ce que tu pos -- sè -- des et don -- ne_- le aux pau -- vres.
  Ton É -- van -- gi -- le le dé -- ci -- de à tout quit -- ter pour te cher -- cher.
  Mé -- di -- tant les cho -- ses du Roy -- au -- me, lais -- sant les biens pas -- sa -- gers,
  Son ex -- is -- ten -- ce fut ca -- chée dans le Christ.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Dans les psaumes et la lou -- an -- ge, do -- cile à ta Pa -- ro -- le,
  Dans la dou -- ceur et le si -- len -- ce, dans la joie et l’hu -- mi -- li -- té,
  Il mit fin aux œu -- vres du vieil hom -- me pour re -- vê -- tir son Sau -- veur,
  L’A -- dam nou -- veau qui par sa croix nous re -- crée.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  La vie de Jé -- sus son maî -- tre en lui fut ma -- ni -- fes -- te.
  Il com -- ba -- tit Sa -- tan lui_- mê -- me a -- vec l’ar -- mu -- re de l’Es -- prit,
  Sa vie pro -- cla -- mait la pé -- ni -- ten -- ce pour re -- ce -- voir le sa -- lut,
  Il an -- non -- çait les biens du mon -- de qui vient.
}

altoWordscinq = \lyricmode {  
  \set stanza = #"5. "\set shortVocalName = "5."
  Qui ha -- bite en ta pré -- sen -- ce vit au cœur de l’É -- gli -- se,
  Car il n’est plus de so -- li -- tu -- de pour l’hom -- me qui de -- meure en toi.
  Il pos -- sè -- de la paix vé -- ri -- ta -- ble, son si -- lence est ha -- bi -- té.
  Il con -- duit vers toi un grand nom -- bre de fils.
}

altoWordssix = \lyricmode {  
  \set stanza = #"6. "\set shortVocalName = "6."
  Gloire à toi, Dieu no -- tre Pè -- re. Tu es son hé -- ri -- ta -- ge.
  Tu re -- nou -- velles en tes fi -- dè -- les la res -- sem -- blan -- ce de ton Fils,
  Car tu veux nous ren -- dre l’in -- no -- cen -- ce qui ré -- gnait au pa -- ra -- dis,
  Par ton Es -- prit de sain -- te -- té et d’a -- mour. A -- men_!
}


\score {
  \new ChoirStaff 
  <<
    \new Staff = "women" \with { \remove "Time_signature_engraver" }
      \new Voice = "altos" {
        \voiceOne \cadenzaOn \altoMusic
      }
    
    \new Lyrics \lyricsto "altos" \altoWordsun
    \new Lyrics \lyricsto "altos" \altoWordsdeux
    \new Lyrics 
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
    \lyricsto "altos" \altoWordstrois
    \new Lyrics \lyricsto "altos" \altoWordsquatre
    \new Lyrics \lyricsto "altos" \altoWordscinq
    \new Lyrics \lyricsto "altos" \altoWordssix
  >>
}