\version "2.24.0"
%\include "TonsDef.ly"


\new ChoirStaff
<< \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c'
        { \clef "treble" \key g \major \time 2/2 \cadenzaOn \tempo 2 = 72
          d4 a'2 a4 b b2 a4 b c (a) a2.\breathe\allowBreak
          d,4 a' d c b a2.\breathe\allowBreak
          a4^\markup{\italic "en retenant"} d c a a a^> c a2 a\fermata\bar "|."
        }\tonVIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c'
        { 
          d4 fis2 fis4 fis fis2 fis4 fis g2 fis2.
          d4 fis fis g g fis2. fis4 g g g g fis g fis (g) fis2
        }          
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Je suis la lu -- miè -- re du mon -- de. 
     Si vous cro -- yez en moi, vous se -- rez fils de la lu -- miè -- re.
   }

   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \key g \major \time 2/2 \cadenzaOn
          d4 d2 d4 dis dis2 e4 dis! e2 d2.
          d4 d d e e d2. d4 e e e e d e d (e) d2
        }\tonVIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        { 
          d4 d2 d4 <b b'> q2 <c c'>4 <b b'> <a a'> (<c c'>) <d d'>2.\breathe
          d4 d d a' a d2.\breathe d4 a a c c d_> a d2 d\fermata
        }
      }
   >>
>>