\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 20
%   right-margin = 20
% }
% 
% #(set-global-staff-size 12.5)
% 
% \header {
%   title = \markup \center-column { "Viens, Esprit créateur" }
%   subtitle = " "
%   poet = ""
%   composer = ""
%   tagline = ##f
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
%
\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

armure = { \key a \minor \time 2/2 }
resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

global = {
  \key g \minor
  \time 3/2
}

sopMusic = \relative c' {
  f4-> g f-> ees f g-> f bes-> c bes2\resp
  bes4-> f g-> bes c-> bes c-> d c2.\bar "|"
  bes4 c-> d bes-> a g-> f bes-> c \once \slurDashed f,-> (g) bes2\resp
  a4-> bes g f-> ees g g-> (a) g \slurDashed f-> (ees) f2\fermata \bar "|."
}

altoMusic = \relative c' { 
  f4 ees d c d ees d c c d2 d4 d ees d c d ees ees f2.
  bes4 a a g f ees ees d d \tieDashed ees~ ees d2
  f4 d ees d c c bes (a) bes \slurDashed c (d) c2
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. " \set shortVocalName = "1."
  Viens, Es -- prit Cré -- a -- teur nous vi -- si -- ter,
  Viens é -- clai -- rer l’â -- me de tes fils,
  Em -- plis nos cœurs de grâce et de lu -- miè __ -- re,
  Toi qui cré -- as tou -- te chose a -- \im vec a -- mour.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "  \set shortVocalName = "2."
  Toi le Don, l’en -- vo -- yé du Dieu Très_- Haut,
  Tu t’es fait pour nous le Dé -- fen -- seur,
  Tu es l’A -- mour, le Feu, la sour -- ce vi -- \skip4 ve,
  Force et dou -- ceur de la grâ -- \skip4 ce du Sei -- gneur.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. " \set shortVocalName = "3."
  \im
  Don -- ne_- nous les sept dons de ton  a -- mour,
  Toi le doigt qui œuvres au Nom du Père,
  Toi dont il nous pro -- mit le règne et la ve -- nue,
  Toi qui ins -- pi -- res nos  lan -- \skip4 gues pour chan -- ter.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. " \set shortVocalName = "4."
  Mets en nous ta clar -- té, em -- bra -- se_- nous,
  En nos cœurs, ré -- pands l’a -- mour du Père,
  Viens for -- ti -- fier nos corps dans leur fai -- bles -- \skip4 se,
  Et don -- ne_- nous ta vi -- gueur é -- ter -- nel -- \skip4 le.
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5. " \set shortVocalName = "5."
  Chasse au loin l’en -- ne -- mi qui nous me -- nace,
  Hâ -- te_- toi de nous don -- ner la paix,
  A -- fin que nous mar -- chions sous ta con -- dui __  -- te,
  Et que nos vies soient  la -- vées de \im tout pé -- ché.
}

altoWordssix= \lyricmode { 
  \set stanza = #"6. " \set shortVocalName = "6."
  Fais_- nous voir le vi -- sa -- ge du Très_- Haut,
  Et ré -- vè -- le_- nous ce -- lui du Fils,
  Et toi l’Es -- prit com -- mun qui les ras -- sem -- \skip4 ble,
  Viens en nos cœurs, qu’à ja -- mais nous croy -- ions en toi.
}

altoWordssept = \lyricmode { 
  \set stanza = #"7. " \set shortVocalName = "7."
  Gloire à Dieu, no -- tre Pè -- re, dans les cieux,
  Gloire au Fils qui mon -- te des En -- fers,
  Gloire à l’Es -- prit de Force et de Sa -- ges __ -- se,
  Dans tous les siè -- cles des siè -- cles. A __ -- men
}

\transpose f e
\new ChoirStaff <<
  \new Staff = "women"\with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne \cadenzaOn
      << \global \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo
      << \global \altoMusic >>
    }
  >> 
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics \lyricsto "sopranos" \altoWordssept
>>

