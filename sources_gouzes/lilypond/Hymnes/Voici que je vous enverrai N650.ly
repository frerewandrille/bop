\version "2.24.0"
% 
% \paper {
%   #(set-paper-size "a5")
%   system-system-spacing.basic-distance = #0
%   top-margin = 10
%   bottom-margin = 10
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter svp"
%   print-page-number = ##f
% }
% 
% #(set-global-staff-size 14)
% 
% \header {
%   title = \markup \center-column { "Voici que je vous enverrai" }
%   subtitle = " "
%   poet = ""
%   composer = ""
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
% \markup{ \vspace #1 }

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 1.5
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

global = { \key f \minor \time 4/4 }

resp = { \breathe }
silN = { \oneVoice r4 \voiceOne }

sopMusic = \relative c' {
  \partial4   \bar"|:"
  f4 f4. f8 aes4 bes bes4. aes8 g4\resp f aes g f e f2.\bar":|."
  f4 g4. aes8 bes4 g aes bes c \resp d ees4. d8 c4 b c2. \bar ".|:-|"
  c4 c4. c8 c4 c bes4. aes8 g4\resp f aes g f e f2.
  \bar":|."
}

altoMusic = \relative c' {
  c4 des4. des8 f4 f g4. f8 e4 f c ees des c c2.
  c4 ees4. f8 g4 ees f g ees g g4. f8 ees4 d e2.
  f4 ees!4. aes8 g4 f f4. f8 ees4 des ees ees des c c2.
}

tenorMusic = \relative c' {
  aes4 aes4. bes8 c4 des ees4. c8 c4 aes f bes bes g aes2.
  aes4 c4. c8 ees4 bes c ees ees bes bes4. bes8 g4 g g2.
  aes4 aes4. c8 ees4 aes, des4. c8 c4 aes c bes bes g a2.
}

bassMusic = \relative c {
  f4 des4. bes8 f'4 bes, ees4. f8 c4\resp f f ees bes c f2.
  f4 c4. f8 ees4 g f ees aes\resp g ees4. bes8 c4 g' c,2.
  f4 aes4. aes,8 c4 f bes,4. f'8 c4\resp des aes ees' bes c <f, f'>2.
}

altoWordsun = \lyricmode { 
  \set stanza = #"1. "\set shortVocalName = "1." 
  Voi -- ci que je vous en -- ver -- rai 
  l’Es -- prit de vé -- ri -- té.
}

altoWordsunb = \lyricmode { 
  C’est lui que le Père a pro -- mis
  à ceux qui croient en moi.
  \set shortVocalName = "1." 
  Le mon -- de ne le con -- naît pas car il ne le voit pas.
  Mais vous le con -- nais -- sez dé -- jà,
  puis -- qu’il de -- meure en vous.
}

altoWordsdeux = \lyricmode { 
  \set stanza = #"2. "\set shortVocalName = "2." 
  Vous re -- ce -- vrez du haut des cieux 
  l’Es -- prit con -- so -- la -- teur.
}

altoWordsdeuxb = \lyricmode { 
  C’est lui l’Es -- prit, le Dé -- fen -- seur qui par -- le -- ra en vous.
  \set shortVocalName = "2." 
  Il com -- ble -- ra vos cœurs de joie par ma ré -- sur -- rec -- tion.
  Il vous fe -- ra res -- sou -- ve -- nir de tou -- tes mes pa -- roles.
}

altoWordstrois = \lyricmode { 
  \set stanza = #"3. "\set shortVocalName = "3." 
  C’est vous qui ê -- tes mes a -- mis, car je vous ai choi -- sis.
}

altoWordstroisb = \lyricmode { 
  Par moi vous por -- te -- rez un fruit qui de -- meure à ja -- mais.
  \set shortVocalName = "3." 
  Al -- lez por -- ter un fruit de vie au mon -- de qui l’at -- tend.
  Al -- lez por -- ter ce fruit d’a  -- mour au mon -- de dans sa nuit.
}

altoWordsquatre = \lyricmode { 
  \set stanza = #"4. "\set shortVocalName = "4." 
  Ce -- lui qui gar -- de mon a -- mour, mon Pè -- re l’ai -- me -- ra,
}

altoWordsquatreb = \lyricmode {
  et si vous de -- meu -- rez en moi, moi, je de -- meure en vous.
  \set shortVocalName = "4." 
  Voi -- ci ma paix que je vous donne
  a -- fin que vous vi -- viez.
  Le mon -- de ne peut la don -- ner_:
  C’est la paix de l’Es -- prit.
}

altoWordscinq = \lyricmode { 
  \set stanza = #"5. "\set shortVocalName = "5." 
  C’est un com -- man -- de -- ment nou -- veau
  que je vous ai don -- né_:
}

altoWordscinqb = \lyricmode {
  Don -- ner sa vie pour ses a -- mis,
  \set shortVocalName = "5." 
  c’est le plus grand a -- mour.
  Vous n’ê -- tes plus des ser -- vi -- teurs,
  vous ê -- tes mes a -- mis.
  Ai -- mez_- vous tous de cet a -- mour
  dont je vous ai ai -- més.
}

\transpose f e
\new ChoirStaff <<
  \new Staff = "women"   <<
    \new Voice = "sopranos" {
      \voiceOne \tempo "Paisible, sans traîner"
      << \global \sopMusic >>
    }
    \new Voice = "altos" %\with { \consists "Balloon_engraver" }
    {
      \voiceTwo
      << \global \altoMusic >>
    }
  >>
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsunb
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsdeuxb
  \new Lyrics \lyricsto "sopranos" \altoWordstrois
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordstroisb
  \new Lyrics \lyricsto "sopranos" \altoWordsquatre
  \new Lyrics 
  \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordsquatreb
  \new Lyrics \lyricsto "sopranos" \altoWordscinq
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordscinqb

  \new Staff = "men"
  <<
    \clef bass
    \new Voice = "tenors"
    {
      \voiceOne
      << \global \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo << \global \bassMusic >>
    }
  >>
>>