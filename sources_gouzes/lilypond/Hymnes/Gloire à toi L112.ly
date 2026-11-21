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
%   title = \markup \center-column { "Gloire à toi, Seigneur notre Chef" }
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
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
    \override LyricText.X-offset = #centrer
  } 
}

\layout { ragged-last = ##f indent = #0 }

armure = {
  \key aes \major
  \time 3/4
}
apostrophe = \once \override LyricText.X-offset = #apostrophe
resp = { \breathe\allowBreak }


\transpose c d
\new ChoirStaff
<< \new Staff
   << \new Voice = "soprano"
      \clef "treble" \armure \cadenzaOn
      { \voiceOne \relative c'' { c2 bes4 2 c4 bes-> aes bes4 2 c4 aes2 g4 f2. \bar ":|." } }
      \new Voice = "alto"
      { \voiceTwo \relative c'' { aes2 g4 2 aes4 g f g g2 aes4 f2 ees4 c2. } }
   >>
   \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
   \lyricsto soprano { Gloire à toi, Sei -- gneur, no -- tre chef et no -- tre Roi_! }
   \new Staff %\with {\remove Time_signature_engraver }
   << \new Voice = "ténor" \with { \consists "Balloon_engraver"
                                   \override BalloonText.annotation-balloon = ##f }
      \clef "bass" \armure\cadenzaOn
      { \voiceOne \relative c' {  ees2 4 2 4 4 c des ees2 4 des 
                                  <bes \balloonText #'(1.5 . 2.5)\markup { "" } >2 c2. } }
      \new Voice = "basse"
      { \voiceTwo \relative c' { aes2 ees4 2 aes4 ees-> f bes, ees2 <aes, aes'>4 des ees2 f2. } }
   >>
>>



sopMusic = \relative c' {
  f2-> ees4 f2-> \allowBreak g4 aes2-> g8 ([f]) ees2.->\resp ees2-> f4 aes2-> \allowBreak bes4 aes g8-> ([f] ees4) f2-> f4\bar"|"
  f2-> ees4 f2-> \allowBreak g4 aes2-> g8 ([f]) ees2.->\resp ees2-> f4 aes2-> \allowBreak bes4 aes g8-> ([f] ees4) f2-> f4\fermata\bar "|."
}
altoMusic = \relative c' {
  c2 c4 c2 ees4 2 des4 c2. 2 4 f2 g4 f des (c) c2 4
  c2 c4 c2 ees4 2 des4 c2. 2 4 f2 g4 f des (c) c2 4
}
tenorMusic = \relative c' {
  aes2 g4 aes2 bes4 c2 bes8 ([aes]) g2. 2 aes4 c2 ees4 c bes8 ([aes] g4) aes2 4
  aes2 g4 aes2 bes4 c2 bes8 ([aes]) g2. 2 aes4 c2 ees4 c bes8 ([aes] g4) aes2 4
}
bassMusic = \relative c { \autoBeamOff
                          f2-> c4 f2-> ees4 aes,2-> bes4 c2.-> \resp 2-> f4 2-> ees4 f bes,-> (c) f2-> 4
                          f2-> c4 f2-> ees4 aes,2-> bes4 c2.-> \resp 2-> f4 2-> ees4 f bes,-> (c) f2-> 4\fermata
}

