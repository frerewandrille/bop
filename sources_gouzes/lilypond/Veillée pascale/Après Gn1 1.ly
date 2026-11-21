\version "2.24.0"

%\include "TonsRDef.ly"
\include "vowel-set.ly"

%\paper { #(set-paper-size "a5") }

armure = { \key g \minor \time 3/4 }
retrait = \once \override LyricText.X-offset = #retrait
voy = \once \override LyricText.X-offset = #center-on-vowel

\layout {
  \context {
    \Lyrics
    \override InstrumentName.X-offset = 2
    \override InstrumentName.font-size = 0
    \override InstrumentName.font-series = #'bold
  } 
}

\new ChoirStaff
<< 
  \new Staff \with {\remove Time_signature_engraver }
  { \armure \cadenzaOn \tonRIIkf
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"1. " \set shortVocalName = "1." 
    "Bénis le Seigneur," ô mon âme
    "Seigneur mon Dieu, tu" es si grand_!
    "Revêtu de ma" -- gni -- fi -- cence,
    "tu as pour manteau" la lu -- mière_!
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"2. " \set shortVocalName = "2." 
    "Tu as donné son assise" à la terre_:
    "qu’elle reste inébranlable au" cours des temps.
    "Tu l’as vêtue de l’abî" -- me des mers_:
    "les eaux couvraient même" les mon -- tagnes.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"3. " \set shortVocalName = "3." 
    "Dans les ravins tu fais jail" -- lir des sources
    "et l’eau chemine aux creux" des mon -- tagnes.
    "Les oiseaux séjour" -- nent près \voy d’elle_:
    "dans le feuillage on en" -- tend leurs cris.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  { 
    \set stanza = #"4. " \set shortVocalName = "4." 
    "De tes demeures tu abreuves" les mon -- tagnes,
    "et la terre se rassasie du fruit" de tes œuvres.
    "Tu fais pousser les prairies pour" les trou -- peaux,
    "et les champs pour l’homme" qui tra -- vaille.
  }
  \addlyrics \with {\override LyricText.X-offset = #centrer }
  \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  { 
    \set stanza = #"5. " \set shortVocalName = "5." 
    "Quelle profusion dans tes œu" -- vres, Sei -- gneur_!
    "Tout cela, ta sages" -- se l’a fait
    "la terre s’emplit" de tes biens.
    "Bénis le Seigneur," ô mon âme_!
  }
  \new Staff \with {\remove Time_signature_engraver }
  { \clef "bass" \armure \cadenzaOn \tonRIIkh
  }
>>