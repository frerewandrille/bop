\version "2.24.0"
%\include "TonsDef.ly"
\include "vowel-set.ly"

%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }

armure = { \key d \minor \time 2/2 }
resp = { \breathe\allowBreak }

\transpose a b {
  \new ChoirStaff
  << \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "soprano"
        { \voiceOne \relative c''
          { \clef "treble" \armure \cadenzaOn \tempo "Léger et doux" 2 = 50
            a a2. c4 a2. a8 [a] bes2 bes4-> bes a2 g\resp
            g^\markup{\italic retenu} a f2.\resp 
            f8 [f] bes4->^\markup{\italic retenu } bes bes-> bes a2 a\fermata
            \bar"|."
          } \transpose b a \tonIIImf
        }
        \new Voice = "alto"
        { \voiceTwo \relative c'
          { 
            f4 f2. e4 f2. f8 [f] d2 d4 d f2 e e e d2.
            d8 [d] f4 f g g g2 fis
          }    
        }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
     {
       C’est toi, Sei -- gneur, qui éc -- lai -- res ma lam -- pe_!
       Ô mon Dieu, il -- lu -- mi -- ne mes té -- nè -- bres_!
     }
     \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { \voiceOne \relative c'
          { \clef "bass" \armure \cadenzaOn
            c4 c2. c4 d2. d8 [d] bes2 bes4 bes c2 c c c a2.
            a8 [a] d4 d d d d2 d
          } 
        }
        \new Voice = "basse"
        { \voiceTwo \relative c
          { 
            f4 f2. a4 d,2. d8 [d] g2 g4-> g f2 c\resp c a d2.\resp
            d8 [d] bes4-> bes g-> g d'2 d\fermata
          } \transpose b a \tonIIImh
        }
     >>
  >>
}