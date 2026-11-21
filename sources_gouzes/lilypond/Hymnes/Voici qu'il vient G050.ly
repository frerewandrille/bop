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
%   title = \markup \center-column { "Voici qu’il vient" }
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

%\layout { ragged-last = ##t indent = #0 }

global = {
  \key bes \major
  \time 4/4
}

resp = { \breathe\allowBreak }

sopMusic = \relative c'' {
  g8 g [g] f [g] bes [a] g4.\resp bes8 c [c] c [bes] c [c] d4.\bar"|"
  d8 d [c] d [bes] c [bes] g4.\resp g8 f [g] bes [c] g [f] g4.  \bar "|." 
  g8 ([a g ]) f4 (g)  \bar "|." 
}
altoMusic = \relative c' {
  d8 d [d] e [d] c [c] d4. f8 f [f] f [f] f [f] bes4.
  bes8 bes [f] g [g] ees [ees] d4. d8 d [c] d [f] d [e] d4.
  d8 ([c d]) e!4 (d)
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  Voi -- ci qu’il vient par -- mi les siens,
  et qu’il de -- meu -- re dans nos cœurs_!
  Lu -- mière et vie dans no -- tre chair_:
  Voi -- ci le Verbe, al -- lé -- lu -- ia_!
}
altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Voi -- ci qu’il vient dans no -- tre nuit,
  et sa ve -- nue est no -- tre joie_!
  Gar -- dons nos lam -- pes al -- lu -- mées_:
  Voi -- ci l’É -- poux, al -- lé -- lu -- ia_!
}
altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Voi -- ci qu’il vient comme un vo -- leur,
  voi -- ci qu’il frappe_: en -- tends sa voix_!
  Il vient chez toi pour le re -- pas_:
  Voi -- ci le Maître, al -- lé -- lu -- ia_!
}
altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Voi -- ci qu’il vient pour nous sau -- ver,
  et no -- tre monde est re -- cré -- é_!
  En lui, les temps sont ac -- com -- plis_:
  Voi -- ci le Christ, al -- lé -- lu -- ia_!
}
altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  Voi -- ci qu’il vient sur les nu -- ées,
  et tou -- te chose est trans -- for -- mée.
  Il est l’al -- pha et l’o -- me -- ga,
  Maî -- tre du monde, al -- lé -- lu -- ia_!
}
altoWordssix = \lyricmode {  
  \set shortVocalName = "6." \set stanza = #"6. "
  Lou -- ange et gloire au Dieu très saint,
  au Pè -- re qui nous a cré -- és,
  par Jé -- sus Christ «_Ce -- lui qui vient_»,
  dans l’Es -- prit Saint qui nous u -- nit_!
  A -- men_!
}

\new ChoirStaff 
<<
  \new Staff = "women" \with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne
      << \global \cadenzaOn \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo
      << \global \cadenzaOn \altoMusic >>
    }
  >>
  
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordssix
>>