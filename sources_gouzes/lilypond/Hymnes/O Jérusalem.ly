\version "2.24.0"

\include "vowel-set.ly"

% \paper {
%   #(set-paper-size "a5" )
%   top-margin = 15
%   bottom-margin = 10
%   left-margin = 20
%   right-margin = 20
%   ragged-last = ##t
% }
% 
% #(set-global-staff-size 16)
% 
% \header {
%   title = \markup \center-column { "Ô Jérusalem" }
%   subtitle = " "
%   poet = ""
%   composer = ""
%   tagline = ##f
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
    \override InstrumentName.X-offset = 1.2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

im = \set ignoreMelismata = ##t
imstop = \unset ignoreMelismata

\transpose a b
<< \new Staff = main \with {\remove Time_signature_engraver }
   \new Voice = "soprano" 
   { \relative c'' 
     { \clef "treble" \key f \major \cadenzaOn 
       a8 [a] \phrasingSlurDashed a \([(bes)] a\) g \allowBreak f [g] a [a] d, \breathe\allowBreak 
       f g [e] \allowBreak f [e] \slurDashed d ([c]) d4 \bar "|"
       f8 [d] e [f] \allowBreak g [a] \slurSolid 
       { \tuplet 3/2 { g ([f e]) } }
       d4 \breathe\allowBreak e8 [f] e [d] \slurDashed \allowBreak e ([d]) c4 \bar "|"
       r8 a c [d] \allowBreak c [f] g [g] f \breathe\allowBreak g a [f] \allowBreak g ([f]) d [c] d4 \bar "||" 
       \slurSolid  d4 (e8 [d]) c4 (d) \bar "|." 
   } }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano" \set shortInstrumentName = "1." \set stanza = #"1. "
     Ô8 Jé -- ru4. __ -- sa8 -- lem, ci -- té de Dieu, nous t’ac -- cla -- mons_: Vi -- sion de paix.4
     Dans8 les cieux tu fus cons -- trui4 -- te de8 vi -- van -- tes  pier4 __ -- res,4
     \skip 8 cou8 -- ron -- née d’an -- ges et de saints, tu es la bien_- ai -- mée du Roi.4
   }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano" \set shortInstrumentName = "2." \set stanza = #"2. " %\override Lyrics.LyricText.font-shape = #'italic
     Tou8 -- te neu4. __ -- ve8 des -- cen -- due du ciel, tu es pa -- rée pour ton É -- poux.4
     Com8 -- me l’é -- pou8 -- sée, a -- van4 -- ce_! Viens8 é -- trein -- dre ton Sei -- gneur,4
     \skip 8 et8 l’on ver -- ra8 sur tes rem -- parts é -- tin -- ce -- ler l’or de ta joie.4
   }
   \new Lyrics \lyricmode 
   { \set associatedVoice = #"soprano" \set shortInstrumentName = "3." \set stanza = #"3. "
     Et8 que s’ou4 -- vrent8 tes portes à deux van -- taux. Que res -- plen -- dis -- se ta beau -- té.4
     Que8 tout hom -- me qui pé -- nè4 -- tre par8 ta grâ -- ce soit sau -- vé.4
     \skip 8 Qu’au8 nom du Christ soit ac -- cueil -- li ce -- lui qui souffre et perd cou -- rage.4 
   }
   \new Lyrics 
   \with { \override VerticalAxisGroup.nonstaff-nonstaff-spacing.minimum-distance = #5 }
   \lyricmode 
   { \set associatedVoice = #"soprano" \set shortInstrumentName = "4." \set stanza = #"4. " %\override Lyrics.LyricText.font-shape = #'italic
     Jé8 -- sus Christ4. __ lui-8 même est fon -- de -- ment_: c’est lui la pier -- re  d’an4 __ -- gle.
     Il8 sou -- tient tout l’é -- di -- fi4 -- ce, il8 as -- sem -- ble tous les murs.4
     \skip 8 C’est8 lui, Si -- on, que tu re -- çois, c’est lui en qui tu mets ta foi.4
   }
   %\vspace{5mm}
   \new Lyrics \lyricmode
   { \set associatedVoice = #"soprano" \set shortInstrumentName = "5." \set stanza = #"5. "
     C’est8 le Christ4. __ le8 maître et l’ar -- ti -- san. C’est lui qui taille et qui po -- lit.4
     Il8 a -- jus -- te cha -- que pier4 -- re, la8 choi -- sit en cha -- que lieu,4
     \skip 8 ain8 -- si pla -- cée pour de -- meu -- rer le Tem -- ple saint où il ha -- bite.4
   }
   \new Lyrics \lyricmode
   { \set associatedVoice = #"soprano" \set shortInstrumentName = "6." \set stanza = #"6. " %\override Lyrics.LyricText.font-shape = #'italic
     Cet8 -- te ra4. __ -- ce8 tout de blanc vê -- tue, pa -- rée du Chrê -- me du sa -- lut,4
     toi,8 la mè -- re vierge et pu4 -- re, fais8 qu’au ciel, Jé -- sus le Christ4 
     \skip 8 l’ac8 -- cueil -- le com -- me l’hé -- ri tière, li -- gnée cé --  les4 __ -- te8 du Père.4
   }
   \new Lyrics \lyricmode
   { \set associatedVoice = #"soprano" \set shortInstrumentName = "7." \set stanza = #"7. "
     Ci8 -- té sainte4 et8 ché -- rie de no -- tre Dieu, com -- blée de chants et de lou -- anges,4
     que8 ta grâce et tes mer -- veil4 -- les, et8 qu’en toi tou -- te beau -- té,4
     \skip 8 pro8 -- clament et disent a -- vec a -- mour le Dieu très saint que tu a -- brites.4
   }
   \new Lyrics \lyricmode
   { \set associatedVoice = #"soprano" \set shortInstrumentName = "8." \set stanza = #"8. " %\override Lyrics.LyricText.font-shape = #'italic
     Gloire,8 hon -- neur,4. __ puis8 -- sance à no -- tre Dieu, Très_- Haut Sei -- gneur en tous les lieux_:4
     gloire8 au Père, au Fils u -- ni4 -- que, à8 l’Es -- prit con -- so -- la -- teur,4
     \skip 8 aux8 trois, é -- gale a -- do -- ra -- tion pour tous les siè -- cles é -- ter -- nels.4 
     A2 -- men.2
   }
>>