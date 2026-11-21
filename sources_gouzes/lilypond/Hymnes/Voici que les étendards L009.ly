\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 20
%   right-margin = 20
% }
% 
%  #(set-global-staff-size 18)
% 
% \layout { 
%   tagline = ##f
%   indent = #0
%   ragged-last = ##t
%   \context { \Score \remove "Bar_number_engraver"
%   }
%   \context { \Lyrics \override LyricText.font-size = #2.5
%                      \override LyricSpace.minimum-distance = #1
%   }
% }
% 
% \header {
%   title = \markup \center-column { "Voici que les étendards" }
%   subtitle = " "
%   poet = ""
%   composer = ""
%   tagline = ##f
% }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = {
  \key d \minor
  \time 2/4
}

resp = { \breathe\allowBreak }
im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

sopMusic = \relative c' {
  \partial8 f8 g4 (a8) bes a g f g g a g f e4 d~ d8\resp
  g8 g a f4 d8 f e (f) d (c) c4 d~d8\resp
  d8 d f d4 ( c8) f f (g) a g g4 f~ \once \tieDashed f8~ \resp f
  f8 a bes a g a f4 d8 f e (f) d c c4 d~ \noBreak d2
  \bar "|."
  d4 (e8 [d]) c4\fermata (d)\fermata\bar "|."
}

altoMusic = \relative c' { 
  \partial8 d\breve*1/16\laissezVibrer \repeat unfold 7 { s2 }
   a4^> (d~) d8
  d\breve*2/16\laissezVibrer s8 \repeat unfold 7 { s2 } | a4^> (d~) d2
  \repeat tremolo 8 d16 (a4\mordent) (d\mordent)
}

timbalesMusic = \relative c' { 
  \tiny \partial8 s8 \acciaccatura a-\markup\italic"timb." d4 s4
  \repeat unfold 17 { \acciaccatura a8 d4 s } 
  %\repeat tremolo 4 d16 s4 
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. " \set shortVocalName = "1."
  \im Voi -- ci que les é -- ten -- dards de no -- tre Roi s’a -- van -- cent. \skip4
  Sur nous, la croix res -- plen -- dit dans son mys -- tè -- re,\skip4
  où, dans sa \imstop chair, __ \im le Cré -- a -- teur du mon -- de\skip4\skip4
  fut pen -- du comme un bri -- gand au gi --  \imstop bet __ \im des es -- cla -- ves.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "  \set shortVocalName = "2."
  \im Les  \imstop mains __ per -- \im cées de clous, les pieds et les en -- trail -- les,\skip4
  c’est là qu’il vient s’im -- mo -- ler pour tous les hom -- mes.\skip4
  Bles -- sé aus -- si par la poin -- te d’u -- ne lan -- ce,\skip4\skip4
  il ré -- pand l’eau et le sang pour la --  \imstop ver __ \im nos of -- fen -- ses.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. " \set shortVocalName = "3."
  \im A -- lors les chants de Da -- vid pour lui se ré -- vé -- lè -- rent.\skip4
  A -- lors les psau -- mes vrai --  \imstop ment __ \im s’ac -- com -- pli -- rent\skip4
  quand le pro -- phète an -- non -- çait à tous les peu -- ples_:\skip4\skip4
  Il a ré -- gné par le bois, le Sau --  \imstop veur, __ \im no -- tre Maî -- tre.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. " \set shortVocalName = "4."
  \im Bel ar -- bre res -- plen -- dis -- sant, é -- cla -- tant de lu -- miè -- re,\skip4
  tu es pa -- ré de la  \imstop pour __ -- \im pre ro -- ya -- le.\skip4
  Tu fus é -- lu com -- me l’ar -- bre le plus di -- gne\skip4\skip4
  de por -- ter ce corps très saint, de tou --  \imstop cher __ \im à ses mem -- bres.
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5. " \set shortVocalName = "5."
  \im Heu -- \imstop reu __ -- \im se Croix où pè -- se la ran -- çon du mon -- de,\skip4
  par qui l’en -- fer a trem -- blé en  son em -- pi -- re,\skip4
  heu -- reuse es_- tu de por -- ter ce fruit de vi -- e,\skip4\skip4
  et les peu -- ples ras -- sem -- blés ap -- plau -- dis -- sent ton tri -- om -- phe.
}

altoWordssix= \lyricmode { 
  \set stanza = #"6. " \set shortVocalName = "6."
  \im Sa -- lut, sain -- te Croix, sa -- lut, notre u -- nique es -- pé -- ran -- ce,\skip4
  sa -- lut, au -- tel qui pro -- tas l’A -- gneau sans ta -- che.\skip4
  De par la grâ -- ce de sa pas -- sion très sain -- te,\skip4
  la vie a en -- du -- ré la mort, et la mort  ren -- du la vi -- e.
}

altoWordssept = \lyricmode { 
  \set stanza = #"7. " \set shortVocalName = "7."
  \im Ô Dieu sou -- ve -- rain et bon, Tri -- ni -- té bien -- heu -- reu -- se,\skip4
  nous t’a -- do -- rons, nous te  \imstop ren __ --  dons __ \im grâ -- ce.\skip4
  Rè -- gne sur nous à tra -- \imstop vers __ \im tous les siè -- cles,\skip4\skip4
  nous que tu as re -- le -- vés par ta  \imstop Croix __ \im glo -- ri -- eu -- se.\skip4
  \imstop A -- men_!
}

\new ChoirStaff <<
  \new Staff = "women"%\with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne \slurDashed
      << \global \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo
      << \global \altoMusic >>
    }
    \new Voice = "timbales" {
      \voiceFour
      << \global \timbalesMusic >>
    }
  >> 
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4.5 }
  \lyricsto "sopranos" \altoWordstrois
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4.5 }
  \lyricsto "sopranos" \altoWordssix
  \new Lyrics \lyricsto "sopranos" \altoWordssept
>>