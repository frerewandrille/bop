\version "2.24.0"
% 
% \paper {
%   #(set-paper-size "a5" ’landscape)
%   top-margin = 8
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 15)
% 
% \header {
%   title = \markup \center-column { "Ô Christ, fontaine de la vie" }
%   subtitle = " "
%   poet = ""
%   composer = ""
% }
% 
% %\markup { \vspace #1 }
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
    \override InstrumentName.X-offset = 1
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

resp = { \breathe\allowBreak }

global = {
  \key f \major
  \time 3/4
}

sopMusic = \relative c' {
  f4 f g a2 bes4 a2 g4 a2.\resp a4 g c c2 g4 a bes2 a2.\bar"|"
  g4 a g a2 g4 f2 e4 f2.\resp g4 a g f2 g4 f2 e4 d2.\fermata\bar "|."
  d2 (e4 d) c2 (d1\fermata)\bar "|."
}

altoMusic = \relative c' {
  d4 d e f2 f4 f2 d8 ([e]) f2. f4 d e f2 d8 ([e]) f2 
  \override BalloonText.annotation-balloon = ##f 
  <e \balloonText #'(-1 . -2.5)\markup { "" } >4
  f2.
  e4 f e e2 e4 d2 cis4 d2. e4 f e d (c) d c2 c4 a2.
  d2 (c4 a) a1.
}

tenorMusic = \relative c' {
  a4 a c c2 d4 c2 bes4 c2. c4 bes c a2 bes4 c d2 c2.
  c4 c c a2 a4 a2 a4 a2. c4 c bes a2 bes4 a 
  \override BalloonText.annotation-balloon = ##f 
  <g \balloonText #'(1 . 2.5)\markup { "" } >2
  f2.
  bes2 (g4 f) e2 (f1)
}

bassMusic = \relative c {
  d4 d c f2 bes,4 f'2 g4 f2.\resp f4 g c, f2 g4 f bes,2 f'2.
  c4 f c cis2 cis4 d2 a4 d2.\resp c4 f g d2 g,4 a c2 d2.\fermata
  bes2 (c4 d) a2 (d1\fermata)
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "
  \set shortVocalName = "1."
  Ô Christ, fon -- tai -- ne de la vie, 
  Nous te chan -- tons, res -- sus -- ci -- té.
  De l’hom -- me, tu de -- viens l’a -- mi, 
  Et tu le sau -- ves de la mort.
}

altoWordsdeux = \lyricmode {  
  \set stanza = #"2. "\set shortVocalName = "2."
  Mal -- gré la pier -- re du tom -- beau, 
  Et les sol -- dats gar -- dant ton corps, 
  Tu res -- sus -- cites en no -- tre nuit, 
  Ren -- dant au mon -- de sa clar -- té. 
}

altoWordstrois = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3."
  Ton bras s’est re -- cou -- vert de gloire, 
  Tu as broy -- é tes en -- ne -- mis, 
  Tu ouvres au pro -- fond des en -- fers 
  La voie nou -- velle à Is -- ra -- ël.
}

altoWordsquatre = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4."
  Tes mains qui nous ont fa -- çon -- nés, 
  Tu les as é -- ten -- dues en croix, 
  Pour que nos corps pé -- tris de boue 
  De ter -- re soient res -- sus --  ci -- tés. 
}

altoWordscinq = \lyricmode {  
  \set stanza = #"5. "\set shortVocalName = "5."
  Nous t’a -- vons sou -- mis à la mort, 
  Toi qui nous as don -- né la vie, 
  Tu nous res -- sus -- cites a -- vec toi, 
  Et tu nous rends l’é -- ter -- ni -- té_! 
}

altoWordssix = \lyricmode {  
  \set stanza = #"6. " \set shortVocalName = "6."
  Gloire et lou -- ange au Dieu très saint_!
  Gloire à son Fils res -- sus -- ci -- té_!
  Gloire à l’Es -- prit qui nous u -- nit_!
  Aux trois, la même a -- do -- ra -- tion_! A -- men.
}

\score {
  \new ChoirStaff 
  <<
    \new Staff = "women" \with {\remove Time_signature_engraver }
    <<
      \new Voice = "sopranos" {
        \voiceOne \cadenzaOn
        << \global \sopMusic >>
      }
      \new Voice = "altos" \with { \consists "Balloon_engraver" }
      {
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
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordssix
    
    \new Staff = "men" \with {\remove Time_signature_engraver }
    <<
      \clef bass
      \new Voice = "tenors" \with { \consists "Balloon_engraver" }
      {
        \voiceOne \cadenzaOn
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo << \global \bassMusic >>
      }
    >>
  >>
}