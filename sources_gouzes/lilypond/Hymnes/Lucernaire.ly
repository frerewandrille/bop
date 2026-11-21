\version "2.24.0"
\include "vowel-set.ly"

gauche = { \once \override LyricText.X-offset = #center-on-vowel }

\transpose g e 
\new ChoirStaff 
<< \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "soprano" 
      { \voiceOne \relative c'' 
        { \clef "treble" \key g \major \cadenzaOn \tempo \markup{ "Très léger, " \dynamic ppp ", calme" }
          b4 c^>(b c) d2. b s2 b4 b^>( a b) c^>( b c) d2. b \bar "|" 
          e4 e d c d2^"rall." c4 c^\> b2\fermata\! \bar "|." 
      } }
      \new Voice = "alto" 
      { \voiceTwo \relative c'' 
        {
          g4 a( g a) b2. g r2 g4 g(fis g) a(g a) b2. g g4 g g g g2 g4 fis g2 
      } }
   >>
   \new Lyrics \lyricmode
   { \set associatedVoice = #"alto"
     Joy4 -- eu4 -- se4 lu4 -- miè2. -- re_!2. \skip 2
     Splen4 -- deur4 é4 -- ter4 -- nel4 -- le4 du4 Pè2. -- re_! 2.
     Saint4 et4 bien4 -- heu4 -- reux,2 Jé4 -- sus4 Christ_!2
   }
   \new Staff \with {\remove Time_signature_engraver }
   << \new Voice = "ténor" 
      { \voiceOne \relative c' 
        { \clef "bass" \key g \major \cadenzaOn
          d1 g2. d r2  d4 d1. g2. d
          g4 g g g g(d) e d d2 
      } }
      \new Voice = "basse" 
      { \voiceTwo \relative c' 
        {
          g1 g2. g s2  g4 g1. g2. g
          c4 c b a b2 a4 a g2\fermata
      } }
   >>
>>
\pageBreak


\score {
  \transpose g e  {
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
       \new Lyrics \lyricmode { 
         \set stanza = #"1. "
         "Venant au coucher du so"\breve -- leil,2 \set stanza = #"1. "
         "contemplant la lu"\breve -- "mière du"\breve soir,2 \set stanza = #"1. "
         "nous chantons"\breve le4 Père,2 ""\breve et4 le4 Fils,2 \set stanza = #"1. "
         et \breve le4 Saint_Es \breve -- prit_de \breve Dieu.2
       }
       \new Lyrics 
       \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
       \lyricmode { 
         \set stanza = #"2. "
         "Digne es-tu en tous temps d’être lou"\breve -- é2 \set stanza = #"2. "
         "par de"\breve "saintes"\breve voix,2 \set stanza = #"2. "
         "Fils"\breve de4 Dieu2 "qui don"\breve -- na4 la4 vie,2 \set stanza = #"2. "
         et \breve le4 "monde te" \breve glori \breve -- fie.2
       }
       \new Lyrics \lyricmode {
         \override Lyrics.LyricText.font-shape = #'italic
         \override Lyrics.LyricText.font-series = #'bold
         "Vierge Marie"\breve ""2
         %                      ""\breve ""\breve ""2
         %                      ""\breve ""4 ""2 ""\breve ""4 ""4 ""2
         %                      ""\breve ""4 "" \breve ""\breve"" 2
       }
       \new Lyrics \lyricmode { 
         \set stanza = #"3. "
         "Nous te chantons, Fils de Ma"\breve -- "rie,"2 \set stanza = #"3. "
         "l’é"\breve -- "pouse sans"\breve "tache."2 \set stanza = #"3. "
         "Tu t’es"\breve "vê"4 -- "tu"2 "de"\breve "no"4 -- "tre"4 "chair,"2 \set stanza = #"3. "
         "toi,"\breve "la"4 "source de" \breve "la lu"\breve -- "mière." 2
       }
       \new Lyrics \lyricmode { 
         \set stanza = #"4. "
         "Dans le sein de la Vierge Ma"\breve -- rie,2 \set stanza = #"4. "
         "tu as brillé comme une"\breve "flamme ar"\breve -- dente,2 \set stanza = #"4. "
         "et quand elle ac"\breve -- cueil4 -- lit2 "la Paro"\breve -- le4 de4 l’ange,2 \set stanza = #"4. "
         "a resplendi"\breve sur4 "elle, la lu" \breve -- "mière de ta"\breve face.2
       }
       \new Lyrics \lyricmode { 
         \set stanza = #"5. "
         "Tandis que nous étions plongés dans les té"\breve -- nèbres,2 \set stanza = #"5. "
         "tu es venu, Fils de David, visi"\breve -- "ter notre"\breve nuit.2 \set stanza = #"5. "
         "Marie est devenue"\breve le4 Trô2 -- "ne de"\breve la4 Sa4 -- gesse,2 \set stanza = #"5. "
         "où le Père a préparé une"\breve lu4 -- "mière" \breve "pour son"\breve Christ.2
       }
       \new Lyrics 
       \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
       \lyricmode { 
         \set stanza = #"6. "
         "Tu as fait resplendir la beauté de ta"\breve gloire2 \set stanza = #"6. "
         "en Marie, ta Mère, la"\breve "fille de Si"\breve -- on.2 \set stanza = #"6. "
         "Dans son cœur et"\breve sa4 chair,2 "elle exul"\breve -- te4 de4 joie,2 \set stanza = #"6. "
         "Dans son cœur et"\breve sa4 chair,2 "elle exul"\breve -- te4 de4 joie,2 \set stanza = #"6. "
         "car tu t’es souvenu de la"\breve dé4 -- "tresse" \breve "de ton"\breve Peuple.2
       }
       \new Lyrics \lyricmode 
       { \set stanza = #"7. " \override Lyrics.LyricText.font-shape = #'italic
         "Au soir où tu fus immolé sur la"\breve "croix,"2 \set stanza = #"7. "
         "Marie entrait dans la nuit de la"\breve "mort avec"\breve "toi,"2 \set stanza = #"7. "
         "mais tu as changé"\breve "son"4 "deuil"2 "en"\breve "chant"4 "de"4 "joie"2 \set stanza = #"7. "
         "quand tu sortis du"\breve tom4 -- "beau, drap" \breve -- "pé de lu"\breve -- mière.2
       }
       \new Lyrics \lyricmode 
       { \set stanza = #"8. " \override Lyrics.LyricText.font-shape = #'italic
         "Tu as fait briller dans la chair de Ma"\breve -- "rie"2 \set stanza = #"8. "
         "la splendeur de"\breve "ta résurrec"\breve -- "tion."2 \set stanza = #"8. "
         "Tu l’as couronnée de"\breve "l’é"4 -- "clat"2 ""\breve "des"4 "é"4 -- "toiles,"2 \set stanza = #"8. "
         "toi, le"\breve "so"4 -- "leil qui s’é" \breve -- "lève sur le cou"\breve -- "chant." 2
       }
       \new Lyrics \lyricmode 
       { \set stanza = #"9. " \override Lyrics.LyricText.font-shape = #'italic
         "Tu accueilles Marie dans la gloire des"\breve "cieux"2 \set stanza = #"9. "
         "car son cœur et sa chair ' avaient cri"\breve -- "é vers"\breve "toi."2 \set stanza = #"9. "
         "car son cœur et sa chair ' avaient cri"\breve -- "é vers"\breve "toi."2 \set stanza = #"9. "
         "Bienheureux,"\breve "Sei"4 -- "gneur,"2 "qui habitent en"\breve "ta"4 "mai"4 -- "son :"2 \set stanza = #"9. "
         "tu fais briller"\breve "sur"4 "eux la lu" \breve -- "mière de ta"\breve "face." 2
       }
       \new Lyrics 
       \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
       \lyricmode 
       { \set stanza = #"10. " \override Lyrics.LyricText.font-shape = #'italic
         "Les anges t’offrent leurs chants, et les mages, leurs pré"\breve -- "sents,"2 \set stanza = #"10. "
         "les cieux t’offrent une étoile, et la"\breve "terre une"\breve "grotte,"2 \set stanza = #"10. "
         "les bergers t’offrent un"\breve "a"4 -- "gneau,"2 "la race d’Ève of"\breve -- "fre"4 "Ma"4  -- "rie,"2 \set stanza = #"10. "
         "et Marie offre en"\breve "sa"4 "chair ta de" \breve -- "meure parmi"\breve "nous."2
       }
       \new Lyrics \lyricmode 
       { \override Lyrics.LyricText.font-shape = #'italic \override Lyrics.LyricText.font-series = #'bold
         "Apôtres"\breve ""2
       }
       \new Lyrics \lyricmode { 
         \set stanza = #"11. "
         "Tu es venu dans le"\breve "monde"2 \set stanza = #"11. "
         "toi, la lu"\breve -- "mière véri"\breve -- "table."2 \set stanza = #"11. "
         "Les disciples ont vu"\breve "ta"4 "gloire,"2 "et il l’ont"\breve "pro"4 -- "cla"4 -- "mée,"2 \set stanza = #"11. "
         "car tu étais auprès"\breve "du"4 "Père, et tu nous" \breve "es appa"\breve -- "ru."2
       }
       \new Lyrics \lyricmode { 
         \set stanza = #"12. "
         "Au soir de ta résurrec"\breve -- "tion,"2 \set stanza = #"12. "
         "tu es appa"\breve -- "ru à tes a"\breve -- "pôtres :"2 \set stanza = #"12. "
         "Ne crai"\breve -- "gnez"4 "pas !"2 "La paix soit"\breve "a"4 -- "vec"4 "vous !"2 \set stanza = #"12. "
         "Comme le Père m’a en"\breve -- "vo"4 -- "yé, ' moi aus" \breve -- "si, je vous en"\breve -- "voie."2
       }
       \new Lyrics 
       \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
       \lyricmode { 
         \set stanza = #"13. "
         "Tu as soufflé sur tes dis"\breve -- "ciples,"2 \set stanza = #"13. "
         "et l’Esprit est venu sur"\breve "eux comme une"\breve "flamme."2 \set stanza = #"13. "
         "Il a rempli"\breve "leur"4 "cœur"2 "de feu et"\breve "de"4 "puis"4 -- "sance,"2 \set stanza = #"13. "
         "Il a rempli"\breve "leur"4 "cœur"2 "de feu et"\breve "de"4 "puis"4 -- "sance,"2 \set stanza = #"13. "
         "et la lumière de"\breve "ta"4 "Pâque a resplen" \breve -- "di sur l’uni"\breve -- "vers."2
       }
       \new Lyrics \lyricmode {
         ""\breve ""2
         ""\breve ""\breve ""2
         ""\breve ""4 ""2 ""\breve ""4 ""4 ""2
         ""\breve ""4 "" \breve ""\breve ""2
       }
       \new Lyrics \lyricmode { 
         \set stanza = #"14. "
         "Que ma prière, vers toi Sei"\breve -- "gneur,"2 \set stanza = #"14. "
         "s’é"\breve -- "lève comme l’en"\breve -- "cens,"2 \set stanza = #"14. "
         "et"\breve "mes"4 "mains,"2 ""\breve "de"4 -- "vant"4 "toi,"2 \set stanza = #"14. "
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
  }
  \layout {
%    \context { \Lyrics \override LyricText.X-offset = #center-on-vowel }
    \context { \Lyrics \override LyricText.X-offset = #left }
  }
}