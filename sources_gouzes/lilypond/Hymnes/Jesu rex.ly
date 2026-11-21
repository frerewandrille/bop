\version "2.24.0"

\paper {
  two-sided = ##t
  print-page-number = ##f
  top-margin = 15
  bottom-margin = 20
  inner-margin = 10
  outer-margin = 20
}

#(set-global-staff-size 24)

\layout {    
  tagline = ##f
  ragged-last = ##t 
  indent = #0
  \context { 
    \Score \remove "Bar_number_engraver"
  }
  \context { 
    \Lyrics
    %    \override LyricText.font-size = #2
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  }
}

\header {
  tagline = ##f
}

global = {
  \key c \major
  \time 4/4
}

sopMusic = \relative c'' {
  \partial2 a2 a4 g c b a4. a8 a4 \breathe
  f4 e a g f e4. e8 e2 r
  a2 b b c4 a g4. g8 g1
  r4 c c b a4. a8 a4 g f \breathe
  f4 f e d4. d8 d4 cis d2\fermata \bar":|." \break d d\fermata \bar"|."
}

altoMusic = \relative c' {
  \partial2 f2 e4 d e e f4. f8 f4 \breathe
  a4 g f e d cis4. cis8 cis2 r
  e2 gis gis a4 f e4. e8 e4 \breathe
  e4 e d e4. e8 e4 e f2
  r2 a a4 g f4. f8 f4 e d2\fermata d d\fermata
}

bassMusic = \relative c' {
  \partial2 d2 c4 b a g f4. f8 f4 \breathe
  f4 c' f, g g a4. a8 a2 r
  a2 e e a4 a c4. c,8 c4 \breathe
  c'4 c b a4. a8 a4 g f \breathe
  f4 f e d2 c d8(e f g a4.) a8 d,2\fermata d d\fermata
}


altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Ie -- su, Rex ad -- mi -- ra -- bi -- lis
  et tri -- um -- pha -- tor no -- bi -- lis,
  dul -- ce -- do in -- ef -- fa -- bi -- lis,
  to -- tus de -- si -- de -- ra -- bi -- lis,
  to -- tus de -- si -- de -- ra -- bi -- lis:
}

altoWordsdeux = \lyricmode {  
  \override Lyrics.LyricText.font-shape = #'italic
  \set shortVocalName = "2." \set stanza = #"2. " 
  Rex vir -- tu -- tum, rex glo -- ri -- æ,
  rex in -- si -- gnis vic -- to -- ri -- æ,
  Ie -- su, lar -- gi -- tor gra -- ti -- æ,
  ho -- nor cæ -- les -- tis cu -- ri -- æ,
  ho -- nor cæ -- les -- tis cu -- ri -- æ:
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Te cæ -- li cho -- rus præ -- di -- cat
  et tu -- as lau -- des re -- pli -- cat.
  Ie -- sus or -- bem læ -- ti -- fi -- cat
  et nos De -- o pa -- ci -- fi -- cat,
  et nos De -- o pa -- ci -- fi -- cat. 
}

altoWordsquatre = \lyricmode {  
  \override Lyrics.LyricText.font-shape = #'italic
  \set shortVocalName = "4." \set stanza = #"4. "
  Ie -- sus in pa -- ce im -- pe -- rat,
  quæ om -- nem sen -- sum su -- pe -- rat,
  hanc sem -- per mens de -- si -- de -- rat
  et il -- lo fru -- i pro -- pe -- rat,
  et il -- lo fru -- i pro -- pe -- rat.
}

altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  Iam pro -- se -- qua -- mur lau -- di -- bus
  Ie -- sum, hym -- nis et pre -- ci -- bus,
  ut nos do -- net cæ -- les -- ti -- bus
  cum ip -- so fru -- i se -- di -- bus,
  cum ip -- so fru -- i se -- di -- bus. 
}

altoWordssix = \lyricmode {  
  \override Lyrics.LyricText.font-shape = #'italic
  \set shortVocalName = "6." \set stanza = #"6. "
  Ie -- su, flos ma -- tris vir -- gi -- nis,
  a -- mor nos -- træ dul -- ce -- di -- nis,
  laus ti -- bi si -- ne ter -- mi -- nis,
  re -- gnum be -- a -- ti -- tu -- di -- nis,
  re -- gnum be -- a -- ti -- tu -- di -- nis.
  A -- men. 
}

basseWordsun = \lyricmode {    
  \skip 2 \repeat unfold 30 { \skip 1 } \set stanza = #"1. "
  lis,
  to -- tus de -- si -- de -- ra -- bi -- lis:
}

