\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
silB = { \oneVoice r2 \voiceOne }


\transpose f d
\new ChoirStaff
<< \new Dynamics 
   {
     f2 f4 c' c bes a2. \silN 
     c'4 c c c d bes2 bes4 c2. c4 bes c f,2.
     ees g bes bes4 bes\< a g2\> f4 g2.\!
     bes2\< bes4 c\f ees d c2\> (bes4) c2.\! bes4\mf g f a2.
     bes4\p\> g g f2.\!
   }
   \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn \tempo 2. = 66
         \override Script.outside-staff-priority = #30
         f2 f4 c'-> c bes a2. \silN 
         c4^\markup\italic"vif, accel." c c-> c d bes2 bes4 c2. 
         c4-> bes c f,2.\fermata\bar"|"
         ees\fermata^\markup{\dynamic p \italic "sub., lent" } g\fermata bes\fermata\resp 
         bes4-> bes^\markup\italic"céder" a g2 f4 g2.
         bes2 bes4 c-> ees d c2 (bes4) c2.\fermata
         bes4-.-> g-.^\markup\italic"léger" f-. a2. 
         bes4-.-> g-.^\markup\italic"rall." g-. f2.
         \bar"|."
       } \transpose a c' \tonVIIaf
       %\transpose a bes \tonVIIdf
     }
     \new Voice = "alto" %\with { \consists "Balloon_engraver" }
     %\override BalloonText.annotation-balloon = ##f 
     %<fis \balloonText #'(2 . -2)\markup { "" } >
     { \voiceTwo \relative c'
       { 
         f2 f4 f f f f2. s4 f f f f f g2 d4 f2. f4 d ees c2.
         c c d d4 d c d2 d4 d2. d2 d4 f g f f2 (d4) f2.
         d4 ees c f2. f4 ees ees c2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   %\with { alignAboveContext = "hommes" }
   \lyricsto "soprano"
   {
     Dans les eaux du Jour -- dain,
     le Sei -- gneur a bri -- sé la tê -- te du Dra -- gon.
     Sur la croix,
     il a ou -- vert pour nous u -- ne sour -- ce d’eau vi -- ve,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c
        { \clef "bass" \armure \cadenzaOn
          f2 f4 a a d c2. \silN a4 a a a bes bes2 bes4 a2. a4 bes g a2.
          g g g g4 g a bes2 c4 bes2. bes2 bes4 a bes bes a2 (bes4) a2.
          bes4 bes a c2. d4 bes bes a2.
        } \transpose a c' \tonVIIah
        %\transpose a bes \tonVIIdh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          f2 f4 f-> f bes, f'2. s4 f f f-> f bes, ees2 g4 f2. f4-> g ees f2.
          c\fermata ees\fermata d\fermata\resp d4-> d f g2 a4 g2. 
          g2 g4 f-> ees bes f'2 (g4) f2.\fermata\resp
          g4->-. ees-. f-. f2. d4->-. ees-. ees-. f2.
        } 
      }
   >>
>>

%{
convert-ly (GNU LilyPond) 2.20.0  convert-ly: Traitement de «  »...
Conversion en cours :     Le document n’a pas été modifié.
%}
