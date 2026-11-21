\version "2.24.0"

\include "vowel-set.ly"

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 3
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}


\new Staff \with {\remove Time_signature_engraver }
<< \new Voice = "soprano" 
   { \voiceOne \relative c'' 
     { \clef "treble" \key f \major \cadenzaOn 
       a\breve bes8 c4 a8 bes\breve a4 \allowBreak a8 g\breve a4 \breathe \allowBreak f4 f8 [g] a4 a \bar "|"
       a\breve g8 f\breve \allowBreak e f4 \bar "||" f8 ([g] a4 g) f \bar "|." 
   } }
   \new Voice = "alto" 
   { \voiceTwo \relative c' 
     {
       <c f>\breve <c g'>8  <f a>4 <f c>8 <c g'>\breve <c f>4 <c f>8 <c e>\breve <c f>4
       <a d>4 <a d>8 [<c e>]  <c f>4 <c f>
       <c f>\breve <c e>8 <a d>\breve <a cis> <a d>4
   } }
   \new Voice = "ténor" 
   { \voiceOne \relative c' 
     { 
       
   } }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano" \set stanza = #"1. " \set shortVocalName = "1." 
     "Ô toi dont la"\breve beau8 -- té4
     ray8 -- "onne de clar"\breve -- 
     té4  à8
     "l’ombre de l’Es"\breve -- prit,4
     È4 -- ve8 nou8 -- vel4 -- le,4
     "laisse-nous dé"\breve -- cou8 --
     "vrir le mystère de"\breve 
     "grâce où le monde re" -- naît.4
   }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano" \set stanza = #"2. "\set shortVocalName = "2." 
     "Ta foi nous a"\breve don8 -- né4
     ce8 -- "lui qu’ont annon"\breve --
     cé4 les8 
     "hommes de l’es"\breve -- poir,4 
     joie4 des8 pro8 -- phè4 -- tes.4
     "Dieu façonne en"\breve ton8
     "corps son image éter"\breve -- 
     "nelle et se fait l’un de" nous.4
   }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano" \set stanza = #"3. " \set shortVocalName = "3." 
     "Le prix de ton"\breve a8 -- mour4
     de8 -- "meure pour tou"\breve --
     jours4 ca8  --
     "ché dans nos mois"\breve -- sons,4 
     mè4 -- re8 des8 hom4 -- mes.4
     "Tu prépares en"\breve se8 --
     "cret le ferment du roy"\breve -- 
     "aume et le pain de nos" vies.4
     A2. -- men.4
   }
>>