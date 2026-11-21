\version "2.24.0"

\paper {
  #(set-paper-size "a5")
  %  top-margin = 15
}

#(set-global-staff-size 18)

\layout { 
  tagline = ##f
  indent = #0
  \context { \Score \remove "Bar_number_engraver"
  }
  \context { \Lyrics \override LyricText.font-size = #2
  }
}

\header {
  title = \markup \center-column { "Au sein de son Église" }
  subtitle = " "
  poet = ""
  composer =  ""
  tagline = ##f
}

global = {
  \key g \major
  \time 2/2
}

sopMusic = \relative c' {
  \partial4 d g b a a b4. (c8) d4 \breathe d c b a a g2. \bar ":|."
  g4 fis e d g g (a) b \breathe b a g g fis g2.\fermata \bar ":|."
}

altoMusic = \relative c' {
  \partial4 b4 b d d d d2 d4 d g g g fis g2.
  d4 c c d b b (e) dis d d b e d d2.
}

tenorMusic = \relative c' {
  \partial4 g4 g g g fis g4. (a8) b4 \breathe a c d d d b2.
  b4 a g g g g (e) fis \breathe g fis g c a b2.
}

bassMusic = \relative c' {
  \partial4 g4 e b c d g2 g4 fis e g d d g,2.
  g4 a c b g e' (c) b g d' e c d <g, g'>2.\fermata
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "
  Au sein de son É -- gli -- se, le Sei -- gneur l’ap -- pe -- la.
  \set stanza = #"1. "
  Le com -- bla de sa -- ges -- se, de gloi -- re, le vê -- tit,
}

altoWordsdeux = \lyricmode {  %\set stanza = #"2. " 
  Pour por -- ter sa Pa -- ro -- le, il lui don -- na l’Es -- prit,
  Et sur lui fit des -- cen -- dre al -- lé -- gresse et bon -- heur.
}

altoWordstrois = \lyricmode {  
  \set stanza = #"2. "
  Aux sour -- ces d’É -- van -- gi -- le, le Sei -- gneur le me -- na,
  \set stanza = #"2. "
  Lui don -- na sans me -- su -- re la sè -- ve du sa -- voir,
}

altoWordsquatre = \lyricmode {  %\set stanza = #"V 3. "
  Le plan -- ta comme un ar -- bre près des eaux du sa -- lut,
  Lui fit en a -- bon -- dan -- ce por -- ter du fruit de choix.
}

altoWordscinq = \lyricmode {  
  \set stanza = #"3. "
  Du tré -- sor de ses grâ -- ces, le Sei -- gneur l’ins -- trui -- sit,
  \set stanza = #"3. "
  Il lui don -- na d’en vi -- vre a -- vec fi -- dé -- li -- té,
}

altoWordssix = \lyricmode {  %\set stanza = #". "
  Dans la nou -- velle Al -- lian -- ce, lui en -- sei -- gna la loi.
  %\set stanza = #". "
  Puis d’en -- sei -- gner l’É -- gli -- se a -- vec hu -- mi -- li -- té.
}

altoWordssept = \lyricmode {  
  \set stanza = #"4. "
  Gloire à toi, no -- tre Pè -- re, qui nous at -- tires à toi,
  \set stanza = #"4. "
  Fais_- nous gran -- dir sans ces -- se dans l’a -- mour de ton Fils,
}

altoWordshuit = \lyricmode {  %\set stanza = #". "
  Pour vivre en ta lu -- miè -- re la joie des fils de Dieu.
  %\set stanza = #". "
  Et re -- cher -- cher ta fa -- ce, gui -- dés par ton Es -- prit.
}

ligne = \lyricmode { \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 "."2.
  \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 \skip 4 "."2.
}

\score {
  \new ChoirStaff <<
    \new Staff = "women" <<
      \new Voice = "sopranos" {
        \voiceOne
        << \global \sopMusic >>
      }
      \new Voice = "altos" {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>
    
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \ligne    
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics \lyricsto "sopranos" \altoWordsquatre
    \new Lyrics \lyricsto "sopranos" \ligne
    \new Lyrics \lyricsto "sopranos" \altoWordscinq
    \new Lyrics \lyricsto "sopranos" \altoWordssix
    \new Lyrics \lyricsto "sopranos" \ligne
    \new Lyrics \lyricsto "sopranos" \altoWordssept
    \new Lyrics \lyricsto "sopranos" \altoWordshuit
    
    \new Staff = "men" <<
      \clef bass
      \new Voice = "tenors" {
        \voiceOne
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo 
        << \global \bassMusic >>
      }
    >>
  >>
}