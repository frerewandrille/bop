\new Voice = "alto" \with { \consists "Balloon_engraver"
                            \override BalloonText.annotation-balloon = ##f }
<fis \balloonText #'(2 . -2)\markup { "" } >


\new Lyrics \with { alignAboveContext = "hommes" }


\layout {
  \context {
    \Lyrics
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}


psub = #(make-dynamic-script (markup #:line ( #:dynamic "pp" #:normal-text #:italic "sub." )))
rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0
\agauche a4\psub

\set ChoirStaff.beamExceptions = #'()
\set Staff.beamExceptions = #'()
\set Staff.baseMoment = #(ly:make-moment 1/4)
\set Staff.beatStructure = 1,1,1,1


\once \override TextScript.outside-staff-priority = #1


\override Hairpin.to-barline = ##f %context Score


\revert Staff.TimeSignature.style

\new Staff \with { \consists "Merge_rests_engraver" }