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
    \override InstrumentName.X-offset = 4
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
    %\override VerticalAxisGroup.nonstaff-nonstaff-spacing.basic-distance = #60
  }
  \context {
    \Score
    \override Hairpin.to-barline = ##f
  }
}

global = {
  \key f \major
  \time 3/8
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

rall = #(make-dynamic-script (markup #:line ( #:normal-text #:italic "rall." )))
agauche = \once \override DynamicText.X-offset = #0

sopMusic = \relative c' {
  f4 g8 a4 c8 4 bes8 a g a bes4 a8 g4.\breathe
  f4 a8 c4 d8 4 c8 d e f e d c d4.\fermata\breathe
  d4 e8 c4. bes4 c8 a4. g8 f g g4 (a8) a4.\bar"||"
  f4^\markup\italic"a tempo" g8 a4 c8 4 bes8 a g a bes4 (a8) g4.\breathe
  f4 g8 a4 c8 4 bes8 a g a bes4 (a8) g4.\fermata  
  \bar "|."
}
altoMusic = \relative c' {
  c4 8 f4 a8 g4 8 f f f f4 8 e4.
  c4 f8 g4 a8 4 8 f f f g g a a4.
  f8 <g \balloonText #'(1 . -2)\markup { "" } >4 a4. 8 <g \balloonText #'(1 . -2)\markup { "" } >4 g (f8) d d d d4 (e8) e4.
  c4 8 f4 a8 g4 8 f f f f4. e4.
  c4 8 f4 a8 g4 8 f f f f4. e4.  
}
tenorMusic = \relative c' {
  a4 bes8 c4 8 4 8 8 bes c d4 c8 4.
  a4 c8 4 f8 e4 8 d d d e e e f4.
  d4 8 e4. d4 e8 c4. bes8 a bes8 4 (c8) 4.
  a4 bes8 c4 8 4 8 8 bes c d4 (c8) 4.
  a4 bes8 c4 8 4 8 8 bes c d4 (c8) 4.
}
bassMusic = \relative c { 
  f4 8 4 8 e4 8 f f f bes,4 f'8 c4.\breathe
  f4 8 e4 d8 a'4 8 bes a g c c a d,4.\fermata\breathe
  bes'4 8 a4. d,4 c8 f4. 8 8 8 4 (<c e>8) <a e'>4.
  f'4 8 4 8 e4 8 f f f bes,4 (f'8) c4.
  f4 8 4 8 e4 8 f f f bes,4 (f'8) c4.\fermata
}

ref = \lyricmode {  
  \repeat unfold 36 \skip4
  %\set shortVocalName = \markup\right-align" 1-4." \set stanza = #"1-4."
  Gloire à Dieu et paix sur terre, Al -- lé -- lu -- ia_!
  \override Lyrics.LyricText.font-series = #'bold
  Gloire à Dieu et paix sur terre, Al -- lé -- lu -- ia_!

}
altoWordsun = \lyricmode {  
  \set shortVocalName = \markup\right-align"1." \set stanza = #"1."
  Au -- jour -- \apostrophe d'hui, dans no -- tre mon -- de, le Verbe est né
  Pour par -- ler du Père aux hom -- mes qu'il a tant ai -- més.
  Et le ciel nous ap -- prend le grand mys -- tè -- re_:
}
altoWordsdeux = \lyricmode {  
  \set shortVocalName = \markup\right-align"2." \set stanza = #"2." 
  Au -- jour -- \apostrophe d'hui, dans nos té -- nè -- bres, le Christ a lui
  Pour ou -- vrir les yeux des hom -- mes qui vont dans la nuit.
  L'u -- ni -- vers est bai -- gné de sa lu -- miè -- re_:
}
altoWordstrois = \lyricmode {  
  \set shortVocalName = \markup\right-align"3." \set stanza = #"3."
  Au -- jour --\apostrophe  d'hui dans no -- tre mort a pa -- ru la vie,
  Pour chan -- ger le cœur des hom -- mes qui sont en -- dur -- cis,
  Et l'a -- mour est plus fort que nos mi -- sè -- res.
}
altoWordsquatre = \lyricmode {  
  \set shortVocalName = \markup\right-align"4." \set stanza = #"4."
  Au -- jour -- \apostrophe d'hui, dans no -- tre chair est en -- tré Jé -- sus
  Pour u -- nir en lui les hom -- mes qui l'ont at -- ten -- du.
  Et Ma -- rie, à ge -- noux, l'offre à son Pè -- re.

}
altoWordscinq = \lyricmode {  
  \set shortVocalName = \markup\right-align"5." \set stanza = #"5."
  
}
altoWordssix = \lyricmode {  
  \set shortVocalName = \markup\right-align"6." \set stanza = #"6."
  
}

\new ChoirStaff 
<<
  \new Dynamics 
  {
    f4 g8 a4 c8 4 bes8 a g a bes4 a8 g4.
    f4 a8 c4 d8 4 c8 d e f e\rall\> d c d4.\!
    \agauche d4#(make-dynamic-script (markup #:line ( #:dynamic "ppp" #:normal-text #:italic "rall." ))) e8 c4. bes4 c8 a4. g8\rall\> f g g4 (a8) a4.\!
    f4 g8 a4 c8 4 bes8 a g a bes4 (a8) g4.
    f4 g8 a4 c8 4 bes8 a g a bes4 (a8) g4.  
  }
  \new Staff = "women" \with { \consists "Merge_rests_engraver" }
  <<
    \new Voice = "sopranos" {
      \voiceOne
      << \global \sopMusic >>
    }
    \new Voice = "altos" \with { \consists "Balloon_engraver"
                                 \override BalloonText.annotation-balloon = ##f }
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  %\with {\override VerticalAxisGroup.nonstaff-relatedstaff-spacing.minimum-distance = #20 }
  %\with {\override VerticalAxisGroup.staff-affinity = ##f }
  %\with {\override StaffGrouper.staff-staff-spacing.padding = 0 }
  \with {\override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = 0 }
  \lyricsto "sopranos" \ref
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordsun
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordsquatre

  
  \new Staff = "men" \with { \consists "Merge_rests_engraver" }
  <<
    \clef bass
    \new Voice = "ténors" \with { \consists "Balloon_engraver" } {
      \voiceOne
      << \global  \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo 
      << \global  \bassMusic >>
    }
  >>
>>