\version "2.24.0"

\include "vowel-set.ly"

resp = { \breathe\allowBreak }

div = {
  \once \override BreathingSign.stencil = #ly:breathing-sign::divisio-maior
  \once \override BreathingSign.Y-offset = #0
  \breathe\allowBreak
}

<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \voiceOne \relative c'
     { \clef "treble" \key d \minor \time 3/4 \cadenzaOn \tempo "Samedi"
       f8 g ([a]) a a4.\resp f8 g ([a]) a a4.\resp a8 [g] c ([bes]) a4.\div
       a8 [a] d [c] c [bes a] a [g f] f4. \bar"|"
       a8 [bes] c\breve*1/8 d8 [c] c ([bes]) a4.\div
       a\breve*1/8 g8 [f bes] a4.\div 
       d8 [c] c ([bes]) a a4. f8 [g] f4. (e)\resp
       f8 [g] a [d c] c [bes a] a [g f] f4.\div 
       a8 [a] a ([bes]) a a4. a8 [g] g ([f]) e f [e] d4.
       \bar "|."
     }
   }
   \new Lyrics \lyricsto "soprano" 
   {
     %\set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Samedi "}
     Con -- so -- le_- toi, con -- so -- le_- toi, ô mon Peu -- ple,
     car bien -- tôt vien -- dra ton Sau -- veur et ton Roi_!
     Pour -- quoi "te laisses-tu consumer par" la tris -- tes -- se_?
     "Parce que la dou" -- leur t’a re -- pris_?
     Je te sau -- ve -- rai, ne crains pas_!
     Car je suis ton Sau -- veur, ton Sei -- gneur et ton Dieu,
     le Saint d’Is -- ra -- ël, ton Ber -- ger, ton Ré -- demp -- teur_!
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \voiceOne \relative c'
     { \clef "treble" \key d \minor \time 3/4 \cadenzaOn \tempo "Dimanche"
       f8 g ([a]) a a4.\resp f8 g ([a]) a a4.\resp \breve*1/8 g8 [c bes] a4. a\resp
       a8 [a] a [d c] c [bes a] a [g f] f4.\bar"|"
       a8 [bes c] c4-- c--\resp c\breve*1/8 c8 ([d]) c c [bes a] a4.\div
       a\breve*1/8 a4-- \resp a8 g [f bes] a4.\bar"|"
       d8 [c] c [bes a] a4\resp a8 g [a] f [g] f4 (e)\div
       f8 g [a] a4. d8 [c] c [bes a] a [g f] f4.\div
       a8 [a] a [bes a] a4. \resp g8 g ([f]) e f [e] d4.
       \bar "|."
     }
   }
   \new Lyrics \lyricsto "soprano" 
   {
     %\set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Dimanche "}
     Jé -- ru -- sa -- lem_! Jé -- ru -- sa -- lem_! "Quitte ta ro" -- be de tris -- tes -- se,
     et re -- vêts la beau -- té de la Gloi -- re de Dieu_!
     Mets sur ta tê -- te "le diadème de" Gloi -- re de l’É -- ter -- nel_:
     "Car Dieu veut montrer ta splen" -- deur par -- tout sous le ciel_:
     Lè -- ve_- toi, ô Si -- on, tiens_- toi sur la hau -- teur_!
     Vois tes en -- fants du le -- vant au cou -- chant ras -- sem -- blés_:
     Ils ju -- bi -- lent de joie, car Dieu s’est sou -- ve -- nu_!
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \voiceOne \relative c'
     { \clef "treble" \key d \minor \time 3/4 \cadenzaOn \tempo "Lundi"
       f8 [g] a [a] a [bes] a4.\div a\breve*1/8 g8 [bes] a [g] f4.\bar"|"
       a8 [bes] c\breve*1/8 c4-- c4.\resp c8 c [d c] c [bes a] a4. \div
       f8 g [a] a4.\resp g8 bes [a] a ([g] f4.)\div a\breve*1/8 a4.%\resp
       a8 a [g] c ([bes]) a4.\div f8 g [a] a [a bes] a4. g8 ([f]) e f ([e]) d4.
       \bar "|."
     }
   }
   \new Lyrics \lyricsto "soprano" 
   {
     %\set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Lundi "}
     Ne t’ir -- ri -- te pas, Sei -- gneur, "ne garde pas le souve" -- nir de nos pé -- chés_!
     Voi -- ci "la Cité" sain -- te, Si -- on a é -- té dé -- vas -- tée_:
     Jé -- ru -- sa -- lem, Jé -- ru -- sa -- lem, "le séjour de ta Sainte" -- té et de ta Gloi -- re,
     là où nos Pères ont chan -- té tes lou -- an -- ges.
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \voiceOne \relative c'
     { \clef "treble" \key d \minor \time 3/4 \cadenzaOn \tempo "Mardi"
       f8 [g] a [a] a4.\resp a\breve*1/8 g8 [a bes] a4.\div
       a8 g [f e] d4. a'8 [a g] bes [a] a ([g]) f4.\div
       a8 bes [c] c4. c8 c [d c] c [bes a] a4.\bar"|"
       f8 [g] a [a] a4. f8 [g] f4. e\div
       f8 g [a] a [bes] a4. a8 a ([g]) f [e] f [e] d4.
       \bar "|."
     }
   }
   \new Lyrics \lyricsto "soprano" 
   {
     %\set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Mardi "}
     Nous a -- vons pé -- ché, "et nous sommes devenus sem" -- blables aux paï -- ens,
     nous som -- mes tom -- bés com -- me des feuil -- les mor -- tes,
     et nos pé -- chés nous ont em -- por -- té loin de toi.
     Tu nous as ca -- ché ton vi -- sa -- ge
     et tu nous as bri -- sés à cau -- se de nos pé -- chés.
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \voiceOne \relative c'
     { \clef "treble" \key d \minor \time 3/4 \cadenzaOn \tempo "Mercredi"
       f8 g ([a]) a [a] a4.\resp a\breve*1/8 g8 c ([bes]) a4.\div
       a8 [d] c4-- bes8 a [a] g [f] f4.\bar"|"
       a8 bes [c] c [c c] c ([d]) c c ([bes]) a a4.\div
       a\breve*1/8 a4.\resp a\breve*1/8  g8 ([bes]) a a [g] f4.\div 
       f8 {g] a [a] a ([bes]) a4.\resp g8 f [e] f [e] d4.
           \bar "|."
       }
     }
   }
   \new Lyrics \lyricsto "soprano" 
   {
     %\set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Mercredi "}
     Re -- gar -- de, Sei -- gneur, "l’abattement de" ton peu -- ple,
     et en -- voie Ce -- lui qui doit ve -- nir_!
     En -- voie l’A -- gneau sou -- ve -- rain de l’U -- ni -- vers,
     "du rocher du dé" -- sert "jusqu’à la montagne de la" Fil -- le de Si -- on
     et qu’il nous dé -- li -- vre du joug de nos pé -- chés_!
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \voiceOne \relative c'
     { \clef "treble" \key d \minor \time 3/4 \cadenzaOn \tempo "Jeudi"
       f4-- g8 [a] a ([g]) a [bes] a4.\resp a\breve*1/8 g8 bes [a] a ([g]) f4.\div
       a8 bes [c] c [c] c4.\resp d8 [c] c ([bes]) a a4.\div
       f8 g ([a]) a a4.\resp g8 ([bes]) a a ([g]) f4.\bar"|"
       f8 g a\breve*1/8 4.\resp a\breve*1/8  a4-- a--\resp a8 [a] a [g] c [bes] a4.\div
       f8 [g] a\breve*1/8 a4-- a--\resp a\breve*1/8  g8 [a bes] a4.\resp
       a\breve*1/8  a4-- a8 a [a] g [g] f [e ] f ([e]) d4.
       \bar "|."
     }
   }
   \new Lyrics \lyricsto "soprano" 
   {
     %\set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Jeudi "}
     Moi, ton Sei -- gneur Sa -- ba -- oth, "je t’ai appelé" dans la jus -- ti -- ce,
     je t’ai pris par la main et je t’ai for -- mé,
     Jé -- ru -- sa -- lem, ô mon Peu -- ple_!
     De toi "naîtra le Sau" -- veur,
     "Alliance du" Peu -- ple et Lu -- miè -- re des na -- tions,
     pour ou -- "vrir les yeux des a"  -- veu -- gles,
     "pour faire sortir de pri" -- son les cap -- tifs
     "et du ca" -- chot ceux qui ha -- bi -- tent les té -- nè -- bres.
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \voiceOne \relative c'
     { \clef "treble" \key d \minor \time 3/4 \cadenzaOn \tempo \markup {\large "Vendredi"}
       f8 [g a] a [a] a4.\resp a\breve*1/8 g8 c [bes] a4.\div
       a8 a ([d]) c c ([bes]) a a ([g]) f f4.\resp
       a8 bes c\breve*1/8 c8 ([d]) c c ([bes] a4.)\bar"|"
       a\breve*1/8 a4-- a--\resp a\breve*1/8  g8 [bes] a [g] f4.\div
       f8 g ([a]) a [bes] a4.\resp a\breve*1/8  bes8 a4.\resp g8 f [e] f ([e]) d4.
       \bar "|."
     }
   }
   \new Lyrics \lyricsto "soprano" 
   {
     %\set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Vendredi "}
     Mon -- te sur la hau -- teur, "joyeuse messagè" -- re de Si -- on_!
     É -- lè -- ve for -- te -- ment la voix, joy -- eu -- "se messagère de Jé" -- ru -- sa -- lem_!
     "Élève la voix sans" crain -- te, "et va dire aux" vil -- les de Ju -- da_:
     Voi -- ci vo -- tre Dieu, "voici le Seigneur" qui vient a -- vec puis -- san -- ce_!
   }