altoWordsun = \lyricmode {  
  \set shortVocalName = "1." \set stanza = #"1. "
  D’Is -- ra -- ël tu es le Roi, de Da -- vid le Fils très no -- ble.
  Tu viens au Nom du Sei -- gneur_:_ Christ, les peu -- ples te bé -- nis -- sent.
}
altoWordsdeux = \lyricmode {  
  \set shortVocalName = "2." \set stanza = #"2. " 
  Tous les An -- es et les Saints au plus haut des cieux t’ac -- cla -- ment.
  Sur la ter -- re tou -- te vie a -- vec l’hom -- me te rend grâ -- ce.
}
altoWordstrois = \lyricmode {  
  \set shortVocalName = "3." \set stanza = #"3. "
  Vois le peu -- ple des Hé -- breux qui s’a -- vance a -- vec des pal -- mes.
  A -- vec lui nous t’ac -- cla -- mons par nos chants et nos pri -- è -- res.
}
altoWordsquatre = \lyricmode {  
  \set shortVocalName = "4." \set stanza = #"4. "
  Quand tu mar -- chais vers la mort, ils pro -- cla -- ment ta lou -- an -- ge_!
  Nous aus -- si nous te chan -- tons_: au -- jour --\apostrophe d’hui s’ou -- vre ton rè -- gne.
}
altoWordscinq = \lyricmode {  
  \set shortVocalName = "5." \set stanza = #"5. "
  A -- vec le chant des Hé -- breux, Christ, re -- çois no -- tre lou -- an -- ge_!
  Roi très bon, Roi très clé -- ment, nous cé -- lé -- brons ta vic -- toi -- re.
}
altoWordssix = \lyricmode {  
  \set shortVocalName = "6." \set stanza = #"6. "
  Crie de joie, Jé -- ru -- sa -- lem, chante et danse a -- vec des pal -- mes_!
  Par sa croix, ton Bien_- Ai -- mé vient t’of -- frir la joie des No -- ces.
}
altoWordssept = \lyricmode {  
  \set shortVocalName = "7." \set stanza = #"7. "
  Toi qui vi -- vais dé -- lais -- sée sous le poids de ta souf -- fran -- ce,
  Par l’a -- mour du cœur de Dieu, tu re -- nais à l’es -- pé -- ran -- ce.
}
altoWordshuit = \lyricmode {  
  \set shortVocalName = "8." \set stanza = #"8. " 
  Ton Dieu vient te vi -- si -- ter_: cours vers lui, ou -- vre tes por -- tes
  et ac -- cueil -- le le Mes -- sie que t’an -- non -- çaient les pro -- phè -- tes.
}
altoWordsneuf = \lyricmode {  
  \set shortVocalName = "9." \set stanza = #"9. "
  Lou -- ez_- le, bat -- tez des mains et dan -- sez dans l’al -- lé -- gres -- se_!
  C’est le Christ, c’est le Sei -- gneur, lui qui rè -- gne sur la ter -- re.
}
altoWordsdix = \lyricmode {  
  \set shortVocalName = "10." \set stanza = #"10. "
  Por -- tes, le -- vez vos fron -- tons_! Le voi -- ci, le Roi de gloi -- re_!
  Por -- tes, le -- vez vos fron -- tons_! Que tous chan -- tent sa vic -- toi -- re.
}
altoWordsonze = \lyricmode {  
  \set shortVocalName = "11." \set stanza = #"11. "
  Bé -- ni soit ce -- lui qui vient_: c’est Jé -- sus no -- tre lu -- miè -- re_!
  Chan -- tez_- le, ra -- meaux en mains_! Le Sei -- gneur nous il -- lu -- mi -- ne.

}
altoWordsdouze = \lyricmode {  
  \set shortVocalName = "12." \set stanza = #"12. "
  Danse au son du tam -- bou -- rin, de la flûte et des ci -- tha -- res_:
  Le Sei -- gneur parle à ton cœur, il t’en -- traî -- ne dans sa Pâ -- que.
}
altoWordstreize = \lyricmode {  
  \set shortVocalName = "13." \set stanza = #"13. "
  Toi, la fil -- le de Si -- on, que Dieu com -- ble de sa gloi -- re,
  Re -- vê -- tue de sa beau -- té, tu t’a -- vances à sa ren -- con -- tre.
}
altoWordsquatorze = \lyricmode {  
  \set shortVocalName = "14." \set stanza = #"14. " 
  Dans le Christ, Dieu nous bé -- nit, par la grâ -- ce de sa Pâ -- que_!
  Ex -- ul -- tons, cri -- ons de joie, re -- ce -- vons la vie nou -- vel -- le.

}
altoWordsquinze = \lyricmode {  
  \set shortVocalName = "15." \set stanza = #"15. "
  Gloire au Père et à l’Es -- prit, par Jé -- sus, le Fils u -- ni -- que_:
  Dieu vi -- vant et trois fois saint, que tout chan -- te ta lou -- an -- ge.
}

\transpose c d
\new ChoirStaff 
<<
  \new Staff = "women" \with {\remove Time_signature_engraver }
  <<
    \new Voice = "sopranos" {
      \voiceOne
      << \armure \cadenzaOn \sopMusic >>
    }
    \new Voice = "altos" {
      \voiceTwo
      << \armure \cadenzaOn \altoMusic >>
    }
  >>
  
  \new Lyrics \lyricsto "sopranos" \altoWordsun
  \new Lyrics \lyricsto "sopranos" \altoWordsdeux
  \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
  \lyricsto "sopranos" \altoWordstrois
  % \new Lyrics \lyricsto "sopranos" \altoWordsquatre
%   \new Lyrics \lyricsto "sopranos" \altoWordscinq
%   \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
%   \lyricsto "sopranos" \altoWordssix
%   \new Lyrics \lyricsto "sopranos" \altoWordssept
%   \new Lyrics \lyricsto "sopranos" \altoWordshuit
%   \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
%   \lyricsto "sopranos" \altoWordsneuf
%   \new Lyrics \lyricsto "sopranos" \altoWordsdix
%   \new Lyrics \lyricsto "sopranos" \altoWordsonze
%   \new Lyrics \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #4 }
%   \lyricsto "sopranos" \altoWordsdouze
  \new Lyrics \lyricsto "sopranos" \altoWordstreize
  \new Lyrics \lyricsto "sopranos" \altoWordsquatorze
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" \altoWordsquinze

  
  \new Staff = "men" \with {\remove Time_signature_engraver }
  <<
    \clef bass
    \new Voice = "ténors" \with { \consists "Balloon_engraver" } {
      \voiceOne
      << \armure \cadenzaOn \tenorMusic >>
    }
    \new Voice = "basses" {
      \voiceTwo 
      << \armure \cadenzaOn \bassMusic >>
    }
  >>
>>