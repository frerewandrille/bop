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

PrecesLIntroM = \relative c' { e8 d2\resp d\breve*1/8 c8 e4 \bar"||" }
PrecesLIntroT = \lyricmode { En paix, \gauche "louons et bénissons le" Sei -- gneur_! }
PrecesLRefSop = \relative c' { e4 (f) e e2 a4 g2\resp g4 f2 e4 2. \bar"|." } 
PrecesLRefAlt = \relative c' { c4 (d) b c2 f4 d2 e4 d2 b4 c2. }
PrecesLRefTen = \relative c' { a4~ a gis a2 c4 b2 c4 a2 gis4 a2. }
PrecesLRefBas = \relative c { <a a'>4 (d) e <a, a'>2 f'4 g2 \resp c,4 d2 e4 <a, a'>2. }
PrecesLRefT = \lyricmode { Gloire à toi, Sei -- gneur, lou -- ange à toi_! }
PrecesVIntroM = \relative c' { e8 d2\resp d\breve*1/8 c8 e4 \bar"||" }
PrecesVIntroT = \lyricmode { En paix, \gauche "prions le" Sei -- gneur_! }
PrecesVRefSop = \relative c' { e4 4 4 4 f2 e4 2\fermata\resp
            a4-> 4 4 4 g2 e4 2\fermata\resp
            e4 4 4 4 f2 e4 2\fermata
            \bar"|." }
PrecesVRefAlt = \relative c' { c4 4 4 4 d2 b4 c2 f4 4 4 4 d2 cis4 2 cis!4 4 4 4 d2 b4 cis!2 }
PrecesVRefTen = \relative c' { a4 4 4 4 2 gis4 a2 c4 4 4 4 b2 a4 2 4 4 4 4 2 gis4 2 }
PrecesVRefBas = \relative c { a4 4 4 4 d2 e4 a,2\fermata\resp
            f'4-> 4 4 4 g2 a4 2\fermata\resp
            a,4 4 4 4 d2 e4 a,2\fermata }
PrecesVRefT =  \lyricmode { Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son_! }
PrecesCclM = \relative c' { e\breve*1/8 d4 \bar"|" e\breve*1/8 c d4 \bar"|" 
      d\breve*1/8 c8 e4 \bar ".|-|" }
PrecesCclRefSop = \relative c'' { s8 a4 g2 e e2.\resp e4 f2 e e1\fermata \bar"|." }
PrecesCclRefAlt = \relative c' { s8 f4 d2 cis2 2. cis!4 d2 b cis!1 }
PrecesCclRefTen = \relative c' { s8 c4 b2 a a2. 4 2 gis a1 }
PrecesCclRefBas = \relative c { s8 f4 g2 a a2. \resp 4 d,2 e a,1\fermata }
PrecesCclT =  \lyricmode { À toi, Sei -- gneur, à toi, Sei -- gneur_! }
OfficeCclM = \relative c' { e\breve*1/8 d4 d8 [c] e2 \bar ".|-|" }
OfficeCclRefSop = \relative c' { s8 e4 4 4 a2 g4 2.\resp f2 (e4) 2.\fermata \bar"|." }
OfficeCclRefAlt = \relative c' { s8 c4 4 4 f2 d4 e2. d2 (b4) cis2. }
OfficeCclRefTen = \relative c' { s8 a4 4 4 c2 b4 c2. a2 (gis4) a2. }
OfficeCclRefBas = \relative c { s8 <a a'>4 q q f'2 g4 c,2.\resp d2 (e4) a,2.\fermata }
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