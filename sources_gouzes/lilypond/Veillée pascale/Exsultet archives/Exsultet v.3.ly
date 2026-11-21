\version "2.24.0"
\header { composer = ##f tagline = ##f }
#(set-default-paper-size "a5")
#(set-global-staff-size 18)

\paper { 	
  top-margin = 15
  bottom-margin = 20
  left-margin = 10
  right-margin = 10
  systems-per-page = #9
}
aligne = \once \override LyricText.self-alignment-X = #LEFT
resp = {\breathe\allowBreak}
saut = \allowBreak
pause = \bar "|"
ital = {\override Lyrics.LyricText.font-shape = #'italic
        \override Lyrics.LyricText.font-series = #'bold
}
norm = {\revert Lyrics.LyricText.font-shape
        \revert Lyrics.LyricText.font-series
}
sup = {%\override NoteHead.stencil = ##f
  \override Score.BarLine.stencil = ##f
}
ret = {%\revert NoteHead.stencil
  \revert Score.BarLine.stencil
}
%barre = \ret \bar "|" \sup

\layout { 
  \context { \Lyrics 	
             \override LyricText.font-name = #"Linux Libertine"
             \override LyricText.font-size = #2 
             %   \consists "Bar_engraver"
             %   \consists "Separating_line_group_engraver"
             %   \override BarLine.transparent = ##t
             %   \override VerticalAxisGroup.nonstaff-nonstaff-spacing.stretchability = #10
  } 
  \context { \Staff
             \remove Time_signature_engraver
             \remove Bar_number_engraver
  }
  \context { \Score
             \remove Bar_number_engraver
  }  ragged-last = ##t 
}


\bookpart { 
  \markup { 
    \fill-line {
      \center-column {
        \null\combine \null \vspace #14 \fontsize #12 EXSULTET
      }
    }
  }
}

\new Staff 
<< 
  %\cadenzaOn 
  \time 1/4 \key f \major
  \new Voice = "melodie" \relative c'' {
    \sup
    \mark \markup "C1" 
    a4 c^> c c c c c c c c d2 c4 a c2 c \ret 
    \mark \markup "C2"
    a4 \sup a2 a4 g4 f a2 \resp 
    a4 a a a \saut a c4^> c a g a2 a  \resp 
    c4 c c \saut c4^> d \saut c a c2\fermata \ret
    \bar "|." \mark \markup "C1"
    a4 \sup a a c2 d4 c a c2 c \ret
    \bar "|" \mark \markup "C2"
    a4 \sup a a g4 f a2 a \resp a4 a a a c4 a g a2 \resp 
    c4 c c c c d4 c a c2\fermata \ret
    \bar "|." \mark \markup "C1"
    a4 \sup a a c2 \saut c4 c^> d c a c2 c \ret
    \bar "|" \mark \markup "C2"
    a4 \sup a a \saut g4 f a2 \ret 
    a4 \sup a a c4^> c \saut c a g a2 \resp c4 c d4 c a c2\fermata \ret
    \bar "|." \mark \markup "C1" 
    c4 \sup c c c2 \resp c4 c d c a c2 c \ret
    \bar "|" \mark \markup "C2"
    a4 \sup a a a a g4 f a2
    a4 a a c2^> c \resp c4 c^> d c a c2\fermata \ret 
    \bar "|." \mark \markup "C1"
  }
  \new Lyrics %\with {
  % \override VerticalAxisGroup.nonstaff-relatedstaff-spacing = #'((basic-distance . 7))
  % }
  \lyricsto "melodie" {
    Qu’e -- xul -- te de joie dans le ciel la multi -- tu -- de des an -- ges_!
    Chan -- tez, \aligne servi -- teurs de Dieu, 
    et que retentisse la trom -- pet -- te tri -- om -- pha -- le, 
    \aligne pour la vic -- toi -- re du grand Roi_!
    Ré -- jou -- is- toi, \saut ô no -- tre ter -- re,
    \aligne resplendissante d’une lumière \saut é -- cla -- tan -- te,
    \aligne car il t’a prise en sa clar -- té 
    \aligne et son règne a dis -- si -- pé ta nuit_!
    Ré -- jou -- is- toi, É -- gli -- se no -- tre Mè -- re,
    \aligne toute remplie de sa splen -- deur,
    \aligne et que ré -- son -- ne l’ac --
    cla -- ma -- tion \aligne du peuple des fils de Dieu_!
    \aligne Unissez, frères bien-ai -- més, vo -- tre voix à la mien -- ne,
    \aligne pour que je chante en vo -- tre nom
    \aligne la merveilleuse lu -- miè -- re du Christ res -- sus -- ci -- té_!
    c\breve a2 \resp c\breve c2 \resp c\breve d2 d4 c a c2 c \pause
    c\breve a2 a4 a a g f a2 \pause g\breve f4 g2 \resp g\breve g2 \resp
    g\breve f4 a2\fermata a
  }
>>

\new Staff 
<< 
  \cadenzaOn \key f \major 
  \new Voice = "melodie" \relative c' { 
    f4 f f e4 d f2 \bar "||" a4 a bes4 bes a2 \bar "|." \break
    f\breve g2 g4 g f2 \bar "||" a4 a a bes bes bes bes a2 \bar "|." \break
    f4 f f f e4 d f2 \bar "||" a4 a bes4 bes a2 \bar "|." \break
    c\breve d2 c4 \saut a c2 c \pause c\breve a2 a \resp a\breve g4 f a2 \pause
    g\breve f4 g2 \resp g\breve f4 a2\fermata \bar "|." \mark \markup "A"
 
    c\breve d2 \saut c4 a \saut c2 c \pause c\breve a2 g4 f a2 \resp g\breve f4 a2\fermata
    \bar "|." \mark \markup "A"
 
    c\breve c2 c \resp c\breve d2 c4 \saut a c \pause \mark \markup "A"
    c\breve c2 c \resp c\breve d2 \saut c4 a c2 \resp c\breve a2 g4 f a2 \pause
    g\breve f4 g2 g \resp g\breve f4 a2\fermata \bar "|." \mark \markup "A"
 
    a4 c2 \saut c\breve d4 d c \saut a c2 \pause a\breve a2 \resp a\breve g4 f a2 \pause
    g\breve \saut f4 \saut g2 \resp g\breve f4 a2\fermata \bar "|." \mark \markup "A"
 
    c4 c2 \saut c\breve a4 c2 c \resp c\breve d2 d4 d c \saut a c2 \pause c\breve a2 
    \resp \mark \markup "A"
    c\breve d2 d4 d c2 c \resp a\breve g4 f a2 \pause g\breve f4 g2 g \resp
    g\breve a2 a4 a g2 g \resp g\breve f4 a2\fermata \bar "|." \mark \markup "A"
 
    c\breve a2 \resp c\breve c2 \resp c\breve d2 d4 c a c2 c \pause
    c\breve a2 a4 a a g f a2 \pause g\breve f4 g2 \resp g\breve g2 \resp
    g\breve f4 a2\fermata a \fermata\bar "|." \mark \markup "A"
 
    c\breve d2 d4 d c a c2 \resp c\breve a4 g f a2 \pause g\breve f4 g2 \resp
    g\breve f4 a2\fermata\bar "|." \mark \markup "A"
 
    c\breve a2 a \resp c\breve d4 c a c2 c \resp c\breve a2 a\breve g4 f a2 a
    \pause \mark \markup "A"
    a\breve c2 c\breve d4 c a c2 \resp a\breve g4 f a2 a\breve c4 a g a2 \resp
    g\breve g2 g\breve f4 a2\fermata a\fermata\bar "|." \mark \markup "A*"
  }
  \new Lyrics %\with {
  % \override VerticalAxisGroup.nonstaff-relatedstaff-spacing = #'((basic-distance . 7))
  % }
  \lyricsto "melodie" { 
    \aligne Le Seigneur soit a -- vec vous_! 
    \aligne \ital Et avec votre es -- prit_! \norm
    Éle -- vons no -- tre cœur_! 
    \aligne\ital Nous le tour -- \aligne nons vers le Sei -- gneur_! \norm
    \aligne Rendons grâce au Seigneur no -- tre Dieu_! 
    \aligne\ital Cela est juste et bon_! \norm
    \aligne Vraiment, il est juste et bon de proclamer à pleine voix ta lou -- an -- ge,
    \aligne Dieu invi -- si -- ble, \aligne Père Tout- Puis -- sant,
    \aligne et de chanter ton Fils Bien- ai -- mé, 
    \aligne Jésus-Christ, notre Sei -- gneur_!
 
    \aligne C’est lui qui a payé pour nous la dette encourue par A -- dam no -- tre
    Pè -- re,
    \aligne et qui a dé -- truit en son sang 
    \aligne la condamnation de l’ancien pé -- ché.
 
    \aligne Car voici la fête de la Pâ -- que, 
    \aligne où l’Agneau véritable est im -- mo -- lé pour nous, 
    \aligne voici la Nuit où tu tiras de l’É -- gyp -- te
    \aligne nos père, les en -- fants d’Is -- ra -- ël, 
    \aligne et leur as fait passer la Mer Rouge à pied sec, 
    \aligne Nuit où le feu de la Nuée lu -- mi -- neu -- se
    \aligne a repoussé les ténèbres du pé -- ché.
 
    Ô Nuit \aligne qui nous rend à la grâce et nous ouvre la com -- mu -- nion
    des saints, \aligne Nuit où le Christ, brisant les liens de la Mort,
    \aligne s’est relevé victorieux des en -- fers_: 
    \aligne heureuse faute d’A -- dam 
    \aligne qui nous a valu un tel Ré -- demp -- teur_!
 
    Ô Nuit \aligne qui seule a pu con -- naî -- tre 
    \aligne le temps et l’heure où le Christ est sorti vi -- vant du sé -- jour des morts,
    \aligne ô Nuit dont il est é -- crit_: 
    \aligne « La nuit comme le jour il -- lu -- mi -- ne,
    \aligne la ténèbre autour de moi devient lumière pour ma joie_»,
    \aligne ô Nuit bien -- heu -- reu -- se, 
    \aligne où se rejoignent le ciel et la ter -- re, 
    \aligne où s’unissent l’homme et Dieu.
 
    \aligne Dans la grâce de cette Nuit, \aligne accueille, Père très saint
    \aligne le sacrivice du soir de cet -- te flam -- me 
    \aligne que l’É -- gli -- se t’of -- fre par nos mains_; 
    \aligne permets que ce cierge pascal consacré à ton Nom 
    \aligne brûle sans déclin en cette Nuit 
    \aligne et qu’il joinge sa clarté à celle des é -- toi -- les.
 
    \aligne Qu’il brûle encore quand se lève -- ra l’as -- tre du ma -- tin,
    \aligne celui qui ne connaît pas de cou -- chant_: 
    \aligne le Christ ressuscité revenu des en -- fers, 
    \aligne qui répand sur les hommes sa Lumière et sa Paix.
 
    \aligne Garde ton peu -- ple, \aligne nous t’en prions, ô no -- tre Pè -- re,
    \aligne dans la joie \aligne de ces fê -- tes pas -- ca -- les_;
    \aligne par Jésus- Christ, \aligne ton Fils no -- tre Sei -- gneur,
    \aligne qui par la puissance de l’Es -- prit, 
    \aligne s’est relevé d’en -- tre les morts 
    \aligne et règne près de Toi, \aligne pour les siècles des siè -- cles.
  }
>>