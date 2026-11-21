\version "2.24.0"

%\include "vowel-set.ly"\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }


% \paper {
%   system-system-spacing.basic-distance = #15
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = ##f
% }
% 
% #(set-global-staff-size 19)
% 
% \header {
%   title = \markup \center-column { "J’ai vu jaillir" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
% }
% 
% \layout {    
%   indent = #0
%   \context { 
%     \Score \remove "Bar_number_engraver"
%   }
%   \context { 
%     \Lyrics
%     \override LyricText.font-size = #2
%     \override LyricSpace.minimum-distance = #1
%   }
% } 

armure = { \key c \major \time 3/4 }
resp = { \breathe\allowBreak }
silC = { \oneVoice r8 \voiceOne }

\transpose g e
\new ChoirStaff
<< \new Dynamics 
   {
     g8^\< g [a] a4. f8^\> a [g] g4 g2\!\resp
          g8^\p^\< [a] c4. (d8) a [g] a ([b]) a4.
          g8^\f a [g] a [b] c4^\> b8 [a] b [c] b4\!\bar"|"
          c8^\mf [b] c4 a8 [d] c [b] c ([d]) c [b] g4.\resp
          g8 c [d] c4 c8 [d] 
          e^\> [d] c [b] a4\!\bar"|"
          a8^\ppp [g] a [c] g [a] g4 f\resp g8 [a] a [a] b [a] a4.\bar"|"
          a8 g ( [f] g [a] c4 a b8 [c]) g4 (a g) g2
   }
   \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << %\accidentalStyle neo-modern-voice
      \new Voice = "soprano"
      { \voiceOne \relative c''
        { \clef "treble" \armure \cadenzaOn \tempo "Vivace"% 2 = 52
          g8 g [a] a4. f8 a [g] g4 g2 \resp
          g8 [a] c4. (d8) a [g] a ([b]) a4.
          g8 a [g] a [b] c4 b8 [a] b [c] b4\fermata\bar"|"
          c8 [b] c4 a8 [d] c [b] c ([d]) c [b] g4.\resp
          g8^\markup\italic"très allant" c [d] c4 c8 [d] 
          e [d] c [b] a4\!\bar"|"
          a8 [g] a [c] g [a] g4 f\resp g8 [a] a [a] b [a] a4.\bar"|"
          a8 g ( [f] g [a] c4 a b8 [c]) g4 (a g) g2\fermata
          \bar"|."
        } 
      }
      \new Voice = "altos"
      { \voiceTwo \relative c'
        { 
          d8 d [e] e4. d8 e [d] d4 d2 g8 [g] g4 (a) g8 [g] f4 e\resp
          e e8 [f] e [d] e4 e8 [e] d [d] d4
          e8 [d] c ([d]) e [f] e [e] d4 e8 [d] e4.
          d8 e [d] e ([f]) g [a] b [a] g [g] f4
          f8 [e] f [e] e [d] e ([d]) c4
          e8 [e] d [f] e [f] e4 (d)
          d d e8 ([d] c [d]) d4 d8 ([e]) f ([e]) d4 d2
        }    
      }
   >>
   \new Lyrics \with { alignAboveContext = "femmes" } \lyricsto "soprano"
   {
     \repeat unfold 64 {\skip4} Al -- lé -- lu -- ia_!
   }   
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "altos"
   {
      J’ai vu jail -- lir du seuil du Tem -- ple 
      u -- ne sour -- ce d’eaux vi -- ves_:
      Où pas -- se son tor -- rent, la vie re -- naî -- tra,
      et tous ceux qui é -- taient plon -- gés dans ses flots
      é -- taient sau -- vés de la mort et du pé -- ché.
      Ils chan -- taient dans l’al -- lé -- gres -- se 
      le can -- ti -- que de l’A -- gneau_:
      Al -- lé -- lu -- ia_! Al -- lé -- lu -- ia_!
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor"
      { %\accidentalStyle neo-modern-voice
        \voiceOne \relative c'
        { \clef "bass" \armure \cadenzaOn
          b8 b [c] c4. a8 c [c] b4 b2 g8 [g] e'4 (f) e8 [e] d4 c
          c b8 [d] c [b] a4 a8 [a] a [a] g4 
          g8 [g] g4 a8 [a] b [b] a4 g8 [a] b4.
          b8 c [a16 (b)] c8 ([d]) e [f] g [f] e [d] e4
          e8 [d] c [c] b [a] b4 c b8 [c] c [c] d [c] c4.
          \silC b8 [c] b ([a]) g4 g8 ([a]) g ([a]) b4 (c2) b
        } 
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        { 
          g8 g [g] g4. a8 f [g] g4 g2 \resp g8 [g] g2 g8 [g] g4 g\resp
          g g8 [g] g [g] f4 f8 [f] f [f] g4\fermata
          c,8 [d] e4 f8 [f] g [g] f4 e8 [f] g4.\resp
          f8 e [f] g4 g8 [g] g [g] a [b] c4
          c8 [b] a [a] g [f] g4 a\resp
          g8 [f] f [a] g [a] g4.
          s8 g8 [a] g ([f]) e [(d]) e ([f]) g4 g (f g) g2\fermata
        } 
      }
   >>
   \new Lyrics \with { alignAboveContext = "hommes" } \lyricsto "ténor"
   {\repeat unfold 64 {\skip4} Al -- lé -- lu -- ia_!  Al -- lé -- lu -- ia_!   }
>>

\transpose g e
<< \new Staff = "femmes" \with {\remove Time_signature_engraver }
      \new Voice = "soprano"
      {  \relative c''
        { \clef "treble" \armure \cadenzaOn
          g8 a ([g]) g ([c]) c [c] c8 [(b]) c ([d]) d c [(d)] c4\bar"|"
          c8 ([a]) a ([c]) c c4. (b8 g4.)\resp 
          a8 c ([b]) a g2\bar"|."
          g8 [a] g ([c]) c [c] c4 \resp
          c8 ([b]) c ([d]) c [(d]) c c4\bar"|"
          c8 ([a]) a [c] c\breve c4\resp
          c8 [b] c ([d]) d c ([d]) c c4 \bar"|"
          c8 [a] a ([c]) c [c] c4. (b8 g4.)
          a8 c ([b a]) g2\bar"|."
          \bar"|."
        } 
      }

   \new Lyrics  \lyricsto "soprano"
   { \set stanza = "1. "
     Ren -- dez grâce au Sei -- gneur car il est bon_: 
     car é -- ter -- nel est son a -- mour_!
     \set stanza = "2. "
     Gloire au Père, et au Fils, et au Saint Es -- prit
     comme il é -- "tait au commence" -- ment, 
     main -- te -- nant et pour tou -- jours,
     dans les siè -- cles des siè -- cles. A -- men.
   }   
>>
\layout {
  \context {
    \Lyrics
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}
