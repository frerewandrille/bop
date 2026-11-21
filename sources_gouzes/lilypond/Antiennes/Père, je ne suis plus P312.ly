\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \cadenzaOn \tempo "Calme"% 2 = 52
          f4\fermata f4.\fermata\resp 
          a8 bes [c] bes4 g8 [a] f4 f2\fermata\resp
          g4 f8 [g] d ([f] g [a]) a4 \allowBreak
          bes c8 [bes] c4 (d8 [c]) a2\fermata\bar"|"
          a4 bes8 [c] bes4 a8 [g] f4 \allowBreak g f8 [g] d [f] g4.\resp
          a8 g ([a]) f4 f\fermata
          \bar"|."
        } 
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          c4 c4. c8 d [d] ees ([d]) c [bes] a ([bes]) c2
          d4 d8 [c] d4 (ees8 [f]) f4 
          f g8 [f] ees4 (d8 [ees]) f2
          f4 f8 [f] g ([ees]) d [d] d ([c]) bes ([c]) d [d] d [d] d4.
          d8 d ([c]) c4 c
        } \transpose c bes, \tonVIIIdf
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      Pè -- re, je ne suis plus dans le mon -- de,
      mais les dis -- ci -- ples sont dans le mon -- de.
      Garde en ton Nom, Pè -- re saint,
      ceux que tu m’as don -- nés, al -- lé -- lu -- ia_!
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          a4 a4. a8 f [f] g4 g8 [g] f ([g]) a2
          bes4 a8 [bes] a ([c] bes [c]) c4
          bes bes8 [bes] bes4 (a8 [bes]) c2
          c4 bes8 [bes] bes4 a8 [a] a4 g a8 [a] bes [a] c4.\resp
          c8 bes4 bes a
        } \transpose c bes, \tonVIIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f4\fermata ees4.\fermata\resp
          ees8 d [d] c4 ees8 [ees] f4 f2\fermata\resp
          d4 f8 [ees] f ([a] g [f]) f4 
          d ees8 [ees] g4 (f8 [g]) f2\fermata
          f4 d8 [d] ees4 f8 [ees] d4 ees f8 [f] g [g] a4.\resp
          d,8 ees4 f f\fermata
        } 
      }
   >>
>>
\layout {
  \context {
    \Lyrics
      \consists "Bar_engraver"
      \consists "Separating_line_group_engraver"
      \hide BarLine
  }
}