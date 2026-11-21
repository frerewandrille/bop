\version "2.24.0"

\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes4 \unHideNotes \allowBreak }
armure = { \key g \minor \time 3/4 \cadenzaOn }
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

PrecesLIntroM = \relative c'' { bes\breve*1/8 a8 [g] bes4 \bar"||" }
PrecesLIntroT = \lyricmode { "En paix, louons et bénissons" le Sei -- gneur_! }
PrecesLRefSop = \relative c' { f4 (ees) f g2 f4 2\resp bes4 2 a4 bes2
                               \bar"|." } 
PrecesLRefAlt = \relative c' { d4 (c) d ees2 c4 d2 f4 g2 f4 2 }
PrecesLRefTen = \relative c' { bes2 4 2 a4 bes2 d4 ees (d) c d2 }
PrecesLRefBas = \relative c { bes2 4 ees2 f4 bes,2\resp 4 ees2 f4 <bes, bes'>2 }
PrecesLRefT = \lyricmode { Gloire à toi, Sei -- gneur, lou -- ange à toi_! }
PrecesVIntroM = \relative c'' { bes\breve*1/8 a8 [g] bes4 \bar"||" }
PrecesVIntroT = \lyricmode { "En paix, prions" le Sei -- gneur_! }
PrecesVRefSop = \relative c' { f4 4 ees f g2 f4 2\fermata\resp
                               bes4 4 4 4 2 a4 bes2\fermata\resp
                               d4 d c d ees2 4 d2\fermata
                               \bar"|." }
PrecesVRefAlt = \relative c' { d4 d c d ees2 c4 d2 f4 f ees f g2 f4 2 bes4 4 4 4 2 a4 bes2 }
PrecesVRefTen = \relative c' { bes4 4 4 4 2 a4 bes2 d4 d c d ees2 c4 d2 f4 f ees f g2 f4 2 }
PrecesVRefBas = \relative c { bes4 4 4 4 ees2 f4 bes,2\fermata\resp
                              bes'4 4 4 4 ees,2 f4 bes,2\fermata\resp
                              bes'4 4 4 4 ees,2 f4 bes2\fermata }
PrecesVRefT =  \lyricmode { Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son_! }
PrecesCclM = \relative c'' { bes\breve*1/8 g4 \bar"|" bes\breve*1/8 c bes4 \bar"|" 
                             bes\breve*1/8 a8 [g] bes4 \bar ".|-|" }
PrecesCclRefSop = \relative c'' { bes4 2 a4 bes1 \bar"|." }
PrecesCclRefAlt = \relative c' { f4 g2 f4 1 }
PrecesCclRefTen = \relative c' { d4 ees (d) c d1 }
PrecesCclRefBas = \relative c' { bes4 ees,2 f4 bes1 }
PrecesCclT =  \lyricmode { À toi, Sei -- gneur_! }
OfficeCclM = \relative c'' { bes\breve*1/8 a8 [g] bes4 \bar ".|-|" }
OfficeCclRefSop = \relative c'' { bes4 4 4 2 a4 bes2\fermata \bar"|."  }
OfficeCclRefAlt = \relative c' { f4 ees f g2 f4 2 }
OfficeCclRefTen = \relative c' { d4 c d ees2 c4 d2 }
OfficeCclRefBas = \relative c { <bes bes'>4 q q ees2 f4 <bes, bes'>2\fermata }
OfficeCclT =  \lyricmode { Bénissons le Sei -- gneur_!_
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
      \new Voice = "soprano" \armure { \voiceOne \PrecesLRefSop }
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