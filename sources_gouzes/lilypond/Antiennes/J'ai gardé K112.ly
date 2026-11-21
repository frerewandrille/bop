\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key a \minor \time 3/4 }
resp = { \breathe\allowBreak }

\transpose c g,
\new ChoirStaff
<< \new Dynamics 
   {
     c2^\< c4 b2^\> b4 a2.\! 
     c2^\< d4 e2^\> c4 d2 d4\!     
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Lent" 2. = 48
          c2 c4 b2 b4 a2. 
          c2 d4 e2 c4 d2 d4 e2\fermata e4\fermata\resp
          e2.--^\markup{\italic marcato} e4-- e-- e-- c-- c-- c-- c2-- d4-- b2.\fermata\resp
          cis4 cis cis d2 d4 b2 b4 cis!2.\fermata
          \bar"|."
        } \transpose d e \tonIff
        %\tonIIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          e2 e4 g2 g4 f2. e2 a4 g2 a4 f2 a4 g2 g4 
          gis2. gis4 gis gis e e e f2 f4 gis!2. a4 a a a2 a4 a2 gis!4 a2.
        }    
      }
   >>
   \new Lyrics  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     J’ai gar -- dé, Sei -- gneur, la Pa -- ro -- le de tes lè -- vres_: 
     "“Tu" a -- do -- re -- ras le Sei -- gneur ton Dieu_; 
     tu le sanc -- ti -- fie -- ras, lui "seul !”"
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c2 c4 e2 e4 c2. c2 a4 b2 a4 a2 a4 b2 b4 b2. b4 b b a b c d2 d4 e2.
          e4 e e f2 f4 e2 e4 e2.
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a2 a4 e2 e4 f2. a2 f4 e2 f4 d2 f4 e2\fermata e4\fermata\resp
          e2.-- e4-- e-- e-- a-- a-- a-- a2-- a4-- e2.\fermata\resp
          a4 a a d,2 d4 e2 e4 a2.\fermata
        } \transpose d e \tonIfh
        %\tonIIIah
      }
   >>
>>