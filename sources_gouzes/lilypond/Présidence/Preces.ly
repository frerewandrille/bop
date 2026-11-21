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

PrecesLIntroM = \relative c'' {  }
PrecesLIntroT = \lyricmode { En paix, \gauche "louons et bénissons le" Sei -- gneur_! }
PrecesLRefSop = \relative c'' {  } 
PrecesLRefAlt = \relative c' {  }
PrecesLRefTen = \relative c' {  }
PrecesLRefBas = \relative c {  }
PrecesLRefT = \lyricmode { Gloire et lou -- ange à toi, ô Dieu vi -- vant_! }
PrecesVIntroM = \relative c'' {  }
PrecesVIntroT = \lyricmode { En paix, \gauche "prions le" Sei -- gneur_! }
PrecesVRefSop = \relative c'' {  }
PrecesVRefAlt = \relative c' {  }
PrecesVRefTen = \relative c' {  }
PrecesVRefBas = \relative c {  }
PrecesVRefT =  \lyricmode { Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son_! }
PrecesCclM = \relative c'' {  }
PrecesCclRefSop = \relative c'' {  }
PrecesCclRefAlt = \relative c'' {  }
PrecesCclRefTen = \relative c' {  }
PrecesCclRefBas = \relative c {  }
PrecesCclT =  \lyricmode { À toi, Sei -- gneur_! }
OfficeCclM = \relative c'' {  }
OfficeCclRefSop = \relative c'' {  }
OfficeCclRefAlt = \relative c' {  }
OfficeCclRefTen = \relative c' {  }
OfficeCclRefBas = \relative c {  }
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
\PrecesLIntro
\PrecesLRef
\markup{\vspace #1 \large\bold"Aux Vêpres"}
\PrecesVIntro
\PrecesVRef
\PrecesCcl
\OfficeCcl