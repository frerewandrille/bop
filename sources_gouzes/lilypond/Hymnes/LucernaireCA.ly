\version "2.24.0"

\transpose g e 
\new ChoirStaff 
<< \new Staff \with {\remove Time_signature_engraver }	
   << \new Voice = "soprano" 
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
   \new Lyrics \lyricmode { \set stanza = #"1. "
                      "Venant au coucher du so"\breve -- leil,2 \set stanza = #"1. "
                      "contemplant la lu"\breve -- "mière du"\breve soir,2 \set stanza = #"1. "
                      "nous chantons"\breve le4 Père,2 ""\breve et4 le4 Fils,2 \set stanza = #"1. "
                      et \breve le4 Saint_Es \breve -- prit_de \breve Dieu.2
   }
   \new Lyrics \lyricmode { \set stanza = #"2. "
                      "Digne es-tu en tous temps d’être lou"\breve -- é2 \set stanza = #"2. "
                      "par de"\breve "saintes"\breve voix,2 \set stanza = #"2. "
                      "Fils"\breve de4 Dieu2 "qui don"\breve -- na4 la4 vie,2 \set stanza = #"2. "
                      et \breve le4 "monde te" \breve glori \breve -- fie.2
   }
   \new Lyrics \lyricmode {
                      ""\breve ""2
                      ""\breve ""\breve ""2
                      ""\breve ""4 ""2 ""\breve ""4 ""4 ""2
                      ""\breve ""4 "" \breve ""\breve ""2
                    }
  \new Lyrics \lyricmode { \set stanza = #"3. "
                      "Tu es venu dans le"\breve "monde"2 \set stanza = #"3. "
                      "toi, la lu"\breve -- "mière véri"\breve -- "table."2 \set stanza = #"3. "
                      "Les disciples ont vu"\breve "ta"4 "gloire,"2 "et il l’ont"\breve "pro"4 -- "cla"4 -- "mée,"2 \set stanza = #"3. "
                      "car tu étais auprès"\breve "du"4 "Père, et tu nous" \breve "es appa"\breve -- "ru."2
   }
   \new Lyrics \lyricmode { \set stanza = #"4. "
                      "Au soir de ta résurrec"\breve -- "tion,"2 \set stanza = #"4. "
                      "tu es appa"\breve -- "ru à tes a"\breve -- "pôtres :"2 \set stanza = #"4. "
                      "Ne crai"\breve -- "gnez"4 "pas !"2 "La paix soit"\breve "a"4 -- "vec"4 "vous !"2 \set stanza = #"4. "
                      "Comme le Père m’a en"\breve -- "vo"4 -- "yé, ' moi aus" \breve -- "si, je vous en"\breve -- "voie."2
   }
   \new Lyrics \lyricmode { \set stanza = #"5. "
                      "Tu as soufflé sur tes dis"\breve -- "ciples,"2 \set stanza = #"5. "
                      "et l’Esprit est venu sur"\breve "eux comme une"\breve "flamme."2 \set stanza = #"5. "
                      "Il a rempli"\breve "leur"4 "cœur"2 "de feu et"\breve "de"4 "puis"4 -- "sance,"2 \set stanza = #"5. "
                      "Il a rempli"\breve "leur"4 "cœur"2 "de feu et"\breve "de"4 "puis"4 -- "sance,"2 \set stanza = #"5. "
                      "et la lumière de"\breve "ta"4 "Pâque a resplen" \breve -- "di sur l’uni"\breve -- "vers."2
   }
   \new Lyrics \lyricmode {
%                      ""\breve ""2
%                      ""\breve ""\breve ""2
%                      ""\breve ""4 ""2 ""\breve ""4 ""4 ""2
%                      ""\breve ""4 "" \breve ""\breve ""2
                    }
   \new Lyrics \lyricmode { \set stanza = #"6. "
                      "Que ma prière, vers toi Sei"\breve -- "gneur,"2 \set stanza = #"6. "
                      "s’é"\breve -- "lève comme l’en"\breve -- "cens,"2 \set stanza = #"6. "
                      "et"\breve "mes"4 "mains,"2 ""\breve "de"4 -- "vant"4 "toi,"2 \set stanza = #"6. "
                      "comme"\breve "l’of"4 -- "fran" \breve -- "de du"\breve "soir."2
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
