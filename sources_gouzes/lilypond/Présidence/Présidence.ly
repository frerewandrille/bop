\version "2.24.0"

gauche = { \once \override LyricText.self-alignment-X = #LEFT }

\paper {
  #(set-paper-size "a6")
  top-margin = 10
  left-margin = 8
  right-margin = 8
  bottom-margin = 10 
  print-page-number = #f
}

#(set-global-staff-size 18)



\bookpart { 
  \header {
    title = "PRÉSIDENCE DE L’OFFICE"
    tagline = ##f
  }

  \markup { 
    \vspace #5 \fill-line\bold \fontsize #3 { "Introduction" }}
  \markup\vspace #2

  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c' { 
        \key f \major \cadenzaOn
        f\breve e4 d f2 f4\break \bar "|"
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \set stanza = "Matin :" \gauche "Seigneur, ou"\breve -- vre4 mes lè2 -- vres.4
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \set stanza = "Soir :" \gauche "Dieu, viens"\breve à4 mon ai2 -- de.4
      }
    >>
  }
  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c' { 
        \key f \major \cadenzaOn
        f\breve \break \allowBreak e4 d f2 f\breve g f2 \bar "|."
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \gauche "Gloire au Père, et au Fils, et au"\breve Saint4 Es -- prit,2
        \gauche "mainte"\breve -- \gauche "nant et tou" -- jours.2 
      }
    >>
  }
}
\bookpart { 
  \header {
    tagline = ##f
  }
  \markup { %\vspace #2 
    \fill-line\bold \fontsize #3 { "Preces et conclusion"}  } 
  \markup\vspace #2
  
  \markup{Semaines I, II, III, VI, VII et VIII}
  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c' { 
        \key f \major \cadenzaOn
        f\breve e4 d f2 \bar "|."
      }    
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \set stanza = "Matin :" \gauche "En paix, louons et bénissons"\breve le4 Sei -- gneur.2
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \set stanza = "Soir :" \gauche "En paix, prions et supplions"\breve le4 Sei -- gneur.2
      }    
    >>
  }
  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c' { 
        \key f \major \cadenzaOn
        f\breve e4 d f2 \bar "|."
      }    
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \gauche "Bénissons"\breve le4 Sei -- gneur.2
      }
    >>
  }
  \markup\vspace #3
  
  \markup{Semaines IV et V}
  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key c \major \cadenzaOn
        a4 g\breve f4 a2 \bar "|."
      }    
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \set stanza = "Matin :" En4 \gauche "paix, louons et bénissons le"\breve Sei4 -- gneur.2
      }
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \set stanza = "Soir :" En4 \gauche "paix, prions et supplions le"\breve Sei4 -- gneur.2
        %      \set stanza = "Soir :" \gauche "En paix, prions et supplions"\breve le4 Sei -- gneur.2
      }    
    >>
  }
  \new Staff {
    <<
      \new Voice = "soprano" 
      \relative c'' { 
        \key c \major \cadenzaOn
        a\breve g f4 a2 \bar "|."
      }    
      \new Lyrics \lyricmode {
        \set associatedVoice = #"soprano" 
        \gauche Bénis\breve -- "sons le" Sei4 -- gneur.2
      }
    >>
  }
}


\layout {
  indent = #0
  ragged-last = ##t
  ragged-right = ##t
  \context {
    \Staff \remove "Time_signature_engraver"
  }
}