\version "2.24.0"
\include "vowel-set.ly"
%\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }
% 
% \paper {
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 20
%   right-margin = 20
% }
% 
% #(set-global-staff-size 18)
% 
% 
% \header {
%   title = \markup \center-column { "Christ serviteur K 009" }
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

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key g \minor
  \time 3/2
}

resp = { \breathe\allowBreak }

sopMusic = \relative c' {
  s8 d f [g] g [bes] g [f] g4.*2/3 s8
  f8 a [g] bes [a] g [f] g4.*2/3
  s8 f g [a] a [f] g [f] ees4 d4.*2/3 s8
  d8 f [g] g [bes] g [f] g2\bar "|."
  g4 (a8 [g]) f4 (g)\bar "|."
}

altoMusic = \relative c'' { \tiny
                            g4^\markup\italic"b.f." f g f ees\resp 
                            d c d ees d \bar"|"
                            ees4*1/2 s d4 c d ees f \resp
                            g f ees d8 [ees] d2
                            d4 (c8 [d]) ees4 (d)
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. " \set shortVocalName = "1."
  Christ, ser -- vi -- teur du Dieu vi -- vant,
  sur toi re -- po -- se son a -- mour_:
  Viens ras -- sem -- bler en un seul peu -- ple
  les en -- fants de Dieu dis -- per -- sés_!
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "  \set shortVocalName = "2."
  Christ ser -- vi -- teur, é -- lu de Dieu,
  por -- tant le poids de nos pé -- chés,
  tu prends sur toi no -- tre souf -- fran -- ce
  pour nous ar -- ra -- cher à la mort.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. " \set shortVocalName = "3."
  Christ ser -- vi -- teur, tu viens cher -- cher
  la bre -- bis qui s’est é -- ga -- rée.
  Fais res -- plen -- dir sur nous ta gloi -- re_:
  Que nous vi -- vions res -- sus -- ci -- tés_!
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. " \set shortVocalName = "4."
  Christ ser -- vi -- teur, fils de Da -- vid,
  tu mon -- tes vers Jé -- ru -- sa -- lem.
  Tu es li -- vré aux mains des hom -- mes
  pour le bap -- ti -- ser dans ta mort_!
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5. " \set shortVocalName = "5."
  Christ ser -- vi -- teur, né dans la chair,
  com -- me le blé se -- mé en terre,
  comme un ra -- meau en terre a -- ri -- de,
  tu fais ger -- mer un fruit de vie_!
}

altoWordssix= \lyricmode { 
  \set stanza = #"6. " \set shortVocalName = "6."
  Christ ser -- vi -- teur, Ver -- be de Dieu,
  comme un a -- gneau qu’on met à mort,
  tu n’as pas même ou -- vert la bou -- che
  de -- vant ceux qui te con -- dam -- naient.
}

altoWordssept = \lyricmode { 
  \set stanza = #"7. " \set shortVocalName = "7."
  Christ ser -- vi -- teur, tu as per -- du
  l’é -- clat brû -- lant de ta beau -- té_!
  Toi qui n’as plus vi -- sa -- ge d’hom -- me,
  viens re -- cré -- er nos cœurs bri -- sés.
}

altoWordshuit = \lyricmode { 
  \set stanza = #"8. " \set shortVocalName = "8."
  Christ ser -- vi -- teur, Mes -- sie souf -- frant,
  frap -- pé à mort pour nos pé -- chés,
  tu nous gué -- ris par tes bles -- su -- res.
  Ton châ -- ti -- ment nous rend la paix_!
}

altoWordsneuf = \lyricmode { 
  \set stanza = #"9. " \set shortVocalName = "9."
  Christ ser -- vi -- teur, lou -- ange à toi,
  au Pè -- re qui t’a en -- vo -- yé,
  à l’Es -- prit Saint qui nous en -- traî -- ne
  dans u -- ne Pâ -- que de sa -- lut_! A -- men_!
}

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
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
  \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
  \lyricsto "sopranos" \altoWordssix
  \new Lyrics \lyricsto "sopranos" \altoWordssept
  \new Lyrics \lyricsto "sopranos" \altoWordshuit
  \new Lyrics \lyricsto "sopranos" \altoWordsneuf
>>