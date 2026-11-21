\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\transpose bes g
\new ChoirStaff  %\with { instrumentName = #"6" }
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano" 
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn \tempo "Bien balancé" 2. = 50
          d4 d2 d8 [bes] c2 c4 c2 d8 [c] bes2 (a4) g2. \breathe\allowBreak d'4^> d bes c2 c4 c2 \allowBreak f8 [ees] d2. \breathe\allowBreak
          d2 d4 c2 (d8 [c] bes2 a8 [g] a4^> bes a) g2. \bar"|." }
        \transpose c bes, \tonIIIaf
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c''
        { g4 g2 g8 [bes] f2 f4 f2 f8 [f] d2 (f4) g2. 
          g4 g bes f2 f4 f2 f8 [f] f2. f2 f4 f2. (d f) d} 
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Tu4 es2 tou8 -- te belle,2 ô4 Vier2 -- ge8 Ma -- ri2. -- e. 
     Le4 Roi du ciel2 t’a4 prise2 a8 -- vec lui2. dans2 la4 Gloi1. -- \skip 2. re_!2.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \minor \cadenzaOn
          bes4 bes2 bes8 [g] a2 a4 a2 bes8 [a] g2 (a4) bes2. \breathe
          bes4 bes g a2 a4 a2 f8 [a] bes2.
          bes2 bes4 a2 (bes8 [a] g2 a8 [bes] c4 d c) bes2.}
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        { g4 g2 g4 f2 f4 f2 f4 g2 g4 g2 g4 g2 g4 f2 f4 f2 f4 bes,2 bes4 bes2 bes4 f'2 f4 g2 g4 f2 f4 g2. }
        \transpose c bes, \tonIIIah
      }
      \new Lyrics \lyricmode 
      { \set associatedVoice = #"basse"
        Al4 -- lé2 -- lu4 -- ia,2  Al4 -- lé2 -- lu4 -- ia,2  Al4 -- lé2 -- lu4 -- ia,2  Al4 -- lé2 -- lu4 -- ia,2  
        Al4 -- lé2 -- lu4 -- ia,2  Al4 -- lé2 -- lu4 -- ia,2  Al4 -- lé2 -- lu4 -- ia_!2
      }
   >>
>>