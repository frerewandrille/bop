\version "2.24.1"

\include "vowel-set.ly"

% \header {
%   title = "Sans fin Seigneur"
%   subtitle = "HO60"
%   composer = "Lucien Deiss"
%   poet = "CFC"
%   % Supprimer le pied de page par défaut
%   tagline = ##f
% }
% 
% \paper {
%   #(set-paper-size "a5")
%   indent = 0
% }

\layout {
  \context {
    \Score
    \remove "Bar_number_engraver"
  }
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

resp = { \breathe\allowBreak }

global = { \cadenzaOn }

soprano = \relative c'' {
  \global
  g8 b [a] c [c] c [b] a4 a8 \resp a8 a [c] c [g] a [g] f2\bar"|"
  a8 a [g] c [b] a [g] a ([b]) a4\resp a8 a [g] f [g] a [g] g2\bar"|."
}

verseOne = \lyricmode {
  \set stanza = "1."\set shortVocalName = \markup\right-align"1." 
  Sans fin Sei -- gneur, Dieu no -- tre Pè -- re,
  Sans fin Sei -- gneur nous te loue -- rons.
  La terre e -- xul -- te d’al -- lé -- gres -- se_!
  Bé -- ni sois -- tu  Dieu des vi -- vants.
}

verseTwo = \lyricmode {
  \set stanza = "2."\set shortVocalName = \markup\right-align"2." 
  Sans fin, ton Verbe en nos pa -- ro -- les,
  Sans fin, Sei -- gneur, te chan -- te -- ra_;
  L’a -- mour s’é -- veille en nos cœurs d’hom -- mes
  Au nom du Fils, ton Bien_- ai -- mé.
}

verseThree = \lyricmode {
  \set stanza = "3."\set shortVocalName = \markup\right-align"3." 
  L’oi -- seau re -- çoit sa nour -- ri -- tu -- re,
  La fleur se pa -- re de beau -- té_;
  Tu ai -- mes tou -- te cré -- a -- tu -- re,
  Tu sais le prix de nos an -- nées.
}

verseFour = \lyricmode {
  \set stanza = "4."\set shortVocalName = \markup\right-align"4." 
  Tu es, Sei -- gneur, no -- tre lu -- miè -- re,
  Toi seul nous sau -- ves de la mort_;
  Ton Fils of -- fert à tous les peu -- ples
  Est pour cha -- cun le Pain vi -- vant.
}

verseFive = \lyricmode {
  \set stanza = "5."\set shortVocalName = \markup\right-align"5." 
  Heu -- reux les hom -- mes qui t’a -- do -- rent,
  Le monde ou -- vert à ton a -- mour_;
  L’Es -- prit dé -- jà te nom -- me Pè -- re_:
  Un jour, Sei -- gneur, nous te ver -- rons.
}

\score {
  \new ChoirStaff <<
    \new Staff \with { \remove Time_signature_engraver }
    \new Voice = "soprano" { \soprano }
    \new Lyrics \lyricsto "soprano" \verseOne
    \new Lyrics \lyricsto "soprano" \verseTwo
    \new Lyrics \lyricsto "soprano" \verseThree
    \new Lyrics \lyricsto "soprano" \verseFour
    \new Lyrics \lyricsto "soprano" \verseFive
  >>

}
