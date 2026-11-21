\version "2.24.0"

ss = { \hideNotes b8 \unHideNotes }
resp = { \breathe\allowBreak }
gras = { \override Lyrics.LyricText.font-series = #'bold }
norm = { \revert Lyrics.LyricText.font-series }

\new ChoirStaff
\new Staff = "women" \with { \remove "Time_signature_engraver" } 
<<
  \new Voice = "sopranos" {
    \cadenzaOn \key a \minor \time 2/4 \voiceOne
    \relative c' { 
      d8 [a'] a4 b!8 [a] g [a] a4\bar"||"
      d,8 a'\breve*1/16 \ss \ss a4\allowBreak a\breve*1/16 \ss g8[a] c ([a]) a4\fermata\bar"||"
      a\breve*1/16 \ss \ss a4\resp g8 [a] c [a] a4\bar"||"
      a\breve*1/16 \ss a4\resp g8 [a] c [a] a4\bar"||"
      d,8 [a'] a [a] a ([g16 a] c8 [b16 c] d8 [a]) a4\resp a\breve*1/16 \ss \ss g8 [a] b ([a]) a4\bar"||"
      d,8 [a'] a4 a8 [g] a4 \resp a8 [a] g8 [a] c [a] a4\bar"||"
      d,8 ([a']) a [g16 a] c8 ([b16 c] d8 [a]) a4\resp g8 [a] a4\bar"||"
      d,8 [a'] a4. a8 g [a] a4. a8 g8 [a] c ([a]) a4\bar"||"
      d,8 a'\breve*1/16-> \ss \ss \ss g8 [a] c8 ([b16 c] d8 [a]) a4\resp g8 [a] b [a] a4\bar"||"
      d,8 a'\breve*1/16-> \ss \ss \ss  g8 [a] c ([a]) a4\resp a8 a [a] g8 [a] b^- ([a]) a4\bar"||"
      d,8 a'\breve*1/16-> \ss \ss \ss \ss \ss \ss a8 ([g16 a] c8 [b16 c] d8 [a]) a4\resp g8 [a] b [a] a4\fermata\bar"||"
      d,8 [a'] a [a] a4\resp g8 [a] c [a] a4\bar"||"
      d,8 a'-> [a] a [a] a ([g16 a] c8 [b16 c] d8 [a~] a4)\resp g8 [a] a4.\fermata\bar"||"
      d,8 a'\breve*1/16-> \ss \ss a4\resp g8 [a] c4 c8 [c] b [c] d ([a]) a4\bar"||"\break
      <<
        { \oneVoice r8 d,8 (a' [g16 f] e8 [d] a' [g16 a] c8 [b16 c] d8 [a] b [a]) a4\fermata\bar"|." }
        \new Staff 
        \with { \consists "Balloon_engraver"
                \override BalloonText.annotation-balloon = ##f }
        \with { \remove "Time_signature_engraver" } 
        <<
          \new Voice { \voiceOne \relative c'' { 
            r4 
            <d \balloonText #'(-2 . 2)\markup { "" } >
            (c b a d e) d }}
          \new Voice {\voiceTwo \relative c' { 
            <d \balloonText #'(2.5 . 5)\markup { "" } >2
            (a4 e' f g8 [f] e [c]) d4\fermata }}
        >>
      >>
    }
  }
  \new Voice = "altos" { 
    \voiceTwo
    \relative c' { \once \override NoteColumn.force-hshift = #-1.2
      d\breve*1/2 d4
      \once \override NoteColumn.force-hshift = #-1.2
      d\breve*1/4 d4 d\breve*1/8 c8 [a] c ([d]) d4
      d\breve*3/16 d4 c8 [a] c [d] d4
      d\breve*1/8 d4 c8 [a] c [d] d4
      \once \override NoteColumn.force-hshift = #-1.2
      d\breve*1/4 d8 ([e] f4 g8 [a]) d,4 
      d\breve*3/16 c8 [a] c ([d]) d4
      d8 [d] d4 d8 [c] d4 d8 [d] c8 [a] c [d] d4
      d4 e8 [e16 e] f4 (g8 [a]) d,4 c8 [c] d4
      d8 [d] d4. d8 c [d] d4. d8 c8 [a] c ([d]) d4
      \once \override NoteColumn.force-hshift = #-1.2
      d\breve*5/16 e8 [e] f4 (g8 [a]) d,4 c8 [a] c [d] d4
      \once \override NoteColumn.force-hshift = #-1.2
      d\breve*5/16 c8 [a] c ([d]) d4 d8 d [d] c8 [a] c ([d]) d4
      \once \override NoteColumn.force-hshift = #-1.2
      d\breve*1/2 d8 ([e] f4 g8 [a]) d,4 c8 [a] c [d] d4
      d8 [d] d [d] d4 c8 [a] c [d] d4
      d8 d [d] d [d] d ([e] f4 g8 [a] d,4) a8 [c] d4.
      \once \override NoteColumn.force-hshift = #-1.2
      d\breve*1/4 d4 e8 [e] f4 f8 [f] g [g] a4 d,
    }
  }
  \new Lyrics \with {\override VerticalAxisGroup.staff-affinity = #CENTER }
  \lyricsto "sopranos" 
  {
    Gloire à Dieu, au plus haut des cieux_!   
    \gras Et paix sur la terre aux hom -- mes qu’il ai -- me.
    \norm Nous te lou -- ons, nous te bé -- nis -- sons.
    \gras Nous t’ado -- rons, nous te glo -- ri -- fions. 
    \norm Nous te ren -- dons grâ -- ce, pour ton im -- men -- se gloi -- re.
    \gras Sei -- gneur Dieu, Roi du ciel, Dieu le Pè -- re tout_- puis -- sant.
    \norm Sei -- gneur, Fils u -- ni -- que, Jé -- sus Christ.
    \gras Sei -- gneur Dieu, A -- gneau de Dieu, le Fils du Pè -- re.
    \norm Toi qui enlèves les pé -- chés du mon -- de, prends pi -- tié de nous.
    \gras Toi qui enlèves les pé -- chés du mon -- de, re -- çois no -- tre pri -- è -- re.
    \norm Toi qui es assis à la droite du Pè -- re, prends pi -- tié de nous.
    \gras Car toi seul es saint, toi seul es Sei -- gneur.
    \norm Toi seul es le Très_- Haut, Jé -- sus Christ, 
    \gras A -- vec le Saint-Es -- prit, dans la gloi -- re de Dieu le Pè -- re.
    A -- men.
  }
>>