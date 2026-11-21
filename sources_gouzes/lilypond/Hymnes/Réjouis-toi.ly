\version "2.24.0"

\include "vowel-set.ly"

\new ChoirStaff  %\with { instrumentName = #"2" }
<< \new Staff \with {\remove Time_signature_engraver }
    \new Voice = "soprano"
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \major \cadenzaOn 
          g \breve a8 b4. a8 g [fis] e [dis] e2 \bar "|" 
          g\breve a8 b4 (a8 [g]) fis4 fis8 [a] g4. (fis8 e4 dis!) e2 \bar "|."
          
          g\breve a8 b4 b \breve a8 [g] fis4 \breathe \allowBreak  fis \breve g8 a \breve g8 [fis] g4 \bar "|"
          e \breve fis8 g \breve fis8 [e] dis!4 \breathe \allowBreak dis \breve e8 fis4 fis \breve e8 [dis] e2 \bar "||" }
     }
   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     Réjou \breve -- is-8 toi,4.  ô8 Mè -- re du Sau -- veur,2
     Alléluia_!_Al \breve -- lé8 -- lu2 -- ia_!4 
     Al8 -- lé -- lu1 -- ia_!2
     \set stanza = "1." 
     Réjou \breve -- is8 toi,4 
     rayonne \breve -- ment8 de joie,4
     "Réjouis-toi, par qui" \breve le8 
     mal_a \breve dis8 -- pa -- ru,4
     "Réjouis-toi, tu relèves" \breve A8 -- dam \breve de8 la chute,4
     Réjou \breve -- is-8 toi,4
     "par toi, Ève ne" \breve pleu8 -- re plus.2
   }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano"
     \skip \breve \skip 8 \skip 4. ô8 Vierge im -- ma -- cu -- lée,2
   }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano"
     \skip \breve \skip 8 \skip 4. Ma8 -- rie com -- blée de grâce,2
   }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano"
     \skip \breve \skip 8 \skip 4. é8 -- pouse in -- é -- pou -- sée,2
   }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano"
     \skip \breve \skip 8 \skip 4. Ma8 -- rie, rei -- ne des cieux,2
   }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano"
     \skip \breve \skip 8 \skip 4. 
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricmode 
   { \set associatedVoice = #"soprano"
     "Réjouis-toi," \breve Ma8 -- rie,4. é8 -- le -- vée dans les cieux,2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \cadenzaOn
          b \breve c8 d4. c8 b [a] g [ fis] g2 b \breve c8 d4 (c8 [b]) a4 a8 [c] b4. (a8 g4 fis) g2
          b \breve c8 d4 d \breve a8 [b] a4 a \breve b8 c \breve b8 [a] b4
          g \breve a8 b \breve a8 [g] fis4 fis \breve g8 a4 a \breve g8 [fis] g2
      } }
      \new Voice = "basse" 
      { \voiceTwo \relative c'
        { \cadenzaOn 
          g \breve g8 g4. d8 g [d] e [b] e2 g \breve g8 g4 (fis8 [g]) d4 d8 [d] g4. (d8 e4 b) e2
          g \breve g8 g4 g \breve fis8 [g] d4 d \breve d8 d \breve d8 [d] g4 
          e \breve e8 e \breve dis8 [e] b4 b\breve b8 b4 b \breve b8 [b] e2
      } }
   >>
>>