\version "2.24.0"

\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes4 \unHideNotes \allowBreak }
armure = { \key bes \major \time 3/4 \cadenzaOn }
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

PrecesLIntroM = \relative c'' { bes8 a2\resp a\breve*1/8 g8 bes2\fermata \bar"||" }
PrecesLIntroT = \lyricmode { En paix, \gauche "louons et bénissons le" Sei -- gneur_! }
PrecesLRefSop = \relative c'' { bes4-> bes a bes2-> bes4 c2-> bes4 a2.\resp a a bes
                                \bar"|." } 
PrecesLRefAlt = \relative c'' { g4 g fis g2 g4 a2 g4 fis!2. g fis! g }
PrecesLRefTen = \relative c' { d4 d d d2 d4 f!2 d4 d2. ees d d }
PrecesLRefBas = \relative c' { g4-> g d g2-> g4 f!2-> g4 d2.\resp c d g }
PrecesLRefT = \lyricmode { Gloire et lou -- ange à toi, Sei -- gneur, gloire à toi_! }
PrecesVIntroM = \relative c'' { bes8 a2\resp a\breve*1/8 g8 bes2\fermata \bar"||" }
PrecesVIntroT = \lyricmode { En paix, \gauche "prions et supplions le" Sei -- gneur_! }
PrecesVRefSop = \relative c'' { bes8 [bes] bes [bes] bes4. bes8 bes4 
                                \(a\) bes8 bes [bes] a2 a bes1
                                \bar"|." }
PrecesVRefAlt = \relative c'' { g8 [g] g [g] g4. g8 g4 \(fis\) g8 g [g] g2 fis! g1 }
PrecesVRefTen = \relative c' { d8 [d] d [d] d4. d8 d4 \(d\) d8 d [d] ees2 d d1 }
PrecesVRefBas = \relative c' { g8 [g] g [g] g4. g8 g4 \(d\) g8 g [g] c,2 d <g, g'>1 }
PrecesVRefT =  \lyricmode { Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son_! }
PrecesCclM = \relative c'' { bes\breve*1/8 g4 \bar"|" bes\breve*1/8 g8 a4 \bar"|" 
                             a\breve*1/8 g8 bes2 \bar ".|-|" }
PrecesCclRefSop = \relative c'' { bes\breve*1/8 bes4.\resp  g8 a2 a bes1 \bar"|." }
PrecesCclRefAlt = \relative c'' { g\breve*1/8 g4. e8 f2 fis g1 }
PrecesCclRefTen = \relative c' { d\breve*1/8 d4. c8 c2 d d1 }
PrecesCclRefBas = \relative c' { g\breve*1/8 g4.\resp c,8 f2 d <g, g'>1 }
PrecesCclT =  \lyricmode { "À toi, Sei" -- gneur, à toi, Sei -- gneur_! }
OfficeCclM = \relative c'' { bes\breve*1/8 a4 a8 [g] bes2\fermata \bar ".|-|" }
OfficeCclRefSop = \relative c'' { bes\breve*1/8 a2 a bes1\fermata \bar"|." }
OfficeCclRefAlt = \relative c'' { g\breve*1/8 g2 fis g1 }
OfficeCclRefTen = \relative c' { d\breve*1/8 ees2 d d1 }
OfficeCclRefBas = \relative c' { g\breve*1/8 c,2 d g1\fermata }
OfficeCclT =  \lyricmode { Bénis -- sons le Sei -- gneur_!_
                           "Nous rendons" grâce à Dieu_! }


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
      \new Voice = "soprano" \armure { \voiceOne \PrecesLRefSop }
      \new Voice = "alto" \with { \consists "Balloon_engraver"
                                  \override BalloonText.annotation-balloon = ##f }
      { \voiceTwo \PrecesLRefAlt }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "soprano" \PrecesLRefT   
    \new Staff %\with {\remove Time_signature_engraver }
    << 
      \new Voice = "ténor" \with { \consists "Balloon_engraver"
                                   \override BalloonText.annotation-balloon = ##f }
      \clef "bass" \armure { \voiceOne \PrecesLRefTen }
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
      \new Voice = "soprano" \armure { \voiceOne \PrecesVRefSop }
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
    \new Staff \with {\remove Time_signature_engraver }
    { \Clefs 
      << \new Voice = "soprano"
         { \armure \PrecesCclM
           << 
             \armure \clef "treble" { \voiceOne \PrecesCclRefSop  }
             \new Voice = "alto" { \voiceTwo \PrecesCclRefAlt }
             \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
             \lyricsto "soprano" \PrecesCclT
             \new Staff \with {\remove Time_signature_engraver }
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
    \new Staff \with {\remove Time_signature_engraver }
    { \Clefs
      <<
        \new Voice = "president" 
        { \omit Staff.TimeSignature \armure { 
          \OfficeCclM
          <<
            \undo \omit Staff.TimeSignature 
            \armure \clef "treble" { \voiceOne \OfficeCclRefSop }      
            \new Voice = "alto" { \voiceTwo \OfficeCclRefAlt }
            \new Staff \with {\remove Time_signature_engraver }
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