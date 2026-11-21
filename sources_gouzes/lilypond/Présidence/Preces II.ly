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
PrecesLRefSop = \relative c'' { \tempo "Très vif" g4 f g g2 a4 f2.\resp \silN bes4 (a) g2 f4 g2.
                                \bar"|." } 
PrecesLRefAlt = \relative c' { d4 d d e2 f4 c2. s4 f2 d4 (e!) d d2. }
PrecesLRefTen = \relative c' { bes4 a bes c2 c4 a2. \silN d4 (c) bes (c) a bes2. }
PrecesLRefBas = \relative c' { g4 d g c,2 f4 f2.\resp s4 bes, (f') g (c,) d <g, g'>2. }
PrecesLRefT = \lyricmode { Gloire et lou -- ange à toi, ô Dieu vi -- vant_! }
PrecesVIntroM = \relative c'' { bes\breve*1/8 a8 [g] bes4 \bar"||" }
PrecesVIntroT = \lyricmode { "En paix, prions" le Sei -- gneur_! }
PrecesVRefSop = \relative c'' { g4 g g g f2 4 g2\fermata\resp
                                g4 g g2 f4 (g) a2 4 2\fermata\resp
                                bes4 4 2 a4 (g) 2 f g\fermata
                                \bar"|." }
PrecesVRefAlt = \relative c' { d4 4 4 4 2 4 2 4 4 2 2 f f4 2 4 4 2 4 (d) e2 d d }
PrecesVRefTen = \relative c' { bes4 4 4 4 a2 4 bes2 4 4 2 a4 (bes) c2 4 2 d4 4 2 c4 (bes) c2 a bes }
PrecesVRefBas = \relative c' { g4 4 4 4 d2 4 g2\fermata\resp
                               g4 4 2 d4 (g) f2 4 2\fermata\resp
                               bes4 4 2 f4 (g) c,2 d g\fermata }
PrecesVRefT =  \lyricmode { Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son_! }
PrecesCclM = \relative c'' { bes\breve*1/8 g4 \bar"|" bes\breve*1/8 c bes4 \bar"|" 
                             bes\breve*1/8 a8 [g] bes4 \bar ".|-|" }
PrecesCclRefSop = \relative c'' { \silN bes4 (a) g2 f4 g2. \bar"|." }
PrecesCclRefAlt = \relative c' { s4 f2 d4 (e!) d d2. }
PrecesCclRefTen = \relative c' { \silN d4 (c) bes (c) a bes2. }
PrecesCclRefBas = \relative c { s4 bes (f') g (c,) d g2. }
PrecesCclT =  \lyricmode { À toi, Sei -- gneur_! }
OfficeCclM = \relative c'' { bes\breve*1/8 a8 [g] bes4 \bar ".|-|" }
OfficeCclRefSop = \relative c'' { \tempo "Vif" bes-> a g g2-> f4 g2.\fermata \bar"|." }
OfficeCclRefAlt = \relative c' { f4 4 d e <d \balloonText #'(1 . -2)\markup { "" } >2 d2. }
OfficeCclRefTen = \relative c' { d4 c bes c <a \balloonText #'(1 . 2)\markup { "" } >2 bes2. }
OfficeCclRefBas = \relative c { bes4-> f' g c,-> d2 g2.\fermata }
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
      \new Voice = "alto"
      { \voiceTwo \PrecesLRefAlt }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "soprano" \PrecesLRefT   
    \new Staff %\with {\remove Time_signature_engraver }
    << 
      \new Voice = "ténor"
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
            \new Voice = "alto" \with { \consists "Balloon_engraver"
                                        \override BalloonText.annotation-balloon = ##f }
            { \voiceTwo \OfficeCclRefAlt }
            \new Staff %\with {\remove Time_signature_engraver }
            << \Clefs\new Voice = "ténor" \with { \consists "Balloon_engraver"
                                                  \override BalloonText.annotation-balloon = ##f }
      
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