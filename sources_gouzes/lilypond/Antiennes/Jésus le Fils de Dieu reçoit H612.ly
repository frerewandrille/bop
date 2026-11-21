\version "2.24.0"
%\include "TonsDef.ly"

armure = { \key g \major \time 3/4 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }
silB = { \oneVoice r2 \voiceOne }

\transpose e d
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c'
       { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
         e4-> d e g-> (fis) g e2.\resp e4-> d e g2 g4 a-> (g) a a2\resp
         b4 c-> (b) c a2.\fermata\bar"|" 
         a4-> a a d2 d4 b-> b b e2 e4 d-> cis d b2. b\fermata\bar"|"
         a2^\p  a4 a-> (fis a) b1\fermata
         \bar"|."
       } \tonIIIbf
       %\tonIIIcf
     }
     \new Voice = "alto" %\with { \consists "Balloon_engraver" }
      %\override BalloonText.annotation-balloon = ##f 
      %<fis \balloonText #'(2 . -2)\markup { "" } >
      { \voiceTwo \relative c'
       { 
         e4 d e e2 e4 e2. e4 d e e2 e4 e2 e4 fis2 fis4 g2 g4 fis2. 
         fis4 fis fis fis2 fis4 gis gis gis fis2 fis4 fis fis fis gis2. gis
         fis2 fis4 fis (d fis) fis1
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Jé -- sus le Fils de Dieu re -- çoit l’onc -- tion 
     de l’Es -- prit Saint, al -- lé -- lu -- ia_!
     Il est le Pre -- mier_- Né 
     d’u -- ne mul -- ti -- tu -- de de frè -- res,
     al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          c4 b c b (a) b c2. c4 b c b2 b4 c (d) c d2 d4 e2 e4 d2.
          d4 d d d2 d4 e e e d2 d4 d d d e2. e cis!2 cis4 cis (b cis) dis1
        } \tonIIIbh
        %\tonIIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          a4-> a a e2-> e4 a2.\resp
          a4-> a a e2 e4 c-> (b) a d2\resp
          d4 a2-> a4 d2.\fermata
          d'4-> d cis b2 b4 e,-> e e b'2 b4 b-> b b e,2. e\fermata
          fis2 fis4 fis-> (b fis) b,1\fermata
        } 
      }
   >>
>>