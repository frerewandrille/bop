\version "2.24.0"

\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes4 \unHideNotes \allowBreak }
armure = { \key f \major \time 3/4 \cadenzaOn }
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

PrecesLIntroM = \relative c' { f\breve*1/8 e8 [d] f4 \bar"||" }
PrecesLIntroT = \lyricmode { "En paix, louons et bénissons" le Sei -- gneur_! }
PrecesLRefSop = \relative c'' { \tempo "Très vif"
                                a4 a a2. 4 d2 c c1\resp 
                                bes2\fermata^\pp a\fermata a1 \fermata
                                \bar"|." } 
PrecesLRefAlt = \relative c' { f4 e f2. 4 2 g a1 g2 e f1 }
PrecesLRefTen = \relative c' { d4 cis d2. d4 2 e f1 d2 cis d1 }
PrecesLRefBas = \relative c { d4 a' d,2. d4 <bes bes'>2 <c c'> f1\resp
                              g2\fermata a\fermata d,1\fermata }
PrecesLRefT = \lyricmode { Gloire à toi, ô Dieu vi -- vant, gloire à toi_! }
PrecesVIntroM = \relative c' { f\breve*1/8 e8 [d] f4 \bar"||" }
PrecesVIntroT = \lyricmode { "En paix, prions" le Sei -- gneur_! }
PrecesVRefSop = \relative c'' { a4-> a a a a2-> 4 a2\fermata\resp
                                a4-> a g a bes2-> a4 2\fermata\resp
                                a4 a a f g2 a a\fermata
                                \bar"|." }
PrecesVRefAlt = \relative c' { f4 f f f e2 4 f2 4 f e f g2 e4 f2 4 f f d e2 e f }
PrecesVRefTen = \relative c' { d4 d d d cis2 4 d2 4 d d d d2 cis!4 d2 4 4 4 a c2 cis d }
PrecesVRefBas = \relative c { d4-> 4 4 4 a'2-> 4 d,2\fermata\resp
                              d4-> d d d g2-> a4 d,2\fermata\resp
                              d4-> d d d c2-> a d\fermata }
PrecesVRefT =  \lyricmode { Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son_! }
PrecesCclM = \relative c' { f\breve*1/8 d4 \bar"|" f\breve*1/8 g f4 \bar"|" 
                            f\breve*1/8 e8 [d] f4 \bar ".|-|" }
PrecesCclRefSop = \relative c'' { a4 bes2 a a1\fermata \bar"|." }
PrecesCclRefAlt = \relative c' { f4 g2 e f1 }
PrecesCclRefTen = \relative c' { d4 d2 cis d1 }
PrecesCclRefBas = \relative c { d4 g2 a d,1\fermata }
PrecesCclT =  \lyricmode { À toi, Sei -- gneur_! }
OfficeCclM = \relative c' { f\breve*1/8 e8 [d] f4 \bar ".|-|" }
OfficeCclRefSop = \relative c'' { a4-> a a d2-> c4 2.\fermata \resp
                                  bes (a) a1\fermata \bar"|." }
OfficeCclRefAlt = \relative c' { f4 e f f2 g4 a2. g (e) f1 }
OfficeCclRefTen = \relative c' { d4 cis d4 2 e4 f2. d (cis!) d1 }
OfficeCclRefBas = \relative c { d4-> a' d, bes'2-> c4 f,2.\fermata\resp g (a) d,1\fermata }
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