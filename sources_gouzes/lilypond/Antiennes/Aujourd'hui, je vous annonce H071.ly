\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 6/8 }
resp = { \breathe\allowBreak }

\layout {
  \context {
    \Lyrics
    \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = 1.5
  }
}

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \tempo "Vif"
          \revert Staff.TimeSignature.style
          \partial8 d16 d g4 bes8 a4 c8 bes4. g4 bes8 a4 g8 f4 a8 g4.\oneVoice r4
          \voiceOne d16 d g4 bes8 a4 c8 bes4. g4 bes8 a4 g8 f4 a8 g2.~g4. 
          \oneVoice r4 \voiceOne \allowBreak g8^\markup\italic"rall. subito" 
          d'4 d8 a4 bes8 c4. c bes4 a8 bes4 a8 g4 g8 bes4. a\fermata
          \oneVoice \bar ".|:-|"r4 \voiceOne \tempo "Vif" 
          d,8 g4 g8 f4 f8 d4 d8 bes'4. d4 c8 bes4 (a8) \noBreak g4.
          \bar ":|."
        }\cadenzaOn \tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        {
          \partial8 d16 d g4 bes8 a4 c8 bes4. g4 bes8 a4 g8 f4 a8 g4. s4
          d16 d g4 bes8 a4 c8 bes4. g4 bes8 a4 g8 f4 a8 g2.~g4. s4
          g8 bes4 bes8 f4 f8 e4. e d4 e8 f4 f8 d4 d8 g4 (f8) e4. s4
          d8 g4 g8 f4 f8 d4 d8 d4. e4 e8 f4. d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #UP }
   \lyricsto "soprano"
   { 
     Au -- jour --\apostrophe d’hui, je vous an -- non -- ce u -- ne très gran -- de joie.
     Au -- jour --\apostrophe d’hui, je vous an -- non -- ce u -- ne très gran -- de joie.
     Pour nous dans une é -- ta -- ble %est né le Sau -- veur du mon -- de.
  
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   { \repeat unfold 35 \skip4 est né le Sau -- veur du mon -- de.
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia.
   }
   \new Lyrics = "hommes" \with {\override VerticalAxisGroup.staff-affinity = #DOWN }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          \partial8 s8 s4. s4 d16 d g4 a8 bes4 bes8 c4. d4 
          d8 bes4 bes8 a4 a8 g4.
          s4 d16 d g4 a8 bes4 bes8 c4. d4 d8 bes4 bes8 a4 a8 g2.
          g4. d'4 d8 a4 a8 a4 a8 bes4 c8 d4 d8 bes4 bes8 d4. cis s4
          d,8 g4 bes8 a4 c8 bes4 a8 g4. bes4 bes8 c4. bes
        }\cadenzaOn \tonIIah
      }
      \new Voice = "basse"
      {  \relative c
         {
           \partial8 r8 r4. r4 \voiceTwo d16 d g4 a8 bes4 bes8 c4. d4 
           d8 bes4 bes8 a4 a8 g4.
           \oneVoice r4 \voiceTwo d16 d g4 a8 bes4 bes8 c4. d4 
           d8 bes4 bes8 a4 a8 g2.
           g4. d'4 d8 a4 a8 a4 a8 bes4 c8 d4 d,8 e4 f8 g4. a\fermata
           \oneVoice r4 \voiceTwo d,8 g4 bes8 a4 c8 bes4 a8 g4. g4 g8 f4. g
         }
      }
   >>
   \context Lyrics = "hommes" \lyricsto ténor 
   { 
     Au -- jour --\apostrophe d’hui, je vous an -- non -- ce u -- ne très gran -- de joie.
     Au -- jour --\apostrophe d’hui, je vous an -- non -- ce u -- ne très gran -- de joie.
     Pour nous dans une é -- ta -- ble %est né le Sau -- veur du mon -- de.
   }
>>