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
  a4 b c d c a c \once \slurDashed b (a) g2. \breathe\allowBreak a4 a b g e g a a2.\fermata\bar"|."
  a2 (b4 a) g2 (a)\fermata\bar"|."
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "\set shortVocalName = "1."
  Dans la pri -- ère et dans la foi, elle a vé -- cu en ta pré -- sence.
  Elle a brû -- lé en ton É -- gli -- __ se comme u -- ne lam -- pe dans la nuit.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. " \set shortVocalName = "2."
  Ta com -- pas -- sion pour tes en -- fants l’a -- vait bles -- sée au fond du cœur.
  Près des pe -- tits, des mi -- sé -- ra -- __ bles, elle a mon -- tré ton grand a -- mour.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Au long des nuits, elle at -- ten -- dit la voix cri -- ant_: "“Voi" -- ci l’É -- "poux !”"
  Et à mi -- nuit, dans l’al -- lé -- gres -- se, elle est en -- trée pour le fes -- tin.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  \set ignoreMelismata = ##t
  L’Es -- prit qui ha -- bi -- tait son cœur l’ar -- mait de force et de dou -- ceur.
  Lais -- sons_- le a -- che -- ver en no -- tre vie ce qu’il ma -- ni -- fes -- ta en elle.
}

altoWordscinq = \lyricmode {  
  \set stanza = #"5. "\set shortVocalName = "5."
  Voi -- ci l’É -- poux qui nous ap -- pelle. Cou -- rons aux No -- ces de l’A -- gneau.
  Et quand l’at -- ten -- te sem -- ble lon -- __ gue, di -- sons_: "“Re" -- viens, Sei -- gneur Jé -- "sus !”"
}

altoWordssix = \lyricmode {  
  \set stanza = #"6. "\set shortVocalName = "6."
  Dans la fi -- dé -- li -- té des saints et des ser -- van -- tes du Très_- Haut,
  L’É -- gli -- se trou -- ve son vi -- sa -- __ ge d’É -- pouse ir -- ré -- pro -- chable et pure.
}

altoWordssept = \lyricmode {  
  \set stanza = #"7. "\set shortVocalName = "7."
  Gloire au Père et à l’Es -- prit_- Saint. Gloire au Christ, mort pour son É -- glise.
  Il la veut sainte et sans souil -- lu -- __ re, im -- ma -- cu -- lée de -- vant sa face. A -- men.
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
    \new Lyrics \lyricsto "altos" \altoWordssept
  >>
}