\version "2.24.0"

\include "vowel-set.ly"

\paper {
  #(set-paper-size "a5" )
  top-margin = 9
  bottom-margin = 10
  left-margin = 10
  right-margin = 10
  print-page-number = ##f
  tagline = "Ne pas emporter ni plier svp"
}

#(set-global-staff-size 14)

\layout {
  indent = #0
  \context {
    \Score \remove "Bar_number_engraver"
  }
}

\header {
  title = \markup \center-column { "Viens, Esprit créateur" }
  subtitle = ""
  poet = ""
  composer =  ""
} 

\layout {
  indent = #0
  \context {
    \Score \remove "Bar_number_engraver"
  }
  \context {
    \Lyrics
    \override LyricText.font-size = #2
    \override LyricSpace.minimum-distance = #1
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}

\markup{ \vspace #0.5 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 1
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

global = {
  \key f \major
  \time 4/2
}

sopMusic = \relative c' {
  \tieDashed\partial 1
  \mergeDifferentlyHeadedOn
  f1 a2 g a bes c~ c\resp a1 a2 f bes g f1\resp
  a2 a g f c' bes \time 6/2 a g a1\resp \bar"||" d, \time 4/2 g2 f bes a g~ g\resp
  a1 a2 bes c bes a~ a\resp\bar"||" f1 d2 e f g a~ a\resp
  f1 a2 a d c \time 6/2 bes a g~ g\resp f f \time 4/2 c' a bes g f1\bar"||"
  f a2 a d\resp c \time 6/2 bes a g1\resp f \time 4/2 c'2 (a) bes (g) f1\fermata
  \bar "|." %c c \bar "|." 
}

altoMusic = \relative c' {
  \tieDashed
  c1 f2 g f f e~ e c1 f2 d f e f1 f2 f c f e g f e f1
  d d4 (e) f2 g fis g~ g f1 f2 f f d c~ c c1 bes2 g d' d cis~ 2
  d1 f2 e d e d4 (c) f2 e~ e d d e f f e f1
  d f2 e d e d4 (c) f2 e1 d e2 (f) f (e) f1
}

tenorMusic = \relative c' {
  \tieDashed
  a1 c2 c c bes g~ g a1 a2 a d c4 (bes) a1 c2 c c a4(bes) c2 d c c c1
  bes g2 c d2. c4 bes2~ 2 a1 a2 d c f, f~ f f1 f2 c' a g e~ e
  d1 a'2 a bes a f4 (g) a (bes) c2~ c a a a a d c4 (bes) a1
  d a2 a bes a f4 (g) a (bes) c1 a a d2 (c4 bes) a1
}

