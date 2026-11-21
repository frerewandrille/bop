\version "2.24.0"

\include "vowel-set.ly"

\layout {
  indent = #0
  \context {
    \Score \remove "Bar_number_engraver"
  }
  \context {
    \Lyrics
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
  \context {
    \Lyrics
    \override LyricText.font-size = #2
    \override LyricSpace.minimum-distance = #1
  } 
}

sopMusic = \relative c'' {
  g4 \omit Score.BarLine a8 bes a4 g8 f g (a) bes g \noBreak g8 \noBeam \breathe\allowBreak 
  g8 g bes a f g bes a4 \noBreak a \revert Score.BarLine.stencil \revert Score.BarLine.stencil \bar "|"
  r8 \omit Score.BarLine bes c4 bes8 a g a bes g \noBreak g4 \breathe\allowBreak 
  a8 bes a4 g8 f g a bes g \noBreak g4\fermata \revert Score.BarLine.stencil \bar "|."%\break

  g4 \omit Score.BarLine a8 bes a4 (g8) f g a bes g \noBreak g8 \noBeam \breathe\allowBreak 
  g8 g bes a f g bes \noBreak a4 \revert Score.BarLine.stencil \bar "|"
  r8 \omit Score.BarLine bes c4 bes8 a g (a) bes g \noBreak g4 \breathe\allowBreak 
  a4 bes8 a g8 f g a bes (g) \noBreak g4\fermata \revert Score.BarLine.stencil \bar "|."%\break

  g4 \omit Score.BarLine a8 bes a4 (g8) f g a bes g \noBreak g8 \noBeam \breathe\allowBreak 
  g8 g bes a f g bes a4 \noBreak a \revert Score.BarLine.stencil \bar "|"
  r8 \omit Score.BarLine bes c4 bes8 a g a bes g \noBreak g4 \breathe\allowBreak 
  a4 bes8 a g8 f g a bes g \noBreak g4\fermata \revert Score.BarLine.stencil \bar "|."%\break

  g4 \omit Score.BarLine a8 bes a4 g8 f g a bes (g) \noBreak g8 \noBeam \breathe\allowBreak 
  g8 g bes a f g bes \noBreak a4 \revert Score.BarLine.stencil \bar "|"
  r4 \omit Score.BarLine bes4 c8 bes8 a4 (g8) a bes g \noBreak g4 \breathe\allowBreak 
  a8 bes a4 g8 f g a bes g \noBreak g4\fermata \revert Score.BarLine.stencil \bar "|."%\break

  g4 \omit Score.BarLine a8 bes a4 (g8) f g a bes g \noBreak g8 \noBeam \breathe\allowBreak 
  g8 g bes a f g bes \noBreak a4 \revert Score.BarLine.stencil \bar "|"
  r8 \omit Score.BarLine \omit Score.BarLine bes c4 bes8 a g a bes g \noBreak g4 \breathe\allowBreak 
  a8 bes a4 g8 f g (a) bes g \noBreak g4\fermata \revert Score.BarLine.stencil \bar "|."%\break

  g4 \omit Score.BarLine a8 bes a4 g8 f g a bes g \noBreak g8 \noBeam \breathe\allowBreak 
  g8 g bes a f g bes \noBreak a4 \revert Score.BarLine.stencil \bar "|"
  r4 \omit Score.BarLine bes8 c bes8 a g (a) bes g \noBreak g4 \breathe\allowBreak 
  a8 bes a4 (g8) f g a bes g \noBreak g4\fermata \revert Score.BarLine.stencil \bar "|."%\break

  g4\omit Score.BarLine  a8 bes a4 g8 f g a bes g \noBreak g8 \noBeam \breathe\allowBreak 
  g8 g bes a f g bes \noBreak a4 \revert Score.BarLine.stencil \bar "|"
  r8 \omit Score.BarLine bes c4 bes8 a g a bes g \noBreak g4 \breathe\allowBreak 
  a4 bes8 a g8 f g a bes g \noBreak g4\fermata \revert Score.BarLine.stencil \bar "|."
  
  g4 (\noBreak  \omit Score.BarLine a8 g) f4 (g) \fermata \revert Score.BarLine.stencil \bar "|."
}


altoWordsun = \lyricmode {  
  \set stanza = #"1. "
  Ô Christ, tu es la lu -- mière et le jour_: chasse en la nuit tou -- te té -- nè -- bre,
  lu -- mière en -- gen -- drée de la Lu -- mière, an -- non -- çant la lu -- miè -- re sans dé -- clin.
  \set stanza = #"2. "
  Nous te pri -- ons, Sei -- gneur de Sain -- te -- té, pro -- tè -- ge_- nous en cet -- te nuit.
  Qu’en toi nous trou -- vions no -- tre paix, et no -- tre nuit se -- ra pai -- si -- ble.
  \set stanza = #"3. "
  Qu’un lourd som -- meil ne tom -- be pas sur nous_: que l’en -- ne -- mi ne nous sur -- pren -- ne.
  Li -- bè -- re nos corps de tous pé -- chés, qu’ils ne soient pas cou -- pa -- bles de -- vant toi.
  \set stanza = #"4. "
  Que nos yeux goûtent un som -- meil pai -- si -- ble, que no -- tre cœur veil -- le tou -- jours,
  et que ta droi -- te nous pro -- tège et nous garde à ja -- mais en ton a -- mour.
  \set stanza = #"5. "
  Viens et re -- gar -- de, toi le dé -- fen -- seur, re -- pousse au loin notre en -- ne -- mi.
  Di -- rige et con -- duis tes ser -- vi -- teurs que tu as ra -- che -- tés par ton sang.
  \set stanza = #"6. "
  Gar -- de mé -- moi -- re, Sei -- gneur, de tes en -- fants char -- gés du poids de leur pé -- ché.
  Toi le dé -- fen -- seur de notre âme, ai -- de_- nous, Sei -- gneur, dans le com -- bat.
  \set stanza = #"7. "
  Fais_- nous ce don, toi le Pè -- re Tout_- Puis -- sant, par Jé -- sus Christ, no -- tre Sei -- gneur,
  qui vit pour les siè -- cles é -- ter -- nels, et règne a -- vec l’Es -- prit de Sain -- te -- té.
  A -- men.
}


\score {
  \new ChoirStaff 
  <<
    \new Staff = "women" \with { \remove "Time_signature_engraver" } 
    \new Voice = "sopranos" {
      \omit Score.BarLine \key g \minor \time 1/4 \sopMusic
    }
    \new Lyrics \lyricsto "sopranos" \altoWordsun
  >>
}