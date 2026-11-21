\version "2.24.0"

%\include "TonsDef.ly"
\include "TonsDef.ly"

armure = { \key ees \major \time 6/8 }
resp = { \breathe\allowBreak }


\transpose aes f
\new ChoirStaff
<< \new Staff = "femmes" %\with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure %\tempo "" 2. = 50
          \revert Staff.TimeSignature.style
          \override Hairpin.to-barline = ##f
          \partial 4. aes8^\pp aes g f4^\< c'8 c4 bes8 c4.\!~ c8 aes bes c2.
          f,8 (g) aes f (aes) bes c4 bes8 c4. f4 c8 bes aes bes c4. c
          bes8 (c) bes aes4. aes8 (bes) aes g4. g
          f8^\< (g) aes f aes bes c4 (bes8) c2.\!\fermata
          f8 f c bes aes bes c4 (d8) c4.~ c\resp
          bes8^\> (c) bes aes4 (bes8 aes4 g8) \noBreak f2.\!\fermata
          \bar "|."
        }\cadenzaOn \transpose a c' \tonIef
        %\transpose bes aes \tonIIaf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        {
          aes8 aes g f4 g8 aes4 g8 f4 (g8 aes) f f <e g>2.
          f4. f aes aes f g aes2.
          f4 f8 ees4. f4 f8 f (g f) ees4. c4 c8 d d d c4 (d8) ees2.
          aes8 aes f d d f ees4. ees4 (d8 ees4.)
          f8 (aes) f f4 (g8 f4 ees8) c2.
        }          
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" }
   \lyricsto soprano 
   { 
     \repeat unfold 11 {\skip4}
     vous ver -- rez le Roi des rois qui pro -- cè -- de du Pè -- re,
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     Quand le so -- leil se lè -- ve -- ra dans le ciel,
     \once \override Lyrics.LyricText.font-shape = #'italic \once\small b.f.
     \repeat unfold 13 {\skip4}
     tel l’É -- poux qui s’a -- van -- ce vers la cham -- bre nup -- tia -- le,
     al -- lé -- lu -- ia, al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          \partial 4. f8 f g aes4 g8 f4 g8 aes4 (g8 f) ees' d c2.
          c4. d c d c d ees2.
          d8 (ees) d c4. bes4 bes8 bes4. bes 
          aes4 aes8 bes bes bes aes4. aes2.
          c8 c c f f c bes (aes bes) c4 (bes8 c4.)
          d8 (ees) d c (d4 c8 bes4) aes2.
        }\cadenzaOn \transpose a c' \tonIeh
        %\transpose bes aes \tonIIah
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          \partial 4. f8 f f f4 f8 f4 f8 f4.~ f8 f f c2.
          f2. f f f bes,8 (aes) bes c4. d4 d8 ees4. ees 
          f4 f8 f f g aes4. aes2.\fermata
          f8 g aes bes bes aes aes4. aes~ aes\resp 
          bes4 bes8 f4. (ees) f2.\fermata
        }
      }
   >>
>>