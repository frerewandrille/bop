\version "2.24.0"

\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes4 \unHideNotes \allowBreak }
armure = { \key c \major \time 3/4 \cadenzaOn }
resp = { \breathe }
silN = { \oneVoice r4 \voiceOne }
\defineBarLine "|." #'("|." "" "")
Clefs = { \override Score.BreakAlignment.break-align-orders =
          #(make-vector 3 '(left-edge
                            staff-bar
                            clef
                            key-signature
                            time-signature))
          \override Staff.Clef.full-size-change = ##t
}

PrecesLIntroM = \relative c'' { a8 g2\resp g\breve*1/8 f8 a4 \bar"||"}
PrecesLIntroT = \lyricmode { En paix, \gauche "louons et bénissons le" Sei -- gneur_! }
PrecesLRefSop = \relative c'' { a4 g a c (b) c a2. \resp \silN c4 (b) a2 4 a2. \bar"|." } 
PrecesLRefAlt = \relative c' { f4 e f e (f) g f2. s4 g2 e4 (f) d8 ([e]) f2. }
PrecesLRefTen = \relative c' { c4 c c c (d) e c2. \silN e4 (d) c2 b4 c2. }
PrecesLRefBas = \relative c { f4 c f a (g) c, f2.\resp s4 c (g') a (f) g f2. }
PrecesLRefT = \lyricmode { Gloire et lou -- ange à toi, ô Dieu vi -- vant_! }
PrecesVIntroM = \relative c'' { a8 g2\resp g\breve*1/8 f8 a4 \bar"||" }
PrecesVIntroT = \lyricmode { En paix, \gauche "prions le" Sei -- gneur_! }
PrecesVRefSop = \relative c'' { a2 4 g g a2 f4 f2\fermata\resp
                                a2 g4 a c b2 4 2\fermata\resp
                                c2 b4 a a g2 a4 2\fermata
                                \bar"|." }
PrecesVRefAlt = \relative c' { f2 4 d d f2 c4 2 f e4 f e g2 4 2 2 4 e f d (e) f f2 }
PrecesVRefTen = \relative c' { c2 4 b b c2 a4 2 c c4 c c d2 4 2 e d4 c c b2 c4 2 }
PrecesVRefBas = \relative c { f2 4 g g f2 4 2\fermata\resp
                              f2 c4 f a g2 4 2 \fermata\resp
                              c, g'4 a f g2 f4 2\fermata }
PrecesVRefT =  \lyricmode { Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son_! }
PrecesCclM = \relative c'' { a\breve*1/8 g4 \bar"|" a\breve*1/8 f g4 \bar"|" 
                             g\breve*1/8 f8 a4 \bar".|" }
PrecesCclRefSop = \relative c'' { c2 (b4) a2 g4 a2.\fermata \bar"|." }
PrecesCclRefAlt = \relative c'' { g2. e4 (f) d8 ([e]) f2. }
PrecesCclRefTen = \relative c' { e2 (d4) c2 b4 c2. }
PrecesCclRefBas = \relative c { c2 (g'4) a (f) g f2.\fermata }
PrecesCclT =  \lyricmode { À toi, Sei -- gneur_! }
OfficeCclM = \relative c'' { a\breve*1/8 g4 g8 [f] a4 \bar".|" }
OfficeCclRefSop = \relative c'' { a4 g a c (b) c a2.\resp g a2.\fermata \bar"|." }
OfficeCclRefAlt = \relative c' { f4 e f e (g) g f2. d2 (e4) f2. }
OfficeCclRefTen = \relative c' { c4 c c c (d) e c2. b c }
OfficeCclRefBas = \relative c { f4 c f a (g) c, f2.\resp g f2.\fermata }
OfficeCclT =  \lyricmode { Bénis -- sons le Sei -- gneur_!_
                           Nous ren -- dons grâce à Dieu, a -- men_! }


PrecesLIntro = 
{
  \new Staff \with {\remove Time_signature_engraver }
  <<
    \override Score.SystemStartBar.collapse-height = #4
    \new Voice = "president" { \armure \PrecesLIntroM }
    \new Lyrics \lyricsto "president" \PrecesLIntroT
  >>
}

PrecesLRef = 
{
  \new StaffGroup
  << 
    \new Staff %\with {\remove Time_signature_engraver }
    << 
      \new Voice = "soprano" \tempo "Très vif" \armure { \voiceOne \PrecesLRefSop }
      \new Voice = "alto" { \voiceTwo \PrecesLRefAlt }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "soprano" \PrecesLRefT   
    \new Staff %\with {\remove Time_signature_engraver }
    << 
      \new Voice = "ténor" \clef "bass" \armure { \voiceOne \PrecesLRefTen }
      \new Voice = "basse" { \voiceTwo \PrecesLRefBas }
    >>
  >>
}


PrecesVIntro =
{
  \new Staff \with {\remove Time_signature_engraver }
  <<
    \override Score.SystemStartBar.collapse-height = #4
    \new Voice = "president" { \armure \PrecesVIntroM }
    \new Lyrics \lyricsto "president" \PrecesVIntroT
  >>
}

PrecesVRef =
{
  \new StaffGroup
  << 
    \new Staff \with {\remove Time_signature_engraver }
    << 
      \new Voice = "soprano" \tempo "Très vif" \armure { \voiceOne \PrecesVRefSop }
      \new Voice = "alto" { \voiceTwo \PrecesVRefAlt }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "soprano" \PrecesVRefT   
    \new Staff \with {\remove Time_signature_engraver }
    << 
      \new Voice = "ténor" \clef "bass" \armure { \voiceOne \PrecesVRefTen }
      \new Voice = "basse" { \voiceTwo \PrecesVRefBas }
    >>
  >>
}


PrecesCcl =
{
  \new StaffGroup 
  << 
    \override Score.SystemStartBar.collapse-height = #4
    \new Staff %\with {\remove Time_signature_engraver }
    { \Clefs 
      << \new Voice = "soprano"
         { \omit Staff.TimeSignature \armure \PrecesCclM
           << 
            \undo \omit Staff.TimeSignature 
             \armure \clef "treble" { \voiceOne \PrecesCclRefSop  }
             \new Voice = "alto" { \voiceTwo \PrecesCclRefAlt }
             \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
             \lyricsto "soprano" \PrecesCclT
             \new Staff %\with {\remove Time_signature_engraver }
             << \Clefs \new Voice = "ténor" \clef "bass" \armure { \voiceOne \PrecesCclRefTen }
                \new Voice = "basse" { \voiceTwo \PrecesCclRefBas }
             >>
           >>
         }
      >>
    }   
  >>
}

OfficeCcl =
{
  \new StaffGroup 
  << 
    \override Score.SystemStartBar.collapse-height = #4
    \new Staff %\with {\remove Time_signature_engraver }
    { \Clefs
      <<
        \new Voice = "president" 
        { \omit Staff.TimeSignature \armure { 
          \OfficeCclM
          <<
            \undo \omit Staff.TimeSignature 
            \armure \clef "treble" { \voiceOne \OfficeCclRefSop }      
            \new Voice = "alto" { \voiceTwo \OfficeCclRefAlt }
            \new Staff %\with {\remove Time_signature_engraver }
            << \Clefs\new Voice = "ténor"
               \clef "bass" \armure { \voiceOne \OfficeCclRefTen }
               \new Voice = "basse" { \voiceTwo \OfficeCclRefBas }
            >>
          >>
          }
        }
        \new Lyrics \with { \override VerticalAxisGroup.staff-affinity = #CENTER }
        \lyricsto "president" \OfficeCclT
      >>
    }
  >>
}

\markup\large\bold"Aux Laudes"
\PrecesLIntro\PrecesLRef
\markup{\vspace #1 \large\bold"Aux Vêpres"}
\PrecesVIntro\PrecesVRef
\PrecesCcl
\OfficeCcl