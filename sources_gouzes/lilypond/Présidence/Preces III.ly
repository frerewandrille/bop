\version "2.24.0"

\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes4 \unHideNotes \allowBreak }
armure = { \key g \major \time 3/4 \cadenzaOn }
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

PrecesLIntroM = \relative c'' { g\breve*1/8 fis8 [e] g2 \bar"||" }
PrecesLIntroT = \lyricmode { "En paix, louons et bénissons" le Sei -- gneur_! }
PrecesLRefSop = \relative c'' { \tempo "Très vif" g4-> a b b-> (c) b a2.\resp c2-> b4 a2-> g4 a2.\fermata
                                \bar"|." } 
PrecesLRefAlt = \relative c' { e4 fis g g (e) g fis2. 
                               e2 e4 fis <e \balloonText #'(1 . -2)\markup { "" } >2 fis 2. }
PrecesLRefTen = \relative c' { b4 d d e (c) c d2. 
                               c2 4 d <b \balloonText #'(1 . 2)\markup { "" } >2 d2. }
PrecesLRefBas = \relative c { e4-> d g e-> (a) a d,2.\resp a'2-> 4 d,-> e2 d2.\fermata }
PrecesLRefT = \lyricmode { Gloire et lou -- ange à toi, gloire à toi, Sei -- gneur_! }
PrecesVIntroM = \relative c'' { g\breve*1/8 fis8 [e] g2 \bar"||" }
PrecesVIntroT = \lyricmode { "En paix, prions" le Sei -- gneur_! }
PrecesVRefSop = \relative c'' { g4 g g g g2 a4 a2\fermata\resp
                                a4 4 4 4 c2 a4 2\fermata\resp
                                a4 4 4 4 g2 a4 2\fermata
                                \bar"|." }
PrecesVRefAlt = \relative c' { e4 4 4 4 2 4 fis2 4 4 4 4 g2 4 fis2 4 4 4 4 e2 g4 fis2 }
PrecesVRefTen = \relative c' { b4 4 4 4 2 c4 d2 4 4 4 4 e2 4 d2 4 4 4 4 b2 c4 <a d>2 }
PrecesVRefBas = \relative c { e4 4 4 4 2 a,4 d2\fermata\resp
                              d4 4 4 4 a2 c4 d2\fermata\resp
                              d4 4 4 4 e2 a,4 d2\fermata }
PrecesVRefT =  \lyricmode { Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son_! }
PrecesCclM = \relative c' { e4 \bar"|" g\breve*1/8 a g4 \bar"|" 
                            g\breve*1/8 fis8 [e] g4 \bar ".|-|" }
PrecesCclRefSop = \relative c'' { a4 b2 c\fermata a\fermata \bar"|." }
PrecesCclRefAlt = \relative c' { fis4 g (fis) e2 fis }
PrecesCclRefTen = \relative c' { d4 d2 c d }
PrecesCclRefBas = \relative c { d4 g2 a\fermata d,\fermata }
PrecesCclT =  \lyricmode { À toi, Sei -- gneur_!_ }
OfficeCclM = \relative c'' { g\breve*1/8 fis8 [e] g2 \bar ".|-|" }
OfficeCclRefSop = \relative c'' { a4 b2 4 c2 4 a2.\resp g2 (a4) 2.\fermata \bar"|."  }
OfficeCclRefAlt = \relative c' { fis4 g2 fis4 e2 g4 fis2. e fis }
OfficeCclRefTen = \relative c' { d4 2 4 c2 4 d2. b2 (c4) d2. }
OfficeCclRefBas = \relative c { d4 g2 4 a2 4 d,2.\resp e2 (a,4) d2.\fermata }
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
\PrecesLIntro\PrecesLRef
\markup{\vspace #1 \large\bold"Aux Vêpres"}
\PrecesVIntro\PrecesVRef
\PrecesCcl
\OfficeCcl