\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

\new ChoirStaff %\with { instrumentName = #"7" }
<< \new Staff %\with {\remove Time_signature_engraver } 
   << \new Voice = "soprano" 
      { \voiceOne \relative c''
        { \clef "treble" \key g \minor \time 3/4 \cadenzaOn \tempo "Berceur et paisible" 2. = 52
          d2 c4 bes^> a bes c^> bes a a2 g4 \breathe\allowBreak a2 f4 g2 bes4 c2 bes8 [a] g2. \bar "|"
          d'2 c4 bes^> a bes c^> bes a a2 g4 \breathe \allowBreak a a f4 g2 bes4 c4. (bes8) a ([bes]) g2. \bar "|." }
        \transpose a g {\relative c'' { c \breve b8[ c] a4 \bar "|" \noBreak b \breve g \breve a4 \bar "||" \noBreak c \breve  a4-+ \bar "|." } }
      }
      \new Voice = "alto" 
      { \voiceTwo \relative c''
        { g4 (a) bes g a bes f g a f (g) a f (g) a ees (f) g d (ees) f8 [f] g4 (a bes)
          g4 (a) bes g a bes f g a f (g) a f g a ees (f) g d (ees) f g2.
        } 
        \transpose a g {\relative c'' { a \breve s4 f4 \bar "|" \noBreak f \breve e \breve e4 \bar "||" \noBreak a \breve  f4 } }
        %\tonIIbf
      }
   >>
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano"
     Le2 Sei4 -- gneur fit pour moi des mer -- veil2 -- les,4 et2 mon4 cœur2 ex4 -- ul2 -- te8 de joie_:2. 
     en2 ma4 chair s’ac -- com -- plit la pro -- mes2 -- se,4 
     al -- lé -- lu -- ia,2 al4 -- lé2 -- lu4 -- ia_!2.
   }
   \new Lyrics = "hommes" \with {\override VerticalAxisGroup.staff-affinity = #DOWN }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \minor \cadenzaOn
          d2. d c c c bes a bes d d c c c bes a bes}
        \transpose a g {\relative c' { 	e \breve s4 d4 \bar "|" \noBreak d \breve b \breve c4 \bar "||" \noBreak e \breve d4 } }
        %\tonIIbh
      }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        { g2. g f f f ees d g, g' g f f f ees d g, }
        \transpose a g {\relative c' { 	a \breve s4 d,4 \bar "|" \noBreak d \breve e \breve <a, a'>4 \bar "||" \noBreak a' \breve a4 } }
      }
      \context Lyrics = "hommes" \lyricmode 
      { \set associatedVoice = #"basse"
        Ma2. -- gni -- fi -- cat, ma2. -- gni -- fi -- cat, 
        ma2. -- gni -- fi -- cat, ma2. -- gni -- fi -- cat_!
      }
   >>
>>