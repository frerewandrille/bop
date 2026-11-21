\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

resp = { \breathe\allowBreak }
armure = { \key bes \major }
\transpose bes g {
  \new ChoirStaff
  << \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "soprano"
        { \voiceOne \relative c''
          { \clef "treble" \armure \cadenzaOn %\tempo "" 2 = 52
            bes2 a\fermata\resp bes4 c d\breve*1/8 c2 c4 c bes2 a\fermata
            \bar"|" bes4 bes c d2 \allowBreak d\breve*1/8 d2 c4 bes a2\bar"|"
            bes4 c d2 c4 bes bes2 a bes1\fermata
            \bar"|."
          } \transpose bes bes \tonVIIIaf
        }
        \new Voice = "alto"
        { \voiceTwo \relative c''
          { 
            g2 fis g4 a bes\breve*1/8 a2 a4 a g2 fis!
            g4 g a bes2 bes\breve*1/8 bes2 bes4 g f2
            f4 f bes2 g4 g f2 f f1
          }    
        }
     >>
     \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
     {
       Ô Christ, tu t’a -- "vances vers ta pas" -- sion vo -- lon -- tai -- re.
       Bé -- ni sois_- tu, "qui viens au" nom du Sei -- gneur_:_
       Ho -- san -- na au plus haut des cieux_!
     }
     \new Staff \with {\remove Time_signature_engraver }
     << \new Voice = "ténor"
        { \voiceOne \relative c'
          { \clef "bass" \armure \cadenzaOn
            d2 d d4 f f\breve*1/8 d2 d4 d d2 d 
            d4 d f f2 f\breve*1/8 f2 g4 e c2 d4 ees! f2 ees4 ees d2 c d1
          } 
        }
        \new Voice = "basse"
        { \voiceTwo \relative c'
          { 
            g2 d\fermata\resp 
            g4 f bes\breve*1/8 fis2 fis4 fis g2 d\fermata
            g4 g f f2 bes\breve*1/8 bes2 e,4 c f2
            bes4 bes <bes, bes'>2 ees4 c f2 f bes,1\fermata
          } \transpose bes bes \tonVIIIah
        }
     >>
  >>
}

% \transpose bes g {
%   \new ChoirStaff
%   << 
%     \new Staff \with {\remove Time_signature_engraver }{ \armure \cadenzaOn \tonRVIIbf }
%     \new Staff \with {\remove Time_signature_engraver }{ \clef "bass" \armure \cadenzaOn \tonRVIIbh }
%   >>
% }

