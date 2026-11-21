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
                      "Nous te chantons, Fils de Ma"\breve -- "rie,"2 \set stanza = #"3. "
                      "l’é"\breve -- "pouse sans"\breve "tache."2 \set stanza = #"3. "
                      "Tu t’es"\breve "vê"4 -- "tu"2 "de"\breve "no"4 -- "tre"4 "chair,"2 \set stanza = #"3. "
                      "toi,"\breve "la"4 "source de" \breve "la lu"\breve -- "mière." 2
   }
   \new Lyrics \lyricmode { \set stanza = #"4. "
                      "Dans le sein de la Vierge Ma"\breve -- rie,2 \set stanza = #"4. "
                      "tu as brillé comme une"\breve "flamme ar"\breve -- dente,2 \set stanza = #"4. "
                      "et quand elle ac"\breve -- cueil4 -- lit2 "la Paro"\breve -- le4 de4 l’ange,2 \set stanza = #"4. "
                      "a resplendi"\breve sur4 "elle, la lu" \breve -- "mière de ta"\breve face.2
   }
   \new Lyrics \lyricmode { \set stanza = #"5. "
                      "Tandis que nous étions plongés dans les té"\breve -- nèbres,2 \set stanza = #"5. "
                      "tu es venu, Fils de David, visi"\breve -- "ter notre"\breve nuit.2 \set stanza = #"5. "
                      "Marie est devenue"\breve le4 Trô2 -- "ne de"\breve la4 Sa4 -- gesse,2 \set stanza = #"5. "
                      "où le Père a préparé une"\breve lu4 -- "mière" \breve "pour son"\breve Christ.2
   }
   \new Lyrics \lyricmode { \set stanza = #"6. "
                      "Tu as fait resplendir la beauté de ta"\breve gloire2 \set stanza = #"6. "
                      "en Marie, ta Mère, la"\breve "fille de Si"\breve -- on.2 \set stanza = #"6. "
                      "Dans son cœur et"\breve sa4 chair,2 "elle exul"\breve -- te4 de4 joie,2 \set stanza = #"6. "
                      "Dans son cœur et"\breve sa4 chair,2 "elle exul"\breve -- te4 de4 joie,2 \set stanza = #"6. "
                      "car tu t’es souvenu de la"\breve dé4 -- "tresse" \breve "de ton"\breve Peuple.2
   }
%   \new Lyrics \lyricmode {
%                      ""\breve ""2
%                      ""\breve ""\breve ""2
%                      ""\breve ""4 ""2 ""\breve ""4 ""4 ""2
%                      ""\breve ""4 "" \breve ""\breve"" 2
%   }
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
   \new Lyrics \lyricmode 
   { \set stanza = #"10. " \override Lyrics.LyricText.font-shape = #'italic
                      "Les anges t’offrent leurs chants, et les mages, leurs pré"\breve -- "sents,"2 \set stanza = #"10. "
                      "les cieux t’offrent une étoile, et la"\breve "terre une"\breve "grotte,"2 \set stanza = #"10. "
                      "les bergers t’offrent un"\breve "a"4 -- "gneau,"2 "la race d’Ève of"\breve -- "fre"4 "Ma"4  -- "rie,"2 \set stanza = #"10. "
                      "et Marie offre en"\breve "sa"4 "chair ta de" \breve -- "meure parmi"\breve "nous."2
   }

   \new Lyrics \lyricmode {
                      ""\breve ""2
                      ""\breve ""\breve ""2
                      ""\breve ""4 ""2 ""\breve ""4 ""4 ""2
                      ""\breve ""4 "" \breve ""\breve ""2
                    }
   \new Lyrics \lyricmode { \set stanza = #"11. "
                      "Que ma prière, vers toi Sei"\breve -- "gneur,"2 \set stanza = #"11. "
                      "s’é"\breve -- "lève comme l’en"\breve -- "cens,"2 \set stanza = #"11. "
                      "et"\breve "mes"4 "mains,"2 ""\breve "de"4 -- "vant"4 "toi,"2 \set stanza = #"11. "
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