basseWordsdeux = \lyricmode {  
  \override Lyrics.LyricText.font-shape = #'italic
  \skip 2 \repeat unfold 30 { \skip 1 } \set stanza = #"2. "
  æ,
  ho -- nor cæ -- les -- tis cu -- ri -- æ:
}

basseWordstrois = \lyricmode {  
  \skip 2 \repeat unfold 30 { \skip 1 } \set stanza = #"3. "
  cat,
  et nos De -- o pa -- ci -- fi -- cat.
}

basseWordsquatre = \lyricmode {  
  \override Lyrics.LyricText.font-shape = #'italic
  \skip 2 \repeat unfold 30 { \skip 1 } \set stanza = #"4. "
  rat,
  et il -- lo fru -- i pro -- pe -- rat.
}

basseWordscinq = \lyricmode {  
  \skip 2 \repeat unfold 30 { \skip 1 } \set stanza = #"5. "
  bus,
  cum ip -- so fru -- i se -- di -- bus.
}

basseWordssix = \lyricmode {  
  \override Lyrics.LyricText.font-shape = #'italic
  \skip 2 \repeat unfold 30 { \skip 1 } \set stanza = #"6. "
  nis,
  re -- gnum be -- a -- ti -- tu -- di -- nis.
}

\markup {\vspace #15 \fill-line \bold \fontsize #8  {"Iesu, rex admirabilis" }}
\markup {\vspace #3 \fill-line    {"Texte cistercien anglais de la fin du XIIe siècle"}}
\markup {\vspace #1 \fill-line    {"Musique de Pierluigi da Palestrina"}}
\pageBreak

\score {
  \new ChoirStaff <<
    \new Staff = "women" <<
      \new Voice = "sopranos" {
        << \global \sopMusic >>
      }
    >>
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordstrois
    \new Lyrics \lyricsto "sopranos" \altoWordsquatre
    \new Lyrics \lyricsto "sopranos" \altoWordscinq
    \new Lyrics \lyricsto "sopranos" \altoWordssix
    
    \new Staff = "women2" <<
      \new Voice = "altos" {
        << \global \altoMusic >>
      }
    >>
    \new Lyrics \lyricsto "altos" \altoWordsun
    \new Lyrics \lyricsto "altos" \altoWordsdeux
    \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "altos" \altoWordstrois
    \new Lyrics \lyricsto "altos" \altoWordsquatre
    \new Lyrics \lyricsto "altos" \altoWordscinq
    \new Lyrics \lyricsto "altos" \altoWordssix

    \new Staff = "men" <<
      \clef bass
      \new Voice = "basses" {
        << \global \bassMusic >>
      }
    >>
    \new Lyrics \lyricsto "basses" \basseWordsun
    \new Lyrics \lyricsto "basses" \basseWordsdeux
    \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "basses" \basseWordstrois
    \new Lyrics \lyricsto "basses" \basseWordsquatre
    \new Lyrics \lyricsto "basses" \basseWordscinq
    \new Lyrics \lyricsto "basses" \basseWordssix
  >>
}

\markup { \vspace #4
          \fill-line {
            \column {
              \line { Jésus, le roi très admirable }
              \line {Et le noble triomphateur, }
              \line { La douceur que nul mot ne dit, }
              \line { Le totalement désirable : }
              \line { " "}
              \line { Roi des puissances, roi de gloire, }
              \line { Roi de victoire sans égal, }
              \line { Jésus, donateur de tout bien, }
              \line { Honneur de l’assemblée des anges : }
              \line { " "}
              \line { Toi que les chœurs du ciel proclament, }
              \line { Qu’ils ne se lassent d’acclamer, }
              \line { Tu nous mets en paix avec Dieu, }
              \line { Tu es, Jésus, la joie du monde. }
              \line { " "}
              \line { C’est dans la paix que Jésus règne, }
              \line { D’une paix qui passe nos sens, }
              \line { Celle que cherchent tant les cœurs, }
              \line { En avant-goût de la rencontre. }
              \line { " "}
              \line { Dès maintenant, chantons des hymnes, }
              \line { Louons Jésus, supplions-le }
              \line { Pour qu’il nous donne de goûter }
              \line { Avec lui les joies du Royaume. }
              \line { " "}
              \line { Jésus, fleur d’une vierge mère, }
              \line { Amour pour nous plein de douceur, }
              \line { À toi, les louanges sans fin }
              \line { Et la royauté bienheureuse ! }
              \line { " "}
            }
          }
}


%{
convert-ly (GNU LilyPond) 2.18.2  convert-ly: Traitement de «  »...
Conversion en cours : 2.17.0, 2.17.4, 2.17.5, 2.17.6, 2.17.11,
2.17.14, 2.17.15, 2.17.18, 2.17.19, 2.17.20, 2.17.25, 2.17.27,
2.17.29, 2.17.97, 2.18.0
%}
