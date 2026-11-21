\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key bes \major \time 2/2 }
resp = { \breathe\allowBreak }

\new ChoirStaff
<< \new Dynamics 
   {
     g2^\< f g\! g4 bes a g^\> g f g2.\!\resp
          bes4 bes2. d4 c2 bes2.^\> bes4 a (g2 f4) g1\!\bar"|"
          \oneVoice r4 \voiceOne g4^\pp^\< g2 f g2.\!\resp
          bes4^\> a (g) g (f) g2.\!\resp
          bes4^\f^\< bes2 d c2.\!\resp
          bes4^\> a (g) g (f) g1\!^\p
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Léger et souple" 2 = 80
          g2 f g g4 bes a g g f g2.\resp
          bes4 bes2. d4 c2 bes2. bes4 a (g2 f4) g1\fermata\bar"|"
          \oneVoice r4 \voiceOne g4 g2 f g2.\resp
          bes4 a (g) g (f) g2.\resp
          bes4 bes2 d c2.\resp
          bes4 a (g) g (f) g1\fermata
          \bar"|."
        } \tonIIaf
      }
      \new Voice = "alto" \with { \consists "Balloon_engraver" }
      { \voiceTwo \relative c'
        { 
          d2 d d d4 f f d e d d2. g4 g2 
          \override BalloonText.annotation-balloon = ##f 
          <f \balloonText #'(0.75 . -3)\markup { "" } >
          g g2. g4 f (d ees d) d1
          s4 d d2 d d2. f4 f (d) e (d) d2.
          d8 ([e!]) f2 bes4 (a8 [g]) a4. (g8 f4) d ees2 d d1
        }    
      }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
      De sa main, le Sei -- gneur m’a re -- le -- vé_:
      Il m’a sau -- vé car il m’ai -- me_!
      Al -- lé -- lu -- ia, al -- lé -- lu -- ia, 
      al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver" }
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          bes2 a4 (bes8 [c]) bes2 bes4 d c bes c a bes2.
          d4 ees2 
          \override BalloonText.annotation-balloon = ##f 
          <d \balloonText #'(0.75 . 2.5)\markup { "" } >
          e d 
          \override BalloonText.annotation-balloon = ##f 
          <ees \balloonText #'(1 . 2)\markup { "" } >
          c4 (bes c a) bes1
          s4 bes bes2 a4 (bes8 [c]) bes2. d4 c (bes) c (a) bes2.
          bes4 d2 f f2. d4 c2 a b1
        } \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g2 d g g4 bes, f' g c, d g2.\resp
          g4 ees2 bes' c g ees f4 (g c, d) g1\fermata
          \oneVoice r4 \voiceTwo g4 g2 d g2. bes,4 f' (g) c, (d) g2.\resp
          bes,4 bes2 bes f'2.\resp g4 c,2 d <g, g'>1\fermata
        } 
      }
   >>
>>