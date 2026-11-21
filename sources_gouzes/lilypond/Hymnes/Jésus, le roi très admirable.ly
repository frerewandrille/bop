\version "2.24.0"

\include "vowel-set.ly"

\layout { \context { 
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


altoMusic = \relative c'' {
  a4 a a a d, f e d2. \breathe\allowBreak a'4 a b g a c b a2. \bar "|"
  a4 b c d (c) a (c) b a g2. \breathe\allowBreak a4 a b g e g a a2.\fermata\bar"|."
  a2 (b4 a) g2 (a)\fermata\bar"|."
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "\set shortVocalName = "1."
  Jé -- sus, le roi très ad -- mi -- rable
  Et le no -- ble tri -- om -- pha -- teur,
  La dou -- ceur que __ nul __ mot ne dit,
  Le to -- ta -- le -- ment dé -- si -- rable.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = "2."
  Roi des puis -- san -- ces, roi de gloire,
  Roi de vic -- toi -- re sans é -- gal,
  Jé -- sus, do -- na __ -- teur __ de tout bien,
  Hon -- neur de l’as -- sem -- blée des anges.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Toi que les chœurs du ciel pro -- clament,
  Qu’ils ne se las -- sent d’ac -- cla -- mer,
  Tu nous mets en __ paix __ a -- vec Dieu,
  Tu es, Jé -- sus, la joie du monde.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  C’est dans la paix que Jé -- sus règne,
  D’u -- ne paix qui pas -- se nos sens,
  Cel -- le que cher __ -- chent __ tant les cœurs,
  En a -- vant_- goût de la ren -- contre.
}

altoWordscinq = \lyricmode {  
  \set stanza = #"5. "\set shortVocalName = "5."
  Dès main -- te -- nant, chan -- tons des hymnes,
  Lou -- ons Jé -- sus, sup -- pli -- ons_- le
  Pour qu’il nous don __ -- ne __ de goû -- ter
  A -- vec lui les joies du Roy -- aume.
}

altoWordssix = \lyricmode {  
  \set stanza = #"6. "\set shortVocalName = "6."
  Jé -- sus, fleur d’u -- ne vier -- ge mère,
  A -- mour pour nous plein de dou -- ceur,
  À toi, les lou __ -- an __ -- ges sans fin
  Et la roy -- au -- té bien -- heu -- reuse_!
  A -- men_!
}


\score {
  \new ChoirStaff 
  <<
    \new Staff = "women" \with { \remove "Time_signature_engraver" }
    \new Voice = "altos" {
      \oneVoice \stemUp \cadenzaOn \altoMusic
    }
    
    \new Lyrics \lyricsto "altos" \altoWordsun
    \new Lyrics \lyricsto "altos" \altoWordsdeux
    \new Lyrics 
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
    \lyricsto "altos" \altoWordstrois
    \new Lyrics \lyricsto "altos" \altoWordsquatre
    \new Lyrics \lyricsto "altos" \altoWordscinq
    \new Lyrics 
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
    \lyricsto "altos" \altoWordssix
  >>
}