bassMusic = \relative c {
  \tieDashed
  f1 f2 e f d c~ c\resp f1 d2. c4 bes2 c f,1\resp
  f'2 f e d c g a c f,1\resp bes bes2 a g d' g~ g\resp
  d1 d2 bes a bes f'~ f\resp a,1 bes2 c d bes a~ a\resp
  d1 d2 c bes c d4 (e) f2 c~ c\resp d d a d bes c f,1
  d' d2 c bes \resp c d4 (e) f2 c1\resp d a2 (d) bes (c) f,1\fermata
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "  \set shortVocalName = "1."
  \im Viens, Es -- prit cré -- a -- teur, __ \skip4 toi qui viens trans -- for -- mer 
  le pain de la terre en pain de vie_!
  Toi qui con -- çus le Ver -- be en la Vier -- ge très sain -- te, 
  tu viens re -- nou -- ve -- ler __ \skip4 à son i -- mage et res -- sem -- blan -- ce 
  l’hom -- me bri -- sé par la mort.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. "\set shortVocalName = "2."
  \im Viens, Es -- prit de lu -- miè -- re, feu qui des -- cend du ciel, 
  pour il -- lu -- mi -- ner nos pau -- vre -- tés_!
  Maî -- tre du bel a -- mour, __ \skip4 maî -- tre de vraie sa -- ges -- se, 
  tu viens trans -- fi -- gu -- rer __ \skip4 les pro -- fon -- deurs
  du cœur de l’hom -- me sous le so -- leil de ta joie. 
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  \im Viens, Es -- prit qui dé -- li -- vre, sour -- ce de la vraie joie, 
  fais_- nous vi -- vre dans ta li -- ber -- té_!
  Brise au souf -- fle lé -- ger __ \skip4 qui ra -- fraî -- chit nos cœurs_: __ \skip4
  nous en -- ten -- dons ta voix, __ \skip4 et pour -- tant
  nous ne sa -- vons pas __ \skip4 d’où tu viens, ni où tu vas. 
  %Viens Es -- prit-Saint, al -- lé -- luia_! Al -- lé -- luia_!
  \set stanza = #" 1.-6."  \set shortVocalName = ""
  \imstop Viens, Es -- prit_- Saint, al -- lé -- lu -- ia_! Al -- lé -- lu -- ia_!
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  \im Viens, Es -- prit de fraî -- cheur_! __ \skip4
  Que pleu -- ve dans nos cœurs la ro -- sée du ciel qui don -- ne vie_!
  Fais re -- fleu -- rir en nous __ \skip4 le jar -- din de ta grâ -- ce_! 
  Don -- ne_- nous ta dou -- ceur __ \skip4 et con -- ver -- tis nos cœurs
  de pier -- re, nous don -- nant un cœur de chair. 
}

altoWordscinq = \lyricmode {  
  \set stanza = #"5. "\set shortVocalName = "5."
  \im Viens, Es -- prit d’al -- lé -- gres -- se, toi qui nous fais goû -- ter la sa -- ges -- se 
  des se -- crets de Dieu_!
  Par -- fum de bonne o -- deur, __ \skip4 en -- cens du sa -- cri -- fi -- ce, vin d’u -- ne sobre i -- vres -- se, 
  é -- veille en nous le goût
  de Dieu, __ \skip4 et nous vi -- vrons de ta joie.
}

altoWordssix = \lyricmode {  
  \set stanza = #"6. " \set shortVocalName = "6."
  \im Viens, Es -- prit de beau -- té, __ \skip4 toi qui fais con -- tem -- pler 
  tou -- te chose a -- vec des yeux d’en -- fant_!
  Toi, le prin -- temps de Dieu, __ \skip4 fon -- tai -- ne de jeu -- nes -- se, 
  Fleu -- ve du Pa -- ra -- dis,
  __ \skip4 viens ra -- jeu -- nir en nos dé -- serts __ \skip4 nos cœurs vieil -- lis par la mort.
  \set stanza = #" 1.-6."  \set shortVocalName = ""
  \imstop Viens, Es -- prit_- Saint, al -- lé -- lu -- ia_! Al -- lé -- lu -- ia_!
}

%\transpose c b,
\new ChoirStaff 
<<
  \new Staff = "women" \with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne 
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
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordstrois
%   \new Lyrics \lyricsto "sopranos" \altoWordsquatre
%   \new Lyrics \lyricsto "sopranos" \altoWordscinq
%   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
%   \lyricsto "sopranos" \altoWordssix
  
  \new Staff = "men" \with {\remove Time_signature_engraver }
  <<
    \clef bass
    \new Voice = "tenors" \with { \consists "Balloon_engraver" }
    {
      \voiceOne 
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>

\new ChoirStaff 
<<
  \new Staff = "women" \with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne 
      << \global \sopMusic >>
    }
    \new Voice = "altos" \with { \consists "Balloon_engraver" }
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
%   \new Lyrics \lyricsto "sopranos" \altoWordsun
%   \new Lyrics \lyricsto "sopranos" \altoWordsdeux
%   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
%   \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordssix
  
  \new Staff = "men" \with {\remove Time_signature_engraver }
  <<
    \clef bass
    \new Voice = "tenors" \with { \consists "Balloon_engraver" }
    {
      \voiceOne 
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>