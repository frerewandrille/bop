\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5")
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = "Ne pas emporter ni plier svp"
% }
% 
% #(set-global-staff-size 13)
% 
% \header {
%   title = \markup \center-column { "Ô très doux Créateur" }
%   subtitle = " "
%   poet = ""
%   composer =  ""
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
    \override InstrumentName.X-offset = 2.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
  } 
}

global = {
  \key bes \major
  \time 4/4
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

sopMusic = \relative c'' { \slurDashed
  g4-> bes a-> c bes-> g a-> c bes2\resp
  bes4-> g a-> bes a-> bes g-> a g2\fermata\bar"|"
  g4-> bes a-> c d-> (c) a-> c bes2\resp
  bes4-> g a-> bes a-> (bes) g-> f g2
  \bar "|." \slurSolid
  g2 (a4 g) f2 (g1\fermata)
  \bar "|."
}
tenorMusic = \relative c' {
  d2 c d e d d c d c d d c bes c d d c d ees d d (c) a4 (c d1)
}
bassMusic = \relative c' { 
  g\breve 2 \resp 2 f g f g\fermata
  g\breve 2\resp g f g a g\fermata
  g (f) d (g1\fermata)
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  \set ignoreMelismata = ##t 
  Ton Corps est bri -- sé par nos pé -- chés.
  La soif a brû -- lé ton cœur de chair.
  Ain -- si l’É -- cri -- ture est ac -- com -- plie_:
  “Ils ont par -- ta -- gé mon vê -- te -- ment.”
}
altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  À l’heure où la Pâque est cé -- lé -- brée,
  les sol -- dats s’a -- van -- cent vers ta croix_:
  Du cô -- té qu’ils ont __ trans -- per -- cé,
  ils voient naître un peu -- __ ple nou -- veau.
}
altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  \set ignoreMelismata = ##t 
  Peu -- ple qui te chante, A -- gneau de Dieu_:
  “Par ta mort, tu as vain -- cu la mort_!”
  L’eau jail -- lit du Tem -- ple de ton Corps,
  et l’Es -- prit té -- moigne a -- vec le Sang.
}
altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  \set ignoreMelismata = ##t 
  Christ, Pierre an -- gu -- laire où s’é -- di -- fie
  le Tem -- ple nou -- veau de la vraie Vie,
  lors -- que se re -- lè -- ve du tom -- beau
  tout ce peu -- ple que tu as ac -- quis.
}
altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  \set ignoreMelismata = ##t 
  En ce jour, ras -- sem -- ble tes en -- fants
  pour les ré -- jou -- ir en ton Sa -- lut_;
  tu nous re -- nou -- vel -- les par ton Sang
  lors -- que tu nous don -- nes ton Es -- prit.
}
altoWordssix = \lyricmode {  
  \set shortVocalName = "6." \set stanza = #"6. "
  \set ignoreMelismata = ##t 
  Christ, lou -- ange à toi, Res -- sus -- ci -- té_!
  Gloire au Pè -- re qui t’a en -- vo -- yé_!
  Com -- ble tes dis -- ci -- ples de l’Es -- prit
  pour qu’ils chantent aux hom -- mes ton Sa -- lut_!
  \unset ignoreMelismata A -- men_!
}

\new ChoirStaff 
<<
  \new Staff = "women" \with {\remove Time_signature_engraver }
  \with { \consists "Merge_rests_engraver" }
  \new Voice = "sopranos" {
    \voiceOne 
    << \global \cadenzaOn \sopMusic >>
  }
  
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordscinq
  \lyricsto "sopranos" \altoWordssix
  
  \new Staff = "men" \with {\remove Time_signature_engraver }
  \with { \consists "Merge_rests_engraver" }
  <<
    \clef bass
    \new Voice = "ténors" \with { \consists "Balloon_engraver" } {
      \voiceOne
      << \global \cadenzaOn \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo 
      << \global \cadenzaOn \bassMusic >>
    }
  >>
>>