\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key g \minor \time 6/8 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \armure \tempo "Vif"
          \revert Staff.TimeSignature.style
          \partial8 d16 d g4 bes8 a4 \bar ".|:-|" 
          \repeat volta 2 { c8 bes4. g4 bes8 a4 g8 f4 a8 } 
          \alternative {
            { g4.\oneVoice r4 \voiceOne d16 d g4 bes8 a4 }
            { g2.~g4.  }
          }
          %c8 bes4. g4 bes8 a4 g8 f4 a8 g2.~g4. 
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
          \partial8 d16 d g4 bes8 a4 \bar ".|:-|" 
          \repeat volta 2 { c8 bes4. g4 bes8 a4 g8 f4 a8 } 
          \alternative {
            { g4. s4 d16 d g4 bes8 a4 }
            { g2.~g4.  }
          }
          %c8 bes4. g4 bes8 a4 g8 f4 a8 g2.~g4. 
          s4
          g8 bes4 bes8 f4 f8 e4. e d4 e8 f4 f8 d4 d8 g4 (f8) e4. s4
          d8 g4 g8 f4 f8 d4 d8 d4. e4 e8 f4. d
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano
   { 
     Au -- jour --\apostrophe d’hui, je vous an -- non -- ce u -- ne très gran -- de joie.
     Au -- jour --\apostrophe d’hui, je vous joie.
     Pour nous dans une é -- ta -- ble est né le Sau -- veur du mon -- de.
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia.
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          \partial8 s8 s4. s4 d16 d g4 a8 bes4 bes8 c4. d4 
          d8 bes4 bes8 a4 a8 g4.
          s4 bes4 bes8 a4 a8 g2.
          g4. d'4 d8 a4 a8 a4 a8 bes4 c8 d4 d8 bes4 bes8 d4. cis s4
          d,8 g4 bes8 a4 c8 bes4 a8 g4. bes4 bes8 c4. bes
        }\cadenzaOn \tonIIah
      }
      \new Voice = "basse"
      {  \relative c
         {
           \partial8 r8 r4. r4 \voiceTwo d16 d g4 a8 bes4 bes8 c4. d4 
           d8 bes4 bes8 a4 a8 g4. \oneVoice r4 \voiceTwo 
           bes4 bes8 a4 a8 g2.
           g4. d'4 d8 a4 a8 a4 a8 bes4 c8 d4 d,8 e4 f8 g4. a\fermata
           \oneVoice r4 \voiceTwo d,8 g4 bes8 a4 c8 bes4 a8 g4. g4 g8 f4. g
         }
      }
   >>
   \new Lyrics \lyricsto ténor 
   { 
     Au -- jour --\apostrophe d’hui, je vous an -- non -- ce u -- ne très gran -- de joie.
     ne très gran -- de joie.
     Pour nous dans une é -- ta -- ble
   }
>>

%{
convert-ly (GNU LilyPond) 2.24.1  convert-ly: Traitement de «  »...
Conversion en cours : 2.21.0, 2.21.2, 2.22.0, 2.23.1, 2.23.2, 2.23.3,
2.23.4, 2.23.5, 2.23.6, 2.23.7, 2.23.8, 2.23.9, 2.23.10, 2.23.11,
2.23.12, 2.23.13, 2.23.14, 2.24.0
%}
