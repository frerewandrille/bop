\version "2.24.0"

\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes4 \unHideNotes \allowBreak }
armure = { \key a \major \time 3/4 \cadenzaOn }
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

PrecesLIntroM = \relative c'' { a\breve*1/8 gis8 [fis] a4 \bar"||" }
PrecesLIntroT = \lyricmode { "En paix, louons et bénissons" le Sei -- gneur_! }
PrecesLRefSop = \relative c'' { a2 4 4 gis a b2. b4 a2 a gis\resp
                                cis b4 cis d2. (cis4 b2) a gis1
                                \bar"|." } 
PrecesLRefAlt = \relative c' { e2 4 4 4 4 2. 4 2 2 2 a2 4 4 1 (gis2) e4 (fis) e1 }
PrecesLRefTen = \relative c' { cis2 4 4 b cis d2. 4 cis2 2 b e d4 e fis2. (e4 d2) cis b1 }
PrecesLRefBas = \relative c' { a2 4 4 e a gis2. 4 a2 a e\resp a2 4 4 d,1 (e2) a e1 }
PrecesLRefT = \lyricmode { Gloire et lou -- ange à toi, ô Dieu vi -- vant, gloire et lou -- ange à toi_! }
PrecesVIntroM = \relative c'' { a\breve*1/8 gis8 [fis] a4 \bar"||" }
PrecesVIntroT = \lyricmode { "En paix, prions" le Sei -- gneur_! }
PrecesVRefSop = \relative c'' { a2. 4 gis a b2. a4 gis1\fermata\resp
                                b2. b4 a b cis2. a4 1\fermata\resp
                                cis2. 4 b cis d2. (cis4 b2) a gis1\fermata
                                \bar"|." }
PrecesVRefAlt = \relative c' { e2. 4 4 4 2. 4 1 2. 4 4 gis a2. e4 1 a2. 4 4 4 1 (gis2) e4 (fis) e1 }
PrecesVRefTen = \relative c' { cis2. 4 b cis d2. cis4 b1 d2. 4 cis d e2. cis4 1 e2. 4 d e fis2. (e4 d2) cis b1 }
PrecesVRefBas = \relative c' { a2. 4 e a gis2. a4 e1\fermata\resp
                               gis2. 4 a e a2. 4 1\fermata\resp
                               a2. 4 4 4 d,1 (e2) a e1\fermata }
PrecesVRefT =  \lyricmode { Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son_! }
PrecesCclM = \relative c'' { a\breve*1/8 fis4 \bar"|" a\breve*1/8 b a4 \bar"|" 
                             a\breve*1/8 gis8 [fis] a4 \bar ".|-|" }
PrecesCclRefSop = \relative c'' { cis4 d2. (cis4 b2) a gis1 \bar"|." }
PrecesCclRefAlt = \relative c'' { a4 1 (gis2) e4 (fis) e1 }
PrecesCclRefTen = \relative c' { e4 fis2. (e4 d2) cis b1 }
PrecesCclRefBas = \relative c' { a4 d,2. (a'4 e2) a e1 }
PrecesCclT =  \lyricmode { À toi, Sei -- gneur_! }
OfficeCclM = \relative c'' { a\breve*1/8 gis8 [fis] a4 \bar ".|-|" }
OfficeCclRefSop = \relative c'' { cis4 b cis d2 cis4 b2. a gis\bar"|." }
OfficeCclRefAlt = \relative c'' { a4 gis a4 2 4 gis2. e2 (fis4) e2. }
OfficeCclRefTen = \relative c' { e4 4 4 fis2 e4 d2. cis b }
OfficeCclRefBas = \relative c' { a4 e a d,2 a'4 e2. a e }
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

\markup\large\bold"Aux Laudes"
\PrecesLIntro\PrecesLRef
\markup{\vspace #1 \large\bold"Aux Vêpres"}
\PrecesVIntro\PrecesVRef
\PrecesCcl
\OfficeCcl