\markup{ \vspace #15 }

\transpose g e
\new ChoirStaff
<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \relative c''
     { \clef "treble" \armure 
       g2 a \time 3/2 g f g \time 2/2 a g c d \time 3/2 c1.\fermata\time 2/2 \resp
       c2 g a c d c d e d1 d2\fermata\resp
       c d e c b a g c d g, (a) \time 3/2  c1\fermata\resp
       b2 \time 2/2  c a \time 3/2 g f a a \(b\) a \time 2/2 g \(f\) g1\fermata
       \bar "|."
     }
   }
   \new Lyrics \lyricsto soprano 
   { \set stanza = #"2. "  \set shortVocalName = "2."
     Toi le Don, l’en -- vo -- yé du Dieu Très_- Haut,
     Tu t’es fait pour nous le dé -- fen -- seur. __ \skip4
     Tu es l’a -- mour, le feu, la sour -- ce vi --  ve,
     force et dou -- ceur de la grâ __ -- \skip4 ce du Sei -- gneur.
   }
   \new Lyrics \lyricsto soprano 
   { \set stanza = #"4. " \set shortVocalName = "4."
     Mets en nous ta clar -- té, em -- bra -- se_- nous,
     En nos cœurs, ré -- pands l’a -- mour du Pè -- re_!_
     Viens, for -- ti -- fie nos corps dans leur fai -- bles -- se,
     et don -- ne_- nous ta vi -- gueur é -- ter -- nel __ -- \skip4 le_!
   }
   \new Lyrics \lyricsto soprano 
   { \set stanza = #"6. " \set shortVocalName = "6."
     Fais_- nous voir le vi -- sa -- ge du Très_- Haut,
     Et ré -- vè -- le_- nous ce -- lui du Fils_! __ \skip4
     Et toi l’Es -- prit com -- mun qui les ras -- sem -- ble,
     viens en nos cœurs, qu’à ja -- mais nous croy -- ions en toi_!
   }
   
   \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "alto"
   { \relative c''
     { \armure
       g2 f e d c c1 e4 c b2 c f f e\fermata\resp
       r f e g e a g4 (a) b1 b2\fermata \resp
       r g4 (f) e2 f4 (e) d2 e4 (d) e2 f4 (e) d2 e f g1\fermata\resp
       r2 g4 (f) e \(d\) d (e) f2 f4 (g) f (e) d (e) f (e) d2 d d1\fermata
     }          
   }
   \new Lyrics \lyricsto alto 
   { \set stanza = #"2. "  \set shortVocalName = "2."
     Toi le Don, l’en -- vo -- yé __  \skip4 \skip4 \skip4 du Dieu Très_- Haut,
     Tu t’es fait le dé -- fen -- seur. __\skip4
     Tu es l’a -- mour, le feu, la sour -- ce vi --  ve,
     force et dou -- ceur de la grâ __ -- \skip4 ce du Sei -- gneur.
   }
   \new Lyrics \lyricsto alto 
   { \set stanza = #"4. " \set shortVocalName = "4."
     Mets en nous ta clar -- té, em __ -- \skip4 bra __ -- \skip4 \skip4 se_- nous,
     en nos cœurs, l’a -- mour du Pè -- re_!
     Viens for -- ti -- fier nos corps dans leur fai -- bles __ -- se,
     et don __ -- \skip4 ne_- nous ta vi -- gueur é -- ter -- nel -- le_!
   }
   \new Lyrics \lyricsto alto 
   { \set stanza = #"6. " \set shortVocalName = "6."
     Fais_- nous voir le vi -- sa __ -- \skip4 \skip4 \skip4 ge du Très_- Haut,
     et ré -- vè -- le_- nous le Fils_! __\skip4
     Et toi l’Es -- prit com -- mun qui les ras -- sem __ -- ble,
     viens en nos cœurs, qu’à ja -- mais nous croy -- ions en toi_!
   }
   
   \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "ténor"
   { \relative c'
     { \clef "G_8" \armure
       R1 r e2 f e4 (d) c e g2 g a a g\fermata\resp
       r r c, b c a4 (b) c2 d1 d2\fermata\resp
       r r g, a b c b a a b4 c d2 e1\fermata\resp
       g4 (f) e d c2 b c c d4 c b2 c c4 b a c b1\fermata
     }
   }
   \new Lyrics \lyricsto ténor 
   { \set stanza = #"2. "  \set shortVocalName = "2."
     Toi le Don, l’en -- vo -- yé du Dieu Très_- Haut,
     Tu t’es fait dé -- fen -- seur. __\skip4
     Tu es l’a -- mour, le feu, la sour -- ce vi --  ve,
     force et dou -- ceur de la grâ __ -- \skip4 \skip4 \skip4 ce du __ \skip4Sei __ -- \skip4 gneur.
   }
   \new Lyrics \lyricsto ténor 
   { \set stanza = #"4. " \set shortVocalName = "4."
     Mets en nous ta clar -- té, em -- bra -- se_- nous,
     en nous, l’a -- mour du Pè -- re_!
     Viens for -- ti -- fier nos corps dans leur fai -- bles -- se,
     et don -- ne_- nous ta vi -- gueur é __ -- \skip4 ter __ --  \skip4 nel __ -- \skip4 \skip4 \skip4 le_!
   }
   \new Lyrics \lyricsto ténor 
   { \set stanza = #"6. " \set shortVocalName = "6."
     Fais_- nous voir le vi -- sa -- ge du Très_- Haut,
     et ré -- vè -- le le Fils_! __\skip4
     Et toi l’Es -- prit com -- mun qui les ras -- sem -- ble,
     viens en nos cœurs, qu’à ja -- mais nous __ \skip4 \skip4 croy -- ions __ \skip4 \skip4 en toi_!
   }
   
   \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "basse"
   { \relative c'
     { \clef "bass" \armure
       R1 g2 a g f g a g c1 f,2 c'\fermata\resp
       r r c g a4 (g) f2 c g'1 g2\fermata\resp
       r R1 R1 r2 e a4 g f2 e d c1\fermata\resp
       e4 (d) c (d) e (f) g2 a4 (g) f (e) d2 \(g\) f g \(a\) g1\fermata
     }
   }
   \new Lyrics \lyricsto basse 
   { \set stanza = #"2. "  \set shortVocalName = "2."
     Toi le Don, l’en -- vo -- yé du Dieu Très_- Haut,
     Tu t’es fait dé -- fen -- seur. __\skip4
     Tu es la sour -- ce vi --  ve,
     force et dou -- ceur de la grâ __ -- \skip4 ce du Sei -- gneur.
   }
   \new Lyrics \lyricsto basse 
   { \set stanza = #"4. " \set shortVocalName = "4."
     Mets en nous ta clar -- té, em -- bra -- se_- nous,
     en nous, l’a -- mour du Pè -- re_!
     Viens, for -- ti -- fie sans ces -- se,
     et don -- ne_- nous ta vi -- gueur é -- ter -- nel __ -- \skip4 le_!
   }
   \new Lyrics \lyricsto basse 
   { \set stanza = #"6. " \set shortVocalName = "6."
     Fais_- nous voir le vi -- sa -- ge du Très_- Haut,
     et ré -- vè -- le le Fils_! __\skip4
     Et toi l’Es -- prit, ras -- sem -- ble,
     viens en nos cœurs, qu’à ja -- mais nous croy -- ions en toi_!
   }
>>