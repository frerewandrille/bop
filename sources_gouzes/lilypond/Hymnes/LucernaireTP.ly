\version "2.24.0"

\include "vowel-set.ly"

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
  } 
}


\transpose g f 
\new ChoirStaff 
<< \new Staff \with {\remove Time_signature_engraver }	
   << \new Voice = "sopranos" 
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \major \cadenzaOn
          b \breve a2  \breathe  \allowBreak a \breve c b2\fermata \bar "|" 
          b \breve c4 d2 d \breve c4 b a2  \breathe  \allowBreak a \breve b4 c \breve b a2\fermata \bar "||" 
      } }
      \new Voice = "alto" 
      { \voiceTwo \relative c'' 
        {
          g \breve g2 g \breve g g2
          g \breve a4 b2 b \breve a4 g fis2   fis \breve g4 a \breve g fis2  } }
   >>
   \new Lyrics \lyricsto "sopranos"  { 
     \set stanza = #"1. "\set shortVocalName = "1."
     "Venant au coucher du so" -- leil,
     "contemplant la lu" -- "mière du" soir,
     "nous chantons" le Père, \skip4 et le Fils,
     et  le Saint_Es  -- prit_de  Dieu.
   }
   \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   \lyricsto "sopranos"  { 
     \set stanza = #"2. "\set shortVocalName = "2."
     "Digne es-tu en tous temps d’être lou" -- é
     "par de" "saintes" voix,
     "Fils" de Dieu "qui don" -- nas la vie,
     et  le "monde te"  glori  -- fie.
   }
   \new Lyrics \lyricsto "sopranos"  { 
     \set stanza = #"3. " \set shortVocalName = "3."
     "Tu nous ramènes au Para" -- "dis," 
     "et devant" "nous marche ta" "gloire ;" 
     "Tu nous" re -- vêts "de l’abondance" "de" "ta" "gloire,"
     "tu nous" "re" -- "çois ' dans ton re" -- "pos et dans ta" "paix."
   }
   \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
   \lyricsto "sopranos"  { 
     \set stanza = #"4. "\set shortVocalName = "4."
     "Dieu que personne n’a jamais" -- "vu,"
     "tu nous l’as fait connaître ' en ta"  "chair ressusci" -- "tée :"
     "en te voyant" "ô" "Christ," "nous contem" -- "plons" "le" "Père,"
     "en ta" "lu" -- "mière, ' nous avons"   "vu la lu" -- "mière."
   }
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto "sopranos"  { 
     \set stanza = #"5. "\set shortVocalName = "5."
     "Que ma prière, vers toi Sei" -- "gneur,"
     "s’é" -- "lève comme l’en" -- "cens,"
     "et" "mes" "mains," \skip4 "de" -- "vant" "toi,"
     "comme" "l’of" -- "fran"  -- "de du" "soir."
   }


   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \cadenzaOn
          d \breve c2 c \breve e d2
          d \breve d4 g2 g \breve d4 d d2 d \breve d4 d \breve d d2 
      } }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          g \breve g2 \breathe g \breve g g2\fermata 
          g \breve g4 g2 g \breve fis4 g d2 \breathe d \breve d4 fis \breve g d2\fermata 
      } }
   >>
>>


%{
convert-ly (GNU LilyPond) 2.24.1  convert-ly: Traitement de «  »...
Conversion en cours : 2.17.0, 2.17.4, 2.17.5, 2.17.6, 2.17.11,
2.17.14, 2.17.15, 2.17.18, 2.17.19, 2.17.20, 2.17.25, 2.17.27,
2.17.29, 2.17.97, 2.18.0, 2.19.2, 2.19.7, 2.19.11, 2.19.16, 2.19.22,
2.19.24, 2.19.28, 2.19.29, 2.19.32, 2.19.39, 2.19.40, 2.19.46,
2.19.49, 2.20.0, 2.21.0, 2.21.2, 2.22.0, 2.23.1, 2.23.2, 2.23.3,
2.23.4, 2.23.5, 2.23.6, 2.23.7, 2.23.8, 2.23.9, 2.23.10, 2.23.11,
2.23.12, 2.23.13, 2.23.14, 2.24.0
%}
