\version "2.24.0"

#(define vowel-set 
   (list->char-set 
    (string->list "AEIOUYÁÀÄÂÉÈÊÍÌÏÎÓÒÖÔÚÙÜÛŒÆØaeiouyáàäâéèëêíìïîóòöôúùüûœæǽ")))

#(define space-set
   (list->char-set 
    (string->list " _—.?-;,:\"'’“”‘’–— */()[]{}|<>!`~&…")))

#(define space
   (list->char-set 
    (string->list " ")))

#(define apostrophe-set
   (list->char-set 
    (string->list "'’")))

#(define (width grob text)
   (let* ((X-extent (ly:stencil-extent (grob-interpret-markup grob text) X)))
     (if (interval-empty? X-extent)
         0 
         (cdr X-extent))))

#(define (retrait grob)
   (let* ((text (ly:grob-property-data grob 'text))
          (texte (markup->string text))
          )
     (/ (width grob texte) 1.62)))

#(define (contient grob text)
   (if (string-contains grob text)
       (if (= 0 (string-contains grob text))
           #t
           #f)
       #f))

#(define (centrer grob)
   (let* ((text (ly:grob-property-data grob 'text))
          (syllabe (markup->string text))
          (lettres-position
           (if (string-skip syllabe space-set)
               (string-skip syllabe space-set)
               0))
          (lettres-end
           (if (string-skip-right syllabe space-set)
               (+ (string-skip-right syllabe space-set) 1)
               (string-length syllabe)))
          (lettres (substring syllabe lettres-position lettres-end))
          (mot-end
           (if  (string-index lettres space)
                (+ 1 (string-index lettres space))
                lettres-end))
          (mot (substring syllabe lettres-position mot-end))
          (lettres-pos lettres-position)
          (lettres-position
           (if (string-index mot apostrophe-set)
               (+ 1 (string-index mot apostrophe-set) lettres-position)
               lettres-position))
          (mot (substring syllabe lettres-position mot-end))
          (ponct (substring syllabe 0 lettres-position))
          (ponct-width (width grob ponct))
          (voyelles-position  
           (if (string-index mot vowel-set)
               (string-index mot vowel-set)
               0))
          (reste (substring mot (+ voyelles-position 1) (string-length mot)))
          (voyelles-end
           (if (string-skip reste vowel-set)
               (+ (+ voyelles-position (string-skip reste vowel-set)) 1)
               (string-length mot)))
          (deux-syll 
           (if (< voyelles-end (string-length mot))
               (if (string-index (substring mot (+ voyelles-end 1) (string-length mot)) vowel-set)
                   1
                   0)
               0))
          (voyelles 
           (if (= deux-syll 1)
               (substring mot voyelles-position voyelles-end)
               mot))
          (voyelles-width (width grob (if (string-null? mot) text voyelles)))
          (pre-voyelles (substring mot 0 voyelles-position))
          (pre-voyelles-width 
           (if (= deux-syll 1)
               (width grob pre-voyelles)
               0))
          (note-column (ly:grob-parent grob X))
          (note-column-extent (ly:grob-extent note-column note-column X))
          (note-column-width (interval-length note-column-extent))
          (self-X (ly:grob-property-data grob 'self-alignment-X))
          )
    
     (-
      (*
       (/ (- note-column-width voyelles-width) 2)
       ;(1+ (ly:grob-property-data grob 'self-alignment-X))
       (if (and (= deux-syll 1) (= voyelles-position 0) (< voyelles-width note-column-width) ) 0 1 )
       )
      (+ ponct-width (- pre-voyelles-width (car note-column-extent)))
      )))


#(define (center-on-vowel grob)              
   (let* ((text (ly:grob-property-data grob 'text))
          (syllable (markup->string text))
          (vowel-position  
           (if (string-index syllable vowel-set)
               (string-index syllable vowel-set)
               0))
          (decal
           (cond
            ((contient syllable "gu") 1)
            ((contient syllable "qu'") 2)
            ((contient syllable "Qu'") 2)
            ((contient syllable "qu") 1)
            ((contient syllable "Qu") 1)
            (else 0)))
          (vowel-position (+ decal vowel-position))
          (prevowel (substring syllable 0 vowel-position))
          (vowel (substring syllable vowel-position (+ 1 vowel-position)))
          (prevowel-width (width grob prevowel))
          (vowel-width (width grob vowel))
          (syllable-width (width grob syllable))
          (note-column (ly:grob-parent grob X))
          (note-column-extent (ly:grob-extent note-column note-column X))
          (note-column-width (interval-length note-column-extent)))
     
     (if (<= (string-length syllable) 3)
         (/ (- note-column-width syllable-width) 2)
         (- (/ (- note-column-width vowel-width) 2)
            prevowel-width)
         )))

\layout { \context { \Lyrics \override LyricText.X-offset = #centrer } }