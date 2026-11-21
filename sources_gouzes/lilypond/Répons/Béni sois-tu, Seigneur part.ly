\version "2.24.0"

\include "vowel-set.ly"

\paper {
  #(set-paper-size "a5")
  top-margin = 12
  bottom-margin = 15
}

#(set-global-staff-size 15)

\layout { 
  indent = #0
  \context { \Score 
             \remove "Bar_number_engraver"
             \override TimeSignature.style = #'single-digit

  }
  \context { \Lyrics \override LyricText.font-size = #2
             \override LyricSpace.minimum-distance = #1
  }
}

\header {
  title = \markup \center-column { "Béni sois-tu, Seigneur Jésus" }
  subtitle = ""
  poet = ""
  composer =  ""
  tagline = "Ne pas emporter ni plier svp"
}

\layout { 
  \context { \Lyrics \override  InstrumentName.X-offset = 0.8
             \override InstrumentName.font-size = 0
             \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key c \major
  \time 2/2
}

sopMusic = \relative c' {
  \partial 4 e4 g2 a g4 c c b c1 b4\rest c b a d2 c b4 (a2 gis4) a1 \bar "|."
  b4\rest a a a \omit Staff.TimeSignature \time 6/4 b2 a4 g2 fis4 \time 2/2 g2 b4\rest g a b c b a2 b %\break
  b\rest b4\rest e,4 g2 a g4 c c b c1 b4\rest c b a d2. c4 b4 (a2 gis4) a1 \bar ":|."
} 
altoMusic = \relative c' {
  \partial4 c4 e2 f g4 g a g g1 s4 a g f f2 a f (e) e1
  s4 e e fis g2 e4 d2 d4 d2 s4 e e g g g e2 e
  s s4 c4 e2  c4 (d) e g a g g1 s4 a g f f2. e4 e (c f e) e1
}
tenorMusic = \relative c' {
  \partial4 a4 b2 c c4 e f d e1 s4 e e c d2 e d (b) cis1
  s4 c! c c d2 c4 b2 a4 b2 s4 b c d e d c (b8 a) gis2
  s s4 a b2 a4 (b) c c f d e1 s4 e e c d (a2) a4 gis (a d b) c1
}
bassMusic = \relative c' {
  \partial4 a4 g2 f e4 c f g c,1 d4\rest a e' f d2 a d (e) a,1
  d4\rest a' a a \omit Staff.TimeSignature g2 c,4 d2 d4 <g, g'>2 d'4\rest e a g c, g' a2 e
  d\rest d4\rest a' e2 f c4 e f g c,1 d4\rest a e' f d2. a4 e' (f d e) a,1
}

sopWords = \lyricmode {
  \set stanza = #"Ref. " Bé -- ni sois_- tu, Sei -- gneur Jé -- sus, pour ton É -- gli -- se sain -- te_!
}
IWords = \lyricmode {
  \set shortVocalName = "1. " \set stanza = #"1. " 
  Tu fais de nous un peu -- ple saint par le sang de ta Pâ -- que,
  Et nous pro -- cla -- mons ton sa -- lut, at -- ten -- dant que tu vien -- nes.
}
IIWords = \lyricmode {
  \set shortVocalName = "2. " \set stanza = #"2. " %Vous tous, ser -- vi -- teurs du Seig -- neur, ve -- nez à son ser -- vi -- ce,
  %Vous qu’il choi -- sit pour ser -- vi -- teur, que vos cœurs le bé -- nis -- se_!
  Et vous, dis -- ci -- ples du Sei -- gneur, ac -- cou -- rez à sa sui -- te,
  Vous qu’il choi -- sit pour ser -- vi -- teurs, que vo -- tre cœur l’ac -- cla -- me_!
}
IIIWords = \lyricmode {
  \set shortVocalName = "3. " \set stanza = #"3. " 
  Jé -- sus fait de vous ses a -- mis, c’est lui qui vous ap -- pel -- le.
  Tout ce que Dieu lui a don -- né, il vous l’a fait con -- naî -- tre.
}
IVWords = \lyricmode {
  \set shortVocalName = "4.   " \set stanza = #"4. " 
  Qu’il vous ha -- bi -- te de son feu, vous re -- vê -- te de for -- ce,
  Et vous i -- rez dans l’as -- sem -- blée pro -- cla -- mer l’É -- van -- gi -- le.
}
VWords = \lyricmode {
  \set shortVocalName = "5. " \set stanza = #"5. " 
  Chan -- tons le Père in -- en -- gen -- dré, lou -- ons le Fils u -- ni -- que,
  Dans la puis -- san -- ce de l’Es -- prit, qui fait de nous son peu -- ple.
}
Blanc = \lyricmode { \repeat unfold 15 \skip4 }

\markup { \vspace #4 }
\score {
  \new ChoirStaff <<
    \new Staff = "women" <<
      \new Voice = "sopranos" {
        \voiceOne
        << \global \sopMusic >> %\cadenzaOn\tonIVaf
      }
      \new Voice = "altos" {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>
    
    \new Lyrics \lyricsto "sopranos" { \Blanc \IWords }
    \new Lyrics \lyricsto "sopranos" { \Blanc \IIWords }
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "sopranos" { \sopWords \IIIWords }
    \new Lyrics \lyricsto "sopranos" { \Blanc \IVWords }
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "sopranos" { \Blanc \VWords }

    \new Staff = "men" <<
      \clef bass
      \new Voice = "tenors" {
        \voiceOne
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo << \global \bassMusic >> %\cadenzaOn\tonIVah
      }
    >>
  >>
}