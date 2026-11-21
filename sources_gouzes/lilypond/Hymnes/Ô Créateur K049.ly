\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 20
%   right-margin = 20
%   ragged-last-bottom = ##f
% }
% 
% #(set-global-staff-size 16)
% 
% \header {
%   title = \markup \center-column { "Ô Créateur" }
%   subtitle = " "
%   poet = ""
%   composer = ""
%   tagline = ##f
% }

\layout {
  indent = #0
  \context {
    \Score \remove "Bar_number_engraver"
  }
  \context {
    \Lyrics
    \override LyricText.font-size = #2
    \override LyricSpace.minimum-distance = #1
  } 
}


\layout {
  \context {
    \Lyrics
    \consists "Bar_engraver"
    \consists "Separating_line_group_engraver"
    \hide BarLine
  }
}

resp = { \breathe\allowBreak }
mes = { }%\undo \omit Score.BarLine }
nmes = { }%\omit Score.BarLine }

<< 
  \new Staff = main \with {\remove Time_signature_engraver }
  \new Voice = "soprano" 
  { \relative c'' 
    { \clef "treble" \time 1/4 \key bes \major \tempo 4 = 84
      \cadenzaOn
      { << g4 { \new Voice { \voiceTwo \relative c' { d\breve*1/8 } } } >> }\nmes
      f8 [g] bes4 a8 [bes] g [a] g [f] g4 g\resp
      a bes8 [c] c4 bes8 [a] g4 bes8 [a] g [a] g4  f2 \mes\bar "|" 
      d4 \nmes f8 [g] bes4 (a8) [g] a [bes] c4 c\resp 
      f,8 [g] bes4 c8 [a] bes4 (a8) [g] a4 (g8) [f]  g2 \mes\bar "|." 

      { << g4 { \new Voice { \voiceTwo \relative c' { d\breve*1/8 } } } >> }\nmes
      f8 [g] bes4 a8 [bes] g [a] a4 g8 [f] g4\resp
      bes8 [a] bes [c] c [bes] a4 g bes8 ([a]) g [a] g4 f2 \mes\bar "|"
      d4 \nmes f8 [g] bes4 a8 [g] a [bes] c4\resp
      f,8 [g] bes4 c8 [a] bes4 (a8) [g] a4 g8 [f] g2 \mes\bar "|."

      { << g4 { \new Voice { \voiceTwo \relative c' { d\breve*1/8 } } } >> }\nmes
      f8 [g] bes4 (a8) [bes] g ([a]) g8 [f] g4\resp
      a4 bes8 [c] c [bes] a4 g bes8 [a] g4 a8 [g] f2 \mes\bar "|"
      d4 \nmes f8 [g] bes4 (a8) [g] a [bes] c4 c\resp
      f,8 [g] bes4 c8 [a] bes4 (a8) [g] a4 g8 [f] g2 \mes\bar "|."

      { << g4 { \new Voice { \voiceTwo \relative c' { d\breve*1/8 } } } >> }\nmes
      f8 [g] bes4 a8 [bes] g [a] g8 [f] g4\resp
      bes8 [a] bes [c] c [bes] a4 g bes8 [a] g [a] g4 f2 \mes\bar "|"
      d4 \nmes f8 [g] bes4 a8 [g] a [bes] c4 c\resp
      f,8 [g] bes4 c8 [a] bes4 (a8) [g] a4 (g8) [f] g2 \mes\bar "|."

      { << g4 { \new Voice { \voiceTwo \relative c' { d\breve*1/8 } } } >> }\nmes
      f8 [g] bes4 a8 [bes] g [a] g8 [f] g4\resp
      bes8 [a] bes ([c]) c [bes] a4 g bes8 ([a]) g [a] g4 f2 \mes\bar "|"
      d4 \nmes f8 [g] bes4 a8 [g] a [bes] c4\resp
      f,8 [g] bes4 c8 [a] bes4 (a8) [g] a4 (g8) [f] g2 \mes\bar "|."
      { << { \voiceOne g4 (\nmes a8 [g] ) f4 (g2) } { \new Voice { \voiceTwo d2 g,4 (d'2) } } >> }
      \mes\bar "|."
    } 
  }
  
  \new Lyrics \lyricsto soprano
  { \set stanza = #"1."
    Ô Cré -- a -- teur, tu con -- nais le cœur de l’hom -- me,
    en -- tends nos larmes et le cri de no -- tre pri -- è -- re_!
    En ce saint jeû -- ne du ca -- rê -- me,
    con -- duis_- nous au dé -- sert, pu -- ri -- fie_- nous_!_
    
    \set stanza = #"2."
    Dans ta ten -- dres -- se, Sei -- gneur, tu scru -- tes nos cœurs,
    tu con -- nais l’in -- fir -- mi -- té de tou -- tes nos for -- ces_;
    Donne à ce -- lui qui re -- vient vers toi
    le par -- don et la grâ -- ce de ton a -- mour.

    \set stanza = #"3."
    Oui, nous a -- vons pé -- ché con -- tre toi_:
    Par -- donne à ceux qui pleu -- rent et con -- fes -- sent ton Nom_!
    Pour la lou -- an -- ge de ta gloi -- re,
    pen -- che_- toi sur nos plaies, Sei -- gneur, gué -- ris_- nous_!

    \set stanza = #"4."
    Que l’abs -- ti -- nen -- ce li -- bè -- re no -- tre corps,
    que ta grâ -- ce l’il -- lu -- mine en ton Corps de Lu -- miè -- re_!
    Que notre es -- prit re -- de -- vien -- ne so -- bre,
    qu’il é -- vi -- te tout mal et tout pé -- ché_!

    \set stanza = #"5."
    Nous te pri -- ons, bien -- heu -- reu -- se Tri -- ni -- té,
    con -- duis_- nous jus -- \apostrophe qu’aux joies des fê -- tes pas -- ca -- les_!
    Et nous ver -- rons se le -- ver le Christ,
    glo -- ri -- eux et vi -- vant par -- mi les morts. A -- men_!
  }
>>
