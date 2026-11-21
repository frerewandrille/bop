\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

% \paper {
%   #(set-paper-size "a5")
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% #(set-global-staff-size 14)
% 
% \header {
%   title = \markup \center-column { "En toi, ô Mère du Sauveur" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
% }
% 
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
    \override InstrumentName.X-offset = 2.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
  } 
}

global = {
  \key g \major
  \time 4/4
}

resp = { \breathe\allowBreak }

sopMusic = \relative c' {
  \partial4 
  d4 g a b e d4. c8 b4\resp
  e4 d c b c8 (d) a2 g4\fermata\bar":|."
  d'4 e e a, a d d g,\resp
  b a g fis g8 (fis) e2 d4\fermata\resp
  d'4 c! b a^\markup\italic"rall." b8 (c) a2 g4
  \fermata \bar "|."
}

altoMusic = \relative c' {
  \partial4 
  b8 (c) d4 d d e8 (fis) g4 fis g 
  g fis g8 (a) b (a) g4 g (fis) d
  g g g fis fis8 (g) a (g) fis4 e
  e e d8 (cis) d4 d d (cis) d
  g8 (fis) e4 d8 (e) fis4 g g (fis) d
}

tenorMusic = \relative c' {
  \partial4 
  g8 (a) b4 a g g8 (a) b4 a8 (d) d4
  c8 (b) a4 e' d e e (d8 c) b4
  b c8 (b) a4 d d a b b g a a a g8 (a) b4 (a8 g) fis4
  g g8 (a) b (c) d4 d d8 (c16 b c8 a) b4
}

bassMusic = \relative c {
  \partial4 
  g4 g' fis g c, b8 (c) d4 g,\resp
  c d e8 (fis) g (fis) e (d) c4 (d) g,\fermata
  g' c, cis d d8 (e) fis4 b, e\resp
  e8 (d) cis (b) a4 d8 (cis) b (a) g4 (a) d\fermata\resp
  b e8 (fis) g4 d8 (c) b (g) d'2 g,4
  \fermata
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  En toi, ô Mè -- re du Sau -- veur,
  prend chair la vraie lu -- miè -- re.
}

altoWordsdeux = \lyricmode {  
  En toi l’at -- ten -- te du Mes -- sie
  se change en es -- pé -- ran -- ce.
  \set shortVocalName = "1."
  Car le Sei -- gneur est a -- vec toi,
  tu es com -- blée de grâ -- ce,
  bé -- nie en -- tre les fem -- mes.
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  En toi, ô Vier -- ge d’Is -- ra -- ël,
  s’est ac -- com -- plie l’Al -- lian -- ce.
}

altoWordsquatre = \lyricmode {  
  Tu mets au mon -- de le sa -- lut
  qu’an -- non -- cent les pro -- phè -- tes_:
  \set shortVocalName = "2."
  Voi -- ci_: la Vier -- ge con -- ce -- vra_;
  l’en -- fant qui naî -- tra d’el -- le
  est "“Dieu" a -- vec les hom -- "mes”."
}

altoWordscinq = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  En toi, É -- pou -- se, l’Es -- prit Saint
  a don -- né chair au Ver -- be.
}

altoWordssix = \lyricmode {  
  L’Es -- prit et toi, vous di -- tes "“Viens !”"
  au fruit de tes en -- trail -- les.
  \set shortVocalName = "3."
  Ceux qui en -- ten -- dent di -- sent_: "“Viens !"
  Des -- cends d’au -- près du Pè -- re_!
  É -- clai -- re nos té -- nè -- "bres !”"
}

altoWordssept = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  En toi, ô Mè -- re des cro -- yants,
  se re -- con -- naît l’É -- gli -- se_;
}

altoWordshuit = \lyricmode {  %\set stanza = #". "
  Car la puis -- san -- ce du Très_- Haut
  la cou -- vre de son om -- bre.
  \set shortVocalName = "4."
  Aus -- si ce -- lui qui naît de toi
  est no -- tre vrai Roy -- au -- me,
  est no -- tre vrai vi -- sa -- ge.
}


\transpose d c
\new ChoirStaff 
<<
  \set ChoirStaff.beamExceptions = #'()
  \set ChoirStaff.baseMoment = #(ly:make-moment 1/4)
  \set ChoirStaff.beatStructure = #'(1 1 1 1)
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
    \new Lyrics = "altoWordsun"
    \new Lyrics = "altoWordsdeux"
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
    \new Lyrics = "altoWordstrois"
    \new Lyrics = "altoWordsquatre"
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
    \new Lyrics = "altoWordscinq"
    \new Lyrics = "altoWordssix"
    \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
    \new Lyrics = "altoWordssept"
    \new Lyrics = "altoWordshuit" 
    \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  
  
  \new Staff = "men" <<
    \clef bass
    \new Voice = "ténors" \with { \consists "Balloon_engraver" } {
      \voiceOne
      << \global \tenorMusic >>
    }
   \new Voice = "basses" {
      \voiceTwo 
      << \global \bassMusic >>
    }
    \context Lyrics = "altoWordsun" \lyricsto "ténors" \altoWordsun
    \context Lyrics = "altoWordsdeux" \lyricsto "ténors" \altoWordsdeux
    \context Lyrics = "altoWordstrois" \lyricsto "ténors" \altoWordstrois
    \context Lyrics = "altoWordsquatre" \lyricsto "ténors" \altoWordsquatre
    \context Lyrics = "altoWordscinq" \lyricsto "ténors" \altoWordscinq
    \context Lyrics  = "altoWordssix" \lyricsto "ténors" \altoWordssix
    \context Lyrics = "altoWordssept" \lyricsto "ténors" \altoWordssept
    \context Lyrics = "altoWordshuit" \lyricsto "ténors" \altoWordshuit
   >>
>>