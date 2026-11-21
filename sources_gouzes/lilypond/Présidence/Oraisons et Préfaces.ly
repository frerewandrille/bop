\version "2.24.0"

\include "vowel-set.ly"
gauche = \once \override LyricText.X-offset = #center-on-vowel
resp = { \breathe\break\allowBreak }
tete = { \once\override Stem.length = #0 }

\paper {
  #(set-paper-size "a5")
  top-margin = 10
  left-margin = 8
  right-margin = 8
  bottom-margin = 10 
  print-page-number = #f
  ragged-bottom = ##t
  ragged-last-bottom = ##t
  system-system-spacing = #'((basic-distance . 9) (padding . 0))
}

\header { tagline = #f }

#(set-global-staff-size 17)

\markup { 
  \fill-line\bold \fontsize #4 { "STRUCTURE DES ORAISONS ET PRÉFACES" }\vspace #1 }

\markup { 
  \vspace #3 \fill-line\bold \fontsize #2 { "Oraisons" }\vspace #1 }

\new Staff {
  <<
    \new Voice = "soprano" 
    \relative c'' { 
      \key g \major \cadenzaOn
      g\breve e4\resp
      g\breve a g4\resp
      g\breve e \tete d4 e \break \bar "|"
      g\breve e4\resp
      g\breve a g4\resp
      g\breve \tete e4 \tete d \tete e g4\break \bar "|."
    }
    \new Lyrics \lyricsto "soprano"
    {
      \gauche "Seigneur, toi qui dans le passé as fait ceci et ce" -- la,
      \gauche "renouvelle mainte" -- \gauche"nant tes mer" -- \gauche veilles,
      \gauche "pour que nous soy" -- \gauche "ons san" -- cti -- fiés,
      \gauche "Par Jésus Christ, ton Fils, notre" Dieu,
      \gauche "qui vit et règne avec toi, dans l’uni" --  \gauche"té du Saint Es" -- prit,
      \gauche "Dieu pour les"  siè -- cles des \gauche siècles_!
    }
  >>
}

\markup { 
  \vspace #2 \fontsize #1 { "ou bien" }}

\new Staff {
  <<
    \new Voice = "soprano" 
    \relative c'' { 
      \key f \major \cadenzaOn
      g\breve f4\resp
      g\breve a g4\resp
      g\breve f g4\break \bar "|"
      g\breve f4\resp
      g\breve a g4\resp
      g\breve f g4\break \bar "|."
    }
    \new Lyrics \lyricsto "soprano"
    {
      \gauche "Seigneur, toi qui dans le passé as fait ceci et ce" -- la,
      \gauche "renouvelle mainte" -- \gauche"nant tes mer" -- \gauche veilles,
      \gauche "pour que nous soy" -- \gauche"ons sancti" -- fiés,
      \gauche "Par Jésus Christ, ton Fils, notre" Dieu,
      \gauche "qui vit et règne avec toi, dans l’uni" --  \gauche"té du Saint Es" -- prit,
      \gauche "Dieu pour les"  \gauche "siècles des" \gauche siècles_!
    }
  >>
}
\pageBreak
\markup { 
  \fill-line\bold \fontsize #2 { "Préfaces" }\vspace #1 }

\new Staff {
  <<
    \new Voice = "soprano" 
    \relative c'' { 
      \key f \major \cadenzaOn
      g4 bes\breve  \tete a4 \tete g a4\resp
      g4 bes\breve  \tete a4 \tete g a4\resp
      g4 bes\breve  a \tete g4 a4\break \bar "|"
      a\breve bes a4\resp
      a\breve g a4\resp
      a\breve bes a4\resp
      a\breve g \tete f4  g4\break \bar "|."
      g4 bes\breve  a \tete g4 a4\break \bar "|"
      a\breve g \tete f4  g4\break \bar "|."
      g4 bes\breve  a \tete g4 a4\resp
      g4 bes\breve  a \tete g4 a4\resp
      \tete g4 \tete f \tete g a4 \bar "||"
    }
    \new Lyrics \lyricsto "soprano"
    {
      Vrai -- \gauche "ment, il est juste et bon de te" ren -- dre \gauche grâce,
      de \gauche "renouveler les motifs de te" re -- mer -- cier,
      et \gauche "de le faire en" -- \gauche"core un" -- e fois,
      \gauche "parce que tu es infi" -- \gauche"niment" bon,
      \gauche "infini" -- \gauche "ment ce" -- ci,
      \gauche "encore infini" -- \gauche "ment ce" -- là,
      \gauche "et finale" -- \gauche "ment que tu" nous \gauche aimes.
      Et \gauche "on recom" --  \gauche "mence tout" ce -- ci,
      \gauche "autant de"  \gauche"fois que né" -- ces -- \gauche saire_!
      no -- \gauche"tre cœur étant tout rempli d’une im" -- \gauche "mense al" -- lé -- \gauche gresse,
      no -- \gauche"tre cœur étant tout rempli d’une im" -- \gauche "mense al" -- lé -- \gauche gresse,
      A -- \gauche "fin qu’a" -- \gauche "vec tous" les \gauche anges,
      nous te chan -- tions_:
    }
  >>
}

\layout {
  indent = #0
  ragged-right = ##t
  \context {
    \Staff \remove "Time_signature_engraver"
  }
}