\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key ees \major \time 3/8 }
resp = { \breathe\allowBreak }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\transpose ees d
\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << \new Voice = "soprano"
      {  \relative c''
         { \clef "treble" \armure \tempo "Large"% 2. = 50
           r4 r8 \voiceOne aes8 g f g4 f8 ees4 
           bes'8 ees ees bes c (g) aes bes (ees,) f g4.
           aes8 g f ees4 f8 g4 aes8 bes4 bes8 ees4 bes8 c (g) aes bes4
           ees,8 f4 (aes8) g (aes f) ees4.\fermata
           \bar "|."
         }\cadenzaOn \transpose a bes \tonVgf
      }
      \new Voice = "alto"
      { \voiceTwo \relative c''
        {
          s4. aes8 g f g4 f8 ees4 
          bes'8 ees ees bes ees,4 bes8 c (g) aes bes4.
          aes'8 g f ees4 f8 g4 ees8 d4 r8 g g f ees4.~ ees 
          ees8 (d c) d4 d8 ees4.
          
        }          
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" }
   \lyricsto soprano 
   { 
     \repeat unfold 23 {\skip4}
     l’au -- ro -- re du Sa -- lut,
     al -- lé -- lu -- ia_!
   }
   \new Lyrics %\with { alignAboveContext = "hommes" }
   \lyricsto alto 
   { 
     Si -- on a en -- ten -- du 
     la voix du Sei -- gneur son Bien_- Ai -- mé. 
     Elle a vu se le -- ver pour nous
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { \voiceOne \relative c'
        { \clef "bass" \armure
          r4 r8 r4 bes8 c (g) aes bes4.~ bes bes (aes) g 
          \silN \silC c8 bes aes g (f) ees f4 
          \silC r4 bes8 ees bes (c) g4  c8 bes4. bes8 (f aes) g4.        
        }\cadenzaOn \transpose a bes \tonVgh
      }
      \new Voice = "basse"
      { \voiceTwo \relative c
        {
          ees4. ees~ ees r8 ees (f) g4. g (f) ees
          s aes8 g f ees (d) c bes4 s8 ees4. g8 g (f) bes,4.
          bes bes4 bes8 ees4.\fermata
        }
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" }
   \lyricsto ténor 
   { 
     Al -- lé -- lu -- ia_! No -- ël_! 
     No -- ël, al -- lé -- lu -- ia_!
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Lyrics %\with { alignAboveContext = "hommes" }
   \lyricsto basse 
   { 
     No -- ël_! No -- ël_! 
     \repeat unfold 8 {\skip4}
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
>>