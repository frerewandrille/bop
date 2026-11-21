\version "2.24.0"

\include "vowel-set.ly"

armure = { \key g \minor \time 1/4 }
resp = { \breathe\allowBreak }
barre = { \undo \omit Score.BarLine }
barress = { \omit Score.BarLine }
silN = { \oneVoice r4 \voiceOne }
silC = { \oneVoice r8 \voiceOne }

\layout {
  \context {
    \Lyrics
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}

\new ChoirStaff
<< \new Dynamics 
   { \override Hairpin.to-barline = ##f
     
   }
   \new Staff = "femmes" \with {\remove Time_signature_engraver }
   << 
     \new Voice = "soprano"
     { \voiceOne \relative c''
       { \clef "treble" \armure
         \barress
         g8 g a4-> a8 bes c (bes) a g f f d d g4 
         \silC g8 d'4-> d8 c bes4. c8 d bes c a a2
         \silC a8 c bes a g a a bes a g f d4 
         \silN d8 d es!4-> f8 g f ees f g f ees ees4 d
         \barre\bar "|."
         
         g8 \barress g a4 a8 bes c bes a g f f d d g4 \silC g8 d' d d d d c bes4.-> 8 c d bes c a a a2
         a8 c bes4-> a8 g a a bes a g f d4 d8 d ees4 f8 g f ees f g f4 ees d
         \barre\bar "|."
         
%          \relative c'' { bes4.\barress c8 d bes c a a4 a \silN a8 c bes4-> a8 g a a bes a g f d4 d
%          \silC d8 d d ees4. 8 f g f ees f4 ees d }
%          \barre\bar "|."
         
         \silC \barress g8 a4 \silC bes8 c bes a g f f d4-> d8 d g4 g 
         \silC g8 d' d d c bes4-> 8 c d bes c a a2
         \silC a8 c bes a g a4. 8 bes a g f d4 \silC d8 ees8 8 f g f ees f g f4 ees d2
         \barre\bar "|."
         
         d4 (\barress ees8 d) c4 (d)
         \barre\bar "|."
       }
     }
     \new Voice = "alto" 
     { \voiceTwo \relative c''
       {
         g8 g f4 8 8 ees (f) f d d f d d g4 
         s8 g  g\breve*1/8 s g4. g8 \breve*1/16 s s s fis2
         s8 fis!8 a g f! e f\breve*1/16 s s s d8 d d4 
         s d8 d c\breve*1/8 s8 s s s s s s s c4 d
         
         g8 g f4 f8 f ees f f d d d d d d4 s8 g8 \breve*1/16 s s s s s g4.
         g8 g\breve*1/16 s s s s s fis2
         fis!8 a g4 f!8 e f!\breve*1/16 s s s d8 d d4 d8 d c4 c\breve*1/16 s s s s s c4 c d
         
%          \relative c'' { g4. g8 g\breve*1/16 s s s fis4 f4 s fis!8 a g4 f!8 e f\breve*1/16 s s s d8 d d4 d
%          s8 d d d c4. c8 c\breve*1/16 s s s c4 c d }
         
         s8 g8 f4 s8 f ees f f d d d d4 d8 d d4 d 
         s8 g g\breve*1/16 s s s g4 \breve*1/16 s s s s s fis2
         s8 fis a g f! e! f4. f8 f f d d d4 s8 d c\breve*1/16 s s s s s s s c4 c d2
         d4 (c8 bes) c4 (d)
       }          
     }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano 
   { 
     \set stanza = #"1. "
     Les mar -- tyrs sont les ar -- bres plan -- tés au bord des eaux,
     leurs feuilles et leurs fruits gué -- ris -- sent les na -- tions.
     Vous a -- vez ai -- mé Dieu et mé -- pri -- sé la mort.
     A -- vec nous, sup -- pli -- ez le Christ, a -- mi des hom -- mes.
     \set stanza = #"2. "
     Qu’elle est bel -- le, la voix cri -- ant de -- vant les tri -- bu -- naux_: 
     “Nous ne re -- nie -- rons pas le Christ, qui pour nous mou -- rut sur la croix_!”
     Qu’elle est bel -- le, leur voix lou -- ant de -- vant les ju -- ges 
     le Christ, Fils de Dieu, res -- sus -- ci -- té pour nous.
%      \set stanza = #"3. "
%      Christ, et que vien -- ne ta grâ -- ce_!”
%      Qu’elle est dou -- ce, leur voix té -- moi -- gnant dans les siè -- cles_: 
%      “C’est par ta Croix, Sei -- gneur, que tu nous rends la vie.”
     \set stanza = #"4. "
     Heu -- reux les af -- fa -- més et as -- soif -- fés de jus -- ti -- ce, 
     qui pré -- fé -- rèrent au mon -- de l’a -- mour du Fis de Dieu,
     bon -- heur im -- mense aux saints qui don -- nèrent à l’É -- poux 
     l’of -- fran -- de de leur sang jail -- li de leur a -- mour.
     A -- men.
   }
   \new Staff = "hommes" \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" %\with { \consists "Balloon_engraver" }
      { \voiceOne \relative c'
        { \clef "bass" \armure
          \revert Staff.TimeSignature.style
          g8 g c4 d8 bes g (bes) c bes a a c bes bes4 
          \silC g8 bes4 8 c d4. ees8 f d ees c d2 
          \silC d8 \breve*1/16 s s d8 d\breve*1/16 s s c8 bes a bes4
          \silN bes8 a g4 a8 bes a g a bes a g g (a) bes4
          
          g8 g c4 d8 bes g bes c bes a a c bes bes4 
          \silC g8 bes\breve*1/16 s s s s c8 d4.
          8 ees f d ees c c d2 d8 d d4 d\breve*1/16 s s s s c8 bes a bes4 8 a g4 
          a8 bes a g a bes a4 g8 (a) bes4
          
%           \relative c' { d4. ees8 f d ees c d4 d \silN d8 d d4 d\breve*1/16 s s s s c8 bes a c4 bes4
%           \silC bes8 8 a g4. g8 a bes a g a4 g8 (a) bes4 }
          
          \silC g8 c4 \silC bes8 g bes c bes a a c4 bes8 a8 bes4 4 
          \silC g8 bes\breve*1/16 s s c8 d4 8 ees f d ees c d2
          \silC d8 d\breve*1/16 s s s d4. 8 8 c bes a bes4 
          \silC a8 g g a bes a g a bes a4 g8 (a) bes2
          bes4 (g) g (a)
        }
      }
      \new Voice = "basse"
      { \voiceTwo \relative c'
        {
          g8 g f4-> d8 d c (d) f g a a g g g4 
          s8 g g4-> f8 ees g4. g8 g g ees ees d2 
          s8 d8 \breve*1/16 s s a'8 d,\breve*1/16 s s f8 g a g4
          s g8 f c4-> f\breve*1/16 s s s s c8 c c c4 g'
          
          g8 g f4 d8 d c d f g a a g g g4 
          s8 g g\breve*1/16 s s s f8 ees g4.->
          g8 g\breve*1/16 s s s ees8 8 d2 d8 d d4 d8 a' d,\breve*1/16 s s f8 g a g4 
          g8 f c4 f\breve*1/16 s s s s c8 c4 c g'
          
%           \relative c' { g4. g8 g8 g ees8 8 d4 4 s4 d8 d d4 d8 a' d,\breve*1/16 s s f8 g a g4 g 
%           s8 g8 g f c4. c8 f\breve*1/16 s s c8 c4 c g' }
          
          s8 g f4 s8 d c d f g a a g4-> g8 g g4 4
          s8 g g g f ees g4-> g\breve*1/4 ees8 8 d2 
          s8 d d\breve*1/16 s s a'8 d,4. d8 d f g a g4 s8 f c c f\breve*1/16 s s s s c8 c4 c g'2
          
          g4 (c,8 d) ees4 (d)
        }
      }
   >>
>>