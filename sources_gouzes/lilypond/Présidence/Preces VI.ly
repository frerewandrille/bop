\version "2.24.0"

\include "vowel-set.ly"

gauche = \once \override LyricText.X-offset = #center-on-vowel
ss = { \hideNotes bes4 \unHideNotes \allowBreak }
armure = { \key d \minor \time 3/4 \cadenzaOn }
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
PrecesLRefSop = \relative c'' { a4. g8 f4 bes a g8 ([f] g4) g f1
                                \bar"|." } 
PrecesLRefAlt = \relative c' { f4. f8 c4 f f c (d) e c1 }
PrecesLRefTen = \relative c' { c4. bes8 a4 d c bes8 ([a] bes4) 4 a1 }
PrecesLRefBas = \relative c { f4. f8 f4 bes,8 ([d]) f4 f (bes,) c f1 }
PrecesLRefT = \lyricmode { Gloire à toi, Sei -- gneur, gloire à toi_! }
PrecesLRefSopbis = \relative c'' { a4 g f g2 a4 2\resp 4 c2. bes a
                                   \bar"|." } 
PrecesLRefAltbis = \relative c' { f4 e d e2 4 f2 4 2 (e4) d2 (e4) f2. }
PrecesLRefTenbis = \relative c' { c4 4 a bes2 c4 2 4 2. d2 (bes4) c2. }
PrecesLRefBasbis = \relative c { f4 c d c2 4 f2\resp 4 a2. bes2 (g4) f2. }
PrecesLRefTbis = \lyricmode { Gloire et lou -- ange à toi, Sei -- gneur Jé -- sus_! }
PrecesVIntroM = \relative c' { f\breve*1/8 e8 [d] f4 \bar"||" }
PrecesVIntroT = \lyricmode { "En paix, prions" le Sei -- gneur_! }
PrecesVRefSop = \relative c'' { a4 4 g f g2 a4 2\fermata\resp
                                a4 4 g a c2 bes4 a2\fermata\resp
                                a4 4 g f g2 a4 2\fermata
                                \bar"|." }
PrecesVRefAlt = \relative c' { f4 f e d e2 4 f2 4 4 e f4 2 e4 f2 4 4 e d e2 4 f2 }
PrecesVRefTen = \relative c' { c4 c bes a bes2 c4 2 4 4 4 4 2 4 2 4 4 bes a bes2 c4 2 }
PrecesVRefBas = \relative c { f4 4 c d c2 4 f2\fermata\resp
                              f4 4 c f a2 g4 f2\fermata\resp
                              f4 4 c d c2 4 f2\fermata }
PrecesVRefT =  \lyricmode { Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son, 
                            Ky -- ri -- e e -- le -- i -- son_! }
PrecesVRefSopbis = \relative c' { f4. f8 f [e] g4. 8 f2\fermata\resp
                                   a4. 8 g [a] bes2 (a4) g f2\fermata
                                   \bar"|." }
PrecesVRefAltbis = \relative c' { c4. 8 8 [8] e4. 8 c2 f4. 8 f [f] f2 (e4) e c2 }
PrecesVRefTenbis = \relative c' { a4. a8 a [g] bes4. 8 a2 c4. c8 bes [c] d2 (c4) bes a2 }
PrecesVRefBasbis = \relative c { f4. 8 f [c] c4. 8 f2\fermata\resp
                                 f4. 8 8 [f] bes,2 (c4) c f2\fermata }
PrecesVRefTbis =  \lyricmode { Ky -- ri -- e e -- le -- i -- son, 
                               Ky -- ri -- e e -- le -- i -- son_! }
PrecesCclM = \relative c' { f\breve*1/8 d4 \bar"|" f\breve*1/8 g f4 \bar"|" 
                             f\breve*1/8 e8 [d] f4 \bar ".|-|" }