>>

<< \new Staff \with {\remove Time_signature_engraver }
   \new Voice = "soprano"
   { \voiceOne \relative c'
     { \clef "treble" \key d \minor \time 3/4 \cadenzaOn \tempo "Doxologie"
       f8 ([g]) a a4.\resp g8 c ([bes]) a a4.\div d8 [c] c ([bes]) a a4.\bar"|"
       a\breve*1/8 g8 f [bes] a4.\div a\breve*1/8  bes8 [a] a4.\resp g8 f [e] f ([e]) d4.
       \bar "|."
       \break%\tempo "ou bien"
       f8^\markup\italic"ou bien" ([g]) a g4.\resp c8 [bes] a4.\div d8 [c] c ([bes]) a a4.\bar"|"
       a\breve*1/8 g8 f [bes] a4.\div a\breve*1/8  bes8 [a] a4.\resp g8 f [e] f ([e]) d4.
       \bar "|."
     }
   }
   \new Lyrics \lyricsto "soprano" 
   {
     %\set stanza = \markup { \large\normal-text\italic\with-color #(rgb-color 0.86 0.1 0.01) "Doxologie "}
     Gloire au Père, et gloire au Fils,
     gloire au Saint_- Es -- prit, "comme il était au" com -- men -- ce -- ment,
     maintenant et tou -- jours, et dans les siè -- cles_!
     Gloire au Père, et au Fils,
     et au Saint_- Es -- prit, "comme il était au" com -- men -- ce -- ment,
     maintenant et tou -- jours, et dans les siè -- cles_!
  }
>>