\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" 'landscape)
%   system-system-spacing.basic-distance = #56
%   top-margin = 5
%   bottom-margin = 10
%   left-margin = 15
%   right-margin = 15
%   tagline = ##f
% }
% 
% #(set-global-staff-size 12)
% 
% \header {
%   title = \markup \center-column { "Éveille-toi" }
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
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key f \major
  \time 2/2
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

sopMusic = \relative c' {
  \slurDashed \tieDashed
  d2 a'4 d, a'2 a a bes4 (a) a2 g \breathe f e4 d a'2 g e e4 (f) d2~ d
  \bar ":|.:" \break 
  d2 d4 d d'2 c bes a4 (g) a2 g \breathe f e4 d a'2 g e e4 (f) d2~ d
  \bar ":|."
}

altoMusic = \relative c' {
  \slurDashed \tieDashed
  d2 d4 a' d,2 c bes a4 (bes) c2 c d c4 bes a2 bes c c4 (a) d2~ d
  d2 c4 c bes2 a g a4 (bes) c2 c d c4 bes a2 bes c c4 (a) d2~ d
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  \im É -- veil -- le_- toi, A -- dam, no -- tre Pè -- re,
  Re -- lè -- ve_- toi d’en -- tre les __ \skip4 morts.\skip4 
  Voi -- ci Ma -- rie, la nou -- velle __  \skip4 È -- ve
  qui don -- ne chair au nou -- vel A -- dam.
}

altoWordsunb = \lyricmode {  
  %\set shortVocalName = "1." \set stanza = #"1. "
  \im Dans son a -- mour, Dieu sau -- ve les hom -- mes,
  as -- sis dans l’om -- bre de la  __ \skip4 mort.\skip4 
  La cré -- a -- tion se re -- nou __  -- \skip4 vel -- le
  par la Pa -- ro -- le du Sei __  -- \skip4 gneur.
}

altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  \im Père A -- bra -- ham, voi -- ci la pro -- mes -- se
  qui s’ac -- com -- plit dans ta des -- cen -- dan -- ce_:
  Nou -- vel I -- saac et vraie vic __  -- \skip4 ti -- me,
  -_car  c’est de lui qu’il est é __  -- \skip4 crit_-,
}

altoWordsdeuxb = \lyricmode {  
  %\set shortVocalName = "2." \set stanza = #"2. " 
  \im Dieu a li -- vré son Fils, son U -- ni -- que,
  pour nous ai -- mer jus -- \apostrophe qu’à la  __ \skip4 fin.\skip4 
  por -- tant le bois du sa -- cri __  -- \skip4 fi -- ce,
  il dit pour nous_: Voi -- ci, je __  \skip4 viens_!
}

altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  \im Buis -- son ar -- dent que vit Mo __ -- \skip4 ï -- se,
  che -- min de vie et Pâque é -- ter -- nel -- le,
  Flam -- me de feu au cœur de son peu -- ple
  pour qu’il con -- tem -- ple son vi __  -- \skip4 sa -- ge,
}

altoWordstroisb = \lyricmode {  
  %\set shortVocalName = "3." \set stanza = #"3. "
  \im "“Ce" -- lui qui "est”" prend chair de la Vier -- ge
  pour nous con -- duire en ter -- re pro -- mi -- se.
  c’est par -- mi nous qu’il fait sa de -- meu -- re
  pour que sa gloire en nous res -- plen -- dis -- se.
}

altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  \im Ô roi Da -- vid, ras -- sem -- ble ton peu -- ple
  et que ton chant é -- veil -- le l’au -- ro -- re.
  Ton Dieu bâ -- tit en toi sa de -- meu -- re_:
  C’est le Mes -- sie qu’il t’a pro __  -- \skip4 mis.
}

altoWordsquatreb = \lyricmode {  
  %\set shortVocalName = "4." \set stanza = #"4. "
  \im Tu as re -- çu l’onc -- tion d’al -- lé -- gres -- se,
  ton cœur fré -- mit d’un chant d’a  __ -- \skip4 mour.\skip4 
  Il rè -- gne -- ra, ber -- ger de son peu -- ple,
  Em -- ma -- nu -- el, Dieu a -- vec __  \skip4 nous_!
}

altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  \im Dieu vient chez nous scel -- ler son al -- lian -- ce_!
  Les cieux ré -- pan -- dent leur ro __  -- \skip4 sée.\skip4 
  La Vierge en -- fante, elle est en __  -- \skip4 cein -- te,
  si -- gne don -- né par Dieu à son peu -- ple.
}

altoWordscinqb = \lyricmode {  
  %\set stanza = #"5. "\set shortVocalName = "5."
  \im La ter -- re s’ouvre et dé -- jà se lè -- ve
  le grain se -- mé pour no -- tre __  \skip4 vie.\skip4 
  L’Es -- prit la cou -- vre de son __  \skip4 om -- bre
  pour qu’elle en -- fan -- te son cré -- a -- teur.
}

altoWordssix = \lyricmode {  
  \set stanza = #"6. "\set shortVocalName = "6."
  \im Jé -- ru -- sa -- lem, É -- gli -- se __ \skip4 sain -- te,
  chan -- te la gloi -- re de ton Sei -- gneur_!\skip4 
  chan -- te le Fils qui vient sur __  \skip4 ter -- re
  pour ras -- sem -- bler tous tes en __  -- \skip4 fants,
}

altoWordssixb = \lyricmode {  
  %\set stanza = #"6. "\set shortVocalName = "6."
  \im Chan -- te le Père en sa ten  __ -- \skip4 dres -- se
  qui nous in -- vite à son Roy __  -- \skip4 au -- me,
  chan -- te l’Es -- prit de vie, de lu -- miè -- re,
  par qui Ma -- rie est Mè -- re de Dieu_!
}

\new ChoirStaff <<
  \new Staff = "women"    
  \with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne \tempo 2 = 80
      << \global \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo
      << \global \altoMusic >>
    }
  >> 
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.basic-distance = #5 }
  \lyricsto "sopranos" \altoWordsunb
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.basic-distance = #5 }
  \lyricsto "sopranos" \altoWordsdeuxb
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.basic-distance = #5 }
  \lyricsto "sopranos" \altoWordstroisb
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.basic-distance = #5 }
  \lyricsto "sopranos" \altoWordsquatreb
  \new Lyrics \lyricsto "altos" \altoWordscinq
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.basic-distance = #5 }
  \lyricsto "altos" \altoWordscinqb
  \new Lyrics \lyricsto "altos" \altoWordssix
  \new Lyrics \lyricsto "altos" \altoWordssixb
>>