PrecesCclRefSop = \relative c'' { a4 a2 g f\fermata \bar"|."\textMark\markup\small{ ou bien } bes2 a g f\fermata \bar"|." }
PrecesCclRefAlt = \relative c' { f4 e2 e c f f e c }
PrecesCclRefTen = \relative c' { c4 2 bes a d c bes a }
PrecesCclRefBas = \relative c { f4 c2 c f\fermata bes, c c f\fermata }
PrecesCclT =  \lyricmode { À toi, Sei -- gneur_!_ À toi, Sei -- gneur_! }
OfficeCclM = \relative c' { f\breve*1/8 e8 [d] f4 \bar ".|-|" }
OfficeCclRefSop = \relative c'' { a4-> g a bes2-> 4 a2.\resp g a\fermata\bar"|."\textMark\markup\small{ ou bien }
          a4-^ a-^ a-^ bes8-. ([a-.] g-. [a-.] bes4-.) 4 a2.\fermata \bar"|." }
OfficeCclRefAlt = \relative c' { f4 e f4 2 e4 f2. d2 (e4) f2. f4 4 4 2. e4 f2. }
OfficeCclRefTen = \relative c' { c4 4 4 d2 c4 2. bes c 
                                 c4 c c d8-. ([c-.] bes-. [c-.] d4-.) c c 2. }
OfficeCclRefBas = \relative c { f4-> d f bes,2-> c4 f2.\resp g f\fermata
                                f4-^ f-^ f-^ f2 (bes,4) c f2.\fermata  }
OfficeCclT =  \lyricmode { Bénissons le Sei -- gneur_!_
                           Nous ren -- dons grâce à Dieu, a -- men_! 
                           Nous ren -- dons grâce à Dieu_! }


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
    \new Staff \with {\remove Time_signature_engraver }
    << 
      \new Voice = "soprano" \armure { \voiceOne \PrecesLRefSop }
      \new Voice = "alto" \with { \consists "Balloon_engraver"
                                  \override BalloonText.annotation-balloon = ##f }
      { \voiceTwo \PrecesLRefAlt }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "soprano" \PrecesLRefT   
    \new Staff \with {\remove Time_signature_engraver }
    << 
      \new Voice = "ténor" \with { \consists "Balloon_engraver"
                                   \override BalloonText.annotation-balloon = ##f }
      \clef "bass" \armure { \voiceOne \PrecesLRefTen }
      \new Voice = "basse" { \voiceTwo \PrecesLRefBas }
    >>
  >>
}

PrecesLRefbis = 
{
  \new StaffGroup
  << 
    \new Staff %\with {\remove Time_signature_engraver }
    << 
      \new Voice = "soprano" \armure { \voiceOne \PrecesLRefSopbis }
      \new Voice = "alto" { \voiceTwo \PrecesLRefAltbis }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "soprano" \PrecesLRefTbis  
    \new Staff %\with {\remove Time_signature_engraver }
    << 
      \new Voice = "ténor" \clef "bass" \armure { \voiceOne \PrecesLRefTenbis }
      \new Voice = "basse" { \voiceTwo \PrecesLRefBasbis }
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


PrecesVRefbis =
{
  \new StaffGroup
  << 
    \new Staff \with {\remove Time_signature_engraver }
    << 
      \new Voice = "soprano" \armure { \voiceOne \PrecesVRefSopbis }
      \new Voice = "alto" { \voiceTwo \PrecesVRefAltbis }
    >>
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "soprano" \PrecesVRefTbis
    \new Staff \with {\remove Time_signature_engraver }
    << 
      \new Voice = "ténor" \clef "bass" \armure { \voiceOne \PrecesVRefTenbis }
      \new Voice = "basse" { \voiceTwo \PrecesVRefBasbis }
    >>
  >>
}


PrecesCcl =
{
  \new StaffGroup 
  << 
    \override Score.SystemStartBar.collapse-height = #4
    \override Score.TextMark.self-alignment-X = #LEFT
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
    \override Score.TextMark.self-alignment-X = #LEFT
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
\markup\small{ou bien}
\PrecesLRefbis
\markup{\vspace #1 \large\bold"Aux Vêpres"}
\PrecesVIntro\PrecesVRef
\markup\small{ou bien}
\PrecesVRefbis
\PrecesCcl
\OfficeCcl