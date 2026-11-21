\version "2.24.0"
% 
% \paper {
%   #(set-paper-size "a5" ’landscape)
%   top-margin = 8
%   bottom-margin = 8
%   left-margin = 10
%   right-margin = 10
%   tagline = "Ne pas emporter svp"
% }
% 
% #(set-global-staff-size 15)
% 
% \header {
%   title = \markup \center-column { "Ô Dieu d’allégresse" }
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
  } 
}

global = { \key c \minor \time 4/4 }

sopMusic = \relative c'' {
  g4 g f ees d2 c g'4 g a b c2 b 
  c4 ees d d c2. \oneVoice r4 \voiceOne \bar ":|."
  g4 g aes g f4. f8 ees2 g4 g a b c bes a2 g 
  ees4 ees f ees d2 c\fermata \bar"|."
}

altoMusic = \relative c' {
  ees4 c c c c (b) c2 \breathe
  ees4 ees f f g2 g \breathe
  g4 g aes g8 (f) ees2. s4
  ees ees ees ees ees 
  \override BalloonText.annotation-balloon = ##f 
  <d \balloonText #'(1 . -2)\markup { "" } >
  ees2 \breathe
  ees4 ees f f ees d d2 bes \breathe
  c4 c c c c (b) c2
}

tenorMusic = \relative c' {
  c4 g aes g aes (g) <ees g>2 \breathe
  g4 c c d ees2 d\breathe
  ees4 c c b c2. s4
  bes4 bes c bes bes4. bes8 g2 \breathe
  g4 c c f, g g g (fis) g2\breathe
  g4 aes aes g g2 <g e>
}

bassMusic = \relative c {
  c4 ees f c <f, f'> (<g g'>) c2 c4 c f d c2 g'
  c,4 c <f, f'> <g g'> c2. \oneVoice r4 \voiceTwo
  ees4 ees aes, ees' bes4. bes8 ees2 c4 c f d c g d'2 g,
  c4 aes <f f'> c' g2 c\fermata
}

altoWordsun = \lyricmode {  
  \set stanza = #"1. "\set shortVocalName = "1." 
  Ô Dieu d’al -- lé -- gres -- se, joie de ma jeu -- nes -- se, 
  c’est toi mon bon -- heur.
  En toi, mon cœur et ma chair se con -- fient et se re -- po -- sent.
  Ma cou -- pe dé -- bor -- de.
}

altoWordsdeux = \lyricmode {  
  Tu es mon re -- fu -- ge, ma part d’hé -- ri -- ta -- ge. 
  Tu es mon che -- min.  
}

altoWordstrois = \lyricmode {  
  \set stanza = #"2. "\set shortVocalName = "2." 
  Je viens à ta sui -- te. Pour toi, je veux vi -- vre 
  et don -- ner mes biens.
  Aus -- si je te bé -- ni -- rai, toi qui m’as ins -- truit sans ces -- se,
  ô Dieu d’al -- lé -- gres -- se.
}

altoWordsquatre = \lyricmode {  
  Vers toi sans re -- lâ -- che, Sei -- gneur, je re -- gar -- de,
  et ne tom -- be point.
}

altoWordscinq = \lyricmode {  
  \set stanza = #"3. "\set shortVocalName = "3." 
  Dieu en qui j’es -- pè -- re, Sei -- gneur, tends l’o -- reil -- le_:
  Tu es mon sau -- veur_!
  Je t’ai dit_: “Voi -- ci, je "viens !”,"
  et tu as mis sur mes lè -- vres un chant d’al -- lé -- gres -- se.
}

altoWordssix = \lyricmode {  
  Sei -- gneur, tu m’ap -- pel -- les, pour qu’en ta pa -- ro -- le
  j’e -- xul -- te de joie.
}

altoWordssept = \lyricmode {  
  \set stanza = #"4. "\set shortVocalName = "4." 
  Que mon cœur pro -- cla -- me tou -- tes les mer -- veil -- les
  que tu fis pour moi.
  é -- le -- vant vers toi les mains en pré -- sen -- ce de ton peu -- ple
  pour te ren -- dre grâ -- ce.
}

altoWordshuit = \lyricmode {  
  Je pren -- drai la cou -- pe, sang de l’Al -- li -- an -- ce,
  joie du vin nou -- veau,
}

\score {
  \new ChoirStaff <<
    \new Staff = "women" <<
      \new Voice = "sopranos" {
        \voiceOne
        << \global \sopMusic >>
      }
      \new Voice = "altos" \with { \consists "Balloon_engraver" } {
        \voiceTwo
        << \global \altoMusic >>
      }
    >>
    
    \new Lyrics \lyricsto "sopranos" \altoWordsun
    \new Lyrics 
       \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
       \lyricsto "sopranos" \altoWordsdeux
    \new Lyrics \lyricsto "sopranos" \altoWordstrois
    \new Lyrics 
       \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
       \lyricsto "sopranos" \altoWordsquatre
    \new Lyrics \lyricsto "sopranos" \altoWordscinq
    \new Lyrics 
       \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
       \lyricsto "sopranos" \altoWordssix
    \new Lyrics \lyricsto "sopranos" \altoWordssept
    \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
    \lyricsto "sopranos" \altoWordshuit
    
    \new Staff = "men" <<
      \clef bass
      \new Voice = "tenors" {
        \voiceOne
        << \global \tenorMusic >>
      }
      \new Voice = "basses" {
        \voiceTwo << \global \bassMusic >>
      }
    >>
  >>
}