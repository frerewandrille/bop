\version "2.24.0"

%\include "TonsDef.ly"
\include "vowel-set.ly"

armure = { \key bes \major \time 3/4 }
resp = { \breathe\allowBreak }


\new ChoirStaff
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure \cadenzaOn \tempo "Vif"
         bes8 [8] 8 ([c bes]) 8 ([a] bes4.\fermata )\resp
         8 [8 8] 8 [c bes] 8 [a] bes4 \allowBreak
         g8 [bes] a [g] f4\fermata\resp
         \once\hide r8 [f f] f [a f] g [g f] ees [8g] f4\fermata\resp
         a8 [bes c] bes4\fermata 8 [g] f4. 2.\fermata
         \bar"|."
       } \tonVIIIcf
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c'
       { 
         f8 [f] g4~ (g16 [f]) ees8. ([f16] g4.)
         g8 [g g] g [f g] g [ees] g4 f8 [d16 (ees)] f8 [f16 (ees)] d4
         r8 [d d] d [f d] ees [8 d] c [c ees] d4
         f8 [g a] g [(f)] ees [8] d4. c2.
       }    
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "soprano"
   {
     Al -- lé -- lu -- ia_! Nous a -- vons tous é -- té a -- breu -- vés
     dans un même Es -- prit.
     Du tor -- rent de sa joie, il nous a en -- i -- vrés.
     Al -- lé -- lu -- ia, al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          d8 [d] d ([ees d]) c4 (d4.)
          bes8 [c d] ees [d ees] d [c] f4 d16 [(c) bes (c)] d8 [bes] a4
          r8 [c bes] a [bes a] bes [g a] bes [a bes] c4
          8 [bes a] bes4 c8 [c] c ([bes a]) bes ([c bes] a4.)
        } \tonVIIIch
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          bes8 [a] g16 ([f ees f g8]) ees16 ([d c8] bes4.\fermata )\resp
          g'8 [a bes] c [d c] g16[ (a) bes (c)] d4
          bes16 [(a) g8] f16 [(d) ees8] f4\fermata\resp
          \once\hide r8 [a g] f [g f] ees [8 f] g [f g] a4\fermata\resp
          8 [g f] g4\fermata 8 [g] a ([g f]) g ([a g] f4.\fermata )
        } 
      }
   >>
>>