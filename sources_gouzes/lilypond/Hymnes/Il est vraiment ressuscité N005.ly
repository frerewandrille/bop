\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }


armure = { \key d \major \time 3/4 }
resp = { \breathe\allowBreak }
barre = { \undo \omit Score.BarLine }
barress = { \omit Score.BarLine }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }


\score {
  \new ChoirStaff
  << \new Staff = "femmes" %\with {\remove Time_signature_engraver }
     << \new Voice = "soprano"
        { \voiceOne \relative c''
          { \clef "treble" \armure \tempo "Vif et rythmé"
            \revert Staff.TimeSignature.style
            a4^\f a a b2 a4 a (g) fis a2.
            fis4^\p fis fis fis2 fis4 fis (e) d e2.
            a4^\f a a b2 a4 a g fis a2.
            \silN a4 d cis2. d\fermata
            \bar "|."\break
          }
        }
        \new Voice = "alto" 
        { \voiceTwo \relative c'
          {
            fis4 fis fis g2 fis4 fis (b,) d e2.
            d4 d d d2 cis4 d (b) b cis2.
            fis4 fis fis g2 fis4 fis b, d e2.
            s4 d fis e2. fis
          }          
        }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
     \lyricsto soprano 
     { 
       Il est vrai -- ment res -- sus -- ci -- té_:
       Pour -- quoi cher -- cher par -- mi les morts_?
       Il est vi -- vant, comme il l’a pro -- mis.
       Al -- lé -- lu -- ia_!
     }
     \new Staff = "hommes" %\with {\remove Time_signature_engraver }
     << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
        { \voiceOne \relative c'
          { \clef "bass" \armure
            \revert Staff.TimeSignature.style
            d4 d d d2 d4 cis (e) d cis2.
            a4 a a b2 a4 a (g) fis a2.
            a4 d d d2 d4 cis e d cis2.
            \silN d4 a a2. a 
          }
        }
        \new Voice = "basse"
        { \voiceTwo \relative c
          {
            d4 d d g2 d4 fis (e) b' a2.
            d,4 d d b2 fis'4 d (e) b a2.
            fis'4 d d g2 d4 fis e b' a2.
            s4 fis d a2. d\fermata
          }
        }
     >>
  >>
  \layout { system-count = 2 }
}